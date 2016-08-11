$ rails generate scaffold conversation title:string from_user:references to_user:references
      invoke  active_record
      create    db/migrate/20160704073626_create_conversations.rb
      create    app/models/conversation.rb
      invoke  resource_route
       route    resources :conversations
      invoke  serializer
      create    app/serializers/conversation_serializer.rb
      invoke  scaffold_controller
      create    app/controllers/conversations_controller.rb
