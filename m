Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268632;
	b=IDnaPwu3ImllxMhfKpkWPwHj00v5wCx8EamGgtNCtYtltDVRNQgGzWWeRMtMCsGWmEAJ
	 T9QtPoLwTdCYtDE5C7vQUBtX9wrnscXjthDhU2icK9gwsvw9yevHtrG3EUjcUQRE6mXEH
	 ism+JeLj6bXOOKMFfafeon9A4D8Pt1/ND32uWiQ3inauT22ZQ9YZ/nl2ygcm55JmDU7Zb
	 buQNLj66HSpgn7kfRcGMFFkfcEbvhahGZZwpWpCA7MN0H6ygZoSmGfuOgu02rfkPEDDw1
	 /Tex3Kj6MRrA+O95woyUiwF6RVc18yr007eHgqZBPsvPpecLPGQczL9DSByyKZurLAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2HfnaBPYg3WKFac5pdvEXkz4OF4nU+7Wrx4suqm86rk=;
	b=M8P2MkqMRpkO3Plb5IHCssbd4YKfjT4ncSuWzfcLV3bqxaP4PvEFkgnHp8Z9wnyFqUve
	 WyGbhD/a7UFxTfi3Zb9FP7J0qmYeoFQulPD2MnvOos9eVBMbUdQR8x2sf1wnLPRVfHNFs
	 ysFq8gYFc31Pr7NCPboBlBSCNpCvPijAKkfAXUizqSWcWVCERmla6/RSB11rPLyHb5LkJ
	 5eOykX3WQr298tRJmb+O4MhRgsWMjYBuc4e1kKKkLWODq68yAoRy9A81OY8rO6gj2cbb2
	 Cs8mJ60OOfLQ8eREM+uIpVczVZriePjDJXps13f2R4JRpvIdUASWLrUXRPOeMQdosVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+7GOkCI;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C160A260D
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E7C160A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+7GOkCI
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso213949366b.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268630; x=1794873430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HfnaBPYg3WKFac5pdvEXkz4OF4nU+7Wrx4suqm86rk=;
        b=H+7GOkCIJN/d3/JlCCHY7oHITgnmXbKTixiafwogxUc/5Unn4kppA5F2fcv5GRHqg+
         5SsQoRbtS9NZrFsSbyCbTpVbqqArTMKFwexo+Fcw7B0gBCGfJE2RLGNDljUeAhw0taAE
         GzCh3I5sVczomsokWVbhM7XJl2qcV8a2UHoHf8AWdmKcPvczKILRDqaV961VX4bFB/EG
         8Zo2258hiiyrILdsHVY2yBmeIHxR9YEgNJZmuv/KwHBhTnB9rA+P50CjoIYSUUCj8TJU
         nd2QIJ6nvcunD0AajWGg4MaioY+AOZUIUqYUhgN/eeBJYxzxl8f4eOFqCe1OEG1kcQtv
         rh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268630; x=1794873430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HfnaBPYg3WKFac5pdvEXkz4OF4nU+7Wrx4suqm86rk=;
        b=lCfZaOzpGR246BEN60b72eAZfXcnl+263rmOHy/qcVKzwkqsUmSazhI4f9C3FQLI06
         BsS6VoRO4YRuXBMYGXW7LLBd9FsBaVbjNPat6oIsXVnB9p7c9Mtk0k9IF6nKlnxOzrt4
         r6vsXPudowRokgfkP8emCoTGCYMy10XigOB2Je3f858Ni0kCxEjBDkplZTZ5lDYtAmPk
         7ZicblgFNISf6RKyvUTJzFVhMD5EkY7Gr7Hb1FgyZyP/yqGd20xcZMTdfyTyaOQOvJaZ
         BYWzBUHoMLN1S5bFzT8t0HnCkDcqO1e4eDM+RQexhf/JGce3GmWR+AhaooqqCWqpDbtj
         y19g==
X-Gm-Message-State: APuU4Z/sUNJwZzPsJIlr83iNVxhhvcD3ur1hEvju4xYtYjpiYPSFIWCR
	lrnjY5BE+PBklrD8djS4HKPIphrCqXs0O/cOS9kAskgR3r7pZyI7UueWiLVT2TPx
X-Gm-Gg: AYBFou3h++MpP6bT81CcQhXtsrbbfySenk4VeZgyNJFDsL65B+JnJ2ni/H9/Wq7pUj9
	0VGicMj+s9YfmbAH+8+ibhpmT7ZrdhyCqsOzapYZrdz9egvn7povwR+bCLeOmlGqDrziMYGhoFc
	Xsf2O1IaEQgrslXiCZqFQQCefd6Ny6trkCqybHx6bgs5LHvRhNgnnB72Tcw7T44iYsyD4yVq0K/
	VJgThWzYSVbaGkRDLelre+mF8unFIaP3Audd/H9r7yjoor2v/urZJIW8NAOwWbaIsmmmo5/KOMR
	YYNbr/jEbQHO5cwSNdRmMPP5N0ainrIFu5aHl2O7KWCrgC+jE6huVzZBCRXNAbPO8Zq7fVU4Z2I
	xoxJ6aklLmGRJeGuRPYIVgf2pvQY8fVfpl7j3NeyiOgmBmt2dxZsOxT85mb9crikucUl0C3i9jz
	NxwPoZPYslqz+/p0gYw9M2PH02ZYw3t/17X1KE0RNjmapTSLuW2YSVm5MZJSg+z7ZtVcUY++dz+
	BU62YuVqtDv5KYrDpJeFNv95bQ+Hj2QPFv6JqncAYJcy1LRAFjb62Q9GC2gOhvoMDr65hBYHv2U
	3A1vO64IYQnlzGuXVNFfvfx0TfgRWywtsfnKMfgusTsKG2o741NgPe8=
X-Received: by 2002:a17:907:a88d:b0:c50:4a71:cb5 with SMTP id a640c23a62f3a-c504a710e76mr57150966b.15.1794268630492;
        Mon, 09 Nov 2026 15:57:10 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:10 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/7] net: bcm4908_enet: drop a TX frame whose DMA mapping failed
Date: Tue, 10 Nov 2026 00:56:55 +0100
Message-ID: <20261109235700.2586821-3-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109235700.2586821-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
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

When dma_map_single() fails, start_xmit() returns NETDEV_TX_BUSY after
it has already stored the skb in the slot. The stack requeues the same
frame and retries it at once, and the skb is left in a slot that never
gets a descriptor. A failed mapping is not something a retry fixes:
free the skb, count it as dropped and return NETDEV_TX_OK. Map the
buffer before the slot is touched.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 01a3e1d01..727ad1e96 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -535,6 +535,7 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	struct bcm4908_enet_dma_ring_slot *slot;
 	struct device *dev = enet->dev;
 	struct bcm4908_enet_dma_ring_bd *buf_desc;
+	dma_addr_t dma_addr;
 	u32 tmp;
 
 	/* Free transmitted skbs */
@@ -554,12 +555,17 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 		return NETDEV_TX_BUSY;
 	}
 
+	dma_addr = dma_map_single(dev, skb->data, skb->len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, dma_addr))) {
+		dev_kfree_skb_any(skb);
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
 	slot = &ring->slots[ring->write_idx];
 	slot->skb = skb;
 	slot->len = skb->len;
-	slot->dma_addr = dma_map_single(dev, skb->data, skb->len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, slot->dma_addr)))
-		return NETDEV_TX_BUSY;
+	slot->dma_addr = dma_addr;
 
 	tmp = skb->len << DMA_CTL_LEN_DESC_BUFLENGTH_SHIFT;
 	tmp |= DMA_CTL_STATUS_OWN;
-- 
2.56.0

