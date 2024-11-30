// Your API Gateway URL (replace this with your actual API Gateway endpoint)
const apiUrl = 'https://cfyago03kh.execute-api.us-east-1.amazonaws.com/production'; 
const counter = document.querySelector(".counter-number");
// Function to fetch visitor count from the API and update the HTML
async function updateVisitorCount() {
    let response = await fetch(apiUrl);
    let data = await response.json()
    visitCount = data.visitor_count;
    counter.innerHTML = `Views: ${visitCount}`;
}

// Call the function to update the visitor count
updateVisitorCount();
