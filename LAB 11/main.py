from ranges import *
import json

def compute_fuzzy_time(fuzz_vol, fuzz_dirt):
    expert_rule = {
        (Dirtiness.VD, Volume.FL) : WashingTime.VLOT,
        (Dirtiness.MD, Volume.ML) : WashingTime.MT,
        (Dirtiness.LD, Volume.LL) : WashingTime.LIT,
        (Dirtiness.ND, Volume.FL) : WashingTime.LIT,
        (Dirtiness.VD, Volume.ML) : WashingTime.VLOT,
        (Dirtiness.MD, Volume.LL) : WashingTime.LOT,
        (Dirtiness.LD, Volume.FL) : WashingTime.LOT,
        (Dirtiness.ND, Volume.ML) : WashingTime.LIT,
        (Dirtiness.VD, Volume.LL) : WashingTime.LOT,
        (Dirtiness.MD, Volume.FL) : WashingTime.VLOT,
        (Dirtiness.LD, Volume.ML) : WashingTime.MT,
        (Dirtiness.ND, Volume.LL) : WashingTime.LIT
    }
    
    fuzzy_input_param = ( fuzz_dirt, fuzz_vol)
    fuzzy_output = expert_rule.get(fuzzy_input_param, None)
    
    if fuzzy_output is None:
        raise Exception(f"case not covered for volume : {fuzz_vol} and dirt : {fuzz_dirt}")
    else:
        return [fuzzy_output, (fuzz_dirt,fuzz_vol)]
    
    
def computing_washing_parameters(volume, dirt_level):
    if volume<0 or volume>15:
        raise Exception(f"volume range out of expected range")
    if dirt_level<0 or dirt_level>10:
        raise Exception(f"dirt level out of expected range")
    
    fuzzy_volume = fuzzify_volume(volume)
    fuzzy_dirt = fuzzify_dirtiness(dirt_level)

    fuzzy_time_required = compute_fuzzy_time(fuzzy_volume, fuzzy_dirt)[0]
    param = compute_fuzzy_time(fuzzy_volume, fuzzy_dirt)[1]
    time_required = defuzzify(fuzzy_time_required)
    
    return f"time required on the basis of input is : {time_required} \non the basis of rule : (dirt : {param[0]}, vol : {param[1]}) -> time : {fuzzy_time_required}"


if __name__ == "__main__":
    volume_weight = float(input("enter weight as volume [0-15] : "))
    dirt_level = float(input("enter dirt level [0-10] : "))
    expected_time = computing_washing_parameters(volume_weight, dirt_level)
    print(expected_time)
    
