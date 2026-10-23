Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743044;
	b=ng+VCo39uDV5YCiQdjJucWtNH2WCut6Tqpc6a1izYnL92XK8s6w9dWNgaa6TWjVrtrTT
	 UkKJN0ZQy7Q4aUhf/GZfTtnINGB5njUF0KMv3QyYwXSpXU6GeKaGhiuR2RbBCOBb6Y+d3
	 2/4uhXxrKmu5u+lK9XGIIXYmGbuoiBENTNsesr172rU0/PdLn1CahP8qdky6mPrK3yWKL
	 1MXO/P3EZ+jdfw5dstWHiwnlgzwaXuqVo8uXyjDyCuVxs7sadzO9Tz5eRst/38hwp3vD7
	 rjjUOEnfbYYhl+cCEUWu3XobxySvQXUZ3uYWRlXyqqe2s5BSD+zk0DqcN7kZnNz/5WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=;
	b=Lg8Wdkz7Mrc4dbqrha8ZkvKKVzQsy7L0x66mrj5Ul26ebKxj/9+YQjShcsMzfTo0F/cP
	 bdk1+KDXU8WPBbl2EwM1AUgSI1DYPM5iC2wKtwz1FWOcRDHtTHaQRIl/BkQFFybe1fwTX
	 9w2kWBlsLCZWdJ17c7koTaONG4cMJV1kfMZBkJ38LJSte78slpa1jw/bRVcelhGTJCadn
	 a0NEID3hWQw2ZS9Ebnw5NMkiLq1SjddOnfwxj98QLW9pDXuMOd0/XwUrOTBGx56NYA6jA
	 nsxWseM8LcyTfe7+nt5VlzT6auuklLT+50HYCyjP+D/p8FQMdNEV6LFFqaU8REZ2v+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzW6AGf3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="VzM/vIrG";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32E606A325
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C32E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzW6AGf3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VzM/vIrG
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FTLb2650364
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=; b=CzW6AGf3CPsjQ3+X
	tK2w9rMlmIjzHFoQV2ls9lGngjkxh9ePJstID6lovQnlgqlu6x5SMP7QKX/qj5f+
	AkDr1X24++AoEVscHBeVeTsQr3V9kH1yhbZQ4rxYJ85PXbvjxmFV9EBpoapWTptI
	hYVFKM3Lsj0shwgVN23FF0btPdVHB6cNLLJghAo4iwbEwqNQdXiyyOwLnAlUbi9E
	s4Kzx+2dClDnP03PHoQeSPtVBZ6jbEEgkolxnm6jayBtnVZKDJQVAhb9geJGuuKX
	Mv7ZIug+QDaoJqB0RxigT7HEtSw4NhO3QcxnqtJGTdBnhdZqnMHikFXOOuQnJpDY
	PgMmVQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjapmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so121479585a.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743042; x=1793347842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=;
        b=VzM/vIrGyOjAT7aivcYQ8h83tKdkML6zonI0w8Q8bF8ITupk3xpjXM0pozNUvG//Ph
         RxiDmv/yRlezSGVDTqGTJVGIc7V4GO3RNaYJ+JSW1OV/OfONL6GPKUY2ikZ2JqFEJ2qT
         CaC5AeJpDM2/t3LSFcW76raIUPhdTovc9Apr9ZpNGbcUIPuU/QfDKswSrLxUi0IPR9sH
         9NimrGRRIB2Bu7ZOm/e9jfGl0Xd6jCCEI5pOWBPJ6trvIM1jJRDRUuQM4g0OswfrserL
         v1Nuq5g2owHq4PBsmrMthtF5+GNT//XomJ+6NOfGbTo/D8dqwkBBS+fNSNbHHMcZTvva
         9juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743042; x=1793347842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=;
        b=JO0G8pd09SByqq1G5m8oQGZ58WmHGYamAvwAbhjcSZ3Pv3YLpLtbOcJxmLuIiDqB/m
         h035WZm+tp4RHSRHa0XikKgqvgOK+NmRfvFne3OXnGrtk8QjEq2+b6TVtyO7Kfj17MB+
         r3vGMpsV1UHBxQkRkW2BhSyYAh27BZZ+kTgCaqn3EF/PiBUW/9njZInrT84530OcEBCF
         pxB5TvPVSQ7SXHq/OEP4R/s4NXl08mSTE+oYh2xv/C2j+/CeVwsU1z5WGmmA+1dG0ZTl
         p/tByoc4lMxMlFOwBPNdSqbr1DciIHpMvVbvNhwe+GsFTBE2p6xmlNZqKv9j6E7JzE+U
         8opQ==
X-Gm-Message-State: AFq9FYI9wLnMtnE1BJUVe5SZord4C9ufmcX3k3TtzJcF6HozG2jOOm0T
	eelFqgWThdaZPkCm+j50oVkcqw1jCkTjZf4kaZWbbN5llSCNgSbO/3xQJx5fI5Txdtap5MIx/Yq
	u6wtRhyujAXgODR4LrmsBjZy0sORYT3ni7Vj9cFXANc2TETI/SKQl+UyfJdI=
X-Gm-Gg: AYBFou1lkhxSd5dBh7+HoeN8BaTfw4V7jV1HwLP8FWvJ7z+xxZj/2dtJi2bO9pWzOd2
	Syowm/eF114OTiklP+RTaN/hfUXbqxjRiJ5dq5dZ9OlvJm4ZEjP7YHLBvZUodkjLqkNIymAo2eb
	2PX97z3jejGYb/dSuXrqg+zt7t0NTKGk/aCX1+oV3baTC/TKqJF3XfBjh/LtWKvGEZIByWPHehy
	0/5RRaKje5FFpClvmSmQMKFes5hxxVzmHQ/VdkrnW316mXg+OfJYrraE0FWu3PGmh+q7Ac5jBiI
	mCjeb8eSvcTnNghZbmmWKSO72UpH0KS237N7V1FdKVppjXXqqTenjaQYe1Size00fG02KOxQZ71
	sPRiAhJZcoSY=
X-Received: by 2002:a05:620a:2620:b0:93e:c12d:4ecc with SMTP id af79cd13be357-93f627ef31fmr720543085a.44.1792743041567;
        Fri, 23 Oct 2026 01:10:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2620:b0:93e:c12d:4ecc with SMTP id af79cd13be357-93f627ef31fmr720539085a.44.1792743040971;
        Fri, 23 Oct 2026 01:10:40 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21046b92esm52603085e9.10.2026.10.23.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:57 +0200
Subject: [PATCH net 5/6] net: stmmac: fix VLAN tag stripping on short and
 non-linear RX frames
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-5-efb37e19f5bd@oss.qualcomm.com>
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: pQCZrHa3xjrKKQ9r3JIvs4Tr7DhZt-w4
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb1682 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=hePLJVBFsHslUFHqtFkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX7qg/nwLxzlyJ
 yKsUclcgio4SzHuVB3asEMTLw15blNI9+sQiyGGFvTpzPEmtqh3C0AlLp+kr9Qbm5cao9/rqmiT
 RlR179X+TIo3WSH0cDcu6HuoT+j51oA=
X-Proofpoint-ORIG-GUID: pQCZrHa3xjrKKQ9r3JIvs4Tr7DhZt-w4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXwRcu/8j25Y+8
 uWDKOwloMzY8snHv3TgLBMWK7gUDTH5bFi1cAm/S0TNm3eoyWXuYnH2cL1jZIZ8nWiE08R4bSeR
 AuDlAIKbn+fZkjCMXt+oWj2nqBrc5sMqIwvP9Q01T9/XXE6BJ1mv4YwrtImp218ODdKwiyfcbQU
 /Hb/nPJMiSWtGJBWhUqkBMwwSxGmEpRAY6uZM0Sl+1adR7TTHOGmX0BqJafKYbWYajZFSSVBCKr
 CM4s7Obw9EkiUdfGKa4KcvPdHJ1bVzt475vpSQc8XvmAh463olCbkkRlLlcPieZuSMFRPNTbx6R
 r1mV7s4KRdwHCMVHvwcTmrJ1Kyb3PngQz+yWLvbQ/UMJSl3QUMTnddU2nOr16/fbUqhf6U+vOC5
 SvQwtckjCdlAp3XRmwwTeU0Xg0AnV4OHkNpQo77KvaMGvNKUkRUcMylrlF3QYodXfhvbc+ARmaH
 DIOnyg/Yp1PDQoU+yBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

stmmac_rx_vlan() reads the VLAN header straight from skb->data and
removes it with skb_pull(), assuming the header is fully present in the
linear part of the skb. XDP can change the frame length and head layout
before the tag is stripped.

An XDP program can use bpf_xdp_adjust_tail() to shrink a frame to as
little as ETH_HLEN while bytes 12-13 still contain a VLAN ethertype. The
driver then reads h_vlan_TCI past skb->len and pops the tag, leaving less
than ETH_HLEN in the skb. eth_type_trans() cannot pull the MAC header, so
a malformed skb is passed up. The TCI is also read from the wrong place
when the tag is not fully in the linear head, e.g. when it spans into a
frag.

Read h_vlan_proto after pulling ETH_HLEN into the linear part, and check
it together with the device features. Only if the tag is actually going
to be popped, pull VLAN_ETH_HLEN and re-derive the header pointer
afterwards, as pskb_may_pull() may reallocate the skb head. Return an
error so the callers can drop a frame that claims a VLAN tag but cannot
provide the full header; untagged frames, including short ones, are left
untouched.

Also move the XDP metadata written with bpf_xdp_adjust_meta() together
with the MAC header when the tag is popped, so data_meta still points at
the metadata after eth_type_trans() anchors mac_header, instead of at the
first bytes of the destination MAC.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 48 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8a2faf50d695..32b2c5834c34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
+static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 {
-	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
-	__be16 vlan_proto = veth->h_vlan_proto;
-	u16 vlanid;
+	struct vlan_ethhdr *veth;
 
-	if ((vlan_proto == htons(ETH_P_8021Q) &&
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		return -EINVAL;
+
+	veth = skb_vlan_eth_hdr(skb);
+	if ((veth->h_vlan_proto == htons(ETH_P_8021Q) &&
 	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (vlan_proto == htons(ETH_P_8021AD) &&
+	    (veth->h_vlan_proto == htons(ETH_P_8021AD) &&
 	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
+		__be16 vlan_proto = veth->h_vlan_proto;
+		u8 meta_len = skb_metadata_len(skb);
+		u16 vlanid;
+
 		/* pop the vlan tag */
+		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
+			return -EINVAL;
+
+		veth = skb_vlan_eth_hdr(skb);
 		vlanid = ntohs(veth->h_vlan_TCI);
-		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
+		memmove(skb->data - meta_len + VLAN_HLEN,
+			skb->data - meta_len, meta_len + ETH_ALEN * 2);
 		skb_pull(skb, VLAN_HLEN);
 		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
 	}
+
+	return 0;
 }
 
 static bool stmmac_rx_need_ic(struct stmmac_priv *priv,
@@ -5546,12 +5559,15 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	}
 
 	stmmac_get_rx_hwtstamp(priv, p, np, skb);
-	if (priv->hw->hw_vlan_en)
+	if (priv->hw->hw_vlan_en) {
 		/* MAC level stripping. */
 		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-	else
-		/* Driver level stripping. */
-		stmmac_rx_vlan(priv->dev, skb);
+	} else if (stmmac_rx_vlan(priv->dev, skb)) {
+		dev_kfree_skb_any(skb);
+		priv->xstats.rx_dropped++;
+		return;
+	}
+
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
@@ -6057,12 +6073,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
 
-		if (priv->hw->hw_vlan_en)
+		if (priv->hw->hw_vlan_en) {
 			/* MAC level stripping. */
 			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-		else
-			/* Driver level stripping. */
-			stmmac_rx_vlan(priv->dev, skb);
+		} else if (stmmac_rx_vlan(priv->dev, skb)) {
+			dev_kfree_skb_any(skb);
+			rx_dropped++;
+			goto next;
+		}
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 

-- 
2.56.0

