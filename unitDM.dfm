object DM: TDM
  Height = 480
  Width = 640
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=estoque'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 56
  end
  object tbProdutos: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = Conexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'estoque.produtos'
    Left = 136
    Top = 56
    object tbProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object tbProdutosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
    object tbProdutosfabricante: TStringField
      FieldName = 'fabricante'
      Origin = 'fabricante'
      Required = True
      Size = 30
    end
    object tbProdutosvalidade: TDateField
      FieldName = 'validade'
      Origin = 'validade'
      Required = True
      EditMask = '##/##/####;1;_'
    end
    object tbProdutosestoqueAtual: TIntegerField
      FieldName = 'estoqueAtual'
      Origin = 'estoqueAtual'
    end
  end
  object dsProdutos: TDataSource
    DataSet = tbProdutos
    Left = 136
    Top = 152
  end
  object tbMovimentacoes: TFDTable
    Active = True
    BeforeDelete = tbMovimentacoesBeforeDelete
    AfterScroll = tbMovimentacoesAfterScroll
    IndexFieldNames = 'id'
    Connection = Conexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'estoque.movimentacoes'
    Left = 224
    Top = 56
  end
  object tbMovProdutos: TFDTable
    Active = True
    AfterPost = tbMovProdutosAfterPost
    BeforeDelete = tbMovProdutosBeforeDelete
    AfterDelete = tbMovProdutosAfterDelete
    IndexName = 'idMovimentacoes'
    MasterSource = dsMovimentacoes
    MasterFields = 'id'
    Connection = Conexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'estoque.movimentacoes_produtos'
    Left = 336
    Top = 56
    object tbMovProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object tbMovProdutosidMovimentacoes: TIntegerField
      FieldName = 'idMovimentacoes'
      Origin = 'idMovimentacoes'
      Required = True
    end
    object tbMovProdutosidProdutos: TIntegerField
      FieldName = 'idProdutos'
      Origin = 'idProdutos'
      Required = True
    end
    object tbMovProdutosquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object tbMovProdutosnomeProduto: TStringField
      FieldKind = fkLookup
      FieldName = 'nomeProduto'
      LookupDataSet = tbProdutos
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'idProdutos'
      Size = 50
      Lookup = True
    end
  end
  object dsMovimentacoes: TDataSource
    DataSet = tbMovimentacoes
    Left = 232
    Top = 152
  end
  object dsMovProdutos: TDataSource
    DataSet = tbMovProdutos
    Left = 336
    Top = 152
  end
  object sqlAumentaEstoque: TFDCommand
    Connection = Conexao
    CommandText.Strings = (
      
        'UPDATE produtos SET estoqueAtual = estoqueAtual + pQtd WHERE id ' +
        '= pId')
    Left = 56
    Top = 280
  end
  object sqlDiminuiEstoque: TFDCommand
    Connection = Conexao
    CommandText.Strings = (
      
        'UPDATE produtos SET estoqueAtual = estoqueAtual - pQtd WHERE id ' +
        '= pId')
    Left = 56
    Top = 376
  end
  object sqlMovimentacoes: TFDQuery
    Active = True
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM movimentacoes')
    Left = 288
    Top = 288
    ParamData = <
      item
        Name = 'pDataInicial'
      end
      item
        Name = 'pDataFinal'
      end>
  end
  object dsSqlMovimentacoes: TDataSource
    DataSet = sqlMovimentacoes
    Left = 288
    Top = 376
  end
  object sqlMovProdutos: TFDQuery
    Active = True
    IndexFieldNames = 'idMovimentacoes'
    MasterSource = dsSqlMovimentacoes
    MasterFields = 'id'
    Connection = Conexao
    SQL.Strings = (
      'SELECT * FROM movimentacoes_produtos')
    Left = 440
    Top = 296
    object sqlMovProdutosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object sqlMovProdutosidMovimentacoes: TIntegerField
      FieldName = 'idMovimentacoes'
      Origin = 'idMovimentacoes'
      Required = True
    end
    object sqlMovProdutosidProdutos: TIntegerField
      FieldName = 'idProdutos'
      Origin = 'idProdutos'
      Required = True
    end
    object sqlMovProdutosquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object sqlMovProdutosnomeProduto: TStringField
      FieldKind = fkLookup
      FieldName = 'nomeProduto'
      LookupDataSet = tbProdutos
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'idProdutos'
      Size = 50
      Lookup = True
    end
  end
  object dsSqlMovProdutos: TDataSource
    DataSet = sqlMovProdutos
    Left = 440
    Top = 384
  end
end
