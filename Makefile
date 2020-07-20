input = src/Main.elm

bundle.js : $(input)
	elm make $(input) --optimize --output=bundle.js

.PHONY : clean build cleanall

clean : 
	rm bundle.js

build : bundle.js
	uglifyjs bundle.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle -o bundle.min.js && sed -i "s/bundle.js/bundle.min.js/g" index.html

cleanall:
	rm *.js && sed -i "s/bundle.min.js/bundle.js/g" index.html
