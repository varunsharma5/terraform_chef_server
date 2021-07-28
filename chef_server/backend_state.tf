terraform{
  backend "s3" {
  	bucket = "peer.review.01-varun-sharma-bucket"
  	key = "peer.review.01-instnce-state"
  	region = "ap-south-1"
  }
}
