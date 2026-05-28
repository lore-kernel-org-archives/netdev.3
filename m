Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEF36F8F9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010219; cv=none; b=iFKyKPb7rIdB9FYb0cHSz9WjHoSmNUDBcqlHu7OWJRYb5/H4jhy7BBvD1TIPxHiwziWH7pcFwLdgI/xq0iZ7Ys4QnYXC9u0W8kAOePC1Xn3M3YogaRF1dkXNAoKa6WgDYCWXEkiL88jsc9PjH2eb9xe5yvbk5UGsnoBS+rFQXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010219; c=relaxed/simple;
	bh=v0AHUVjdQ3xnE+kX4akkAvk+cfvNqacdr1IjByuQCUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNcosO6gJ6NAycp+h09TAsAVQVGgE7MifeU6Vp6bFM/Cn8q4W8ezZDoPGuoAIl6Jwz5QXlnecEjSnW17F5kH8qMpQLwXQUcIqkLfsd3uXQ43BKZopMJq3sLAfnB0wo0VfZzybYfSYDWyRcSMT7hDc39GAXjtjZuO7tWrrcM7g3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLrCnfaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLrCnfaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D141F00A3C;
	Thu, 28 May 2026 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010218;
	bh=Og3Ys3Rb98/rutdlhVH60kIpEyGcQjoMYEplyDyrzIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLrCnfaHz1Q+jS9U0/q+Y2kpp0HqjGMfEgtrQ8wQYbu/PRPdJkNiyAUdQzVCtQiaQ
	 gzSZ1MgTI6c1JZdfPrj60vDdPsqByjze94t0PB5R8OMoMjGoFZEtr5D4Tciv7Zy03x
	 hjvTFAxf9B8rVJP6Rv/5Rf+8MqKj86LkjYi3RSn8JF7PeEKwdsi5huTNcQEHDKq83k
	 B92JYGQs5CteAo35Zu4f5HypaVdFbSvOfTqjuKRDIY5F6P1WgNvZPws29EkSAKV7qD
	 Ob5pSypI0PFxLwpB/rJ1pCJGvjsyZZOoCIDzdOscrcTDKqSO4LSz2o7tTPruY5xY1S
	 P6eQSUqoaqV9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/14] net: ethtool: optionally skip rtnl_lock in RSS context handlers
Date: Thu, 28 May 2026 16:16:34 -0700
Message-ID: <20260528231637.251822-12-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
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

