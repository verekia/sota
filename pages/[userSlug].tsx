import { GetServerSideProps } from 'next'

import { serverGraphqlRequest } from '../graphql-request'

const ProfilePage = ({ user }) => {
  console.log(user)
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.bio}</p>
    </div>
  )
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  const { user: users } = await serverGraphqlRequest(`
  {
    user(where: {username: {_eq: "${context.query.userSlug}"}}) {
      bio
      name
    }
  }
  `)
  console.log(users)
  return { props: { user: users[0] } }
}

export default ProfilePage
