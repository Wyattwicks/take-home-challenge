class TeasSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :title,
              :description,
              :temperature,
              :brew_time
end