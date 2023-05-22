# Summary

Document what I’ve learned about Terraform and CDK for Terraform for my use-case! This was to update our Faethm infrastructure as part of [ESM-1377: Update infrastructure to support multi-part uploading](https://faethm.atlassian.net/browse/ESM-1377)

# Set Up

The common set up required is to configure the provider. In my case, this required my AWS credentials.

```shell
$ saml2aws login
$ eval $(saml2aws script)
```

The specific `README.md` for Terraform and CDK for Terraform are in their respective sub-folders.