const express = require('express');
const app = express();
const path = require('path');
const port = 3000;

app.use("/", function(req, res, next) {
	
	var options = {
		root: path.join(__dirname)
	};
	
	var fileName = 'cssTest.html'
	
	res.sendFile(fileName, options, function(err) {
		if (err) {
			next(err)
		} else {
			console.log('Sent:', fileName);
		}
	});
});

app.get('/', function(req, res){
    console.log("File Sent")
    res.send();
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})