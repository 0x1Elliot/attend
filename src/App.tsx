import { useEffect, useState } from 'react'
import { supabase } from './lib/supabase'

type EventType = {
  id: string
  name: string
  slug: string
  duration_minutes: number
  description: string | null
  is_active: boolean
  created_at: string
}

function App() {
  const [eventTypes, setEventTypes] = useState<EventType[]>([])
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function loadEventTypes() {
      const { data, error } = await supabase
        .from('event_types')
        .select('*')

      if (error) {
        setError(error.message)
        setLoading(false)
        return
      }

      setEventTypes(data ?? [])
      setLoading(false)
    }

    loadEventTypes()
  }, [])

  if (loading) {
    return <h1>Connecting to Attend database...</h1>
  }

  if (error) {
    return <h1>Database error: {error}</h1>
  }

  return (
    <main>
      <h1>Attend Backend Test</h1>

      {eventTypes.length === 0 ? (
        <p>Connected successfully, but no Event Types are accessible.</p>
      ) : (
        eventTypes.map((eventType) => (
          <div key={eventType.id}>
            <h2>{eventType.name}</h2>
            <p>{eventType.duration_minutes} minutes</p>
            <p>{eventType.description ?? 'No description'}</p>
          </div>
        ))
      )}
    </main>
  )
}

export default App