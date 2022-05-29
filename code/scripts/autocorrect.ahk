
;*******************************************************************************;
;							Autocorrect - English								;
;*******************************************************************************;

; problem - using send("^+{Left}") selects an entire word, even if the hotkey only replaces the ending, hence hotkeys with the '?' option do not work.
; better solution that is *not* slow?

; hotstrings that replace a phrase do not currently work natively (le votre → le le vôtre)

#Hotstring x b0
; abbreviations
; the prefix '>' is used when an abbreviation may also be used without expansion
:*:afaik::clipSend("as far as I know")
:*:btw::clipSend("by the way")
:*:lmk::clipSend("let me know if I can help you with anything else 😊")
:*:np::clipSend("no problem")
; :*:rvw:: {
; 	currentDate := formatTime(, "yyyy-MM-dd HH:mm:ss")
; ;	gui, new
; ;	gui, add, text,, enter verb in past tense:
; ;	gui, add, edit, vverb
; ;	gui, add, button, default, okay
; ;	gui, show,, which verb do you want
; ;	return
; ;
; ;	buttonOkay:
; ;	gui, submit
; 	clipSend("——" currentDate " — reviewed by Reiwa")
; }
:*:tldr::clipSend("tl:dr")
:*:>ahk::clipSend("autohotkey") ; > used as ahk is also acceptable in some situations
:*:>smth::clipSend("something")
:*:>ty::clipSend("thank you")  ; > used to avoid collision with type, etc.
:*:>uk::clipSend("United Kingdom")
:*:>us::clipSend("United States")
:*:>v2::clipSend("~~you wouldn't have this issue in v2~~")
::tho::clipSend("though")

; autocomplete parenthesis and quote marks outside of VSC
#HotIf !winActive("Visual Studio Code")
; :*b0:``::``{Left} ; automatically type the other '`' character to prevent me from forgetting
:*b:¬¬¬::send("``````ahk{Enter 2}``````{Up}") ; create an ahk codeblock
#HotIf

#Hotstring x0 b
; emojis and special characters
; the prefix ':' is used for emojis and most special characters
:*::+1::👍
:*::hello::👋
:*::laughing::🤣
:*::party::🥳
:*::plead::🥺
:*::please::🙏
:*::rofl::🤣
:*::sad::😭
:*::shock::🤯
:*::smile::😊
:*::thanks::🙇
:*::wave::👋
:*::shrug::¯\_(ツ)_/¯
:*::worried::ಠ_ಠ
:*::flip::(╯°□°)╯︵ ┻━┻
:*::unflip::┬──┬ ノ(゜-゜ノ)
:*::flag.sc::🏴󠁧󠁢󠁳󠁣󠁴󠁿 ; scotland
:*::flag.gb::🇬🇧 ; uk
:*::flag.fr::🇫🇷 ; france
:*::flag.jp::🇯🇵 ; japan
:*::flag.gt::🇬🇹 ; guatemala
:*::flag.gay::🏳️‍🌈 ; secondary prefix — flag — must be used to avoid collision with ':gbp', ':usd', ':yen', etc.

; special characters
; idea - include greek characters (:alpha, :beta, etc.) and their capital counterparts. capitals work automatically?
:*:ss::§
:o::s::§			; slow. included to remain consistant with : prefix
:c::u::↑			; using :*: for short hotstrings may interfere with other commands. see below also.
:c::d::↓
:c*::gbp::£00.00+{Left 5}
:c*::usd::$00.00+{Left 5} 
:c*::cad::C$00.00+{Left 5}
:c*::yen::¥0,000+{Left 5}
:c*:<<::←{Space}	; use :c: to remain consistent with similar commands
:c*:>>::→{Space}	; use :c: to remain consistent with similar commands
:c*:<>::↔{Space}	; use :c: to remain consistent with similar commands
:c*?::en::–			; en dash - means "to" or "through" - used to range numbers (chapters 1–5), report scores (he won 2–1), show a contradiction or connection (liberal–conservative; London–France–Japan flight), etc.
:c*?::em::—			; em dash - used to replace commas, colons and brackets when a longer pause or greater emphasis is needed
#Hotstring x b0
::acn::clipSend("can")
::accomodation::clipSend("accommodation")
::acheive::clipSend("achieve")
::acheivement::clipSend("achievement")
::acheivable::clipSend("achievable")
::alot::clipSend("a lot")
::mischeivous::clipSend("mischievous")
::definate::clipSend("definite")
::easter::clipSend("Easter")
::effecient::clipSend("efficient")
::effeciency::clipSend("efficiency")
::hace::clipSend("have")
::recieve::clipSend("receive")
::recieving::clipSend("receiving")
::releive::clipSend("relieve")
::responsable::clipSend("responsible")
::responsability::clipSend("responsibility")
:c:monday::clipSend("Monday")
:c:tuesday::clipSend("Tuesday")
:c:wednesday::clipSend("Wednesday")
:c:thursday::clipSend("Thursday")
:c:friday::clipSend("Friday")
:c:saturday::clipSend("Saturday")
:c:sunday::clipSend("Sunday")
:c:january::clipSend("January")
:c:february::clipSend("February")
:c:march::clipSend("March")
:c:june::clipSend("June")
:c:april::clipSend("April")
:c:july::clipSend("July")
:c:august::clipSend("August")
:c:september::clipSend("September")
:c:october::clipSend("October")
:c:november::clipSend("November")
:c:december::clipSend("December")
:*:etc::clipSend("etc.")

; :?:;s::clipSend("'s")

::eg::clipSend("e.g.")
::hes::clipSend("he's")
::id::clipSend("I'd")
::ie::clipSend("i.e.")
::im::clipSend("I'm")
::its::clipSend("it's")
::arent::clipSend("aren't")
::cant::clipSend("can't")
::couldve::clipSend("could've")
::couldnt::clipSend("couldn't")
::didnt::clipSend("didn't")
::doesnt::clipSend("doesn't")
::dont::clipSend("don't")
::hadnt::clipSend("hadn't")
::havent::clipSend("haven't")
::hed::clipSend("he'd")
::ill::clipSend("I'll")
::isnt::clipSend("isn't")
::itll::clipSend("it'll")
::ive::clipSend("I've")
::mustve::clipSend("must've")
::shes::clipSend("she's")
::shouldve::clipSend("should've")
::thatll::clipSend("that'll")
::thats::clipSend("that's")
::thell::clipSend("they'll")
::theres::clipSend("there's")
::theyd::clipSend("they'd")
::theyll::clipSend("they'll")
::theyre::clipSend("they're")
::theyve::clipSend("they've")
::todays::clipSend("today's")
::wasnt::clipSend("wasn't")
::werent::clipSend("weren't")
::weve::clipSend("we've")
::whats::clipSend("what's")
::whens::clipSend("when's")
::whered::clipSend("where'd")
::wheres::clipSend("where's")
::whyve::clipSend("why've")
::wont::clipSend("won't")
::wouldve::clipSend("would've")
::wouldnt::clipSend("wouldn't")
::youll::clipSend("you'll")
::youre::clipSend("you're")
::youve::clipSend("you've")
:*:hell*::clipSend("he'll ")
:*:well*::clipSend("we'll ")
:*:were*::clipSend("we're ")


;*******************************************************************************;
;							Autocorrect - French								;
;*******************************************************************************;
#Hotstring x0 b
; les caractères individuels
; note: some characters are not used in french and hence are commented out to prevent unnecessary collisions
:*?:a``::à	; double backtick is required as the backtick is a reserved character in AHK
:*?:a/::á	; using / here is preferred over ' due to conflicts with English contractions
:*?:a^::â
; :*?:a;::ä
; :*?:i``::ì
; :*?:i/::í
:*?:i^::î
:*?:i;::ï
:*?:u``::ù
; :*?:u/::ú
:*?:u^::û
:*?:u;::ü
:*?:e``::è
:*?:e/::é
:*?:e^::ê
:*?:e;::ë
; :*?:o``::ò
; :*?:o/::ó
:*?:o^::ô
; :*?:o;::ö
:*?:n~::ñ
:*?:c;::ç
:*?:oe<::œ
:*?:ae<::æ
#Hotstring x b0
; les abréviations
; the prefix '>' is used when an abbreviation can also be used without expansion
::adm::clipSend("à demain")
::ecq::clipSend("est-ce que")
::hum::clipSend("heureusement")
::qcq::clipSend("qu'est-ce que")
:*:abt::clipSend("à bientôt")
:*:acd::clipSend("à cause de")
:*:ajh::clipSend("aujourd'hui")
:*:atal::clipSend("à tout à l'heure")
:*:bn::clipSend("bonne nuit")
:*:bs::clipSend("bien sûr")
:*:dc::clipSend("d'accord")
:*:ecqinyap::clipSend("est-ce qu'il n'y a pas")
:*:ecqinya::clipSend("est-ce qu'il y a")
:*:ifq::clipSend("il faut que")
:*:inyap::clipSend("il n'y a pas")
:*:iya::clipSend("il y a")
:*:jspq::clipSend("j'espère que")
:*:jqtpubj::clipSend("j'espère que tu passes une bonne journée.")
:*:mhum::clipSend("malheureusement")
:*:mntn::clipSend("maintenant")
:*:ntqp::clipSend("ne t'inquiète pas")
:*:pdp::clipSend("pas de problème")
:*:pds::clipSend("pas de soucis")
:*:pq::clipSend("pourquoi")
:*:pblm::clipSend("probablement")
:*:ptt::clipSend("prends ton temps")
:*:qcqinyap::clipSend("qu'est-ce qu'il n'y a pas")
:*:qcqiya::clipSend("qu'est-ce qu'il y a")
:*:qqia::clipSend("quoi qu'il arrive")
:*:qqies::clipSend("quoi qu'il en soit")
:*:taf::clipSend("tout à fait")
::>eu::clipSend("États-Uni")
::>mdr::clipSend("mort de rire")
::>qqch::clipSend("quelque chose")
::>qqp::clipSend("quelque part")
::>qqn::clipSend("quelqu'un")
::>qqun::clipSend("quelqu'un")
::>rdv::clipSend("rendez-vous")
::>stp::clipSend("s'il te plaît")
::>svp::clipSend("s'il vous plaît")
::>ru::clipSend("Royame-Uni")

; fautes d'orthographes
; note: the suffix '*' is used for words that are spelled the same (except accents) in both fr/en (hôtel / hotel) or fr/fr (là / la) to prevent conflicts
; note: :: omitted for some contractions to prevent collisions (e.g. ça + car → çar; àcces + access → àccess)
::2eme::clipSend("2ème")
::3eme::clipSend("3ème")
::4eme::clipSend("4ème")
::abreviation::clipSend("abréviation")
::acces::clipSend("accès")
::acceuil::clipSend("accueil")
::aout::clipSend("août")
::appetit::clipSend("appétit")
::apres::clipSend("après")
::arrete::clipSend("arrête")
::beacoup::clipSend("beaucoup")
::bientot::clipSend("bientôt")
::cafe::clipSend("café")
::ca::clipSend("ça")
::chateau::clipSend("château")
::creer::clipSend("créer") ; not possible to also accommodate the past tense
::decembre::clipSend("décembre")
::deja::clipSend("déjà")
::delicieux::clipSend("délicieux")
::deranger::clipSend("déranger")
::derange::clipSend("dérange")
::desolee::clipSend("désolée")
::desole::clipSend("désolé")
::deuxieme::clipSend("deuxième")
::differemment::clipSend("différemment")
::drole::clipSend("drôle")
::echange::clipSend("échange")
::ecossais::clipSend("éccosais")
::electronique::clipSend("électronique")
::ephemere::clipSend("éphémère")
::espere::clipSend("espère")
::etais::clipSend("étais")
::etait::clipSend("était")
::etat::clipSend("état")
::etes::clipSend("êtes")
::ete::clipSend("été")
::etre::clipSend("être")
::eviter::clipSend("éviter")
::evite::clipSend("évite")
::facon::clipSend("façon")
::fete::clipSend("fête")
::fevrier::clipSend("février")
::francais::clipSend("français")
::francias::clipSend("français")
::garcon::clipSend("garçon")
::gateau::clipSend("gâteau")
::grace::clipSend("grâce") ; technically, the word grace also exists in en, however it is very rarely used, hence suffix '*' omitted
::honnetement::clipSend("honnêtement")
::honnete::clipSend("honnête")
::idee::clipSend("idée")
::inquiete::clipSend("inquiète")
::interessant::clipSend("intéressant")
::interesser::clipSend("intéresser")
::interesse::clipSend("intéresse")
::journee::clipSend("journée")
::la notre::send("+^{Left}"), clipSend("la nôtre")
::la votre::send("+^{Left}"), clipSend("la vôtre")
::le notre::send("+^{Left}"), clipSend("le nôtre")
::le votre::send("+^{Left}"), clipSend("le vôtre")
::lecon::clipSend("leçon")
::meme::clipSend("même")
::mere::clipSend("mère")
::naive::clipSend("naïve")
::noel::clipSend("Noël")
::pere::clipSend("père")
::plutot::clipSend("plutôt")
::pourqoui::clipSend("pourquoi")
::premiere::clipSend("première")
::prete::clipSend("prête")
::pret::clipSend("prêt")
::probleme::clipSend("problème")
::qoui::clipSend("quoi")
::quatrieme::clipSend("quatrième")
::recu::clipSend("reçu")
::reflechi::clipSend("réfléchi")
::rendezvous::clipSend("rendez-vous")
::reussi::clipSend("réussi")
::riviere::clipSend("rivière")
::soeur::clipSend("sœur")
::soiree::clipSend("soirée")
::souffle::clipSend("soufflé")
::sur::clipSend("sûr")
::tempete::clipSend("tempête")
::tete::clipSend("tête")
::toirs::clipSend("trois")
::tot::clipSend("tôt")
::tres::clipSend("très")
::troisieme::clipSend("troisième")
::vetements::clipSend("vêtements")
::vuet::clipSend("veut")
::vuex::clipSend("veux")
:*:difference*::clipSend("différence")
:*:diner*::clipSend("dîner")
:*:du*::clipSend("dû")
:*:education*::clipSend("éducation")
:*:la*::clipSend("là")
:*:ou*::clipSend("où")
:*:prepare*::clipSend("prépare")
:*:present*::clipSend("présent")
:*:pu*::clipSend("pû")
:*:su*::clipSend("sû")
:*:hotel*::clipSend("hôtel")

; contractions
; note: :: omitted for some contractions to prevent collisions (e.g. t'es + test → t'est)
::ce nest::send("^+{Left}"), clipSend("ce n'est")
::cest::clipSend("c'est")
::cetais::clipSend("c'étais")
::cetait::clipSend("c'était")
::daccord::clipSend("d'accord")
::dun::clipSend("d'un")
::jaime::clipSend("j'aime")
::jai::clipSend("j'ai")
::jarrive::clipSend("j'arrive")
::jattends::clipSend("j'attends")
::jaurai::clipSend("j'aurai")
::javais::clipSend("j'avais")
::jen::clipSend("j'en")
::jespere::clipSend("j'espère")
::jetais::clipSend("j'étais")
::jimagine::clipSend("j'imagine")
::jy::clipSend("j'y")
::lai::clipSend("l'ai")
::langlais::clipSend("l'anglais")
::menerve::clipSend("m'énerve")
::menvoyer::clipSend("m'envoyer")
::nai::clipSend("n'ai")
::nes::clipSend("n'es")
::netais::clipSend("n'étais")
::netait::clipSend("n'était")
::ny::clipSend("n'y")
::quil::clipSend("qu'il")
::quils::clipSend("qu'ils")
::quon::clipSend("qu'on")
::quun::clipSend("qu'un")
::sil::clipSend("s'il")
::taide::clipSend("t'aide")
::tas::clipSend("t'as")
::tattends::clipSend("t'attends")
::tembete::clipSend("t'embête")
::tentends::clipSend("t'entends")
::tenvoyer::clipSend("t'envoyer")
::tetais::clipSend("t'étais")
::tutilises::clipSend("t'utilises")
:*:men*::clipSend("m'en ")
:*:quelle*::clipSend("qu'elle ")
:*:ten*::clipSend("t'en ")
:*:tes*::clipSend("t'es ")

;*******************************************************************************;
;							Autocorrect - Japanese								;
;*******************************************************************************;

:*:argt::clipSend("ありがとう")
:*:gbtn::clipSend("頑張ってね")
:*:gzms::clipSend("ございます")
:*:mtn::clipSend("またね")
:*:omdt::clipSend("おめでとう")

