import { GetStaticProps } from 'next'

import { staticGraphqlRequest } from '../graphql-request'

const HomePage = ({ sponsors }) => {
  return (
    <div>
      Welcome to Next.js!
      <div>
        <img src="/img/html5.png" />
      </div>
      <div>
        Sponsored by:
        <ul>
          {sponsors.map((s) => (
            <li key={s.id}>{s.name}</li>
          ))}
        </ul>
        (fetched from the API at build time)
      </div>
    </div>
  )
}

export const getStaticProps: GetStaticProps = async () => {
  const { sponsor: sponsors } = await staticGraphqlRequest('{ sponsor { id name } }')
  return { props: { sponsors } }
}

export default HomePage
