Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569396;
	b=LudcbcqNfj4WfeOb0bivNK3sLfdRPtWNrao5J+UH1AE7DgdI3VdTmoe9HxMtyXwP+s8K
	 7WR9TWTO+gRYvsd8BJqEXgaY6pgI5VdU89wCB7PtZlYUHXWvi+bN3DW9sTZEEGn2zSdWZ
	 z1Jie6gv6nE2k9+/Mehgux5BxPpQ4WEdld8EuiR0dTrzuqQHbxBy3lprb00j0Pim/nwTJ
	 fe+4ily9SWG94aSuiHucSDCRFhFLhDeAQssOtosLADbgNN3caBFk53jHWKkf9s1SUrnS0
	 /C8wI4OSlA7n0aAPzeZVvTX0A7YWQdIBEHMQelDkZ6X9ke5F0EXjeIbJpSbwwu+zrmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569396;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=ODsXlSUWjKP5s4gu5hZvkkARUL9B5SgGCQ4UPjpEKNI=;
	b=UC3V5yhS8TORssgjg6G1BW6zxBmI8a/jrkgoIytcByj8/WueZfsZwoZqIwaU9ZIHqu/k
	 Sa3WthzXXs3IBO38oi29qgpwFp+5k9WJzKHLXO3zH/tH7r2VR6D0dUWjVk/SuND/grjvt
	 YfgA+hgkRa6SUK/tq4yJxQ0fOFdbZTqw2qEA/jZCIa78OBUBz5C7dodjw6IH1bkCpkpXh
	 0AqG4z+ONYBliuFYjUKTpTGuM+TVpk5KrYFKL1hHnFWXupxZmex20WEk012LvV13TGGTl
	 4AVIOJNw7FCudQLsY1ofKmJjv4izSftBDGPtmgB2SV5PnH/+tXOjYiU2lNfFFnRi68g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=gZaySVq4;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B2606A320;
	Wed, 21 Oct 2026 07:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 452B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=gZaySVq4
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8340AA1627;
	Wed, 21 Oct 2026 09:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792569393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ODsXlSUWjKP5s4gu5hZvkkARUL9B5SgGCQ4UPjpEKNI=;
	b=gZaySVq4M0fqnFdiGVuv+gRXVjxt8P+xCtziYOz47F0YM2YcR9mWbnWDXtRDi2q3qtsOSJ
	frrzXxgh2J7rHn16N4IVtXL0mO8lUhmhqgbovRXLg6K7ULSaUDPLGkGc5kX5HjuE/NSXat
	DNY+6QeLc+udSsZEr2WfJp+0nQGGpFnhS0hb/bsZObnk+ELqzXSm5vshYnRTVqcn0+fhNP
	O+z4Hbbbb5EO+x1cVy+LOAUG1I2tMEQJd4vbVWE2tTSQCqULkgxc0ZtAFThDdJ9J6KcUrc
	GFNerpOcFlREoMZDajC/iZaj/rajESQCNTfBMZtVm5YQKZiEOOjBArVM2ioLeg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 21 Oct 2026 09:56:18 +0200
Subject: [PATCH net v2 1/2] net: usb: cdc_ncm: don't enable BHs in tx_fixup
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
Message-Id: <20261021-cdc-ncm-netpoll-v2-1-8818965bbb69@tipi-net.de>
References: <20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de>
In-Reply-To: <20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de>
To: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, 
 Alexey Orishko <alexey.orishko@gmail.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
 Greg Suarez <gsuarez@smithmicro.com>
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
 drivers/net/usb/cdc_ncm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3e4a2..fed0b117a42f1 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1522,8 +1522,9 @@ static void cdc_ncm_txpath_bh(struct tasklet_struct *t)
 struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
-	struct sk_buff *skb_out;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
+	struct sk_buff *skb_out;
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

