String data = /%RASMUSSEN^THOMAS BREGENTVED       ]L\KKE ALLE 7 3 314B              4615000?;9208100401017023451041173083461010814?/

def parse(String str) {
    def names = str[1..34].trim().tokenize('^')
    def fields = [
        // Track 1
        firstname    : names[1],
        lastname     : names[0],
        address      : translate(str[35..68].trim()),
        // http://bbr.dk/kommunekode/0/30
        municipal    : str[69..71].trim(),
        postalcode   : str[72..75].trim(),
        // Track 2
        cardtype     : str[78].trim(),
        // https://da.wikipedia.org/wiki/ISO_3166-1
        nationality  : str[79..81].trim(),
        application  : str[82..83].trim(),
        issuer       : str[83..85].trim(),
        cpr          : str[86..95].trim(),
        group        : str[96].trim(),
        // https://www.medcom.dk/opslag/koder-tabeller-ydere/yderelokationsnumre/laegepraksis-i-danmark
        doctor       : str[97..102].trim(),
        // https://da.wikipedia.org/wiki/ISO_3166-2:DK
        region       : str[103..105].trim(),
        municipal2   : str[106..108].trim(),
        date         : str[109..114].trim()
    ]
}

def translate(String str, String enc = 'da') {
    String out = ''
    // https://en.wikipedia.org/wiki/National_Replacement_Character_Set
    def table = [
        ascii : ['#', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~'],
        da    : ['#', 'Ä', 'Æ', 'Ø', 'Å', 'Ü', '_', 'ä', 'æ', 'ø', 'å', 'ü', null]
    ]
    def tr = {x -> table['ascii'].findIndexOf { elm -> elm == x}}
    str.each {
        out += table[enc][tr(it)] ?: it
    }
    return out
}


/*
 * Test parser...
 */

def fields = parse(data)

println "Fornavne:\t\t"         + fields.firstname
println "Efternavn:\t\t"        + fields.lastname
println "Adresse:\t\t"          + fields.address
println "Bopælskommune:\t\t"    + fields.municipal
println "Postnummer:\t\t"       + fields.postalcode
println "Korttype:\t\t"         + fields.cardtype
println "Nationalitet:\t\t"     + fields.nationality
println "Anvendelsesområde:\t"  + fields.application
println "Kortudsteder:\t\t"     + fields.issuer
println "Personnummer:\t\t"     + fields.cpr
println "Sikringsgruppe:\t\t"   + fields.group
println "Lægens ydernummer:\t"  + fields.doctor
println "Regionsnummer:\t\t"    + fields.region
println "Kommunenummer:\t\t"    + fields.municipal2
println "Gyldig fra:\t\t"       + fields.date
