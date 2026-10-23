Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743056;
	b=fwU7jdYoO+DMWF6xrFEULYpiGpostESPL2jbCLEFg7+ZvyBK5pdMOkGN0uaCxYSYvkkJ
	 tVZwVRma7/3LPNB/Pg9k/NIw89rzzcv/2khs4YwrVzrFml5YX89B69ZDe9lO4LS2Qz5SY
	 BvrOEegkqJhvyy97atMJRi3kosWqdoXZr4LD6XRWoowOkhxqxmP970VJeYvVTLAYVAnW2
	 Y/lHm2/ulvtjwv48bQSxIPHGovc1240QMWfaL/uKuyXmEt/rO7NUp4Zq7DuFVzZ/tqeTl
	 ysJ6jRgvWrNti14E5K1kpQdNHnVa/TvXBiV3fVDXsO4D8YoMrK6PmUr5g82SsZkAl3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743056;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=;
	b=c9/hhImpkgSe02RmhNnakhyqk/eGeP12Jb5lFjwHhMk+4l7ab17lCl2IuxT9doDkl0Au
	 eOv/f8rEyb7WCN/tCmJH+VX7v6HGSVBPSc7SiskYNDsR/jqVdDfP3ag19kXUgakHXFxZB
	 ptnXxZu2wne1rHt8kGzAYTR6xqIqcRCE+sHmBTBbJPRWCms/oVFEQLDQQlPlhSWtLAGwM
	 DthdsideKJuaywbiXmIW9mUwdaDpee6up2Y9jrlE/6vdXi9WQlsukaXh+xixSlhU2MWHG
	 6tO+x/mthJcfUCq9knMoZUYWoUUVLFBIV9cJv1MXBChQKMI/YR8t+ofekzhIcXvioXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQ19wM3z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQxUCvSG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DC60A260B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D0DC60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQ19wM3z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQxUCvSG
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FTX12650368
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=; b=hQ19wM3zGfqTPoWh
	uxfUM4Wed00n8ocdmOx/GrKbM0W/dI5hem5jEsguz5O5hQEcM8OQLKZ00e/W7YoC
	c2vYstw96n9tx4IwSYzEnJHcbOCj79hhQBRagZZYFCVO9+XG/D/liRAeMyu4Cqxv
	h0IU9MNGutL/3OWO6dFzjuwfIbNyTNC+zv/8QvhG27a43zG4i+yc8HNcbiOWbG9u
	77YATjnXDbCS3JQUjnlnwet/EnTuFBmpBF8thMiR66l6Kqels3XV4w5ge9zr/onm
	zsKaA/c8ErHEsUQf9po2LrBAUIGy1qnEo+DXDfnz9k2pR5eFUBgaU5sgSdz5P7QN
	8/CQEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjapm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f13c143c8so115078185a.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743040; x=1793347840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=;
        b=gQxUCvSGiZHFs633Q11eCp52g6sxC91EwQHhnp3mKThg7Txyy1ZOPcXc89iCU9CDdF
         idPel4wyOTiTtJJD3VdgYeiIbkqW+DSTC1WKLmzkuaC6ZrEifWwd5X08h2Nh3abN5xsj
         2KGoiwcfnB9vE5bF969LnoJ0JkLeJeGvxE3mBTFiKEz/Jkx714K12MRHQ9MQqcTQ3kbr
         /B3secLPDn6sHjiuaPsMbWmitMJ2OcQlJ1+Un23ImXr+iA9EVeSykSB7SZsdpp/Kyal/
         4U7qBRx2xQmy69/3qAHA3lChQZUOcvkKO/1rmDQi1TYHjwFBxTCUUGSBdV6BI47aFZgI
         wH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743040; x=1793347840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=;
        b=O4oU4RTPvgRVqQGfmi7oLSElynTyAcBWtmeK+ZNSvvMwP1tvZTly+PB4Cjnt3hWkw/
         aHUO2IX9NYI+FHCDehDjETI15jgOcj0hcpau88QNAjzW5Q97WW/zEameqigUDY955IhL
         29Fja3B1qIIYzEfsElwgs/EtSDbVxLrWZBnN1Iam/PTz8V1CJuIbrxSgKeZ47zaC0CJM
         Sd50WENZHCEsgAab+uomW+I1mOIPCpH1KcD7XOtalOB71OpDMDPc2jRL3zbbCM4tuDps
         8HLIODGG0fB/v9yZq4SgkYPoxl35KWI34zw3Ulr4C18wvMjWBlN2jmRsy64diM8PTZN0
         WDfg==
X-Gm-Message-State: AFq9FYKRKJh14JnlFmQCiCEVuj98pt1n2yFsUP+2J5aeZ8v4XyESr42U
	cHuHhBAEujkAAVCe9UUTy3QGn/W0Fu4YnC+vzwAPIY4Jlq92Liiilmfj8jGen+z+U+Vpxm4WLgf
	A3OXNUQgIu152jTS7njlnR7Q7JIZqyhJXb1bTGIyo3IEF34+MgeEiYFvdGwI=
X-Gm-Gg: AYBFou1G83S+n3dRvP5obcn5O7PSLCJCQbjFCcjo0sxyizheDU5qLvYMDvb/KBEkLqu
	d1UiWDis4pHiBxwklXr+At3Off6zJkbqhGS2jElJ4GAFuHBeikjm0cmLWaIKm/yirDjLkB1gnav
	WiUVSc8ZXtIy3YBDfrzGbsCRfPDAp+1UCev1BzTdJkJeyfEAcJt/xKOyITP+zfSskXvWqUlnpEB
	Z1bt4w1OOTF93IxBq5Ky8k2MchoKl9JnnfyE50HG25RztXteDZCnWVPqVDkITve5eRT3zHJzVTk
	mcWnVgSjCPnbX8p61EJq5aGGWtuxs0Nnvx5Sax7sGLBKUM1wQ9u/AknoZTPtXQdvQXH4nUkj0HR
	zHHb9PdxZ0km6bhvH1mg2bROXoHKxLkrlut4sUtNwQ+3Zvevu
X-Received: by 2002:a05:620a:1a24:b0:939:7fc4:fb1a with SMTP id af79cd13be357-93f6f7dc7bdmr308619885a.27.1792743039806;
        Fri, 23 Oct 2026 01:10:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:939:7fc4:fb1a with SMTP id af79cd13be357-93f6f7dc7bdmr308616785a.27.1792743039278;
        Fri, 23 Oct 2026 01:10:39 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edfb3fsm3871572f8f.8.2026.10.23.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:56 +0200
Subject: [PATCH net 4/6] net: stmmac: copy XDP metadata in AF_XDP zero-copy
 RX
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-4-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: fxNjNgf_Nn6d1qxd5RIeM_ehUXUhn28c
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb1680 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9RzD3mWewD2guqUcLtsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXx2eVuVt6KGVi
 ecmNMZqwbKcR0FjD5j0695V8muAYVll+H85XIKH7WvG2DEoY+15Tu8xBmjGr/HC8+xEC1599lth
 ATY1H7jxG0RCFEydvYQ6MXZYRG58YmI=
X-Proofpoint-ORIG-GUID: fxNjNgf_Nn6d1qxd5RIeM_ehUXUhn28c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX7LhoLApnmdQT
 8vtmgB7Sp8XSvoLu0LJWQg7pnqnicR0AAzSEL2k8B1ORR69HYoIXpt5hVZjuk/q01i1DDFs18g2
 kHYQ725Kuxw2IszZSnovP/518f+y50q1dmQwCLD3CZ2bzFvRDq1RYrHNiMpPqFhOzASBopxLIOO
 0GI8t+2jiCmshfDAsY66w2IJ6Y2Q5KpWROyHVwgSaEWyDgAzwrx/20285CUGVJ9a+ClkxkJq6rw
 ZHdSdTLmSwfvjbN1UOy+AOplgPHDkiWLuQriAwmRn05Oa5DyNdt6Lj9B1TJF5xa/9SCW3B1YsQB
 /Ov08NlvYoOXSmW//YHW5W9s6WXVVymDV1DidEfQ3CwdPY7KgtSTMP4fT8CyVLAQijjw2vHFCEm
 Cpm+9oCW+7jBF7FNtwIMTo8ygYeBKmKwU4tMvQW60pnNULh2W7L/dM2BmFgakSOxDz6E5ibKBPY
 eqsJhlGzwkVcQA9HNMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

stmmac_construct_skb_zc() reserves headroom for the XDP metadata and
records the length reported by the XDP program, but only copies the
packet data starting at xdp->data. The bytes in
[xdp->data_meta, xdp->data) are never copied into the new skb, so the
skb advertises metadata that is not there: after eth_type_trans()
anchors mac_header, data_meta points at uninitialized headroom instead
of what the program wrote.

Copy the metadata together with the packet data starting at
xdp->data_meta, leaving skb->data at the start of the frame and the
metadata immediately before it, and record its length. This keeps
data_meta valid for the stack and TC BPF, and keeps the metadata aligned
when stmmac_rx_vlan() relocates it with the MAC header while stripping a
tag.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 30a2774d722b..8a2faf50d695 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5519,7 +5519,8 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 		return NULL;
 
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
+	__skb_put(skb, datasize);
+	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 

-- 
2.56.0

