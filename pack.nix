{lib, buildPythonPackage, pytestCheckHook, numpy, pip, setuptools, typing-extensions, pythonOlder }:

buildPythonPackage rec {
    pname = "filtc";
    version = "0.0.1"; 
    disabled = pythonOlder "3.10";
    src = ./.;
    format = "pyproject";
    checkInputs = [ pytestCheckHook ];
    buildInputs = [pip setuptools]; 
    propagatedBuildInputs  = [ numpy typing-extensions ];
    meta = with lib; {
    };
}
