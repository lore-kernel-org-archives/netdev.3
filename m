Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501286;
	b=SY8ngHG95bACG7TuXEfMnIWWLpDxCcUJ5IwjOu1KHvU38zreCHiQTSOO1K5FOi7sj80N
	 m65OLOSb4HFVrRqM4Yzt0q0kQCCqUc4nm0/G+OADrl0nNThZMwea98L335blKNSYGkka3
	 VvUbRqlndgotyc/n+YgT+LtBL01U3zqz5lHdvolwC7O7Esl+spzLnCQLBbG6xgJsw0gns
	 OadgZE+0K6qM3AD+q5yxjr9QlVRPIm/kIh7zrfjfWpiyxT13zQr7E+8fxf7gXOrif1ZOe
	 HbgsGJRpZW2C/qXap70Qa5KPYVMX9dly9Ngtyk/llPa1IKry2niurn4YBG5ZLqX3yZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501286;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lES+zmaepjgeGxhsMXKaDsakwX55QlsqoDr1psCb+v4=;
	b=QkMacVZRfDrm5iEaMDqI7GPyUnIUNgTyK6VpGwihNYnvLOo8+8Hqj3Me/WawAV+bhJrH
	 6zzC2/WNI2hrJSTy6nUOL07nlSKURD9ETZoojW9HQeX1sYiLtkw6qCeHn3uLWr3fp1HcE
	 /zNVdFpLGCHjMrdnZJjh/R4j5xuHxyWj4/ytQ1XFP3iVwC6C0sZtYY0n3Ws90mqSbjDwz
	 P1xmkCOrvVy+ha3dNoWHeyU1LaL7QZfbqTRJIpgeRbDc4ktZYu4pldme/sg4PZtV1aH5v
	 7HIG0pHuC+0iTfFHlXZGGwpzHq7n2A+dywjlO3VpsVQQWGVNUOHMqSXB6PbNTB7FnNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g++cQzTq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QP0YwLNq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA1606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20EA1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g++cQzTq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QP0YwLNq
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFa8aF1309455
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lES+zmaepjgeGxhsMXKaDs
	akwX55QlsqoDr1psCb+v4=; b=g++cQzTqcxOUjKgCV4yRKDYq6EDHYmuk6Dc6qQ
	jLmTYWWo1l8sWKW6chz8rKoCItTL/vFTfd70B6f1cM09as1Tqz/E130bI0T3Gw2J
	8L5OD4fG64Xt4TL55d8GUrgd91YLtF7VTF54zBVx2VY2AEcV+ZZoryxUhw3gTLnr
	mO1BnsMmhPxWnkssGSIgfKDOX4SQjfayIvDdx7TyaJn1XF5WIkWNlkkuY9ULnjaD
	GoNjqut4O30HUUbrouz9eof1nDP8aGQu3VkKTyoa1mBxsirH78Gj9dKym3CPyhJ9
	4nUFAszs3sN8bQydv91HEhq459NOvQeV1W5H0t8mRZverN+A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4skb7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:34:43 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7d2ef6a9f18so3065913137.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501283; x=1795106083; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lES+zmaepjgeGxhsMXKaDsakwX55QlsqoDr1psCb+v4=;
        b=QP0YwLNqrS97fNLfhLGzQz/jbuwjVtJuHiC4l1F0k3BuOpNh0l0rNW0jmvaU2isLMW
         IqDvQKzhhABj53PiPl+NhCnMqexdz/B63bZzdJeXdXrGubwucjMXrefZkVniWmOVTZh8
         LiuCijiwcqYXpqXuMI+KxTosJSR4v3863OBfNxXmNtshZ0x/y2HT4jF6vgd2xEGdO1/6
         Eat34StJkewiH8JPk+Je2VvAN6xb6E34eqIQ2bVGePr5/rjpEqkp6m61bwR+lDEh+Q79
         rGzq8YfrPm7kCqZd+KIBD+roS0rsgkVoLrFG3Yf/WGovXNEkF5n/AGRzlPCUGnZUq6uJ
         5m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501283; x=1795106083;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lES+zmaepjgeGxhsMXKaDsakwX55QlsqoDr1psCb+v4=;
        b=bINPhn6fdtkG8uk1l2Ouwed+NdE5LFDa1ToErLGyCg6WZstrtLN+cHrJ8mSOUaByDc
         s113vhgItP1BgETq8NIwiC9hOWWPRz7c/q6QAYI+IAwmkwYhK0HMnwX+acWeziZdGxAZ
         6iqzw+x+6P1De2dz0JXNIJZae8Kr0855+uougJ7a67nJb6H9P0sJ836pApS0pOvdSzhg
         em/XcS/cf9bh1ksPraiVXnYgdh8Z7Rv+Hzg2RZxKRVKH8TAdS3PVrGbQRCPiwrdqvyZl
         WhsUmWk+ORyjiqrCmRC9+aJWQXlef4qYpsi4xh97jKgQ6piWNQD1AmrzJjF4M3E1Whss
         wVOQ==
X-Gm-Message-State: APuU4Z8v2NOookg3jrZ7OgHFPhILrIbZzXY9jzKn2S7df22rJ3ggDHZi
	M6lm4W589UASHChWFZJNznHZu9jNxHttOeVs6/sgt+weCkvDESRxloa6EljcJERx79v/3HD0cxB
	XpPqIDnmELRWi72MYlBR1SFGVVNPIaMQqVCYXZvIFrEWreBSg3fTwVG/Jvcg=
X-Gm-Gg: AYBFou3ETkPEImSRHtVFZJWcAjmomWroJi32DF7Fx7qmt+0jAcT/E38cW0uMgHBpmKC
	9RBioyvJcaDVmeeHrxDixiISAV0fKwpExpOQmTjDp46tUEXqLw9otaXwiLylrKJMA7v0kFOH8CX
	MMHpkdHK9lOZa2Jgvt/1CtNBWak+VGPzwspZGbcpUk5RgXx5SIOKnPq2svjLvbk0Byz2LDpodKO
	mVE6jMYvripI4NRSu8gXayjCdG5GH7b6cslAktvAEU+aGvF1q4Tsy/QG3Z4MnAmBJuOVYGlad9d
	uYBlNKEHB1SQQCzGaGSMS/dVqqRYx7KG9YLEC+h+tIop1POCENHzJxcimOml+FuuTz+0Q/9c/TH
	VpSJGJYt3pXA866YwORzMC/AoAQ4RmeoXjnYxhjRi55Wqw2tUd5MrTBb9yk26FDg=
X-Received: by 2002:a05:6102:cca:b0:7cc:3246:3095 with SMTP id ada2fe7eead31-7d506243039mr2843126137.34.1794501283074;
        Thu, 12 Nov 2026 08:34:43 -0800 (PST)
X-Received: by 2002:a05:6102:cca:b0:7cc:3246:3095 with SMTP id ada2fe7eead31-7d506243039mr2843103137.34.1794501282385;
        Thu, 12 Nov 2026 08:34:42 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm90771425e9.5.2026.11.12.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:41 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v10 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Date: Thu, 12 Nov 2026 17:34:09 +0100
Message-Id: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRzW7DIAwH8FepOI/KNh+BnfYe0w6EwBppSbqQR
 Z2qvvtoDlvEygXJWPws/r6yFOY+JPZ8uLI5rH3qpzEXCE8H5k9ufA+87/IFIyANFg1PyzA4z+c
 LH1qOWmrrqEEZHMtPznOI/WXzXtkYFj6Gy8LecufUp2Wav7dBK279x+SKHDm0UmHTSZAuvkwpH
 T+/3IefhuGYj81baWcQFgZlQwdDOmCMAnTFEL8GAsjCEBy4guiwQRdt8BVD7g1dGDIbITrpnW1
 kEF3FUHvDFobKhhcmK8E5FKZi6J2BVBg6G0SkQOXAlceK0eyNMo/mnkdHXQMRFPnaX8zeKHdr7
 kZUxkNLykhbMeyfgf8ytXm3Hqz1loTWsn1g3G63Hw2Ams/aAgAA
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: CHehoGua7xaUyfIds7zf7b8FoZAM1ugN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX887wD6hPhLgx
 LGWS3t5K5YB0HsARloRfVe60xCceGvzLeZZHD6b6M36Pcfe2lMj9rpxTZBERLhCv7xUEAiSQjs8
 h/LYd6c8K61ffE3LlTXzQZ15koh3mSA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX0sTNG1E8i1ZY
 NLAh1Im+SVWFgUtTCuurIPHqh8aivxx0bQssMf9Ap0TcqCqk9qWWHVD7ZgTyxNLDaRYsvDs0pid
 8uaToYOvPnBvu3ZEnChPKuYeWmcPqZzKeFtB+taBdQJAdHOd1iIWmPziqqxBffjagqwqF79APOn
 +RJimOOGyybRsRh9YgTMWsOhaHxpI/K0Jh0cFuTo3/tbyHT3EZmJUVFriRT8exT0wxAx+ScoiCl
 WnoUlXbmtC776v9Pp0c3uEV4vct4Hwza0BNpNw/jwxLLNTosW5mZ8FN6j1F4iKA4f5+sVcDoLzq
 t6tQZJcP0d+Uf19dxNZhR0nV7Q68rfavzaAj6YvdUrfPDASep9PZfcdx1VZfIX0/d1OuPXBHBR9
 AqtUmBEaf1sr+y59F6uHat5GuilaxmcOQ6t6t6Pav6k6UGYW4NjqKcVwiqXix5JzDLZwhsrjdyQ
 fZMNnT5Ui0lLv+pZ3dw==
X-Proofpoint-ORIG-GUID: CHehoGua7xaUyfIds7zf7b8FoZAM1ugN
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5eaa3 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u4BqklbH0r9NqUsF4ZAA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120066

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v10:
- Introduce __xdp_return_buff(), xdp_buff_shrink_tail() and
  __xdp_build_skb_from_buff() helpers.
- Link to v9: https://lore.kernel.org/r/20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com

Changes in v9:
- Rebase on top of net-next main branch.
- Link to v8: https://lore.kernel.org/r/20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com

Changes in v8:
- Add patch 'net: stmmac: fix VLAN tag stripping on non-linear RX
  frames' to fix sw rx vlan parsing.
- Rebase on top of net-next main branch.
- Link to v7: https://lore.kernel.org/r/20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com

Changes in v7:
- Take into account the case where buf2_len is not 0 for the single
  descriptor case if the interface is running in xdp mode.
- Report rx_not_ls bit if the packet is splitted over multiple
  descriptors for dwmac100 and dwmac1000 cores.
- Link to v6: https://lore.kernel.org/r/20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com

Changes in v6:
- Drop patch 'net: stmmac: allow non-linear xdp_buff in XDP mode' since
  it requires some XDP fixes.
- Introduce patch 'net: stmmac: drop split frames on AF_XDP zero-copy
  RX' to always drop XDP multi-buff frames for AF_XDP mode since it not
  yet supported there.
- Introduce patch 'net: stmmac: drop multi-buffer frames in XDP mode' to
  fix pending bugs due to missing XDP multi-buffer support before patch
  'net: stmmac: rework stmmac_rx to support XDP rx multi-buff'
- Link to v5: https://lore.kernel.org/r/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com

Changes in v5:
- Fix possible read after bound issue in patch 1/3.
- Do not allow parsing non-linear XDP buffers if the program loaded does
  not support frags.
- Add patch 3/3 to remove MTU constraint for XDP prog.
- Link to v4: https://lore.kernel.org/r/20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com

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
Lorenzo Bianconi (4):
      net: xdp: add __xdp_build_skb_from_buff() helper
      net: xdp: add xdp_buff_shrink_tail() helper
      net: xdp: add __xdp_return_buff() helper
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 231 ++++++++++------------
 include/net/xdp.h                                 |  27 ++-
 net/core/filter.c                                 |  83 +-------
 net/core/xdp.c                                    | 111 ++++++++++-
 5 files changed, 240 insertions(+), 215 deletions(-)
---
base-commit: a640dd0ffdbcfd23223ae2e84249d23776d41d5c
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

