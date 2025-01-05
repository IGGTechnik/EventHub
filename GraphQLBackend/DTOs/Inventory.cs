using graphQLBackend.Models;

namespace graphQLBackend.DTOs
{
    public class Inventory
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
        public Department Department { get; set; }
        public string? Group { get; set; }
        public IEnumerable<Packages>? Packages { get; set; }
        public IEnumerable<Events>? Events { get; set; }
    }
}
