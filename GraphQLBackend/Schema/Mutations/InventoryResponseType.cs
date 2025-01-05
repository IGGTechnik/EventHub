namespace graphQLBackend.Schema.Mutations
{
    public class InventoryResponseType
    {
        public required string Name { get; set; }
        public enum DepartmentEnum
        {
            audio,
            lights,
            video,
            stage,
            house
        }
        public DepartmentEnum Department { get; set; }
        public string? Group { get; set; }
    }
}
