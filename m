Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4F360EEA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613744; cv=none; b=TMXMCBZV5ZqyX9m1bJsbcU80a6ZBOUzuWOBAERX7/yLWr8YPmqqKXVovVIsBCF7Tn6HlJXrbafRa7oLAucpx7DK0peGGrvxVYIUexw3ncsfBgXiXxadlTP+cae4A1ikjDhoZKoVIoniYVVFOstOtbA1bObWHW18ezvtAyvvgQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613744; c=relaxed/simple;
	bh=hH0oRwMftoRPG/+KR7O9epoqDsjpP0ySNJo81UC5ZNA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cdshqnhpZgndhuWSCKS9DMvsw3Ia+x2dEKWTFxH4eGCbE1bdQFWZYkbJO702lS7d5hOAJEMt0eVaDs5DS3ok81KjBS2P379AcWuC9mvlH+InFGnyqfmO5PHR5C+9+bxwco5bR9+QNe27VgQtXEM5+EYVB8AVQj+QASPg8fBdHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7uyUq+C; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7uyUq+C"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2247e38eso40939945ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613742; x=1782218542; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6uM0ObpaAPGFXgDRAB4wX+6R8VKBvIYPs4Db/iskdHQ=;
        b=M7uyUq+CriAUmO+EipGnPNO7Au3Z+lBVb/BNZ//QztzHN3dsutEraIYIZPSnIWLShp
         fc5TswMzEOaIl4EoLLs5UtGcEh1sELCMUJXzy0ZTvmI+rj9mpw/WPlgk/SQKYWVPzjVT
         nwl0tCBBLcGv1f6VPzyQRgzwHWCLHBnI1tUMCD/WPHme4AssZWNNGCentj2co7cY+Xd9
         JO/sK5qY2rSJmnzeejB1rFfCwuoa/ppiKwxyl9MQ4oTX9ov5ciMDrU3KmCn6gUtLV3Tb
         p3f1hi53apNdKdm2pBujiAretawJuExUC456fDOLm2pZ2xYyXCIkWKTPDFfthu8RAzu8
         zJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613742; x=1782218542;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uM0ObpaAPGFXgDRAB4wX+6R8VKBvIYPs4Db/iskdHQ=;
        b=rTN5xymkvrZPFU0Ps8xHglSeUO5+9LiEbX3M7Yjh+DcJQIJZSiPBfzoyUrgiUxexY6
         hoSKg00CuXrjRKF6PsMTmILDOdLSwjI3ziXBJwNP0XYnBi9pz9PAPw+X5KmHagL1J0bM
         Vcu+Z074204eEIS32bUn3p2LnVCfSaZWVBG0U+xbO6uHZKVXcB1d3vicpSkk2kwp5ngQ
         wSqyqXgwAgDVBAWw8uVH7NYJLXVJWMIWa+mZhUE3ldDwvLepuYjNTJ41LbjgxTzIrUO1
         zvlVxm8PEh9WUV3fNr2QgPuPNYLNyIO/XusLlxNhB4o4hJN8ku1ttJuXhF8gLyBpJ+tg
         56aA==
X-Gm-Message-State: AOJu0YyOE6iX9G2EeoYVOBt/y6/h6eJzcBtuOUZUAzbDc7TD7tB8ejZ/
	WnpmSzIMagX/oEoLnl6HgVC9NveZDPnQefFYqJ5rAhdCcuNcPY8kuw0pWQRyCOwwUcAsnQ==
X-Gm-Gg: Acq92OEWKSHxZcGwIRUlDwZ7XxugYABrADbEBdaFjpFxgLueUrHva+tmrp2H9HUcF6s
	LsoBk/97jpxVbb8impUNUT0B67iDglk6BvrEZTCHEO3WOxEXF1GjLGt5TxOFwH3kqudMHmhH5dh
	nPPzp7SkSQ6WvdFJD+cBkQuY0epL+nPVzdBp3ErTjKySSoljaCWorXLtrzQHbmmPXiURpsYq4ei
	KECBo1Ua15a/NqAKXOGIgqhRJemPNvqe7tR0o+/lz67/UO9hwp2bG0Jwm9JvTUesUdUj2Ujo9FP
	Q55tawS4kpfWk23nwzBT2q7KgdSYgncdbIFp/OapuHIRJjN1OabFnKPYwmwoXOvWykkBC48Y0hc
	AQHepfblm2+GfjBAsMWf+zw4xGiupHiQl1LFS82lcx0aIzPLddLrGQB1p/5hNZT9gs7t2KfXPiK
	pN12pdCDD5ZNjsnZDa
X-Received: by 2002:a17:902:c944:b0:2c6:9448:363a with SMTP id d9443c01a7336-2c69a1731b3mr37365455ad.20.1781613742538;
        Tue, 16 Jun 2026 05:42:22 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb50e5sm135274665ad.35.2026.06.16.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:42:22 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net v3] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
Date: Sun, 14 Jun 2026 07:30:54 +0800
Message-ID: <178161373805.2167512.2544164327472822616@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

In airoha_dev_select_queue(), the expression:

  queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;

implicitly converts to unsigned arithmetic: when skb->priority is 0
(the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
and UINT_MAX % 8 = 7, routing default best-effort packets to the
highest-priority QoS queue. This causes QoS inversion where the
majority of traffic on a PON gateway starves actual high-priority
flows (VoIP, gaming, etc.).

Fix by guarding the subtraction: when priority is 0, map to queue 0
(lowest priority), otherwise apply the original (priority - 1) % 8
mapping.

Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..d476ef83c3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1933,7 +1933,7 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 	 */
 	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
-	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = skb->priority ? (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES : 0;
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
 
 	return queue < dev->num_tx_queues ? queue : 0;
-- 
2.51.0


