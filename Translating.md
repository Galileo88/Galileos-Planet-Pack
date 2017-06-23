# Contributing to Galileo's Planet Pack

## Translating to your language

![Languages supported by KSP 1.3: English, Spanish, Chinese, Russian, Japanese](https://i.imgur.com/DbCCJWK.png)

The 1.3 release of KSP introduces localization, which allows in-game text to be translated to other languages. This allows more people to enjoy the game in their preferred language and enlarges the community. However, it does not happen automatically for mods; by default, a mod will appear in English regardless of the language of the base game. In order to have both the base game and mods available in the same non-English languages, some additional work must be done by the modder.

Unfortunately, none of us are completly fluent in any langauge other than English. This means we cannot create our own translations, and we cannot pay a professional translation service to produce high quality translations. The best we can do on our own is to use Google Translate, which is of dubious value for the terse, idiomatic strings needed in a KSP mod. Instead, we must rely on the expertise of you, the multilingual KSP mod user, to tell us what good translations look like for your language. If you would like to help in this effort, please keep reading to learn how the mod's language files are structured and how to submit translations for use by others.

Note: Even though you will appear to be editing the project's files, don't worry about making mistakes. Github will keep your changes separate from the main files until we have verified that they are OK to use. It is even possible for us to ask questions or request changes before your work is committed to the main files.

If you have any problems with any of the steps, feel free to ask in the [GPP thread](http://forum.kerbalspaceprogram.com/index.php?/topic/152136-v123-galileos-planet-pack-official-release-ksp-122/)

### Creating or editing a translation

1. Navigate to the [localization folder](https://github.com/Galileo88/Galileos-Planet-Pack/tree/master/GameData/GPP/GPP_localization)
2. Look for a file called *lang*.cfg, where *lang* is KSP's name for your locale; as of KSP 1.3, this includes:
    - en-us (English)
    - es-es (Spanish)
    - ja (Japanese)
    - ru (Russian)
    - zh-cn (Chinese)
3. Copy and paste the file into a empty text file on your computer

The remaining steps are different depending on whether the file already exists:

####  If the file exists

Follow these steps to make improvements to an existing translation:

4. Edit the file for your language in your favorite text editor
5. Make the changes you wish to see in-game (see the [File format section](#file-format) below for details)
6. Save your changes

#### If the file does not exist

Follow these steps to start your own translation from scratch:

5. Rename the file according to the list of languages above
6. Edit the file for your language in your favorite text editor
7. Change the third line from `en-us` to the string for your language
8. Translate each string from English to your language (see the [File format section](#file-format) below for details)
9. Save your changes

#### File format

The middle part of the `cfg` file contains the strings to translate. The format is `#name = translation`, where the name is a special string defined by the mod. Two examples:

    #LOC_GPP_Planets_Eta_displayName = Eta^N
    #LOC_GPP_Planets_Eta_description = As far as Kerbalkind knows, this is the most petite body around. Her relationship with Thalia is akin to Sleeping Beauty and Maleficent.
    
The first part "#LOC_GPP_Planets_Eta_displayName" or "#LOC_GPP_Planets_Eta_description" should never be changed. The text to the right of the = sign is what should be translated. One thing you should know is that the localizations for planets displayNames need to end with ^N.

### Contributing your translation for others to use

After you have prepared a `cfg` file for your language and confirmed that it works as you intend, if you are willing to contribute it for redistribution under the CC BY-NC-ND  license, follow these steps to upload it for inclusion in the main mod distribution:

1. Log in to [Github](https://github.com); you may need to register an account if you do not already have one
2. Navigate to the [localization folder](https://github.com/Galileo88/Galileos-Planet-Pack/tree/master/GameData/GPP/GPP_localization)
3. Look for the file you edited

The remaining steps are different depending on whether the file already exists:

#### If the file exists

4. Click the file's name to view it
5. Click the [pencil icon](https://help.github.com/assets/images/help/repository/edit-file-edit-button.png) to edit
6. Replace the text with the pasted contents of the file you edited locally
7. Click `Propose file change` at the bottom when done

#### If the file does not exist

4. Click [Create new file](https://help.github.com/assets/images/help/repository/create_new_file.png) to create it
5. Enter the correct file name in the box at the top
6. Paste the contents of the file you edited locally into the big box in the middle
8. Click `Propose new file` at the bottom when done

#### Review

Once you finish your changes, Github will send me a notification that a pull request has been submitted. WE will take a look at it within a day or two and attempt to verify that the changes make sense by:

- Confirming that the file name and the third line of the file match one of the supported locale names
- Viewing each change string in-game
- Checking Google Translate
- Asking individual human experts
- Requesting help on the KSP forum

If we have any questions about specific changes you've made, we will add them to the pull request, which should trigger a notification to you. Please try to respond to these in as timely a manner as you can manage. Your pull request may be closed without merging if you do not reply for a long time.

Once all the questions and comments are resolved to my satisfaction, your changes will be merged into the main files and included in the next release.
