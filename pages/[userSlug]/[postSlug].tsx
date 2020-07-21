import { useRouter } from 'next/router'

const PostPage = () => {
  const router = useRouter()
  const { userSlug, postSlug } = router.query

  return (
    <div>
      Post of @{userSlug} about {postSlug}
    </div>
  )
}

export default PostPage
