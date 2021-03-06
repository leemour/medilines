ActiveAdmin.register AdminUser do
  menu :priority => 6

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count

    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Описание пользователя #{f.object.name if f.object.name}" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
