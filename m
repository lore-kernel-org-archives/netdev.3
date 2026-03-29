Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CB36C9C1;
	Sun, 29 Mar 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794900; cv=none; b=XThl+/+JPdNRIhI4wlrpg2O05bpdKE3Cz1IL+WHDiwdu5bRioLH9KXr1pl3riFYDWpPCwD4di6+9FMb1tb5Oie41SEB7hp+CgTNrhdWGOnaIGyH4dAj1FyrbeVsCWftXxhLsHJgD6F+DZ1Zzs5pMA3ksjKNZdAI1dl01bd2WODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794900; c=relaxed/simple;
	bh=H4OReyZYEJw+EIZJLYdpcrMXwbdzfOq5Y9BMVzx1P4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijWsGwE9z6r0MUzcr6exbpHgy2Z/jnVeXlmm2oasdTBoMg9st0SwACw+8FpibxsSoD1St54DKIdgIFikcqYfXkToZlnm7D0ccf/abSQLP1p/W4TXVNN9X1XkTuNsMzoCQW2j8+WLJIgN1Tfkkp8hGVW1VIxXH+rKSTrtguDIFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iaqFPkuT; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c2ujkUkX; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iaqFPkuT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c2ujkUkX"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fkH344kWWzB15q;
	Sun, 29 Mar 2026 16:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aqDfbFa1iCuB28C+Gs91A6jzgvXiA0+cvmHO8xRGaw=;
	b=iaqFPkuTZwrwRDzWbAxsF9iYplpq6P/Q+8oioKT0e+47AfYbQ+pR8ypWlMEB0UaxmXW88F
	SxmV/Yp05rOOWdkCBiSs4ZgLdxLTqbXBIe6AJOGZMBchXVRoUbmOGYkKIMpjg432QDX6Ch
	Q+hNlZdgw23iidajcOIVDRDyiTl/ZLo64/c3YisBR244ZP0fCOOgUd1hV1oynoj1Icae4i
	ststdHhAlcUxLsRz4QB2DSrXyvjZv7dzR4+zsqdJRlGAd3FG/Mpm/1nZQpKOKVt/X5BMfY
	ZU59j0lYjfbMXNTH2kVW4MRA3mpcB+ckNtMAVa2ie94Nl/OFJWzJLJzSRfEPRA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=c2ujkUkX;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aqDfbFa1iCuB28C+Gs91A6jzgvXiA0+cvmHO8xRGaw=;
	b=c2ujkUkX65BRGGaK42XzDOf/OdKqtPfEQ53TeK+iLzMpTWrmV/oPnzTGi14P6CSKO80MkK
	gRt/0yRhH2ww+ZAgUNayiTky+eM2Uksd1BTCoyCWedEVe0lPI0/e31EpI6vZdRGqbDkBlh
	2H8q8+wU4wp42Vc4CqY79OiC2Mnok1TNAa9VoDBgwDR7Q5o6UgUi8+Ss6UBScZIdJzbLxR
	JNf1w2Lw/iuejH8rMPLVnTsBhs8NbtS7zFyeETC/UJuISMH3nG5JiVGFUylnjkhgyS9ICh
	r+NmPRdNBgLstLJZxMc/9ruuTESGNis+SQuDJalhw7Fmgy3jWAWxYIEJsGptNw==
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 1/5] hamradio: mkiss: move assignments out of if conditions
Date: Sun, 29 Mar 2026 22:34:04 +0800
Message-ID: <20260329143408.747197-2-mashiro.chen@mailbox.org>
In-Reply-To: <20260329143408.747197-1-mashiro.chen@mailbox.org>
References: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: egixi1dqeihowp7jpbqq3usbs77tnjgn
X-MBO-RS-ID: be6bcb8adc1f6aa82d0
X-Rspamd-Queue-Id: 4fkH344kWWzB15q

Move assignments out of if conditions to comply with
the Linux Kernel coding style and improve code
readability. This also switches to the preferred
'if (!ptr)' idiom for NULL pointer checks.

Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/mkiss.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 5f38a002b..eac45d936 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -282,7 +282,8 @@ static void ax_bump(struct mkiss *ax)
 
 	count = ax->rcount;
 
-	if ((skb = dev_alloc_skb(count)) == NULL) {
+	skb = dev_alloc_skb(count);
+	if (!skb) {
 		printk(KERN_ERR "mkiss: %s: memory squeeze, dropping packet.\n",
 		       ax->dev->name);
 		ax->dev->stats.rx_dropped++;
@@ -591,10 +592,12 @@ static int ax_open(struct net_device *dev)
 	if (len < 576 * 2)
 		len = 576 * 2;
 
-	if ((ax->rbuff = kmalloc(len + 4, GFP_KERNEL)) == NULL)
+	ax->rbuff = kmalloc(len + 4, GFP_KERNEL);
+	if (!ax->rbuff)
 		goto norbuff;
 
-	if ((ax->xbuff = kmalloc(len + 4, GFP_KERNEL)) == NULL)
+	ax->xbuff = kmalloc(len + 4, GFP_KERNEL);
+	if (!ax->xbuff)
 		goto noxbuff;
 
 	ax->mtu	     = dev->mtu + 73;
-- 
2.53.0

