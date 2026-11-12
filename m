Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513064;
	b=McTreLaHvZpbO6+fB79UqJ4YEl3aQLGXbgsdW1TQRJGqJvuK1H9kqGHE6cJxE+jop7z+
	 c0jShdYBwOPJUP4QIqV58c/YLEKdV74PkAwrpdR22LcdtVCydPRlnJhDl7SPjbBiDdtDt
	 L+1Pg7lzSTKfz0UI/z1ivnu/smAT1r9G7OegXoujVqJKoLobIU65phSuAUOGn4BbK6Ytm
	 4NU1l/gkRdH9hs1URILXolMNuEDk+mw3KK3OGwNNPuHHx1DhjyCc/u2SQmL0fWOhhUtF0
	 lU9jqRCOTxnUvi+HFmmJAHYt7sGe7XZgk6RJS/jq5p0qkI1xd7J86ppPURvdZP+DIsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gyig1chHMnnzbW45ArCSOBvIzbw2ho2ewGO+sy3D/+Y=;
	b=OCvuauN1ITX+S+bomywlgsryytxOrvIIku7CJ/2a+LndPRTAhwlMiDrfiPdpX9ZswBNE
	 SjLQAy4hsTTaRMxMFGdIFuH775+WZF0jLH/glBFsz9WmiIZBXcK3DS0/6i/F6J3/2yTHh
	 7pQpTOi4tviDOwTx0SFQ8ul8xip6evRlDt2orsm6pEIpjrkh+gzxVTGDfO2A/axPh+h9Y
	 d+wqz391JVFXfhqZONSk+3YPpAN9/2TbIp1VxxdFMP1xKdw6ZCiw5Jl5g6pqp9KgAj/bk
	 2U+BZlisWuMN0YIsXslhs0runjAR+z5JKmMD4VoVCGQqAbA87CJoXXEEChZ0T/oe1Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="G/241nnC";
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A60606A881
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A60606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G/241nnC
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50933bdf4bso10035466b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513062; x=1795117862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gyig1chHMnnzbW45ArCSOBvIzbw2ho2ewGO+sy3D/+Y=;
        b=G/241nnCMOpCBUM8WimR6WUXV8u5qBIGRbDjiPYDvnkyuZtH2JYVmJf0d0A1dknVhy
         sb8t5V+creTKTSsMLxj4SCdtCrruFgrsbbyy/c1XsihTdzlv9J12dqrZuqfPRRCGw6kQ
         KPLBW14sS4Ra0wl84PI2TG9s4PIT/9j2VZ1MGZBDyMBKVebd5jQ+JbIaXW7FeU5gBn0w
         g9ppLH+CdCXSSPF2nDv2czpgVrc/xMy0ARrUIMPxMahFOe8dT48kCgiKrIqk0uihWGa5
         upE7Ew0GrvC44/ukzmxjxvi+8pUoRcr1s870qyvxHkkQIniLfTb6h/ODWVivFBAkYJ+r
         BsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513062; x=1795117862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gyig1chHMnnzbW45ArCSOBvIzbw2ho2ewGO+sy3D/+Y=;
        b=0RUaIWHftugJlDNsEUwV85yUnea7rpr2HtNPRXL6tMMLZblpYaff6USzCxrl4yDwoS
         q4BSrXGksqXQT+kTyD3jeniX8sBTYc6+2RSPYHB2kgIvk9zWFaSeeDVIpC/xClVjNL25
         n/w0FpzDFGQfNruQpygNslgbVCWdZ7JJzGL9rzSo7UrlosbSYh1zwT8L6QRNcJvAMrwe
         35pJPJUCwlOyj+RKaoLv2FQ9HSmuf1V9roZoqboI+kfiSwMdyz+M3p1UEeZbooaXiime
         Wy0v/K4rxiUFZWnF7TkmdjYgtgmImYL43AV8kp3ldqTgamZMCeGS3xusbUk4mnTihDfr
         Ew2g==
X-Gm-Message-State: APuU4Z+9MYgC4/aSh9ImaKnlCQ/BTUr6b75zfpCdTZitS5gjdstIz0Xu
	K6QpWVCB/KIhjHDQSqmuTRI91dgjWmlvbGwNe0RrF6DcQA7A1gyWBoHx20yTYhp0
X-Gm-Gg: AYBFou00QP2j7+RhJcNrN9eM5mD23jVINySmG1VXJkcerAuDWSaD7sP6ZS89Y3X4nRp
	/ZStP/CnZb90G9USwPbpRFSemT5uz46TWvDTfO2i9OOY8EguqDMZuJOKOIzHms05/anfoCoMj15
	6WKJm6kxWYgiGadnINI6s4Wh1bwEsMLqpNmWM939EBayYepVPSxjdjRQaEN24b20SsN8BDLT6il
	kreeQKdOQxeSHoqZizXGfEjSUyMGcMcccCPVRBr8aC604hnZzlwhjFhkyUW+wPIhlSzk92nSKg5
	HX4hXMEa8oqrOjjKXySxtuIYNT7YEa9H7XEGl2iFmSiobDoacIIJ06QQB/hmMVHNB7Lt+eHjkgz
	yhBND/6B5914TZ8Au6xMBwuggzx8ePqV6MW/kZR7eGKULkVF241CyijagiuVUrlou0QtkuW9XMi
	rf5Ejh3QKsLXMC0JPst31wrS7nhGxoM2KGvDB8v7kaJCA2AcXzGaNITxwkBvB7s4V1+1USSgYwO
	4ORDUvr8honnbtjt6dhfbiEhVJ5uNtMtt2bmKQI2rJf5XCnO1PuC26BxByZmingd2YN7F9UT4i9
	xzEPxUOoCFBC53oxx5IyM4FTsJ9+wit0etHT51v5eU+PtPZkOomsVyFT6BfBqg==
X-Received: by 2002:a17:907:9606:b0:c2e:62af:b6fe with SMTP id a640c23a62f3a-c5096317218mr27319966b.8.1794513062485;
        Thu, 12 Nov 2026 11:51:02 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:02 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/6] net: bcm4908_enet: drop a TX frame whose DMA mapping failed
Date: Thu, 12 Nov 2026 20:50:47 +0100
Message-ID: <20261112195051.597102-3-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112195051.597102-1-kudzo51@gmail.com>
References: <20261112195051.597102-1-kudzo51@gmail.com>
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

When dma_map_single() fails, start_xmit() returns NETDEV_TX_BUSY with
the queue still running, after it has already stored the skb in the
slot. Documentation/networking/driver.rst treats NETDEV_TX_BUSY under
normal circumstances as a hard error, and a driver that returns it must
not keep any reference to the skb. Here the stack requeues the frame
and retries it while the slot still points at it. Drop the frame
instead: free the skb, count it as dropped and return NETDEV_TX_OK.
Map the buffer before the slot is touched.

Found by reading the code.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 60f711e8c..b1738d954 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -537,6 +537,7 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	struct bcm4908_enet_dma_ring_slot *slot;
 	struct device *dev = enet->dev;
 	struct bcm4908_enet_dma_ring_bd *buf_desc;
+	dma_addr_t dma_addr;
 	u32 tmp;
 
 	/* Free transmitted skbs */
@@ -555,12 +556,17 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
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

