class Api::V1::SchoolHousesController < ApiController

    before_action :set_house, only: %i[ show update ]

    def index
        houses = SchoolHouse.all
        data = HouseSerializer.new(houses).serializable_hash
        json_response(
            data,
            :ok,
            I18n.t('general.controller_responses.messages.success_transaction')
        )
    end

    def show
        data = HouseSerializer.new(@house).serializable_hash
        json_response(
            data, 
            :ok, 
            I18n.t('general.controller_responses.messages.find_ok')
        )
    end

    # POST -> api/v1/houses
    def create
        house = SchoolHouse.create!(house_params)
        data = HouseSerializer.new(house).serializable_hash
        json_response(
            data,
            :created,
            I18n.t('general.controller_responses.messages.created_ok')
        )
    end

    def update
        @house.update(house_params)
        data = HouseSerializer.new(@house).serializable_hash
        json_response(
            data,
            :ok,
            I18n.t('general.controller_responses.messages.updated_ok')
        )
    end

    def destroy;end

    private 

    def house_params
        raise Errors::ParamsMissing.new I18n.t('general.controller_responses.messages.params_missing') unless params.dig(:house).present?
        params.require(:house).permit(:name, :school_id, :url_logo)
    end 

    def set_house 
        @house = SchoolHouse.find(params.dig(:id))
    end 
end
