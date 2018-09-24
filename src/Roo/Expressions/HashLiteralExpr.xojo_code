#tag Class
Protected Class HashLiteralExpr
Inherits Expr
	#tag Method, Flags = &h0
		Function Accept(visitor as ExprVisitor) As Variant
		  return visitor.VisitHashLiteralExpr(self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(keyValues() as Roo.KeyValuePair)
		  self.map = new VariantToVariantHashMapMBS
		  
		  for each kvp as Roo.KeyValuePair in keyValues
		    
		    self.map.Value(kvp.key) = kvp.value
		    
		  next kvp
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		map As VariantToVariantHashMapMBS
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
			Name="name"
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
	#tag EndViewBehavior
End Class
#tag EndClass
