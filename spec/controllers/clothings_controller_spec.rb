require 'rails_helper'

RSpec.describe ClothingsController, type: :controller do
    describe "#show" do
        before(:each) do
            controller.class.skip_before_filter :current_user
            
        end
        #let(:current_user) {instance_double(User,:id => '1')}
        let(:id) {'1'}
        let(:id2) {'2'}
        let(:clothing) {instance_double('clothing',:name => 'JC Penney')}
        let(:clothing2) {instance_double('clothing2',:name => 'Boscovs')}
        let(:clothings) {[clothing,clothing2]}
        context "When clothing exists" do
            describe "When looking to show a clothing" do
                it "calls the find method to retrieve the clothing" do
                    allow(controller).to receive(:can_proceed).and_return(@current_user)
                    expect(Clothing).to receive(:find).with(id).and_return(clothing)
                    
                    get :show,  {:id => id}

                end
            end
        end
    end
    
    describe "#index" do
       
        let(:id) {'1'}
        let(:id2) {'2'}
        let(:clothing) {instance_double('clothing',:name => 'JC Penney')}
        let(:clothing2) {instance_double('clothing2',:name => 'Boscovs')}
        let(:clothings) {[clothing,clothing2]}
        
        context "When clothing exists" do
            describe "When looking to show all clothing" do
                it "calls the all method to retrieve all clothing" do
                    allow(controller).to receive(:can_proceed).and_return(@current_user)
                    expect(Clothing).to receive(:all).and_return(clothings)
                    get :index, {:id => id}
                end
            end
        end
    end
    
    describe "#create" do
        let(:params) {{:name => "JC Penney"}}
        let(:clothing) {double('clothing', params)}
        let(:id) {'1'}
        let(:id2) {'2'}
        #let(:clothing) {instance_double('clothing',:name => 'JC Penney')}
        let(:clothing2) {instance_double('clothing2',:name => 'Boscovs')}
        let(:clothings) {[clothing,clothing2]}
        context "When a clothing is created" do
            describe "When trying to create a clothing with the same name" do
                it "calls the new method to create the clothing" do
                    allow(controller).to receive(:can_proceed).and_return(@current_user)
                    expect(Clothing).to receive(:new).with(params).and_return(clothing)
                    allow(clothing).to receive(:save)
                    post :create, {clothing: params }
                end
            end
            
        end
    end
    
    describe "#update" do
        before :each do
            @current_user=instance_double('User', name: 'student')
        end
        let(:params) {{:name => "clothing"}}
        let(:clothing) {double('clothing', params)}
        let(:id) {'1'}
        
        context "When a clothing is updated" do
            describe "When looking to update a clothing" do
                it "calls the find method to update the clothing" do
                    allow(controller).to receive(:can_proceed).and_return(@current_user)
                    expect(Clothing).to receive(:find).with(id).and_return(clothing)
                    allow(clothing).to receive(:update_attributes).with(params)
                    get :update,  id: id, clothing: params
                end
            end
        end
    end
    
    describe "#edit" do
        let(:id) {'1'}
        let(:id2) {'2'}
        let(:clothing) {instance_double('clothing',:name => 'JC Penney')}
        let(:clothing2) {instance_double('clothing2',:name => 'Boscovs')}
        let(:clothings) {[clothing,clothing2]}
        context "When clothing exists" do
            describe "When looking to edit a clothing" do
                it "calls the find method to retrieve the clothing" do
                    allow(controller).to receive(:can_proceed).and_return(@current_user)
                    expect(Clothing).to receive(:find).with(id).and_return(clothing)
                    get :edit, {:id => id}
                end
            end
        end
    end
  
    describe 'destroys a clothing' do
        let(:id) {'1'}
        let(:id2) {'2'}
        let(:clothing) {instance_double('clothing',:name => 'JC Penney')}
        let(:clothing2) {instance_double('clothing2',:name => 'Boscovs')}
        let(:clothings) {[clothing,clothing2]}
        it 'calls the find method to retreive the clothing' do
            allow(controller).to receive(:can_proceed).and_return(@current_user)
            expect(Clothing).to receive(:find).with(id).and_return(clothing)
            allow(clothing).to receive(:destroy)
            delete :destroy, {:id => id}
        end
        it 'sets a flash message' do
            allow(controller).to receive(:can_proceed).and_return(@current_user)
            allow(Clothing).to receive(:find).with(id).and_return(clothing)
            expect(clothing).to receive(:destroy)
            get :destroy,  {:id => id}
            expect(flash[:notice]).to eq("Store deleted!")
        end
        
        
     
        it 'redirects to the groceries page' do
            allow(controller).to receive(:can_proceed).and_return(@current_user)
            allow(Clothing).to receive(:find).with(id).and_return(clothing)
            allow(clothing).to receive(:destroy)
            get :destroy,  {:id => id}
            expect(response).to redirect_to(clothings_path)
        end
    end
end
