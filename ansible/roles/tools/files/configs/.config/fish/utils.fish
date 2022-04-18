if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

set SMARTSYSTEM_DIR /workspace

function ss-docker-up
	pushd $SMARTSYSTEM_DIR/smartview-dev-docker/common > /dev/null  && docker-compose up -d --force-recreate;
	pushd $SMARTSYSTEM_DIR/smartview-dev-docker/smartview5 > /dev/null && docker-compose up -d --force-recreate;
	pushd $SMARTSYSTEM_DIR/smartview-dev-docker/smartview6 > /dev/null && docker-compose up -d --force-recreate && docker-compose -f docker-compose.ems.yml  up -d --force-recreate;
	popd > /dev/null && popd > /dev/null && popd > /dev/null;
end

function ss-crestart
	pushd $SMARTSYSTEM_DIR/smartview-dev-docker/$1 > /dev/null  && docker-compose up -d --force-recreate $2;
	popd > /dev/null;
end


function ss-crebuild
	pushd $SMARTSYSTEM_DIR/smartview-dev-docker/$1 > /dev/null && docker-compose build $2;
	popd > /dev/null;
end


function ss-active-branches
      pushd $SMARTSYSTEM_DIR > /dev/null;
      for d in ./*
        if test -d "$d/.git"
           pushd $d > /dev/null;
           echo "$d - $(git rev-parse --abbrev-ref HEAD)";
					 popd > /dev/null;
        end
      end
      popd > /dev/null;
end

function ss-update-branches
  pushd $SMARTSYSTEM_DIR > /dev/null;
  for d in ./* 
    if test -d "$d/.git"  
      pushd $d > /dev/null;
      echo "--------------- $d --------------- " && git pull;
      popd > /dev/null;
    end
  end

  wait 2>/dev/null
  for d in ./*
    if test -d "$d/.git"
      cat /tmp/$d
    end
  end
  popd > /dev/null;
end

function docker-ssh
	 set d_cmd $2 bash
	 docker exec -it $1 $d_cmd
end

function aws-mfa
	if test -z $1 
    echo "Please enter your MFA code"
    return 1
  end

	set user $(aws iam get-user \
			--query 'User.Arn' \
			--output text \
		) || return 1

	set profile $(echo $user | cut -f2 -d '/')
	set serial $(echo $user | sed 's/:user/:mfa/')

	set output $(aws sts get-session-token \
			--query 'Credentials.[SecretAccessKey,AccessKeyId,SessionToken]' \
			--output text \
			--serial-number $serial \
			--token-code $1 \
		) || return 1
	set aws_secret_access_key $(echo $output | cut -f1 -d ' ')
	set aws_access_key_id $(echo $output | cut -f2 -d ' ')
	set aws_session_token $(echo $output | cut -f3 -d ' ')

	aws configure set "aws_access_key_id" "$aws_access_key_id" --profile "$profile"
	aws configure set "aws_secret_access_key" "$aws_secret_access_key" --profile "$profile"
	aws configure set "aws_session_token" "$aws_session_token" --profile "$profile"
end
