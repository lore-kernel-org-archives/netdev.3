Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20A234964
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393607; cv=none; b=U95+kQIyj0IU0PWfDtfH4UHkk+akF5Fq6COGFYte8i3+YoLURqTA16CI6P44/B3BWloJHzQrPaPHTBzghP6wn+oOq0twbnTjImK/nJVHyIbKCqSFBYKJbrL3EtMLeNKQGPdraNJP+MOEuSCCNAjrxST6/SuaHZDGCgM78TuknpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393607; c=relaxed/simple;
	bh=2z0NoZg/hCzHGRavyFL5mvpAZmqcn2LtOxQATyqpcj0=;
	h=Message-ID:From:Date:Subject:To:Cc; b=f2HsLkPa4ub9R9aXEnfNV6VC9yQi7IrX0jUbO8s2p1jMRpkp2vlSMqeOA3O8t0GWzvDr2wOD9qFXxZ+reBQpEex0bBXPSXUxDSIOhEf0mTM/ORDdAz2+OObsJfXGDrVhiRln9WYCW8yyojur/r8gXVxH0hH70UoPvU8lvaKu/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPf32wAd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPf32wAd"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1356417a91.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781393606; x=1781998406; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG/JEc/L0uDc2VwHJweRU+2vbGpFb8TCmkW2psEcnQY=;
        b=qPf32wAdzPxz/vIbRMBwJ9mcdfDjOA+RQ9KVl/oKrjsxAElRL5fO1nethw0GMFOij2
         JGVO27n80jnqq8mcHhLkKJUX56cogVhzK5iis1lbLMhxK2unO3sw2A4WJ+L/X/GbebIe
         HOC5JwoE1UqI9aMkU15ac/V3fKBuaU7AYQ+ZUFgUgMk7A1xn7sRXW8cn1BcD4sJuUhC1
         tHqnASac1JkLdZnhxKVQ1IdlzKYkkIKzem/23AKFUdqYM8411EUGDh2atVExFiU2oXPM
         shaIPipD1BdCBBT6betMggcA0ihKfh34TO1mA/AGLM5ae4fYxA6AXuMOaP3qssBiIyd+
         u0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781393606; x=1781998406;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AG/JEc/L0uDc2VwHJweRU+2vbGpFb8TCmkW2psEcnQY=;
        b=po0VnKOqjdc6/DKhHVpIk9ZA5EYhE5tl65XZ65kh0burl0aTjLBIFo7c2M6mQmzsj0
         C2fe6m+ebqFoccJC75XZ9zAlihdnDgMjA09R7LiWVmtlnbcFDSFVWtYDUhHyddVKb/QV
         XWGvYYdK/TTZnV5gjxUnMDVIU3p5xMs7ffFjQesVAVCCtijO8XUKwfl/w/kdXwx+dUYf
         c8GsJx4m6PtB5QPqRBCUrl1C1KPDdzCt1l/Fky3wS/t1vlpZjvsxNVIz+YSV84WYcvYS
         Hv1Gk5JfKKkoDBB14G/Fo1n9o7MgUahDY/C8UGTZwka7E6Pm0YWnrkKSb3xcKt4CQheF
         kjbQ==
X-Gm-Message-State: AOJu0Yy8+61Rj8gfRoFLrAOhH07DZVNlZsmdBOiMt48DNkl3e4TCojds
	YB14qjcONURu8DfRhSRL2+Pgb65SbRadYxXwqs8xs56dt8D3S2yCZQfbUoLBpSfewjc=
X-Gm-Gg: Acq92OGIdEjNIC/bpSmBwCmNBqHZtTxOuWBehjwjUpW7N0xCDlWhtu7sZkitXvSqSED
	ifzFfl91sTBQIDwk+4K/V7VoRbfuXB/nM3Fppl73TJjom1tLmY9vOsTFm/vpsj10P7LNA28vite
	e12WO35A/b6K015rFZOZ4Woac1iX245oZkEvCFpOBaZgjz5cH13RrYnORqUI5yd3fvUQ2gNrB8A
	/kt8baLu1Xtm60fZdn1AvtwU2teyzJN92ph0zMO/+In5Q5Rm9yH4lt1bx9bnl/JE3KowrNAv/vy
	luyYIED+WAbU6ri87xOWEyBxtT3hTODi02i8HMj7fR5gWjn0/cD9F/b5C9/69g1DIXgIg54CyBc
	Gw8Wgml3jw2B67qxZ6EtLjsK8F8z0SD+fDtElX5MyUtHWhuoP6IjVCv+yDEQQrAr9pHrrr/AyB0
	/z3eoju9NdRFfuzRFZ
X-Received: by 2002:a05:6a21:1519:b0:3b4:b26e:bab2 with SMTP id adf61e73a8af0-3b783b22db0mr9105274637.2.1781393605822;
        Sat, 13 Jun 2026 16:33:25 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866519f88bsm5126208a12.27.2026.06.13.16.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 16:33:25 -0700 (PDT)
Message-ID: <6a2de8c5.2c570c9e.53b1a.0e1b@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sun, 14 Jun 2026 07:30:54 +0800
Subject: [PATCH] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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
Signed-off-by: Wayen <win847@gmail.com>
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


