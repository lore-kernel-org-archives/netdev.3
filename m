Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A337C112
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280977; cv=none; b=kiIdFWD7o950RoD4UMbANhibDN+uos5YBEwVJHz+6zbfAkK0ZpFDBayw4I466Mt+emF5TCcoM9iFKx3uKQZfEJ2a68nmwQSXfJUG9Lq4LAhqyH3vjyD/xQppjfTVVk2dvhghh5yefCOHtfeZZrcKm+fvp6UZQ9N93PioNf3uNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280977; c=relaxed/simple;
	bh=2X+SJ2oaW0+RgIAxsjRii8FypRIhmvfsktQS98iPTQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G5eKyv26EEUaG0rzDWnCOuXHTORiblX3xn9gMR2uwxdrknPgnWmDvkZQW8mScbDU6e26cG+oG45CtkaeD3GzCsSI3tPubACGLBcr5YN/EqGqaLY2wH6SSxDP9RcMGpyzKfHE5L6ImspmJXkEO7JFLCBbk4Y34opXKH4AZh0EO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V58utDWl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kfNqA7P2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V58utDWl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfNqA7P2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966eD203269523
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y3bDkdlPgoyDZs/us+RW5I
	FOVL2T8UGRn5OXKbHaJfY=; b=V58utDWlwe/PemSqpco7YKyWAVcjvgnskeHyAb
	Qa4PyNqq2/yKt9w15jwMTBfKIorMj6sifsbP2kGSdP20z7bjpHAD1BdGOcMY8p9G
	UKH3CCwTsCjQ9lJ55hzC15booOs1JRJ2GjeaZxevWBEs/V0W7MR4qMrNDRv9cQxP
	p4rZKQcIPdpeqR75rslYuZ0JbARCPw0NHz5lvCvt2FkO1UGfViF217CAKixCCWDu
	/fx1IK4pXuLoyUkfp/StX2oDPujpZ81zXPtBWjKL0lQT7pZSOPHKv/zs07k09gJ0
	+xV6NrmMCDW/VShzqVT33BusBw0ee3w4ioqZCIjwNqHAnAsA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkukcpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:02:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf45388253so2424695137.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791280974; x=1791885774; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y3bDkdlPgoyDZs/us+RW5IFOVL2T8UGRn5OXKbHaJfY=;
        b=kfNqA7P2eeHeI4OQa8h0WLFeG7sto4zr3w6SByYo4fk2wBHo0avtoXBFWeFMH2OX7X
         onhR7eGVtje/Vwde0UxTmLH4EVSVtRhU2i9Hhqxhn/nZueMz59taw+3Aqo1KFVk/hyMF
         XU3kA1PYALA3pRU/FnTF6B/9HvIkyfWOnCuiTDRlgZ7bwucx+stCmUYI2dQdWVix3is/
         iWB+cB9AjbX0TS0DLXrfugfbc2VxcwEtO9/B7S0Am+iyIaCPpI9xBiZV4KfHi/Kd7Amf
         dgVLlvVqFl7Bn+QnpniOa1hVKWw4SymAI9S2rtZ2GACGDgIAMUYUxkJ9+j/4/QWrbxLw
         s9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280974; x=1791885774;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3bDkdlPgoyDZs/us+RW5IFOVL2T8UGRn5OXKbHaJfY=;
        b=ustGLZp0ZzJ2X/chZv58+EW/CCP+UGI3Id4IrNm7P11PPMQkRls4qDPiZH+gS+R8AL
         MeVgfpYV+loPA1zFHyLcGt2jUFKh/f/71fYIXAhRpAck2rq9nkDDTkpZb/2lm+wDqrjg
         ia/53ViNGe5PF72bptYwf3bZUKvS8bWTBXfLpBcXL0FSRMphNDYuT+oEx1QKV1kn97v3
         uVx33Voks79QpBuDDo4GGUUKXI3pgMYhYbZxPH8nZwCqN8+4rV6rsO+VLsqr/1kk+Gbm
         cT2X+y5X90OMGLUXyprojXO+3HatNNjZ5SnBV919VuFsolx9o3LCEz6wMTMezQYhftzC
         /zzQ==
X-Gm-Message-State: AFq9FYIKO4r6F8ll5AJUR6WrE7SmXLP19Irh5sBvHrxlXk8smTIvUq7P
	7Z5M718AyUbmLHjfIHi+4LwyJLINr0XivjHUd68O/KRmVhtJXO0+ahJC0FYmM8pbkczCF8ar5h3
	MnUB01o5vX0A2SFMubZ9H9T9zWZ+VIQ//zwKUaaNGzDQDma+lwIyScbC9Yo8=
X-Gm-Gg: AYBFou3VsIOt3PiGPBmgd3a6dbD+Whfshe2alJKzU9NjFDB+OafOMtEl5Eam++k0S2z
	PXv4rjaTwXuY2FnyTGOlJqnwmRYMl+KcFkuiLFlxTlcN1mXcnR2RYxRqPe1RJN2f3pwMgOG2Hca
	kY/z7yx8YCIjh2e46uUjc7tcAIDdIHPp02siI40ynwXsNSTvnF2miCZ0nhg2d4pG6dVdMtkieIj
	uRM7C0jE31/vOTNFKa144aJpn2FKr3oNxfwEIAGdEQEdUh+2SqXuI2BQGdxF7+GOI57qXanssAU
	+9DK8NXr83+pbbOPrqQYXBVq6b1c9IsgyUkugfrMKazRcCUh4B5xN/UyigxMtjUM88v2YxdMn3i
	fHaLj1wPzBTPqhw==
X-Received: by 2002:a05:6102:549e:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7c879eff7b4mr197248137.14.1791280974171;
        Tue, 06 Oct 2026 03:02:54 -0700 (PDT)
X-Received: by 2002:a05:6102:549e:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7c879eff7b4mr197220137.14.1791280973569;
        Tue, 06 Oct 2026 03:02:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c53997sm92744655e9.12.2026.10.06.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:02:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Date: Tue, 06 Oct 2026 12:02:19 +0200
Message-Id: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQrCMBAF0KtI1k6ZSWPauvIe4iKtExswrSa1V
 ErvbuhCRHQz8Pn8N7OIHBxHsd/MIvDoouu7FNR2I5rWdBcGd05ZSJQaKyohDt6bBsIEvgbSSld
 GFqTYiDS5BbZuWrmj6HiAjqdBnFLTujj04bn+GWntf5MjAQHWakfFWaEy9tDHmN0f5tr03mfpr
 N4oPwxJX4ZMhuZSaiZrc9R/jPxtEKL6MnJA2KE1VJCxFTc/jGVZXpZ1Ot1BAQAA
X-Change-ID: 20260918-stmmac-rx-mb-16469a2714ea
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac4c74e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e9kd2x7fyNmJAygvsboA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: w-_74nrsA-8drKf0Vm7U8lzeZmj55neO
X-Proofpoint-ORIG-GUID: w-_74nrsA-8drKf0Vm7U8lzeZmj55neO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX4hRcVthHDNSs
 rcuE/XLf572tlzxVDXhzhfy0iqB3y3CK17UTULoum8NFduxDER0tf9HJ1KSSIlt8gal+sH5UJse
 0hrLtJ1A4bvdtHKuGSZgRxkTys/Vth8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX5mzJSbkHi0bk
 MxRgXGd5XX+XVD5G27s4wa7ltk6chVXYNPTn4wmCubEEHxYCcJJ4LmiO6r33p57A56A/vf4mAMH
 6BvfIhJkkdBriKnwCQqjvtWHI4VvS+GEFJT2ZAXGiNTqFB/nhQY3c6H1rYzUcYTNjfmlL2bLVet
 fEmGcUt2+6vvsiqbj/GAsYPbq1HWeGojNZJIc6ZHLVO1M9bCFZtZUlt4seFy4nzK94lDDWB1xrL
 By3RUbba8gRfpmEJ6qolww+5H4BT/ZPjlAOu8JOiwqfrl1rnUMgPFn1u4vi2KvtzTvMyZ/6Sn2n
 JQO3qhoiMMhPls7YgRYi4zFbamOM5fMZi+mNVFqBZxmsu2sslM9LVlc44S5m6W6fCxt5/cTnEiA
 sK49T6LSsleyfP9X+994fl64fF63j/DbKTFwa6RqVTCWRJvKq54SJ59H2UsOsgW8uGiFWkKlDMa
 Hwk/zACkoe9EvOrxvsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

Note that an XDP program still cannot be attached with an MTU larger than
ETH_DATA_LEN and SPH is disabled while XDP is enabled, so an ordinary
frame fits in a single buffer. The multi-buffer path is exercised by
frames that do span several descriptors (for example jumbo frames the MAC
admits through its jumbo-enable bit) and is groundwork for extending XDP
to jumbo/SPH; it does not enable XDP jumbo support by itself.

---
Changes in v4:
- Reset in_progress flag when the packet is fully consumed.
- Advetise NETDEV_XDP_ACT_RX_SG capability.
- Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com

Changes in v3:
- Return secondary page in case of error.
- Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
- Add patch 'net: stmmac: take ownership of saved RX state at poll
  entry' from James.
- Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com

Changes in v2:
- Rely on xdp_buff_add_frag() to create xdp fragments
- Fix bugs in rx_q state recording
- Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
- Cosmetics
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (1):
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 390 ++++++++++++++--------
 2 files changed, 250 insertions(+), 143 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

