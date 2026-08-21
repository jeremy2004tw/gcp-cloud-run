#! /usr/bin/bash

# gcloud auth login
# gcloud auth application-default login

export PROJECT_ID=$(gcloud config get-value project)
# export PROJECT_ID="terraform-demo-504200"
# gcloud config set project "$PROJECT_ID"
echo "$PROJECT_ID"

export REGION="us-central1"
# gcloud config set run/region "$REGION"
echo "$REGION"

export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
echo "$PROJECT_NUMBER"

# Enable the Artifact Registry, Cloud Build, and Cloud Run APIs
gcloud services enable \
  artifactregistry.googleapis.com \
  cloudbuild.googleapis.com \
  run.googleapis.com

# Create a service account named gcp-cloud-run-sa
gcloud iam service-accounts create gcp-cloud-run-sa

gcloud projects add-iam-policy-binding $PROJECT_ID \
	--member=user:$(gcloud config get-value account) \
	--role='roles/run.invoker'

gcloud run services add-iam-policy-binding gcp-cloud-run2 \
    --member="allUsers" \
    --role="roles/run.invoker" \
    --region=$REGION

# Deploy the application to Cloud Run
gcloud run deploy gcp-cloud-run2 \
	--service-account=gcp-cloud-run-sa@$PROJECT_ID.iam.gserviceaccount.com \
	--no-allow-unauthenticated \
  --region=$REGION \
  --source .

# Get the service URL
# SERVICE_URL=$( \
#   gcloud run services describe gcp-cloud-run2 \
#   --platform managed \
#   --region $REGION \
#   --format "value(status.url)" \
# )
export SERVICE_URL=https://gcp-cloud-run2-79495184008.us-central1.run.app
echo $SERVICE_URL

# Call the application
curl $SERVICE_URL?who=me

# Delete your container image repository
# gcloud artifacts repositories delete cloud-run-source-deploy \
#   --location $REGION

# Delete your Cloud Run service
# gcloud run services delete helloworld-python \
#   --platform managed \
#   --region $REGION

# Delete the project
# gcloud projects delete $PROJECT_ID
