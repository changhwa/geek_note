"use strict"
module.exports = (sequelize, DataTypes) ->
  historyMeta = sequelize.define("historyMeta",
    history_id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4

    history_commit_id:
      type: DataTypes.STRING
      unique: true

    doc_id:
      type: DataTypes.UUID

    doc_version:
      type: DataTypes.INTEGER
      defaultValue: "1"
  ,
    underscored: true
    timestamps: false
    tableName: "doc_history_meta"
  )
  historyMeta.sync(force: true)
  historyMeta
