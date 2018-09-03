#tag Module
Protected Module Roo
	#tag Method, Flags = &h0
		Function DoubleToString(d as Double) As String
		  ' Converts a Double to a String. Used for prettier printing of Doubles that are Integers.
		  
		  if d.IsInteger then
		    dim i as Integer = d
		    return Str(i)
		  else
		    return Str(d)
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInteger(extends d as Double) As Boolean
		  return if(Round(d) = d, True, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RooPath(Extends f As FolderItem) As String
		  ' Returns this FolderItem's path as a Roo path. A Roo path is essentially a UNIX path.
		  
		  Dim path As String
		  
		  Dim tmp As New FolderItem(f.NativePath, FolderItem.PathTypeNative)
		  
		  Do
		    If tmp.Parent <> Nil Then
		      path = "/" + tmp.Name + path
		      tmp = tmp.Parent
		    Else
		      Exit
		    End If
		  Loop
		  
		  Return path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RooPathToFolderItem(rooPath As String, baseFile As FolderItem) As FolderItem
		  ' Takes a file Roo file path and returns it as a FolderItem or Nil if it's not possible to derive a 
		  ' valid FolderItem.
		  ' File paths in Roo are separated by forward slashes `/`
		  ' `../` moves up the hierarchy to the parent
		  ' If a path starts with a `/` it is absolute, otherwise it is taken to be relative to `baseFile`.
		  
		  ' An empty path refers to the base file.
		  If rooPath = "" Then Return baseFile
		  
		  ' Remove any superfluous trailing slash.
		  If rooPath.Right(1) = "/" Then rooPath = rooPath.Left(rooPath.Len - 1)
		  
		  ' Is this an absolute path? If so it will begin with `/`.
		  Dim absolute As Boolean = False
		  If rooPath.Left(1) = "/" Then
		    absolute = True
		    rooPath = rooPath.Right(rooPath.Len - 1)
		  End If
		  
		  ' Split the path into it's constituent parts.
		  Dim chars() As String = rooPath.Split("")
		  Dim char, part, parts() As String
		  For Each char In chars
		    If char = "/" Then
		      parts.Append(part)
		      part = ""
		    Else
		      part = part + char
		    End if
		  Next char
		  If char <> "/" Then parts.Append(part)
		  
		  ' Get a FolderItem pointing to root
		  Dim root As FolderItem = App.ExecutableFile.Parent
		  Do
		    if root.Parent = Nil Then Exit
		    root = root.Parent
		  Loop
		  
		  Dim result As FolderItem
		  
		  ' Handle absolute paths.
		  If absolute Then
		    result = New FolderItem(root.NativePath, FolderItem.PathTypeNative)
		    for Each part In parts
		      If part = ".." Then
		        Try
		          result = result.Parent
		        Catch err
		          Return Nil
		        End Try
		      Else
		        Try
		          result = result.Child(part)
		        Catch err
		          Return Nil
		        End Try
		      End If
		    Next part
		    Return result
		  End If
		  
		  ' Handle relative paths.
		  If baseFile = Nil Then
		    result = App.ExecutableFile.Parent
		  ElseIf Not baseFile.Directory Then ' Use this file's parent folder as our starting point.
		    result = New FolderItem(baseFile.Parent.NativePath, FolderItem.PathTypeNative)
		  Else
		    result = New FolderItem(baseFile.NativePath, FolderItem.PathTypeNative)
		  End If
		  for Each part In parts
		    If part = ".." Then
		      Try
		        result = result.Parent
		      Catch err
		        Return Nil
		      End Try
		    Else
		      Try
		        result = result.Child(part)
		      Catch err
		        Return Nil
		      End Try
		    End If
		  Next part
		  Return result
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToBoolean(extends s as String) As Boolean
		  return if(s = "True", True, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger(extends d as Double) As Integer
		  return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(extends b as Boolean) As String
		  return if(b = True, "True", "False")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VariantType(v as Variant) As String
		  ' A more robust implementation of Variant.StringValue().
		  
		  if v = Nil then return "Nil"
		  if v isA BooleanObject then return "Boolean object"
		  if v isA NumberObject then return "Number object"
		  if v isA TextObject then return "Text object"
		  if v isA NothingObject then return "Nothing"
		  if v isA RooClass then return RooClass(v).name + " class"
		  if v isA RooFunction then return RooFunction(v).ToText
		  if v isA RooInstance then return RooInstance(v).ToText
		  
		  dim info as Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(v)
		  return info.Name
		  
		  exception err
		    return "Cannot determine variant type."
		End Function
	#tag EndMethod


	#tag Constant, Name = VERSION_BUG, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VERSION_MAJOR, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VERSION_MINOR, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant


	#tag Enum, Name = TokenType, Type = Integer, Flags = &h0
		AND_KEYWORD
		  ARROW
		  BANG
		  BOOLEAN
		  BREAK_KEYWORD
		  CARET
		  CLASS_KEYWORD
		  COLON
		  COMMA
		  DOT
		  ELSE_KEYWORD
		  EQUAL
		  EQUAL_EQUAL
		  EOF
		  ERROR
		  FOR_KEYWORD
		  FUNCTION_KEYWORD
		  GREATER
		  GREATER_EQUAL
		  IDENTIFIER
		  IF_KEYWORD
		  LCURLY
		  LESS
		  LESS_EQUAL
		  LPAREN
		  LSQUARE
		  MINUS
		  MINUS_EQUAL
		  MINUS_MINUS
		  MODULE_KEYWORD
		  NEWLINE
		  NOT_EQUAL
		  NOT_KEYWORD
		  NOTHING
		  NUMBER
		  OR_KEYWORD
		  PERCENT
		  PERCENT_EQUAL
		  PIPE
		  PLUS
		  PLUS_EQUAL
		  PLUS_PLUS
		  QUERY
		  QUIT_KEYWORD
		  RCURLY
		  REGEX
		  REQUIRE_KEYWORD
		  RETURN_KEYWORD
		  RPAREN
		  RSQUARE
		  SELF_KEYWORD
		  SEMICOLON
		  SLASH
		  SLASH_EQUAL
		  STAR_EQUAL
		  STAR
		  STATIC_KEYWORD
		  SUPER_KEYWORD
		  TEXT
		  VAR
		WHILE_KEYWORD
	#tag EndEnum

	#tag Using, Name = Roo.Expressions
	#tag EndUsing

	#tag Using, Name = Roo.Native.Functions
	#tag EndUsing

	#tag Using, Name = Roo.Native.Modules
	#tag EndUsing

	#tag Using, Name = Roo.Objects
	#tag EndUsing

	#tag Using, Name = Roo.Statements
	#tag EndUsing


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
