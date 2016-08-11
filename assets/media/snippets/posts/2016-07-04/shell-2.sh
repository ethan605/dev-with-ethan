$ rails generate model conversation title:string from_user:references to_user:references
      invoke  active_record
      create    db/migrate/20160704073539_create_conversations.rb
      create    app/models/conversation.rb
