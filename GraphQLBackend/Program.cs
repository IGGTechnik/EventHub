using graphQLBackend.Schema.Mutations;
using graphQLBackend.Schema.Queries;
using graphQLBackend.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddGraphQLServer()
                .AddQueryType<Query>()
                .AddMutationType<Mutation>();

var connectionString = builder.Configuration.GetConnectionString("EventHubDb");
if (string.IsNullOrEmpty(connectionString))
{
    throw new InvalidOperationException("Connection string is missing");
}
builder.Services.AddPooledDbContextFactory<EventHubDbContext>(options => options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

var app = builder.Build();

using (IServiceScope scope = app.Services.CreateScope())
{
    using (EventHubDbContext dbContext = scope.ServiceProvider.GetRequiredService<IDbContextFactory<EventHubDbContext>>().CreateDbContext())
    {
        dbContext.Database.Migrate();
    }
}

app.UseWebSockets();
app.MapGraphQL();
app.Run();
