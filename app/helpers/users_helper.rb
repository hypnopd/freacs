module UsersHelper
  def confirmed(result)
     result ? t("yes") : t("no")
  end
end
