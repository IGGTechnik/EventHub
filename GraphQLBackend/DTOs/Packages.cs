namespace graphQLBackend.DTOs
{
    public class Packages
    {
        public Guid Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public IEnumerable<Inventory>? Inventory { get; set; }
        public IEnumerable<Events>? Events { get; set; }

    }
}
