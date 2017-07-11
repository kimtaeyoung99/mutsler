require('nokogiri')
require('open-uri')
require('rest-client')

class MusleVideoController < ApplicationController
    before_action :authenticate_user!
    def test 
    end
    def list
        
        @post = Video.all

    end
    def detail
         puts "detail"
         puts current_user.id
            
        @post = Video.find(params[:id])
        @url = @post.url.to_s[@post.url.index(?=)+1..-1]
        
        @like = VideoLike.where("video_id = ?", params[:id]).length
        
   
        @like_user = like_check(current_user.id,params[:id])
        
        puts @like 
        puts "뭐라고나와?"
        
    end
    def update
    end
    def create
    end
    def reply_ok
        
        r = VideoReply.new
        
        r.content = params[:msg]
        r.user_id = params[:user]
        r.video_id = params[:video_id]
        
        r.save 
        
        redirect_to :back
    end
    
    def like 
     
        like = VideoLike.find_by(user_id: current_user.id ,
                                video_id: params[:post_id])
        puts params[:post_id]
        if(like.nil?)
            #create
            
            puts "like"
            col = VideoLike.new
            col.user_id = current_user.id 
            col.video_id = params[:post_id]
            col.save
        else
            puts "delete"
            like.destroy
        end
        #카운트가 플러스 일 해주는거 
        puts "count"
        puts params[:post_id]
        @count =  VideoLike.where("video_id = ?", params[:post_id]).length
        puts @count
        if request.xhr?
            render :json => {
                                :count => @count,
                            }
        end
    end
    
        #좋아요 체크 기능 
    def like_check(user,post)
         like_user = ""
         puts "조아요눌럿나여?"
         puts VideoLike.find_by(user_id: user ,video_id: post)
         if VideoLike.find_by(user_id: user ,video_id: post)
             puts 'if'
             like_user = "heart heart_off" # 눌럿을때 하트가 밝아야댐
         else
             puts 'else'
             like_user = "heart"
         end
         return like_user
    end
end
