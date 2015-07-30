package utils 
{
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class NapoleonArray 
	{
		private var _dataArray : Array = []; //bevat alle data
		private var _nameOfDataArray : Array = []; // bevat de namen waarmee je de data kan aanroepen.
		
		public function NapoleonArray() 
		{
			
		}
		
		public function add(data : * , name : String) :void {
			if (!checkNameInUse(name)) {
				_dataArray.push(data);
				_nameOfDataArray.push(name);
			}else {
				throw new Error("Name " + name + " already in array!"); 
			}
		}
		//USE DATA TO GET DATA
		public function getDataFromIndex(index : int) : * {
			var result : * = null;
			if (_dataArray.length < index || index >= 0) {
				result = _dataArray[index];
			}else {
				throw new Error("Index out of bound!"); 
			}
			return result;
		}
		public function getNameFromIndex(index : int) : String {
			var result : String = null;
			if (_nameOfDataArray.length < index || index >= 0) {
				result = _nameOfDataArray[index];
			}else {
				throw new Error("Index out of bound!"); 
			}
			return result;
		}
		
		//USE NAME TO DATA
		public function deleteWithName(name : String) : void {
			if(checkNameInUse(name)){
				var index : int = _nameOfDataArray.indexOf(name);
				_dataArray.splice(index, 1);
				_nameOfDataArray.splice(index, 1);
			}
		}
		public function deleteWithIndex(index : int) :void {
			if (_dataArray.length < index && index >= 0) {
				_dataArray.splice(index, 1);
				_nameOfDataArray.splice(index, 1);
			}else {
				throw new Error("Index out of bound!"); 
			}
		}
		public function getDataWithName(name : String) : * {
			
			var result : * = null;
			if(checkNameInUse(name)){
				var index : int = _nameOfDataArray.indexOf(name);
				result = _dataArray[index];
			}
			return result;
		}
		// REST
		public function empty() :void {
			_dataArray = [];
			_nameOfDataArray = [];
		}
		public function getLength(): int {
			return _dataArray.length;
		}
		public function checkNameInUse(name : String) :Boolean {
			var result : Boolean = false;
			var lN : int = _nameOfDataArray.length;
			for (var i : int = lN - 1; i >= 0; i--) {
				if (_nameOfDataArray[i] === name) {
					result = true;
					break;
				}
			}
			return result;
		}
	}
}