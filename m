Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D143E0C4A
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793004; cv=none; b=lDucFFfHUvKYRtbpgj4NZT+aJ7qI8FFX7odvhiiPzR3R4BhMr8D1PHG901j+k4nBfQWLAJ+WI8tKiktZ7Qnhq1fXU8CJwQAOBKo9kQJxeIbh2eDUFNhDJbVso9IKFWLd2BFp2tmSZGaH4TQ1BRMhdHgN1+QFW+Yl37b8HihDqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793004; c=relaxed/simple;
	bh=xEw2RGjxhsudg+2oCVAbhhAdiLToHL8HwjP4Nl69Y+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BELDaE9Uq8vpcC3tutxwknozNRRbKlE8svYGpmbHu3JX2z1iFk3lbHBFYcN28WV9xstwAa1HEu+JPdKAWngRi8287ejkkHYQvTeYYLnCCGy/OpNuztf+n05x4fHDsIl5ItGPd/n6b3kPKyounO820e6dapdrP5fBrtKqC3BDR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMNinX39; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMNinX39"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37ff436a048so968373a91.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793002; x=1783397802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBZg7HUDnXyI8tZu7pp7T9t7odrKhi99tNW6A6Ze2oE=;
        b=BMNinX39kfqkAwQlflAsCJh85YpjKDvG9FacXw+kKkuKHIRZEU2clYnhIbvRgyUIpT
         WPcJW/vQofe0qKUbm0yEs+9WV4XHq4dcfl0pE6LCHZla1tlS2H5AY0ByrOVks9cLPDoy
         MqE30puIZF5ouzA247ufe91JmlFGoTzGmd3/Ewm+u7WMgf2l9+8g1mpfr2qo2pG6oOCv
         pabgU2YaI96gutwgXRhQuZI072z4FMhkNv+ySGEkCudwTJ8XMmVLRLiyxtzEz2QAso20
         UqubgmhfDWH08BlhZ+FYt6CJgzyJFMu/h2aTkocin00s58WL3H04oRCbeEoRmL4PPFux
         Jzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793002; x=1783397802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBZg7HUDnXyI8tZu7pp7T9t7odrKhi99tNW6A6Ze2oE=;
        b=FuVJdjFwIwRNjQ66dg+sLqefOLwQAA+UYHgu2r3QEcs2LHMYKpibvRrc//UB3lkLfy
         VLgbgzJJ3Rj3o4h6TjJ2ZBBfDaTLlQT3LtzDpc2EjTCbs/um1TntWIMwkVfWVl4TSZWI
         BW/tLGuCR4et48hgNVl1diL4+b5bl0veSyiNQHUzaXx/wy/jx929gw0w78ge9ThU33Vg
         grtb735uv05eh17ntCPUL29AwYwxbF8mZiFnLMldQ0nm1Nz8RUEaZRPP0juFa8YtmAFs
         8WLKOVKbB4cjMiKAjzDIlHTwPCcXAyuHPgGLqjdKdq+QSv/b+WBlcd/jnMx3DXI9fDlp
         taaQ==
X-Gm-Message-State: AOJu0Yx6f504Vw87nHFgJjHnQJO/yVLHM0WUFySyBrShnBeDetyaijfu
	AG9s8XGgjqjsm9HkrkdvkHCQ8uFEh5Led48376DIGEXK6I/Baltgp4xQfpvjPSoE
X-Gm-Gg: AfdE7cmEmforj1Nd4lOFE4iuhbXYFJ9Ryn87hruUr0N1a132QRrOn21/8oRi+w4PlEd
	R60waDpG8aDrh/mIgH7faeWcQHw6RKAew4dJ4mZqKVmAEnZNpXyVPd8YH4DNDMcjK8OkN7COiHV
	KQ239hl9qhGXni7/DRBKnpwE40EjqylJlmhwjur+PeiGdH0WU63umZ3+qz9VRaiyyQwspWJiKro
	9lIo/RBcTI5C4tA2AtI1AIeuon1YmSjhCXOZ6cGity1V2iNtFWp8Bc/9VpPwH2bVSWoFyuhJ8Ha
	SNOpgetSCwvzxOlavwq/CJ7rMWxNIiyKBCarKj92u+yVJ7fM4JMBUGymXivPdDEOiubIUSlsC0h
	zaUpgy7aEmfAqsgJAM/S8OhJGEmhPxsskEL4V/tviMhATpILpVDKAhjGVkWkExiyJpPfzkPOzGG
	QUmeuZKaKybJdxs4QCSkCjlaTYTJd7HbsZlODSR+cJMg1x3Jr1iIoFmDiMvxqLwZlXlFrG4l6j2
	pcE/z13NhVevv3TK1Am
X-Received: by 2002:a17:90b:2d87:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-3805252efcfmr1360590a91.4.1782793001895;
        Mon, 29 Jun 2026 21:16:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/10] net: emac: mal: replace of_get_property with of_property_read_u32
Date: Mon, 29 Jun 2026 21:16:28 -0700
Message-ID: <20260630041634.284127-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated of_get_property() calls with the typed
of_property_read_u32() helper in mal_probe(). This is both safer
and more idiomatic for modern DT API usage.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 99615c8a6c3e..82d502d576ee 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -519,7 +519,7 @@ static int mal_probe(struct platform_device *ofdev)
 	int err = 0, i, bd_size;
 	int index = mal_count++;
 	unsigned int dcr_base;
-	const u32 *prop;
+	u32 val;
 	u32 cfg;
 	unsigned long irqflags;
 	irq_handler_t hdlr_serr, hdlr_txde, hdlr_rxde;
@@ -535,23 +535,23 @@ static int mal_probe(struct platform_device *ofdev)
 
 	MAL_DBG(mal, "probe" NL);
 
-	prop = of_get_property(ofdev->dev.of_node, "num-tx-chans", NULL);
-	if (prop == NULL) {
+	err = of_property_read_u32(ofdev->dev.of_node, "num-tx-chans", &val);
+	if (err) {
 		printk(KERN_ERR
 		       "mal%d: can't find MAL num-tx-chans property!\n",
 		       index);
 		return -ENODEV;
 	}
-	mal->num_tx_chans = prop[0];
+	mal->num_tx_chans = val;
 
-	prop = of_get_property(ofdev->dev.of_node, "num-rx-chans", NULL);
-	if (prop == NULL) {
+	err = of_property_read_u32(ofdev->dev.of_node, "num-rx-chans", &val);
+	if (err) {
 		printk(KERN_ERR
 		       "mal%d: can't find MAL num-rx-chans property!\n",
 		       index);
 		return -ENODEV;
 	}
-	mal->num_rx_chans = prop[0];
+	mal->num_rx_chans = val;
 
 	dcr_base = dcr_resource_start(ofdev->dev.of_node, 0);
 	if (dcr_base == 0) {
-- 
2.54.0

