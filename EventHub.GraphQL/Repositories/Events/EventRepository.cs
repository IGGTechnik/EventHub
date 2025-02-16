using EventHub.GraphQL.DTO;
using Microsoft.EntityFrameworkCore;

namespace EventHub.GraphQL.Repositories.Events
{
    public class EventRepository : IEventRepository
    {
        private EventHub_DbContext _dbContext;
        public EventRepository(EventHub_DbContext dbContext)
        {
            _dbContext = dbContext;
        }
        public IEnumerable<Event> GetEvents()
        {
            return _dbContext.Events;
        }
        public Event? GetEvent(Guid id)
        {
            return _dbContext.Events.FirstOrDefault(e => e.Id == id);
        }
    }
}
