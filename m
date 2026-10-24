Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848220;
	b=L3ujPhbgbtMx3ekLh8Df8DIbWPjMRvO/GwtcXwgq90z2wMsaMpte5bU3B7+PtYO7Mq0P
	 evxRTE8Rs9dp6Oe/oQ31EQdAtUBOat3gbrVDrFFQER1jvCqGjuSD5iqyZ4EYLnFOsWRmN
	 S57/3lN+otT/LreNvU1VmeA1A84p4TVsR70QIoxghoLFgw5a4zaXCp2PJ9vvuNzRXSoF+
	 YAPjqYsnKBEeF01ILj2SyNfEja4G1aNrlh3z16rmx8BmTx8dz+IKnCnnOkZ0R5TR7oN/n
	 t4ugTTZMiiduEQNqC1o0wTn1OLDXZ7OAeJQuJq2ym4a56JVn7A32fCy8PY1uVMhkx3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848220;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=qJqARBJBZ2j0sPZaN9roF9hygDjY25NTxK/1qwx0dfw=;
	b=UYK3bRLZ1eWAhxTrKM3kxk+V+G69s82rtf0ZUc+svb6yvBIoa4zw1MXD3J6CXFjrlpI+
	 l6OSmWi6SGw5tztcrKw6d6BH5TmTuX81UBKwNSesZKGkI4Y9QofIs+gnLhIIceymbLJPx
	 GpiyfXo37C78WuaB+Enl5nL+m+u2mXO70m7TO1NvuGtbfA5CrIxRIOcgAFltLuB0g3ztf
	 5IQhxBIaOEIpuDmoyj4aX8alFDCoNHeC10rzYI2blsslWd9j4tNQdf//PoG/fzsV1CA/V
	 NxuZC16/PFSK/Tx7B32L4RoslHp84nVxE4lqjWGqIsGaBasm25Khi2eWgqlI+gbYRkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=a2r7glJB;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DF606A31B;
	Sat, 24 Oct 2026 13:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27DF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=a2r7glJB
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51D86A21B8;
	Sat, 24 Oct 2026 15:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792848216; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qJqARBJBZ2j0sPZaN9roF9hygDjY25NTxK/1qwx0dfw=;
	b=a2r7glJBj6LpFcQB4eY90eJOeb9LIpSyApGLqHFB0ylhK3/pyTnwItDkpx7d8i8hVcq5Nf
	obU7wjuUIrAI7PwY51gKakyTpxXYWJSV45MGnCIpzc7oIrHKd57qcRURSDLlKp4GAyq/6K
	oc20/Q1wXSPZJR5RYV1hnh70QM6Pf5O6ZX3ftcJvdX9i3HUJLrhbhf8uLjQoTOV2+wI6M5
	aZdpu9dJU26hjbkgWd8lXQ2ZZVAhyXJcjM5oAxlYu4J6+/LmMcDYRA0L8x4sriqFojzA//
	AN+8HdvV8zquILH7PB0KPJRN8NGS5+W5sX885S8UFLOtS4+iJIxdIMAw2nSiAw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 24 Oct 2026 15:23:06 +0200
Subject: [PATCH net v3 1/2] net: usb: cdc_ncm: don't enable BHs in tx_fixup
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
Message-Id: <20261024-cdc-ncm-netpoll-v3-1-6284ca03f967@tipi-net.de>
References: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
In-Reply-To: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
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

Every caller of cdc_ncm_tx_fixup() holds the txq lock with BHs or IRQs
off, so the softirq user of ctx->mtx cannot interrupt it. Use plain
spin_lock().

Fixes: c84ff1d6dff3 ("cdc_ncm: reduce driver latency in the data path")
Reported-by: Mikkel Eskildsen <mke@visotia.com>
Closes: https://lore.kernel.org/netdev/PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM/
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/cdc_ncm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3e4a2..3bd7cb66f3fc3 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1535,14 +1535,17 @@ cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 	if (ctx == NULL)
 		goto error;
 
-	spin_lock_bh(&ctx->mtx);
+	/* BHs or IRQs are always off here. netpoll only disables IRQs, and
+	 * spin_unlock_bh() would then run softirqs with the txq lock held.
+	 */
+	spin_lock(&ctx->mtx);
 
 	if (ctx->is_ndp16)
 		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN));
 	else
 		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP32_NOCRC_SIGN));
 
-	spin_unlock_bh(&ctx->mtx);
+	spin_unlock(&ctx->mtx);
 	return skb_out;
 
 error:

-- 
2.53.0

