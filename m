Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71164D9F93
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983403; cv=none; b=bNUHyGgSdzjvGM+mQr7pj+ARigVg6XlIOzz8VxggDT+y58WBZEl1DOJZwvM0limuNyI40hj2dce7hzsVIVTZnxykBYrjckqrJt/Folhn85JgHL/fw0vxr/Li7WCb3vgLrmujKzfoKAyv1l9Z2uQfLvSnvkj5FHKqGoXn5/jFMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983403; c=relaxed/simple;
	bh=qH17lBmgiVluKz5vouUMh+s0kY40L+S6WMyX+1BJDBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtUgVNgRFZv+RLeYXgVG9jZohnveAz97jX2zd6GTJ6XpJJQ523NQgaJFgevw0wIMUi7mfgiUHemOUXCIk5Dn4oXA3cVhHqQ3i2i3Yzb2JwaX66Cv1vySCqI81QEn/TTETdOdA4HVtdjYK91WuQ6/5MdOJTtpMOOfvS/znETe928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJVrRUys; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drV0oBsM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJVrRUys";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drV0oBsM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E7ObOZ2874017
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1VCwModZDCtBhM3y4K1tnj8cU+tnsu+uFycA0xv3Trc=; b=NJVrRUysbB17dyLJ
	IayeCz8/x52ovPqtRHaoVKrSx6jZ+ORObHAy4JN2OGF7BPdBhY+HmbEX04KDy1Aa
	KI/k1JB72Vy4E+F1hmgXXETGKRQGRpnr+If6XyCKhKKvhnk0yY8lmDwDT8SQXCXM
	9G1M7tNhtZisPOnSJPUvf/3ALKWhFIrXkLx1LmvT1i6vPuMnVJB3HmRzyOWTcGif
	UqHowTzsjUSbYl0cXutXVMSNKa7Tm18sKD7t5Ksi7NlV+r2N1xrY50q36foVdWtz
	MwieIOkyhBw9/Za4j58A7WiolIzAcsOYdKoKc9mt0IFKe1jxA2HQtmPEo5sY+6+D
	JB7cCw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphjp3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:10:00 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c0bad5ec1cso562229137.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983400; x=1792588200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1VCwModZDCtBhM3y4K1tnj8cU+tnsu+uFycA0xv3Trc=;
        b=drV0oBsMNovh9a4FcisjCAFkFol6d5RpenaUNJ1b2G6whjDA0uyLH4q0pEOmj79o1Y
         ujSIyxl7BG3YgKAX9AO+N/zB6PYHENrMdm8hbdWNG1MNAWh2xEBJqisaxYKd8kskSZlt
         atRcHBx4ZAIN+kxjlonyjSiGnEln/VRjYE7K13uSiyAx5IQEU4J3EZEH1leFe40hXrNT
         5qDjJba+YaHVCWa9whkLZjTx9FtdIw3E6n3PR3bTep4aviKIm92Bx3XVMLls84oWTMQ8
         OI5Hv0BtP9pSKb+RRo1OjzSSUzzpJzBo2XPemHsbN560Emvr9hDx+/1Y8FsgKAmjrQ6X
         BmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983400; x=1792588200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VCwModZDCtBhM3y4K1tnj8cU+tnsu+uFycA0xv3Trc=;
        b=MpJARgn9amW0iu8QRL6Bjrf9xr8bwOGeyR5AQBqrSpD5tp7zIqE05U5j2+KvBpwcmh
         UV6/K7KQXdrgQJ1++QFWZuuvennHzPc4yfRtLIU3FLXIeP0/A50wj46yZCexfhGBnqBA
         TEtD5CGtO4+/l6rlauwn/F6ePOTvQMGm0MXLMJEVVV4yhM53wC77Wf9tmmguFwXZugxB
         Dv7WPROSqtJk4TnQ962ALNSsZh/j1e3Vdtwv2ufRRDwYJs0L9IDRk3u11UDjCRsqF31A
         C1byLSCBZ5bH/TtA/bLEuDczN+NzEbwzWc7vXtTo7VYtnYnCFRHmiSAuuPhRoR7it4yB
         2wgg==
X-Gm-Message-State: AFq9FYLkfXaA4gLG510Pb/us7YdCUnMLW0TDbj5YBtBtgfzAh+aqRFfX
	gX+ErqpvDwDaCd4EP6RWcS/Onz1HiduR0nx05ncyIDCp+9tevPycvm24fjySLkPdFQPe6uY9JQ2
	8uk4Gy1TilmXC9GB+gM6XSnKXF8noUdborqE5qHnGlDe18R46/jqGG9r7jQo=
X-Gm-Gg: AYBFou15f1qrGzcCL6HShBJzOe6txAi0KbBGH8XWmxqnbe3ZkSlDJDELkamzLFeEgPb
	ivdGGk2SCJOfN04EwUw5gvFaRkbQf03kcGFe8cX9BCrKlpHcfbw3QMMCl9tw3+zJRZhAYjz1s8m
	SX0LkQHp4dO7XHPipDjsMGmmH5kFz3sOF1dLV/cVwSb8laefCnx4H1NsMDHGXsnQwyze/tyWls0
	QAMAC8n0CIeB9VtvXV8V16ucadMxZ5htW8vSXWCp/sPC6gY3bslZvD30hTEsYPeP8wTrrOgx/du
	rkLjxcxxiqdsiZeww4YHchv+4aPdc9PQbqc5TO9BywrKaPbeijRETNod4OJqrySRB+oSmsjzMv9
	E2cAm0iW2Ygyw3g==
X-Received: by 2002:a05:6102:1609:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7cb372de97dmr3646950137.17.1791983398183;
        Wed, 14 Oct 2026 06:09:58 -0700 (PDT)
X-Received: by 2002:a05:6102:1609:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7cb372de97dmr3646922137.17.1791983397411;
        Wed, 14 Oct 2026 06:09:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2ec47fcsm55844895e9.1.2026.10.14.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:56 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:09:36 +0200
Subject: [PATCH net-next v7 2/4] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-rx-mb-v7-2-5d2d70f052cd@oss.qualcomm.com>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
In-Reply-To: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ZXsAIsD1PmI_3nL8cK6KMI86uov2PWxi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX4OxnkB9kqGRH
 pCDpP02Yo8Qhk6zU5soZTXVIdOLDBO1E3KuOTgYuvDjPSyDDldukZ/YkMPWRXNKNFKkU0Xc6sDe
 ctjDGlbHmcw+l6l5yVCi+lN1K0ByDn4=
X-Proofpoint-ORIG-GUID: ZXsAIsD1PmI_3nL8cK6KMI86uov2PWxi
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf7f28 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CzSfKeaMSJ9arFq4QbgA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX+FwFrWJdEfa7
 RBMKobDuvOB3vYgFx9aB2KJBekTpK86CwEYDzHi4H7YP7G1LJXu8M5GEQIcQwitCj6xtA9JDFDD
 65zs5qFxO64UmsJLW9jXUq04+HnSyZHenMEKpDSwZP+JZXssNVEKVRYGyJgfpPb304KNQnI9QdP
 33SQztFmTS1SvTdCYQK62pJ9WDOjZ5z4Vythki5ceET4osGkWK464W5ggGJ6vj0nSLoWpQi+hnT
 bJGNimngiEDGC6yMRcuXLoUSUWGvIBqtVQy9u5cMrOgjrNhYL+N6W2q32OGPL1rKZkrhRU3v+2h
 IRotrvgLalqt4jb83pvdxLRp7b6nMPCRv6rbfuFSKewsiQ7g3ARzH8HiuZMfvV9pDo1EzeH82ga
 sLpRndV1xMjnfs/lA9alio8w85RCcj0svniInpj7OzMChRGovDzHnMBCR4r0UbGsGY7/3170fgQ
 pUvWT7cvKigpMv4yNMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
XSK pool buffer and drops any frame that spans more than one RX
descriptor:

        /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                dirty++;
                count++;
                goto read_again;
        }

The non-last descriptors are freed and dropped, but the frame is not
marked as errored. When the poll reaches the last descriptor of the
same frame, error is still 0, so the fragment is handled as a complete
frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
or converted for XDP_TX. The tail starts in the middle of the original
payload at a predictable offset and, parsed as a fresh frame (len == 0),
stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
though the DMA engine only wrote the tail remainder into that buffer, so
the reads extend past the received bytes and can reach beyond the end of
the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
when the interface MTU is left at 1500.

Set error when the 1:1 mapping check drops a descriptor, so the
remaining descriptors of the frame - including the last one - are
drained and released with xsk_buff_free() instead of being processed as
a new frame. Account every freed buffer with dirty and count the
dropped frame once in the poll budget / rx_pkt_n. The direct 1:1
mapping drop also increments rx_dropped.

Normalize the legacy normal and enhanced descriptor callbacks to report
rx_not_ls together with discard_frame for non-last descriptors. This
allows both stmmac_rx_zc() and stmmac_rx() to drain split frames on
dwmac100 and dwmac1000 instead of reparsing the final fragment as a new
packet.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601225..297e2428a8f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -184,7 +184,7 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c4b613564f87..d19bf7ca4db3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -70,7 +70,7 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f0835be2f65a..10ea72cbf889 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5695,18 +5695,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
-			xsk_buff_free(buf->xdp);
-			buf->xdp = NULL;
-			dirty++;
+
+		if (unlikely(status & discard_frame)) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
 		if (unlikely(error)) {
+			xsk_buff_free(buf->xdp);
+			buf->xdp = NULL;
+			dirty++;
+
+			if (status & rx_not_ls)
+				goto read_again;
+
 			count++;
 			continue;
 		}
@@ -5715,8 +5718,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
+			rx_dropped++;
+			error = 1;
 			dirty++;
-			count++;
 			goto read_again;
 		}
 
@@ -5883,7 +5887,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
+
+		if (unlikely(status & discard_frame)) {
 			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;
 			error = 1;

-- 
2.56.0

