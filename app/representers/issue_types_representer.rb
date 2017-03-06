module IssueTypesRepresenter
  include Representable::JSON::Collection

  items extend: IssueTypeRepresenter
end
