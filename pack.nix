{lib, buildPythonPackage, pytestCheckHook, numpy, pip }:

buildPythonPackage rec {
    pname = "filtc";
    version = "0.0.1"; 
    src = ./.;
    format = "pyproject";
    checkInputs = [ pytestCheckHook ];
    buildInputs = [pip]; 
    propagatedBuildInputs  = [ numpy ];
    meta = with lib; {
    };
}
