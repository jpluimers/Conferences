{$i AlwaysInclude.inc}

unit NLConsts;

{$T-} //##jpl: tijdelijk totdat we de code hebben opgeschoond

interface

implementation

uses
  Consts, ResourceUtils;

resourcestring
  SCantWriteResourceStreamError = 'Kan niet naar een alleen-lezen resource stream schrijven';
  SDuplicateReference = 'WriteObject tweemaal aangeroepen voor dezelfde instance';
  SInvalidImage = 'Ongeldig stream formaat';
  SClassMismatch = 'Resource %s niet van de correcte class';
  SInvalidTabIndex = 'Tab index buiten de toegestane grenzen';
  SInvalidBitmap = 'Bitmap image is ongeldig';
  SInvalidIcon = 'Icon image is ongeldig';
  SInvalidMetafile = 'Metafile is ongeldig';
  SInvalidPixelFormat = 'Ongeldig pixel formaat';
  SBitmapEmpty = 'Bitmap is leeg';
  SScanLine = 'Scan regel index buiten toegestane bereik';
  SChangeIconSize = 'Kan de grootte van en icon niet wijzigen';
  SOleGraphic = 'Ongeldige bewerking op TOleGraphic';
  SUnknownExtension = 'Onbekend grafische bestandsextensie (.%s)';
  SUnknownClipboardFormat = 'Niet ondersteund klembord formaat';
  SOutOfResources = 'Systeembronnen ontoereikend';
  SNoCanvasHandle = 'Canvas niet geschikt voor tekenen';
  SInvalidImageSize = 'Ongeldige grootte voor plaatje';
  STooManyImages = 'Te veel plaatjes';
  SDimsDoNotMatch = 'Kenmerken van het plaatje komen niet overeen met die van de ImageList';
  SInvalidImageList = 'Ongeldige ImageList';
  SReplaceImage = 'Het was niet mogelijk het plaatje te vervangen';
  SImageIndexError = 'Ongeldige ImageList Index';
  SImageReadFail = 'Het was niet mogelijk de ImageList data van een stream te lezen';
  SImageWriteFail = 'Het was niet mogelijk de ImageList data naar een stream te schrijven';
  SWindowDCError = 'Fout bij het aanmaken van een window device context';
  SClientNotSet = 'Client van TDrag is niet geinitialiseerd';
  SWindowClass = 'Fout bij het aanmaken van de window class';
  SWindowCreate = 'Fout bij het aanmaken van het window';
  SCannotFocus = 'Kan de focus niet naar een onzichtbaar of uitgeschakeld window verplaatsen';
  SParentRequired = 'Control ''%s'' heeft geen parent window';
  SMDIChildNotVisible = 'Kan een MDI Child formulier niet verbergen';
  SVisibleChanged = 'Zichtbaarheid kan niet in OnShow or OnHide ingesteld worden';
  SCannotShowModal = 'Een zichtbaar scherm kan niet modaal gemaakt worden';
  SScrollBarRange = 'Scrollbar property buiten het toegestane bereik';
  SPropertyOutOfRange = '%s property buiten het toegestane bereik';
  SMenuIndexError = 'Menu index buiten het toegestane bereik';
  SMenuReinserted = 'Menu tweemaal ingevoegd';
  SMenuNotFound = 'Sub-menu is niet in het menu aanwezig';
  SNoTimers = 'Niet voldoende timers beschikbaar';
  SNotPrinting = 'Printer is op het moment niet aan het afdrukken';
  SPrinting = 'Afdrukken is bezig';
  SPrinterIndexError = 'Printer buiten het toegestane bereik';
  SInvalidPrinter = 'Geselecteerde printer is ongeldig';
  SDeviceOnPort = '%s op %s';
  SGroupIndexTooLow = 'GroupIndex kan niet minder zijn dan het vorige menu item''s GroupIndex';
  STwoMDIForms = 'Meer dan 1 MDI formulier per applicatie is niet mogelijk';
  SNoMDIForm = 'Formulier kan niet aangemaakt worden. Geen MDI formulieren actief';
  SImageCanvasNeedsBitmap = 'Een plaatje kan alleen aangepast worden als het een Bitmap bevat';
  SControlParentSetToSelf = 'Een control kan niet zijn eigen parent zijn';
  SOKButton = 'OK';
  SCancelButton = 'Annuleren';
  SYesButton = '&Ja';
  SNoButton = '&Nee';
  SHelpButton = '&Help';
  SCloseButton = '&Sluiten';
  SIgnoreButton = 'Ne&geren';
  SRetryButton = '&Opnieuw';
  SAbortButton = 'Afbreken';
  SAllButton = '&Alles';

  SCannotDragForm = 'Formulier kan niet gesleept worden';
  SPutObjectError = 'PutObject naar ongedefinieerd item';
  SCardDLLNotLoaded = 'CARDS.DLL kon niet geladen worden';
  SDuplicateCardId = 'Dubbel CardId gevonden';

  SDdeErr = 'Een foutmelding werd door DDE geretourneerd ($0%x)';
  SDdeConvErr = 'DDE fout - conversatie niet tot stand gekomen ($0%x)';
  SDdeMemErr = 'Foutmelding, DDE heeft niet voldoende geheugen ter beschikking ($0%x)';
  SDdeNoConnect = 'Het is niet mogelijk een DDE conversatie te starten';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = 'Kan niet een oudere versie van TShape laden';
  SVMetafiles = 'Metafiles';
  SVEnhMetafiles = 'Enhanced Metafiles';
  SVIcons = 'Iconen';
  SVBitmaps = 'Bitmaps';
  SGridTooLarge = 'Grid is te groot voor deze bewerking';
  STooManyDeleted = 'Teveel rijen of kolommen gedetecteerd';
  SIndexOutOfRange = 'Grid index buiten toegestane bereik';
  SFixedColTooBig = 'Het aantal vaste kolommen moet minder zijn dan het totaal aantal kolommen';
  SFixedRowTooBig = 'Het aantal vaste rijen moet minder zijn dan het totaal aantal rijen';
  SInvalidStringGridOp = 'Kan geen rijen toevoegen of wissen in de grid';
  SInvalidNumber = 'Ongeldige numerieke waarde';
  SOutlineIndexError = 'Outline index niet gevonden';
  SOutlineExpandError = 'Parent moet geexpandeerd zijn';
  SInvalidCurrentItem = 'Ongeldige waarde voor het huidige item';
  SMaskErr = 'Ongeldige invoer';
  SMaskEditErr = 'Ongeldige invoer.  Gebruik escape om de invoer ongedaan te maken';
  SOutlineError = 'Ongeldige outline index';
  SOutlineBadLevel = 'Incorrecte niveau toewijzing';
  SOutlineSelection = 'Ongeldige selectie';
  SOutlineFileLoad = 'Fout bij het laden van een bestand';
  SOutlineLongLine = 'Regel is te lang';
  SOutlineMaxLevels = 'Maximum diepte van de outline overschreden';

  SMsgDlgWarning = 'Waarschuwing';
  SMsgDlgError = 'Fout';
  SMsgDlgInformation = 'Informatie';
  SMsgDlgConfirm = 'Bevestigen';
  SMsgDlgYes = '&Ja';
  SMsgDlgNo = '&Nee';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Annuleren';
  SMsgDlgHelp = '&Help';
  SMsgDlgHelpNone = 'Geen help beschikbaar';
  SMsgDlgHelpHelp = 'Help';
  SMsgDlgAbort = '&Afbreken';
  SMsgDlgRetry = '&Opnieuw';
  SMsgDlgIgnore = 'Ne&geren';
  SMsgDlgAll = '&Alles';
  SMsgDlgNoToAll = 'N&ee op Alles';
  SMsgDlgYesToAll = 'Ja& op Alles';

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  srUnknown = '(Onbekend)';
  srNone = '(Geen)';
  SOutOfRange = 'Waarde moet tussen %d en %d liggen';
{$ifndef d9up}
  SCannotCreateName = 'Kan geen standaard methodenaam voor een component zonder naam maken';
{$endif d9up}

  SDateEncodeError = 'Ongeldige parameter bij datum omzetting';
  SDefaultFilter = 'Alle bestanden (*.*)|*.*';
  sAllFilter = 'Alles';
  SNoVolumeLabel = ': [ - Geen schijf naam - ]';
  SInsertLineError = 'Onmogelijk een regel tussen te voegen';

  SConfirmCreateDir = 'De aangegeven directory bestaat niet. Aanmaken?';
  SSelectDirCap = 'Selecteer Directory';
  SDirNameCap = 'Directory &Naam:';
  SDrivesCap = 'D&isks:';
  SDirsCap = '&Directory''s:';
  SFilesCap = '&Bestanden: (*.*)';
  SNetworkCap = 'Ne&twerk...';

  SColorPrefix = 'Kleur';
  SColorTags = 'ABCDEFGHIJKLMNOP';

  SInvalidClipFmt = 'Ongeldig klembord formaat';
  SIconToClipboard = 'Klembord ondersteunt geen iconen';

  SDefault = 'Standaard';

  SInvalidMemoSize = 'Tekst is langer dan de capaciteit van het memo';
  SCustomColors = 'Specifieke kleuren';
  SInvalidPrinterOp = 'Bewerking wordt niet ondersteund door de geselecteerde printer';
  SNoDefaultPrinter = 'Er is momenteel geen standaard printer gedefinieerd';

  SIniFileWriteError = 'Onmogelijk om naar %s te schrijven';

  SBitsIndexError = 'Bits index buiten toegestane bereik';

  SUntitled = '(Naamloos)';

  SInvalidRegType = 'Ongeldig data type voor ''%s''';

  SUnknownConversion = 'Onbekende RichEdit conversie bestandsextensie (.%s)';
  SDuplicateMenus = 'Menu ''%s'' wordt reeds gebruikt door een ander formulier';

procedure HookResources;
begin
  CopyResString(@NLConsts.SCantWriteResourceStreamError , @Consts.SCantWriteResourceStreamError , True);
  CopyResString(@NLConsts.SDuplicateReference           , @Consts.SDuplicateReference           , True);
  CopyResString(@NLConsts.SInvalidImage                 , @Consts.SInvalidImage                 , True);
  CopyResString(@NLConsts.SClassMismatch                , @Consts.SClassMismatch                , True);
  CopyResString(@NLConsts.SInvalidTabIndex              , @Consts.SInvalidTabIndex              , True);
  CopyResString(@NLConsts.SInvalidBitmap                , @Consts.SInvalidBitmap                , True);
  CopyResString(@NLConsts.SInvalidIcon                  , @Consts.SInvalidIcon                  , True);
  CopyResString(@NLConsts.SInvalidMetafile              , @Consts.SInvalidMetafile              , True);
  CopyResString(@NLConsts.SInvalidPixelFormat           , @Consts.SInvalidPixelFormat           , True);
  CopyResString(@NLConsts.SBitmapEmpty                  , @Consts.SBitmapEmpty                  , True);
  CopyResString(@NLConsts.SScanLine                     , @Consts.SScanLine                     , True);
  CopyResString(@NLConsts.SChangeIconSize               , @Consts.SChangeIconSize               , True);
  CopyResString(@NLConsts.SOleGraphic                   , @Consts.SOleGraphic                   , True);
  CopyResString(@NLConsts.SUnknownExtension             , @Consts.SUnknownExtension             , True);
  CopyResString(@NLConsts.SUnknownClipboardFormat       , @Consts.SUnknownClipboardFormat       , True);
  CopyResString(@NLConsts.SOutOfResources               , @Consts.SOutOfResources               , True);
  CopyResString(@NLConsts.SNoCanvasHandle               , @Consts.SNoCanvasHandle               , True);
  CopyResString(@NLConsts.SInvalidImageSize             , @Consts.SInvalidImageSize             , True);
  CopyResString(@NLConsts.STooManyImages                , @Consts.STooManyImages                , True);
  CopyResString(@NLConsts.SDimsDoNotMatch               , @Consts.SDimsDoNotMatch               , True);
  CopyResString(@NLConsts.SInvalidImageList             , @Consts.SInvalidImageList             , True);
  CopyResString(@NLConsts.SReplaceImage                 , @Consts.SReplaceImage                 , True);
  CopyResString(@NLConsts.SImageIndexError              , @Consts.SImageIndexError              , True);
  CopyResString(@NLConsts.SImageReadFail                , @Consts.SImageReadFail                , True);
  CopyResString(@NLConsts.SImageWriteFail               , @Consts.SImageWriteFail               , True);
  CopyResString(@NLConsts.SWindowDCError                , @Consts.SWindowDCError                , True);
  CopyResString(@NLConsts.SClientNotSet                 , @Consts.SClientNotSet                 , True);
  CopyResString(@NLConsts.SWindowClass                  , @Consts.SWindowClass                  , True);
  CopyResString(@NLConsts.SWindowCreate                 , @Consts.SWindowCreate                 , True);
  CopyResString(@NLConsts.SCannotFocus                  , @Consts.SCannotFocus                  , True);
  CopyResString(@NLConsts.SParentRequired               , @Consts.SParentRequired               , True);
  CopyResString(@NLConsts.SMDIChildNotVisible           , @Consts.SMDIChildNotVisible           , True);
  CopyResString(@NLConsts.SVisibleChanged               , @Consts.SVisibleChanged               , True);
  CopyResString(@NLConsts.SCannotShowModal              , @Consts.SCannotShowModal              , True);
  CopyResString(@NLConsts.SScrollBarRange               , @Consts.SScrollBarRange               , True);
  CopyResString(@NLConsts.SPropertyOutOfRange           , @Consts.SPropertyOutOfRange           , True);
  CopyResString(@NLConsts.SMenuIndexError               , @Consts.SMenuIndexError               , True);
  CopyResString(@NLConsts.SMenuReinserted               , @Consts.SMenuReinserted               , True);
  CopyResString(@NLConsts.SMenuNotFound                 , @Consts.SMenuNotFound                 , True);
  CopyResString(@NLConsts.SNoTimers                     , @Consts.SNoTimers                     , True);
  CopyResString(@NLConsts.SNotPrinting                  , @Consts.SNotPrinting                  , True);
  CopyResString(@NLConsts.SPrinting                     , @Consts.SPrinting                     , True);
  CopyResString(@NLConsts.SPrinterIndexError            , @Consts.SPrinterIndexError            , True);
  CopyResString(@NLConsts.SInvalidPrinter               , @Consts.SInvalidPrinter               , True);
  CopyResString(@NLConsts.SDeviceOnPort                 , @Consts.SDeviceOnPort                 , True);
  CopyResString(@NLConsts.SGroupIndexTooLow             , @Consts.SGroupIndexTooLow             , True);
  CopyResString(@NLConsts.STwoMDIForms                  , @Consts.STwoMDIForms                  , True);
  CopyResString(@NLConsts.SNoMDIForm                    , @Consts.SNoMDIForm                    , True);
  CopyResString(@NLConsts.SImageCanvasNeedsBitmap       , @Consts.SImageCanvasNeedsBitmap       , True);
  CopyResString(@NLConsts.SControlParentSetToSelf       , @Consts.SControlParentSetToSelf       , True);
  CopyResString(@NLConsts.SOKButton                     , @Consts.SOKButton                     , True);
  CopyResString(@NLConsts.SCancelButton                 , @Consts.SCancelButton                 , True);
  CopyResString(@NLConsts.SYesButton                    , @Consts.SYesButton                    , True);
  CopyResString(@NLConsts.SNoButton                     , @Consts.SNoButton                     , True);
  CopyResString(@NLConsts.SHelpButton                   , @Consts.SHelpButton                   , True);
  CopyResString(@NLConsts.SCloseButton                  , @Consts.SCloseButton                  , True);
  CopyResString(@NLConsts.SIgnoreButton                 , @Consts.SIgnoreButton                 , True);
  CopyResString(@NLConsts.SRetryButton                  , @Consts.SRetryButton                  , True);
  CopyResString(@NLConsts.SAbortButton                  , @Consts.SAbortButton                  , True);
  CopyResString(@NLConsts.SAllButton                    , @Consts.SAllButton                    , True);

  CopyResString(@NLConsts.SCannotDragForm               , @Consts.SCannotDragForm               , True);
  CopyResString(@NLConsts.SPutObjectError               , @Consts.SPutObjectError               , True);
  CopyResString(@NLConsts.SCardDLLNotLoaded             , @Consts.SCardDLLNotLoaded             , True);
  CopyResString(@NLConsts.SDuplicateCardId              , @Consts.SDuplicateCardId              , True);

  CopyResString(@NLConsts.SDdeErr                       , @Consts.SDdeErr                       , True);
  CopyResString(@NLConsts.SDdeConvErr                   , @Consts.SDdeConvErr                   , True);
  CopyResString(@NLConsts.SDdeMemErr                    , @Consts.SDdeMemErr                    , True);
  CopyResString(@NLConsts.SDdeNoConnect                 , @Consts.SDdeNoConnect                 , True);

  CopyResString(@NLConsts.SFB                           , @Consts.SFB                           , True);
  CopyResString(@NLConsts.SFG                           , @Consts.SFG                           , True);
  CopyResString(@NLConsts.SBG                           , @Consts.SBG                           , True);
  CopyResString(@NLConsts.SOldTShape                    , @Consts.SOldTShape                    , True);
  CopyResString(@NLConsts.SVMetafiles                   , @Consts.SVMetafiles                   , True);
  CopyResString(@NLConsts.SVEnhMetafiles                , @Consts.SVEnhMetafiles                , True);
  CopyResString(@NLConsts.SVIcons                       , @Consts.SVIcons                       , True);
  CopyResString(@NLConsts.SVBitmaps                     , @Consts.SVBitmaps                     , True);
  CopyResString(@NLConsts.SGridTooLarge                 , @Consts.SGridTooLarge                 , True);
  CopyResString(@NLConsts.STooManyDeleted               , @Consts.STooManyDeleted               , True);
  CopyResString(@NLConsts.SIndexOutOfRange              , @Consts.SIndexOutOfRange              , True);
  CopyResString(@NLConsts.SFixedColTooBig               , @Consts.SFixedColTooBig               , True);
  CopyResString(@NLConsts.SFixedRowTooBig               , @Consts.SFixedRowTooBig               , True);
  CopyResString(@NLConsts.SInvalidStringGridOp          , @Consts.SInvalidStringGridOp          , True);
  CopyResString(@NLConsts.SInvalidNumber                , @Consts.SInvalidNumber                , True);
  CopyResString(@NLConsts.SOutlineIndexError            , @Consts.SOutlineIndexError            , True);
  CopyResString(@NLConsts.SOutlineExpandError           , @Consts.SOutlineExpandError           , True);
  CopyResString(@NLConsts.SInvalidCurrentItem           , @Consts.SInvalidCurrentItem           , True);
  CopyResString(@NLConsts.SMaskErr                      , @Consts.SMaskErr                      , True);
  CopyResString(@NLConsts.SMaskEditErr                  , @Consts.SMaskEditErr                  , True);
  CopyResString(@NLConsts.SOutlineError                 , @Consts.SOutlineError                 , True);
  CopyResString(@NLConsts.SOutlineBadLevel              , @Consts.SOutlineBadLevel              , True);
  CopyResString(@NLConsts.SOutlineSelection             , @Consts.SOutlineSelection             , True);
  CopyResString(@NLConsts.SOutlineFileLoad              , @Consts.SOutlineFileLoad              , True);
  CopyResString(@NLConsts.SOutlineLongLine              , @Consts.SOutlineLongLine              , True);
  CopyResString(@NLConsts.SOutlineMaxLevels             , @Consts.SOutlineMaxLevels             , True);

  CopyResString(@NLConsts.SMsgDlgWarning                , @Consts.SMsgDlgWarning                , True);
  CopyResString(@NLConsts.SMsgDlgError                  , @Consts.SMsgDlgError                  , True);
  CopyResString(@NLConsts.SMsgDlgInformation            , @Consts.SMsgDlgInformation            , True);
  CopyResString(@NLConsts.SMsgDlgConfirm                , @Consts.SMsgDlgConfirm                , True);
  CopyResString(@NLConsts.SMsgDlgYes                    , @Consts.SMsgDlgYes                    , True);
  CopyResString(@NLConsts.SMsgDlgNo                     , @Consts.SMsgDlgNo                     , True);
  CopyResString(@NLConsts.SMsgDlgOK                     , @Consts.SMsgDlgOK                     , True);
  CopyResString(@NLConsts.SMsgDlgCancel                 , @Consts.SMsgDlgCancel                 , True);
  CopyResString(@NLConsts.SMsgDlgHelp                   , @Consts.SMsgDlgHelp                   , True);
  CopyResString(@NLConsts.SMsgDlgHelpNone               , @Consts.SMsgDlgHelpNone               , True);
  CopyResString(@NLConsts.SMsgDlgHelpHelp               , @Consts.SMsgDlgHelpHelp               , True);
  CopyResString(@NLConsts.SMsgDlgAbort                  , @Consts.SMsgDlgAbort                  , True);
  CopyResString(@NLConsts.SMsgDlgRetry                  , @Consts.SMsgDlgRetry                  , True);
  CopyResString(@NLConsts.SMsgDlgIgnore                 , @Consts.SMsgDlgIgnore                 , True);
  CopyResString(@NLConsts.SMsgDlgAll                    , @Consts.SMsgDlgAll                    , True);
  CopyResString(@NLConsts.SMsgDlgNoToAll                , @Consts.SMsgDlgNoToAll                , True);
  CopyResString(@NLConsts.SMsgDlgYesToAll               , @Consts.SMsgDlgYesToAll               , True);

  CopyResString(@NLConsts.SmkcBkSp                      , @Consts.SmkcBkSp                      , True);
  CopyResString(@NLConsts.SmkcTab                       , @Consts.SmkcTab                       , True);
  CopyResString(@NLConsts.SmkcEsc                       , @Consts.SmkcEsc                       , True);
  CopyResString(@NLConsts.SmkcEnter                     , @Consts.SmkcEnter                     , True);
  CopyResString(@NLConsts.SmkcSpace                     , @Consts.SmkcSpace                     , True);
  CopyResString(@NLConsts.SmkcPgUp                      , @Consts.SmkcPgUp                      , True);
  CopyResString(@NLConsts.SmkcPgDn                      , @Consts.SmkcPgDn                      , True);
  CopyResString(@NLConsts.SmkcEnd                       , @Consts.SmkcEnd                       , True);
  CopyResString(@NLConsts.SmkcHome                      , @Consts.SmkcHome                      , True);
  CopyResString(@NLConsts.SmkcLeft                      , @Consts.SmkcLeft                      , True);
  CopyResString(@NLConsts.SmkcUp                        , @Consts.SmkcUp                        , True);
  CopyResString(@NLConsts.SmkcRight                     , @Consts.SmkcRight                     , True);
  CopyResString(@NLConsts.SmkcDown                      , @Consts.SmkcDown                      , True);
  CopyResString(@NLConsts.SmkcIns                       , @Consts.SmkcIns                       , True);
  CopyResString(@NLConsts.SmkcDel                       , @Consts.SmkcDel                       , True);
  CopyResString(@NLConsts.SmkcShift                     , @Consts.SmkcShift                     , True);
  CopyResString(@NLConsts.SmkcCtrl                      , @Consts.SmkcCtrl                      , True);
  CopyResString(@NLConsts.SmkcAlt                       , @Consts.SmkcAlt                       , True);

  CopyResString(@NLConsts.SrUnknown                     , @Consts.SrUnknown                     , True);
  CopyResString(@NLConsts.SrNone                        , @Consts.SrNone                        , True);
  CopyResString(@NLConsts.SOutOfRange                   , @Consts.SOutOfRange                   , True);
{$ifndef d9up}
  CopyResString(@NLConsts.SCannotCreateName             , @Consts.SCannotCreateName             , True);
{$endif d9up}

  CopyResString(@NLConsts.SDateEncodeError              , @Consts.SDateEncodeError              , True);
  CopyResString(@NLConsts.SDefaultFilter                , @Consts.SDefaultFilter                , True);
  CopyResString(@NLConsts.SAllFilter                    , @Consts.SAllFilter                    , True);
  CopyResString(@NLConsts.SNoVolumeLabel                , @Consts.SNoVolumeLabel                , True);
  CopyResString(@NLConsts.SInsertLineError              , @Consts.SInsertLineError              , True);

  CopyResString(@NLConsts.SConfirmCreateDir             , @Consts.SConfirmCreateDir             , True);
  CopyResString(@NLConsts.SSelectDirCap                 , @Consts.SSelectDirCap                 , True);
  CopyResString(@NLConsts.SDirNameCap                   , @Consts.SDirNameCap                   , True);
  CopyResString(@NLConsts.SDrivesCap                    , @Consts.SDrivesCap                    , True);
  CopyResString(@NLConsts.SDirsCap                      , @Consts.SDirsCap                      , True);
  CopyResString(@NLConsts.SFilesCap                     , @Consts.SFilesCap                     , True);
  CopyResString(@NLConsts.SNetworkCap                   , @Consts.SNetworkCap                   , True);

  CopyResString(@NLConsts.SColorPrefix                  , @Consts.SColorPrefix                  , True);
  CopyResString(@NLConsts.SColorTags                    , @Consts.SColorTags                    , True);

  CopyResString(@NLConsts.SInvalidClipFmt               , @Consts.SInvalidClipFmt               , True);
  CopyResString(@NLConsts.SIconToClipboard              , @Consts.SIconToClipboard              , True);

  CopyResString(@NLConsts.SDefault                      , @Consts.SDefault                      , True);

  CopyResString(@NLConsts.SInvalidMemoSize              , @Consts.SInvalidMemoSize              , True);
  CopyResString(@NLConsts.SCustomColors                 , @Consts.SCustomColors                 , True);
  CopyResString(@NLConsts.SInvalidPrinterOp             , @Consts.SInvalidPrinterOp             , True);
  CopyResString(@NLConsts.SNoDefaultPrinter             , @Consts.SNoDefaultPrinter             , True);

  CopyResString(@NLConsts.SIniFileWriteError            , @Consts.SIniFileWriteError            , True);

  CopyResString(@NLConsts.SBitsIndexError               , @Consts.SBitsIndexError               , True);

  CopyResString(@NLConsts.SUntitled                     , @Consts.SUntitled                     , True);

  CopyResString(@NLConsts.SInvalidRegType               , @Consts.SInvalidRegType               , True);

  CopyResString(@NLConsts.SUnknownConversion            , @Consts.SUnknownConversion            , True);
  CopyResString(@NLConsts.SDuplicateMenus               , @Consts.SDuplicateMenus               , True);
end;

procedure UnhookResources;
begin
  RestoreResString(@Consts.SCantWriteResourceStreamError );
  RestoreResString(@Consts.SDuplicateReference           );
  RestoreResString(@Consts.SInvalidImage                 );
  RestoreResString(@Consts.SClassMismatch                );
  RestoreResString(@Consts.SInvalidTabIndex              );
  RestoreResString(@Consts.SInvalidBitmap                );
  RestoreResString(@Consts.SInvalidIcon                  );
  RestoreResString(@Consts.SInvalidMetafile              );
  RestoreResString(@Consts.SInvalidPixelFormat           );
  RestoreResString(@Consts.SBitmapEmpty                  );
  RestoreResString(@Consts.SScanLine                     );
  RestoreResString(@Consts.SChangeIconSize               );
  RestoreResString(@Consts.SOleGraphic                   );
  RestoreResString(@Consts.SUnknownExtension             );
  RestoreResString(@Consts.SUnknownClipboardFormat       );
  RestoreResString(@Consts.SOutOfResources               );
  RestoreResString(@Consts.SNoCanvasHandle               );
  RestoreResString(@Consts.SInvalidImageSize             );
  RestoreResString(@Consts.STooManyImages                );
  RestoreResString(@Consts.SDimsDoNotMatch               );
  RestoreResString(@Consts.SInvalidImageList             );
  RestoreResString(@Consts.SReplaceImage                 );
  RestoreResString(@Consts.SImageIndexError              );
  RestoreResString(@Consts.SImageReadFail                );
  RestoreResString(@Consts.SImageWriteFail               );
  RestoreResString(@Consts.SWindowDCError                );
  RestoreResString(@Consts.SClientNotSet                 );
  RestoreResString(@Consts.SWindowClass                  );
  RestoreResString(@Consts.SWindowCreate                 );
  RestoreResString(@Consts.SCannotFocus                  );
  RestoreResString(@Consts.SParentRequired               );
  RestoreResString(@Consts.SMDIChildNotVisible           );
  RestoreResString(@Consts.SVisibleChanged               );
  RestoreResString(@Consts.SCannotShowModal              );
  RestoreResString(@Consts.SScrollBarRange               );
  RestoreResString(@Consts.SPropertyOutOfRange           );
  RestoreResString(@Consts.SMenuIndexError               );
  RestoreResString(@Consts.SMenuReinserted               );
  RestoreResString(@Consts.SMenuNotFound                 );
  RestoreResString(@Consts.SNoTimers                     );
  RestoreResString(@Consts.SNotPrinting                  );
  RestoreResString(@Consts.SPrinting                     );
  RestoreResString(@Consts.SPrinterIndexError            );
  RestoreResString(@Consts.SInvalidPrinter               );
  RestoreResString(@Consts.SDeviceOnPort                 );
  RestoreResString(@Consts.SGroupIndexTooLow             );
  RestoreResString(@Consts.STwoMDIForms                  );
  RestoreResString(@Consts.SNoMDIForm                    );
  RestoreResString(@Consts.SImageCanvasNeedsBitmap       );
  RestoreResString(@Consts.SControlParentSetToSelf       );
  RestoreResString(@Consts.SOKButton                     );
  RestoreResString(@Consts.SCancelButton                 );
  RestoreResString(@Consts.SYesButton                    );
  RestoreResString(@Consts.SNoButton                     );
  RestoreResString(@Consts.SHelpButton                   );
  RestoreResString(@Consts.SCloseButton                  );
  RestoreResString(@Consts.SIgnoreButton                 );
  RestoreResString(@Consts.SRetryButton                  );
  RestoreResString(@Consts.SAbortButton                  );
  RestoreResString(@Consts.SAllButton                    );

  RestoreResString(@Consts.SCannotDragForm               );
  RestoreResString(@Consts.SPutObjectError               );
  RestoreResString(@Consts.SCardDLLNotLoaded             );
  RestoreResString(@Consts.SDuplicateCardId              );

  RestoreResString(@Consts.SDdeErr                       );
  RestoreResString(@Consts.SDdeConvErr                   );
  RestoreResString(@Consts.SDdeMemErr                    );
  RestoreResString(@Consts.SDdeNoConnect                 );

  RestoreResString(@Consts.SFB                           );
  RestoreResString(@Consts.SFG                           );
  RestoreResString(@Consts.SBG                           );
  RestoreResString(@Consts.SOldTShape                    );
  RestoreResString(@Consts.SVMetafiles                   );
  RestoreResString(@Consts.SVEnhMetafiles                );
  RestoreResString(@Consts.SVIcons                       );
  RestoreResString(@Consts.SVBitmaps                     );
  RestoreResString(@Consts.SGridTooLarge                 );
  RestoreResString(@Consts.STooManyDeleted               );
  RestoreResString(@Consts.SIndexOutOfRange              );
  RestoreResString(@Consts.SFixedColTooBig               );
  RestoreResString(@Consts.SFixedRowTooBig               );
  RestoreResString(@Consts.SInvalidStringGridOp          );
  RestoreResString(@Consts.SInvalidNumber                );
  RestoreResString(@Consts.SOutlineIndexError            );
  RestoreResString(@Consts.SOutlineExpandError           );
  RestoreResString(@Consts.SInvalidCurrentItem           );
  RestoreResString(@Consts.SMaskErr                      );
  RestoreResString(@Consts.SMaskEditErr                  );
  RestoreResString(@Consts.SOutlineError                 );
  RestoreResString(@Consts.SOutlineBadLevel              );
  RestoreResString(@Consts.SOutlineSelection             );
  RestoreResString(@Consts.SOutlineFileLoad              );
  RestoreResString(@Consts.SOutlineLongLine              );
  RestoreResString(@Consts.SOutlineMaxLevels             );

  RestoreResString(@Consts.SMsgDlgWarning                );
  RestoreResString(@Consts.SMsgDlgError                  );
  RestoreResString(@Consts.SMsgDlgInformation            );
  RestoreResString(@Consts.SMsgDlgConfirm                );
  RestoreResString(@Consts.SMsgDlgYes                    );
  RestoreResString(@Consts.SMsgDlgNo                     );
  RestoreResString(@Consts.SMsgDlgOK                     );
  RestoreResString(@Consts.SMsgDlgCancel                 );
  RestoreResString(@Consts.SMsgDlgHelp                   );
  RestoreResString(@Consts.SMsgDlgHelpNone               );
  RestoreResString(@Consts.SMsgDlgHelpHelp               );
  RestoreResString(@Consts.SMsgDlgAbort                  );
  RestoreResString(@Consts.SMsgDlgRetry                  );
  RestoreResString(@Consts.SMsgDlgIgnore                 );
  RestoreResString(@Consts.SMsgDlgAll                    );
  RestoreResString(@Consts.SMsgDlgNoToAll                );
  RestoreResString(@Consts.SMsgDlgYesToAll               );

  RestoreResString(@Consts.SmkcBkSp                      );
  RestoreResString(@Consts.SmkcTab                       );
  RestoreResString(@Consts.SmkcEsc                       );
  RestoreResString(@Consts.SmkcEnter                     );
  RestoreResString(@Consts.SmkcSpace                     );
  RestoreResString(@Consts.SmkcPgUp                      );
  RestoreResString(@Consts.SmkcPgDn                      );
  RestoreResString(@Consts.SmkcEnd                       );
  RestoreResString(@Consts.SmkcHome                      );
  RestoreResString(@Consts.SmkcLeft                      );
  RestoreResString(@Consts.SmkcUp                        );
  RestoreResString(@Consts.SmkcRight                     );
  RestoreResString(@Consts.SmkcDown                      );
  RestoreResString(@Consts.SmkcIns                       );
  RestoreResString(@Consts.SmkcDel                       );
  RestoreResString(@Consts.SmkcShift                     );
  RestoreResString(@Consts.SmkcCtrl                      );
  RestoreResString(@Consts.SmkcAlt                       );

  RestoreResString(@Consts.SrUnknown                     );
  RestoreResString(@Consts.SrNone                        );
  RestoreResString(@Consts.SOutOfRange                   );
{$ifndef d9up}
  RestoreResString(@Consts.SCannotCreateName             );
{$endif d9up}

  RestoreResString(@Consts.SDateEncodeError              );
  RestoreResString(@Consts.SDefaultFilter                );
  RestoreResString(@Consts.SAllFilter                    );
  RestoreResString(@Consts.SNoVolumeLabel                );
  RestoreResString(@Consts.SInsertLineError              );

  RestoreResString(@Consts.SConfirmCreateDir             );
  RestoreResString(@Consts.SSelectDirCap                 );

  RestoreResString(@Consts.SDirNameCap                   );
  RestoreResString(@Consts.SDrivesCap                    );
  RestoreResString(@Consts.SDirsCap                      );
  RestoreResString(@Consts.SFilesCap                     );
  RestoreResString(@Consts.SNetworkCap                   );
  RestoreResString(@Consts.SNetworkCap                   );

  RestoreResString(@Consts.SColorPrefix                  );
  RestoreResString(@Consts.SColorTags                    );

  RestoreResString(@Consts.SInvalidClipFmt               );
  RestoreResString(@Consts.SIconToClipboard              );

  RestoreResString(@Consts.SDefault                      );

  RestoreResString(@Consts.SInvalidMemoSize              );
  RestoreResString(@Consts.SCustomColors                 );
  RestoreResString(@Consts.SInvalidPrinterOp             );
  RestoreResString(@Consts.SNoDefaultPrinter             );

  RestoreResString(@Consts.SIniFileWriteError            );

  RestoreResString(@Consts.SBitsIndexError               );

  RestoreResString(@Consts.SUntitled                     );

  RestoreResString(@Consts.SInvalidRegType               );

  RestoreResString(@Consts.SUnknownConversion            );
  RestoreResString(@Consts.SDuplicateMenus               );
end;

initialization
  HookResources;
finalization
  UnhookResources;
end.
