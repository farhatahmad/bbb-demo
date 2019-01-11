require 'rails_helper'

describe PagesController, type: :controller do
  describe 'Routing and Rendering tests' do
    it 'routes to the home method in the pages controller' do
      expect(get: root_url(subdomain: nil)).to route_to(controller: 'pages', action: 'home')
    end

    it 'renders the home template' do
      get :home
      expect(response).to render_template('home')
    end
  end

   describe 'POST #create' do
     it 'successfully redirects the user' do
       params = {
         room_id: 'test-create-post',
         record: false,
         name: 'Ahmad',
         password: 'mp',
       }

       post :create_and_join_meeting, params: params
       expect((response).status).to eq(302)
     end
   end
end
