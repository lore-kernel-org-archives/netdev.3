Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25F36923F
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194524; cv=none; b=K4E/is0+8i8F6ZE6aflnyY+UaTGvF9X3iMXe0P8ddFQtOyhQbrulib52xYY16ETgu/ox0YQzv/3yUuLDWB1pa/Cw4fkmIdqm/MiVgsISVYb7wBRJIMOiCi3reM2MXSZUW7NMKQ27tH8KQ2mWj9jDnktrL0/2sEKQxLVAB8MkHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194524; c=relaxed/simple;
	bh=dhExR1EHzXJkFiLslcyUZdEfkMxsNHh6PXT3iU1uuUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzG/GFXnAXByLd9Zh9FU29HXDop8Z0vmJ//Pl900ivtG8IWU0TLopLFG+2GCJsZUFsOYe2mkMpcAkoPc3JYgugRBzgYNEfRCu/yY3YN/Qh2pilw5+t4R5knR+ujEBvWjhs6cVfKZD7iWeG+gtHHq3Id+Jgj2xWVIaGujnUQB5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0EpvhYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0EpvhYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB381F00A3E;
	Mon, 31 Aug 2026 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194522;
	bh=Fio3ay+hXE1eNvV0FitUEwVzyXmKgHgGH4smkFmZ+tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E0EpvhYOY3dRySm7ooJqx7oV22IfSTwNammBFITyLOXz6L4ENzJp5fvZ84hT+4IQi
	 NmfR0A0bIelywi4QzqzLFpl4dvrwlGJZgiMr96esmDg5eLGUgJYL8I37/nm9Lgotvr
	 iNIFQ01NCCy4Y2zs56DGVgVyOsUipUCtqZbxIjXT9GDFpuVQT+JIdxjbEZzYF+alHY
	 r3FnCjkmn/ETQhNsD9DFN1Txo93mlknrQNPY2Lxh29TzjCcU965pDaTdsg6HkEeJ/o
	 jKjKDqhuXsj68rm2girfU0wC6ysmPWNISdiLQLgIFTpEy9YkG9qj/cEkCDHoZiYNvi
	 Vvi8ZHX6Khtjg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	razor@blackwall.org,
	bobbyeshleman@meta.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/3] netdev: avoid skipping objects on race with device disappearance
Date: Mon, 31 Aug 2026 09:41:57 -0700
Message-ID: <20260831164159.1124679-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831164159.1124679-1-kuba@kernel.org>
References: <20260831164159.1124679-1-kuba@kernel.org>
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

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 04dcd7fc614e..e427bab4c4d2 100644
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
-- 
2.55.0

