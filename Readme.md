The main object of this XcodeProject is read the JSON from the School detatils and School SAT url and convert that JSON in couple of School model objects
1. SchoolDetails: This holds the ID, Name & rest of School Model objects
2. Address: This holds the physical contact of give School including location coordinates
3. SchoolSchd: This model class represents the school start and end timing and grades
4. SchoolMetrics: This model class represents graduation rates, demographic rates etc
5. SchoolGradeRequirements: This is model class for minimun graduation requirements
6. SchoolSATScores: Class to hold the SAT scores for given school at one given point of time

Networking:
API: represents the URLSession networking class to the both the URL and parse the json and converts into model object

UI:
ViewController: Represents the main VC which is a collectionViewController and each cell is presentation by
SchoolInfoCollectionViewCell: Represents basic information like Name, school metrics and Thumbnail of the map, when you tap
1. The map it launches out the location of the school out to Maps app
2. On the cell navigates to SAT Scoring UI

3. The searchbar on the CollectionViewController helps to quickly shot list the school name.

XCTest:
Two test case to test the JSON which reads from the local file and call the JSON parser and checks of correct school model objects has being generated correctly or not.

@ToDo: Convert the Add into appropiate school Address object which represents the generic style of address
@ToDo: Would like to do some Analytics on the School data like 
1. Where does each school ranks based on the Average SAT schools
2. Which schools faired top (3) based on SAT scores
3. Would like to give segement quick assess to filter on sports, grade requirements etc.,
4. Add Alphabetical order menu
