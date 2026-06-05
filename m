Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F552264C7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619385; cv=none; b=KtoO8M2h0XQdQ54/TvhagAYlDS72MT8WphzQXzheGkJYlUKroG7PCk7PnOj5Ta3Av5GD0PUEnZJev1LwY3Fo303VtoLodzD5ph0HOLT/j1Z5zfX1S4TRUlhaW6QbfPR9cme6A+DmRudiBOHvqqiRfUtZlH9QmDsAYap8y1qP9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619385; c=relaxed/simple;
	bh=v0AHUVjdQ3xnE+kX4akkAvk+cfvNqacdr1IjByuQCUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5iqZO60Q5PsKh2G7Z9kPXlvQUnEA9qH58ODkwh+eWJWi6ugyKxDJH9ZboLUe3rU89A4lugt14B1qMgEPPVkPvCogBc4E/M8EW0GW7MrMRFOPnoBP3244Z2yTjSwPhFhfHk9TSlee4uytPSlYdnBhB3aSwuWZ7CgIPt6N7oySAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCiEhRQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCiEhRQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E70A1F0089B;
	Fri,  5 Jun 2026 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619384;
	bh=Og3Ys3Rb98/rutdlhVH60kIpEyGcQjoMYEplyDyrzIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCiEhRQyrbBHCscoe/9JPHY6VZNrcrBLZhsiuQDk5VML0/CvlS3O/SLKM2pdsceDt
	 w3Tj+d0D8jH4K3WscUNL/X7KjnCRFzGVUlyFqHaTD9PS9ev+2Df2hx3OzTJVtfwj//
	 RLJPYob52hhXy813LouInHxzHVDxKtMX5AUele2DaE4Vl3g59Wu1nUWutynSNYpvtG
	 B4wciAuWREUpCrddrKdE1b2GlSpVaAiob5OVE+jBjiDk4K1yK/oW5HIQK8XRi/LMGM
	 jHeyduCaVhNX4lkSGqrJEfPYOYFSwUhKONlXPwASiKR+7jhzkZF/4L11Q48HpnE/AH
	 RSQRk8vbBnN6g==
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
Subject: [PATCH net-next v2 09/12] net: ethtool: optionally skip rtnl_lock in RSS context handlers
Date: Thu,  4 Jun 2026 17:29:09 -0700
Message-ID: <20260605002912.3456868-10-kuba@kernel.org>
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

Skip rtnl_lock in RSS context handlers if device is ops-locked.
Fairly trivial conversion. bnxt needed rtnl_lock for changing
the main context but looks like additional contexts are fine
without it.

Note (for review bots?) that ethnl_ops_begin() checks whether
the device is still registered.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 65bad23d5c59..d8adc78e3775 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -2,6 +2,7 @@
 
 #include <net/netdev_lock.h>
 
+#include "../core/dev.h"
 #include "common.h"
 #include "netlink.h"
 
@@ -468,21 +469,16 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
 	struct net *net = sock_net(skb->sk);
-	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
-	for_each_netdev_dump(net, dev, ctx->ifindex) {
+	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->ifindex) {
 		if (ctx->match_ifindex && ctx->match_ifindex != ctx->ifindex)
 			break;
 
-		netdev_lock_ops(dev);
 		ret = rss_dump_one_dev(skb, cb, dev);
-		netdev_unlock_ops(dev);
 		if (ret)
 			break;
 	}
-	rtnl_unlock();
 
 	return ret;
 }
@@ -1037,8 +1033,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto exit_free_dev;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -1125,8 +1120,7 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 exit_ops:
 	ethnl_ops_complete(dev);
 exit_dev_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 exit_free_dev:
 	ethnl_parse_header_dev_put(&req.base);
 exit_free_rsp:
@@ -1179,8 +1173,7 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 		goto exit_free_dev;
 	}
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -1210,8 +1203,7 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&dev->ethtool->rss_lock);
 	ethnl_ops_complete(dev);
 exit_dev_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 exit_free_dev:
 	ethnl_parse_header_dev_put(&req);
 	return ret;
-- 
2.54.0

