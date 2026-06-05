Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838423AE62
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619383; cv=none; b=ff/qX+RhjYWsV6CnCLuS520nlwRqgzkLPlf6BaW76z8JbcvSAZM+69oTMvtAbXBwUrWlSOLt0O3pXhNdCkcaucYhFGy7/ST39AV77nP6m18g5/klqJcHad1t0qk7FHoYFhSmK/RIu2T6S2lsjwHkTJEdvY5hAHrZIkrpsXqeDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619383; c=relaxed/simple;
	bh=0wid0A1WEddsxRmojrquvMvKMMDVKTOnKlJaFTHZbSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACB3je6RrS2HK5WnM1ayfMeng7H/coBjTLyMclTZEt7J/XKP3dhH5EAsRIudhwAI8/VuaBmKvQgnKua4g4TinLSrzGJ9QrmILRUXFNWTnnQE8/t3Qb1LJVMrqDVl/tdI/cfp/QyfqmA6K1lHHvMfeTDM8FBUWzVLuqIwek8uFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUSpwn6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUSpwn6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59651F00899;
	Fri,  5 Jun 2026 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619382;
	bh=Am0LcCQo3hex/flMBZ8cx5LktRiogWaGlPeQ36V8VDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hUSpwn6PJV85g9X6n1G0ab26EfS6eH7JLUxkBysXu3BfUVvJkXJm65CrkLMfvZuSo
	 PEvgmaqma2m409zvquKfQY20fXs/8JnZPZ+tr1FGhUjcO7cqodmrmbqn8A0aN1FDE+
	 3jA9MS0r+Ed9j3nLEPBmcprAvP8CtSz6GcMaGQyYJZvd/R4xqUtUPA9efOL7wXGEyi
	 kg0ssJCSoR9X9wm7jbXhQw5dHP4svPoUrXC4IZVaOeV3lFGXxcvzEcRaYjXS6VQhb0
	 vJSwihpIMo+zxk/XRWNXXwdWAHUOPxhQOzwF71NbKfPCNUrWmwyIFy/rtZwru33+XF
	 9BFdwcCWy5KrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/12] net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
Date: Thu,  4 Jun 2026 17:29:07 -0700
Message-ID: <20260605002912.3456868-8-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethnl_tsinfo_dumpit() iterates netdevs and per-netdev PHY topology
calling ops->get_ts_info(). Switch to the "ops compat locking"
helpers which take either rtnl_lock or instance lock, depending
on what the device needs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/tsinfo.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 14bf01e3b55c..c9b680a9cc3f 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -6,6 +6,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <net/netdev_lock.h>
 
+#include "../core/dev.h"
 #include "bitset.h"
 #include "common.h"
 #include "netlink.h"
@@ -473,28 +474,25 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
 	if (ctx->req_info->base.dev) {
-		dev = ctx->req_info->base.dev;
-		netdev_lock_ops(dev);
+		struct net_device *dev = ctx->req_info->base.dev;
+
+		netdev_lock_ops_compat(dev);
 		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
-		netdev_unlock_ops(dev);
-	} else {
-		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-			netdev_lock_ops(dev);
-			ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
-			netdev_unlock_ops(dev);
-			if (ret < 0 && ret != -EOPNOTSUPP)
-				break;
-			ctx->pos_phyindex = 0;
-			ctx->netdev_dump_done = false;
-			ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
-		}
+		netdev_unlock_ops_compat(dev);
+		return ret;
+	}
+
+	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->pos_ifindex) {
+		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			break;
+		ctx->pos_phyindex = 0;
+		ctx->netdev_dump_done = false;
+		ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
 	}
-	rtnl_unlock();
 
 	return ret;
 }
-- 
2.54.0

