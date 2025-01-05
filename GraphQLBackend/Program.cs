using graphQLBackend.Schema.Mutations;
using graphQLBackend.Schema.Queries;
using graphQLBackend.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.AddGraphQL()
       .AddQueryType<Query>()
       .AddMutationType<Mutation>();


var connectionString = builder.Configuration.GetConnectionString("EventHubDb");

if (string.IsNullOrEmpty(connectionString))
{
    throw new InvalidOperationException("Connection string is missing");
}

builder.Services.AddPooledDbContextFactory<EventHubDbContext>(options => options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));



var app = builder.Build();

EventHubDbContext dbContext = await app.Services.CreateScope().ServiceProvider.GetRequiredService<IDbContextFactory<EventHubDbContext>>().CreateDbContextAsync();
dbContext.Database.Migrate();

app.UseWebSockets();

app.MapGraphQL();

app.Run();
