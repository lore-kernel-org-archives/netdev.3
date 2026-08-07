Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A723A3E68;
	Fri,  7 Aug 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122693; cv=none; b=Opjc17VDznDhHLUHuTbyAedKtziPy6erxf1HfTl57xm6YHvfzZV6jz6LhH1u680j6HDImRDL4TWq9dWptPaFr0zc1AJdlQV6CvZl8RP5yKKNtMSTBG4wOMkXet3pWOZDp91v9B+ZOXo5cQe8W6OcY+pba+gqOyLh+ymtSx97CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122693; c=relaxed/simple;
	bh=wrG1bzk2+x4AAsaThTgi8RNnXW996Gf1Mpo0Ez0QJLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMRFCxSzNLDJjhPR9fBynGGpbgzoQL/WL12zmqJfTbgWWSgREb3x+HVd4RmB9mPDyOnaJ5xgCDujCFhXXrCURzUjcrwIxMZNU2w8/f85GcRrOKdXldAssf7fIIX0ROjepapa9ZMHB3ksfIqahlToXQhkv9KugMd8dgdJrtZ+Atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=lalwVzo5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="lalwVzo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122673; x=1786727473;
	i=markus.stockhausen@gmx.de;
	bh=eAuPgjqr7pYC4FEjv//zjkcz0uGQxNpvM4yfRof2nn8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lalwVzo5k3Lq/NBZdl/G8kuOH3NgLocfMEblXPyjGso407YL10P6iapD9UV80pzO
	 MKYf34kpL1jhmynktkKVjpM9JPdZNgWjKjgohPq4QQV2PWVrxKMSCBOqYZ179+DYQ
	 n3xovZ8jJB1nhNK6x9q75KzC2U8BD+WgTek/KnQDyGIDlSFsqlNtwSdW0U/vPw54E
	 Qx3PfOU3oWCCEccZvoMKu07iPisgx2Zv2+MZsbSg8CeCswA9q1rSjD6wCcpoEaFBr
	 5K8nezGGdcelgz5QPDPum8YiJY65wS1/AKYfVlbgOom4c0ofloEmsslOHgGhvqjzF
	 qC1sPlCQlIdqRbGDAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1xGCWB10yw-00jcvi; Fri, 07
 Aug 2026 19:11:13 +0200
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
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v13 06/11] net: mdio: realtek-rtl9300: Add page tracking
Date: Fri,  7 Aug 2026 19:10:53 +0200
Message-ID: <20260807171058.522833-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kvi4ZXmDE8agL7ykcy8fQEWyMlasRnISq8MNeTdaKyzCVr+D6kc
 rgdOYSrQ65oYI6un8ijDo/eMtmiRB4dc8+ji/SbT4a1Ru+RTYhzfo8x9IZcpxxp8K+UvuWZ
 TWEks4hTd4O+RH6ynapFyYOia29Pu0w5mnNpfnwLfec7lyHOn6OB4GP23qKeTFkDgx3Bg+J
 8xzWpjsgeGDHdkj462EvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1iKVPQ9eafE=;hhoAiF11ujsC2J685A09dWqkRUS
 bQ12DK9512M895Z0eDHLMH1qUtKsOrFXXl780MevBHmzzVmENJQlBvsZjSfyMKbMhbMU01Eo5
 aRzcw1QK7HfhIseVMwp56E+v7ansElPzQiqVXnH6IP/kIgggYpkbgCZIIPYes6zLE5dj8d82h
 ck+O42JPPolYMXJr68KalUPOU8up7Q3/sg8bKsn60kUlWoRbYtsnTlNkhxzjenNed+hb7t+mU
 4uKkzCy8MdcozG5+tLHZ0eWDMKJXt1mMcjLe1hKAMwTW1SD0f30IuY2XkmSENDYbh11eoC8/x
 lBiQlj1k/30+VKKeWZYQNr0XN9JLuEGCxWgG6BaJxXB7Ug5DYwOV8nnfpvCdZAo6LOuswh44q
 mX2BZyglbhpqi4WiuYB1luAmWz1UyDQV9+TrmGV+J5bqSvIvfeYNjJ5KmoDJBDfzgCxFKZMq6
 WB+wrvg1ICFXwPv/1jBC3vH2IkjvTfk4clD6Se+mjnqaBR9j17n+4oKz1dTNBkK+UCC+FQ2Ly
 S5vimmyFdNFHGLpeQGk22EBRNabtTpBjW34lhmBp3JgDpxDgUpmxrvchjhcEAicKgZl2PgiGz
 YbU/OQHcMa99VUElrR3WpMClT9pDaj6Olu2k8KDXqjIb4BIbpUJ1kM+7vpZ3B2bnP5JAh/Jer
 zWaY240j2xvpdw+yq+lGmeYAkcZghWAjao+Ut56ZDE9qqJM8PxENeepNAAjJcvi3DIKSoEzS1
 IBftAxSfzB/k9jclCuaEAEXcOGPFnZDy1niadkEvXcTcXZeo1K3LzzvhJdNjsSHVaxCMsWLox
 GjcwrlcDgwGVLZ154mFhFOPY1XgVAwQ92UvvpZIvJu//sV/q98OQPo11cFD5Pw3gqmiIB2jTI
 nlt3xrTeFTK8Ndj/WiWahSbf5sVbLNF+zkqGJSvkhfesQYRNy1zElHg5dd5UvBigCsRsdV7aB
 tZbXi/CrjnPp3gmUiip/xzwxKJjE/alVhHkofQhfuPwtbdXqKnruJHLp14Px3WvRDhz521Xt7
 DbClRrQireutEiRS6ZRp501bRz8yyJbsxrY5V5/UwdY+YGX38+YMZIZCUwNYONY/qPcq3Sj1B
 zKzeqIkvxP07ywOQDOtj/iD+dJjIINaObYpn+yzwAM45VftOlhFkaoKdQdnJrhjvPEgf1Meku
 va2MYPBAnX5Q5FvUe1yV6Gvwr/BCVaTi82H8MkT6hRM1zsBNih1neJ5X29ZxRRyXDxlunmrdV
 yTBFejCmYyWHs0R59z3rEUd9gSgY5AeonlaNHI6qYfcI/4NiDdCIGQRgwwKdd1kIp5OoheKde
 EPphAT/KzY1wnSejtX6TmfgqK2Xwhv2e493RQVptqn87Bf0CdJIAx4OJz1s8I+jjuGCCOegyV
 VXkkFLQi47er0sJvOS4GSLp676nWngar92lKH+OdJ1PvhWXSQt+lOm60wJcEa+8CXHW5PLUWh
 e0z06i/lU8XlAsiy+iHXu4/O7hJmg29udXqraEZNA7q8xt5hOlNM6PwL8vqJyCg9cfxN5Im2g
 VVE1lBpV1jfwqADVSpdtNS7TIrnLfcRwwgIlmz4X10nunMHRiZPTgKdqSLh1Iy9uTposl6zhq
 XoLwzOFttrZfe/gmV8X7k2M0aJHH7Him8P63SxkyLNX8M3ClY1IRW+Mbf+B9xnrm3jxAUEUHv
 2eSkC714D3z2vBhAtEvRqAXNoGuI2ortvuQTryQBomkXw0WErTbIw6k8p6Y2+9m5WCvtlxX5U
 2/0JaXJws/9ry1Y9oroi63sqC0cFP/DNOO8Tdf7to9nGrDU0wy/dL0r9xXmGae6Dy+CDysToo
 ODk52mSARon+j4mRKXCRirc36X7q0k1If5EiJIWtTtToeGPXMnvWIxzrkHTTG4kExZGfSoqa8
 xP+CH3BDAM8mV+II7zzrE7uz/Q4MHs7mDkExYivto2a14aQ1O3O+ciMvYFaYczYJw/epzxuMh
 cluWHDCW0rINHm16BfAWRf40MzKk4wO1htnHDWA3CosUoJIP3MnGJIM93kk0Z5oC3pccXTd+i
 Lr8zVZbC6Yz1jYrihA5MYmu0DcSqylWt3eSMsj1amlc/napVOmEY5lr+un5yRL85kQiK6SpJ6
 CiTxne/MTYIoy0v/ORIv+AGnZ9SGzPhZkGNSWRCgHOKMSXF4P9IQdTK//oBgybn7eE9oP23QO
 TPMKb/4fvmrHvwyCwuVHJwwZKApXS5j/vFYzHK6D2joco2LyKLiqXILO2R+wul+HHHz/FqL64
 xNuOAzNOiXThCFxqwMtKvxeL3Xv5CJ4wTFc+/4USPOO210M/37V5CVsiYjlfA+9Qp7LDBFxml
 DZTvEnpaf4no1YE6jA37Wg8uxEqwL3TJNzUWUvgvjaeDK+CsQOLgGxr3UO5oVALZwcySWZWaZ
 ipqRflCH7rnLCwjZZRAzipvjRfRvog41WJqGxlahlu8XChK0ManEjTZzqhCf3ok+jLaiDSufc
 VjFZMkzrBWvu1LsdiPHYHgu0o44u+yKkTv30zbASqpokr/JSYBkkFwvvtSyNZQAuRwp6tYQuf
 eBQz7hAJI2nYn8BEeejksmm+/x7Em1uYGrcGccPSm01SzyaHtoj8HbGSzAv8GspsSbS0PiE/M
 lz+kX7q3HaKidMTe8wFfKQ6EfriNX2RwKsYs3AXrhNc8bDhxE4QeXOLtFQkcrOAfBM/B1uOXK
 m45vJiXyJZrUVVghZioqpCWNUc/YxPQ8rld30ME4C3YbOhLS0vCbmVCYmgLzEJtugeBlhvYd3
 9E0AGdJgztfz9n2+zV0mxC5ZqnkTtdKA0GecUlQoYEm6gyZuWgVUwSBAaA84nmq9IBsKrts19
 mgbDCKzV7oXwgZzXoTgfayRTLaq3Q3vDI5zX8o44R/G1OZknlJ+tHN3s7ACEH5lv/t286zKS7
 57W6xS1bZJuCB5GnR/dkhvk4UYw+/D8QJGONvGLPi3mEmH57gkIrJWyVHdNjOYLhONTED1uIi
 2lcgAZnNGLxJyBNqLuCMfx8ruO9r8Fm8taDV8DgN6IpqU9tG+Vik6rJECg9uf+ILAtnkWfOki
 XK6wMDgfY/N2Jv1c+OUtJhWReVDS1TvJNj63bucf2KzRnUuCsDdrk6cpviA46H4eFgOoyeJbB
 XtVWj1J6IBgEHcJio2yi4QOZobf9av6gsZGelsA3kckDm6fuhey5MZX1JOWqGja+kUV8BHI2g
 W5LBWKWSNd++t8E1OPFmG6s/c6KBVDhe4uVXYNSx3uqN867kWMlL4mQ+ul8sqgnEv+4p1yONZ
 S4VQQ0haHXHczQuNJFg56CvD68ONVSDFNRsxjUBjw1rBNOohfJhzDt3HvF3DmtluNQs44NK8/
 WGkxE72idD2DwshMWyIitIvQo2aZGL4qGSqBxW80PV3xq4ByMok8EHyhAbmGXzmlECxHYgzVb
 cVUT5T58mxVU942Pw5YWrWmOhMEoosWWkmXnLR+E37gVqLu9n0KlZo3TUccvMr0Hysi/2fvKS
 8DWsIaoHe9xyr2RoCXHzBHcTUorn6RTiIOiOOBazuYvv+ufRjk/X6oaXQTlGbUxgvgTvzFw8v
 oV95iv8aFOJ0045sxbEdppdD6+oZhlxyaSSTWzshwJjjhjQN8HxOKDk/Nwiqsazpv23Zzq6vb
 AoYFZtSI6UvXUcBvOumROvqoy9JAyHfv/c6YpbrZbfKm+uHooYdQvD2ASGqWAlVhH30LpRygR
 wCaoaHiKvqilv3m5gMEkENxlKSF9TVKI8TgwFs6TF2z2PZ5pgJyEB7IROl9AOwdFa7EGGpBkh
 sReKGT06q4lpxL169nUVU7q9KbLX4JHAoHfVco6/7CX2jFyt4omop4Ef4XGw+/WqKqonnQSXp
 EQUnK5gO0F7A5sxrSMYRiC5b/zRwqMTI29qGYYDYtZzXwGTMk2unIrHJC/qJlQpR4kf7W9Edz
 zxbkUlIA9Xw8eZ4Hc1EZwIBanFdUectVJyNj6Jo3nLagy5QrECcflHhZhh/kEhLDxNZeDsfWo
 FYpWf8x6fZNldYCf8hOLqP9d5hJBoN49yFH1LvRebzj1nXHEymUtEsDa2xWE2Q+xB6V+QLJCf
 Pb95Gzu8+Y7lEEcM0JLym+Tq018LPq9yxYwYw10LrDPZZiyzHFBhILzxH5Cdvva/gowEI7HlV
 G4qHiaymUhcWTOyyJli4aT2IDieC7jfSAZ4YhD3CHlfcrEiVAd+mb3gGH2Zn8uzDGYd+C4Y/W
 fv+lWNThhUWklE/9KvtMjq5ykspY25f7PbfazT/IxF3vPbgDkHJ1RzJlDE7wo15vGr9s8LcFb
 f8C3jzgEqngLtW/1pd9pE39K4bAE2u+ZzDWkEDjW/BEn5OaPlxiRB0jP0K/fxM9+zlGaYwjpq
 7WwOiY/axw3Z5RRv4BS0wnjC7xdq3GkvkNd5boWPx1FM+dN3vm8My8OnNTbrRuS5iiq37URp3
 MGnn7yo7yINJ3KgA0I3QiqHuKz/rbLCxuJisuLmQjoVgN1N0utLUJ2VQLn2tj1jAs5b9lm2kL
 s+91khoxC6MqEilfLMYVqhxFZMjPkidAmaC0K+DgeU0HbDzaBlIujNwHXapaV8rqbOxV4Rwm5
 rgPJA4i53ChM1C+Dvs74ciYy0jCJNdSvnR4rP3D2G3d9SHS5E5zn6rXBKX4pfxe+j0g+6Id/t
 dcOJkSffONv10m7dG0vh7Yl0SzwadfEG/BKMMj0N2v3IBg2L9j4eT29N4KHzsyQ7/Yy+N+yCg
 KeX2p8ouTbMxUlBzRA9YyXxsGBNPUHvWSL/sLQR8U5fIKu2mrG1kSrxsbvQL0vW62+3zgYdlZ
 DFJcYZS2NyCEz69vwiUKFwA8378k/y0+zYF3SekCbHzn1DIEu47zPjeph1KYItXzuwrMMCLXK
 IoGjYYq3qSQJwgiFXEKqLd9Jh83/CCpqgVX0/Z5LlUI9itgplz0IL/DQk4l7bqGpETxda2jX8
 WnkEEx/2giz5fGvCvip0mtRYlSTNpq8zCrWlO5eU2DUuJcYoyF7dfn9dz5fNVF3pZLRii7IHa
 nLUuOhqu4DELwibfqbir0JyQZKb1DUEATsgpolG1YDiUrQbjjPdRTvldefVtD5yoWyzcM/OUR
 9UznZ5lEBBcTvrdB80XgXP338rFAhVhO672DZed3BXmC7ccfbFsjWEvNYGBe7lELTivdR0Dul
 HeujtBglDWTX7jaTCvrpRA5W7MmzybV4ej+9Kpr3SS3xA32CIgaBC5lbsKsSS/VfHjRfEu2e4
 frWyWFRRWYp+0s9Txyab9umGN756uNHiKK4ZGUosAHIMGsFswRJ9w8VNzM11uf4UwRZ5ZQwuh
 zhDEhqTgwY3EwZtTwI3LUZVSfCPWtegGnkJYfr011fFUImAQv66Z/zO8+TBc37M3936VYGN1a
 CFVyyGmUZ6Xq+e38GNMNBuP8k3/R+2anIkxiWCUEnloaQVmAQL3gNpYQQm3jqs9Hl4UUhBmIU
 TPmd6ti3zfHFq5eWT6dBn6scx/gGDD822rRQniCRIh963hjvNhgCW35KkJgh2qiNy3iXZQPo9
 yJu+NSaOQI5NZcl61807dtXel4qHRrzXsQff2Xp0CLXi1Mc013AHj2Mv4my3C2+ccmL8YzLl1
 JgT8IJpUTyQ6sIh5AKUiOGbuGDzDnOf6Aw85egPHNTPmXoWIA2CH7YiKII1li/3dhRXyAYYg1
 P1kVSzbl8hkPn/5Ag2zUmDN7FlcEfgPBWdUv/P+0RRXnawyvGwqNQk53kRb3/IE5RVHWn4T5j
 XZ2XFiJ9hhiBtBXJ+c04lSqlBFFd4viY0svhSThrmNVD+UZRGOg2QVDlu7376AvnXtn1etoLR
 XZmKmXiTT3hAe3DasPuIezNSBL0QXTkacf/djfT3vLvLB3WAANZnsU+JXt3RdzDqgC41C0AmJ
 Jj9fkG72zmEEaQlkxkzjG+tOeP3X8l8xR1Tb4rkKDlkG+pXRvwIhzXZUUUFC1UoE2swolxnA1
 rdiJyuAq2z64zGsNS3TaI9lXBqpjEF3UbTQtdH/AKwpWCVVo+XMdgSJ4qDFSbAtLXAIreCD82
 YWER1RkvDhk+CZbc8kWJcGu/1lc6XXeqbOBNhB5xH1zeNoZVx/bifsJsSEYwtN9OXP+6HCYzh
 m47+gH0eYHfJKGIvOSVm8dbq8or8rN36iWV6RPWaCiKCZuGxe

The hardware polling unit of the Realtek switches has a very special
handling for c22 PHY register 31 (aka Realtek page register) in place.

- On the RTL838x it is permanently reset to zero.
- On other devices there is some magic saving/restoring (aka parking)
  in the background in place.

This makes access to PHYs a gamble.

It is vital to keep the polling alive so the MAC layer can rely on
consistent data. Intercept access to c22 register 31 and handle it
internally. Store the desired value for each port in the driver. When
issuing hardware access to other registers add the page to the command
towards the controller. Given this, the hardware will run two c22
commands that are not interrupted by polling.

  ... hardware poll ...
  phy_write(phy, 31, page)
  phy_write(phy, reg, value)
  ... hardware poll ...

Looking at this implementation one might argue that disabling/enabling
polling might be a cleaner solution. But one must remember that

- This driver differentiates clearly between C22 and C45 buses. During
  probing it enables only one of the protocols for a bus.
- All known devices run RTL8218 (B/D/E) or RTL8214FC on 1G
- RTL839x gives link flapping when deactivating polling for a port

So a solution for a Realtek-only ecosystem is required. This commit
copies the downstream-proven driver-only page handling patch without
any new MDIO callbacks and is the lowest common denominator. If a
non-Realtek PHY is identified on a c22 bus the attachment aborts. It
should be noted that bus scan runs with the page handling already in
place before the check in notify_phy_attach(). This is accepted for
now.

Remark: To keep this simple, writes to register 31 are only accepted
if they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on a c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 46 +++++++++++++++++++++----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a30be66c4b17..7f6bda5ea1ad 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -178,6 +178,9 @@
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
=20
+#define RTL_VENDOR_ID				0x001cc800
+#define RTL_PAGE_SELECT				31
+
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
 #define MAP_BITS_PER_BUS			2
@@ -203,6 +206,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -354,7 +358,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -368,7 +372,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -408,7 +412,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -420,7 +424,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -466,8 +470,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D RTL_PAGE_SELECT)
+			return priv->page[port];
+
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+	}
=20
 	return ret ? ret : value;
 }
@@ -481,8 +489,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D RTL_PAGE_SELECT) {
+			if (value >=3D RAW_PAGE(priv))
+				return -EINVAL;
+
+			priv->page[port] =3D value;
+			return 0;
+		}
+
 		ret =3D priv->info->write_c22(bus, port, regnum, value);
+	}
=20
 	return ret;
 }
@@ -593,8 +610,9 @@ static int otto_emdio_9310_setup_controller(struct ott=
o_emdio_priv *priv)
=20
 static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
 {
-	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
+	struct otto_emdio_priv *priv =3D chan->priv;
=20
 	if (port < 0) {
 		/* All subsequent bus operations will fail */
@@ -602,6 +620,16 @@ static int otto_emdio_notify_phy_attach(struct phy_de=
vice *phydev)
 		return port;
 	}
=20
+	/* "sync" page in case of previously failed attachment */
+	scoped_guard(mutex, &priv->lock)
+		priv->page[port] =3D 0;
+
+	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
+	    !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
+		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
+		return -EOPNOTSUPP;
+	}
+
 	return otto_emdio_set_port_polling(priv, port, true);
 }
=20
@@ -617,6 +645,10 @@ static void otto_emdio_notify_phy_detach(struct phy_d=
evice *phydev)
 	if (port < 0)
 		return;
=20
+	/* "sync" page for next attachment */
+	scoped_guard(mutex, &priv->lock)
+		priv->page[port] =3D 0;
+
 	if (otto_emdio_set_port_polling(priv, port, false))
 		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
 }
=2D-=20
2.55.0

