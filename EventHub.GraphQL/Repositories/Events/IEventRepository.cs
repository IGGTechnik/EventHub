using EventHub.GraphQL.DTO;

namespace EventHub.GraphQL.Repositories.Events
{
    public interface IEventRepository
    {
        public IEnumerable<DTO.Event> GetEvents();
        public Event? GetEvent(Guid id);
    }
}
