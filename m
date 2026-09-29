Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6152B1FB
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689412; cv=none; b=Ke0UYHeG6t26KeaQ0UWiUkrdyn8Ye710e6jnk+RPgKoae71K/LHbLRrDVYPZyepLqYEorlQzRpCm0z4iwm3ycbxdWxLQOngijTIaWo5jXbnKcOEbweT1nZ7+FNrNRACAFGLtUXi0JrYAmEM3NHQckPZdUDZZAbcnG/Ej1CErE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689412; c=relaxed/simple;
	bh=pV/ZMk5J6GubE+E3E2CVe/RelLgGSPYJ2djHsRUzvuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B8YusQRJIOfYPNyt8ECAD49DIfMkksZZLzPu/FG5lynAEkgC7Zx3qqnPrFKaqFENDhferD/4FG94sXUS17qJ5K0BsFL3Vd967DMcVxfV3bWs1TIHleI4tggskJJs/7H68AKACuiMdwrIMtt9mD608VgWwPdESBEZk+Vl1nqVUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WGJiXzY6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QNOPUkD2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGJiXzY6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QNOPUkD2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqhQt858094
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yhRCxmzlZwX2jgGGGEOlYA
	aVNuB7SIC5mbkw4tMhoJY=; b=WGJiXzY6t1QlpWtESXBb2nBQT2oG21GF8ZLG2e
	UIcn/xOFSLoa2A868FOv2Ri+xbo+a/Eo0v6qaAriyPlhhPWrAUwALpK7E500MX9M
	jldiniTHJdrwKXDepJB31GTUi2Ut4fW/14hPl1Qr784R8A7MC0hwQYEjQfjfpZz+
	3paWVX2aWl5k/E/m6p27nTDZz6Ib2g6COH2a4q+FTr2Gq3rYCLBQ+oA9KyMY+Jjh
	SC8KdAeNgJiGnzkM56C6y2Nm1AhPk8sinsXgbQlmeny3rbOd1yjZC4AOurmp7/qN
	4BQ11twph6kjwyzltgMpNCgHGrMESUFJ+MmylXb+HtjSrZ7A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0hq1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:43:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bf4c0af4eso144744185a.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790689409; x=1791294209; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yhRCxmzlZwX2jgGGGEOlYAaVNuB7SIC5mbkw4tMhoJY=;
        b=QNOPUkD2r23ventZOI0S520h7ZAwDhkdj1owsGVwF3szE/tdULPFVdeOL41mcg1gZc
         B1dHs38GkAVjhtxjNbxLDzKsdfu9w9FNTz3vuvNHIYu4srs6GXg/1rka+iQMMhoFsyzk
         MqB6WXxGW6usYbjwcYfkIu/EQX6gV2Svzli8XPCvPvmxoaG0P/DxqY2LcI7tiJpjac48
         3ufDkJ9SKCb2Sjl95ljIs9Ranweh6QjFK6BMdkoiZ0DGOD/Dv+SsGF4/wZjqCI+uZMy9
         OhUYKUj1gYvjykmHuiR2AFmLsxCsseSrLdQAtgzlx6k2l5Mp2qMWg2kq3r6ORut8VmLZ
         Nh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689409; x=1791294209;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yhRCxmzlZwX2jgGGGEOlYAaVNuB7SIC5mbkw4tMhoJY=;
        b=JRTJlgArbyQet35u3UPbbTPwT7Y8vrK7QX++f4Gd3FlEb+kEx0nu/EqH4HK2Gimx2t
         RcyPQjOc8+xPqG79wyuN/OIzjM43ncorzmhZpAu/hdnXaGJ+Mepb7j7gauhevIktTsSH
         W260YbYkpHRtMvZF+Br2eJUFLZYqBUhOve7+OcmGSTjZAN+40WNI/kc07wV8U9o95Xu8
         /MBcvpbpaRcV1C4sRVLHNsoS075pQt7B1oovHT0oRBaOpH9Uy9sRclDB3MT4XTt5RdkN
         JAhhnEbzTgZ+gV7eDGmEAja+PK7vTOPTaHJR83APSYUa9bmKDgWxDwpfRXRfjmXJ6wnN
         0qrQ==
X-Gm-Message-State: AFuF++mhJjhvDClXYoBkIOuNlorivuysruVB6KIj1N/i9A8iMhA6wdkG
	UjpLksKqPoAkyQLtzmxZaou68y/Cjvfspa/CuT1OKQs6e+mRTqJqJG4LC3kjm+Q8/PDYYt8Owge
	nGIBkyTwEBvhPpAWsDpYhFo5kNHTtLLJYEXhMj8/ujCw8TewmBHR4/WY521U=
X-Gm-Gg: AYBFou3JTftW9f/S8BE7gHR/JPggSZwSQ63KqqjcwvOnQsco8Orgvr8WSkZQBZFMUfN
	KSNiQApnBTXmYAaSRGGJoEr+whTNSVMXI6N3rTy/IX5Ms9ML+F+/TR3e2a9lAtSTyXHmrpjdK42
	M1YycKVpGfGwTdynBl+NZwKdRukWzcVf8Z8pZKlZkcK8Q9gto7/BauxQEW9r1LxqH3pEDV67px4
	BszWQeYq5JIvhtlAYX1Q75aEkwdJ4FncZLLmuzJk2RLUC88uA/AwJh6zW7hhGylRwK2qXN/S0cM
	e9ioUVEMDkTxWK9qG2NhCwu6FzuA8eamEK2Tdjbp5P0jneSJBgkQU81HB2PYZUF7UH3A2fCzcr0
	b6sLJs8UzPNbx9w==
X-Received: by 2002:a05:620a:2b9b:b0:93b:c6fc:71e9 with SMTP id af79cd13be357-93c8bf447famr442075485a.25.1790689408543;
        Tue, 29 Sep 2026 06:43:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9b:b0:93b:c6fc:71e9 with SMTP id af79cd13be357-93c8bf447famr442068585a.25.1790689407896;
        Tue, 29 Sep 2026 06:43:27 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfa66e5sm93045535e9.11.2026.09.29.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:43:26 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:43:03 +0200
Subject: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NMQ7CMAwF0KugzBg1aZtiJu6BGEzqQCTaQgIRC
 PXuWGVhgC6Wvq3//FKJY+CkNouXipxDCkMvoVoulDtRf2QIrWRlCmML1Ahd7vlG8Ggv4M5MEXy
 kI/jwgIacRc3a1nhQ0r9ElvVk75SU1F6Wp5BuQ3xO/7KeTh/aFDN01qChbdhTy85jjdshpdX1T
 mc3dN1KxoRn8w2Wc6AR0ODaYkkNkz38ActvcD0HlgKSr6jWFSKT/wGO4/gGSjNPq3ABAAA=
X-Change-ID: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX0UEgoJP2AA2b
 vp04mtmrzj5A7H9GZOdCNiyjFO78Asx5rOV6OZSkodh7jXIpJ0ZZAzWrt1cg4ds7Va7yoYgSWaE
 E+k3LnP7hFZQNt5b15FOxP1hLRYtHxE=
X-Proofpoint-ORIG-GUID: XCPtTX6EDH-ZDFTOGi9ewvjNn_oQ7F4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX5XBp5gedCby0
 s0EWspD22ijTdUkTRMtyeCe6ZijnZS4acWvPiCgDyES6qK35EdD0Sb7q/zNLay39zbmEyQ/yHev
 3KDrkshN1uzaAUPWz8L2L3hSuHAXwcWA+p3N5GAhoCFX8tdHXKSwJlfyFb+xE7tTG5YtOr/TU/H
 6Ze5ElAt+vaR1LfgfONtcMmnNrg21E+coYbwy85II3ZWFJMzdbhRlpiGFgTfRMqi8w/EWmzcYuU
 J+qFPILBS1SfBe8GhVf6beEOzyfWAABgBEGctZNRJFyxN1pkB0+YZq210awg1l1LAk4RUvlENBN
 9F7OgJrLC7Ysigq7QsuGfVpNKRQvyb37sy00AU2PHSionq/4DHMDOKSJU/J9EEa58AggAnqJ/ZP
 aDB2eNOpjrKutUq4+Itffn+UJvlWkBdGL8709tbiCFbrEOUXCi8EHXY+1mM2DdoAXUuvGzDo1Sx
 bDA32CazjMe3Ah/mWXw==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbc081 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Bf4p-39G4bmrPmVIT4wA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: XCPtTX6EDH-ZDFTOGi9ewvjNn_oQ7F4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290054

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
Changes in v4:
- Rename xdp_reinit_buf() in xdp_reinit_buff().
- Link to v3: https://lore.kernel.org/r/20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com

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
index 543e566425c1..4f479b6f731e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 
 	/* Prefetch header */
 	prefetch(data);
-	xdp_buff_clear_frags_flag(xdp);
+	xdp_reinit_buff(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, true);
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..07231adfb5f8 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -106,6 +106,11 @@ struct xdp_buff {
 	};
 };
 
+static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
+{
+	xdp->flags = 0;
+}
+
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);

---
base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
change-id: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

