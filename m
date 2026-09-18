Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CF52B1F8
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765463; cv=none; b=KeZdXeO5ILvY20FvyJa8WAaMICh8BFc4eyb7DLTxDwwoixysgDh2gIwfpDaZxVU/JRBhEOaNbftKNSZT2izZG8r388rS7CG9mf/JDnfiWIEKRnvWShLlXX9myX8aTBXB+rsdSuRdTYq5f2NAC4uhaBX7d8GvbQCSzwq8TN6fKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765463; c=relaxed/simple;
	bh=ap6mMYNObT1SczRZXfJ0V5N4yS9olGT6nZuAWWh/WT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVmTKnue8kU7YE1kuZQnMRZuUE/krQlhTJqEv4gn4SISdwms6tR2PAPt3n/gxdZGs2hG7AAQpTxd7qHZ/GIkZ8IPn5yDfclZHCQGTQuhddwXmMJMmsbzltOPb20ZjRFAu2+i0tJPzZTfXEKJYd69HNfwPq6gg1tvwCNPArG2WnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4Uz3x6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4Uz3x6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC9F1F00898;
	Fri, 18 Sep 2026 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765461;
	bh=ySciVAgDXUsK0rq7K84A310eJiUJimWynGK3iCNh+5g=;
	h=From:To:Cc:Subject:Date;
	b=K4Uz3x6eKrgWG8JFCyXm18q2JXAdZcAt3oqo8YiuRfurNllBdM34w5fhGO+T85duc
	 Nfhgl2snZoH1KY8jDENb+MlxbA7HvokmsIt2WxjE70AePmT+haup6uj/py+PJXOuXV
	 /IcXvRAppRyPvHz7785t4Ug0+3ZktjKChmuUm+R4/THdeKrXOJRRh7tc1b/WHxDzbj
	 C/Aftn4J35H4fu59iAd3X2LXOquLr8hX4xzbI+NUk+sqEL0DFmkhd9DnsXzhRd/YuI
	 iYxR/EbPyg79ONvN+Bnu6qUUcjtzL+jXBO4jqZOJMT1ZaaclBzt7w7to5A3wLOzLLn
	 yqI1StEizZg+g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: opt loopback into instance locking
Date: Fri, 18 Sep 2026 14:04:19 -0700
Message-ID: <20260918210419.4088201-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev netlink iterates over devices when dumping queues/NAPIs/qstats
etc. and takes rtnl_lock or instance lock depending on the underlying
device. Currently even if all the "real" devices in the system are ops
locked we still have to take rtnl_lock for lo (only to find out
that it doesn't even have queues or NAPIs to report).
Opt loopback into having control path under the ops lock.

This is a pretty obvious thing to do, I've held back this
patch because we used to only apply ops locking on physical devices.
netkit queue leasing made a precedent for (far more complex)
SW devices enabling ops locking. Now adding it to lo should
not create much new bug surface.

I considered an alternative of adding a "predicate" to the iteration
primitive so that we can skip the devices which obviously don't
support given API (eg qstat) without any locking. But it's more
LoC and real_num_.x_queues is not currently WRITE_ONCE()ed so
it doesn't work too well for queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/loopback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1fb6ce6843ad..689ab853c2db 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -172,6 +172,7 @@ static void gen_lo_setup(struct net_device *dev,
 	dev->type		= ARPHRD_LOOPBACK;	/* 0x0001*/
 	dev->flags		= IFF_LOOPBACK;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
+	dev->request_ops_lock	= true;
 	dev->lltx		= true;
 	dev->netns_immutable	= true;
 	netif_keep_dst(dev);
-- 
2.55.0

