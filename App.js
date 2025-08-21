// Facebook SDK Initialization
window.fbAsyncInit = function () {
  FB.init({
    appId: "YOUR_FACEBOOK_APP_ID",
    cookie: true,
    xfbml: true,
    version: "v12.0",
  });

  document
    .getElementById("facebook-login")
    .addEventListener("click", function () {
      FB.login(
        function (response) {
          if (response.status === "connected") {
            alert("Logged in with Facebook!");
          } else {
            alert("Login failed");
          }
        },
        { scope: "public_profile,email" }
      );
    });
};

// Google Sign-In Initialization
function onSignIn(googleUser) {
  var profile = googleUser.getBasicProfile();
  alert("Logged in with Google: " + profile.getName());
}

gapi.load("auth2", function () {
  gapi.auth2
    .init({
      client_id: "YOUR_GOOGLE_CLIENT_ID",
    })
    .then(function () {
      document
        .getElementById("google-login")
        .addEventListener("click", function () {
          gapi.auth2.getAuthInstance().signIn().then(onSignIn);
        });
    });
});

// GitHub OAuth Initialization
const githubOAuth = new GitHubOAuth({
  clientId: "YOUR_GITHUB_CLIENT_ID",
  redirectUri: "YOUR_REDIRECT_URI",
});

document.getElementById("github-login").addEventListener("click", function () {
  githubOAuth
    .login()
    .then((response) => {
      alert("Logged in with GitHub!");
    })
    .catch((error) => {
      console.error(error);
      alert("GitHub login failed");
    });
});
