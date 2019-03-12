#tag Class
Protected Class RooBooleanLiteralExpr
Inherits RooExpr
	#tag Method, Flags = &h0
		Function Accept(visitor As RooExprVisitor) As Variant
		  Return visitor.VisitBooleanLiteralExpr(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(value As Boolean)
		  Self.Value = value
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Value As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
