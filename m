Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF6380FCA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405904; cv=none; b=c6mm/PS0DJSSkHR+ay5uVaEHk8mvj6aEK1GE7/ruobqNwTMxbBgHna6tr4MTD+t3JicQ2ZUNRVl2nj3ZEqTfj1yP7/BKMIssUmljaeoSxQs2A/2j0klf0HBv94OE/6IaaROQ4qnDyJiYgi9DvcCdypaKZ1TtTes+dRNMf/V9SVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405904; c=relaxed/simple;
	bh=0TJUG9pu3Cn2+eiZJOCPJkkHRXEmXYRx2sBJ2Y78yBg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=bvIZNu8oEh17m27syaj1hnDX4yzsxr9NohaO3AHLTtxfqHJ3bQFI8jPMZDl8BDS005QKhgi6jCscvJFNNSrfizuBz74EjQNBEdpETAEllUh1m0QSHzdfrKE43EDfm+7rcNPXdkXnmdgtWOs2Qq68pRDsv3DYcc+gj5/ITg5RpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WKAV5iNY; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WKAV5iNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791405902; bh=OJ8pNG9qdSi9jb/9SeMyk+yHe0vCA/py3E7LD/TuWg8=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=WKAV5iNYya8ctNKHzNoBsYXJUX89yKzjwhP18fpxoprDhL4kln2Ydnunld85+baa8hLotqmkXGHuxYlMYXW19JOfMKQ/5P1sH+Fmk6+NkCFocfG45A2J4vqISLopizw7u9NeXCjTt/yIjZBAsLiI+i04haMrF5VY6ffS8sniqbXZ/eiJ3nfSFPRFgYrB7Pi6aBnKdHplfTFrvy9V/imKArEyD5I/3Z1H8y9jgGfJ3I50qUn1WXR184vmogsIOU9fqoZUppKxrRIyjfEo1Qu+oj7k2GAa+epeUJ2Iu70h9F/6XgXB0nPM+TPFLBp7MG8zepkQnrwTimIi7VfnZF3zmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791405902; bh=6MjM4lS49P2fz/wwfjbtphyBCrudppuHnE3+XfjyjMK=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=D4y6LtrSPFB43Jp3kTbB4CLgpZJYbEXgUyx/hC/uwErQrV3MV2IM65JNFDQch4UAe99RMRK4va0oBuGL6wUTSKbgR9bVdTuADZKENaIqr8o5cmS9At8mekK1fo9hRerF2VNsf1Ta5SLkNPgn24b1p7U46hPSfE9FyyMPWqOFuGFLC53AJkYEHhXijJAq71J4tfCN9i6DDVA6/ibMQKJAguXLqJaPOQMvM3scJMZsREz5uHgsb4FsIiMMQYikJYVIFmstZTkSYJ2yGu6qTv4MWRuKun5o6+90/UWvrpMrUHpriUaV4jQW5tMtQZjrcy5K1bVZbigIv4nZW+yfxFgGlA==
X-YMail-OSG: 4ln0jEkVM1nDpOHNpM7twu1v_sw4Ac1iL7DOU_eKvwX1XzYdQ70dh.YPOtyZ8ex
 3cDlj1Zyj.1XnRT_GPAJctpElkr9r6fNjb3BtCNknnTqIhmP8IDlab8OS5unn9V6bbFDmorI4IqY
 lSrUC7wR4Yt9ddnFy_iqr3s.CSsr80dnAuNH6KbROQlxmBtDmESR9_b7bBuRF1IoC5D9SkmQ2lV1
 NPp11zkD4FAbzW2GmhPz3jH1o52Tb5cG33Fn5FYxnzoaOt8zhon515e.0ZpGxiHPn7AIHAEDVjNN
 ke5njT97DM8zJQxok_Qt79Oo4t..ibxqe5SlQILjV5hzz6YhCEsbtOVCyWBS147zVNYvR71nSV7X
 48UtgrNIfXxodRaqVoZOBm.GNih5zeJnNslqdInNGVnL7ey.eJMvLAKxtt9fhY0bGIDkxbqY3pxF
 M.EiNb2IVPhHr8nXHqEnafOkxhOIGGKWEBG3Xphy7v1k6D_hDLdeF_aPssiaYXkDb42NHZ6vXHQ.
 qq5q.dttj45W__cDElkOKL7M8nKzd.0Chj1GPcJQ3Qn0mt475ajKdGJntnlXiXs21jOIQxIW16oz
 an6Un47RgngyvkySiFltaOh16YkKp2NTnHTlNbFyroOEfOfpFNkzMpAHfebDvSLZMxG2MEgPMly2
 vE1.gKM2DDOQn9gw4FMQDHBCZeL2UoWRaHpEtjQ1mQEe0BDctTNM3JuK0u4g3Psu58aMIeV0wKcW
 1Img5.B9QsV69dmFxJruyv8O8eX0Qay7hyOZo.5qQl4wnTvqJM2wrk_1txUQBVt_6CAt61NYelKu
 2Larb0.yxiir0YET3SNXkPFKGoZYvj9aIyVyAKVVaS94WTxRbEhTaBYDQX1y_GyQbAvmACB1VBck
 7KFMmQWwC2Y7FMhwadK1PQ__7ooKh9cRTCIBYNG.SJbyTnNoudBGoK891vKoZRopeM7Lg0ZnpRb2
 EHb4msWkufekOR1nsHvunKfvOgD6IXrVYhnHo_VP24bt5Au77ctfaGMNLdmJ_uW.q8UPg_mXS6ny
 2Bj8ZN1S1h_ALBa.qvISXxpedplQYxugShigCunrKunkkqsDHR_DqIkFSGSbwUszjgCz4kxon16.
 huZCF_hAY.bukWwV3INE.OV2P0yjrWiRXQtkcExvKry3xYTt0uwx83Q8U.119_rHCnOGQVmocF.k
 .5UMrzw8nnf4SnKxomMIU6xBo5GpwzPX_Bms8_ha.cU4WTBgk76C7OMef_gvhSWhrDcPqKFZKPzV
 GrrPGZse3wax2AJ8ji8QYjGO6YqqJpM6kuPUvl8fDYcNWB2.2NtEI7oV1yBnyUb.3RLfpVjxIDOf
 D2VumQe8NdzXY39Vr5RZZ10dFRe2y7OXU44Hi7276Ck.o4bNWr1w6t18QUKcz0J5Re..bwMvqkdY
 ZcJqYxfl5kaODsNwe335h1arWagY_Bbt7NNdQFCPZP2AcPP4s9Ye3RxGmF.cs24i2xWK0ICBR5.Z
 nSK6lIMuyrX.FUnloVk9ArF_KvGTlEceYO2Ig3rCxDD0dGTdWvbpEjYtg_pkNsiqu3snCsVXIMbZ
 eWctZiR67vxlt5wsOUiqTJHoY7L8mde1fCER2FGcO0Gz2rkvQBTGM9ax0m5yBTAwLndZm4WS0Pmk
 58r2ZlSNMZZppxaLSrmiKPhxTAC0h_thzUUCjWoaKhMzXN3zz02vA3PS5VJv2UbRRXBHL0KL_j20
 Lb9TcGMl41uFGvta7fCHHjJiAO.mdIsZH3l.KD.OePZCLfiflmMuV4YMkbjkbw64JlqLj1UYFzTk
 uGQZPo7Q7T7q9XkZ1OPW4hFQJAwCvEWIn_8GppA1X2x_fpJPKPi3emS4JDM5xB98QFf9uFIOwuo2
 hY2ogmPc0DRbXzAyUFen.B0DffiMTTKPQ2gVPub1zYMxpKbBx8shls6PHRnL.nakDXFPSqfD2uQP
 rU89w.b1ipFg4Z4.CP2Z.36MbSgouWtp6SiO6NvhKjm9k_VGudbzm2dobJAbTodwCJPW4H_CVm5m
 D4X9011L2EUorbrKI7kl5s_7Ci4Kw1_cW5lC2FQ5OATxMt2ydvy8uCxvXc7G1KUjlU_RkMFyHy5L
 LjMwQXNCjymweo0pAaI6Euv8DIq2elYe8EbE4ybddMPABCRNKH81Iy835J2qSnZCQFI7HXsTPXHo
 XhkI4qtsvxH_YvssH0jCVZjy_.eKb2i8eKse1HpdslmRYG3FWb7qMZsTpLOnPDpUO0LWn5hajG37
 O6zoLFvgMfyUGxeCn2_5goi9GlqRTvDu9Z.t8WTqQNHA0tTTz43N2v7QIjwWaHR7BlVbc3eCJxhe
 AF8u8vMgL17NfndsuaOSTDB6nyvo-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 77ff1bad-b4a0-4591-b7a2-296957345f37
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Oct 2026 20:45:02 +0000
Received: by hermes--production-bf1-6d6877594b-7khjh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f16f9c62dd119540405e9b85040b9773;
          Wed, 07 Oct 2026 20:34:42 +0000 (UTC)
Message-ID: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
Date: Wed, 7 Oct 2026 22:34:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH net-next 0/8] net: dsa: realtek: rtl8365mb: add support for
 RTL8367S-VB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <84fc7483-b22d-45ea-a3b8-3285dc357265.ref@yahoo.com>
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
rtl8365mb driver. The chip belongs to a new "family D" that differs from
the existing family C in its VLAN table layout, speed/RGMII configuration
and SerDes (SDS13) handling.

Patch 1 detects the chip and introduces the family D branch.
Patches 2-4 add port speed, PVID read and RGMII mode configuration.
Patches 5-6 add VLAN 4k table access and PVID set/clear.
Patches 7-8 add SDS13 PCS support and re-latching of the SerDes.

Family C's functional behaviour is unchanged. The only change in a
shared path is a mutex serializing SerDes register access, added in
patch 8.

Tested on TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII to ipq5018)
with bridge VLAN filtering and per-port PVIDs.

Mieczyslaw Nalewaj (8):
  net: dsa: realtek: rtl8365mb: detect RTL8367S-VB
  net: dsa: realtek: rtl8365mb: set speed for family D
  net: dsa: realtek: rtl8365mb: get pvid for family D
  net: dsa: realtek: rtl8365mb: set RGMII mode for family D
  net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D
  net: dsa: realtek: rtl8365mb: set/clear pvid for family D
  net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support
  net: dsa: realtek: rtl8365mb: re-latch the family D SerDes

 drivers/net/dsa/realtek/rtl8365mb.h      |  14 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 545 ++++++++++++++++++++---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 304 ++++++++++---
 3 files changed, 752 insertions(+), 111 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

-- 
2.53.0

