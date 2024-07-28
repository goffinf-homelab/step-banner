# step-banner

## Overview

This action is used to add a console log output a banner to indicate the subsequent step within a composite action.


## Requirements & Limitations

* Linux and Windows runners supported.

## Purpose

A composite action does NOT provide any separation of each of the declared steps and this can make it more difficult to understand the behaviour of the action, particulalrly when debugging.

For example, here is console output for a simple set of steps within a composite action where NO BANNER steps are included. Its hard to reason what is going on even when this simple:

```
	Run echo "excluded_codeql_languages = "
	excluded_codeql_languages = 
	Run EXCLUDE_CODEQL_LANGUAGES_IN=
	EXCLUDE_CODEQL_LANGUAGES_IN = 
	EXCLUDE_CODEQL_LANGUAGES_OUT = 
	EXCLUDE_CODEQL_LANGUAGES_OUT_DQ = ""
	Run echo "EXCLUDE_CODEQL_LANGUAGES_IN = []"
	EXCLUDE_CODEQL_LANGUAGES_IN = []
	Run codeql_languages=$(gh api "repos/${GITHUB_REPOSITORY}/languages" -q '[{"C":"cpp", "C++":"cpp", "C#":"csharp", "Go":"go", "Java":"java", "Kotlin":"java","JavaScript":"javascript", "TypeScript":"javascript", "Python":"python", "Ruby":"ruby"}[keys[]]] | unique -[null] -[]')
	Run echo "Languages to be scanned: ["java"]"
	Languages to be scanned: [java]
```

Here is the same example but with a banner between the steps

Note that the length of the outer banner is set to ONE character more than the length of the longest inner text.

Console output:

```
	#####################
	## Show input values
	#####################

	Run echo "excluded_codeql_languages = "
	excluded_codeql_languages = 

	#############################################
	## Prepare a JSON array of exclude languages
	#############################################

	Run EXCLUDE_CODEQL_LANGUAGES_IN=
	EXCLUDE_CODEQL_LANGUAGES_IN = 
	EXCLUDE_CODEQL_LANGUAGES_OUT = 
	EXCLUDE_CODEQL_LANGUAGES_OUT_DQ = ""
	Run echo "EXCLUDE_CODEQL_LANGUAGES_IN = []"
	EXCLUDE_CODEQL_LANGUAGES_IN = []

	#################################################
	## Detect scanning languages and remove excluded
	#################################################

	Run codeql_languages=$(gh api "repos/${GITHUB_REPOSITORY}/languages" -q '[{"C":"cpp", "C++":"cpp", "C#":"csharp", "Go":"go", "Java":"java", "Kotlin":"java","JavaScript":"javascript", "TypeScript":"javascript", "Python":"python", "Ruby":"ruby"}[keys[]]] | unique -[null] -[]')
	Run echo "Languages to be scanned: ["java"]"
	Languages to be scanned: [java]
```

## How to Use

Can be called from any workflow within any repository.

It does NOT require a GitHub authentication token or any GitHub contexts.

### Example - Simple Single Text Output

The composite action supports a MAXIMUM of 6 lines of text to be added into the banner

```
	- name: fetch_af_token_banner
	  uses: goffinf-homelab/step-banner@v1.0.0
	  with:
		banner_text: "Fetch secret value from Vault"
```

Would output:

```
	################################
	## Fetch secret value from Vault
	################################
```

### Example - Multiple text lines

Console output:

```
    - name: multi_line_banner
      uses: goffinf-homelab/step-banner@v1.0.0
      with:
        banner_text: "BANNER TEXT 1"
        banner_text2: "BANNER TEXT 2"
        banner_text3: "BANNER TEXT 3"
        banner_text4: "BANNER TEXT 4"
        banner_text5: "BANNER TEXT 5"
        banner_text6: "BANNER TEXT 6 is the longest"

	################################
	## BANNER TEXT 1
	##
	## BANNER TEXT 2
	##
	## BANNER TEXT 3
	##
	## BANNER TEXT 4
	##
	## BANNER TEXT 5
	##
	## BANNER TEXT 6 is the longest
	################################
```

### Example - Including expressions in the text and changing the banner charater

```
	name: "File_Exists"
	description: "Return true of false based on whether the requested filepath was found"
	inputs:
	  filepath:
		description: 'An absolute of relative filepath'
		required: false
		type: string
	...
	runs:
	  using: "composite"
	  steps:
      - name: file_search_banner
        uses: goffinf-homelab/step-banner@v1.0.0
        with:
          banner_text: "Search for requested file: ${{ inputs.filepath }}"
	  banner_text_char: "@"

      - name: file_search
        id: file_search
        run: |
	      ...
```

Console Output:

```
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Search for requested file: ./.github/config/codeql-config.yml
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	...
```

## Configuration

## Inputs


| Input Name | Type | Description | Required | Default Value | 
| :--------- | :--- | :---------- | :------- | :------------ |
| banner_text | String | Line 1 of the INNER text to display | Yes | &#160; |
| banner_text_char | String | The character to use as the boarder | Yes | # |
| banner_text2 | String | Line 2 of the INNER text to display | No | &#160; |
| banner_text3 | String | Line 3 of the INNER text to display | No | &#160; |
| banner_text4 | String | Line 4 of the INNER text to display | No | &#160; |
| banner_text5 | String | Line 5 of the INNER text to display | No | &#160; |
| banner_text6 | String | Line 6 of the INNER text to display | No | &#160; |

### Outputs

None.
