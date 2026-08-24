Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2C3264DF;
	Mon, 24 Aug 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573003; cv=none; b=szqUAAUu/r4yKFfEyHoFKRVHsIl71bSZbYOxSC+pYBH92ulo6Lx3ObfVCupQI8gxLe7VcwSOAaRyRRGS2f0F6hciC5SWmEXMPpbJzE6G7xovPd2uomPEJ4p4gdeQ2W/9D/ODKQ4EI9j5BiQ11cjgDBexe/1GBnbLyURCOSNcjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573003; c=relaxed/simple;
	bh=/IL/GGKCr+hcyociXokyQeNFCLjn6Jh+q34jpQNkgm0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QW72SUVViah0mUS8v00N3ClP4WmucqEmI1OaickLRQ9HajHFx0UshFB8soFfHrE6MGdPWhZPXtd5jWGDzf4EHm/qc5UgmQqkk/A0WXFY27jfP3QCOJkZeoWWSCV0tToi/210QYDXdBoutI676ZopUAGw5ME8EMu+S3tmBGeDi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Fi5LL5Ke; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Fi5LL5Ke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787572994; x=1788177794;
	i=markus.stockhausen@gmx.de;
	bh=CdAeC/6iY9OEOhTdAKvOXfxFOdLRzSCwQlWxSC1Ir7s=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fi5LL5KeR0/G+YtTnJKIY2OXj9/RwAGCyLghSmeJ0081vupfobdjwCAPtLtVx+Vk
	 lD4D7urE/LgkM+K8PXeCiJsQoLteGMA/biMNukjj6vUB6Kh0Ei5owLbw0Go8R0SYI
	 c3a7nxOaMl35oNNk/PqP7NFIJfjPicaIAFxYKE+ekW6BpNsUlOunA0I1gHJCSFZrv
	 Lbdg3GPFO0wlz2PZU27tTEPFn5MFF4SojskyoAsWHQWZ0hVyv8RmCSl3j1W5isvwi
	 TvU82t4HEO8lioCx3guKltNkB9Kt2iE+So1R71dM2ZO31g9XxXYZpKV5dhIOURIrn
	 2FH6LAIjSNz2fDxcyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1wO2mX0LXv-00bPEx; Mon, 24
 Aug 2026 14:03:14 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: <andrew@lunn.ch>
Cc: <robh@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de> <20260817162632.1208891-4-markus.stockhausen@gmx.de> <20260818162727.0392E1F000E9@smtp.kernel.org>
In-Reply-To: <20260818162727.0392E1F000E9@smtp.kernel.org>
Subject: AW: [PATCH net-next v14 03/13] net: mdio: realtek-rtl9300: deny C45 over C22 access
Date: Mon, 24 Aug 2026 14:03:13 +0200
Message-ID: <039501dd33c0$8ae34330$a0a9c990$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGRKDnP2yh8sOJ5M24BwCNtDMK1QGTsagBAl46wCu1O2b4YA==
Content-Language: de
X-Provags-ID: V03:K1:Ado9VWZA90P6fW53bgEAJzE1kN51tCooxMuLLOePt6XgNopXS6m
 qJuhCVlYIFkouieh2+pu8uRpay3TvZ78UYYfRwVA02a5ns60PQGsR7k4dHqvq+OTVrzNauN
 RJK4D7vgScYQsrHlOWI4bDkJ+87zwk1oDIQ5T7LudqOdIc2nxpm8jdTk+DR+VXsArhHNz6y
 Of9jeG9DAqW7+Z0pDEa2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mkp2V0tEwl0=;yAGchBupoy+cyAS0/K4VLjYev5U
 Rg7SKz5RaF+uLW3I9Z/b09s6tIfJoNTlvqdqilmghiMDZ+/xkpVKeZnf5I/wfl57SzR1ZSZdg
 4Zm+ykJ0vVgxx7vEYS3g+k2AuseHvyvpWddLUyhwXmtxG+R/meQ6YfI3p/mFQuLS0WSH73TRU
 FuOJPmgqGii83zK0XJQ8qKXuiaF3cZIJhyuMGYKaWOOI/hSzFMJn10tiGQMaMw0fkc/yMpWDF
 sq5ywjFss9xm8hOLc66EmJgun4Tdh64vllJTQc6PYMyk5Z9LmlCBTl+iMe8Otc8IytWU/rpI9
 qfmrP0SO/o9NLCy0FhfhApEpBz9d9yQbcQSRPVfKVWG+K07MZfLQaxY/CBugUuqHTeJGI4VaM
 uAc9yFjTZSoBZlN66yXseYaKfblOwixNjBiDa41ahvdf0Euq/KQzjtxWMpT/UzzCX5m3zO0eP
 SoIEnKFEjBXs08vd6CAA5P7AqDwudMBRkeTsfGLEoPVOwNND6XKKLolz5LvGaGszY1q8vAHez
 lkB0SjjIxW2Y8MpLGYbFgV5A21oOh/ZrH+MY3wV40Ju0BB8zInwykr/pkVoDytZlQIX2ftMGp
 pNr6FAnzWhTqYODf7hVjlbbs6GEEkoPF04TT/84NQHet8a7vioHf9Xiil1GpHE/sOGf5KawQR
 RopGXc5tmnhEtlPd8aUxAJWvhA5A6fu/EJldG9vU90l+eJBhuHHCrwfy/e6RQE8S0bon6RQbG
 dBp1iasUWwQ0ve0ObbSlSc2r5bAsLvYLWQEhRRQzeCdzfXbM5BLuY4kj5lG3EnW8SrY5J3Z+p
 X3K0y+ULfrcyv38mc/C3eGlUAbTkQSXRsBLA2ph1xdHIw7y/14ioWkUbdLbM7Vy9h3SRms2Bq
 xzV7FYqVE17BvXdy2G/VFBJcDLl260gbsuhuJLhYLiypkSZSzb3CilN3+jKtcxS2ZGtsK+jPB
 lvVBQi2VUJvf/iq4gW+MHzkHE3ifE2oREth/kJSzVkIJsf+DB2yU+6MmzNG4pYcDROPsU5Fur
 qBi+aPU2jjoPStX3jBL4STvcPwoM5GHqeVUfjUoN78vpOVuUl3SERVQf+6q2ep+sA5npaGCRj
 5qRjHUnhoPysuJ6uMp5Z5TM2yn5h4ygB0w0cbeYKwzg2DHsNUSvBFlr8X5Q23l89ku9PYKitL
 R40gJiPZULn6vYRwLU4uMwVsnNUYG6/hj5aVAO+8JAk9I9iVBl13UWDKz7aBlA3KtzR9IB2Tj
 1sTY+ZECluUXMljhNJ31wEyu+FbRwHpXxebeGZWkpwpFkMpnRxpDhZbSJ1AEJMsM9WUHamkci
 eSCch+cOz5nIKbV2nplnawOdPb1FQfEmIOBHJ96OwB+slkUrNPx7+2Vy7H1KK24vWv7ZLWhs0
 5PT7mBeFMjzjloySjFUKfxLsm7E5g1oigM3uuqbA6zvTTxvTAEYTIkBUb020wiyg8Cac04r65
 6du5gVC41tHiERxfsVKqkZvmN7KTIVVMRUa9o33EaLNTzE8oRnRRILI3KRjjeL9oun8axcCV2
 Y/STgT9C9W/9jLYJa9O/YIaXIDDh+raTYTzR4D/BxuvWVVu9L1s1uGcmB7qfoCjEeDjjZLSSt
 8TBw2EEXF8WQzOHQwR2/e/LJIa2+Zr4ST26dfgBeBniBih2jSivBkc7DpDlKmm2+odFP1i8Fj
 zpu+g60MXH/wfMCi+ThIEycGID0NakV424FZ5CZ+VcQibPP+nZxMhxEIVYJc7hmN/uw4ixiaV
 vKftSXFZnKJKfJis3xzTMlBzCLAL0wm4vvYZW9F6Y4vgo2cgXaJkVHIHE2BKJVmUhpy28g5A8
 GgzjHGdXCPHn0Pf4Z1F/oGpWttHqp7jm/sXlQ/3yoJk8Tb5NDL81knyByv2tb5M/h1kqN5gal
 H1eOdfyH3L7CKyvAzn7D3NoccncVbnTSo6n6fgn0MmXOyWFVPR6272K0KMpdht8lTJiZbNbU2
 TRkRZ6DSsc6H/xst40ZbIx19ir71WU/6ib5rw0mJ+q9Z+gP9XHIJ2AAVdqyXXHzF45ilVfQ3Q
 yRpzduyMHJuGPHAFXuY0/rEiMUJNUOE8GQPbW2quGhLV9fTN8rMXE7bdyXXTvcB0H4R39xtaS
 uJFujGEzgkqKYWcwswlfDGMUHa3ZXbcpd23JASuqTjizhtCVBh9LrUw8CfqzXc7CkJ9ycaR6P
 FYiIhdPv+GxLBgmjPiYWhY8wHkQhBnVn+dr4Ap8a0tkoXtvDYhfFILFYufJ9qLQT5TBw0N5oX
 6enzgtBwhLHEyJkCHVMeQwieZeGNflw/lRIAkmN3szAZbXIULmdG8sqWGr2CrT+gvOFBdzone
 vPdOmyGx5CuOjKxLWmVHDotC5qPtQam+ymH4Q0q3Y0BZZGYWAL8fP+fZJFCw+9ikRTD/x4lKf
 zT+Q0/ufr8iFamE3qdy93WMr/wmXzr6b0J2RIE4dVO7GUX8YcGQwx8boNhGcEpadPBVwyMMmG
 kikKXotWGKOW98DUNJvBud3iUNIuLRYo2lKFtwE6ZIR80rl+zjYzmXpiW72yh28oybRte3+Cw
 dtYAeshQNgbLYThLsN7NSL3RJXtvSq/oUsOOl/MJS6BggpHkFzODIvif4AhhZ/qmnSW1COLth
 aef9J7NhkidfM+1eXOYvh28/s+8kWrm/Pp9hgX/jfOddfgayvrnXAm/f+UElm0nzhC5zDYaRU
 hE7C5s4lUMvkgEea9RAu+VDQ4l+rJ8HK+Zp9rA/ezfVrhtiNLDrabhHb+lzP4GA42rj8jeBHD
 Os+JHD0tPkJrrthiUz9OpktaNOrj2wA3Uhh5pyNBtoIGelw9D+E6AVO5gRYBIlfrf2KPy0DoV
 nWY1xoZ69FAPRmv0/8VnkhZt24w+pZJhacPSM2QDz+v3Xo8Kf/3gLFFsmOQiTQncmQpHGYoTB
 r7t+duWc9Ri+t1XIaa10RwZgqQM8JvUHOxJ8JcLklyjKsBxhX2CXuwFGtzM9Y+Kq6qMIiQyP3
 q+cFc/xvPc7q4U3ndpzPMuGFcN1MHlFUj9fJNaN1YoN4q25iwE8Nd+ycxSKmNBVA1SuC+sN6q
 RuXcPgWWp51jrz2r+DkIIYrbKFI8FydUsx1krOQeXoGnaXOP770qFpB7o1+G8RqDCIubtnOfU
 b8v0/NlXmQsFEpEtI7JMJzT5Pcl1K5RbuJDumPLw1V3RBPFQi66hnOXe0J3Wxoc1E3mYOCf31
 zXHAdyoztH9XxesRPkXBc1f5rpqR/TK4YOO2RzogOFrJRMfccyof/uO3NBGuxl4SynkwgMe/q
 XeALprzRwzTwqgO77Mg8ShHd+9h+7I6LNdk9R4aazuW09OQm28V6hE7/MxA5KR/SW1/tseOEe
 iQtFT8yQgGb4JXAmzyRnaCD7lpnFMOuokToBbW7rAf7uQxRdzxM7769bx84PN5vXaYrLsBVX4
 h2yMr+pt5DcXE4FJciBT5NAKGfmQ8m/Uj++x0ZPiuA9ZLHRdR6v4C9/o/6DIwxUgj5/NIm1iX
 rJhbW6jiND2/EENWUnkzzccJK9gaOu/DPtJZ7baOc82hnsKovuFNKxNutFOOyMYmy4Az2I7zB
 v1Pey7+VjVBKIwq70eBGq9f9zziXLDKFMLP6F5V7bM7S6zksv7M+HMbk3fiRPmzMJ74oTqPjv
 y5vJBvHa6O0sue0yIwfBrj9f3JYI4oizaF6mtuYtRy6RaeT45rSwV1hV/xwyvhUBYaBaXuWwf
 yiP7sWG/oK67dalywHrFBFZdCtWpGxD8WWiUyZmPQQ9hrplAKhmNaNbtWN0YdAjgA8TUkwb2w
 Ko/SYmYKh2kH/UztH+O5aFuRKPE8KLUm0vwriNlV/E3zeLIf+XcoH77Zz59Nz0Poj3DTqE/xd
 vT01902IHSvczCNoYC41SyNhc31n84jNDIa0ThDDXmqcbbYd8oVysDJhSLDCXzMQW7asB1V/y
 EXmdLtzCqB7FAsj/4uPsBMlemCPTKhCoN7IxqRHKdhZCd2fP59eprntE9/ytpmXtindGlLrI3
 Xs2drZcdUW+t4Y5xbAVTvBI6sL5Q2t1Qy9nbKwdmuJ+hbil8iITHdPHHK4sFz1oKBmsXvS3o7
 LRdLjugG0kSi64033fw4RNC6IRbQ6UYkPl1SBt87vAAjMo7Hs9STKTvU3zt32EzlFphXD0e0H
 veDjc+nwYqoxJO+gPcJvtVSoK91SoKDP0h/4sYy5srdUowTOCtjusnaCEUYaE14pNJ2MOiA5s
 I+yqLEhgVQZAtUiAsuLKfAR1DjEV2XFYk3+1fnsf5hUF+VzpQdrX4NunW/jiZdqX+ZE7QpAlZ
 F6iX736/yjDhlGln5xGHjwqMTNcJ/83gEsYCwUJRk1shq5tT7xk5TMNPAGmkXkJp3EdrJ1268
 cyHWRVFhnM2sgf70rcmc66YBJBYpRQ/NftCMbdmQ8Nb60Gwm5Pyw72jXsV1FIxpFzQEiTEmwQ
 eneiqhk2tZyIswcXhhYZMQRZT0mbvThX5UYhjU0vw14aR8PngN2qaorC3z3EWL3BuiHesF0wm
 7HQHH76qrqxm7aVAD9O2O/jhWYo897n4EPLFiv8Q6v7o5GtuELbA886v1uapevs4nWHxLW896
 SF3bS8P7BTxQGEkJO/vsFtBwNhBJNi2viLOggFBbkXRml9elWU9T8S48cFLFih3g9PfXz6FUL
 vWmcF18u3bXXYilO74myaU/gk5KxLPiK821a3Qx9WDDu0vheLZAOM62Wqj442Z6I22BLCtJMG
 1u4ONzVo4hJwbPMnHPiHBDlYW6uQGegwy1fU/zIBrLfCcyBLi5Cs1B0fXsuRQU3mpCFnxFznX
 /eIavoyb9v19QD0q+wdyDfPN/iXJ9kg2CywKbetClbiva7jaIRJR94GDuHxKEYwrV5EYtJNVq
 3CJrYAKPH0HWJCFqDm4RYZWOKKtA7u/IHT1oRVCeoU806h5s7dX8IbkSYM9PHJ4PP1z4nbrFC
 KdGwIzlFHKYFoCJ1TZoQuEqgsDrN3ute8jQdKVLlES+9iwcKXAkunVRMZ+dB+TYdccgtWUWjA
 WuNWPbN4Bnm7/C4KpdqJyqiwBZ3c7RZ+1LmQf8NNxaSKLufIwYj5y3nvnNmQLT9gL/BxcG7fx
 5pAUUvzYaFh/bzViIuvkSikGC2wKN02gMq3wPj0Q5HGts9LMe/QDFXoWgtCAXC6vW87tiHfSc
 4TFwAiW/Qo6o3RYpBp82aIU7DQcxcxU9Jvz5CsZ66wAeWDMQLmBdrklXU30sfBRyb7Y/49rYa
 0vd/vmuFJlQD9VvX4FSSlcKGxgSvm9EShHAUJXg632OQPY5bDRN7WzqXMQRI1elD5UquS4HNC
 H5lrQBqO+cyTZkmG3FSSl3pg+wTL27H0IKTtQQoPJPjCTpCdp8n3h9KZgjuSBd5CtKQdxqN7l
 au7nx30BK5m7ViD1Ylc8N24Cn1kUTsws8OV/aWTjE8TsEmTRzfYeNp22iBsMkGyMoFRS0AVt6
 i28eTVG8nb/0mKoe81b4XOBQycYUwanKullR5vykgYZBE+MiWaPaPVeA2QvMhB5ALnTyH4dBi
 w6Q75tnfiKKjx5Vek9n0Gv/pEoFTajpywOqU12Houl4gDeLn77yCIcyVwTlNtYk2vut91N+c7
 xbUUcWCHvetBa224emsUIvr00/fK0yMx4g5qUYgXPsYX7nwKSEVpP9xjIfInY7aAf3hJqYp7X
 zvT7z5AYUTLpPYe+UIuIyrukG99qPnm3D3CXTDQ4JkrLEnV6F8OfnGIGgi3jNcIKIJT0JMLUa
 H8fq44OzkEsqpP7+Xe6XV2SBXZev4YH3bEQJ9b7w3DljUzjsRUgGSpHoZzG6CtIHCYoVR3YL6
 SZBBn4tIUMTRxkp3IJXvpH0ZywCnWEHLeuJDq0Aex6GGq8CHtE0UTRtC3mmD4qNRg5OSDvp9l
 fZRCX+pOg3D8KKV+xyRGq02ZGADp4kbHo0WWHSi9BPhUHu1q/lGHJxcHVA2ygU34vTK4FDBwo
 6wZgYQufMMw0+L2K2udGnqWehUN1xHovOx4H3nr3wTHqhfeSHQHzY2W8PxOARG+dY4BS8uD0a
 RtUl5gdjQgPtHQc86fUz4YijKrmQojBADRtnlEisEpmX9y0aaKNWLN3TByFdtSjjvj4/WhAem
 6f7uqi1zX/xHNc3qdUBB3fu074MumUIBoDNuD/DfjDc9wAsHGby6odgqEWXcCX5Mxx4k6Ugh6
 rr/5IxBCWj/eJoByAdDWNTh4a1Y+A1SkbkYkegJ12ZkxivJ3lsLetcIQb2Q+zvSWZReL0JnXd
 Bn2Bl+wDY0M3plMfG74RkRzcaEpCm71z+bLuU2bz9KpWqtW1e0NrmQH4vJ2OizBpXmj3vfov6
 0832jD0wNt5xItBQpE7M2LnQmVhPssdd7aBhy3omDMD8P8uwvz6Mf8t3PlZH8OmS5EW3QzED9
 gLFwSPpmh6ZnkL+W6QNPZMLejkb+hW+f+6ZMq3v2JA9BCu0keM7oTGcQ5GCaslvYPeQS9LjOl
 DFELszaunmJyJ9V4RLnATXGqG9j0Hah6X2QfrTs+To9oTmQzM1BPmMNzurFtnw1LWeac4s41s
 uRsgX3Vc8F06UcTFtaYBkfRthtTARTWuQyXoUy/Ph1XtwMTSLtJkmUWRaiv/mdh/Cu8CxXJxL
 u+BdoXPhytovOlEcp6roFuiPQ5XMTZ+LXJ6bDxNhjO9oAGDeMYp0Zh3JNDBsQmxxrOUY8rh2r
 0+k5JrOeeESpnS0bRC01PeiU/bVxhAaHY5gwL2chTizD6tZY/zVIjdCfkqWf4JpvdXml/KBI1
 tKFk6Lh6FFhehSwwfhvHFF9kH454JOON+HgFKVVfW9kOBa9Yles1ju6g77ZKOQxIH5NOYPBna
 H1mZUQ3gjnXkL9k7vLORV3zwkxrI7d5aKbZMCKJQQnwKw==

Hi Andrew,

> Von: sashiko-bot@kernel.org <sashiko-bot@kernel.org>=20
> Gesendet: Dienstag, 18. August 2026 18:27
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Cc: robh@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org
> Betreff: Re: [PATCH net-next v14 03/13] net: mdio: realtek-rtl9300: =
deny C45 over C22 access
>
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Using `dev_WARN_ONCE` for an unsupported hardware operation =
triggers kernel=20
>    stack traces and potential panics, creating a local denial of =
service vector.
> - [Medium] Returning the internal `-ENOTSUPP` error code instead of =
the standard `-EOPNOTSUPP`=20
>    breaks error handling and leaks internal kernel error codes to =
user-space.

In contrast to your v13 advise Sashiko is unhappy with the =
implementation
Switching to -EOPNOTSUPP sounds logical. Regarding the other complaint.
Should I switch to dev_warn_once() then or keep as is?

Markus

