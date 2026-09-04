#!/bin/bash

set -e

AWS_ACCOUNT_ID="157263244729"
AWS_REGION="us-east-2"
REPOSITORY="shopsphere"

ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY}"

SERVICES=(
frontend
adservice
cartservice
checkoutservice
currencyservice
emailservice
paymentservice
productcatalogservice
recommendationservice
shippingservice
)

echo "======================================="
echo " Amazon ECR Image Push Started"
echo "======================================="

for SERVICE in "${SERVICES[@]}"
do
    LOCAL_IMAGE="shopsphere/${SERVICE}:v1"
    REMOTE_IMAGE="${ECR_URI}:${SERVICE}-v1"

    echo ""
    echo "---------------------------------------"
    echo "Processing : ${SERVICE}"
    echo "---------------------------------------"

    if ! docker image inspect "${LOCAL_IMAGE}" > /dev/null 2>&1; then
        echo "Image not found : ${LOCAL_IMAGE}"
        continue
    fi

    echo "Tagging image..."
    docker tag "${LOCAL_IMAGE}" "${REMOTE_IMAGE}"

    echo "Pushing image..."
    docker push "${REMOTE_IMAGE}"

    echo "Completed : ${SERVICE}"
done

echo ""
echo "======================================="
echo " All Images Uploaded Successfully"
echo "======================================="
