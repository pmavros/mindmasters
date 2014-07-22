mindmasters
===========

This is a project for an interactive media installation using the Emotiv EPOC devices.

Requirements

The sketches work standalone. You don't have to be connected to Emotiv to run.

1. An Emotiv EPOC or EEG
1. An installation
1. A Mac/Windows version of MindYourOSCs: https://emotiv.com/store/apps/applications/119/1446

To run

1. Start EmotivControlPanel
1. Create/set profile
1. Start + connect with MindYourOSCs
1. Start processing

The MindMastersMain has to global arrays, which are updating on the background with the Affectiv suite values (excitement, frustration, engagement, meditation - in that SPECIFIC order)
 
Team A
⁃	Float statesValuesA [] = {0.0,0.0,0.0,0.0};
Team B
⁃	Float statesValuesB [] = {0.0,0.0,0.0,0.0};

The sketch architecture allows you to update the arrays with dummy variables if not connected to emotiv, but that's not implemented yet.