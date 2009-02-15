require File.dirname(__FILE__) + '/../../../spec_helper'
require 'controller_spec_controller'

['integration', 'isolation'].each do |mode|
  describe "A controller example running in #{mode} mode", :type => :controller do
    controller_name :controller_spec
    integrate_views if mode == 'integration'

    describe "with an error that is not rescued in the controller" do
      context "without rails' error handling" do
        it "raises the error" do
          lambda do
            get 'un_rescued_error_action'
          end.should raise_error(ControllerSpecController::UnRescuedError)
        end
      end

      context "with rails' error handling" do
        it "raises the error" do
          controller.use_rails_error_handling!
          lambda do
            get 'un_rescued_error_action'
          end.should raise_error(ControllerSpecController::UnRescuedError)
        end
      end
    end
    
    describe "with an error that is rescued in the controller" do
      context "without rails' error handling" do
        it "raises the error" do
          lambda do
            get 'rescued_error_action'
          end.should raise_error(ControllerSpecController::RescuedError)
        end
      end

      context "with rails' error handling" do
        before(:each) do
          controller.use_rails_error_handling!
        end

        it "does not raise error" do
          lambda do
            get 'rescued_error_action'
          end.should_not raise_error
        end

        it "executes rescue_from" do
          get 'rescued_error_action'
          response.body.should == 'Rescued!'
        end
      end
    end


  end
end