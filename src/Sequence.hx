package;

@:enum abstract SeqType(Int) {
	var MSG = 0;
	var FUNC = 1;
}

@:forward
abstract Sequence(Array < { type:SeqType, data: Dynamic } > ) {
	
	public inline function new() this = [];
	
	public inline function push(type:SeqType, data:Dynamic) {
		this.push( { type: type, data:data } );
	}
	
}