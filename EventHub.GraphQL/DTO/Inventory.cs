using EventHub.GraphQL.Models;

namespace EventHub.GraphQL.DTO
{
    public class Inventory
    {
        public Guid? Id { get; set; }
        public string? Name { get; set; }
        public Department? Department { get; set; }
        public string? Group { get; set; }
        public IEnumerable<Event>? Events { get; set; }
        public IEnumerable<Package>? Packages { get; set; }
    }
}
