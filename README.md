# tf-azurerm-module_primitive-virtual_network_subnet

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module creates a subnet in an Azure Virtual. It is designed to be used as a primitive in a collection or reference architecture module.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.106.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the Redis cache. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The size of the Redis cache | `number` | `1` | no |
| <a name="input_family"></a> [family](#input\_family) | The SKU family/pricing group to use | `string` | `"C"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The type of SKU to use | `string` | `"Basic"` | no |
| <a name="input_enable_non_ssl_port"></a> [enable\_non\_ssl\_port](#input\_enable\_non\_ssl\_port) | Enable the non-SSL port (6379) | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned. | `list(string)` | `null` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version. Defaults to 1.2 | `string` | `"1.2"` | no |
| <a name="input_patch_schedule"></a> [patch\_schedule](#input\_patch\_schedule) | Window of time when the Redis cache can be patched | <pre>list(object({<br>    day_of_week        = string<br>    start_hour_utc     = optional(string)<br>    maintenance_window = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_private_static_ip_address"></a> [private\_static\_ip\_address](#input\_private\_static\_ip\_address) | The private IP address to use when `subnet_id` is set | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public network access to the redis cache | `bool` | `true` | no |
| <a name="input_redis_configuration"></a> [redis\_configuration](#input\_redis\_configuration) | Additional options for the Redis cache | <pre>object({<br>    aof_backup_enabled                      = optional(bool)<br>    aof_storage_connection_string_0         = optional(string)<br>    aof_storage_connection_string_1         = optional(string)<br>    enable_authentication                   = optional(bool)<br>    active_directory_authentication_enabled = optional(bool)<br>    maxmemory_reserved                      = optional(number)<br>    maxmemory_delta                         = optional(number)<br>    maxmemory_policy                        = optional(string)<br>    data_persistence_authentication_method  = optional(string)<br>    maxfragmentationmemory_reserved         = optional(number)<br>    rdb_backup_enabled                      = optional(bool)<br>    rdb_backup_frequency                    = optional(number)<br>    rdb_backup_max_snapshot_count           = optional(number)<br>    rdb_storage_connection_string           = optional(string)<br>    storage_account_subscription_id         = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Major version of redis to use. Defaults to 6 | `string` | `"6"` | no |
| <a name="input_replicas_per_master"></a> [replicas\_per\_master](#input\_replicas\_per\_master) | Number of replicas to create per master | `number` | `null` | no |
| <a name="input_replicas_per_primary"></a> [replicas\_per\_primary](#input\_replicas\_per\_primary) | Number of replicas to create per primary | `number` | `null` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards to create on the cluster | `number` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet where the Redis cache should be deployed | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the Redis cache | `map(string)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of availability zones where the Redis cache should be located | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redis_cache_id"></a> [redis\_cache\_id](#output\_redis\_cache\_id) | n/a |
| <a name="output_redis_cache_hostname"></a> [redis\_cache\_hostname](#output\_redis\_cache\_hostname) | n/a |
| <a name="output_redis_cache_primary_access_key"></a> [redis\_cache\_primary\_access\_key](#output\_redis\_cache\_primary\_access\_key) | n/a |
| <a name="output_redis_cache_secondary_access_key"></a> [redis\_cache\_secondary\_access\_key](#output\_redis\_cache\_secondary\_access\_key) | n/a |
| <a name="output_redis_cache_primary_connection_string"></a> [redis\_cache\_primary\_connection\_string](#output\_redis\_cache\_primary\_connection\_string) | n/a |
| <a name="output_redis_cache_secondary_connection_string"></a> [redis\_cache\_secondary\_connection\_string](#output\_redis\_cache\_secondary\_connection\_string) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
