Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614346;
	b=mARwPTq200pkXixrX8A2jMsosO7mqq5rRhSwTldHciDMBjzwpcKjjRdxrJ1H0mYRHTpL
	 WCa1QBZFPNgNzSIQL9wRbQd2UlS92a6gAozQMkEsEAgzjypXrvrgtl5oIvvPoL21ikoSZ
	 wb97J7m0zoQncv9EsnEMYIJif1Jkt0n6fbTcodgpmq4wOYpa2qUpQgzqn7b+lsl7UX1Jz
	 Ia5JCt+dh9Hud2XvguF9uRi39MGo/THp/QnkQQRUfd16kOluBBieKlGoa7U4F4XU9LNB4
	 iyZzQd9OxagJtHyZmUUVOQLEMqOEtT37J7ReIreUgCaZV52axNOiYtHzgMp8f5tXT3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CIJ9lTxFK2rYD9M28Y9MMRCwwxN4Oxtl/6GVumckvVQ=;
	b=VznL6FwS9cb5ztvsR8ry9X0dk0EHgYz8QByBIliVZJd2P/0oFvLpEmGVtQsopj43MCNi
	 kN4ntUZRCYprvhA0sv2fl4k7IgOvxae0etbwuxbkxh6i/SUEdDrQIFAIzh3mEGq32RQGZ
	 YtB/Ii6+TN+JCJrvlfRToI4v8LNlX8qHyU9k6JoCRYovEWqZ2iKX9C+T38viXLZc3RxhG
	 hwz7UEQ5XyXiiTHjy1Yi9EpvWnGtjbnRJnHdghUL14sqL0Tl2VEqYifaesUwp0p4xpaS4
	 qQDB4fgw9r1eLrPPzSHKJ+nV3++qWeapruEc0aU1T1Fp8mBFOo5SlvK1LHejuQUNuOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFJX82tH;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7260A2623
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0F7260A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFJX82tH
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so298928266b.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614340; x=1795219140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CIJ9lTxFK2rYD9M28Y9MMRCwwxN4Oxtl/6GVumckvVQ=;
        b=kFJX82tHdIN4mLBK3xEGp9XQvLW+6z2W5p3pqMRs8rAFVFnL+1g+4xJ9gB7JKWkotW
         bjfAtLvgwiIvBgXJQrXpZqY+C1Lsk/0xh6wkpzE42iqiYqGNof6bQNehlnbFCIke2C4d
         bb7o8G8S3/BYJd7aO7Ts/QNTQ1/4DUGSm9DNpnGLb0/hGUh8OotqCIrx0iMfkN1+GS5I
         +IA4vgy0ETP4IgXNIVGdHbc/Uy9yehyVEV9G71gOvsuAzge8Ss/bkgiOl03nRQ/68Y96
         kIwHEmyd4S6m0s1YC6pHJ+f4OoUjePcCDUE10WwC+PSgEQw5mTIVqKfWDjVaVOGlmoiP
         MRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614340; x=1795219140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CIJ9lTxFK2rYD9M28Y9MMRCwwxN4Oxtl/6GVumckvVQ=;
        b=j51OnHeBeRYEpGqQObzmk3sjTdLiU7FOe3YAh0rKz8t0CT1htkEIBottQjP8Ls9QY2
         1f0U+Aylo486aym3UhiIkF+vNAT0+nCyHpQsZhM+k2Jw9f1/da6xIuUfgH2kT72wJ009
         qTMN0DN+psiuwAZwIf/Tt4dXzp5J2Eriu3UNXcNoL02ndfquEdINN1jRQnfC4j82iXWQ
         RfJ78wC67hlga43T7Ug4WE8m/mx9kJ/jQiodN2ddHf3xf37TudxD27X4LIzhpiRcroU3
         iyPNeB+fj2Ua8iLoYWhLdzLPD/NlcYRUga0p05sFVFIBLZj+BX+dvjAxzTNQWUu1Rxbh
         UXMA==
X-Gm-Message-State: APuU4Z/h8zPO/dmWxoDW/jNLzW7Zbb+CIKpY4CUbps+0xvaPHpVCecfa
	GNq4TieGIckA0yvspAswU9YLxFkBL6NNpwhwt56cmgO14fdb2kWWc9mDSZwH6U4G
X-Gm-Gg: AYBFou2JxoI6FYzZ1JEJ2QY2wPIk23StXU6f1qQwsgYHhnjOJjlRnnmcfWispI8mJNi
	pWIx0g1Isw4FCtAP/8hDcEsjVYh8P5GxUKreGWlIKA+YD4nP+VsHW4P+FtMg/elHw+S3JcKgtBG
	Weja6qEH6fvFv8cEbxIwsstD+TeDmruK1U/07qECQXHuoUWxPMa+dyW4EB7k5pB+Oz5T+kJTDTD
	k0fWkdZdNmJVkM8CO4h3qfYxNghOd4Z/JuwxVNC0xW2aLb8mlReNUB3zmpe81DQra3jSMD52tco
	W8XeQ6uuWZffsglyOzglMr+GiQyNxCZMzwft9pwZ4ERcUTCOPMCZOEH6Vw04AfX7/RXpTXP9SUT
	Xtpb5psQimaabskDOAb9YDTitJjIhwlNeDxSBQ5uLtoMnEsgrhiUFi448PHNrY4u1a+vbKshcwq
	lDhCWR0oNe9j6acWHBBRoZkq5HXTSDx/XdfByxr/vqI+MmsO8lFynIiM4t4mOHVffxq+iD4LRo+
	F6rpQ3UwSk+xDVuU+8fdXuk00CIJkn9PxdxT882Z3QD96vaM01bi6KOP+lOEZ3TDhNOr1obhwbl
	JYruCs4UOR9paHMpgZTNdxQaW2l7TdARrFCW6L01
X-Received: by 2002:a17:906:c151:b0:c2d:c800:d797 with SMTP id a640c23a62f3a-c509614d4ccmr342511866b.6.1794614339929;
        Fri, 13 Nov 2026 15:58:59 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:58:59 -0800 (PST)
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
Subject: [PATCH net v3 6/7] net: bcm4908_enet: publish the buffer address before OWN
Date: Sat, 14 Nov 2026 00:58:46 +0100
Message-ID: <20261113235847.517308-7-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113235847.517308-1-kudzo51@gmail.com>
References: <20261113235847.517308-1-kudzo51@gmail.com>
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

bcm4908_enet_dma_alloc_rx_buf() hands a descriptor to the DMA by
writing its control word, with DMA_CTL_STATUS_OWN, first and the new
buffer address second. If the DMA read the descriptor between the two
stores, it would write the next frame into the old buffer, which
poll_rx() is turning into an skb. start_xmit() writes the address
first, but nothing orders the two stores, and the descriptors live in
coherent memory, where arm64 may make them visible in either order.

Write the address first on both paths and order it before the control
word with dma_wmb(). In poll_rx(), read what the DMA wrote only after
seeing OWN clear (dma_rmb()), as Documentation/memory-barriers.txt
describes for descriptors shared with a device.

Found by reading the code; I have no test that shows the DMA reading a
descriptor while it is being refilled.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 4065769da..4139dad3a 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -291,8 +291,10 @@ static int bcm4908_enet_dma_alloc_rx_buf(struct bcm4908_enet *enet, unsigned int
 	tmp |= DMA_CTL_STATUS_OWN;
 	if (idx == enet->rx_ring.length - 1)
 		tmp |= DMA_CTL_STATUS_WRAP;
-	buf_desc->ctl = cpu_to_le32(tmp);
 	buf_desc->addr = cpu_to_le32(slot->dma_addr);
+	/* Hand the descriptor to the DMA only once it holds the new buffer */
+	dma_wmb();
+	buf_desc->ctl = cpu_to_le32(tmp);
 
 	return 0;
 }
@@ -613,6 +615,8 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	netdev_sent_queue(enet->netdev, skb->len);
 
 	buf_desc->addr = cpu_to_le32((uint32_t)slot->dma_addr);
+	/* The DMA must not see OWN before the buffer address */
+	dma_wmb();
 	buf_desc->ctl = cpu_to_le32(tmp);
 
 	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
@@ -647,6 +651,8 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 		ctl = le32_to_cpu(buf_desc->ctl);
 		if (ctl & DMA_CTL_STATUS_OWN)
 			break;
+		/* Read the rest only after the DMA gave the descriptor back */
+		dma_rmb();
 
 		slot = enet->rx_ring.slots[enet->rx_ring.read_idx];
 
-- 
2.56.1

