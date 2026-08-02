extends Object
class_name RandomUtils

static func make_random_generator(seed: int = 0) -> RandomNumberGenerator:
	var randr = RandomNumberGenerator.new()
	if seed != 0:
		randr.seed = seed
	else:
		randr.randomize()
	return randr
