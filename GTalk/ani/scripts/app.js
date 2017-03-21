/**
 * Created by Administrator on 2015/4/7.
 */
require.config({
    waitSeconds : 45,
    paths: {
        "jquery": "libs/jquery-2.2.3.min",
        "swiper":"swiper/swiper.min",
        "swiperAnimate":"swiper/swiper.animate.min"
    },
    map: {
        '*': {
            'css': 'libs/css.min'
        }
    },
    shim : {
        "jquery": {
            exports: "jQuery"
        },
        "swiper":{
            deps: ["jquery"]
        },
        "swiperAnimate":{
            deps: ["swiper"]
        }
    }
});




require(["jquery"],function($){



    require(["css!../css/libs/animate.min.css","css!../css/swiper/swiper.min.css","swiperAnimate","swiper"],function(){
        scaleW = window.innerWidth / 320;
        scaleH = window.innerHeight / 480;
        var resizes = document.querySelectorAll('.resize');
        for (var j = 0; j < resizes.length; j++) {
            resizes[j].style.width = parseInt(resizes[j].style.width) * scaleW + 'px';
            resizes[j].style.height = parseInt(resizes[j].style.height) * scaleH + 'px';
            resizes[j].style.top = parseInt(resizes[j].style.top) * scaleH + 'px';
            resizes[j].style.left = parseInt(resizes[j].style.left) * scaleW + 'px';
        };
        var mySwiper = new Swiper('.swiper-container',{

            pagination: '.swiper-pagination',
            //virtualTranslate : true,
            speed : 50,
            // longSwipesRatio : 0.3,
            // grabCursor:true,
            // nextButton:'#btn2',
            mousewheelControl : true,
             lazyLoading : true,
             lazyLoadingInPrevNext : true,
             lazyLoadingOnTransitionStart : true,
            onInit: function(swiper){
                setTimeout(function(){
                    $(".swiper-container").css({"opacity":"1"});
                    swiperAnimateCache(swiper);
                    swiperAnimate(swiper);
                },100);

                 $("#go").click(function(){
                    window.location.href="start";
                 });
            },
            onSlideChangeEnd: function(swiper){
                swiperAnimate(swiper);
            },
            onTransitionEnd: function(swiper){
                swiperAnimate(swiper);
            }, watchSlidesProgress: true,
            onSetTransition: function (swiper, speed) {
                for (var i = 0; i < swiper.slides.length; i++) {
                    es = swiper.slides[i].style;
                    es.webkitTransitionDuration = es.MsTransitionDuration = es.msTransitionDuration = es.MozTransitionDuration = es.OTransitionDuration = es.transitionDuration = speed + 'ms';

                }
            },
        });
    });

});