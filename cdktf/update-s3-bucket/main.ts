import { Construct } from "constructs";
import { App, TerraformStack, CloudBackend, NamedCloudWorkspace } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { DataAwsS3Bucket } from "@cdktf/provider-aws/lib/data-aws-s3-bucket";
import { S3BucketLifecycleConfiguration } from "@cdktf/provider-aws/lib/s3-bucket-lifecycle-configuration";
import { S3BucketCorsConfiguration } from "@cdktf/provider-aws/lib/s3-bucket-cors-configuration";
import { REGIONS, BUCKET_NAME, AWS_REGION } from "../utils";

class UpdateS3Bucket extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: AWS_REGION,
      accessKey: process.env.AWS_ACCESS_KEY_ID,
      secretKey: process.env.AWS_SECRET_ACCESS_KEY,
      token: process.env.AWS_SESSION_TOKEN,
    });

    for (const region of REGIONS) {
      const bucket = new DataAwsS3Bucket(this, `data_${region}_bucket`, {
        bucket: `${region}.${BUCKET_NAME}`,
      });

      new S3BucketLifecycleConfiguration(bucket, "lifecycle_config", {
        bucket: bucket.bucket,
        rule: [
          {
            id: "abort-incomplete-multipart-upload",
            abortIncompleteMultipartUpload: {
              daysAfterInitiation: 7,
            },
            status: "Enabled",
          },
        ],
      });

      new S3BucketCorsConfiguration(bucket, "cors_config", {
        bucket: bucket.bucket,
        corsRule: [
          {
            allowedHeaders: ["*"],
            allowedMethods: ["PUT"],
            allowedOrigins: ["*"],
            exposeHeaders: ["ETag", "x-amz-checksum-sha256"],
          },
        ],
      });
    }
  }
}

const app = new App();
const stack = new UpdateS3Bucket(app, "update-s3-bucket");
new CloudBackend(stack, {
  hostname: "app.terraform.io",
  organization: "lance-learning",
  workspaces: new NamedCloudWorkspace("update-s3-bucket"),
});
app.synth();
