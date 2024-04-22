<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@ include file="include/header-static.jsp"%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/assets/css/reset.css">
    <link rel="stylesheet" href="/assets/css/movieinfo.css">
    <title>Document</title>
</head>

<body>

    <div class="scrollBar">

    </div>

    <div class="backSky">
        <svg class="sky"></svg>
    </div>

    <div class="movie">


        <div class="info-wrap">
            <img class="poster" src="${movie.imageUrl}">
            <div class="doc">
                <h1>${movie.movieName}</h1>
                <p class="content">${movie.plot}</p>
                <div class="info">
                    <div>
                        <h1>누적 관객수 :</h1>
                        <p>${movie.audiAcc}명</p>
                    </div>
                    <div>
                        <h1>장르 : </h1>
                        <p>
                        <c:forEach var="genre" items="${genres}">
                            ${genre.genreName} &nbsp;
                        </c:forEach>
                        </p>
                    </div>
                    <div>
                        <h1>출연 :</h1>
                        <p>
                            <c:forEach var="actor" items="${actors}">
                                ${actor.actorName} &nbsp;
                            </c:forEach>
                        </p>
                    </div>
                    <div>
                        <h1>감독 :</h1>
                        <p>${movie.director}</p>
                    </div>
                    <div>
                        <h1>국가 :</h1>
                        <p>${movie.nation}</p>
                    </div>
                    <div>
                        <h1>등급 :</h1>
                        <p>${movie.rating}</p>
                    </div>
                    <div>
                        <h1>개봉일 :</h1>
                        <p>${movie.openDate}</p>
                    </div>
                    <div>
                        <h1>러닝타임 :</h1>
                        <p>${movie.runtime}분</p>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="review-wrap">
        <div class="review-box">
            <div class="review">
                <!-- 리뷰별개수 창입니다 -->
                <div class="reple">
                    <div class="reple-box">
                        <div class="reple-star">
                            <span class="star">
                            ★★★★★
                             <span>★★★★★</span>
                            <input type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
                             </span>

                            <button class="reple-bt"> 코멘트 남기기 </button>
                        </div>
                        <div class="reple-item">
                        <select>
                            <option>공감순</option>
                            <option>최신순</option>
                        </select>
                        </div>
                    </div>
                </div>

                <div class="swiper review-swiper-custom">
                    <div class="swiper-wrapper">
                        <% for(int i=0;i<10;i++)  { %>
                        <div class="swiper-slide review-swiper">
                            <div class="review-container">
                                <div class="review-profile">
                                    <div class="review-profile-img">
                                        <img src="" alt="프사">
                                        <p style="margin-left:5px; color:black;">이름</p>
                                    </div>
                                    <div class="review-profile-grade">
                                        <img src="/assets/img/3.png">
                                        <p style="margin-left:5px; color:black;">5.0</p>
                                    </div>
                                </div>
                                <hr class="review-hr" />
                                <div class="review-text">
                                    <p style="color:black !important;">리뷰 글</p>
                                </div>
                                <hr  />
                                <div class="review-sym">
                                    <div>
                                        <p style="color:black !important;"> 따봉 </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <div class="swiper-pagination pagination_bullet"></div>
                    <div class="swiper-pagination pagination_progress"></div>
                </div>

               

            </div>
        </div>
    </div>
        <%@ include file="include/footer.jsp"%>

    <script>
        /* 리뷰별개수 */
        const drawStar = (target) => {
            document.querySelector(`.star span`).style.width = `\${target.value * 10}%`;
            let button = document.querySelector('.reple-bt');
            if(target.value>0){
                button.style.visibility = "visible";
            }else{
                button.style.visibility="hidden";
            }
            console.log(target.value);
        }


        const $sky = document.querySelector(".sky");

        // 브라우저 창 크기에 따른 별 생성
        window.onresize = () => {
            makeStars();
        }

        const makeStars = () => {
            // 브라우저 가장 큰 크기
            const maxSize = Math.max(window.innerWidth, window.innerHeight)

            // 랜덤한 X 위치 값
            const getRandomX = () => Math.random() * maxSize;

            // 랜덤한 Y 위치 값
            const getRandomY = () => Math.random() * maxSize;

            // 랜덤한 크기 (circle는 반지름이 크기)
            const randomRadius = () => Math.random() * 0.7 + 0.6;

            // 임의의 값
            const _size = Math.floor(maxSize / 2);

            const htmlDummy = new Array(_size).fill().map((_, i) => {
                return `<circle class='star'
        cx=\${getRandomX()}
        cy=\${getRandomY()}
        r=\${randomRadius()}
        className="star" />`
            }).join('');

            $sky.innerHTML = htmlDummy;
        }

        window.onload = () => {
            makeStars();
        }
    </script>
    <script>
        var reviewSwiper =new Swiper('.review-swiper-custom', {
            speed: 800, // 슬라이드 속도
            slidesPerView: 4, // 한 번에 보여질 슬라이드 수
            slidesPerGroup: 4,
            spaceBetween: 10, // 이미지 간격
            loop: false, // 슬라이드 루프 설정 비활성화
            pagination: {
                el: ".pagination_bullet",
                clickable: true,
                type: 'bullets',
                renderBullet: function (index, className) {
                    return '<span class="' + className + '">' + (index + 1) + "</span>";
                },
            },
        })

    </script>
</body>

</html>