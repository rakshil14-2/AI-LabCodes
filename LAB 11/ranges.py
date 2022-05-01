class Volume:
    """fl:full, ml:medium, ll:low"""
    FL = "full"
    ML = "medium"
    LL = "low"
    
    
class Dirtiness:
    """vd:very, md:medium, ld:ligtly, nd:not """
    VD = "very"
    MD = "medium"
    LD = "lightly"
    ND = "not"
    
    
class WashingTime:
    """vlot: very long, lot: long, md: medium, lit: little """
    VLOT = "very long"
    LOT = "long"
    MT = "medium"
    LIT = "little"
    
def fuzzify_volume(val) : 
    if val<= 3.5 :
        return Volume.LL
    elif val>=3.6 and val<6.5:
        return Volume.ML
    else:
        return Volume.FL
    

def fuzzify_dirtiness(val):
    """we are assuming dirt level to be between 0 and 10 """
    if val <=0.5:
        return Dirtiness.ND
    elif val>0.5 and val<=2:
        return Dirtiness.LD 
    elif val>2 and val<=6:
        return Dirtiness.MD
    else:
        return Dirtiness.VD
    
def defuzzify(val):
    if val==WashingTime.VLOT:
        return 40
    elif val==WashingTime.LOT:
        return 30
    elif val==WashingTime.MT:
        return 20
    else:
        return 8
    
    
    
    