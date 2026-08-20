gcloud auth list

gcloud auth application-default login

gcloud run services add-iam-policy-binding gcp-cloud-run \
    --member="allUsers" \
    --role="roles/run.invoker" \
    --region=us-central1
