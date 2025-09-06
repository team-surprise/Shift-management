import { useEffect, useState } from 'react'
import { getHello } from '../api/getHello'

export default function HelloMessage() {
  const [message, setMessage] = useState('')

  useEffect(() => {
    getHello().then(setMessage).catch(console.error)
  }, [])

  return <h1>{message}</h1>
}
