using EventHub.GraphQL.DTO;
using HotChocolate.Authorization;

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

        public String ConnectionTest()
        {
            return "Connection succeded!";
        }

        [Authorize]
        public String AuthConnectionTest()
        {
            return "Authenticated connection succeeded!";
        }
    }
}
