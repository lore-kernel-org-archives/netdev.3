Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513068;
	b=zBfcWTHsdAsnNeewcTFfhpRF1bGjJ5/xxERDHWWu3nf50PHbBoGkBhCHNrwSIZOzVbkj
	 TS6OB6ld9ulzzxvJVcpgEgmTxu015JbRjTrLkOewJ4Q2OadPi5sHikgMRwda+M77lMm2X
	 qY3m5WvlgevzYLyWT/gB8MnzzjLf0DYPGOA/qRYhKmYgRyQ4VS+uU5msycsDEJndE07K7
	 PBmh95Ejoh2f+CHZDhP51CMvzxl9HKpXjWJwVHZoRVqABEhUUybmcgH1VeM7zUuaSmvIi
	 ucl1j1PPOm1HOGC0zNLCRAzVGwiHtgPEediim6CsNdgZGL7zm67Gfwch4abDjKVqCSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9wH/dvIVPNok79VeHTk3379PpsJpsn5pMeJSpNre7+U=;
	b=WWTmlpgh68SUfjFMaDDFEG92nxEn98PpCwRVpW/geaRkJR9XSzN/yecYRtCR1G/8IHbv
	 YdgwD2i8e8y8zxume1wmEByqOR7RMWpY9NgQMpW1jMp+QcxUPqaLpygnhEiqkdtPYLZNO
	 hxQ6SfJQRPk49QxZNs4jWILoCkr4go8+G6S1mth0U/5PCqFSGQJr7rJtHwpxwHkN5SRz1
	 zUUw688FhysVnM5wMjkArjGbKZpQMcioCqR6HB9vZiqW4E+/rWBONOhivW/kuczwrJ1C2
	 6ui43NfHuPascKSLiJDCK+CYMGAYtzgx5lf1+Q3l8s/s3rquZZPzWFTSCmnBJtxYU/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTlFXnb+;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFC60A2634
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6BFC60A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTlFXnb+
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so723166b.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513066; x=1795117866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9wH/dvIVPNok79VeHTk3379PpsJpsn5pMeJSpNre7+U=;
        b=PTlFXnb+yEYKTeMS1WaBDvg/3Va35AQa+wKdbJANXL6TZHXOKamvtvEn5tHjufUyDP
         8a1fqMxM2Gh2XqIaqQKqYq2TV3uqMMUuVu0aCEwqzt/u+a8L3S+aimUfl7fVpGRNDavZ
         /d9och4+bxWC1SldOqaAnK9hslcfautqDw4zrrCrkGZAT2cRPB2xCdbXnzLS3ohWjCh5
         +gfyiU6zxYphw7NzvKROiwR95KfqsJhslFnBMMGuQuh3+2pkIq60A3xR0AofgyRtcGHe
         5pKYPHEsTXtx0CMjDApAJW5DO7sc7oYoMtK9KDDt1RoyrS0HZcGwgk1EbxkdQpMFpqff
         strQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513066; x=1795117866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9wH/dvIVPNok79VeHTk3379PpsJpsn5pMeJSpNre7+U=;
        b=YquqQKsUn7g06htgKiKLxCbnsZXzaYFUq2/Do6D+7l39+JHLyc4H0lPTSKckGyzGIk
         Dzw9hATw6nRr38Ewbitntm78DQQE4Mh+id4WwdWwMdGp3gQxV319kIZOUXxQ1xJNH/II
         poDwC98+e2spb5lwYhz1d5C9p7tcHDM1hCwB9ipy/KvPn9qFwUwGk6fbIF7aIgMxDS5Y
         bb1Fkxl43/N16OR+HpwrfRr/npw0W8beqauJSCCG/l9LpJ5UM8Gm8LAMIrzzU6devmZt
         f2mwa6zLb2eOgvxuripz2QnUvIn2MOTgyLGcLkjOA2piiWOpP2fKfqhh+Ltvx2AGGn47
         YJqQ==
X-Gm-Message-State: APuU4Z/Juty0T6gtHKXOAYnzT6nGPWFSXErwmjh+WUgtmwF3uO4h90Wj
	QUSsRBHXImJsCA0JMNuCWtzCS4hPDVWvjtBFcAyzMH0rqzoA2B2+gjVMzJpg6MBs
X-Gm-Gg: AYBFou1I9MB4SYRZESLnr+B1p/ysLAqjTAXkBjcMr0Z0eTexZKJKn23jR7LjLGwbbne
	1UpcgSt110rgkjt6Af5tQ1nPRhPEUIdqMTty2aasIVvEs0/iJvTnjqgd0yM4Jky9hp4SWASZjmJ
	otbOmKT5dP2/ua1jSS8Gn6OuFITKs34bYaYXLOUPFeMYjKiQr1k5gXbdve9xChZ6iOksu0+61l7
	IoscE8V7cMhQf6MyJ9UU/Vuy+iajRxTjV/tncPl8oPNWuH/Dfo2SuyM2rpXXtsgAfrP60EI8qoQ
	uloVl+SmbY0/w26mbnlpahXeOTqKnsoFQaZ9GEbWAe9Zf+lhGi53wYC56fGdd1OFmUfspYQMx2C
	+oKI9L9jcAX/MLQnNxqMV0UXolGzN9YtahE8ohMtK4WOddYZo0ePf7chBV0W50JlZMnbobSACk4
	qpQ2ZGcubyboU9TwsVTQ3yvqkhTrwQ/RrXvN2hCYE0RHTXs+rjdeELPdwDLNpEQw0VsJ7hlaedI
	oyE/OwZhYAuFR6sTMMq1jt2pfqhoMWcTGSG4hP33jjnyLiIXD8Ii7vrsmyRp1ofIDWIhHVAkVR5
	4ggMwVRD29gYO5mupQaofdQc64feQH6tTJfsSHK0
X-Received: by 2002:a17:906:694e:b0:c4c:bff4:200c with SMTP id a640c23a62f3a-c50963da4acmr22688866b.32.1794513066329;
        Thu, 12 Nov 2026 11:51:06 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:05 -0800 (PST)
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
Subject: [PATCH net v2 6/6] net: bcm4908_enet: publish the buffer address before OWN
Date: Thu, 12 Nov 2026 20:50:51 +0100
Message-ID: <20261112195051.597102-7-kudzo51@gmail.com>
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
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 8ac749c44..3d44b3452 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -290,8 +290,10 @@ static int bcm4908_enet_dma_alloc_rx_buf(struct bcm4908_enet *enet, unsigned int
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
@@ -610,6 +612,8 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
 	netdev_sent_queue(enet->netdev, skb->len);
 
 	buf_desc->addr = cpu_to_le32((uint32_t)slot->dma_addr);
+	/* The DMA must not see OWN before the buffer address */
+	dma_wmb();
 	buf_desc->ctl = cpu_to_le32(tmp);
 
 	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
@@ -644,6 +648,8 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 		ctl = le32_to_cpu(buf_desc->ctl);
 		if (ctl & DMA_CTL_STATUS_OWN)
 			break;
+		/* Read the rest only after the DMA gave the descriptor back */
+		dma_rmb();
 
 		slot = enet->rx_ring.slots[enet->rx_ring.read_idx];
 
-- 
2.56.0

