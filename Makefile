all: check_env sam_version build deploy

check_env:
ifndef PROFILE
	$(eval PROFILE := $(shell bash -c 'read -e -p "AWS_PROFILE: " var; echo $$var'))
endif

sam_version:
	@sam --version

build:
	@sam build

deploy:
	@sam deploy \
	  --profile $(PROFILE)

package:
	@sam package --output-template-file packaged.yaml --s3-bucket ${ARTIFACT_STORE_BUCKET} --s3-prefix "sam"
