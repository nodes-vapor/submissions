import Vapor
import Submissions

struct UpdatePostRequest: Content, UpdateRequest {
    static func find(on request: Request) -> EventLoopFuture<Post> {
        // Here we return a new, empty post
        //
        // Real world implementations could include:
        // - loading a model from the database
        // - getting the model from the authentication cache (updating logged-in user)
        request.eventLoop.future(Post(title: ""))
    }

    let title: String?

    static func validations(
        for _: Post,
        on request: Request
    ) -> EventLoopFuture<Validations> {
        var validations = Validations()
        if request.url.query == "fail" {
            validations.add("validation", result: ValidatorResults.TestFailure())
        }
        return request.eventLoop.future(validations)
    }

    func update(_ post: Post, on request: Request) -> EventLoopFuture<Post> {
        if let title = title {
            post.title = title
        }
        return request.eventLoop.future(post)
    }
}
