#!/usr/bin/env sh

packer build "-only=ubuntu-24_04.*" \
"-var=tenant_id=fake" \
"-var=tenant_id=fake" \
"-var=azure_tags={}" \
"-var=allowed_inbound_ip_addresses=[]" \
"-var=client_secret=123" \
"-var=subscription_id=FakeSubscriptionId" \
"-var=oidc_request_url=fake" \
"-var=install_password=FakeInstallPassword" \
"-var=client_id=fake" \
"-var=oidc_request_token=fake" \
"-var=location=FakeAzureLocation" \
"-var=managed_image_resource_group_name=FakeResourceGroupName" \
"-var=image_os=ubuntu24" \
"-var=managed_image_name=fake" \
./images/ubuntu/templates
