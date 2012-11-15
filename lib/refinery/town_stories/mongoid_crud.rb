# Created based on refinerycms/core/lib/refinery/crud.rb.

module Refinery
  module TownStories
    module MongoidCrud
      extend ActiveSupport::Concern
      
      module ClassMethods
        def mongoid_crudify_default_options(model_name)
          class_name = "#{model_name.to_s.camelize.gsub('/', '::')}".gsub('::::', '::')
          model_class = class_name.constantize
          singular_name = ActiveModel::Naming.param_key(model_class)
          {
            conditions: {},
            order_by: [],
            paging: false,
            per_page: false,
            redirect_to_url: "refinery.#{Refinery.route_for_model(model_class, plural: true)}",
            searchable: false,
            search_conditions: '',
            title_attribute: 'title',
            xhr_paging: false,
            model_class: model_class,
            singular_name: singular_name,
            plural_name: singular_name.pluralize
          }

        end
  
        def mongoid_crudify(model_name, options = {})
          options = mongoid_crudify_default_options(model_name).merge(options)
          model_class = options[:model_class]
          singular_name = options[:singular_name]
          plural_name = options[:plural_name]
  
          prepend_before_filter :find_item, only: [:update, :destroy, :edit, :show]
  
          define_method :new do
            @item = model_class.new
          end

          define_method :create do
            redirect_to_url = eval(options[:redirect_to_url])
            if (@item = model_class.create(params[singular_name])).persisted?
              (request.xhr? ? flash.now : flash).notice =
                t('refinery.crudify.created', what: "'" + @item[options[:title_attribute]] + "'")

              if from_dialog?
                render text: "<script>parent.window.location = '" + redirect_to_url + "';</script>"
              elsif params[:continue_editing] =~ /true|on|1/
                if request.xhr?
                  render partial: "/refinery/message"
                else
                  redirect_to :back
                end
              else
                redirect_back_or_default redirect_to_url
              end
            else
              if request.xhr?
                render partial: "/refinery/admin/error_messages", locals: { object: @item, include_object_name: true }
              else
                render action: 'new'
              end
            end
          end
  
          define_method :edit do
            # object gets found by find_item function
          end

          define_method :update do
            redirect_to_url = eval(options[:redirect_to_url])
            if update_item params[singular_name]
              (request.xhr? ? flash.now : flash).notice =
                t('refinery.crudify.updated', what: "'" + @item[options[:title_attribute]] + "'")

              if from_dialog?
                render text: "<script>parent.window.location = '" + redirect_to_url + "';</script>"
              elsif params[:continue_editing] =~ /true|on|1/
                if request.xhr?
                  render partial: "/refinery/message"
                else
                  redirect_to :back
                end
              else
                redirect_back_or_default redirect_to_url
              end
            else
              if request.xhr?
                render partial: "/refinery/admin/error_messages",
                       locals: { object: @item, include_object_name: true }
              else
                render action: 'edit'
              end
            end
          end
  
          define_method :destroy do
            # object gets found by find_item function
            if @item.destroy
              flash.notice =
                t('destroyed', scope: 'refinery.crudify',
                  what: "'" + (@item[options[:title_attribute]] || '') + "'")
            end

            redirect_to eval(options[:redirect_to_url])
          end
  
          define_method :find_item do
            @item = model_class.where(_id: params[:id]).first
          end
  
          define_method :find_all_items do |conditions = options[:conditions]|
            model_class.where(conditions).order_by(options[:order_by])
          end

          define_method :paginate_all_items do |items|
            paging_options = { page: params[:page] }

            if options[:per_page].present?
              paging_options.update per_page: options[:per_page]
            elsif model_class.methods.map(&:to_sym).include?(:per_page)
              paging_options.update per_page: model_class.per_page
            end

            items.paginate paging_options # TODO fix?
          end

          define_method :update_item do |item|
            @item.update_attributes item
          end

          # define_method(:search_all_items) do
            # find_all_items(options[:search_conditions]).with_query(params[:search])
          # end
  
          protected :find_item, :find_all_items, :paginate_all_items, :update_item
  
          define_method :index do
            items = find_all_items
            # items = (options[:searchable] && searching?) ? search_all_items : find_all_items

            if options[:paging]
              @items = paginate_all_items items
              render partial: 'items' if options[:xhr_paging] && request.xhr?
            else
              @items = items
            end
          end

          singleton_class.instance_eval do
            define_method :searchable? do
              options[:searchable]
            end
            define_method :pageable? do
              options[:paging]
            end
          end
        end
      end
    end
  end
end
