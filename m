Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976C47DD78;
	Sat, 12 Sep 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218322; cv=none; b=tPEtk9ljdtbzl9cNj7DyREY2F7UcYMWNGvI/Q8gCae6Ez6jrLL0BTjy9A8IBw19oecMOkz1+oCNGdrxOQGqZ4HuO8uy9Y1Uxc3bowvO1pKkCqsNL3IDmfVd9606W+e+x8R6EXf10zmPoVfHgcFc+McmfvO9AmhgI/4+lxVd6QVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218322; c=relaxed/simple;
	bh=B9QKPwf5UF68C6cYh/FxDEMIpCmPmcfK4WuciEmfgeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0JkYiKNF+DRCpkqXFyDnRFRrGE0FiTokSnqFc3jgjICV0fPws1kZPELGe8RjIlIGgkgFOdVngYrVAdabxlDJKLRWLRTDvw8mUk+Q1eQcUi+qVIwaMFukS4uSvAi2/QAZWeWHRtD+MY0WJN384c+ct7ViQo8KZ/9m9OHYLdqP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=R0GZlotA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="R0GZlotA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789218309; x=1789823109;
	i=markus.stockhausen@gmx.de;
	bh=pRGHo3iDhBIlaohnWzGCPr1RLA1MGn4YjsGNN9nBMiI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R0GZlotACvDmnrk1dKlBU4iaoQh1Mt0rOaxygdMqu/oj7RwE53wU7VEZeF7hFKSI
	 CQd8v9GdH6tFTV55zqd2QRDk0/gwyWOubFhQK0dXzzw+ICmwjAQk24N4GvfRVu41t
	 Qwg431ELvILai8g/f7sM4TTnQAxxsVMMpSnD48hlgSSwZwBZ5rHPwktjY945FOUzm
	 Mx8W7JD8b6dhJ7JexHRAZAoB27osF6ZnhLEe4Claif64IOb7By3LzRN8WpP5ijZay
	 EXlS66oIUrB/N8BTDR+JRqPkoGiW2Zn8jnUvSgGbvGAayeYQI30XQjXVbYJS7s9SN
	 ceBPrwFRFUGEsJzU2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1xSxVz06Pu-00P7LV; Sat, 12
 Sep 2026 15:05:09 +0200
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
Subject: [PATCH net-next v4 2/5] dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
Date: Sat, 12 Sep 2026 15:04:48 +0200
Message-ID: <20260912130451.3757276-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KnO8C+kLJKqS5+NEqCeOix/H16rAJNr3aKDJp5RVcwJo/9ZCGbL
 /tUWd/EJ1xyk0tBOmikAEox6AGPQFMlK/APHfF8oJj9TafgPpXCqFGvs67gpJvph32eFvX9
 94oVjyQpH9OU4LQ68E5/kogJ5zKUu9G5lFNVzu6FaYbZluMpAHRypyowlcPRrF9Gy686TnS
 zkP1sItfexHyDjCHNt+xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ufQ16dKUBBc=;MbyylwMM5BCLS0QtVLb9dogKmE9
 /QttZ4wV8zIylratahWVYwfg5qh3pZhbj4TA2BVgQq0XcF8kuun8vX/aKBYDKK92IpxnQVBm3
 VHDg2Ccjy/w53MR7uIchkDON5e97ZklkIxefmQQV+1WUwJn8mIyE9PkxHqByiCJZCLEXLXxpv
 4h3suF8WORnad/1maXfEuVxmDT2S29r6QXt7sAfIyusWnCZ8t5Pq5X9b9Jm+iJXAN9ByPxbOD
 JRt8CUSaVOI7zvRGpAZ12ULp5dpRSxqGmhDajnHWng8Egp16bibWXrQCJDa6wMr7ZXfGoJvGk
 c/is3uddY9Ub6aZL7k7cc/zs+FSJzzmA+AHU+caUMpnpuV2inCqC1+MR7vd8ugQpHkzBLUagw
 hUZqT4IauxwpBMo8gKVWzqpMGIUnNAQ5VgUD81poC8utec3EV/zfTxUVOfoefB5PI82c6BLdd
 xn1yiYw5vb2FtkQY1DiANzY9LiwcnPsGfLkT8BP+OBOA8E+h51JRqq+etKOgQdrbGoj4J/EV4
 bAEivexB3uH2tx1X/otoLHqjVCxzr8XHzoco2TMOwVTWBfscQZPDpx2SpCLCsid7mwwTpLyQZ
 EUnq9u+/mrdQ3U2aI8Af31RPFgrOwRyn1bQK2y/RVrNOKGMnNECslT/mAbgh3xaxnrvQQyToD
 jKI3lG8FgUm1+cveSVIXcYToJDId7BkXSAZWfvm1qV3RVAt9K9l3V4Gp/GPWDcL78Sg0C7kM9
 4aAVKWsg5u8omEisW9pNYF+eMet6spxgEyHz0b2KnkhWwd5qRDrp7zJdoTamJ/9DfKKUR1WSW
 pUTap16ZWzLKM8Dx+KVgrTqSItjlpgEa0lp6yOPPujGDBH5Pfy1/RDG2VoaLiGAc7+NnDfjdO
 q6Lr11QRjKfiGp1PGB0Y+7p5uA/1vYPkf1io8/X0U9VvHinqJ6ad1icmUj746cpChhBYjXsq7
 ay+cJnFg+4DiBsnUOxUpJlmhJIqt+fC9DvTmY513TpOOTsHy2VTB4B3XcJZo6AieOqJ//Wpb5
 V3/W5DEpgFUQiA9zc3npxBTR0X/qmPz4jIwR0549Qe/jhy7j1yni/1NAwRiinjv6IbdA7uyTI
 NY0d4h2+eZfYPP1T+QeGQywynaBMH0zlytnV+qWfUbuAtPEOSSJIcyST15IqmsUKDohinOsGC
 BSdGr3ubRg03CDZHFIXxwM9ulzHc9plZ6mf25cwusBotgC5tsh+1/ZINeksj3fwY0iPukLncW
 6SiXhZ6ZTUqkqsHaPw4HaCXsKAM4i3nOdrW0sNRey6rJWjIMMquQxiLOv8k0eoJFm8z5ijYw0
 HASSYenzik7j/BWAJafK7vTEEOWHuLQ1w3xjWu4uWJCsrVIJ6B/Eb/YeF3WC00/iE6SzxfCOg
 yLhhbqtBCSxPDHiGNAPMF7xtMwN3Z1YnCRJKdoWPrCUcVP10hKQhYco5/7uzlTir5arOfli0m
 WX5CEgndW1dYkplKvJWHHbzklrQAO40xef4OML3cDF526yybJosJpkqvvzUcPxIkHGOS8PP6C
 kh64yb1Cgqm+pTwbp+mJtr/zh47eGMMs4paa1qyrLiO2/aN1rB0NJ4aX6v2haGK1YbpCL+Gmi
 PdeGj2hcXC+Ecvol3WvEaP0vbyB8tk7jqjIWuVqZa6bGVEDAYLyiseAJnOPHSwkxO2wBNIhA/
 bEF0vxVXVXtGAjUx2cgx/dyerbN2OqMMFzsZWV5SzWUJCRcHDc1M1Z/x3bEA33wkBBT/SPIs3
 uoTbsZz5SawBX1OvizrDdqYKmWbQ+FO6T27yqow2IH6TqSvD2jom58eop86qfDJSNVHnJJzfh
 JCvRCnmxG5p1cVGDOTCLsniDlVpgecs1zo5hYt8ob4kdiGK85I5g/Ny/jAZ1mkT1CdVHu9+mE
 qK4UTclA8OPdWZgDhyDKpogs4MHz4+WCLdoERmoirFPYZXLinFYdcKo/uJhHnKyG2S5vDeJ8W
 zstF/1b9qBTT0/HCzvrbCVozDYgRQ0ye2FyIHceyZ8Ku2KijpVCypbQZalkP9DXaD6JwGSjnk
 psu4EdBWjud41MJ+C5GQzPcK+41XJnu1RsFXuV1eKNXCO8r6ClqUYo+U79S/t/D6ZvwD4hkvl
 RqURdCs4h7As46aHFimyXUKj9p4oOey7tSnTPonEdMZqmDGk/y7TktEkZG/qHsw722K4R5B0Z
 4sBaXbo8WC/N3pjrCxh53W38VsPOwzjnzrw7mNQ+gx8GxLZVWFMFYIRNkyuJcSnLkbAjsujqY
 N0mudSd9efBKCwJKTEvbf1nweCrJU42LkY6eLcYZbQJ3VlfgLzwLqn7WL1Mr+WfEH7swmPe4x
 bE2bpUT6UwUJeGt7D+33hxkb0xblo8ra8Yju/c3kcK0pE2LkCB045jx6ouF/C1ZOTnkxvS2nT
 J9FAz0cTvmH8zFt9i9zWEhqjlJ0UutWmGLw4kSZyldpiQRFBFpl4TImLg6LEulxq7pz+s5MdR
 uCPd0YtkBK+MB1B1SDshzDq465fyHFv9TNA5/9Yb+WC84YktH3bXAH2LlQQQiWSH7n6exHIRu
 OBpwQZVN887ENNtWbstRrXzGMNsg1VcsMmZXzlYYwlw1P27qFcW7JGlNNBwgI+r0yTFM4Ry8/
 u/RlPjtR8QYagGkg9CeSQtYC3+JW+9KtOUXH3eAmG6w2FbItkWV/Xp/ebWoKFe7PJC0FnjwES
 2xbn4W7cdq0/j38EwySqgoTH2lBwz8VdtrDqdYUzs8EcYxQkA+0sQj3hS5/5m6o+4Nh4kp78R
 S728+Prsli+odDGjTEcsejYjkl67yh7PAVJ55Mrk/Yj1yuE47afHGiGXiWZp07FbuyAuMoKbu
 POVjvtY26G+T4hfqnCad3W8WdYlGUrj8ALQ6fPkAMcWtIAyU/bg9ZlPYKF6VNvndq2VdWH0gN
 Jie7TicFpO/iHeMw+5SUzqOoyUQYL0oE7e3O69EEq76cbMVYbrzbxwmyPfocUgn0vJhhtCOqU
 QFfmebqZiLcIyjvMjrT9jPJwAUVJUNUfxXK98xmqTgdeeW2apqkiCDVTPHXfey3nrOjbbFAka
 lSyuf3WqXPYDTmoUojii+YBX3roTts+YILQoKSnjpBadlVxhaPsK4ur9icAa5ZIAct/meP2ZY
 nhhcNdAPyF4lQzeN7R4aEZIYld3dAj1dNxto1Q0iXfYoVEwNkGxRJUsHaGyOH3pZgwl7SmVeX
 BGB3lNMRys5QSl1B2OoE8A4ZC7EIgvneviNmtEOELcdIANJjLEYoY3HSN247BPfHLah08dufQ
 q3qHvDXPcpNinur4tIkhrDyIZxlkP7Sne0o96bnBOdBQj5aScd4eFEsumg4oUsw8gbPeNaAb3
 AXlGGBfFkYexNeIfWhQalzrTNU9AKuJyo1A9miER30T+he9hAddV8WHslwGBPaMWNfDqQgHSO
 BoGephx7LerzY49QUdwbo7ijcKazInqeyVJqcOUqYOt3leVauwj1SXj6Yy+7ZDetxoJaTdxHd
 3N4L/a9oZ1yVO+zZFQCTt6Qzl9r4E+cHpQOHYsOdQlNkdd+8KChVkRuQNtczVyfY0lvxDhglm
 IIce02mFn8NICNyi5R3a2rcpdfXezG8Y8xCKCv/2THjv3RlkEmkXvWYLx/PCNCCOeQJ3b/FW6
 DA6gmlcGOI/B3CWvxeGSZyX20XFwhrMCh7NyPrWDcmUk3LSt415R0vRbkxJqAd8GbBrf6HyRN
 +D0pSZ27cW9xoziZdZRGPZQBwKfITmoXuxvayZvDgjnX46snPYw4poPHxMg1Z5GWFIG3FtgDU
 G0NQ++BihTaxAngy2Tms697lX99rW8dMUqr3Xbr3OisXa4ptZ/aPKNCH8n5qobzn4sFhS98L9
 yszUpIpuTYSbbYhHaPi5r0AoQbXT/MOG44wjwzTtaF6GdaeSKWfhZ5P6/OSQA/ZymFUIN8MlW
 +wOiYy6QMACDN5icGU3pw04M3ny06ufMIGx3PPeX9SIJRIlW0u97O/BKu09dxyb/CvnFwPOqV
 DKmPAlDCrChZms1PLGNXu5Q6U3d3mwZUWpFDXuW03PtzkdInHNBjzGgIvNbWX3bPTKLsIUdQB
 DJkdqJVCJri4GBArFaRUEpt4abZ5jpp7OANgGmQEL73N/jS1PXgsY4SSVBlSRc/RkeArqQc2k
 9S9GjnHIx+C7kWPIOL/Wy4AmBmpsF/dwN60xPxo0uoxdDnxJPgy3lvLKAzjz4rVN3w2XkClO1
 B2SmWC0F1tutACBaojNkiieGCODR+FLyYelJwEKjk6lOcC8pcaRdDzRZnxfjxu241yKJ1dQgc
 kYYn1/5Szsd2YFrfbbuuHIhIdHi+To4zDwXy+Spy1M3WlW+6qLGynIxqXaCEvF83MBo846+E8
 6PcjsYihRleG/p2vukx+iyZ3Kx5/xJuejMQgMS6+twJuJNIjZVKRNJl5kt76QW3gcvO2EJbqQ
 JGlkSfcShiT52XtvVs7F770Rp6ld/Tq5jkEdhsxkLinQcaKGBLC6B1uvZD4h0k2pMww9Rayuk
 /m3W3GIkSqSrx4/nvb4E17y4hLVZZiWMyggUTyunetvFovcggHq1eZ+F91hkntfKaI7RP4I0R
 GN7ULrRZ3UgvP1qk4JJ8fsRpKydeX2lxia4abJeldlc6NUK0NA1al4PLsZ/NZPA+gLVOfjITJ
 IEQ0JwBhleqhVI7y+TOHpagXCgjISL+oskhaBMV9zKSirGUaKD9/SV0bLAW/TlUPmTJuA4xdA
 xusgEWn7YAU09TqP5dmWw4Dbydrntd0PVzleY4EvSuvI+RdLQhEUWv4M4o5dCEZAUdlmwhqRD
 cJO2fZIRTG6+IvRcCuwQ9QnxNgbGgwmDl/X1QlO49aqyDCr8Ki3t1By5tc+U9rlmH6mr7munW
 Ty2NNRvTUV/mqKLxly863RPEnaojlf3FLYJ/EUZsOyTg/giAFRkYCPjmAdA9dCMNAkSrkLiHU
 ZMa8gELgokGEeog9dpMT+WNnHVrPeJy0zpvex7YufVP5J/jqJfylMushUOTjts/Yy4oeYO12H
 G8ytHv/crelzaGLv7U3fpEiBUtVrGv0Hfbkh71wRcTmCLPgJhYhVs17fmEH+MAHy/c1by0nK9
 tdcd2yCAbnBnSz9f66EQNHoSGX0qGpCquXMUtYm7KLmuRd1B5yCBP1fgFKi2yXsM15vuXw0D0
 ym2fSBP2pBnfc5N/816KkTc6oU2RRCaPFV5ZmoGCxERxkywF9TQpGUvSmhA7skfnPfUApFUro
 FAbkNoaqDxO0O2Lz9IZVE6Yk2XWsH9BueZZ6ZC9r+c6NbWlAz1zSIxm0PR+GbM+c2wGEyZjXw
 w9uEqIqdhMpCOMmrZpB2Qd557b4mPM9ad3QdtfJgYwYbZWteaGtFXqQOd8//icXEsbLw7JF3f
 2qCjvFIYMtvRubn+hCC8LZYq6M+OE6Z55GJR5zzxoI8rOpXotbzCvpEifnPLXPALLgEOR3Xfy
 kW0LWYQBqoSiyd6zFkXADEOEv1Rwn2mGj8eandxPHi2kKaZukO3+E0ifE4SAraIa9wmfft6uc
 LXTxk2DilFJse9mm6pK0JcJoWV9PbpX475SN7/lqXDChn2woPZcy9jdIgSgugnJbUmvQ0rsmg
 h4ShqOKOuu7Fw6tvUbZaU0qZSlaVOPzyLLnnNO+6B7M5qPtRW/Nws77+Zpp7zLaDsavv9Qdp+
 jdXQts0vvGKhzdCm83trxwklvVT/jiE0nYrVgpR+aWF3NHCfvCLvAkXClK9vg8jVMURucB6TE
 KcUSL3XnCZx03FKNKbK8djyOb3+hK4mJH0OdpfrUKFWiqe3Us/A/elRuglnavQ+T3N0PeQYnP
 mzQUhWMllWNYGqewKm/Thcf0VcqkWu0Axpn7chp/FEPewCd4B/nIx4AVJNWiUwg99VyXMDx5b
 t8vWxw/SLewl/lEL/BSyw5P0w3ggyhTP10GR0+q4QbDWbR0ZtVDx8l7kb55QJTCQlBuO9UI4B
 iCS0hTyY2MqJuPn5K30y2xoo46gGpTQfaBmVD2uNOuRjm9fHfbSSH47wqvHfsrUPAk9EDrowH
 Cz9MmS9NyRCjzy+yx5eS72dBy+h0BM1Iyh/8cHazIFS4H1I+1vMx3afVa55hsbqU6zXiGHndz
 8YQkNbqGGJlKX+p9X5m5dFwuQx70cjuLEZkxbKb2V0yRRj57RD0Y29gEdEmxvzv3d5ix5/LiG
 Eouahpr8JVY1F/M5JcWJkDVUt06Q17jRzWf4lI2G1FxFvzzeW/ZwZGTm8kukBfLmpMuYsls7k
 jcICCk5zLbpkecc0e9ScCzETQ2qG1nBT+U0TtfMUBOczO7zQQKjEr2hOBGmFmtKYuqBq8qxcw
 0zAgmP1/ph26f9oiCLAdHDFVkdPAAsl96iejOMtHjdr08gJ7W9yJmRVwnEnCOd3vrRH1+7qAc
 fjsFoH5lDJ5k3Zcm1aano5xs+rCfKatka9I8IMr8jkzOl1Avdn3yGLQTY4EsrPusFGN+OVhgQ
 FQFk1jU87wlfsqN5nCMct2QIp9TJ6ciTQgCUaFeMqg2RY7Tg7KjYwuz8KJF79aA7b9Of

The Ethernet MDIO controllers in Realtek Otto switches support several
MDC frequencies. Document the supported clock-frequency values:

- RTL838x: 2.5 MHz or 10 MHz
- RTL839x, RTL930x and RTL931x: 1.25 MHz, 2.5 MHz or 5 MHz

RTL839x has a single frequency selector shared by both MDIO buses.
Require explicitly specified frequencies to be identical and document
that a bus without clock-frequency inherits the frequency selected by
the other available bus. Use 2.5 MHz if neither bus specifies a
frequency.

There is neither an official documentation nor any obvious registers that
indicate a dependency to one of the hardware clocks. The usable setup bits
are more like hardcoded values than dividers. Without further details do
not add a clock reference.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml    | 47 +++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 7f5b4897487b..c5f2289dc0eb 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -56,6 +56,9 @@ patternProperties:
       reg:
         maxItems: 1
=20
+      clock-frequency:
+        $ref: /schemas/types.yaml#/definitions/uint32
+
     required:
       - reg
=20
@@ -67,6 +70,10 @@ patternProperties:
=20
     unevaluatedProperties: false
=20
+required:
+  - compatible
+  - reg
+
 allOf:
   - if:
       properties:
@@ -77,8 +84,16 @@ allOf:
               - realtek,rtl8381-mdio
               - realtek,rtl8382-mdio
     then:
+      properties:
+        mdio-bus@0:
+          properties:
+            clock-frequency:
+              enum: [2500000, 10000000]
+              default: 2500000
+
       patternProperties:
         '^mdio-bus@[1-3]$': false
+
   - if:
       properties:
         compatible:
@@ -89,11 +104,37 @@ allOf:
               - realtek,rtl8393-mdio
     then:
       patternProperties:
+        '^mdio-bus@[01]$':
+          properties:
+            clock-frequency:
+              enum: [1250000, 2500000, 5000000]
+              description: |
+                RTL839x has one clock selector shared by both MDIO buses.=
 All explicitly
+                specified clock-frequency values must be identical. A bus=
 without this
+                property inherits the shared frequency selected by anothe=
r available bus.
+                If neither available bus specifies a frequency, 2500000 H=
z is used.
+
         '^mdio-bus@[2-3]$': false
=20
-required:
-  - compatible
-  - reg
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,rtl9301-mdio
+              - realtek,rtl9302b-mdio
+              - realtek,rtl9302c-mdio
+              - realtek,rtl9303-mdio
+              - realtek,rtl9311-mdio
+              - realtek,rtl9312-mdio
+              - realtek,rtl9313-mdio
+    then:
+      patternProperties:
+        '^mdio-bus@[0-3]$':
+          properties:
+            clock-frequency:
+              enum: [1250000, 2500000, 5000000]
+              default: 2500000
=20
 unevaluatedProperties: false
=20
=2D-=20
2.55.0

