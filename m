Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480643;
	b=t8ZKSS+W2/Qs9EBlTNd7XbEyTaW7H0yzNY4u79uwBbMUu0XbPR64soFvj19dJnIq5cXw
	 gGXKDXRifTXM8J6anm1OZpcDB2MIDGlekbsIiWhJc5RjJDo20x5X/yNC5ZcEx2/w3jSE3
	 N2lLb9WuQlwR6lOkTmQSIGIgPnaB9Vn5qmSUTIvqpmiUzi7ts3pflWHtRgnp3cI7FCvi1
	 BKVKPhUpxuvFZ4qy2J1xFdENvbjCqSoWXGNj6nSSi49FRdGJgiOIny78KrWVM+58QRbiL
	 BJiNG40vN1rvsINnSISXHOQIsQ/HryO+EpZ5pxuxDdWIlF3e0QQB7BSv4wew4Grx5zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480643;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=dd8e5Qfy/UV1GcAFvQi/X2o68cpxIAE+gjoO6DiA/KU=;
	b=nlS7RO8fCwwGvFFTAt/ukp/Eaay+bjAG9m+IvBCzRca0tukEn0f+W9Q1EOL1MB5mtryC
	 ge2SeuMKCG9bInRes0UqSCRhDkMWFp7R6S/qIOB0ySy0j7vkdz9qvbKrzjZwuPSPeXjy4
	 3S+1uf8VtIKkJmihhEUYZqY+o2NCUSStcSO/MX/DcxZjrP5B4OO0VR/Qq0qmQeujP9WWs
	 Hbpt76dFuTGUbtjXrWCgJMGWD59c64vZgGMxhTVWGXJVSVOfWa9vG+J6MY+vjcekjfy4T
	 Acnjwd7kPxVGWbt1IwPe1c27CnkAM+whGXbHpcL7dsMOLLmmVyyTTB5WZGh6HV3eTmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZZAAm5RR;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BF606A31D;
	Tue, 20 Oct 2026 07:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZZAAm5RR
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 704DFA161D;
	Tue, 20 Oct 2026 09:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792480631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dd8e5Qfy/UV1GcAFvQi/X2o68cpxIAE+gjoO6DiA/KU=;
	b=ZZAAm5RRNa8iPc9kSOz7eehDXxnqIV09N4r+s1ccy1SjKH4KOp7ZfrjMKTW47qdl+GzWb+
	eSVzd2d2htkXiP3cUuEPA+3FtZ6A2I2WGduQCvURZ0S7rY2QN3ZBzxMUbGXQAbks4ccl60
	3OEKMxfgmHfBKqSrsz89rza+V3gY6bWPoANQ4O6zJdW+16o79yfPMPIK4mELNUJy3hrN/m
	kDgDRRmq/uxs9ddHCtt3vQmhxOtywVOf35/7Y4n2OoFKfUv9p3QG/KTwbjRNpmJX7KGocq
	1dCBGR2nd/xrmi3/0Wozenfl02XcqFPmX8nmcUzPKo9cbbGNy56JLVABQgB5uQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 09:16:56 +0200
Subject: [PATCH net 2/2] net: usb: cdc_mbim: don't enable BHs in tx_fixup
 under netpoll
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
Message-Id: <20261020-cdc-ncm-netpoll-v1-2-682184384b49@tipi-net.de>
References: <20261020-cdc-ncm-netpoll-v1-0-682184384b49@tipi-net.de>
In-Reply-To: <20261020-cdc-ncm-netpoll-v1-0-682184384b49@tipi-net.de>
To: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, 
 Alexey Orishko <alexey.orishko@gmail.com>, 
 Greg Suarez <gsuarez@smithmicro.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Breno Leitao <leitao@debian.org>, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

cdc_mbim_tx_fixup() has the same spin_unlock_bh() as cdc_ncm_tx_fixup().
Under netpoll it runs pending softirqs while the txq lock is held, and
a transmit from one of them spins on that lock.

Use spin_lock_irqsave() as in cdc_ncm.

Fixes: 9bf211a30b3f ("net: cdc_mbim: adding MBIM driver")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/cdc_mbim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index a7010a0664c7d..7158716c1f106 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -223,6 +223,7 @@ static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb
 	struct cdc_mbim_state *info = (void *)&dev->data;
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	__le32 sign = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN);
+	unsigned long irqflags;
 	u16 tci = 0;
 	bool is_ip;
 	u8 *c;
@@ -289,9 +290,10 @@ static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb
 		}
 	}
 
-	spin_lock_bh(&ctx->mtx);
+	/* IRQs are off and BHs on under netpoll, see cdc_ncm_tx_fixup() */
+	spin_lock_irqsave(&ctx->mtx, irqflags);
 	skb_out = cdc_ncm_fill_tx_frame(dev, skb, sign);
-	spin_unlock_bh(&ctx->mtx);
+	spin_unlock_irqrestore(&ctx->mtx, irqflags);
 	return skb_out;
 
 error:

-- 
2.53.0

