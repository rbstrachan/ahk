; concept test to find out if it's possible to functional-ise conjugating french verbs in AHK
; note: c'est important d'écrire correctement les accents pour pouvoir conjuguer les verbes
; problème: quelques verbes (comme changer) ont deux formes - normal et reflexive, donc tout les deux de "j'ai changé" *et* "je suis changé" sont acceptables comme des formes de la passé composé
; can now perfectly conjugate strictly-regular group 1 and 2 verbs in all modes, tenses and pronouns — working on adding support for pseudo-regular group 1 and 2 verbs by implementing additional rules. 
; conjugate french verbs according though their group, mode, tense, pronoun and auxiliary 
conjugateFR(verbe, mode := "indicatif", tense := "présent", pronom := "je", auxiliaire := "avoir") {
	groupes := map( ; maps regular verbs to their appropriate group
		"er",	1,
		"ir",	2,
		"re",	3
	)
	
	irreguliers := map( ; list of verbs that are completely irregular and do not follow any other well defined pattern
		; "aller", ? ; "aller" is not a group 1 verb
	)

	exceptions := map( ; list of irregular verbs that do not belong to the group they appear to yet follow psuedo-regular conjugations
	)

	modes := map(
		"indicatif",	1,
		"subjonctif",	2,
		"conditionnel",	3,
		"participe",	4,
		"gérondif",		4,
		"impératif",	5
	)
	
	; idea - use avoir_passé composé to accommodate for les auxiliaires. possible?
	tenses := [
		map( ; indicatif
			"présent",			1,
			"imparfait",		2,
			"futur simple",		3,
			"futur proche",		4,
			"passé simple",		5,
			"passé composé",	6,
			"plus-que-parfait",	7,
			"passé antérieur",	8,
			"futur antérieur",	9 
		),
		map( ; subjonctif
			"présent",			1,
			"imparfait",		2,
			"plus-que-parfait",	3,
			"passé",			4 
		),
		map( ; conditionnel
			"présent",			1,
			"passé permiere",	2,
			"passé deuxième",	3
		),
		map( ; particip
			"présent",			1,
			"passé composé",	2,
			"passé",			3 
		),
		map( ; gérondif
			"présent",			1,
			"passé composé",	2 
		),
		map( ; impératif
			"présent",			1,
			"passé",			2 
		)  
	]

	pronoms := map(
		"je",		1,
		"tu",		2,
		"il",		3,
		"elle",		3,
		"on",		3,
		"nous",		4,
		"vous",		5,
		"ils",		6,
		"elles",	6
	)

	; idea - make this avoirTerminaisons and make a seperate array for êtreTerminaisons?
	terminaisons := [
		[ ; 1er groupe -er [1]
			[ ; indicatif
				["-e", "-es", "-e", "-ons", "-ez", "-ent"],										; présent
				["-ais", "-ais", "-ait", "-ions", "-iez", "-aient"],							; imparfait
				["+ai", "+as", "+a", "+ons", "+ez", "+ont"],									; futur simple
				["vais -er", "vas -er", "va -er", "allons -er", "allez -er", "vont -er"],		; futur proche
				["-ai", "-as", "-a", "-âmes", "-âtes", "-èrent"],								; passé simple
				["ai -é", "as -é", "a -é", "avons -é", "avez -é", "ont -é"],					; passé composé
				["avais -é", "avais -é", "avait -é", "avions -é", "aviez -é", "avaient -é"],	; plus-que-parfait
				["eus -é", "eus -é", "eut -é", "eûmes -é", "eûtes -é", "eurent -é"],			; passé antérieur
				["aurai -é", "auras -é", "aura -é", "aurons -é", "aurez -é", "auront -é"]		; futur antérieur
			], 
			[ ; subjonctif
				["-e", "-es", "-e", "-ions", "-iez", "-ent"],									; présent
				["-asse", "-asses", "-ât", "-assions", "-assiez", "-assent"],					; imparfait
				["eusse -é", "eusses -é", "eût -é", "eussions -é", "eussiez -é", "eussent -é"],	; plus-que-parfait
				["aie -é", "aies -é", "ait -é", "ayons -é", "ayez -é", "aient -é"]				; passé
			],
			[ ; conditionnel
				["+ais", "+ais", "+ait", "+ions", "+iez", "+aient"],								; présent
				["aurais -é", "aurais -é", "aurait -é", "aurions -é", "auriez -é", "auraient -é"],	; passé première
				["eusse -é", "eusses -é", "eût -é", "eussions -é", "eussiez -é", "eussent -é"]		; passé deuxième
			],
			[ ; participe et gérondif
				["-ant"],		; présent
				["ayant -é"]	; passé composé
			],
			[ ; impératif
				["-e", "", "", "-ons", "-ez", ""],				; présent
				["aie -é", "", "", "ayons -é", "ayez -é", ""]	; passé
			]
		],
		[ ; 2ème groupe -ir [2]
			[ ; indicatif
				["-is", "-is", "-it", "-issons", "-issez", "-issent"],							; présent
				["-issais", "-issais", "-issait", "-issions", "-issiez", "-issaient"],			; imparfait
				["+ai", "+as", "+a", "+ons", "+ez", "+ont"],									; futur simple
				["vais -ir", "vas -ir", "va -ir", "allons -ir", "allez -ir", "vont -ir"],		; futur proche
				["-is", "-is", "-it", "-îmes", "-îtes", "-irent"],								; passé simple
				["ai -i", "as -i", "a -i", "avons -i", "avez -i", "ont -i"],					; passé composé
				["avais -i", "avais -i", "avait -i", "avions -i", "aviez -i", "avaient -i"],	; plus-que-parfait
				["eus -i", "eus -i", "eut -i", "eûmes -i", "eûtes -i", "eurent -i"],			; passé antérieur
				["aurai -i", "auras -i", "aura -i", "aurons -i", "aurez -i", "auront -i"]		; futur antérieur
			],
			[ ; subjonctif
				["-isse", "-isses", "-isse", "-issions", "-issiez", "-issent"],					; présent
				["-isse", "-isses", "-ît", "-issions", "-issiez", "-issent"],					; imparfait
				["eusse -i", "eusses -i", "eût -i", "eussions -i", "eussiez -i", "eussent -i"],	; plus-que-parfait
				["aie -i", "aies -i", "ait -i", "ayons -i", "ayez -i", "aient -i"]				; passé
			],
			[ ; conditionnel
				["+ais", "+ais", "+ait", "+ions", "+iez", "+aient"],								; présent
				["aurais -i", "aurais -i", "aurait -i", "aurions -i", "auriez -i", "auraient -i"],	; passé première
				["eusse -i", "eusses -i", "eût -i", "eussions -i", "eussiez -i", "eussent -i"]		; passé deuxième
			],
			[ ; participe et gérondif
				["-issant"],	; présent
				["ayant -i"]	; passé composé
			],
			[ ; impératif
				["-is", "", "", "-issons", "-issez", ""],		; présent
				["aie -i", "", "", "ayons -i", "ayez -i", ""]	; passé
			]
		],
		[ ; 3ème groupe (première forme) [3] ; -s -s -t -ons -ez -ent
			[], [], [], [], []
		],
		[ ; 3ème groupe (deuxième forme) [4] ; -ds -ds -d -ons -ez -ent
			[], [], [], [], []
		],
		[ ; 3ème groupe (troisième forme) [5]
			[], [], [], [], []
		],
		[ ; 3ème groupe (quatrième forme) [6]
			[], [], [], [], []
		]
	]
	; idea for terminaisons[] → terminaisons[(exceptions.has(verbe) ? groupes[exceptions[verbe]] : group[verbe])] ; if verb is in exceptions, take groupe value from exceptions[], otherwise, take value from groupes[] as normal
	finBrute  := terminaisons[groupes[subStr(verbe, -2)]][modes[mode]][tenses[modes[mode]][tense]][pronoms[pronom]] ; locates the raw ending in the 'terminaisons' array above given the parameters passed in the function call
	finPartie := strSplit(finBrute, A_Space, "-") ; splits the raw ending into two parts - the composite verb (if one exists for this conjugation) and the ending

	indice := finPartie.length ; sets the index to the length of 'finPartie' - relevant for rules section later 

	regles := [ ; rules that describe the exceptional cases of spelling changes in verb conjugations
		((regExMatch(verbe, "ger$") && regExMatch(subStr(finPartie[indice], 1, 1), "[aâo]")) ? finPartie[indice] := "e" finPartie[indice] : False) ; conserve le "e" après le "g" devant les voyelles "a" et "o"
		; add rule — les verbes en "-éger" subissent une variation d'accent (é → è) à certaines formes (devant une syllabe muette sauf au futur et conditionnel) : protéger / il protège mais il protégera, il protégerait
	]

	fin := (finPartie.length = 2 ? finPartie[1] " -" finPartie[2] : "-" finPartie[1]) ; reconstructs the two halves of finBrute into a final variable 'fin'
	return((inStr(fin, "-") ? regExReplace(fin, "-([\wéèâî]+)$", subStr(verbe, 1, -2) "$1") : regExReplace(fin, "\+(\w+)$", verbe "$1"))) ; joins the verb stem with it's ending
}

/* 
^+5:: { ; test irregular conjugations of verbs in 1er groupe
	send(conjugateFR("protéger", "indicatif", "présent", "je") "`n")
	send(conjugateFR("protéger", "indicatif", "présent", "tu") "`n")
	send(conjugateFR("protéger", "indicatif", "présent", "il") "`n")
	send(conjugateFR("protéger", "indicatif", "présent", "nous") "`n")
	send(conjugateFR("protéger", "indicatif", "présent", "vous") "`n")
	send(conjugateFR("protéger", "indicatif", "présent", "ils") "`n`n")

	send(conjugateFR("protéger", "indicatif", "imparfait", "je") "`n")
	send(conjugateFR("protéger", "indicatif", "imparfait", "tu") "`n")
	send(conjugateFR("protéger", "indicatif", "imparfait", "il") "`n")
	send(conjugateFR("protéger", "indicatif", "imparfait", "nous") "`n")
	send(conjugateFR("protéger", "indicatif", "imparfait", "vous") "`n")
	send(conjugateFR("protéger", "indicatif", "imparfait", "ils") "`n`n")

	send(conjugateFR("protéger", "indicatif", "passé simple", "je") "`n")
	send(conjugateFR("protéger", "indicatif", "passé simple", "tu") "`n")
	send(conjugateFR("protéger", "indicatif", "passé simple", "il") "`n")
	send(conjugateFR("protéger", "indicatif", "passé simple", "nous") "`n")
	send(conjugateFR("protéger", "indicatif", "passé simple", "vous") "`n")
	send(conjugateFR("protéger", "indicatif", "passé simple", "ils") "`n`n")

	send(conjugateFR("protéger", "subjonctif", "imparfait", "je") "`n")
	send(conjugateFR("protéger", "subjonctif", "imparfait", "tu") "`n")
	send(conjugateFR("protéger", "subjonctif", "imparfait", "il") "`n")
	send(conjugateFR("protéger", "subjonctif", "imparfait", "nous") "`n")
	send(conjugateFR("protéger", "subjonctif", "imparfait", "vous") "`n")
	send(conjugateFR("protéger", "subjonctif", "imparfait", "ils") "`n`n")	
}

^+6:: { ; test irregular conjugations of verbs in 2ème groupe
	send(conjugateFR("finir", "indicatif", "présent", "je") "`n")
	send(conjugateFR("finir", "indicatif", "présent", "tu") "`n")
	send(conjugateFR("finir", "indicatif", "présent", "il") "`n")
	send(conjugateFR("finir", "indicatif", "présent", "nous") "`n")
	send(conjugateFR("finir", "indicatif", "présent", "vous") "`n")
	send(conjugateFR("finir", "indicatif", "présent", "ils") "`n`n")

	send(conjugateFR("finir", "indicatif", "imparfait", "je") "`n")
	send(conjugateFR("finir", "indicatif", "imparfait", "tu") "`n")
	send(conjugateFR("finir", "indicatif", "imparfait", "il") "`n")
	send(conjugateFR("finir", "indicatif", "imparfait", "nous") "`n")
	send(conjugateFR("finir", "indicatif", "imparfait", "vous") "`n")
	send(conjugateFR("finir", "indicatif", "imparfait", "ils") "`n`n")

	send(conjugateFR("finir", "indicatif", "passé simple", "je") "`n")
	send(conjugateFR("finir", "indicatif", "passé simple", "tu") "`n")
	send(conjugateFR("finir", "indicatif", "passé simple", "il") "`n")
	send(conjugateFR("finir", "indicatif", "passé simple", "nous") "`n")
	send(conjugateFR("finir", "indicatif", "passé simple", "vous") "`n")
	send(conjugateFR("finir", "indicatif", "passé simple", "ils") n`n")

	send(conjugateFR("finir", "subjonctif", "imparfait", "je") "`n")
	send(conjugateFR("finir", "subjonctif", "imparfait", "tu") "`n")
	send(conjugateFR("finir", "subjonctif", "imparfait", "il") "`n")
	send(conjugateFR("finir", "subjonctif", "imparfait", "nous") "`n")
	send(conjugateFR("finir", "subjonctif", "imparfait", "vous") "`n")
	send(conjugateFR("finir", "subjonctif", "imparfait", "ils") "`n`n")	
}
*/
