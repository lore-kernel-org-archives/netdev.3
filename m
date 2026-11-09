Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268634;
	b=zLijQpk9Fpbn+NjQO5xR+LtrcxRaNIg9PGaV+5wqSSD4Av4V3YWdc8tcTSZvlOLmI1Gk
	 kazi1Pcmn2JmTz74y9cT6wQh8BszExShEVfyfE3Ul3juomCTZAMHbcMJ+ddFQ3jltV1HM
	 ni7WIIsaj9hQiYQS/QimmcI2VfVAxXhpHmsk4kafhKItg2heLLBGe3QwhwgP2lMolGnBl
	 LqLp36+4uvN7UAOlD0bYK6ewWVDNHkJZ8iDlqgX4FP9G0AXyj2n9JrqR+89LyKXEa9BfU
	 gOXx3dykJmVT6fxqNgfMITUPdbY+v8/V1so/zS3JQdPqoOObU6i+XtIZZd4W9BEcpow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bBigMNQ1sAPQNa/iJ6yjbs4IQOEwHsZtkAEwCXLbQKo=;
	b=Tp8nc89BLUOXW6ZoHYVq+rQpNHiV7+7qlKPKGj4MiXs38bY9Du05ygmu8EfZQOwfPBDC
	 uGAjoOXnGnQukSy/pcaqKF7ZG40AlF4XHeJvz7pMDYAIH5w0So9uDCYyX6JU+fxbkm9Q8
	 jXRzprEk4mqcaFvGKxe6zRWVdAzVjY9SZB27ztOBAnEtvnr5tGlUARRiRidj6oEjQnjsN
	 4CzlwGQoZ9onQAiqRuLw200ifMfaz/9c8Pz3a6VkQ7T10559PC46DLO9LdeFmRx2xYg0M
	 2qxWB3WE5MjajEBNAcen9nr6Oki9irOXUw05kWBrMdHhgfI0Fo24Z2xnQwTMGX9NKag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQHDpmx5;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9C60A3806
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF9C60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQHDpmx5
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c504bfd7393so27273366b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268633; x=1794873433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBigMNQ1sAPQNa/iJ6yjbs4IQOEwHsZtkAEwCXLbQKo=;
        b=XQHDpmx5cLpIJIEoolw1g8b5MaO42/mb5O875lTDGREzclc199u8Vd7K3OMlcxbH6O
         CkWPY7V/pno5e0HuBsjQ4iYaY6OY8AeRCwDIaDHfb+3LGjSO2V9k7V1Oiw0O3j6j1/72
         bNFPeizmbAgL1Gp7o7FgwTz0v91ENZp06f0kYJ7TlQ1DoH7gsFlz0hDM/yEGbi2Onalt
         ocQ1SFo/RSL0WIIlSLmESk3Su/dBmk7l9TfDXFWd/QybQ3i6m5T1X8/X4a/xWSoxlhqb
         ILiu0RkdXNmED6vu80+vxnQ/uYwh5pADLupTn9bo2VeGh4TcyH4L6BrLqeNNqfZuNQ8q
         7ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268633; x=1794873433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBigMNQ1sAPQNa/iJ6yjbs4IQOEwHsZtkAEwCXLbQKo=;
        b=Yf/LXEnxoUbGV9wQrajWJ4RyjaMCjV0o2cuxAweYdesy0/55Wwm5Xt3gzhFAFkPQ4j
         RdJ92utlhp91QbUxIM1rEDBl5exrWTURw0fCtq+Cp0TbZmgaC5wBEQpSw1sdKpIxrDmp
         qPdybnMwEfHTjKdGW6Q03BtTwMZItN7JUuW+iKP/PCmPxVMzchWOZYLa9FHdfUU46rsN
         MqMHiZoftF7KnAgyKXG56ChrpRcb94hAgEZ29F/nkz6JB6VUaTswHbAYopFI9NlTC80V
         T4QIW/ItBoqwP6eZgKHRN9RW8Ne2AXj4esxNLRgxPq3Q1YU0tzDhXyWpXY4j8EQ29HRj
         FXkw==
X-Gm-Message-State: APuU4Z8I6djOwNYX2H9jqBGO0I2JHyPEtd5aJBeoNZu8k8S8TCmvphFL
	iY/WzaN1a+xFiys2CFQtLvMSFoiSuFZxXQ3+57FyhHBezzurM6GqD+HRoqB2dUh5
X-Gm-Gg: AYBFou0lyWHB4+YsgrPemHmGV4bGSU90BiHF4A7CV9imuMZ1m8VM1D79FK1e200n7B3
	S98BYFj8GjUCwfVDASO708zI+iTL0U/W6NNhq1hLyoU4NI0o76Y41CG6f1/Zl9nf7kwdUCk2qu5
	xzCFHt3vQETnQh53GlW1aaUY6jjN5XWC40SfDAKA7D6LiGfed/ASHebn3r99yQpNK3k4T4zYHvy
	pq+y6FTWnl/rBMnfCOhYgjGW1rfvzEpDaOOxrCS5ax0K/dA9j1wmG+q2NJbcthM3eDcnVt64vLb
	m2nHgeAX4qECJJ0mprqBgCULPfeCimk4qDdOede5PS+W3A+m031SvJ/Vqsgp/meO7U/gPK9qYIl
	n7l4DBYJLSjGhUBzLAHpQFS5u7AaGQSC0sUg8n+MI6pOvpC0/K3H3rGChRo63HVW5t9EgP6C31a
	T8c3hyn6DbZiDwsIN1WZfOReFq1Z9sWcGrReKVZkuGO8JGGg7VozYMhB/B5ckkBI1b5T3E0y1wD
	apmwP+Zcu7OF85UTJnuOmi5/bXg/AtyIwjpVu596Wk9USQ2wO1dEM6/AvdHAuVlyTe5lHubeJP7
	6NwQkXt6Lrmc0s3Tn7ExmQFSOn7bzQWJCfK4xo0MK2fEckbnc6YABfU=
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr79060966b.44.1794268632629;
        Mon, 09 Nov 2026 15:57:12 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:12 -0800 (PST)
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
Subject: [PATCH net 5/7] net: bcm4908_enet: unmap RX buffers on stop with their mapped size
Date: Tue, 10 Nov 2026 00:56:58 +0100
Message-ID: <20261109235700.2586821-6-kudzo51@gmail.com>
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

Since the switch to build_skb() the RX buffers are mapped with
ENET_RX_BUF_DMA_SIZE and slot->len is no longer set for them, but
bcm4908_enet_dma_uninit() still unmaps them with slot->len. Use the
size they were mapped with.

Fixes: 3a1cc23a75ab ("net: broadcom: bcm4908_enet: use build_skb()")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 778920e37..c0aca6801 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -331,7 +331,7 @@ static void bcm4908_enet_dma_uninit(struct bcm4908_enet *enet)
 		slot = &rx_ring->slots[i];
 		if (!slot->buf)
 			continue;
-		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_FROM_DEVICE);
+		dma_unmap_single(dev, slot->dma_addr, ENET_RX_BUF_DMA_SIZE, DMA_FROM_DEVICE);
 		skb_free_frag(slot->buf);
 		slot->buf = NULL;
 	}
-- 
2.56.0

