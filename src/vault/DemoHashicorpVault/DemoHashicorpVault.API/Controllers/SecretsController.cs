using Microsoft.AspNetCore.Mvc;
using VaultSharp.V1.AuthMethods.Token;
using VaultSharp.V1.Commons;
using VaultSharp;
using VaultSharp.V1.SecretsEngines;

namespace DemoHashicorpVault.API.Controllers;

[ApiController]
[Route("[controller]")]
public class SecretsController : ControllerBase
{
    private readonly string _rootToken = "hvs.Q123H123n123WuVV123E123M";

    [HttpGet]
    [Route("kv/byclient")]
    public async Task<IActionResult> GetKeyValueSecretByClient()
    {
        // Initialize one of the several auth methods.
        var tokenAuthMethodInfo = new TokenAuthMethodInfo(_rootToken);

        // Initialize settings. You can also set proxies, custom delegates etc. here.
        var vaultClientSettings = new VaultClientSettings("http://127.0.0.1:8200", tokenAuthMethodInfo);

        IVaultClient vaultClient = new VaultClient(vaultClientSettings);

        // Use client to read a key-value secret.
        Secret<SecretData> kv2Secret = await vaultClient.V1.Secrets.KeyValue.V2.ReadSecretAsync(mountPoint: "secret", path: "dotnet-demo-api");

        if (kv2Secret.Data.Data.TryGetValue("myptsecretkey", out object myptsecretvalue))
        {
            return Ok(myptsecretvalue.ToString());
        }

        return NotFound();
    }

    [HttpGet]
    [Route("database/byclient")]
    public async Task<IActionResult> GetDatabaseSecretByClient()
    {
        // Initialize one of the several auth methods.
        var tokenAuthMethodInfo = new TokenAuthMethodInfo(_rootToken);

        // Initialize settings. You can also set proxies, custom delegates etc. here.
        var vaultClientSettings = new VaultClientSettings("http://127.0.0.1:8200", tokenAuthMethodInfo);

        IVaultClient vaultClient = new VaultClient(vaultClientSettings);

        // Read dynamic database credentials from Vault
        Secret<UsernamePasswordCredentials> databaseCredentials = await vaultClient.V1.Secrets.Database.GetCredentialsAsync("my-role");

        // Use the dynamically generated username and password in your .NET application
        var connectionString = $"Host=localhost;Port=5432;Database=mydatabase;Username={databaseCredentials.Data.Username};Password={databaseCredentials.Data.Password};Pooling=true;";

        return Ok(connectionString);
    }
}