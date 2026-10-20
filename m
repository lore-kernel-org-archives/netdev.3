Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480637;
	b=0lg5AkQ/+1LnnqIAyXjo5hoQ4IRvcPMalk+FdYIBMHij+guGD8UXteZmSr2jiIlp+73y
	 wdVACpOvRa/4HtSVaOLG5rhn1saoTYXNtOFxtW/1HFYId9h6v01aAwV+r7WQCrtRgfFuh
	 dL/3MTIqBCPpPH4DvysFp8E94jD5fXINv4sjN4xj+PWKjS+Aem08YyrX4W7e/uel5WM9U
	 NgxOnhc4O392tX6Bip3dWyAFUNM+fv+xBCTdo6fad1y+I8PjF4RPOW8yjwOP2eMGA33Ol
	 3ydGoIbcgwxO+AYqTOo8taLjmSJ0JECKxct+czr1UA1Y/mu0Htyvtxg/24L9xDWh26Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480637;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=uY08WIDcyfXsbuMxE0cgXupuT9t+N3HFFpO9VcmEGwU=;
	b=CShd92EHPQa/lahlErT+1liHL28pPaBkMGuEUkrop2BUSwEXLj/atPVEEHVeeZL1B8jb
	 3uJ7TDt1VUrgiicVhSmYiTrVhNZv4dHEH3CwT8ZWGrxWzBupx5RCUJUgJPu/+Dh1u/xHF
	 YS2ZTTmIJ4vKaBjKm+1DWt9b/Gp5G3eK0ebRD6g4EYS/vTFiGYk611a2Sad/16VkEC58J
	 VMtm+gwNTWouSZOw5YI/8NanJR3K09Q2Wrn17uOl3f4YL5/GgFQDyhEIxuwQnnc/KkOz8
	 ypmd8kCCb6AQoRiZ0vTMpA3iJQQdiWOKuD3aziACfq6um3Ym2QPwrt32eJgsOMoZEIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=dAPnKuoL;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C0606A31B;
	Tue, 20 Oct 2026 07:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F13C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=dAPnKuoL
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A702CA161C;
	Tue, 20 Oct 2026 09:17:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792480631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uY08WIDcyfXsbuMxE0cgXupuT9t+N3HFFpO9VcmEGwU=;
	b=dAPnKuoLH5fTxAT2T6oMqat6co0w1F2NGiLIenFqREcIooZvV8vCC7uRI7adwUBFlDH52M
	urHHu/fw3PytKvreeLeOkeYAqe79clO+yecf8SCWrQqGPaOPMhPZtcoEVmz/bQWxBbMcy6
	SdR16NuGhHRuto822NfoQvGT9gbJP4GCavzTyecs2di4a/ytUsS5dg+BdqV68nNubGh/lF
	/r0CMcYC5pTWxWzVgYSHkGzOj2h0+ja3aQX/8X2bQiHNAzjdBY5p1FzFkHVweLa1NGl2Qc
	nSsIPnbZhYE87f1N9AZNl9va8YECaQRj7DlPbXNEAIJesxtu5mTZdAnLeoj/3Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 09:16:55 +0200
Subject: [PATCH net 1/2] net: usb: cdc_ncm: don't enable BHs in tx_fixup
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
Message-Id: <20261020-cdc-ncm-netpoll-v1-1-682184384b49@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>, Mikkel Eskildsen <mke@visotia.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

netpoll holds the txq lock and calls ndo_start_xmit() with IRQs off but
BHs on. The spin_unlock_bh() in cdc_ncm_tx_fixup() then runs pending
softirqs. If one of them transmits, it spins on the txq lock that
netpoll holds. With netconsole on a cdc_ncm device this ends in a soft
or hard lockup.

Use spin_lock_irqsave(), which is safe both under netpoll and on the
normal xmit path.

Fixes: c84ff1d6dff3 ("cdc_ncm: reduce driver latency in the data path")
Reported-by: Mikkel Eskildsen <mke@visotia.com>
Closes: https://lore.kernel.org/netdev/PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM/
Tested-by: Mikkel Eskildsen <mke@visotia.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/cdc_ncm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3e4a2..b579442f4a272 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1524,6 +1524,7 @@ cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	unsigned long irqflags;
 
 	/*
 	 * The Ethernet API we are using does not support transmitting
@@ -1535,14 +1536,17 @@ cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 	if (ctx == NULL)
 		goto error;
 
-	spin_lock_bh(&ctx->mtx);
+	/* netpoll calls this with IRQs off and BHs on, so unlocking with
+	 * spin_unlock_bh() would run softirqs that need the held txq lock.
+	 */
+	spin_lock_irqsave(&ctx->mtx, irqflags);
 
 	if (ctx->is_ndp16)
 		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN));
 	else
 		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP32_NOCRC_SIGN));
 
-	spin_unlock_bh(&ctx->mtx);
+	spin_unlock_irqrestore(&ctx->mtx, irqflags);
 	return skb_out;
 
 error:

-- 
2.53.0

