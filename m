Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8693101A5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473520; cv=none; b=Qhd92io53WQpSKQIJVd66MNnTa66rlP4Af2Fx3Q5DGWCVqMPrxgzKov5i8CHEzE03zuW+0e/ze/UgkWdV+lK5RTx87pXYtlWVPfrb5eRuzPR70Ibg7kO5gjn4V/wzgR6x0uE+WRXeSuFz64EcWBnNvWCt0XhSXqypJcKFESCAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473520; c=relaxed/simple;
	bh=3BKwTGkO+Ww473i+r/eAg8qBrcgt4pm1pRuC6u6hkxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzgFtRFf2KNONxtV+A6WWo7oh0kBcjRtLWXaBbgiKzazYTUtB4PAxnxGkASCm4jr1aMoHL3BIJZt0LWfM+qQf5JVgADBZP8ANub0kjkkVw/yoeq3IAqpGXv8NWKYounSsk2B3uLRb4rlJoqs2GF626cqOblZf38NWMnrv4pYetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKdzKuyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKdzKuyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BA31F000E9;
	Thu,  3 Sep 2026 22:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788473518;
	bh=NGollT3DBRdVHQp8wLz0G4tcE7l5GOwoOWOLE2uWAwE=;
	h=From:To:Cc:Subject:Date;
	b=oKdzKuyRoo0wWfu0DcEAtE7jzFobIphmeHIKnxhrIU2vGBiBTXSXSUy8ou23VTaTw
	 1oIQWVr2zZJiyeFJ8ovFjuvx2fv+7+iziYgcqiWpRy5I11DlPDAtohvZBQ3+xqIRpu
	 6HEjLDvsdwMr5tON3lHBHL948zIJpCBeIEdKPuvEk1z5n/M13qdYLNTsT7R6sw39ul
	 rzu61TCh2u8g8FYe7E6OKEmsS1wdEQjNXT7ThxpqS5f7bqDYeF7NUTs6v0pwE0Of7c
	 lomu8y5LLrd5z0qwlfC7ihYejKjIZ5QKCeIQB6ghhD7wVw5gX9tI1pw6f26HXa9RIR
	 KVskMWGs9k1VQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v3] netdev: avoid skipping objects on race with device disappearance
Date: Thu,  3 Sep 2026 15:11:54 -0700
Message-ID: <20260903221154.3359889-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the currently dumped device disappears while we were mid-dump
we will get the next device without resetting the sub-object ID.
This is quite unlikely, it was reported by an AI tool not a real
user. Let's fix it for better dump consistency.

We only intend to cover the case where device A disappears
and we skip over sub-objects of device B which was stable (B existed
before and after the dump). We don't intend to provide stable
results for any device that gets created or deleted during
the dump.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3: cover page pool dump as well
v2: https://lore.kernel.org/20260831164159.1124679-3-kuba@kernel.org
v1: https://lore.kernel.org/20260609190804.1137085-1-kuba@kernel.org
---
 net/core/netdev-genl.c    | 22 +++++++++++++++++-----
 net/core/page_pool_user.c |  8 ++++++--
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b8ba91cc93da..fa9edfdb32c2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -312,11 +312,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			err = -ENODEV;
 		}
 	} else {
+		unsigned long start_ifindex = ctx->ifindex;
+
 		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
+			if (ctx->ifindex != start_ifindex)
+				ctx->napi_id = 0;
 			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
-			ctx->napi_id = 0;
 		}
 	}
 
@@ -636,13 +639,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			err = -ENODEV;
 		}
 	} else {
+		unsigned long start_ifindex = ctx->ifindex;
+
 		for_each_netdev_lock_ops_compat_scoped(net, netdev,
 						       ctx->ifindex) {
+			if (ctx->ifindex != start_ifindex) {
+				ctx->rxq_idx = 0;
+				ctx->txq_idx = 0;
+			}
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
-			ctx->rxq_idx = 0;
-			ctx->txq_idx = 0;
 		}
 	}
 
@@ -788,8 +795,6 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 		ctx->txq_idx = ++i;
 	}
 
-	ctx->rxq_idx = 0;
-	ctx->txq_idx = 0;
 	return 0;
 }
 
@@ -904,6 +909,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
 	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(skb->sk);
+	unsigned long start_ifindex;
 	struct net_device *netdev;
 	unsigned int ifindex;
 	unsigned int scope;
@@ -936,7 +942,13 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 		return err;
 	}
 
+	start_ifindex = ctx->ifindex;
+
 	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
+		if (ctx->ifindex != start_ifindex) {
+			ctx->rxq_idx = 0;
+			ctx->txq_idx = 0;
+		}
 		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
 						    info, ctx);
 		if (err < 0)
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index ef4261c0e8ea..f30f3779624c 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -84,6 +84,7 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct page_pool_dump_cb *state = (void *)cb->ctx;
 	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(skb->sk);
+	unsigned long start_ifindex;
 	struct net_device *netdev;
 	struct page_pool *pool;
 	int err = 0;
@@ -91,6 +92,8 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	if (ifindex_attr)
 		state->ifindex = nla_get_u32(ifindex_attr);
 
+	start_ifindex = state->ifindex;
+
 	rtnl_lock();
 	mutex_lock(&page_pools_lock);
 	for_each_netdev_dump(net, netdev, state->ifindex) {
@@ -99,6 +102,9 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		    netdev->ifindex != nla_get_u32(ifindex_attr))
 			break;
 
+		if (state->ifindex != start_ifindex)
+			state->pp_id = 0;
+
 		hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
 			if (state->pp_id && state->pp_id < pool->user.id)
 				continue;
@@ -108,8 +114,6 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			if (err)
 				goto out;
 		}
-
-		state->pp_id = 0;
 	}
 out:
 	mutex_unlock(&page_pools_lock);
-- 
2.55.0

