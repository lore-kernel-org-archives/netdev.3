Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1E1862
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749446; cv=none; b=TIbJQ3bcd2KBNY8LN5TvtzXjnwc5tKc4/HwQQBnh1wG9rP/Nl1N1qFJL2rVuAhlv8GceRiWxyXaHpXjGIRBv3n5tAWAPprtGtyC0j1nPyD7u0cU+u7M8vgUgJwHLzdsAucu7qSYBaUXNC+G0vB98BTUdUsgcF6KyiVJDYBMrq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749446; c=relaxed/simple;
	bh=vSVyEWjPeiVXONRbBe1lepSK2gDyL9eBh2Fn371wOxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VAWKYj4clYWj6+KEU9eMmWB7QDaCXMLmHlbcQclgFgFomwEmfXg//9eZApo4BASh0S8XjMuAPOW6ivO3weHhpmZADBsUiHwA6R++C4/Tos57Bu2bjmVtYU/59TaatIpZWQCYxATPR3hAx7cC8To6/4vO9MF74bJFD/OTWvdGXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eAV1yzk/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ky97OtxI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eAV1yzk/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ky97OtxI"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCCkdT883287
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 13:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Drh7nr47RmktzpGSg9HIsY
	IvZ9oCqisJanN48gX/rgw=; b=eAV1yzk/KY5o5a8IFVz0qzgCHS/F/g7vZchrT/
	Iqix0XOyGTI79TN7XZQ0VbMfzmBuJBMkyRDPBiwebaf59WLjO/WGRIk+M5AqH0/f
	/JHrhvxTqplpdr2rTJjCxvFFcFl8boRZoKXQ4rQSWbkHYHj/pZINL7r/3UVwNlqv
	t5P6ajrosXgz9WZOYS9H5Q7p4AMqUMv8OFYZ4/+LB1cg/H578OjZdQOac1UJsRNC
	1YstFrJFEIyUwDs0dk6bv/ayioiFiANI4FRTTJx9MKlciioKKIQ5UQLIKAjS8Zf8
	blHN4uhHJ7jObDpCfK79rzxHhX27zMa/0B98CZoDjmFQ7IjA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k27vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 13:04:04 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-73883529f72so785694137.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787749443; x=1788354243; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Drh7nr47RmktzpGSg9HIsYIvZ9oCqisJanN48gX/rgw=;
        b=Ky97OtxIh4WW3meXD+E4VVneRfdJ9CqrjZSmH76Xn70H7WSKRi0GSxneFCvCQMDq0t
         h7wNqM9g9QlonS9kqT7140l5+NrCxPVMwWTIYU+dx0+DPl8niJYxwEo7+pweBIDMu5Go
         6LgiTfde8wxNCwXBhVRBklP3OSEjsZVYVWvFTRQ3CCibAa6Rok3c/882ynjK3VKq+e9j
         yFYc7qJAQ7v/LxqQzFgHcuv+dzQ58VYjz7GGEYfOiDJq/02qrLVewQm1SpkaJJNuaS7n
         WKmAsZK68Q/in1wUOst8tx9INuxDOGKh2y5if5KaeD6USIHz5Ar+RtzcTm7ZH7NE8c5M
         RDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749443; x=1788354243;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Drh7nr47RmktzpGSg9HIsYIvZ9oCqisJanN48gX/rgw=;
        b=OgNvY5drsmXut/91pOE0bOdUTZ2QC0/l03O9HuTAMAGz8UluboeoBZvdEUisbjMH5J
         7UMLg45Wwe+LqhRs3DHSaDm98iT62025ewbB984HEKwcZm9fI1pbMqNfXiU+Yv1u7JPh
         AfIX1ampZ0dRSMmcJJ9wS5fLcRumGxrtO9PDpheb/zsbeH0ZhDzUN+TKjEDGP8foWaJL
         mScKnHHuHYAVjXnqAVcCZU+aPIP9xJakqbqu7ItmeMxa5IGfS7Se/igWPHTr49DvfEGm
         H10UHNBdvM0mAw9nPsy+PcnVnNL2C/mmltqhrPUYzY119KyZm2CEhcNoIBCqaa8YNkh3
         XTqQ==
X-Gm-Message-State: AFuF++nnYGXsaIk/WzsPYEjlEV953lVWL6s3njJ97jIMttxObunwQ9b5
	AKpF2Yihht6REoWFKzl8ILeYWm85NKpJOlLA3uUt4UI0VlyQViCbrKbLn75pWDTsyTBXPAJuN6D
	PDdF3Ac7gOs66e8isczCOcM3dsroERu5ue7E1R7tcmio851S7CFsCx2QmCuY=
X-Gm-Gg: AR+sD13pa8hwCy2X9YWbdoQzRCn7SGdsSVr0TZELbx0kduGeqh0ugQ1Qm1YqdSeZJuh
	VGuHrRShy+asH2lEL7zpk6rFQuim/BGS9UWvcEDtdOEpAcYDT838E8YK4Bho5MP2EpnbvZrbhoy
	k6i9JREbBu+ZLFC+lxNeS7kvasYmzC3fQUE9xCE5eufUsN2To5NQcAjxtAsicISrD3c/SKao2we
	TtQ8Ewjx26ncNk3M6yOq3DDe9Q5xavwPOx0gmSQjaXZV4mnqa/kQX/egnEmGRoQE4n2dubu5BlI
	W4mtr7QxLYqBwN7TIMTkpZKXNMLhPhVOlWsuMPHcTkzn06fI/EobVL2x2qd0k9u6F54m+EzTBv0
	wV1sToV35aMhOeQ==
X-Received: by 2002:a05:6102:549e:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-782bf9bed0dmr2002427137.2.1787749442421;
        Wed, 26 Aug 2026 06:04:02 -0700 (PDT)
X-Received: by 2002:a05:6102:549e:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-782bf9bed0dmr2002205137.2.1787749437769;
        Wed, 26 Aug 2026 06:03:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250bbc5c02sm381231366b.61.2026.08.26.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:03:56 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:03:15 +0200
Subject: [PATCH net] net: stmmac: fix dma mapping leak in stmmac_tso_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-stmmac_dma_unmap_tso-v1-1-a2753d1576ba@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBBA0auEWVcwBqz0KqXIVCfJLDTBMaEgu
 Xuky7f4v4FQYRJ4DQ0KnSy85Y7xMUBYMS+kOHaD0cZqZ6ySmhIGHxP6IyfcfZVNTdGFGZ9jsF8
 LPd0Lzfz7b9+QqcLnum5HTg4TawAAAA==
X-Change-ID: 20260826-stmmac_dma_unmap_tso-3d8cfa71c6b6
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hariprasad Kelam <hkelam@marvell.com>, Furong Xu <0x1207@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8ee444 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gCaaR3UEgWr7BH7gueUA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfXx+xLavQN0zRU
 1Jeud0fNYJ8xZwrQNw0aBkoVxXBC8MDZXrbMHmctlaTvDhhcXxzon68XRRwYVgnTZEhw3njVtKo
 ovcTDxeAM3taxZMjSwCzlBK6nFxl3sI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX+jXZkeao56Dl
 kr5prnikIvuq331HxGJGI8tL44KSSvkEf/jGqbPXZmSvjR178zZc5BVxS0OftiWXI3QU1mHtQUe
 lCDamb2Jp0X1laBfRQuwZRdDuT3a2rVgnRpyRBV60h2ggrYg6763NT+S9iYezLoq+VJx1CYFZkq
 d7dCYtkNO8ihLmA3RfqVjA2KZ3mf/sSLcEL2/7P10YzDmsdcvHk4UgsLYhDSos1plRk59gIQBoL
 IRWd2RATEK/GcqPTr7TzfP1aBjb3Hu2kceVAV7vABhFZL8DooPnbktJwPHhJjhS+J6N5JyzxLHN
 EGNs438qq7yD+TNNmOLUlWj3kGJBWCROztik3t9JS0IjkiraBlMmVtTi31uZwNahUhc/J/wHbWI
 jiDx8XUPAT1i7T2d/9dl3V6X8h1x1LRMvvKqhgPx2vTjlLHkO3Ct4X1/cHG+/btx4vQ1vd0qCBi
 LNQw33QHJ2iSAUoGGzw==
X-Proofpoint-ORIG-GUID: K7R7oW6xbU4Xwi63ClLItC8kJvk_WbK9
X-Proofpoint-GUID: K7R7oW6xbU4Xwi63ClLItC8kJvk_WbK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260108

In stmmac_tso_xmit(), if the DMA mapping of an skb fragment fails, the
frame is dropped but the DMA mappings already created for the linear
part and for the fragments mapped before the failure are never
unmapped, leaking DMA mappings.

Fix the leak by walking back over the descriptors used by the frame and
releasing each of them with stmmac_free_tx_buffer(). Moreover, release
the descriptors with stmmac_release_tx_desc() unmapping the DMA buffers.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 53 +++++++++++++++--------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa35cfecc4f..64d9356b6226 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4319,6 +4319,7 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 /**
  *  stmmac_tso_allocator - close entry point of the driver
  *  @priv: driver private structure
+ *  @entry: TX queue buffer index
  *  @des: buffer start address
  *  @total_len: total length to fill in descriptors
  *  @last_segment: condition for the last descriptor
@@ -4327,8 +4328,9 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
  *  This function fills descriptor and request new descriptors according to
  *  buffer length to fill
  */
-static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
-				 int total_len, bool last_segment, u32 queue)
+static void stmmac_tso_allocator(struct stmmac_priv *priv, u32 *entry,
+				 dma_addr_t des, int total_len,
+				 bool last_segment, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	struct dma_desc *desc;
@@ -4340,14 +4342,13 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 	while (tmp_len > 0) {
 		dma_addr_t curr_addr;
 
-		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
-						priv->dma_conf.dma_tx_size);
-		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
+		*entry = STMMAC_NEXT_ENTRY(*entry, priv->dma_conf.dma_tx_size);
+		WARN_ON(tx_q->tx_skbuff[*entry]);
 
 		if (tx_q->tbs & STMMAC_TBS_AVAIL)
-			desc = &tx_q->dma_entx[tx_q->cur_tx].basic;
+			desc = &tx_q->dma_entx[*entry].basic;
 		else
-			desc = &tx_q->dma_tx[tx_q->cur_tx];
+			desc = &tx_q->dma_tx[*entry];
 
 		curr_addr = des + (total_len - tmp_len);
 		stmmac_set_desc_addr(priv, desc, curr_addr);
@@ -4500,7 +4501,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	unsigned int first_entry, tx_packets;
+	unsigned int first_entry, entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	struct stmmac_tx_queue *tx_q;
 	bool set_ic, is_last_segment;
@@ -4563,22 +4564,24 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	first_entry = tx_q->cur_tx;
-	WARN_ON(tx_q->tx_skbuff[first_entry]);
+	entry = first_entry;
+
+	WARN_ON(tx_q->tx_skbuff[entry]);
 
 	if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		desc = &tx_q->dma_entx[first_entry].basic;
+		desc = &tx_q->dma_entx[entry].basic;
 	else
-		desc = &tx_q->dma_tx[first_entry];
+		desc = &tx_q->dma_tx[entry];
 	first = desc;
 
 	/* first descriptor: fill Headers on Buf1 */
 	des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
 			     DMA_TO_DEVICE);
 	if (dma_mapping_error(priv->device, des))
-		goto dma_map_err;
+		goto error;
 
 	stmmac_set_desc_addr(priv, first, des);
-	stmmac_tso_allocator(priv, des + proto_hdr_len, pay_len,
+	stmmac_tso_allocator(priv, &entry, des + proto_hdr_len, pay_len,
 			     (nfrags == 0), queue);
 
 	/* In case two or more DMA transmit descriptors are allocated for this
@@ -4593,8 +4596,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * this DMA buffer right after the DMA engine completely finishes the
 	 * full buffer transmission.
 	 */
-	stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des, skb_headlen(skb),
-				    false);
+	stmmac_set_tx_skb_dma_entry(tx_q, entry, des, skb_headlen(skb), false);
 
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
@@ -4604,14 +4606,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 				       skb_frag_size(frag),
 				       DMA_TO_DEVICE);
 		if (dma_mapping_error(priv->device, des))
-			goto dma_map_err;
+			goto error_dma_unmap;
 
-		stmmac_tso_allocator(priv, des, skb_frag_size(frag),
+		stmmac_tso_allocator(priv, &entry, des, skb_frag_size(frag),
 				     (i == nfrags - 1), queue);
 
-		stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des,
+		stmmac_set_tx_skb_dma_entry(tx_q, entry, des,
 					    skb_frag_size(frag), true);
 	}
+	tx_q->cur_tx = entry;
 
 	stmmac_set_tx_dma_last_segment(tx_q, tx_q->cur_tx);
 
@@ -4716,7 +4719,19 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	return NETDEV_TX_OK;
 
-dma_map_err:
+error_dma_unmap:
+	for (;;) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue,
+				      first_entry);
+		if (first_entry == entry)
+			break;
+
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
+	}
+error:
 	dev_err(priv->device, "Tx dma map failed\n");
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;

---
base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
change-id: 20260826-stmmac_dma_unmap_tso-3d8cfa71c6b6

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

