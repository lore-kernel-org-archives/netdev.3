Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBC36A341
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580216; cv=none; b=J76rOy+p/H4q+Q8pNkkxk+LWmBSfVDUdW6wYNP0Hywb+rYBKLvYUlkO03ciMO0qvSvWbTuHKu6qMynvGtqGzY2ezy2lMRITUrgMtP04Sg3gwmx5r1yhcxXeemmAAojSbDCJZcmXKyj5bX7H13Vql6ewMJVRschtIuIdojj/INjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580216; c=relaxed/simple;
	bh=KYZFP0gPWy/Wd7obFLKDxyqHNqvG5d6OlBTK+GoIZAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HFbI5QKq4s0SMFu1woFHBnpNRZ0omwHLMjumMsdgudW9UBJ/5wBVjdOoE0f1WOUOiaQWV0WDb2p5fq0TK4Ce3NNldNNrfiwgI2Rz1WhOqzc7mdLrfIEHiezB7BMfiqUKDdFpPY9+v+RTfBSzr1SN7a9JVim0Qf/vAT937XVYae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ehfCuvvW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWCf3weT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehfCuvvW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWCf3weT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S6eQN3718408
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=26JY99h+pS0QjWl2fYV2iX
	kQch2O4CTOJVLN00yVygc=; b=ehfCuvvWwkztX8U2y/h2lcCK0LFh9sRldBMJmT
	u+ZWZlwWaodsuraqN76fMI4lRyto/YRhzzFsB7dY/01Y+RXw/RRxm1hHMc2qIVWV
	gYOLAWBDmKNLqB2+RfX0oEyLSVOaq25rMRRb/o0Mo5DfUGF+T2SVsdYqLOKhxkIe
	JWxtpl2D/mNbJVHH2rGrVqDkiusC1CGR5o+to9y4JcErXuwjb3oP8lQuc0lQoB5E
	yP1NsgauKkJHi13ekKqdJ67szPN/du2c28a0usySZHtEolCDN/0/NSB5qobqaoW+
	32cGfut3LUN/+JLp4BB3wZfjqPReBCLSGHVMQDkmBH4LuYXg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526n3d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:23:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c599e3d3bso375482885a.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790580214; x=1791185014; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=26JY99h+pS0QjWl2fYV2iXkQch2O4CTOJVLN00yVygc=;
        b=dWCf3weTdhJuu7WAEjF3RcizY+ki5/Nm01Ph/e6sjeP/ZaB3bd7spOXSB53N2jQXz6
         QQpdtBAb2ME3YhJeF7dIXD7+u1zB54lskqGRrAfNfD33+cGbxrN/sZoA+N7D9wg4PG/+
         5ZKTUPto9AJ79LKmHIkFGh4MMQ7mA/iM9i4hrm3WACT35VGtmqjlSq/uTS6LkRpwkZpd
         zpL9A34/oZPEfFD0uprWoNOLd8jROY1uQbwCzKdBeYeLQTPjEpFgXthkJaOZJixOB1Wh
         0VoR6lEDOOgfdAlqI5MWag2snLZtXcVyvaF1Hj7X3eWCXBIBA+3rMbdNCcGpe0GtEQhb
         NVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790580214; x=1791185014;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=26JY99h+pS0QjWl2fYV2iXkQch2O4CTOJVLN00yVygc=;
        b=SZqIv+ctjl1YiXmJUJUYn65EqzWFiQntBlnIAPDsTVyuWU08gnjLbt1jyi8hGgWPF6
         N2vLO4N3Ad4IQuNCjvMONV5wxG0rQEjjP6hfeTy5nb9YKm84IwDm+hv6fuQU5cUWhBoO
         IKj2w1xdwml4C8WyakwzK96wA0USPsFsvc4UwY67uXnjOe5UdJefHO8ujqw2BmiFJt3m
         r61+KHIDAxZlKZZsYAyIYcF10FXi6BO1ZFuFBvcVbqULJDCi6yn+zIr8yhQiUTYpGzYL
         hAFNOVTBYotrTU2NbJ0zfd6qaSJoSYzDFiTXfxjW19DbBzWnkm+C9vdz9BAJX3PL5X7W
         Hv7A==
X-Gm-Message-State: AFuF++mIzKaTIQ7Ycv8oPtssAXG04CgboIa5p1rHCBdUWkqpMiFjedyo
	xqSkRl7sXyxRNHuagxLpMG6g1cjWI0/DUnGefWVQlvn5ySZECPNswVFYhz5E9IvDSwLs9OMrmQw
	Fo/rlr/OHlv6ALoAOODdT+6iZIQIfn2xnGgzUpG9lL6CKteOVfNTb4MDaMfQ=
X-Gm-Gg: AYBFou0PPCUvsxXilzasDb3GbrSvcNa6Tzd4ceM9Qb9y8Tv4tJDCTsKXLCVEjcm9o2r
	e8vxk9wSkZkTbEbbYElI24QN/048e0yqGWrO4UuDY6tLJilFOurIaTyqH+ctS6orSYaBn7bmsit
	AMJFU094OlvGCym434VViKFlFXELu+lUZ8HCJDHdk84+VZ5R7+ozGTGBEPbOR+xxG5gj+nsXWvh
	HKDUaofvZ5M8hXc5az+5Cvq4vaEa9HTC9a+pgIogxqH0TnN3Z4tuGtWuMcb9EWKm8Xeu7ikv25E
	LVfsOZri7y8LtYwpCVYKKKaTF0wlm/32qkPzA5r6W3FY/zE4ebwEFdpf7KCnyX4MBf6mEd4wVl0
	uwfB6xFTAesvjSQ==
X-Received: by 2002:a05:620a:4408:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-93c43cfd229mr1943777385a.21.1790580213728;
        Mon, 28 Sep 2026 00:23:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4408:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-93c43cfd229mr1943771785a.21.1790580213090;
        Mon, 28 Sep 2026 00:23:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ced69sm165493075e9.0.2026.09.28.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:23:32 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 09:23:11 +0200
Subject: [PATCH net v3] net: mvneta: clear XDP pfmemalloc flag between
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQqDMAwG4FcZPS9iK9Z1p73H2CHWVAtqXeuKQ
 3z3FXfZYXgJ/An/l5UF8pYCu55W5inaYN2YQnE+Md3h2BLYJmUmciFzxRUMcaQZYWkm0D2hB+O
 xBWMXqFBLxYnLUtUs9SdPab3bd5ZK7JGWnQ2z8+/9X+T76UuL/ICOHDg0FRlsSBtVqpsLIXu+s
 NduGLI0djyKX7A4AkUChbpIVWBFKOs/4LZtH8Hzdf4fAQAA
X-Change-ID: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6aba15f6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Bf4p-39G4bmrPmVIT4wA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: i9HVDxJandlMpQoXbIfVp_FfuaAE3mBQ
X-Proofpoint-ORIG-GUID: i9HVDxJandlMpQoXbIfVp_FfuaAE3mBQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfX8HmS27DrRoJt
 mkH00nDq41ZjmHOe3TvnW759vB3/Zb14WGuKtnOh6QnmlWl5AN1u26WxJMUV/uvH74ZWPCdIz7e
 Xjdfk9r4FQ6Tq1jHmL/Lge7srATe0yhWj16VEWrRlHaqCmEFp5EfOGbEzxgu19wOL97utlcCIEI
 hTRGTdEgO1FejIu7cIRSf2+Q4FndpQ2pQh7padBwyAXpOCGAzA06TNtrOrrRDPWjrkTNP6jjJI/
 JqrfFBaRhOrJ8TCIuNOR4wkVLePzs7eH6mF+kc9f7OmFRgFfzOVmNoWXj+uGkLu5+l+H1l+fj/P
 QFfOUEDcJ17zmKma3hAtkHTdWLkEEPogWIjZM4CLJYTuTRkft/NE0v6zUpoUZsdvKB7VWjx9jgj
 XinSd2dkxKK5fC+wD9xOD1bQGJc5bKlKAGbhUopfRNdR/Iau0yxq08CqtxoTr9eUd8waIwHIvUn
 jSRvMTDzmVPi8f2aErA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfX2RfEbuWcAsFl
 2fkiPkGgSBws92AHnP26XHBZYHAWC0GyAgGSZhAWCFwpSYMktFdSVc0YzuZUzXvT7rmlJ7Am7xK
 /AjQYK8pQyu+TS+xPJ2ZWzvO+fxE4Gc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280029

mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
xdp_buff when a fragment page is a pfmemalloc one (page under memory
pressure). The xdp_buff is reused for the next frame, but only the
XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(),
so the skb of a subsequent fragmented frame could be wrongly marked as
pfmemalloc even if none of its pages are under pressure.

Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.

Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Rename xdp_buff_clear_flags() in xdp_reinit_buf().
- Link to v2: https://lore.kernel.org/r/20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com

Changes in v2:
- Introduce xdp_buff_clear_flags() utility routine.
- Link to v1: https://lore.kernel.org/r/20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 include/net/xdp.h                     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index c2b1098d8d1d..485af7e395ae 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 
 	/* Prefetch header */
 	prefetch(data);
-	xdp_buff_clear_frags_flag(xdp);
+	xdp_reinit_buf(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, true);
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..8d928eb73dc1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -106,6 +106,11 @@ struct xdp_buff {
 	};
 };
 
+static __always_inline void xdp_reinit_buf(struct xdp_buff *xdp)
+{
+	xdp->flags = 0;
+}
+
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);

---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

