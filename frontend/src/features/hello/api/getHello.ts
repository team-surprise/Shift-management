export async function getHello(): Promise<string> {
  const res = await fetch(`${import.meta.env.VITE_API_BASE_URL}/api/v1/hello`)
  const data = await res.json()
  return data.message
}
