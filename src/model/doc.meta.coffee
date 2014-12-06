"use strict"
module.exports = (sequelize, DataTypes) ->
  docMeta = sequelize.define("docMeta",
    doc_id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4

    doc_title:
      type: DataTypes.STRING

    doc_path:
      type: DataTypes.STRING

    doc_version:
      type: DataTypes.INTEGER
      defaultValue: "1"

    doc_summary
      type: DataTypes.STRING
  ,
    underscored: true
    timestamps: false
    tableName: "doc_meta"
  )
  docMeta.sync(force: true)
  docMeta
