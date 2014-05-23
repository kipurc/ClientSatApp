/*
 * Copyright 2014 IBM Corp. All Rights Reserved
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Load the Node modules required
// Express handles the HTTP URI requests
var express = require('express');
var namespace = require('express-namespace');

// Require the Mobile Cloud SDK for Core and Data Node Config
var IBMBaaS = require('ibmbaas');
var IBMData = require('ibmdata');
var IBMConfig = require('ibmconfig');

// Load the config.json file that is used to hold the App Id
var app = require("./public/bluelist.json");

// initialize the SDK with the Application Id
IBMBaaS.initializeSDK(app.applicationId);

// initialise the Config (MB. This will be changing)
IBMConfig.initializeSDK(app.applicationId);

// initialize the Data SDK 
var data = IBMData.initializeService();

// Create an express app and map routing
var app = express();
app.use(express.bodyParser());
app.use(app.router);

//get context root to deploy your application
//the context root is '${appHostName}/v1/apps/${applicationId}'
var mbaasContextRoot = IBMConfig.mbaasContextRoot;

// log all requests
app.all('*', function(req, res, next) {
    console.log("Received request to " + req.url);
    next();
});

// Create resource URIs for the mbaas Context Route
app.namespace(mbaasContextRoot, function() {

    // Define the main GET method for retreiving a full list of items
    app.get('/items', function(req, res) {

        // Retreive a Query instance of type "Item" and issue a find() action on it 
        // to retreive all the items (NO PAGING)
        var query = data.Query.ofType("Item");
        query.find().done(function(items) {
            res.send(items);
        },function(err){
            res.status(500);
            res.send(err);
        });
    });

    // Retrieve a single Item using an id
    app.get('/item/:id', function(req, res) {

        // Using the Data SDK create a query and pass in a search parameter
        var query = data.Query.ofType("Item");
        query.find({
            id: req.params.id
        }, {
            limit: 1
        }).done(function(item) {
            if (item.length == 1) {
                res.send(item);
            } else {
                res.status(404);
                res.send("No such item found");
            }
        });
    });

    // Create a new Item using the payload passed 
    app.post('/item', function(req, res) {

        // Create a new Item instance and then save it to the cloud
        var item = data.Object.ofType("Item", req.body);
        item.save().then(function(saved) {
            res.send(saved);
        },function(err) {
            res.status(500);
            res.send(err);
        });

    });

    // Update an existing Item
    app.put('/item/:id', function(req, res) {

        // Find the Item
        var find = data.Object.ofType("Item");

        // FIX: Use new API when released
        // Set the ObjectID in the internal meta data field
        find._meta.objectId = req.params.id;

        // Read the object
        find.read().done(function(item) {

            // Update the Contents of the Object
            item.set(req.body);

            // Save the updated items
            item.save().then(function(saved) {
                res.send(saved);
            },function(err){
                res.status(500);
                res.send(err);
            });


        }, function(err) {
            res.status(500);
            console.log(err);
        });        

    });

    // Delete the Item using a unique id
    app.del('/item/:id', function(req, res) {

        // Find the Item
        var find = data.Object.ofType("Item");

        // FIX: Use new API when released
        // Set the ObjectID in the internal meta data field
        find._meta.objectId = req.params.id;

        // Read the object
        find.read().done(function(item) {

            // Delete the Item from the Cloud 
            item.del().done(function(deleted) {
                // Validated it was deleted
                var isDeleted = deleted.isDeleted();
                if (deleted.isDeleted()) {
                    res.send("delete successfull.");
                } else {
                    res.status(500);
                    res.send("delete failed.");
                }
            });

        }, function(err) {
            res.status(500);
            console.log(err);
        });
    });

});


// host static files in public folder
console.log(mbaasContextRoot + '/public');

app.use('/public', express.static('public'));

// redirect to cloudcode doc page when accessing the root context
app.get('/', function(req, res) {
    res.redirect('/public/index.html');
});

app.listen(IBMConfig.port);
console.log('Server started at port: ' + IBMConfig.port);
