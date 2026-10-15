Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBE3DAAB0
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040836; cv=none; b=X+ONyjc+e3/KKXaGa1mxVLDOKKqWpSWrO+fgT0t6+019+KcWIFjM/31m7VRh/8lkIbaYTv6CuvWrHJdU22ONpmnS/oPtugpoAxLPSkpVJtsQ2bwfGxP8O2X5D2zBihle2l6tc0xgEC8A2K1ZefOZO8ZReviO9fZCK/i4EayVloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040836; c=relaxed/simple;
	bh=4laeaYnyM82VkcLLI0+4iJvrSAWDDWZ+kak0dp7QhoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaJYQJ3weXP9TNw6lZM7t2up4h0Wz+p2iP2dFONimLeecK3FuGWSFZJTEjPHZ5Zz71vNZxBWmuOGYeNWs5yqBmrRKr0F61LDlSiDdxQ2tCjGlRC5WmKj6pQSs1+l/4sndfNTTrbX5OnETwIdWvvKWcmxHJm2Ckjj9yx1nfMcbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0td4gQK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0td4gQK"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso750360a91.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792040835; x=1792645635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RG483f/vXFgd+W2LD/AsmPv9HxoY1L8OX7tqUMO6Cp0=;
        b=T0td4gQKEiTmfqZ8oMoVvo/cv1CVno7rbOSroMIrA8UjJvKDR2PTsjhH+US4J6UmbV
         4YeJcTELQ/Yt0OVsgkEqZjbraJKPiEwI6/AAUYoy+IydgK8Ti3l0ua+I5mg92RrOXvPn
         ELr/7ioisvgg8RJ91SYHcydOB8uV6qqWph3XXBjgN/eAg8gukf5dYS8dYvjzp6Y395wn
         RxUSM80C35QTY99072S3VeSsjuao42gPZP/nEKZNQ+faGycVLSntlAqO2QZ5F6lPCC/o
         +lKXAVWldKuPa5cFaeMbLmSHSbl02/llKyf+TP5fyKrd1FLbnwMh82ouc6SVnlzGopBg
         Uwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040835; x=1792645635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RG483f/vXFgd+W2LD/AsmPv9HxoY1L8OX7tqUMO6Cp0=;
        b=Swv24Sxs4qS05uONfpGR5G5LVkDZjtHTLOOKAyspSLsa+l4RBzCOtCThTh9O0CLq0R
         A9ozGVCosR3enWSi+ml45ekWSSMQaBkOWdGlNv0g4dbj61DhrvcrVHbLPjBlD/YVezEM
         TfpprT1pev3FweD2d1yvc0VXOXQvDXZxpAemaABjeI3VhPCvV8hVKIvqE5kt7Zhd6Z1e
         pZZqkt9pVvauOOzlBGN8GYwda53t5aVHIOJRRdwiD+wx6OCBeAmb8CyS5ZxSosHDSWDv
         UMsHC3n3nLEnmVWhz+ocrI133VHl9WW2m9TFej/RzSrwudMUA17kH8TQnMMviZR9KaEt
         pwSQ==
X-Forwarded-Encrypted: i=1; AKwUvByvkLau3MeMhGPb+hIzUeuMOp0Nb8U57N7l22scrDWu6vuQjIpLTt16c1cSkNwJ99MVfzUpgkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZWe4kI2vJ2zytClDZrnUyGViNSVOUYm7Zgp+fbpjUHNQiSyFR
	7cPKyW2a6ikGXqK/ZQRakQzWU66KIcAKO7+C/0D8wegQPftp56LTSf1U
X-Gm-Gg: AYBFou1O02+BjaFRe6yjIlIzFDDvZcfvWvACg8eInqZthLI9U7ue40pLWtNxSH733Pb
	pS6qqSAUwJ/7ibEgWxz5pN/khcXMy4k6yza8lw9BMzWvSQxiLgixs8Rnr0FAc+Md1x1FcOL8PAk
	8K+5TLyP8bgIY0pNGjM3EnVTq3gNiH3JM9yCnDPPgZrD0a9TtoQmtzHYVd7SlI6fnizCAUbaJHC
	PDtIoyIDvCWpyVGXX0o5dAzxr7ddWRsBbnfbufRlDRfcGq+FnS9GOYsztDRqmXKjzmK+SzC3R13
	tyBLtetp05vvTmpwVzJ3mhIYjIBd8QzcPNoSi7TjlJvCBFjb8xxZ7CRmW3qWAs8M52HcfAb6IeS
	QQlSlnbuKXsWfrMbN0fTRc+Yf60hUELdJeSHACugytvDEyI6VqEZAqCbR+241GlSLthQlMKChp7
	tc/82mgQISdrmYoem6zURr1duPVdfaOUy4YSO8542wjG//hdyq+wlYjqk2RG4fJXmrX3UZpZRo/
	oOBm/QNc1Q=
X-Received: by 2002:a17:90b:498c:b0:3ac:9176:e81c with SMTP id 98e67ed59e1d1-3ac9176f12dmr1864528a91.46.1792040834893;
        Wed, 14 Oct 2026 22:07:14 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9449ae48sm2548033a91.13.2026.10.14.22.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:07:13 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v4 2/4] ipv6: serialize address publication with device teardown
Date: Thu, 15 Oct 2026 14:06:49 +0900
Message-ID: <20261015050651.1841557-3-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015050651.1841557-1-4ncienth@gmail.com>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_add_addr() checks idev state before allocating an ifaddr, but
publishes the object later. addrconf_ifdown() can mark and detach the
idev between the check and publication.

This happens when a non-loopback device MTU falls below IPV6_MIN_MTU. A
forced interleaving published an address on a dead idev, and
ipv6_get_ifaddr() still returned it after teardown. Later device deletion
remained blocked with:

  unregister_netdevice: waiting for ac0 to become free. Usage count = 3

Protect the dead indication with idev->lock and keep that lock across
both hash and device-list publication. Recheck dead before publishing;
if teardown wins the lock, reject the unpublished object.

Non-unregister teardown does not set dead. The preceding change covers an
add that misses the initial hash scan but reaches the per-device list
snapshot. Both changes are required when backporting this fix.

Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/179161099408.434549.14449036924552933828@kernel.org
Link: https://lore.kernel.org/r/20261012145306.GB779501@shredder
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/addrconf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 72d7df23f79674..3bede30d4e989b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1168,14 +1168,18 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	rcu_read_lock();
 
-	err = ipv6_add_addr_hash(idev->dev, ifa);
+	write_lock_bh(&idev->lock);
+
+	if (idev->dead)
+		err = -ENODEV;
+	else
+		err = ipv6_add_addr_hash(idev->dev, ifa);
 	if (err < 0) {
+		write_unlock_bh(&idev->lock);
 		rcu_read_unlock();
 		goto out;
 	}
 
-	write_lock_bh(&idev->lock);
-
 	/* Add to inet6_dev unicast addr list. */
 	ipv6_link_dev_addr(idev, ifa);
 
@@ -3897,7 +3901,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
+		write_lock_bh(&idev->lock);
 		WRITE_ONCE(idev->dead, 1);
+		write_unlock_bh(&idev->lock);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
-- 
2.55.0

