{ lib
, buildPythonPackage
, dictdiffer
, diskcache
, dvc-objects
, fetchFromGitHub
, funcy
, pygtrie
, pythonOlder
, setuptools-scm
, shortuuid
, sqltrie
}:

buildPythonPackage rec {
  pname = "dvc-data";
  version = "2.23.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = "dvc-data";
    rev = "refs/tags/${version}";
    hash = "sha256-UsWMlwG1g59I+TIn1uwp6vyzVIBtj1lfchp+3SYognc=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    dictdiffer
    diskcache
    dvc-objects
    funcy
    pygtrie
    shortuuid
    sqltrie
  ];

  # Tests depend on upath which is unmaintained and only available as wheel
  doCheck = false;

  pythonImportsCheck = [
    "dvc_data"
  ];

  meta = with lib; {
    description = "DVC's data management subsystem";
    homepage = "https://github.com/iterative/dvc-data";
    changelog = "https://github.com/iterative/dvc-data/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
