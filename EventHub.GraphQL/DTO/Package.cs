using Microsoft.JSInterop.Infrastructure;

namespace EventHub.GraphQL.DTO
{
    public class Package
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public IEnumerable<Inventory> Inventory { get; set; }
        public IEnumerable<Event> Events { get; set; }
    }
}
