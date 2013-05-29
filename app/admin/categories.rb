ActiveAdmin.register Category do
  menu :priority => 4

  index do
    selectable_column
    column :slug
    column :name
    column :description

    default_actions
  end

  filter :name

  form do |f|
    f.inputs "Admin Details" do
      f.input :slug
      f.input :name
      f.input :description
      f.input :created_at
      f.input :updated_at
    end
    f.actions
  end
end
