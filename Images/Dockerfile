FROM public.ecr.aws/lambda/python:3.8

ARG VERSION="5.6.0"
ARG CHECKSUM="3363e874688bc02360f92875a2eebe2b90f9af98ed07b8209d105695f73e313a"

# Install dependencies for pulling and verifying source code
RUN yum -y update && \    
        yum -y install tar gzip wget && \
        yum clean all && rm -rf /var/cache/yum && \
        wget https://github.com/terraform-aws-modules/terraform-aws-notify-slack/archive/refs/tags/v${VERSION}.tar.gz && \
        echo "${CHECKSUM}  v${VERSION}.tar.gz" > checksum.txt && \
        sha256sum -c checksum.txt && \
        tar -xf v${VERSION}.tar.gz && \
        rm v${VERSION}.tar.gz && \
        mv terraform-aws-notify-slack-${VERSION}/functions/notify_slack.py ${LAMBDA_TASK_ROOT} && \
        rm -rf terraform-aws-notify-slack-${VERSION} 

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "notify_slack.lambda_handler" ]