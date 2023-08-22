//
//  NewsMockDataService.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

class NewsMockDataService: NewsServiceProtocol{
    
    // Mock News Sources
    func getNewsSources(completion: @escaping (Result<NewsSourcesResponse, Error>) -> Void) {
        let mockSources = [
            NewsSource(
                id: "abc-news",
                name: "ABC News",
                description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
                url: "https://abcnews.go.com",
                category: .general,
                language: .en,
                country: "us"
            ),
            NewsSource(
                id: "ars-technica",
                name: "Ars Technica",
                description: "The PC enthusiast's resource. Power users and the tools they love, without computing religion.",
                url: "http://arstechnica.com",
                category: .technology,
                language: .en,
                country: "us"
            ),
            NewsSource(
                id: "associated-press",
                name: "Associated Press",
                description: "The AP delivers in-depth coverage on the international, politics, lifestyle, business, and entertainment news.",
                url: "https://apnews.com/",
                category: .general,
                language: .en,
                country: "us"
            ),
            NewsSource(
                id: "australian-financial-review",
                name: "Australian Financial Review",
                description: "The Australian Financial Review reports the latest news from business, finance, investment and politics, updated in real time. It has a reputation for independent, award-winning journalism and is essential reading for the business and investor community.",
                url: "http://www.afr.com",
                category: .business,
                language: .en,
                country: "au"
            ),
            NewsSource(
                id: "axios",
                name: "Axios",
                description: "Axios are a new media company delivering vital, trustworthy news and analysis in the most efficient, illuminating and shareable ways possible.",
                url: "https://www.axios.com",
                category: .general,
                language: .en,
                country: "us"
            ),
            NewsSource(
                id: "bbc-news",
                name: "BBC News",
                description: "Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news as well as local and regional perspectives. Also entertainment, business, science, technology and health news.",
                url: "http://www.bbc.co.uk/news",
                category: .general,
                language: .en,
                country: "gb"
            )
        ]
        
        let mockResponse = NewsSourcesResponse(status: "ok", sources: mockSources)
        completion(.success(mockResponse))
    }
    
    // Mock News
    func getNews(from sourceId: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let mockNews = [
            News(
                title: "Former UK neonatal nurse sentenced to life for murder of 7 babies",
                description: "The judge said there was \"a deep malevolence bordering on sadism.\"",
                author: "Camilla Alcini, Somayeh Malekian",
                url: "https://abcnews.go.com/International/former-uk-neonatal-nurse-sentenced-life-murder-7/story?id=102417318",
                urlToImage: "https://s.abcnews.com/images/International/Lucy-Le_hpMain_20230821-052622_16x9_992.jpg",
                publishedAt: "2023-08-21T12:45:46Z",
                content: "LONDON -- Former British nurse Lucy Letby was sentenced on Monday to spend the rest of her life in prison after being found guilty in the worst child serial killer case in the modern history of the U… [+931 chars]",
                
                source: NewsSource(id: "abc-news", name: "ABC News", description: nil, url: nil, category: nil, language: nil, country: nil)
            ),
            News(
                title: "Russia, China look to advance agendas at BRICS summit of developing countries in South Africa",
                description: "Russia and China will look to gain more political and economic ground in the developing world at a summit in South Africa this week",
                author: "GERALD IMRAY Associated Press",
                url: "https://abcnews.go.com/Business/wireStory/russia-china-advance-agendas-brics-summit-developing-countries-102416032",
                urlToImage: "https://s.abcnews.com/images/International/wirestory_f596f2362aa11c42d17d26ba739e56f2_16x9_992.jpg",
                publishedAt: "2023-08-21T06:14:27Z",
                content: "JOHANNESBURG -- JOHANNESBURG (AP) Russia and China will look to gain more political and economic ground in the developing world at a summit in South Africa this week, when an expected joint dose of a… [+7366 chars]",
                source: NewsSource(id: "abc-news", name: "ABC News", description: nil, url: nil, category: nil, language: nil, country: nil)
            ),
            News(
                title: "Four die in climbing accident on the Pico de Orizaba, Mexico's highest peak",
                description: "Authorities in Mexico say four Mexican citizens have died in a climbing accident on the Pico de Orizaba",
                author: "The Associated Press",
                url: "https://abcnews.go.com/International/wireStory/die-climbing-accident-pico-de-orizaba-mexicos-highest-102414243",
                urlToImage: "https://s.abcnews.com/images/US/abc_news_default_2000x2000_update_16x9_992.jpg",
                publishedAt: "2023-08-21T03:33:22Z",
                content: "MEXICO CITY -- Four Mexican citizens died in a climbing accident on the Pico de Orizaba, which is the highest mountain the country, authorities said Sunday. \r\nThe civil defense office in the central … [+942 chars]",
                source: NewsSource(id: "abc-news", name: "ABC News", description: nil, url: nil, category: nil, language: nil, country: nil)
            ),
            News(
                title: "Early results in Ecuador show possible presidential runoff between ex-president’s ally and banana tycoon’s son",
                description: "Early results in Ecuador show possible presidential runoff between ex-president’s ally and banana tycoon’s son",
                author: "The Associated Press",
                url: "https://abcnews.go.com/International/wireStory/early-results-ecuador-show-presidential-runoff-presidents-ally-102414129",
                urlToImage: "https://s.abcnews.com/images/US/abc_news_default_2000x2000_update_16x9_992.jpg",
                publishedAt: "2023-08-21T02:08:36Z",
                content: "GUAYAQUIL, Ecuador -- Early results in Ecuador show possible presidential runoff between ex-presidents ally and banana tycoons son.",
                source: NewsSource(id: "abc-news", name: "ABC News", description: nil, url: nil, category: nil, language: nil, country: nil)
            ),
            News(
                title: "North Korea's Kim watches cruise missile launches as US, South Korean troops begin annual drills",
                description: "North Korean media say leader Kim Jong Un observed the test-firing of strategic cruise missiles as the U.S. and South Korean militaries kicked off major annual drills that the North views as an invasion rehearsal",
                author: "HYUNG-JIN KIM Associated Press",
                url: "https://abcnews.go.com/International/wireStory/north-koreas-kim-watches-cruise-missile-launches-us-102412318",
                urlToImage: "https://s.abcnews.com/images/International/wirestory_e5786d8f60adcb9a66e93086751de638_16x9_992.jpg",
                publishedAt: "2023-08-21T00:16:08Z",
                content: "SEOUL, South Korea -- North Korean leader Kim Jong Un observed the test-firing of strategic cruise missiles, state media reported Monday, as the U.S. and South Korean militaries kicked off major annu… [+4231 chars]",
                source: NewsSource(id: "abc-news", name: "ABC News", description: nil, url: nil, category: nil, language: nil, country: nil)
            ),
            News(
                title: "3 dead, 6 wounded in shooting at a hookah lounge in south Seattle; no word on suspects",
                description: "Authorities say three people are dead and six others wounded after a shooting at a hookah lounge in south Seattle",
                author: "The Associated Press",
                url: "https://abcnews.go.com/US/wireStory/3-dead-6-wounded-shooting-hookah-lounge-south-102411295",
                urlToImage: "https://s.abcnews.com/images/US/abc_news_default_2000x2000_update_16x9_992.jpg",
                publishedAt: "2023-08-20T21:39:18Z",
                content: "SEATTLE -- Three people are dead and six others wounded after a shooting Sunday at a hookah lounge in south Seattle, authorities said.\r\nCity police didnt immediately release any information about a p… [+948 chars]",
                source: NewsSource(id: "abc-news", name: "ABC News", description: nil, url: nil, category: nil, language: nil, country: nil)
            )
        ]
        
        let mockNewsResponse = NewsResponse( status: "ok", totalResults: 7, news: mockNews)
        
        completion(.success(mockNewsResponse))
    }
    
}
