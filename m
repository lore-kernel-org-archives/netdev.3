Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916E377EA9;
	Mon,  5 Oct 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186576; cv=none; b=R2buLwEc07RnKuveKz3CueMq4HhY8WoIKETdkFOPMRZ+AUbI2HSQyiQKQ3KYGoiMr9lTCOgMjfSvmoStN7CRviNCRhAw3TEs7zPsBXQM14iewr4HxgkDArHE0fEydPbF57lUBV1GE3ThoeaERe/K+9I5UJ0BbZ96ig7zI7b2yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186576; c=relaxed/simple;
	bh=nXh8Zd+A5MRmqGFvbv7xcXVSXiupJHCxD6XOrXMFjFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/LV3WfJejmxvRNniGKx64GvRDNvu6maavhUThHgW0X6FZ0F/UOEBFwN2SXFhMLYqSkTVOnmJESrmQ4oDKVKpET2ZBrC4tx0FdUfiDIziBH8taoG4YPlGzttOzH0IopPehcMPDzjr8bmqQ2hF06GqlwswUhYmMdvd1w3g07TRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=uhfZA83D; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="uhfZA83D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791186563; x=1791791363;
	i=markus.stockhausen@gmx.de;
	bh=FVKmpywFoREzBsTHfRdj7Pm0y8w1q5LqvVG5EJYJuqk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uhfZA83DqLs6Yrmq9nKaYGuCkj7ArXMgOheXdC2vblp+l4+hL/hAhcDD1oMuxJiz
	 fxTxBNB3YKideL/ceXvChDk961o+kUQfdbXC9kNcMn4vaME9i4ARhoL2x+ii1t3W4
	 TXQS0TUANIVbYjk162q9CLvy7S0sKD7NHAjJXPH20X2SdOo3pYNuDQJD1M0AcuKuu
	 X72o8CWhdVMifWhMbyD12jlhE19InvGws1z6NrUjIekmb+zRlBw3SEscIWlHUsw+9
	 tAjpDVVsKHvAhy42bLNhlgqyzFEijsO4rTnW8xR5vEGe6JIqWz9UnCNWuVsvMBcIi
	 c+oFrB+Krhre1ymyAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCOE-1x1Rix2BoS-00PKFz; Mon, 05
 Oct 2026 09:49:23 +0200
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
Subject: [PATCH net-next v5 0/5] net: mdio: realtek-rtl9300: add bus frequency handling
Date: Mon,  5 Oct 2026 09:49:03 +0200
Message-ID: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S+RH0Qa4hA/QJcyxT9HaC7Bocf4folXRAQARfpJvKc3u9Fs3jMZ
 U1yFWUNcwEvtFnAj4gTFmXakPmganUET0TReL7IT60n+XoPvWqXOqnlh8aI1+bL+xpOE3CF
 WPkpuiiHPHuxp8eMtQa8I+CpoITB1TuVL24UIdsUoEPtcb0MH50ESW9A/QhtSJkEuu8SsdG
 BCxxZg7Hn+wFQzWPjsD5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mZpPXZv/6n4=;wZP3x8EMFlD72lX7dRWnM7gg8nR
 GuZ5e1ib3S+YI1ZNunhepZdNoySg0cC/ffzI/SQ74vHPIYooxuJyjpCZ0wg63pu0N7erit9HC
 67RkGFSd2lUxeeelNwyLA8bux32btQOFB0/tJ9oKpva8wHDiBdtv4goCTZV5rdAGXW25rLTCU
 gsCLKvMeX7EIbxUgwjnZi93aVWXT8W/HhG1YcX6I6e9HhJPO112oQXRZXELDMHnrftCDSlUNL
 lRxooQlWZuQ9r1LPnr4DzTdxYwd7vcuEdHnRYHFKdX9zgWLNyu1JPJr1SDO4VeqK9P4SLrN4u
 4uHgJu44+3W6IlhfojEC8KIjlJ88OCsgpwsjDQHCKAUGmYTdJiPLM5uMaP3jLAqZ37g7TnVfe
 mnVUvDGgk6DY2Qi138rItlB8Izm2yXcLAV9RTBjuaBAlGY++2zDFoJHveW2grWVaZozu/Gi/R
 Lgg/DeulNRDkRrS480daNBHtaTGeHcE0n3NwPIoTkpjSDH5KPThGodQKYzgB9JCHpVLu9TBA7
 wNgmN2BAPK+l8Ev17RnT5VnfimdJqzsxD6sFeDMAPnBrSIo8xJAooTEEuuLBPCmn3ibQrXDSl
 O36nTQzhftOsyeSDJz20WvBbun3YLC6Gd8p/IES/KttBpZG5IF7FqUuDrt9smZECNiylkGtrC
 XPVBnfVhLyS80ziR/XmAEyzlounVsLf7iqBXaJh/wgNZaRj/QaJlwxUrLb1HaPWLjDiiyGcD3
 eCRR7XFUC/rjDuib6tpnnkAM7KH1WOUcPp4YbC3u/PGaCqwIPJ9RzvRLL0/ZX3R5TNcMhfks5
 2TKLD/C9Fije/2fe4J/gdHl1qgGFl1jj1YL2b0KOzEHw6bJc75nKZ2UgobLfIsi24qjmQa5kU
 FerUCEwrozcDkoEHaRyBlqMC5lx9LTrLLOzmihtYfrrY9IkxXcPnINlBuSti6NteMjtcWO7gK
 XiUvS+zQIykq04uK8knIDVYfnw0IsRCyPmGDeP6EiRE/IwtjJj1+eo5s0IW2DsKt6XQb9W7Iw
 QCTFs/8CaHP1D9SRz5mSN5Y+YwGTdvItS8uOWucgaG4KZsL6oMH/vPg15Jr13bvnThdge4vH2
 fxzezwxs+q86Cy/oSnb96jIYP5AjNrphJ850GtyWVISDBh+XIchiCLcpGF/DK/RFcrzlzPuL/
 bAxLZVrGTwC+ldmxfwMTzseaAkkwmlTACba8GqMB0jWTRyOnflW5vQDwsV7uVXKksayc3fmvU
 GixnZ9yvqM8UfoM1/6J4xX73lNnqL4vQ9W/mb+jfOTu2dSDjMBP9qcj+7fhGgvlJ1xBgZh60R
 UDxTesoeGAp23eW3Bdojz7D531BGQhH/teM19AyaVgFrzh5YQJ2ljptIjiTo595NzVRGGL0to
 Fgh19FdFaN+8NOV+/9/Ot1uImaioATGekZ9TKyWR0MsIaZnOFE3Vm8H/8kvif/OwCLOfLuW4a
 h1NVqEs8xCHp4Urv5HR9KnNvxeiX6c18tyBzBnV7+X7D9ZO8Ok/JvyZpcTtJGARrmyaaMQjw7
 xnGMcVyVFXT45oGKv0KoCYabEpW2tQYL0nJWeAmG9HWQr4jWSCHT1E5AhhrHxOec2sFEh0IU4
 C3g14nY652zo2uOCf6AnmRlsAi9F4t0BMgRezG0mopJVkb71nFWRVRGeYVa+09JiSl0zeAUfI
 dginEWByyAopoya0dnQgWBmlV12TIChkJPb7U0O7wgk4ZhyKPQ+QbTAWzKCYb2j5tV5qAVsLR
 LBHZCIj30vSrWSjI840bqHlXdw2yDM11DXfcZ7pp/9WubIccmBcwqa0UzFjkDRwa3JlWPOvwI
 SstBN4tipA9bRPU85JYKQuUgAT03lxmOgSwS2XB+eRzaBJoQJNjXvu45q+Y0D2J+p/MAUp0Ax
 hgRHtXmIZ0VGYBfyrk1K4uOoNToUAlbrrorssi6MgRnsAnhImEf7jg6LXg6Z5qpluIqTjpUeF
 NV9pzmGIzlqlA92KxRT2rIawgljg6OPDJ9B9iN2eJwN4eF+XYtNC3tmqRKt4gEwjLomlsOoxz
 g5qtNjhWuhCGrlG5ulMHbasyt7AKc6077AYQiPKLm4xEHWDuwWcCtKMX0zztNqdjaqVWUOwYe
 KoAfajZ6028CEBn+3qXnWn4vUWUtv1NZeMpFsQFnhTSi48oyr+M5Hzjed3SWtV3wlvaQTLS15
 bzQyAY2TcSKj+xnQXmYR0Jyy2FYDWb5i/gwcZtzlrYr0Yfi5BJgLMCytrRvzxrswuBf7B/uph
 4lPjXJMCyyKAXY0zg4W2RjbehXnvF56eriQVwpWjIQxfEz/PFqi9ZSr5sCDE5WVipGZ8caR3h
 08Kxuk61ylSnpcbnrzEDMGBS5vVdJXa9nxJuwMKawkfW+GtiPG8tvqdcpm29hfhw10ho/pEqH
 S8zxm2gERdvMhQzU/Uis4vbl5i3LMcJM9y7jCKb9164Fw6IEJpbKayBETMkbaiSbtOvxQq5dC
 N91KxnYgdOIqI7OB1IHN0yrz44jevnp86MpeGyjtn26icWMtuXlabwQ4rrhsPsGHEHpo/XlAg
 ty3IsHAA7kHiQuDytuVNZg/Tp30OXU8TIqPtkK7afCqeII+MwV33tjHlafO2njiWxuF9s0XM2
 3/rp4hG0Fmdw9fAbn44cam/YLM9UVpbkUoO88kUo/H/d9YuWs6Gn4JcuVqOhcB3T+WWLPD5DA
 fi4FLwVIuYFV6wLyWKjl6GEhsIoU0u8lek+saLrSXo5ztE2969ErKV2LCQNQTMUd6oEZ7sD4S
 tO75Gax3P1+qHxYo/0H3UI5ykDoFyK02oVkyxwG/3T/cpsq27JSYtlacB30BrUU+DOPPwqP1s
 SKe4TofSOBGJ23E6rFnoG41A0ayZ+Ch1hVdYcc1vpthksnrcThHRflUeYkev1pq6VwWi9BwnB
 Vo3TUXtc3bn9qxTTlY98qzn7j4PDuhcv6fucvU3yY+08by+8KNH2vA/ZxHPoD8DXODbdJwdH7
 xXOQvWeyskZyxPbA3vIJ1SQkSrItvAM/+zk4d/34dXL+cLKvOTB8/joXqHgPO/IxxJ1IDecir
 P4fl5gPtgrgJPfFAm9CMqqieUk0KZeiXY9imDIB/yY8i0wlmjxhKx2vraxGxVwFmlmQo0goq6
 s++tz1D5xLFiNE9xmG4rvYSE9gH14gLT6K6d0ifSBIREqhEVG8UByTDQEFYrgtFJAS6cSRncO
 +Qw1XQLyaNbn7A3zEysXZXEfcGf5pOVbhwnImS1aAmLfELML3sAVChzo5aASsVG9LCweEp1NJ
 AdkTyazKyfGRxNyqxDi3TCxKQJNXLzLdaDA/lS7q8k0zRWvOfaBcRLtcJeFjJVWUvcyBy09VO
 2FewgagGpQlWjr/zzML2kJFncKs+06KzhFYJRErQWDCio8K2J7X4NNTUm01c1wlHYLF0ahVR6
 B5OZVa4rdag90IVexwBSrkNWG7Lz5HCUtgaTSJNCywX/bq7abKh5/uALUShmH/muP74Yk7Hmj
 tWoGqKj09kwj/N873KiEH3qd8VvyHfudtty8YAYqfCuPHRrBvzCtc2eKeujiElXPu7i2MREJ3
 JqwIiUOnaoaNYffB5zRHACAj5XyJEhzWtCEoBElRtdsYwjhsgWg0hAPCLquUZMWgtTkK7h5UB
 JK3KKe6leLmn9MEpsJkQumHaAmzTKSgHGUQ3CE/XmlQY1nXyuqRE+J4CeJXZ1XjTO+rPXFnUO
 hfU0KpcbMrIrnJYW/yuQIgiPANi0Ku6tYldGp+49Nx9x5BifVAZiZmgxEn8ikJVbJLR9OezPI
 VKEr52avLe6y0CZhE0aNpM8vFzZGirZuzD/ntD5NdzK60qNy60nNsk6Z7Za9E8eWzlxmNakt2
 f7FxKXmkGxWhJW2A0LNud8zd4R/C6r3qXwLHwYl9zXnbZ5DPwnHqED6AiBb3UOg1NAaaUnuL7
 vx0+FqcrNHrQ0Mi/Njrn796pMznRa+04GGSfQhzk1NLC1SIZfWtuse5DDlx+2MbOa2v2g1nfC
 SIzF4hFE6+ySPnSj7iK4Ol3vOOImJve9ic0rucCepiA6lA0699rybR/8jj16I56ad3agLN8pC
 LR+36znWdQ+/n6/rImEgA16bQbgmBFUb1JmKAeTRxws7sTnM4VzKkRggxm3rIEWs0rND6/tKm
 y7V0LXFmKcuWFmfgBRWVCux0GscUGIU6/VwXZj6xfjQyYc3zZwOv19e9IPMc15tmjGqI6tlIi
 8Ushpa2xAmMXJl4TtGZ5RkxPR72rF20yel55KCdQQg1wIMwv6B3SuNV1X9Potiqo4VUp4itZx
 nnbOklPHcbeRiKagzmsg5dDZhGFjJmxE2FMVuglfowfJaKGN1AApWU3sDBh5iK3NzBBZktHh4
 53YJJXo4ZVSI3s2ULZVwT8dnGVmVbK4ESI6lMXh3Ubrg/v1g53TzuC8R/0JkxxRVXgsSdsqzl
 Tbyj2ZDANxov2CQDUza/GG6OXL1T79iqcP2BaMGMgq+Mt6xlIOUITKOds0yfU8sm+Uhu32zF9
 hYAF1jv1DQck73GlFTyeVdeahhrX1n3QsVYkfuav6oZlzuhEV2hqy++YRUsRdAsyEZtrrhyvl
 eRh4BIHsMFxjy8XMHTH4KQzdcCm90VI9QUjggVwfXBx5N/rROxhO1eWYVLQLgI9IOZdJyqGfT
 4dbFoynTt7lXAWvi5XLGUKRJIYed7/IhBPZGRNFOnO15zWZu7GAWN60NPk0hT1WVVAJ4nIgFX
 ML+SLf5JkUnJc5gilCn2eV3wpa5DqIhpKyV0uhCnSA+/Vdc1Uo4BLxU58JHLNXSl6yl6Lncjp
 TW8HOQylPe/qJljt92d6ASWuOzmg/F2laJ4Ns30SMEjRKdwN2vg39gr5Qgy4BWVz3BUthC2ia
 K6EN1ddv7W835v+kxn+UJgzo/NvvWQxNVXv5w3TT1ZDaIky++6HhGq9fEy3CK4BiWsvvdG6bA
 M/g1nJsHcWeAg9mH+31h+F8ejNkEHqd91Dw59Gyp+L92o6ox83Euq6DIZKb5aWnqfcq0EAkQj
 4JLwXf3A/MtbuCbqukYYyC7Q5KZOPZMqz4Enbl4LlcyTC3DJKy6oSBuHUXDYeoS0uO6KdixQl
 WQmrRuxyYEiK17j9u7Q2tpbZfTVWwbFpGEm777m4TnY7uGIiqS2dC4FmQ5eYCTpAj2cTw9dPz
 dj8GvfJYAACRrEwswsE/4StjAaAcGlN6+WKe1ZhHrI88iyYnCNlbcIVpg2qayW2n8XyGHmFYr
 VsI4IflwhMam6Ok1VHCmTuIWuVtCkRu8FLQx6WEwr3z6HjADL0ouDrCvIfxwYRF4NuAZ4Zafp
 H/h45Gy4BLGKC1PFQmoMBqVUgFJ7TUBQp4ojFfBoA2oxXdKdqe+NGHiKaokJKpe1uAhsoIN9a
 JtPDkXMKrE+0EuIWctFeaFvwAHQbRHZ7X1sojOg7LOYZvzQKVQLI+J/+nFEvETQK5Q2AzwQHR
 uWg5kPCt3naFHz1aPdvF7ztKLQ/FMb9DiZlwsbMC/S7DixozS3sQBI0hU9DhphjP22AujCXrz
 HlTZ8UvrIvmXIBV4mhpkA/uN0gb5dypdwGf1Jn59xj54mya8m+HXLaufqFfP0fMnSKtVfLBCx
 KaIhOc6eeJWJXP9j/vBxbbbJh7KZ2tWZX9aFsu3erjo0FXSW64mFPQqU1FpVV9PVk3uvLqGJT
 Zb5XWg0gQ5ihsDvPNTmBKbXxx4mFmIFfi0rcMNTsOKKTsJRJubAtWK9OhMMI7ZlSMcidKs2FR
 Ywmaw9FTeYmeQkBlty6vPiDc4n/ld+Crhnxdzo3ty9bgrVoN3U0fLXPOrIfSRm6SyWsMtmmLT
 EniQpFxP1P2s9abxbLJQHwoD9Cca/J1FfTpezfGJ1QGeM+C8e9V4J7x+2nutF9r8LdUppy5wl
 rjKHcLEt7SrTd9d0UeV1RsRe7aFmiTj3+RUEwbmoCUpKpTc5t5OLEt4sFi2ZJsikx6DyUFRPD
 vUj4NRvkwgjLP2AK8GYoQCC2Y+vw4rHwTTXdlp+OUW/0SogwxH/bEXC1+2KtMh8W0u08v7w/v
 5zyhue3iyiceqA+16WSwP6AK/+LktdhibJklYqOJNtHVEqB4CD2JTXWjelel2h06XQxeAa2A3
 XNzdIYl3kLlehXHI2GeGBYk+8bh9xidxtBSIvsJP1X8pXD+P3pVk3LjpTGLamgSClLREF2ZVP
 zPQcy6AamQ6c5EPbuYsSicCw4pQzTIjT85I1CkpCe9C/GST1o+x5X0qn+s3bzoNhfI7oMVQTE
 KKaMmfjKPPq53zt3cxiLFyBTXyBNg7yhfuYie1PAHUMedGqwFQ8t2FvPAEI7u39AZidmYvdqf
 0jDGKE2dZsbsgXVtdbzj0GeCF284rhUNZR6zrr7PxHDf3K8sqyoawDrTbmeQkHz5Sl+ijTIUO
 MIw4Cg1Qkm9T8dMKsNbgbJUmW07jlxzv9mFgqKPTLiGgYOwojrzT8cAlCQuQVcW8RGjKLRIYa
 tqJdbhTeJOnLH/ORB1Di/uBU3++HhU1lAIcXx+aNY2MeVZyakihfN047mD4ZK66ye5waaNR+4
 V+8qq8NTeLIIvVU0/ehLGUwvxbDaOOhbq1HSTvBHvgDbXwwi3RlArqT1Bpc

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

All of them support changing the bus frequency of their one to four
Ethernet MDIO buses, although the available settings differ between
the series. Extend the driver to support this feature.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
v4 -> v5:
  - Drop "clock-frequency" from devicetree (Rob)
  - Add Reviewed-by for patch 3/4/5 (Andrew)
v4: https://lore.kernel.org/netdev/20260912130451.3757276-1-markus.stockha=
usen@gmx.de/
v4 Sashiko 1: https://sashiko.dev/#/patchset/20260912130451.3757276-1-mark=
us.stockhausen%40gmx.de
v4 Sashiko 2: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912=
130451.3757276-1-markus.stockhausen%40gmx.de

v3 -> v4:
  - Add new devicetree patch to clearly describe the number of
    MDIO buses. (Sashiko)
  - Harden devicetree clock-frequency properties to match the
    driver. (Sashiko)
  - Therefore drop Acked-by for devicetree patch. (Markus)
  - Improve fwnode to of conversion. E.g. drop dev_fwnode or usage
    of unneeded includes. (Sashiko)
  - Reword commit message of frequency commit to better reflect how
    the setup logic works. (Sashiko)
  - Refactor RTL839x frequency setup and comment to be consistent
    with the commit message. (Sashiko)
v3: https://lore.kernel.org/netdev/20260909150107.3602067-1-markus.stockha=
usen@gmx.de/
v3 Sashiko 1: https://sashiko.dev/#/patchset/20260909150107.3602067-1-mark=
us.stockhausen%40gmx.de
v3 Sashiko 2: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909=
150107.3602067-1-markus.stockhausen%40gmx.de

v2 -> v3:
  - Add Acked-by for devicetree patch. (Conor)
  - Andrews Reviewed-by not added because of Sashiko findings. (Markus)
  - Add patch "Reject duplicate MDIO bus" to harden the bus detection
    and as preparation for the RTL839x frequency setup. (Markus)
  - Rework RTL839x frequency setup to better handle missing/default
    frequencies. (Sashiko)
  - Use for_each_available_child_of_node_scoped(). (Sashiko)
v2: https://lore.kernel.org/netdev/20260906081946.3499898-1-markus.stockha=
usen@gmx.de/
v2 Sashiko 1: https://sashiko.dev/#/patchset/20260906081946.3499898-1-mark=
us.stockhausen%40gmx.de
v2 Sashiko 2: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906=
081946.3499898-1-markus.stockhausen%40gmx.de

v1 -> v2:
  - Describe per-device frequencies in devicetree. (Andrew)
  - Add proper per-device frequency checks. (Andrew)
  - Use the initialized parent device for dev_warn(). (Sashiko)
  - Make clear that otto_emdio_probe_one() currently has an
    indentation issue that will be fixed by this series. (Andrew)
  - Throw error if RTL839x devicetree has different speeds set
    for first and second bus.

v1: https://lore.kernel.org/netdev/20260903122119.2638354-1-markus.stockha=
usen@gmx.de/
v1 Sashiko: https://sashiko.dev/#/patchset/20260903122119.2638354-1-markus=
.stockhausen%40gmx.de



Markus Stockhausen (5):
  dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
  dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
  net: mdio: realtek-rtl9300: convert "fwnode" left-overs to "of"
  net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs
  net: mdio: realtek-rtl9300: support non-default clock frequencies

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  62 +++++++++
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 120 ++++++++++++++++--
 2 files changed, 173 insertions(+), 9 deletions(-)

=2D-=20
2.55.0

