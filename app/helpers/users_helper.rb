module UsersHelper
  def show_user_image(user)
    if user.image.attached?
      image_tag user.image.variant(resize: "300x300"), class: "img-thumbnail img-r"
    else
      image_tag "no_image.png", class: "img-thumbnail"
    end
  end
end