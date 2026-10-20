Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516385;
	b=5bkmax8QzgFWgiRQJeAOhoIZ0IPLT0XfXfI1OW5ZS52Cf5FviHcnTBGfxlSpc9eSAgZk
	 0smEWhKYFMJEzkzsB3jD45wJb4xfCGGQeofWCxcyhIV/d5lgJyZkf3DCIpfiitaEwvNnP
	 tcgPZEoeiTAAGaNYluo2o1ry4IxT8nMGifnDfdWEkTlzhl4181ouaPLzI41EIpzl4aM06
	 bcVV8Le5vHYv4MYl6d8HGSwMB1nFGXB1Cq27tK0trzA7615zYRc+8CmnxwJFxSSLHfvWR
	 Y67xFypm/nYuLTHga6+NCgbwocwqu/2KzvhpPGa3nzQJN1C2KcWUZqd1sG2BD4jvavA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Qa/Bnu4IDyx7HlJH6cI3pDp+8l0FBfYl4SHNAHwQpAY=;
	b=piiX4u8/0UZ2knXbplng7NJriZKC7ixq6C6+EfuMvhPrc+Mftek2HGQpjv6A2uWZk4J9
	 nkMNGRFjHVcsEfP/5HCIxaXZ+LnukQsnW3nTmBoXfVM3qC2JK0R4JalOeJ+f1czhTl5+v
	 akjpfElCMIuX8HGFVA+ujfIe2utG5ly0BGJO06Uw3S0rGY3WDdAU7GaaoOb+ouJqq2cFA
	 VRnLJqw5ga2qf7hp1Ddo/uduhEC7Kmk2PaO9d+iM7WIY0jtXImRUlpX3gmp8CqNtNvtLD
	 mbXGU1ttrgGkj5JKda4yu5YPBozCtkAH1BeqR0T2MHBlYww3gV9WAsTzk37Hx6RU74g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=CUoBOqHC;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B93606A31D;
	Tue, 20 Oct 2026 17:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B93606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=CUoBOqHC
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 59042E8318C;
	Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qa/Bnu4IDyx7HlJH6cI3pDp+8l0FBfYl4SHNAHwQpAY=;
	b=CUoBOqHCw4f3cuT7aQmLB7vVlZpCf8yo2JuOP5dc2yCmdRcCC5AJuz/enKmZ1ReCROUEBu
	DyBM6lMgm4Uurr+ixX2ENjSLMTiHsCBdkLU3gv7EXBiA4s0NY+4pkfwnJ+N0GjGlJ6NGRp
	lqoPMwAclkD3jidr0wyC4VJGaSeENMJVBj4p5ok1qNncAwXNZUyQdK9hIlAbhGuZ8w5X2+
	2cKIVzjPCgYETmr5U926Z7EjHRWE+mHegB8WPlvoa3tHVYhy6TWky6s0uBmjlEQRcAIgKj
	W+vtG7jCSkqnj5FcKYOv02SnV8+poAybR7XHfz/GM4aY3FSG5DOTXb1dTGrWSQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id ICugAwAQ5GAF; Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 01/14] net: pse-pd: size the notification kfifo after defaulting nr_lines
Date: Tue, 20 Oct 2026 19:12:36 +0200
Message-ID: <20261020171249.853085-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171249.853085-1-github@szelinsky.de>
References: <20261020171249.853085-1-github@szelinsky.de>
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

pse_controller_register() allocates the notification kfifo before it
turns nr_lines == 0 into 1, and kfifo_alloc() fails for a size below 2.
So a controller with nr_lines 0 or 1 cannot register. pse_regulator
(podl-pse-regulator) never sets nr_lines, so its probe has failed with
-EINVAL ever since the kfifo was added.

Apply the default first, and allocate at least two entries.

Triggered in QEMU (arm64) with a test-only PSE controller with
nr_lines 0: its probe failed with "failed to allocate kfifo
notifications". With this patch it registers.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9f..c0573cbbba5b 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1044,16 +1044,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	mutex_init(&pcdev->lock);
 	INIT_LIST_HEAD(&pcdev->pse_control_head);
 	spin_lock_init(&pcdev->ntf_fifo_lock);
-	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
+
+	if (!pcdev->nr_lines)
+		pcdev->nr_lines = 1;
+
+	/* kfifo_alloc() rejects a size that rounds up to less than 2 */
+	ret = kfifo_alloc(&pcdev->ntf_fifo, max(pcdev->nr_lines, 2U),
+			  GFP_KERNEL);
 	if (ret) {
 		dev_err(pcdev->dev, "failed to allocate kfifo notifications\n");
 		return ret;
 	}
 	INIT_WORK(&pcdev->ntf_work, pse_send_ntf_worker);
 
-	if (!pcdev->nr_lines)
-		pcdev->nr_lines = 1;
-
 	if (!pcdev->ops->pi_get_admin_state ||
 	    !pcdev->ops->pi_get_pw_status) {
 		dev_err(pcdev->dev,
-- 
2.43.0

