Documentation
=============

Installation
------------

Installer le packages "remotes" pour pouvoir récupérer le package RFlaviaAPE

.. code:: console

	# Installer le package "remotes" nécessaire pour installer le package RFlaviaAPE depuis GitHub
	install.packages("remotes")
	library(remotes)
	
	#Puis récupérer le package RFlaviaAPE
	install_github("DonovanMaillard/RFlaviaAPE", force=TRUE, upgrade='always')
	library(RFlaviaAPE)