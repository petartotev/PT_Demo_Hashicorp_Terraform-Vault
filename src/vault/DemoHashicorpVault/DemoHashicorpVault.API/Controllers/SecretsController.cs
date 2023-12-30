using Microsoft.AspNetCore.Mvc;
using VaultSharp.V1.AuthMethods.Token;
using VaultSharp.V1.Commons;
using VaultSharp;
using Microsoft.Extensions.Configuration;

namespace DemoHashicorpVault.API.Controllers;

[ApiController]
[Route("[controller]")]
public class SecretsController : ControllerBase
{
    [HttpGet]
    [Route("kv/byclient")]
    public async Task<IActionResult> Get()
    {
        // Initialize one of the several auth methods.
        var tokenAuthMethodInfo = new TokenAuthMethodInfo("hvs.DhmJu2E6X38M1praaApLuH6q");

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
}