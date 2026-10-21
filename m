Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569396;
	b=1rQatW4Yc4jZLFjSIVcEuxMA526L3a33bYB/Mg2ViWVub/Mo0mczRYbKRdyqQsXCaXJ9
	 4cN0tE+YAw/gaH0eeBDhy4rom4J/Aa2AHaw8YA9kVlR9eYRHvPMC/xay/WitBWkzvfTYN
	 Lq/Etj9GTa/lcb4ZZ4NgwkMtWZs9QTv2mNUWo/zbeqy43jCg+/Pz/vRc1meObgXTBL69s
	 1fHrUdXL7ODocNOoDql/a+kcC484IMaHrVzFoDOq/mzqLefVA3KlhLPgXVMNLQoiRz/Ag
	 Y0IZAXi2AfbPu0dPOQESr9nHAhW1jLSgvlzW5h3AwZUfCBzw+f8pDT2jxrOZxNrOeNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569396;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=dd8e5Qfy/UV1GcAFvQi/X2o68cpxIAE+gjoO6DiA/KU=;
	b=lGm4uSqwDSJd8BUun2CUNWeGk775S8Fgc3Z46EHNo/rD23A6Nzudts50HSzCiOHM+o7D
	 /uJM6+7V1tz2sXvY6BDLQBujrWTiFVJmZP2CL9IbwIg1Bjh43k/A8d+/cf1n8mxhmk2YV
	 0Tb8BCyDqfQCCcjBOgKf5B8kJBTJgRXjYj6N6DA3j250Bgp5rFqr6YBAfmrUQ31Qpqeqk
	 Z/VpZLrtdYSnTeidLKVbW1osRtJ18BXkxc5tqFm5YbfipGm1LkhQjSUf6r24jEmHy47sL
	 Hf4EhadoGN81X/DhZR1dB8WtpfVryrn/kTFcgPxseVuu+6sZcCBzxlYNfHL4xN45L7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ucLSaO26;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040E606A324;
	Wed, 21 Oct 2026 07:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C040E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ucLSaO26
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 790E5A1628;
	Wed, 21 Oct 2026 09:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792569393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dd8e5Qfy/UV1GcAFvQi/X2o68cpxIAE+gjoO6DiA/KU=;
	b=ucLSaO26KUGZxF11RmKIlLGramPdXPlmduVu/GlhO9rDZ/nG9BvrhlMoc+Upad3B8eiJeu
	YuYF3yM58XiOVyErz/ingLgnFkmgUYvNj1dbmHOGSWElgIODMETWNr+YO33Oh66RPeeILP
	ywBH9rmelR4qtEAtg00CElhElaI9oVr7oqyfNMsCNbOMgHFhtsZ76fZp61UwkR1gUXfbld
	e04bZQInXYUn6FiB1ZHnkKroc62KOIphAbjcB1CREVcXPnc5rtMyJDRm4X/ihbGP9ocCJn
	iBOceqGiye5XidQhSSi91z2OhibNGn+NZBJ92D9daX58TxFGilx6LsMKhpYKPw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 21 Oct 2026 09:56:19 +0200
Subject: [PATCH net v2 2/2] net: usb: cdc_mbim: don't enable BHs in
 tx_fixup under netpoll
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
Message-Id: <20261021-cdc-ncm-netpoll-v2-2-8818965bbb69@tipi-net.de>
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

