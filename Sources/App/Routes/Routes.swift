import Vapor

extension Droplet {
  func setupRoutes() throws {
    get("hello") { req in
      var json = JSON()
      try json.set("hello", "world")
      return json
    }

    get("apod") { req in
      let res = try self.client.get("https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")
      return try JSON(node: [
        "text": "NASA Pic of the Day",
        "attachments": [
          "image_url": res.data["url"],
          "title": res.data["title"]
        ]
      ])
    }

    try resource("posts", PostController.self)
  }
}
