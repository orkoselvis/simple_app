
[1mFrom:[0m /home/orkos/Desktop/search_task/app/concepts/search/operation/show.rb @ line 24 Search::Operation::Show#main_search:

    [1;34m16[0m: [32mdef[0m [1;34mmain_search[0m(ctx, _options)
    [1;34m17[0m:   search_word = ctx[[33m:params[0m].downcase
    [1;34m18[0m:   ctx[[33m:words[0m] = []
    [1;34m19[0m:   [1;34;4mJSON_FILE[0m.each [32mdo[0m |line|
    [1;34m20[0m:     ctx[[33m:words[0m] << line [32mif[0m line.values.map(&[33m:downcase[0m).grep([1;34;4mRegexp[0m.new(search_word)).any? ||
    [1;34m21[0m:                            line.values.map(&[33m:downcase[0m).grep([1;34;4mRegexp[0m.new(reverse_string(search_word))).any?
    [1;34m22[0m:   [32mend[0m
    [1;34m23[0m:   p ctx[[33m:words[0m]
 => [1;34m24[0m:   binding.pry
    [1;34m25[0m: [32mend[0m

