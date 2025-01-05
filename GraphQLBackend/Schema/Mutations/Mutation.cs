using graphQLBackend.Schema.Queries;

namespace graphQLBackend.Schema.Mutations
{
    public class Mutation
    {
        private readonly List<EventsType> _events;

        public Mutation() 
        {
            _events = [];
        }
    
        public EventsType CreateEvent(EventsResponseType input)
        {
            EventsType newEvent = new()
            {
                Id = Guid.NewGuid(),
                Title = input.Title,
                Start = DateTime.Parse(input.Start),
                End = DateTime.Parse(input.End).TimeOfDay,
                SeatingTime = DateTime.Parse(input.SeatingTime).TimeOfDay,
                KioskPossible = input.KioskPossible,
                Pax = input.Pax,
            };

            _events.Add(newEvent);

            return newEvent;
        }
        
        public EventsType UpdateEvent(Guid id, EventsType input)
        {
            EventsType eventToUpdate = _events.FirstOrDefault(e => e.Id == id) ?? throw new GraphQLException(new Error("Event not found.", "EVENT_NOT_FOUND"));
            eventToUpdate.Title = input.Title;
            return eventToUpdate;
        }

        public bool DeleteEvent(Guid id)
        {
            return _events.RemoveAll(e => e.Id == id) >= 1;
        }
    }
}
