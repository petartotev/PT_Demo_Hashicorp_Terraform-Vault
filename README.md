# PT_Demo_Hashicorp_Terraform-Vault

## Contents

- [Terraform](#terraform)
  - [Terraform Workflow](#terraform-workflow)
  - [Terraform Demos](#terraform-demos)
    - [Terraform Demo 1 Local In Output](#terraform-demo-1-local-in-output)
    - [Terraform Demo 2 Vars From Cmd Apply](#terraform-demo-2-vars-from-cmd-apply)
    - [Terraform Demo 2 Vars From Env Vars](#terraform-demo-2-vars-from-env-vars)
    - [Terraform Demo 2 Vars From File Auto Tfvars](#terraform-demo-2-vars-from-file-auto-tfvars)
    - [Terraform Demo 2 Vars From File MyFile Tfvars](#terraform-demo-2-vars-from-file-myfile-tfvars)
    - [Terraform Demo 2 Vars From File Terraform Tfvars](#terraform-demo-2-vars-from-file-terraform-tfvars)
    - [Terraform Demo 3 Provisioners Local Exec](#terraform-demo-3-provisioners-local-exec)
    - [Terraform Demo 4 Functions Templatefile](#terraform-demo-4-functions-templatefile)
- [Vault](#vault)
  - [Vault Initial Setup](#vault-initial-setup)
  - [Vault KV Secrets](#vault-kv-secrets)
  - [Vault Database Secrets](#vault-database-secrets)
  - [Vault Cubbyhole Secrets (Optional)](#vault-cubbyhole-secrets-optional)
  - [.NET Web API Application Setup](#net-web-api-application-setup)
- [Links](#links)

## Terraform

### Terraform Workflow

![Terraform Workflow](./res/terraform_workflow.jpg)

### Terraform Demos

#### Terraform Demo 1 Local In Output

Your text here.

#### Terraform Demo 2 Vars From Cmd Apply

Your text here.

#### Demo 2 Vars From Env Vars

Your text here.

#### Terraform Demo 2 Vars From File Auto Tfvars

1. One must create any file with suffix `auto.tfvars` that contains the values for variables (for example `somefile.auto.tfvars`).  
2. `terraform apply` command will find such files, take the values from them and apply those.

#### Terraform Demo 2 Vars From File MyFile Tfvars

1. One must create any file of type `.tfvars` that contains the values for variables (for example `myfile.tfvars`).  
2. `terraform apply -var-file="myfile.tfvars"` command instructs Terraform to take the values from this file and apply those.

#### Terraform Demo 2 Vars From File Terraform Tfvars

1. One must create a file named exactly `terraform.tfvars` - containing the values for variables.  
2. `terraform apply` command takes the values from the `terraform.tfvars` file and apply those.

#### Terraform Demo 3 Provisioners Local Exec

Your text here.

#### Terraform Demo 4 Functions Templatefile

Your text here.

## Vault

Vault has different types of ``Secrets Engines like KV or K/V (version 1 and version 2), Cubbyhole, Database etc.

### Vault Initial Setup

1. Open Power Shell `as Administrator` and execute the following command in order to install Vault:

```
choco install vault
```

2. Test the `Vault` installation by executing the following command:

```
vault
```

Output:
```
Usage: vault <command> [args]

Common commands:
    read        Read data and retrieves secrets
    ...
    unwrap      Unwrap a wrapped secret

Other commands:
    audit                Interact with audit devices
    ...
    version-history      Prints the version history of the target Vault server
```

3. Start the Vault server:

```
vault server -dev
```

Output:
```
...
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variables:

PowerShell:
    $env:VAULT_ADDR="http://127.0.0.1:8200"
cmd.exe:
    set VAULT_ADDR=http://127.0.0.1:8200

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: bzARE123H1123B123+3ZzR2BVRZP/4km6123J1232ww=
Root Token: hvs.Q123H123n123WuVV123E123M

Development mode should NOT be used in production installations!
```

4. Set the `VAULT_ADDR` environment variable:

```
Unix:
export VAULT_ADDR=http://127.0.0.1:8200

PowerShell:
$env:VAULT_ADDR="http://127.0.0.1:8200"

cmd.exe
set VAULT_ADDR=http://127.0.0.1:8200
```

5. Use the `Unseal Key` from the output in step 3 and pass it when you execute the following command to Unseal Vault:

```
vault operator unseal
Unseal Key (will be hidden): enter-unseal-key-from-step-3
```

6. Login using the `Root Token` from the output in step 3:

```
vault login
```

Output:
```
Token (will be hidden): enter-root-token-from-step-3
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                hvs.Q123H123n123WuVV123E123M
token_accessor       mzpRMbULuN6aA46YsS99ip8a
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```

### Vault KV Secrets

[Key-Value (KV) Secrets Engine]((https://developer.hashicorp.com/vault/docs/secrets/kv))

- Purpose: The KV secret engine is a general-purpose engine for storing arbitrary key-value pairs as secrets.
- Usage: It allows you to store and retrieve secrets in a hierarchical key-value structure. Secrets can be organized into paths, making it easy to manage and access different sets of data.
- Example: Storing application configuration, API keys, or any other key-value data.

7. Create a sample `Vault KV Secret`:

```
vault kv put secret/dotnet-demo-api myptsecretkey=myptsecretvalue
```

Output:
```
======= Secret Path =======
secret/data/dotnet-demo-api

======= Metadata =======
Key                Value
---                -----
created_time       2023-12-27T16:33:21.4204449Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            1
```

8. Retrieve the newly created Vault Secret:

```
vault kv get -field=myptsecretkey secret/dotnet-demo-api
```

Output:
```
myptsecretvalue
```

---

You can also use the following command:

```
vault kv get secret/dotnet-demo-api
```

Output:
```
======= Secret Path =======
secret/data/dotnet-demo-api

======= Metadata =======
Key                Value
---                -----
created_time       2023-12-27T19:34:30.8260126Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            7

======== Data ========
Key              Value
---              -----
myptsecretkey    myptsecretvalue
```

⚠️ WARNING: The deprecated path-like syntax can also be used, but this should be avoided for KV v2, as the fact that it is not actually the full API path to the secret (secret/data/foo) can cause confusion!

---

✅ SUCCESS: For KV v2. it is best to use the following command:

```
vault kv get -mount=secret dotnet-demo-api
```

Output:
```
======= Secret Path =======
secret/data/dotnet-demo-api

======= Metadata =======
Key                Value
---                -----
created_time       2023-12-27T19:34:30.8260126Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            7

======== Data ========
Key              Value
---              -----
myptsecretkey    myptsecretvalue
```

### Vault Database Secrets

[Database Secrets Engine](https://developer.hashicorp.com/vault/docs/secrets/databases/postgresql)

0. 💡 You need to follow all steps described in the [PT_Demo_PostgreSQL](https://github.com/petartotev/PT_Demo_PostgreSQL) before storing the Vault database secret (postgres), including:

```
docker run --name postgrescntr -e POSTGRES_PASSWORD=test1234 -p 5432:5432 -d postgres
```

7. Enable the PostgreSQL database secrets engine:

```
vault secrets enable database
```

Output:
```
Success! Enabled the database secrets engine at: database/
```

8. Configure the PostgreSQL connection details:

```
vault write database/config/my-postgresql-database \
  plugin_name=postgresql-database-plugin \
  allowed_roles="my-role" \
  connection_url="postgresql://{{username}}:{{password}}@localhost:5432/mydatabase?sslmode=disable" \
  username="postgres" \
  password="test1234"
```

Output:
```
Success! Data written to: database/config/my-postgresql-database
```

9. Create a role for PostgreSQL
```
vault write database/roles/my-role \
  db_name=my-postgresql-database \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  default_ttl="1h" \
  max_ttl="24h"
```

Output:
```
Success! Data written to: database/roles/my-role
```

### Vault Cubbyhole Secrets (Optional)

[Cubbyhole Secrets Engine](https://developer.hashicorp.com/vault/docs/secrets/cubbyhole)

- Purpose: The Cubbyhole secret engine provides a private storage space, known as a "cubbyhole," for each authenticated token.
- Usage: Each token that interacts with the Cubbyhole engine gets its own isolated storage space. The data stored in a cubbyhole is only accessible by the token that created it, making it a secure place for temporary or sensitive data that is specific to a particular token's session.
- Example: Storing short-lived, session-specific data, such as temporary tokens or small pieces of data meant for short-term use within a specific session.

7. Write secret:

```
vault write cubbyhole/my-secret my-value=s3cr3t
```

Output:
```
Success! Data written to: cubbyhole/my-secret
```

8. Read secret:

```
PS C:\Windows\system32> vault read cubbyhole/my-secret
```

Output:
```
Key         Value
---         -----
my-value    s3cr3t
```

### .NET Web API Application Setup

1. Create a new .NET blank solution `DemoHashicorpVault` and add a new .NET 6 Web API project `DemoHashicorpVault.API`.

2. Install the following NuGet packages:
- dotnet add package `VaultSharp`

3. Implement new `SecretsController.cs` as follows:

```
using Microsoft.AspNetCore.Mvc;
using VaultSharp.V1.AuthMethods.Token;
using VaultSharp.V1.Commons;
using VaultSharp;

namespace DemoHashicorpVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SecretsController : ControllerBase
    {
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var tokenAuthMethodInfo = new TokenAuthMethodInfo("hvs.Q123H123n123WuVV123E123M");

            var vaultClientSettings = new VaultClientSettings("http://127.0.0.1:8200", tokenAuthMethodInfo);

            IVaultClient vaultClient = new VaultClient(vaultClientSettings);

            Secret<SecretData> kv2Secret = await vaultClient.V1.Secrets.KeyValue.V2.ReadSecretAsync(mountPoint: "secret", path: "dotnet-demo-api");

            if (kv2Secret.Data.Data.TryGetValue("myptsecretkey", out object myptsecretvalue))
            {
                return Ok(myptsecretvalue.ToString());
            }

            return NotFound();
        }
    }
}
```

## Commands
### Vault
- Create / Retrieve Vault Secret
  	- ```vault kv put secret/dotnet-demo-api myptsecretkey=myptsecretvalue```
    - ```vault kv get secret/dotnet-demo-api```
    - ```vault kv get -field=myptsecretkey secret/dotnet-demo-api``` ⚠️ WARNING: DEPRECATED!
    
    "the deprecated path-like syntax can also be used, but this should be avoided for KV v2, as the fact that it is not actually the full API path to the secret (secret/data/foo) can cause confusion"
    ```
    ======= Secret Path =======
    secret/data/dotnet-demo-api

    ======= Metadata =======
    Key                Value
    ---                -----
    created_time       2023-12-27T19:34:30.8260126Z
    custom_metadata    <nil>
    deletion_time      n/a
    destroyed          false
    version            7

    ======== Data ========
    Key              Value
    ---              -----
    myptsecretkey    myptsecretvalue
    ```
    - ```vault kv get -mount=secret dotnet-demo-api``` ✅ SUCCESS: Good for KV v2!
    ```
    ======= Secret Path =======
    secret/data/dotnet-demo-api

    ======= Metadata =======
    Key                Value
    ---                -----
    created_time       2023-12-27T19:34:30.8260126Z
    custom_metadata    <nil>
    deletion_time      n/a
    destroyed          false
    version            7

    ======== Data ========
    Key              Value
    ---              -----
    myptsecretkey    myptsecretvalue
    ```
- Others
    - ```vault secrets list```
    ```
    Path          Type         Accessor              Description
    ----          ----         --------              -----------
    cubbyhole/    cubbyhole    cubbyhole_d78b59c9    per-token private secret storage
    identity/     identity     identity_e5338889     identity store
    secret/       kv           kv_78ca757b           key/value secret storage
    sys/          system       system_9d2bb428       system endpoints used for control,     policy and debugging
    ```

    - ```vault read -format=json /sys/mounts/secret/your-mount-path/tune```<br>*
    replace your-mount-path with dotnet-demo-api
    ```
    {
      "request_id": "b83ecce3-1d0c-23d2-0dfb-f21642a7ebd2",
      "lease_id": "",
      "lease_duration": 0,
      "renewable": false,
      "data": {
        "default_lease_ttl": 2764800,
        "description": "key/value secret storage",
        "force_no_cache": false,
        "max_lease_ttl": 2764800,
        "options": {
          "version": "2"
        }
      },
      "warnings": null
    }
    ```
## Links
- https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install
- https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dev-server
- https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-first-secret
- https://developer.hashicorp.com/vault/docs/secrets/kv
- https://developer.hashicorp.com/vault/docs/secrets/cubbyhole
- https://developer.hashicorp.com/vault/tutorials/app-integration/dotnet-httpclient
- https://stackoverflow.com/questions/63878533/vault-error-server-gave-http-response-to-https-client