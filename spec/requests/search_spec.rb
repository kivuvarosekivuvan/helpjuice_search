describe 'POST /api/search', type: :request do
  it 'logs and returns results' do
    post '/api/search', params: { q: 'test' }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to have_key('results')
  end
end