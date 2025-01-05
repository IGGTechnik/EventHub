using graphQLBackend.Models;

namespace graphQLBackend.Schema.Queries
{
    public class InventoryType
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
        public Department Department { get; set; }
        public string? Group { get; set; }
    }
}
