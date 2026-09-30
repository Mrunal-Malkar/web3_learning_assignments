import { useConnect, useConnection, useConnectors } from 'wagmi'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { WagmiProvider } from 'wagmi'
import { config } from '../config'

const queryClient = new QueryClient()

export default function App() {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <WalletOptions/>       
      </QueryClientProvider>
    </WagmiProvider>
  )
}


export function WalletOptions() {
  const { connect } = useConnect()
  const connectors = useConnectors()
  const {address} =useConnection();

  if(address){
    return <div>You are connected to ${address}</div>
  }
  return connectors.map((connector) => (
    <button key={connector.uid} onClick={() => connect({ connector })}>
      {connector.name}
    </button>
  ))
}