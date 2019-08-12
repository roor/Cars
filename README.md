Task:

AS a user I would like to get all available cars listed so that I can choose 1 of them.

Info:
	▪	The list of available cars is defined as a JSON Object.
	▪	The list of the available cars’ prices is defined as a JSON Object.

ACs:
	1.	When starting the App, a screen with all available cars should appear.
	2.	This screen contains:
	⁃	a title “List of available cars”,
	⁃	a subtitle “Please select the car you want to buy to get the price”.
	⁃	a segmented control contains 2 tabs “Sort by price” and “Sort by name”.
	⁃	a tableview, where all available cars are listed.
	3.	Each cell should present the following info:
	⁃	On the left side of the cell, an icon of the car (use the icon attached for all cars) .
	⁃	Next to the icon, the car model.
	⁃	Below the car model, the Immatriculation number.
	4.	This list should be scrollable.
	5.	Default sorting of the list is by price.
	6.	When clicking on the one of the segmented control tab, the list should be sorted correspondingly.
	7.	Once a cell is tapped, a spinning wheel appears on the right side of the cell.
	8.	 After 3 seconds, the spinning wheel disappear and  the price of the the selected car should be presented.
	9.	Both portrait and landscape modes should be supported.

