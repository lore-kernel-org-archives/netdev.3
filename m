Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC73C584E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524889; cv=none; b=bgM76XVesahQuGjwe+UVK0okBmFOYeQY0NxvlzYAh4cvHV3pz+jU+Ib/wehqApWZZydhNXFwFU9TYze1QaZpzeRDq2PcA61IQBjudBxt+bMeJBo+hgTjCIdcrL/AYWA8TScqRZAra8mGfZYo0g1+b+/NocfeB60sWdIvfXBvg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524889; c=relaxed/simple;
	bh=tE5akYm/0D5UPBwRUE4ayZR2N2EQweSn1OJl5iXnacA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5bqkjyT4kgKVWFyV2h+1XSxIBQbt28BdcLHA7JWiVCLcrocUtVRrrSESJhxql5fyzzTxcCt0jL7cfzVFbYYStt1CWU8uch9yjxIz7OYss1V7ROB5Krc9DuPxaGHiVQbcUXFIPVy2SsWODl/+w5YQt4s2TytCNH6/Yom++HPpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMSXlI5Q; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMSXlI5Q"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bf321d786so11912971cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786524887; x=1787129687; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2yIReJQdSxVH3YkEZxwA5FjXcal/zbxQ/3Lm7eNqUI=;
        b=JMSXlI5QhIkeqI1XAxVV3lBlYpl/jXSY/06RhMvtnuzHNDh8J2anTVvBsVDyDxEYPp
         pxoqfArqFAR6nIyWiqYCUmki1KaVIpjvAbFvcw/ZNxrvJL6lnP1tZhHZcPxk5voTiueJ
         pEjeaiqtKgUns6ADGvazKh6UGOL/9+RO/Ez5qbTzRPSHGIYRgxy3g6svMLZ7w5Uvbjz8
         2W1DOhGcvCZxgDOiRvux6r171uI1t5z588ZqHdvcH+gRdtclsejF3g86G/h9+ogdw+yT
         YZGNn7rU5EsW961Zi/gaUR78HlRXiGxs5zzXCbvyyHh3HaPz7igoH8jARDEve8ib1bF5
         zmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524887; x=1787129687;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2yIReJQdSxVH3YkEZxwA5FjXcal/zbxQ/3Lm7eNqUI=;
        b=ZVW2i4SJmSftXEvRQjDN5m7liMFHkbtqAbX6Lz7nXiL50KNCVSl4uMIufQDI39fxhE
         ojEZFdHdpm986xJmICjy5NdmBnf1HgB6VrBFg7NR8PIxOwmKdPdPH6dQl0YBjPFD1AWL
         UkIKApE9YxgzCNLHDqtoNhmbMcsLRdMmGcJnS721MIX/gZiqAL607e0ur4dvnx6krV68
         +jb/n3+5EwFuYgXPlRMFFTfcHjtqXTFRD3yXzQaB0ryhd8WeBADYQdYZosPO3QlmSCWN
         lH0JwMyAXrxU4/apVrPm3CpJGGpO7yoqutdZfeusG/35JSvP732BFtKPXsflmyIBeWJ4
         bWIA==
X-Forwarded-Encrypted: i=1; AHgh+RpLH+T/Q4nrCYdV/Vm2SdI0rXZz/btqj1KRFvrG0buegNvwMWW0hOKQGdcnOOthqKpcAL1NspE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxshGtDq439FoeAEPCQgB3itQ+1WGaHtWQgFD67uXas0y1vgLV
	AQRx6Q+l9nrMJWq3T9FHgyLtq856qis1BWi/yH4SnhiOpRnjtij8YYp1jQzlmz0H2/++IB+s55j
	rIMIftGCgOT4ySw==
X-Received: from qtqv13.prod.google.com ([2002:ac8:748d:0:b0:51b:fdcb:cfdc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2d5:b0:51b:cdc2:fb99 with SMTP id d75a77b69052e-52d647a2fbfmr24767891cf.24.1786524886549;
 Wed, 12 Aug 2026 01:54:46 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:54:40 +0000
In-Reply-To: <20260812085440.3917924-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812085440.3917924-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812085440.3917924-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net: add READ_ONCE()/WRITE_ONCE() annotations
 for dev->prio_tc_map
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Concurrent fast-path readers access dev->prio_tc_map (e.g. via
skb_tx_hash(), netdev_get_prio_tc_map(), and qdiscs) while writers
update entries in dev->prio_tc_map or reset/clear the map via
netdev_reset_tc() and netdev_unbind_sb_channel().

Furthermore, memset() in netdev_reset_tc() and
netdev_unbind_sb_channel() provides no guarantee of performing
atomic word/byte stores.

Add READ_ONCE() and WRITE_ONCE() annotations to netdev_get_prio_tc_map()
and netdev_set_prio_tc_map(), replace memset() in dev.c with explicit
WRITE_ONCE() loops, and update direct array accesses in qdiscs to use
netdev_get_prio_tc_map().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h  | 4 ++--
 net/core/dev.c             | 6 ++++--
 net/sched/sch_mqprio_lib.c | 3 ++-
 net/sched/sch_taprio.c     | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index db0002bd68f90fa4dd087edabc11549bc8ee0f66..de307c01d33eb8835bdbe32118c2fc086e53a51c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2671,7 +2671,7 @@ static inline bool netif_elide_gro(const struct net_device *dev)
 static inline
 int netdev_get_prio_tc_map(const struct net_device *dev, u32 prio)
 {
-	return dev->prio_tc_map[prio & TC_BITMASK];
+	return READ_ONCE(dev->prio_tc_map[prio & TC_BITMASK]);
 }
 
 static inline
@@ -2680,7 +2680,7 @@ int netdev_set_prio_tc_map(struct net_device *dev, u8 prio, u8 tc)
 	if (tc >= READ_ONCE(dev->num_tc))
 		return -EINVAL;
 
-	dev->prio_tc_map[prio & TC_BITMASK] = tc & TC_BITMASK;
+	WRITE_ONCE(dev->prio_tc_map[prio & TC_BITMASK], tc & TC_BITMASK);
 	return 0;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 8ffae11d272e979bab5b64f4d912d3d97f738d48..d52285ac01a54fdafa63703f1af134e19d028ffd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3124,7 +3124,8 @@ void netdev_reset_tc(struct net_device *dev)
 	WRITE_ONCE(dev->num_tc, 0);
 	for (i = 0; i < TC_MAX_QUEUE; i++)
 		WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
-	memset(dev->prio_tc_map, 0, sizeof(dev->prio_tc_map));
+	for (i = 0; i <= TC_BITMASK; i++)
+		WRITE_ONCE(dev->prio_tc_map[i], 0);
 }
 EXPORT_SYMBOL(netdev_reset_tc);
 
@@ -3172,7 +3173,8 @@ void netdev_unbind_sb_channel(struct net_device *dev,
 #endif
 	for (i = 0; i < TC_MAX_QUEUE; i++)
 		WRITE_ONCE(sb_dev->tc_to_txq[i].combined, 0);
-	memset(sb_dev->prio_tc_map, 0, sizeof(sb_dev->prio_tc_map));
+	for (i = 0; i <= TC_BITMASK; i++)
+		WRITE_ONCE(sb_dev->prio_tc_map[i], 0);
 
 	while (txq-- != &dev->_tx[0]) {
 		if (txq->sb_dev == sb_dev)
diff --git a/net/sched/sch_mqprio_lib.c b/net/sched/sch_mqprio_lib.c
index b60e130c70781479eed0ea5a02d01197f03f4895..888935e34d4381f85aaf4c97cf9c4bacb93e13f1 100644
--- a/net/sched/sch_mqprio_lib.c
+++ b/net/sched/sch_mqprio_lib.c
@@ -105,7 +105,8 @@ void mqprio_qopt_reconstruct(struct net_device *dev, struct tc_mqprio_qopt *qopt
 	int tc, num_tc = netdev_get_num_tc(dev);
 
 	qopt->num_tc = num_tc;
-	memcpy(qopt->prio_tc_map, dev->prio_tc_map, sizeof(qopt->prio_tc_map));
+	for (tc = 0; tc <= TC_BITMASK; tc++)
+		qopt->prio_tc_map[tc] = netdev_get_prio_tc_map(dev, tc);
 
 	for (tc = 0; tc < num_tc; tc++) {
 		struct netdev_tc_txq res;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 18fcb4e78456a2f74fa5d3465175d100a39575b4..39ac5b97aa3af83fe63ab5ff9173c39700f6bbb0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1813,7 +1813,7 @@ static int taprio_mqprio_cmp(const struct net_device *dev,
 	}
 
 	for (i = 0; i <= TC_BITMASK; i++)
-		if (dev->prio_tc_map[i] != mqprio->prio_tc_map[i])
+		if (netdev_get_prio_tc_map(dev, i) != mqprio->prio_tc_map[i])
 			return -1;
 
 	return 0;
-- 
2.55.0.679.g6767b8d81c-goog

