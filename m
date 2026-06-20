Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610611A7264
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781943674; cv=none; b=qNc8/kwR7he4w7okuS07Jv/2TGjnbXYSWTkViLvfK8plgXCqWp+nDzpeLXi+JuuvuTQo2gTeKOwS09d8aKhhCoJ1LuDEA7G0s+OrU113souJ5Wztiwvd8ZxcpgssEu6Mu69Bz90sajvKGi+OA4ScvGrzUq2dbKNk399+1D1eLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781943674; c=relaxed/simple;
	bh=0RN4xgvlR94K56zWo+x69Bv/7MNdIjCyjpTscNmF0y4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fkZi6g/YjTL1OwPMYMyvLxJrgaA7FS31LqQUgAxjFRrgMXs3UPs6CdZj3BS+8SA02otFBBWcHdMbELUtzfeqW+YNj+MiH/fzBBdWtXJgpbCEMToWE680HpFvZ6JWZzUHIsEarGMg1eB2Fh5f2N3WA1f8qr3Juy5rTmWgY8AQj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ8gJI8y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ8gJI8y"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1100945a91.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781943673; x=1782548473; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uZHSWLvj9OPXqYMo+gcDi1m2qcLBOu8zkp0WPfo48s8=;
        b=JQ8gJI8yJUVTjrEuqWqwFjcwGYpp9s85FkLdfk96F9vhJqhVV/Fkm1/sV/f0a1g4Ex
         P9zhfMsERQPbekt0qFqv5MtsAsOrx9l9v5ms0/+kxqVBQeKL+g6LWDIMZYdP1aPeBqjv
         Jyoi5upogqT9jq0N1oveBYNB2DoLE0H7V9j58d0EmV6XRzkYMx45497TSf2iOHGxjZH8
         0Kx5nUJhplszW/u9Jrhtofn6F6Txr3bkvUla67bs8BoCJdKJV3beY07gV3DpRD/dBTt9
         QHXTivdfMDCZ9t8WQdudUwO/VxieXWG9VyoB7i9U3rBmYY3Mx+1FsXhL1ufd8N7BdoL3
         7XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781943673; x=1782548473;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZHSWLvj9OPXqYMo+gcDi1m2qcLBOu8zkp0WPfo48s8=;
        b=SOuyjC+fmQltBUTWe/Gj4yRe9Di3D9lXZvceQnEtUwm+TmqW1HHh/l0+C/HTruy6+l
         N1OanGJanDCOxJDJzcq+VYhK4a0nSYfvctrnDhWg+JGqBv3IGT5DTt0qzItaXi4wPaSa
         VXL54RXAzHlEL1IDKCoU5PcA3jnMAJv76kBppNbGuGr/RMI/lXn6vo+9sMbSi7yaVrxV
         sEi9E/icXdYZ4BHUjghQU4Gg3CTSLt25V6Pd3SBxG8Pv7m+ZMNC4VCvIOt1ktgyBRXrw
         18NRAGbj+4aZezmqBiF+b/rMffF/sna27Ggs28smzUb4qeKz+CLd55ULefyUdhuueKkr
         jBxQ==
X-Gm-Message-State: AOJu0YypW639zIKqXKa/j/uzniHOBS1SZZGZXU7tS75PUoC8Ussb3sVT
	bCUleE6LhB9/hDwlptha9j70V2LlRyC7l4U1jyQMrV3ub9n1Sv2wGVUfQFaNBX01C+FaIg==
X-Gm-Gg: AfdE7ckXkONQcPOmdK5NfhYmypzCG67olLaV/Xcxds9o18uLHnCvwlzTBUJt0hvWOqC
	fzWC1j8/M0QuxDj5wUDo/ItSEEmTIj9mRroUUU6oHvssG02oumcZ8jceV3834A5X+INmoa0Yr3d
	f9x6vuhNf5O+o+d0LEEvqeG8ehyFpUe8Dw02Be0N7Tkw1rfjrvI+6ftfoyVPV4g4Hr6SVKugH1O
	vIFwJn4WU8keQsAzikX6srQa/Q9EYwUxWqvBmIjQMQXCOHC2n6MEvrBHJT6d1FEAevqVaDcJoMC
	Q7eFGyF5uD458I5c4LNP52p/ypbNCsi0f1rtadh4FTZYC4GkH8DuWGB4JK0N2qClOfXiHCVvuCZ
	MzJ32rALVAQ+Rk7UX2G1FYX5a/sjHOiyHSvzWORL7QEiTvUO0wyi1JkVRQtPWX2C/JVRtnOiX3y
	BMP01tKg==
X-Received: by 2002:a17:90b:5884:b0:37c:806b:3ca7 with SMTP id 98e67ed59e1d1-37d4d71d969mr2357014a91.3.1781943672584;
        Sat, 20 Jun 2026 01:21:12 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bbffc2329sm1786971a12.0.2026.06.20.01.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 01:21:11 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Joe Damato <joe@dama.to>
Subject: [PATCH net v5] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
Date: Sat, 20 Jun 2026 16:17:44 +0800
Message-ID: <178194366700.2485734.5368768965976693502@gmail.com>
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

The "- 1" offset was a leftover from the ETS offload implementation
that has since been removed. The correct mapping is a direct modulo:

  queue = skb->priority % AIROHA_NUM_QOS_QUEUES;

This maps priority 0 → queue 0 (lowest), priority 7 → queue 7
(highest), with higher priorities wrapping around. This is the
standard Linux sk_prio → HW queue mapping used by other drivers.

Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
Link: https://lore.kernel.org/netdev/178185573207.2378135.3729126358670287878@gmail.com/
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
---
Changes in v5:
- Rebase on net/main (previous version was incorrectly based on
  net-next/origin/master, causing Patchwork CI apply failure).

Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..3370c3df7c10 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2110,7 +2110,7 @@ static u16 airoha_dev_select_queue(struct net_device *netdev,
 	 */
 	channel = netdev_uses_dsa(netdev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
-	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = skb->priority % AIROHA_NUM_QOS_QUEUES;
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
 
 	return queue < netdev->num_tx_queues ? queue : 0;
-- 
2.51.0


