import { Construct } from "constructs";
import { App, TerraformStack, CloudBackend, NamedCloudWorkspace } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";
import { REGIONS, BUCKET_NAME, AWS_REGION } from "../utils";

class CreateS3Bucket extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: AWS_REGION,
      accessKey: process.env.AWS_ACCESS_KEY_ID,
      secretKey: process.env.AWS_SECRET_ACCESS_KEY,
      token: process.env.AWS_SESSION_TOKEN,
    });

    for (const region of REGIONS) {
      new S3Bucket(this, `${region}_bucket`, {
        bucket: `${region}.${BUCKET_NAME}`,
        forceDestroy: true,
      });
    }
  }
}

const app = new App();
const stack = new CreateS3Bucket(app, "create-s3-bucket");
new CloudBackend(stack, {
  hostname: "app.terraform.io",
  organization: "lance-learning",
  workspaces: new NamedCloudWorkspace("create-s3-bucket"),
});
app.synth();
