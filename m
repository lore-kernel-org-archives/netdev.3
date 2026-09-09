Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBD5616C0;
	Wed,  9 Sep 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966102; cv=none; b=hVbrc7Cv5mhbtYKmzPsUBKZgk5MXqz+sLNcqiYf79BuaM9byJ2FaeXYiv5WIQMJyuXME15IiZTLP3P7qH22CwdxdVLJRoJ6hC1n0AHQDKlIW5A2I+cLEJV8Y+2Q5YVO6R7vFy2gGmx9EsNFGnPaeDGNhGOpa2qieMpeYUqKIhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966102; c=relaxed/simple;
	bh=E1gU9s1JFTwdl2opK3SUIz6eWqLgOffYzpKSSeUP3eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5u9B3HtYW1lbjND7Y4f22ikNB9ImVruSdwzQI+lP7zSuwxm9JfjY3rOdu429/Pu1fWdapbvSDut25+YClMrbsyWdTWxd4Wz3dUj/j4SISONL9tGapQsalAr7e1ZpWG7+ASuJVvaV4ndR5B1E/X8n6GEdouwkSfsiPUMnFsYbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=iAFdkRUU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="iAFdkRUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788966090; x=1789570890;
	i=markus.stockhausen@gmx.de;
	bh=E1J1Tn8G0yWnKRkirV4MiPJoh6Uq+aC7DKOJdxyOTOk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iAFdkRUUwIDCTrr2XL8z6ZhysLWDWjQA9dkrS+MOMUhDq9/RyohGCW82+fW3GASX
	 /wgf381yBcEecdcy9NRubLcZjeZR9z7hfho1r2AgM/EmkqucXMSRVjXPxzP3+JGXl
	 FFHTOX+PrEPyBUEeCurFSH4OOPc79NIYlh9GQ8q+29mJ2OygwGXcmB07td9NghUQN
	 MvG3m/FIDjTzsgvayJntjnomqXOqKQjJPWk19c5mJjwAxnp/38+ptFI0RBx3zUovt
	 sOis6TPAnEQpdZ5yE2ecGSGKvSajO0sUMVe8ausw6cv5qLzFihE09KLaUQUDqGb2A
	 v2FDg0qJ7pmrvrOo4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1wtemA2loJ-00wBCs; Wed, 09
 Sep 2026 17:01:29 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 4/4] net: mdio: realtek-rtl9300: Support non-default clock frequency
Date: Wed,  9 Sep 2026 17:01:07 +0200
Message-ID: <20260909150107.3602067-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SE3vJcMXBPvDUJ01oLs1A0ePvs8z3JRvRjXXgWOVgbRURWjkBAv
 kq+7qUD1nP7/xIJ0ZzPUmylV3/xkKI8WDeS3honr3v4k8315Y65/EI3Wlq45I1sqGUx9F47
 dUilkDmx597V1H6hXt4Cj9TH9Ge/FGOTjCYhfPwRPubUTn1Psul1PBgCzd87VFrX6QjH/cP
 NNqJ6AmRsK9itph765NgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VKZO0mCVNjo=;6p++CHWxYBTdXgJJFZK/1oET+YE
 per/9hFaXczXyVp+ZhvJSQ2tboNjq+SziLjGk1GGoGPSqflyl39lrlMP6SN9+v0ooHtwpm7ed
 OAwxSAqS3aAKa9WRnHz09dp0antM4M+CO3UhxKxCZFm11XgIm2l2kuIyYllu+fOgtcpPQcTGL
 /KKrtr5zxGACebRE0qLWL2XwIqRZpISzl7nmoEqEBetNmiM6KphmhfvLicaNl4Ja2DKMQHbVF
 VObkvoeUEEm6GX5JqwPPvtcOn7+DJLgSuCUWebUdvHQbiO32PXtDYuP66wLq+dBYhWGwTw2lh
 GscsOy2pteXWuBNa87Vc80Rwj/vaSWFpsQtwOkvkEScKtxTku2bYijzNrTOtapLK96VJkq8fh
 CaeHIBat0tNM+0wmWuMHiTf1w8bb+C+xIZ7Xw7yP5quB+kAToJh4/GzEaIki1gABNFC9J5mS0
 rmSWCi7BBl62dl/eKqIaiXczdgR+VhD1I/BeljbAbhtHNrCRL38IdQDFh9i5Jqv5mdkETDES7
 ggQlbex+ZaCLTtQFmLnhQI84Y3O6Fwd9HZCNxVwQj3y2bgUZ3sG7HyjoAhebeAzstSdET9N1x
 YVQQh8iq6YkDCBk3ipoqHrA8IxUMC7B73b+REeWM6n8kF0ACa2nrbIDWGiCUrjt6cmmLUTiRC
 b0q+dYTdgAZ44injvaoPp4YMv3fiG3rp2ywEQhPvaTEGXfWyhT0RW3vY+ALIFcTkrFxAn1OXt
 BbMSU8LP5WvRRa5xGc0Cho3lb/++BajNCTUFzjoA+bhLJotzqI4kIt//RLauTbur094SBIn8b
 +iPZA7RoYezKfFr923+RZItgJVZHfqBNkfoGRF7DwVQei9BdFfu0JVh8qStbkj2aZLtvOaJqz
 NMAFHNpMAUQi0Hb+jVTV1VkQS99mA2QGeir7YHSZoFazgfRFQKw9x9W1I6t/NGZDahaQCAgxb
 fVVmLGzx+SvnHOIZaLSVh1Jir41tTyjBfcRBJa3PW5hPkQk6GUObBpdttDyXw/ajiUf5rY+EM
 HCaWoDov6IwDkKxd2HmuPukzhTWxRRwE+WlHKTVR61C/nNGd/sVj+Qt3onWTwj/8fxi7IUlsc
 iIIgtjNS3QD/KiVvGQ4Co6S2hIE03eU7Aeza5FUUZbvKN4riktNEXkPzsVWmcZI0I3ssYw93D
 WlKLMnJKCIMrFapKfPlMqRR5DtkEgjYEF9UlzwE1U15tVjC/8Hbk0g/TGAWh1ZnhGHyx+ilQR
 yJYqPzYwOhK2xd0Pf8+cVehBQTerQYRYipPea2Ii+toTXoUdy7kj4Pz5Gmj56vBs35+SJ9df4
 7/vhN0gZFjt1mU42sc/gk9pWHdLdOf6YCCSK3oUef4z3hz8sUCeGqDVzllx0CUVOkWXdnFI9k
 4dQP/5T7SOIPe6rIhOSvhgZXP3JWuF/Wyfiiv9fcAihgQEVWBlHpWkxwDT4RjJIUTaZ2ulxvA
 iro/OeOaCEOB3bDYjsGUXqngtyQQeAb6HBW+YDaWKlRJ6DXo9lgStfWrbgxbLyKdRLXdQFrK1
 mVFjmmxpwmlPtXysj82OWIAJdliXbOl5eZsCDBunl5bgZDM1k3r9NaQeOAdzYm4SrPiFkp/+1
 60DuCyMlhsRmIfHkHv++bBsiGeccvrw/2mSJP+01V5eg6hjr578Z6qj7nuHLkBjcvV58j5gSe
 ni1Rb0XS7HpiHUy7QRL3VLOec6OmE5OSCePhbcixqujp7WE8cF1ol3h7aqMlm4PzLrzw7IhDK
 TtiSc/IJYn5MpBly8374s4pYsZ3iQ08YGstZpRbNz6UU12tai0o+K7AZw5xZh6q1GBrfup5p1
 H+9Dhho+bsZZzPFl1WAsEsDgJf8FBb4EGTeLU0itbTXcep0mTJ1csciMBUVy2pIWWxm9ZxLyL
 VRLFFUotzr2OMtC7EZuFdxwnbsRlg/Qeosncp6XPsfKadnslH562DyaGLQy050h3JmeE6B5S/
 lDSMP7tzVUzUrmrYcedB7k8UqzYiMqgHO5UHXBJUVdgC2DvX4u12Sak8h966a+RjEQ7yR7MAV
 obB5UtUhNk0nwursyeXLdOndfClycBWEN/gYlV+xosgLFiqfrWeLfPPgXk0HKSBNMAI6P5Hee
 1OIVqF4m1XdDxMMDOPLBw3mK9DImA3croKuOtlgdmVSTbasKE8yQFCSGrYhLQmLjdyJZSRnua
 xah6E/EdHLZkl2O6WMkhKDd7frPucCH6lBSrQm4vIVLIvPgymEMA7os3wEgcY2PfmY0Bh657t
 UCq4aOJIbTFf+xOfYeOhiUa1DYytxNiW3oHIweEoL9R5DmetX2Q4JSYsi/5hvOY5xhPu76Mcj
 /7wgxBxY7dd6RZUtgVXanxR8+GQ2dB4BymfMNXIuv7csDJq5wd1i9/VMkBNUO+aBV9vw9Ws5g
 w4XGmWUZi+rHvETo5kX+pmF/dzEbEbXUbXQjL79g3ksr6nP8qZ9RZOyEUw/Y32/4+ZXzL18dK
 mWnwv5DxCgZT+gqnKJfEmcGF13rWHQCwW9icvCD722M3ZWst0UcUmvIJ/a2QZzpxbukjYYzot
 oqlD/wa9lmxKx4w4n46QcQzFkQg/DUb/odHg/EekMp/RCW1nPqLbFNwSJqaX+CRFl5l1X8XH1
 o3N+sFxLpJTMQRkwI0lqImihekGym+OlMMOqrSHtLu6NF+HK9JwwBfGKmQmie8BYQajCYYjWv
 n5s8wc2qmsgE+nXmyCYkHGRYnhNWc61LDPDOhYqwEA7u8u/BDhuwAsFPtxGu9saMMQjkTDS6h
 GwFMkMx1lqsHWOXbVfrMWgdHocyDeeovcHM+BDfjazb6N7aXibeGPGx0hDysIeirxci+jnIAz
 IYjLeLCE4eDBvRYUZPR2Pu79HrRSe1snbO5NwY7BgPEBcTeFOlj/XUjoyviGVIqr35LB8q+/Z
 TR02NF0FjZGN+sbQrk27S3sP2CKFZH39hlljrbP+jdK2KnsRpoU8z6N0Xx2f4GqdwiImveBia
 ZC//tcamfHjHYV8Xe0A5QceXzhO1KOHkgoc0zsEroN+ZagyhFKlaXlKP7IQp/6acq4vAGQg7l
 Qel6bVj4IGfVENjMBrRG7C45eA9s1RobvQjOsxNXWzcd8TssdUtp4gdFkh++OhC3RX4SITxAe
 jC4bSDqbqa/S1fJh8VnodO0V7MBeBYys9y4oddsLr2j3EN/HxiyB2Wpi84/p12TwZxqAabQbH
 YoTl+bUojlaSLiRDqXdlVZUjdaRnpiqgBfj1bgCkIV170VDjRjwva9htuPlEvSM9P4gwsM7pi
 SICVB4qdR8kM9YnG131gJXQd0j3azaAoBPuK4t0v0aw2Lq5FqclCbEAp17UrnvT/95FDYK9Je
 Du8CUcFxW4DgKGRrmLQs5aNa4j6sIzID8/40At4Lpln7MfLGJqtjKe0piTytX8U0YWiUbM3Oz
 3h0bAyrcs2vZDbOyo3P1W0qOS5YFxNzS6NHY3ZmOfU1srlzI5t/0nk/wu1iOQXL5MBmq32otA
 8VRlxdL5oXTGXtzxfE4JcE/2a/blQtskNELrFsTlUmMH7h1cwLrfuvP4h6wIkgaDmG6HkmQi1
 CkdpOqSwcT7mmhDHvywt7DT7qmXmY9dGcyARoVT/R2pCmTubpwOAqiIpAYYy7W34eLs8dkJsc
 sFxyIucsC7JKlW6rlE9e8dBeB+zp/EXYuAmu2ZGe6+rEE69cwA3TslW8FXwoPOIIHGqZfNDe1
 jIIBGjnUdACTN8BWmqP11ZI4C2tBPH3x91c+tNQ50qnGgWUYLO4dqUuc9+rEjiNLWhlBgk+ZQ
 D/DBWgXkqC7nFgyUjMYOkyh9ZlCgYZ6Ul6+x6tbSLtJr4F99TNGkeU2P6XgwSNSezz2bR6jIV
 UKn2VDZcDHLV+9SO0y++Ly+yquQgIQQixjxSboSumg5QyibnaSUBWywpygs5NCor96wraR+lI
 TxKyY/xo6CEDplPbE3VRSyGvqfd+nf8S9wl/IzzXnkQj6pvURAwuX20k6M7afsiUZnoKwm3W/
 fKqOs2GTx9zqGY0GiWBLe30ApAAOCnresaGE41mryu6xljy/LmhlHNAw0KxTfpKXphnQqaLIe
 jtUDKAqKCPKIYe6xy2990dbafp6dnkuDctOwXyQGoWN859FV1I44uG2VOcrW8XVHDDAZIfFm+
 96KUYtlLPttPYyq6KuO/kf6hLFr8f+9acgDXicyiOXnxKVhFfJiG71uCauhNXU8BsrE26Tjt2
 Ato+OeHJYtAIyKip75r8c5J2CsXPH7ceC9nUtnS3yJUSaOSh584oGHoaQAMbCPwgJtPaLUyA8
 sXy1ImZKv5dTJHktBQFHZBq15WQnaZZU2nkr94yHpHX7suHhmuzZRMytXyMp6GKlGvjSKne+Y
 OjaKBoj0Iw2+VhZHy42HedxlT1guwdYD8plx9OCc1/OrgaqpQ158ar912yalvFrn9CRgcQRLV
 QuxyTwxeivDkBxexbhof85EEh/+/8Tgco+tVhMgaILU+JCFKeDobR2voH7CqIU4Q880HM75iN
 e8Jrr1ONEAsYVOCI7TcrRD5fmlp5Ab2uNN+LgGG4X8pN5tR8svjoDbR2YKgSaVnzKvgETZ6mo
 nfbCL2wdg/d3oZJPkzb4KPpET7trDny03qK/EfB8XucMYKze8Go1qklhpD0nPrrUdvSxr4Tyz
 duADbSf1PEl2svaijqKXDN+/6YpKX7Nalz4e7iLTsfOMFNuxmaQq0iYyIXPMitnUBjhOKYevZ
 Ac0prbMrpevvGfvr6+ygPJZEntDrCtAShN7Jz1zdUuT6tKDHdx6Yp6QR/+po6B0tWAYcGzlZp
 zfZH1tp56V87X8tU/tH2yeV0bsKG2E5grlClT2DfEJMZ5uuX4gJHVuTVtLT9l5/NoTH9Seomd
 1TsFiVHTlwdLGzuYePMi7sdBiLlLa4kco17GmUKit4Ev71F7LShLzw2Kvwf8djLJYuc+yBI9M
 gpAJriVX2DwnTwoLKx5zpCNOThUK6wl83gejmnSoHHW/ZohEK5bodbfXqvS7hgHDZ2jIOxrJw
 Gu36V+6Bm3SxKGn4S5PV3WlZjsXmMdf1zRUUPvm8pPDR4HkN1w7eCs8cAlQZo8akCxasuhXmf
 h9nGvfKV/PjLQ5Cy69ZgTWHZ5+N91R3KrcQSxFIIIarkIRTH8wDvRZvQqKH0qu/BV2l7GAXWD
 9VuCehwvyitrL0qpC1nWC9QHUaL3xWE8O9X7/ORvKGoUjP9u+P/sUcqgQcDmTcX2874EPW4DS
 VYUp2nVTpzv5Pk+KYIMl8PyTyWiu5SJvAQgJ5lo2gSLM0Q2x5gipiK3JxDjVnaP9JcF4/bvw+
 NtmmAzLS202jsceK0uS87M21z7I2zgdKjAyb2oaWjpJskY85/7vPLp42gbEmNrG/P3RkP5brm
 fZDvuwtY9neu2P3FGS7vAXWveoHxEjJ2JSuly0r+FQQXbmnwgX4HRMPOcJ/SuIrFWdIJ/D3Cx
 rfhJ4jzk2fRKTrgZ46c9R8upQ2PVTFeBtxlluNoejyuoLfOmZIYUAHaZcS5/p+NVgmSIKKjBz
 61YHXvy0zV/jrwTFxvkwPu6A1AUjCBPgLkGlIVuDkOTBwW6QdRxRXf81y2ERkMeiUgqouu+uI
 LoffisnnNN23dvoNt0sNuR+jJyEoItQAnLhcFEq5JAACUUmlXdDRMu497Iy3O/09C2Y2BiJl2
 OSsmc/ew71vrsnp3cn/0AZ9/tRADG4iuBn23W/4HewtURIxvEH0eXngrBzwg15z8cGk8zR1Ux
 zL4KJlQIdHNW0yC9w2wm5WRR4467DEDTS7BGjN/AiG3DPsY+FKMaLi2CkYdGiSdnNxzBPfIjB
 eGhFMBlUjykxjHhCu/BP1Ov6nMjJqALcxLAfwF+AVlrigst0x1W56FdT26kM9mDP9ZII7dlA3
 5XzyiueDCMdDKA5GDZcW77Ky7r8E6/bgjZuDrrBRrLtULoEo96ZN5UlDM/yGoNcFMNgNZpt+I
 75vU3gc0pwAukpodddBGa7VVwoj8nBuPjkFI28mL8wXIOLKmL0iDx+FVIzuLKekKd6Q+Gnuhh
 5Repmqg98TX8CXhdh1pp/JlMUUnvM7+6ecHGDusYOVhSfREeeYApHzKZVJW50KyVZjB1akPFS
 LUQj6HWZxb5gPeFJ+eYSWOfdV0zBdzWxj4APQLp0Ha3tZO9+L8FH6SGKWNAi/ArACaAMlXkUm
 VLfrlzHUm76pdSSaBLE3ihfjZkpNC1UHKW2srT8+fSM93qzyLo8xF96FhzhrDnlafXfJma2Fy
 Fq5RzVrCApN0tVbSxwMsObVoi7r2FSd3VIljfzGm1JoRujjRVi+okbXEQepH82Vb2YLStoirY
 lKfFzzDlurcTivglhWUvqVo1C8Yt+ywjxFRHHScwpGfn9b/dGgWq+AnFVnOPZDD19LMfwWzl4
 s/7nCRRGgDv2ZSiBuXeuR4xEqRkZFel3mErQH/782IE6+y+NIfijr3RNQK/uUdOXJE8SkYBOi
 foy0RTAXkOAiGfp7kYCxD0FTZDLP/vA33lZPhMKC6iE8zLq1W31LIEJRyMaRzweJgMFfEllCX
 Ouci0ew2ptlC5BNyA==

The ethernet MDIO controller of the Realtek Otto switches has a default
MDC clock frequency of 2.5MHz. Via configuration bits one can adapt this.
Depending on the series the following can be set

- RTL838x: 2.5 Mhz, 10 MHz
- RTL839x, RTL930x, RTL931x: 1.25 MHz, 2.5 MHz, 5 Mhz

Enhance the driver so it allows to set the clock frequency via device
tree. This helps to

- simplify protocol analysis with a logic analyzer (lower speeds)
- reduce MDIO access times during normal operation (higher speeds)

Note: While the devices normally support a per-bus frequency selection,
the RTL839x is an exception from that. It can only select the speed for
both buses globally. To avoid device tree special treatment for this,
use the per-bus speeds for this series too. Return an error if the
RTL839x Devicetree specifies different frequencies for the first and
second bus.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 97 ++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 14fc98949fa3..d40fdd0ed2f0 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -130,6 +130,7 @@
 #define RTL8380_NUM_PAGES			4096
 #define RTL8380_NUM_PORTS			28
 #define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_FREQ_SEL			BIT(1)
 #define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
 #define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
 #define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
@@ -169,12 +170,15 @@
 #define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
 #define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
 #define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+#define RTL8390_SMI_GLB_CTRL			0x03f8
+#define   RTL8390_SMI_FREQ_SEL			GENMASK(6, 5)
=20
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
 #define RTL9300_SMI_GLB_CTRL			0xca00
 #define   RTL9300_GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
+#define   RTL9300_SMI_FREQ_SEL(intf)		GENMASK((intf) * 2 + 9, (intf) * 2 =
+ 8)
 #define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
 #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
@@ -196,6 +200,8 @@
 #define RTL9310_NUM_BUSES			4
 #define RTL9310_NUM_PAGES			8192
 #define RTL9310_NUM_PORTS			56
+#define RTL9310_SMI_GLB_CTRL0			0x0cc0
+#define   RTL9310_SMI_FREQ_SEL(intf)		GENMASK((intf) * 2 + 5, (intf) * 2 =
+ 4)
 #define RTL9310_SMI_GLB_CTRL1			0x0cbc
 #define   RTL9310_SMI_GLB_FMT_SEL_C45(intf)	BIT((intf) * 2 + 1)
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_0		0x0c00
@@ -269,6 +275,7 @@ struct otto_emdio_info {
 	u8 num_ports;
 	u16 num_pages;
 	u32 poll_ctrl;
+	int (*set_bus_frequency)(struct mii_bus *bus, u32 freq);
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -740,6 +747,17 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+
+	if (freq !=3D 2500000 && freq !=3D 10000000)
+		return -EINVAL;
+
+	return regmap_assign_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
+				  RTL8380_SMI_FREQ_SEL, freq =3D=3D 10000000);
+}
+
 static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
 {
 	/*
@@ -749,6 +767,57 @@ static int otto_emdio_8380_setup_controller(struct ot=
to_emdio_priv *priv)
 	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
 }
=20
+static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	bool freq_set =3D false;
+	u32 child_freq, val;
+	int err;
+
+	/*
+	 * RTL839x uses a single frequency for the two MDIO buses. During regist=
ration of first
+	 * bus pick an explicitly requested frequency from any enabled bus. Use =
the default only
+	 * if no frequency is set at all.
+	 */
+	if (priv->bus[0] || priv->bus[1])
+		return 0;
+
+	freq =3D 2500000;
+	for_each_available_child_of_node_scoped(bus->parent->of_node, child) {
+		if (of_property_read_u32(child, "clock-frequency", &child_freq))
+			continue;
+
+		if (freq_set && freq !=3D child_freq)
+			return -EINVAL;
+
+		freq =3D child_freq;
+		freq_set =3D true;
+	}
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	val =3D FIELD_PREP(RTL8390_SMI_FREQ_SEL, freq / 2500000);
+	err =3D regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_S=
MI_FREQ_SEL, val);
+
+	return err;
+}
+
+static int otto_emdio_9300_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	mask =3D RTL9300_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL9300_SMI_GLB_CTRL, mask, val)=
;
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -769,6 +838,21 @@ static int otto_emdio_9300_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_9310_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	mask =3D RTL9310_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL9310_SMI_GLB_CTRL0, mask, val=
);
+}
+
 static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
 {
 	int i, err;
@@ -835,7 +919,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
-	u32 mdio_bus;
+	u32 mdio_bus, freq;
 	int err;
=20
 	err =3D of_property_read_u32(node, "reg", &mdio_bus);
@@ -868,6 +952,13 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
+	if (of_property_read_u32(node, "clock-frequency", &freq))
+		freq =3D 2500000;
+	err =3D priv->info->set_bus_frequency(bus, freq);
+	if (err)
+		return dev_err_probe(dev, err, "cannot set frequency %u for MDIO bus %d=
\n",
+				     freq, mdio_bus);
+
 	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
@@ -1056,6 +1147,7 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.num_pages =3D RTL8380_NUM_PAGES,
 	.num_ports =3D RTL8380_NUM_PORTS,
 	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_8380_set_bus_frequency,
 	.setup_controller =3D otto_emdio_8380_setup_controller,
 	.read_c22 =3D otto_emdio_8380_read_c22,
 	.read_c45 =3D otto_emdio_8380_read_c45,
@@ -1080,6 +1172,7 @@ static const struct otto_emdio_info otto_emdio_8390_=
info =3D {
 	.num_pages =3D RTL8390_NUM_PAGES,
 	.num_ports =3D RTL8390_NUM_PORTS,
 	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_8390_set_bus_frequency,
 	.read_c22 =3D otto_emdio_8390_read_c22,
 	.read_c45 =3D otto_emdio_8390_read_c45,
 	.write_c22 =3D otto_emdio_8390_write_c22,
@@ -1102,6 +1195,7 @@ static const struct otto_emdio_info otto_emdio_9300_=
info =3D {
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
 	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_9300_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -1128,6 +1222,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
 	.num_pages =3D RTL9310_NUM_PAGES,
 	.num_ports =3D RTL9310_NUM_PORTS,
 	.poll_ctrl =3D RTL9310_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_9310_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9310_setup_controller,
 	.read_c22 =3D otto_emdio_9310_read_c22,
 	.read_c45 =3D otto_emdio_9310_read_c45,
=2D-=20
2.55.0

