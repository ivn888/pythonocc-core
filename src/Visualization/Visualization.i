/*
##Copyright 2008-2016 Thomas Paviot (tpaviot@gmail.com)
##
##This file is part of pythonOCC.
##
##pythonOCC is free software: you can redistribute it and/or modify
##it under the terms of the GNU Lesser General Public License as published by
##the Free Software Foundation, either version 3 of the License, or
##(at your option) any later version.
##
##pythonOCC is distributed in the hope that it will be useful,
##but WITHOUT ANY WARRANTY; without even the implied warranty of
##MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##GNU General Public License for more details.
##
##You should have received a copy of the GNU Lesser General Public License
##along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.
*/
%module Visualization;

%{
#include <Visualization.h>
#include <Tesselator.h>
#include <Standard.hxx>
%}

%include ../SWIG_files/common/ExceptionCatcher.i
%include "python/std_string.i"
%include "typemaps.i"

%typemap(out) float [ANY] {
  int i;
  $result = PyList_New($1_dim0);
  for (i = 0; i < $1_dim0; i++) {
    PyObject *o = PyFloat_FromFloat((float) $1[i]);
    PyList_SetItem($result,i,o);
  }
}

enum theTextureMappingRule {
	atCube,
	atNormal,
	atNormalAutoScale
	};

%apply int& OUTPUT {int& v1, int& v2, int& v3}
%apply float& OUTPUT {float& x, float& y, float& z}

class Tesselator {
 public:
    Tesselator(TopoDS_Shape aShape,
               theTextureMappingRule aTxtMapType,
               float anAutoScaleSizeOnU,
               float anAutoScaleSizeOnV,
               float aDeviation,
               float aUOrigin,
               float aVOrigin,
               float aURepeat,
               float aVRepeat,
               float aScaleU,
               float aScaleV,
               float aRotationAngle);
    Tesselator(TopoDS_Shape aShape);
    %feature("kwargs") Compute;
    void Compute(bool uv_coords=true, bool compute_edges=false, float mesh_quality=1.0);
    void GetVertex(int ivert, float& x, float& y, float& z);
    void GetNormal(int inorm, float& x, float& y, float& z);
    void GetTriangleIndex(int triangleIdx, int& v1, int& v2, int& v3);
    void GetEdgeVertex(int iEdge, int ivert, float& x, float& y, float& z);
	float* VerticesList();
	int ObjGetTriangleCount();
	int ObjGetVertexCount();
	int ObjGetNormalCount();
	int ObjGetEdgeCount();
	int ObjEdgeGetVertexCount(int iEdge);
    std::string ExportShapeToX3DIndexedFaceSet();
	std::string ExportShapeToThreejsJSONString(char *shape_function_name, bool export_uv=false);
	%feature("kwargs") ExportShapeToX3D;
	void ExportShapeToX3D(char *filename, int diffR=1, int diffG=0, int diffB=0);
};

class Display3d {
 public:
	%feature("autodoc", "1");
	Display3d();
	%feature("autodoc", "1");
	~Display3d();
	%feature("autodoc", "1");
	void Init(const long handle);
	%feature("autodoc", "1");
	void SetAnaglyphMode(int mode);
	%feature("autodoc", "1");
	void ChangeRenderingParams(int  Method,
                               int  RaytracingDepth,
                               bool IsShadowEnabled,
                               bool IsReflectionEnabled,
                               bool IsAntialiasingEnabled,
                               bool IsTransparentShadowEnabled,
                               int  StereoMode,
                               int  AnaglyphFilter,
                               bool ToReverseStere);
    %feature("autodoc", "1");
    void SetVBBO();
    %feature("autodoc", "1");
    void UnsetVBBO();                               
	%feature("autodoc", "1");
	Handle_V3d_View& GetView();
	%feature("autodoc", "1");
	Handle_V3d_Viewer& GetViewer();
	%feature("autodoc", "1");
	Handle_AIS_InteractiveContext GetContext();
	%feature("autodoc", "1");
	void Test();
};

