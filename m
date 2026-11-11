Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434496;
	b=vls82xz3mwEp7kTR6aW8YDu7y7R9Ixbq0pnk+gXOpvfdEhOhO+41ZjKOJZvXwcsny9Jw
	 /uq8Xm+DDXeHrbf/oNLD/RMDwiQZ+neCcAmS0nv4Iv4O+EX4pHiJa8Zuq49XySqH6SH3f
	 0jhtRlMmgQZJP/dpMCNGSQmsqgSn5F/ptsN3reRqvftK5X1G+txgAHhnaNm/H/aagRqlk
	 xWozrmxkDX/YCGrabMA3m9aOo9C0WCz7GaoxmC2jZ5BlVzTDtEsaet9MUy25wy69L6EVZ
	 uEvjGiO6s3n9DKhSOZdmOieZpHiRIvHCiAjSkdUAsHxMBhDAdo+IxrPP21doqiN8njw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JSIAzpXnSdisZ+wf/icgEJDDLXAEGjiCSiJJgkCBhpM=;
	b=eNTs9wE9fPYhXsqL5JoPzOmHf5I9ld7b8h0ojEda80AyGDnsSK3HfDXL/kEBWmv0oyLy
	 SSta494wM2Odpi26tAQANpW9va2S6SdkqSidqgRTeKbuFiruJ9s6hWr9SkH8pSVjEESN1
	 IwXskYlJmp7WKWAFpXHpIz8WoJ+laiFRmghJDD1J82Qo/W+V2m6y8N5EjHNe2yKVMpdc5
	 LurrQ13PO2+kTdj8ngPw+bsz7mauTJgZnhzQAP2DIRp27I9zd+9RDaReJ9lSe4TU5Op6Y
	 FAgCwXTDHUU4rttTpejgZL2w/ycNNwKiZT1IypobgUBJfQdKQiA6vsS+40W258TnhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIQgOtgl;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81E606A88F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F81E606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIQgOtgl
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so2421592e0c.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434495; x=1795039295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSIAzpXnSdisZ+wf/icgEJDDLXAEGjiCSiJJgkCBhpM=;
        b=MIQgOtgl0vOXZcLS+Pw9trXj0U9ZoWMmP4kYK2eOorx2DLByexEHr2PHrkKX8YxRJ0
         bOMc8PO2pZmQMLGAVgjWzsCGV+bpmSd7Rl5itPybghf+W9WEdKYPr0Se1IjnNOr51JL9
         INoTMI4GZd2dWpuGQnXQf8bIlj4kt++DdMUS2cMFtznO5o3nd/ymK/sOjg3xI38d5Bx6
         eVbYKoMqjAZxIiIfMjVdMqmdSBHylXrj29W9pY5ceg+YSfL+zboDTVG3mlg+lp8hweNz
         CJkiRaewjHA2Qwzx+x17pteM51mSEnEsXwsFs2jw9yI5vL+g/lzqW8ZSQZ5+LDTrwSjy
         DViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434495; x=1795039295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSIAzpXnSdisZ+wf/icgEJDDLXAEGjiCSiJJgkCBhpM=;
        b=fN4iZVi/1CRYciWHTGa3uKi2r10s+zkE3DjZm6bbbq/EvoDutN344zPlviI7EOy6Gf
         dbzWNNDep8jjxxZEuNsbc67xHAScz24AIEFvXFjC1yeFYnIcnNJ3A2UZSe8frc4RGZBl
         bebbV/YzBAYj/PAIwtGhKnJ5yY3XVJZU5yWKwYbPXX9TfyfYuZ5Ruq6/qX29Vn4DIKkb
         so8t2FrSopqhTjNub36stpJnbID/qkNMkueaHe/bb6pxe+DEl7LvqWlWZU25c2cdsxxH
         IV9vuNsp02nBLenVFHLvmzzE8si0WuZ5GsyX+xXJ29DhGswy9wJSe1zBr78LhiGsp3Fn
         pKVA==
X-Gm-Message-State: APuU4Z94hiXDvg+X0BHRd91AoyqoHnTk7c1T2RJ96Uy4JRDPc+/uMFtE
	0Rlo43yLhuwhY8xIW4E4bniMk8XA+wpc/U8aljBwjv8Cp89/yIIGo8oeWEvbA//A0Z7b
X-Gm-Gg: AYBFou1ek8CDTSEK+mY7sXKL9yXvkwlukLVNjevYxs9nV3qHKmBqC1loMmmzV1NvSx0
	L4FRNGknUUuOK7DdjXOo55tPlD3iCKYRQDfQxZGetpoXARWpcht6Mh2wGXQvcGFezUitVEx2AyL
	VgAe/7bm8Lw+HD4sISbGudOBCtfdi3i2kIMwBprHhPbbOqzfkq/q1i7V+zru0pnHk7TwjhWAp3/
	Vqo2z8QtA/CJ9jTqSw6Oh00zRyO1n5qi5aWtUI+KO8fQjfXVNuQqs7haerLhBqDUpz7pp3Dvewr
	YI5li56OmllXPmlr4ChlYGMYCFd4cyGGSGRXHIZVSpAb4SrfCb18AH+AzPHYgqPeGnhNJR0bBMo
	7ETehd5FX8V4sqKB6W2jzmK/2ywkyvwzfafI8bqgYgSaqMpcNfShWp0vDPl47yvMGsgSt1CbFTd
	zBgprTP0bfFHJ6nCWKK0G03aJUdaV3tg+KHK6SEFiVIpvWkxUpZKIm7oI2Fkv6LMwT4t7979qi0
	lEXu4zZo96Qo6sTdk4yKjDRUmrwGkdzyxBZUOgl3ktzHv559WA+ybTZ04UTViP/rT0fBeBqBGVH
	N/KuI1sDneeULsnWYxrrmLph/S/8
X-Received: by 2002:a05:6122:4683:b0:5ec:c186:d22b with SMTP id 71dfb90a1353d-5ee1c49c9a5mr1620587e0c.22.1794434495089;
        Wed, 11 Nov 2026 14:01:35 -0800 (PST)
Received: from Ixchel.lan ([70.49.63.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm4557992241.4.2026.11.11.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:34 -0800 (PST)
From: Vlad Banea <montrealtango@gmail.com>
To: netdev@vger.kernel.org
Cc: hkallweit1@gmail.com,
	javen_xu@realsil.com.cn,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 4/5] r8169: add the type 3 RX descriptor
Date: Wed, 11 Nov 2026 17:01:13 -0500
Message-ID: <20261111220114.3863505-5-montrealtango@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220114.3863505-1-montrealtango@gmail.com>
References: <20261111220114.3863505-1-montrealtango@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTL8125A/B family has a 32-byte RX descriptor ("type 3" in Realtek's
driver), which the RTL8125B requires with RSS. Its second half is laid
out like RX_DESC_TYPE_RSS, so add RX_DESC_TYPE_V3 as a 16-byte header
followed by a struct RxDesc and reuse the RSS accessors.

Differences from RX_DESC_TYPE_RSS:
 - FirstFrag/LastFrag at bits 25/24 and RES/RUNT/RWT/CRC at 20-17 of
   opts1;
 - one checksum flag per protocol in opts2, and only the matching
   protocol's failure flag is valid;
 - the RSS hash in rss_result, its type in hdr_info;
 - selected by RxConfig bit 24, set before the receiver is enabled.

No chip uses it yet.

Signed-off-by: Vlad Banea <montrealtango@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 158 +++++++++++++++++++---
 1 file changed, 136 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cc253728109c..85e2c03fa61d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -75,7 +75,6 @@
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
 #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
@@ -492,6 +491,26 @@ enum rtl8125_registers {
 #define RX_VLAN_INNER_8125	BIT(22)
 #define RX_VLAN_OUTER_8125	BIT(23)
 #define RX_VLAN_8125		(RX_VLAN_INNER_8125 | RX_VLAN_OUTER_8125)
+#define RX_DESC_V3_8125		BIT(24)	/* type 3 (32-byte) RX descriptors */
+
+/* RX_DESC_TYPE_V3 status bits, opts1 unless noted */
+#define RX_FIRST_FRAG_V3	BIT(25)
+#define RX_LAST_FRAG_V3		BIT(24)
+#define RX_RES_V3		BIT(20)
+#define RX_RUNT_V3		BIT(19)
+#define RX_RWT_V3		BIT(18)
+#define RX_CRC_V3		BIT(17)
+#define RX_UDPT_V3		BIT(29)	/* opts2: UDP packet */
+#define RX_TCPT_V3		BIT(28)	/* opts2: TCP packet */
+#define RX_IPF_V3		BIT(26)	/* opts2: IP checksum failed */
+#define RX_UDPF_V3		BIT(25)	/* opts2: UDP checksum failed */
+#define RX_TCPF_V3		BIT(24)	/* opts2: TCP checksum failed */
+#define RXS_RSS_UDP_V3		BIT(9)	/* hdr_info */
+#define RXS_RSS_IPV4_V3		BIT(10)
+#define RXS_RSS_IPV6_V3		BIT(12)
+#define RXS_RSS_TCP_V3		BIT(13)
+#define RXS_RSS_L3_V3		(RXS_RSS_IPV4_V3 | RXS_RSS_IPV6_V3)
+#define RXS_RSS_L4_V3		(RXS_RSS_TCP_V3 | RXS_RSS_UDP_V3)
 
 #define RX_FETCH_DFLT_8125	(8 << 27)
 
@@ -740,6 +759,19 @@ struct RxDesc {
 	};
 };
 
+/* 32-byte RX descriptor of the RTL8125A/B family ("type 3") */
+struct RxDescV3 {
+	__le32 rsv1;
+	__le32 rsv2;
+	__le32 rss_result;
+	__le16 hdr_buf_len;
+	__le16 hdr_info;
+	struct RxDesc desc;
+};
+
+static_assert(sizeof(struct RxDesc) == 16);
+static_assert(sizeof(struct RxDescV3) == 32);
+
 struct ring_info {
 	struct sk_buff	*skb;
 	u32		len;
@@ -812,6 +844,7 @@ enum rtl_dash_type {
 enum rx_desc_type {
 	RX_DESC_TYPE_DEFAULT,
 	RX_DESC_TYPE_RSS,
+	RX_DESC_TYPE_V3,	/* 32-byte struct RxDescV3 */
 };
 
 struct rtl8169_rx_ring {
@@ -2112,6 +2145,7 @@ static void rtl8169_rx_vlan_tag(struct rtl8169_private *tp,
 
 	switch (tp->init_rx_desc_type) {
 	case RX_DESC_TYPE_RSS:
+	case RX_DESC_TYPE_V3:
 		opts2 = le32_to_cpu(desc->rss_opts2);
 		break;
 	default:
@@ -2817,7 +2851,9 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 		break;
 	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_LAST:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
-			RX_PAUSE_SLOT_ON);
+			RX_PAUSE_SLOT_ON |
+			(tp->init_rx_desc_type == RX_DESC_TYPE_V3 ?
+			 RX_DESC_V3_8125 : 0));
 		break;
 	default:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
@@ -2825,12 +2861,36 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+/* RX_DESC_TYPE_RSS and RX_DESC_TYPE_V3 share the address/opts2/opts1 order */
+static bool rtl8169_rx_desc_rss_layout(struct rtl8169_private *tp)
+{
+	return tp->init_rx_desc_type != RX_DESC_TYPE_DEFAULT;
+}
+
+static size_t rtl8169_rx_ring_bytes(struct rtl8169_private *tp)
+{
+	if (tp->init_rx_desc_type == RX_DESC_TYPE_V3)
+		return NUM_RX_DESC * sizeof(struct RxDescV3);
+
+	return NUM_RX_DESC * sizeof(struct RxDesc);
+}
+
+static struct RxDesc *rtl8169_rx_desc(struct rtl8169_private *tp,
+				      struct rtl8169_rx_ring *ring,
+				      unsigned int index)
+{
+	if (tp->init_rx_desc_type == RX_DESC_TYPE_V3)
+		return &((struct RxDescV3 *)ring->rx_desc_array)[index].desc;
+
+	return &ring->rx_desc_array[index];
+}
+
 static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
 {
 	for (int i = 0; i < tp->num_rx_rings; i++) {
 		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
-		memset(ring->rx_desc_array, 0x0, R8169_RX_RING_BYTES);
+		memset(ring->rx_desc_array, 0x0, rtl8169_rx_ring_bytes(tp));
 	}
 }
 
@@ -4533,6 +4593,9 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
 	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
 	rtl_pci_commit(tp);
 
+	/* Select the 32-byte descriptor before the receiver is enabled */
+	if (tp->init_rx_desc_type == RX_DESC_TYPE_V3)
+		rtl_init_rxcfg(tp);
 	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
 	rtl_init_rxcfg(tp);
 	rtl_set_tx_config_registers(tp);
@@ -4570,6 +4633,7 @@ static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc
 
 	switch (tp->init_rx_desc_type) {
 	case RX_DESC_TYPE_RSS:
+	case RX_DESC_TYPE_V3:
 		eor = le32_to_cpu(desc->rss_opts1) & RingEnd;
 		desc->rss_opts2 = cpu_to_le32(0);
 		/* Force memory writes to complete before releasing descriptor */
@@ -4589,7 +4653,7 @@ static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 					  struct rtl8169_rx_ring *ring, unsigned int index)
 {
-	struct RxDesc *desc = ring->rx_desc_array + index;
+	struct RxDesc *desc = rtl8169_rx_desc(tp, ring, index);
 	struct device *d = tp_to_dev(tp);
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
@@ -4607,7 +4671,7 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	ring->rx_buf_dma_addr[index] = mapping;
-	if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
+	if (rtl8169_rx_desc_rss_layout(tp))
 		desc->rss_addr = cpu_to_le64(mapping);
 	else
 		desc->addr = cpu_to_le64(mapping);
@@ -4619,6 +4683,7 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 static void rtl8169_rx_clear(struct rtl8169_private *tp,
 			     struct rtl8169_rx_ring *ring)
 {
+	struct RxDesc *desc;
 	int i;
 
 	for (i = 0; i < NUM_RX_DESC && ring->rx_databuff[i]; i++) {
@@ -4628,12 +4693,13 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp,
 		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
 		ring->rx_databuff[i] = NULL;
 		ring->rx_buf_dma_addr[i] = 0;
-		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS) {
-			ring->rx_desc_array[i].rss_addr = 0;
-			ring->rx_desc_array[i].rss_opts1 = 0;
+		desc = rtl8169_rx_desc(tp, ring, i);
+		if (rtl8169_rx_desc_rss_layout(tp)) {
+			desc->rss_addr = 0;
+			desc->rss_opts1 = 0;
 		} else {
-			ring->rx_desc_array[i].addr = 0;
-			ring->rx_desc_array[i].opts1 = 0;
+			desc->addr = 0;
+			desc->opts1 = 0;
 		}
 	}
 }
@@ -4642,6 +4708,7 @@ static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct R
 {
 	switch (tp->init_rx_desc_type) {
 	case RX_DESC_TYPE_RSS:
+	case RX_DESC_TYPE_V3:
 		desc->rss_opts1 |= cpu_to_le32(RingEnd);
 		break;
 	default:
@@ -4666,7 +4733,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
 	}
 
 	/* mark as last descriptor in the ring */
-	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
+	rtl8169_mark_as_last_descriptor(tp, rtl8169_rx_desc(tp, ring, NUM_RX_DESC - 1));
 
 	return 0;
 }
@@ -4679,7 +4746,7 @@ static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
 	for (int i = 0; i < tp->num_rx_rings; i++) {
 		ring = &tp->rx_ring[i];
 		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
-							 R8169_RX_RING_BYTES,
+							 rtl8169_rx_ring_bytes(tp),
 							 &ring->rx_phy_addr,
 							 GFP_KERNEL);
 		if (!ring->rx_desc_array)
@@ -4697,7 +4764,7 @@ static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
 		ring = &tp->rx_ring[i];
 		if (ring->rx_desc_array) {
 			dma_free_coherent(&pdev->dev,
-					  R8169_RX_RING_BYTES,
+					  rtl8169_rx_ring_bytes(tp),
 					  ring->rx_desc_array,
 					  ring->rx_phy_addr);
 			ring->rx_desc_array = NULL;
@@ -4832,11 +4899,12 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
 		for (int j = 0; j < NUM_RX_DESC; j++) {
+			struct RxDesc *desc = rtl8169_rx_desc(tp, ring, j);
 			dma_addr_t phy_addr = ring->rx_buf_dma_addr[j];
 
-			if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
-				ring->rx_desc_array[j].rss_addr = cpu_to_le64(phy_addr);
-			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
+			if (rtl8169_rx_desc_rss_layout(tp))
+				desc->rss_addr = cpu_to_le64(phy_addr);
+			rtl8169_mark_to_asic(tp, desc);
 		}
 	}
 }
@@ -5300,9 +5368,13 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 	}
 }
 
-static inline int rtl8169_fragmented_frame(u32 status)
+static inline int rtl8169_fragmented_frame(struct rtl8169_private *tp,
+					   u32 status)
 {
-	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
+	u32 frags = tp->init_rx_desc_type == RX_DESC_TYPE_V3 ?
+		    RX_FIRST_FRAG_V3 | RX_LAST_FRAG_V3 : FirstFrag | LastFrag;
+
+	return (status & frags) != frags;
 }
 
 static void rtl8169_rx_hash(struct rtl8169_private *tp,
@@ -5315,6 +5387,20 @@ static void rtl8169_rx_hash(struct rtl8169_private *tp,
 	if (!(tp->dev->features & NETIF_F_RXHASH))
 		return;
 
+	if (tp->init_rx_desc_type == RX_DESC_TYPE_V3) {
+		const struct RxDescV3 *v3 = container_of(desc, struct RxDescV3,
+							 desc);
+
+		rss_header_info = le16_to_cpu(v3->hdr_info);
+		if (!(rss_header_info & RXS_RSS_L3_V3))
+			return;
+
+		skb_set_hash(skb, le32_to_cpu(v3->rss_result),
+			     (rss_header_info & RXS_RSS_L4_V3) ?
+			     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
+		return;
+	}
+
 	rss_header_info = le32_to_cpu(desc->rss_dword.rss_info);
 
 	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
@@ -5329,11 +5415,23 @@ static void rtl8169_rx_hash(struct rtl8169_private *tp,
 
 static void rtl8169_rx_csum(struct rtl8169_private *tp,
 			    struct sk_buff *skb,
+			    struct RxDesc *desc,
 			    u32 opts1)
 {
 	bool csum_ok = false;
+	u32 opts2;
 
 	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_V3:
+		/* The chip also sets the failure flag of the other
+		 * protocol (a TCP frame carries UDPF); check only the
+		 * matching one.
+		 */
+		opts2 = le32_to_cpu(desc->rss_opts2);
+		if (((opts2 & RX_TCPT_V3) && !(opts2 & (RX_TCPF_V3 | RX_IPF_V3))) ||
+		    ((opts2 & RX_UDPT_V3) && !(opts2 & (RX_UDPF_V3 | RX_IPF_V3))))
+			csum_ok = true;
+		break;
 	case RX_DESC_TYPE_RSS:
 		if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
 		    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
@@ -5358,6 +5456,7 @@ static __le32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *d
 {
 	switch (tp->init_rx_desc_type) {
 	case RX_DESC_TYPE_RSS:
+	case RX_DESC_TYPE_V3:
 		return READ_ONCE(desc->rss_opts1);
 	default:
 		return READ_ONCE(desc->opts1);
@@ -5369,6 +5468,17 @@ static bool rtl8169_check_rx_desc_error(struct rtl8169_rx_ring *ring,
 					u32 status)
 {
 	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_V3:
+		if (unlikely(status & RX_RES_V3)) {
+			u64_stats_update_begin(&ring->stats.syncp);
+			if (status & (RX_RWT_V3 | RX_RUNT_V3))
+				ring->stats.rx_length_errors++;
+			if (status & RX_CRC_V3)
+				ring->stats.rx_crc_errors++;
+			u64_stats_update_end(&ring->stats.syncp);
+			return true;
+		}
+		break;
 	case RX_DESC_TYPE_RSS:
 		if (unlikely(status & RX_RES_RSS)) {
 			u64_stats_update_begin(&ring->stats.syncp);
@@ -5407,7 +5517,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 
 	for (count = 0; count < budget; count++, ring->cur_rx++) {
 		unsigned int pkt_size, entry = ring->cur_rx % NUM_RX_DESC;
-		struct RxDesc *desc = ring->rx_desc_array + entry;
+		struct RxDesc *desc = rtl8169_rx_desc(tp, ring, entry);
 		struct sk_buff *skb;
 		const void *rx_buf;
 		dma_addr_t addr;
@@ -5437,6 +5547,10 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 			if (tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT) {
 				if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
 					goto release_descriptor;
+			} else if (tp->init_rx_desc_type == RX_DESC_TYPE_V3) {
+				if (status & RX_RWT_V3 ||
+				    !(status & (RX_RUNT_V3 | RX_CRC_V3)))
+					goto release_descriptor;
 			} else {
 				if (!(status & (RXRUNT_RSS | RXCRC_RSS)))
 					goto release_descriptor;
@@ -5454,7 +5568,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		/* The driver does not support incoming fragmented frames.
 		 * They are seen as a symptom of over-mtu sized frames.
 		 */
-		if (unlikely(rtl8169_fragmented_frame(status))) {
+		if (unlikely(rtl8169_fragmented_frame(tp, status))) {
 			u64_stats_update_begin(&ring->stats.syncp);
 			ring->stats.rx_dropped++;
 			ring->stats.rx_length_errors++;
@@ -5484,7 +5598,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 			rtl8169_rx_hash(tp, desc, skb);
 			skb_record_rx_queue(skb, ring - tp->rx_ring);
 		}
-		rtl8169_rx_csum(tp, skb, status);
+		rtl8169_rx_csum(tp, skb, desc, status);
 		skb->protocol = eth_type_trans(skb, dev);
 
 		rtl8169_rx_vlan_tag(tp, desc, skb);
@@ -5499,7 +5613,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
+		if (rtl8169_rx_desc_rss_layout(tp))
 			desc->rss_addr = cpu_to_le64(ring->rx_buf_dma_addr[entry]);
 		rtl8169_mark_to_asic(tp, desc);
 	}
-- 
2.53.0

