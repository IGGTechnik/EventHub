using Microsoft.EntityFrameworkCore;
using EventHub.GraphQL.DTO;
using System.Data.Common;
using EventHub.GraphQL.GraphQL.Queries;
using EntityGraphQL.AspNet;
using EventHub.GraphQL.GraphQL.Mutations;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using EventHub.GraphQL;
using System.Text.Json;


var builder = WebApplication.CreateBuilder(args);


DbConnectionStringBuilder csb = new DbConnectionStringBuilder();
csb.ConnectionString = builder.Configuration.GetConnectionString("MySQL");
if (string.IsNullOrEmpty(csb.ConnectionString))
{
    throw new Exception("The connection string is invalid. Check in appsettings.json/ConnectionString/MySQL");
}
builder.Services.AddPooledDbContextFactory<EventHub_DbContext>(c => c.UseMySql(csb.ConnectionString, ServerVersion.AutoDetect(csb.ConnectionString)));


builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    var KeycloakAuthority = "http://localhost:8080/realms/eventhub";
    options.Authority = KeycloakAuthority;
    options.Audience = "graphql-api";
    options.RequireHttpsMetadata = false;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidIssuer = KeycloakAuthority,
        ValidateAudience = true,
        ValidAudience = "graphql-api",
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true
    };
    options.Events = new JwtBearerEvents
    {
        OnAuthenticationFailed = context =>
        {
            var logger = context.HttpContext.RequestServices.GetRequiredService<ILogger<Program>>();
            logger.LogError(context.Exception, "Authentication failed.");
            return Task.CompletedTask;
        },
        OnChallenge = context =>
        {
            var logger = context.HttpContext.RequestServices.GetRequiredService<ILogger<Program>>();
            logger.LogWarning("Authentication challenge triggered.");
            return Task.CompletedTask;
        },
        OnForbidden = context =>
        {
            var logger = context.HttpContext.RequestServices.GetRequiredService<ILogger<Program>>();
            logger.LogWarning("Access forbidden.");
            return Task.CompletedTask;
        }
    };
});

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("Admin", policy =>
    {
        policy.RequireAssertion(context =>
        {
            var resourceAccessClaim = context.User.FindFirst("resource_access")?.Value;
            if (string.IsNullOrEmpty(resourceAccessClaim)) return false;

            var resourceAccessJson = JsonDocument.Parse(resourceAccessClaim);
            if (resourceAccessJson.RootElement.TryGetProperty("graphql-api", out var graphqlApi))
            {
                if (graphqlApi.TryGetProperty("roles", out var rolesArray))
                {
                    return rolesArray.EnumerateArray().Any(role => role.GetString() == "admin");
                }
            }
            return false;
        });
    });
});


builder.Services.AddGraphQLServer()
    .RegisterDbContextFactory<EventHub_DbContext>()
    .AddQueryType<EventQueries>()
    .AddAuthorization()
    .AddMutationType<EventMutations>();


var app = builder.Build();

app.UseRouting();


app.UseAuthentication();
app.UseAuthorization();
app.MapGraphQL();

app.Run();
