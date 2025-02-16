using EventHub.GraphQL.DTO;
using EventHub.GraphQL.Repositories.Events;
using HotChocolate.Authorization;
using Microsoft.EntityFrameworkCore;

namespace EventHub.GraphQL.GraphQL.Queries
{
    public class EventQueries
    {
        public IQueryable<Event> GetEvents(EventHub_DbContext dbContext)
        {
            return dbContext.Events;
        }
        public Event GetEvent(EventHub_DbContext dbContext, Guid id)
        {
            return dbContext.Events.First(options => options.Id == id);
        }

        public String admin()
        {
            return "admin";
        }
    }
}
