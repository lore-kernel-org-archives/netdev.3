Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CCF1E98EF
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787686; cv=none; b=px4EfHSD3NvHqzBoTNIF38a3ljd1rs1wWW2NhpDeKchPZmnR9nkPLY9FwzbJnB6DxqAL0o45zxyDRYfKPOR9Di8ljGQNwS3wRCgWl2q6nMu6/0gITAyuJ7mjfKy+noznEXoop6Iq5YvZk2M4w/qEGc2H29CW8/rL3tCSQzyD8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787686; c=relaxed/simple;
	bh=M7iRHTBJPb2PRUhzJpwM2pWCP7DsDz6g+JsmfNbD8NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtOc+DxDuEOSqya8aZBWkehrDkTGBw503h1V0U8pMlsbwFyfMFBjkO7Npz/tUZ/9yfGhBHyMtvLJ8h4OYrl8L/t4Ldqod/COw+AE0C5bmphMXxsCu8Gw+FRmH6DV2hS17aoKBl+GuVNb6QCfa07qMJGfsLTrvVPRWEKPv52RwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWhtpDv5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWhtpDv5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso21308895ad.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786787684; x=1787392484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3F6IAQ4pKsreYQprgJ/5sDlA3ah7ieVyFMiRIBIZuFw=;
        b=BWhtpDv55GzXL7G/r+wNpARgJVWNYb5teTfADde/7Hi2qHLIdg/BHtUa16MNJk+ZDj
         AiB5QshqVeOytky9RbxmH2Y+DvRul+6mN0WFoCkbA1aOPdYZu9kSeK0wc/qxXsftQb9L
         HvBjtIccTGWYYDBAfFogr1yqe2To5CkK6GNAdxk0+TUPfdBbekPXwCYL5I0xsQm04OB9
         Kl6JMCvXKIBSKCNBY4jZrg0SK2+ePFwIKd/NarvTBov/D/LXvMqzZkimhpCaFZo9SfxE
         11VOwDmtz0JC1gC3DpGAPkQgC8xGd0gV6sjY6PDI7ycN4fRxqYmN7YA+x4ojOpBieIaw
         4W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786787684; x=1787392484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3F6IAQ4pKsreYQprgJ/5sDlA3ah7ieVyFMiRIBIZuFw=;
        b=SzOu8oGAxpx9NcCO1Cd+WOG5EerzFQZLuK4BOgeC5/X7BAm/xDnK/Av0zcZMNn1Got
         Z5O+CVcNWSr4Kf5VWpOurs7so6tikisoiE0tEQcYz/ABbN6OkImSzS4ct3pC1bJ+PM/X
         4x1axez03Y/rZS0LFWOfjJuzPguYZO5hJub+r+NO7f5WEWq/rBvdNg5Y4xe8bP7rBl/1
         8u9oEx0jVJxx0N2E+wDXgoYgw7Waggd4XWTOQbHBR8hBQVZrpKY8LRc9M4TJfdS79t3h
         +tgttvJqNKqtLHBphrtRHkbMCs+L60JYRgF1Qd4ok21OeqdsyFOvn5Mz0OOp+zPZBHmu
         EbfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPY2jjy30itQXfGfkAG/tidrFf8Y+aQmdLB2Xi5CssoA2sQmXIwV0p+xUm9VafHSjtFW+GPHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhmi7kJPP7jIcuAmML3RyAAeuRXqmFRxRKN1tVSlhmyLF1s80g
	1fVY1j/qJPhaytAWoTluYAESJQ/X1FW4Itx7XqtDil5A0PED39m9RHcu
X-Gm-Gg: AR+sD11gjRVf7tgruSU0RLaMLupogiZZcmhXA+TRDy42zD/FRdfwxg8Zdlj5rrW9ukd
	I+9Rg7NUhxipqHB64wy3s4P8lYdPMP/ZP+aXH2FoojX4q11CJ7lCh9OkGFhsdPd0e3YObRA9udY
	HmCgyJosHXENYro7SaNl//UouJsH9l1vIUpb//7Jomc4eHMI66nxZx4LFbQr3brludDheGin4Zj
	VMkwk5SkWe5cRcPPJofGlqWevJB4mZo9Eywa5yQvBlQpywQ2HD0lvx7no1zHHvvU3SafTzc8A8m
	OqEI/kGqWr9+nFbsZylKrhxF/CCCz4pvtY3JrLv+U8GXJKAaQD7r9weYqBWU/L7kToW96WyL+Zt
	doDl2EiOKzUECHgCXGiFUaTSdTHismM/4CX8HUNKFYMr8O3V+bO0+P4ZAtYldwb5ZaHy3wG5dCs
	+KqMOV+cnPiO0F9YffTIcC3XhBJ9QwE1oN1gGtbaiYYLa7aIqw1QSTErLZE8/uPpdiR3t+QBLpf
	aLdqge74mGTiXPfEDF7Mo5ZiyEk7GHBpGlHpRI7TFfv/zHkmw==
X-Received: by 2002:a17:902:ce83:b0:2ca:e496:5f19 with SMTP id d9443c01a7336-2d3b0043318mr99627235ad.19.1786787684016;
        Sat, 15 Aug 2026 02:54:44 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:959f:bb81:fb2:a537])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7d16e8sm18107435ad.31.2026.08.15.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:54:42 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Amit Cohen <amcohen@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ipv6: Serialize hardware flag notifications
Date: Sat, 15 Aug 2026 18:54:36 +0900
Message-ID: <20260815095436.90534-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib6_info_hw_flags_set() first performs a lockless check of fib6_node.
It then allocates a notification skb with GFP_KERNEL, which can sleep. A
concurrent route deletion can remove the route, set fib6_node to NULL, and
emit RTM_DELROUTE while the allocation sleeps. When the thread wakes up,
it can emit RTM_NEWROUTE for the already deleted route.

This can cause userspace routing daemons to receive RTM_DELROUTE followed
by RTM_NEWROUTE and incorrectly believe that the deleted route still
exists in the kernel.

Allocate the skb before taking tb6_lock, then recheck fib6_node while
holding the lock. Keep the lock until RTM_NEWROUTE is published. If route
deletion wins the race, the recheck sees NULL and drops the notification.
Otherwise, deletion cannot remove the route until RTM_NEWROUTE has been
published, preserving notification order.

RTM_DELROUTE is sent by fib6_del_route() with tb6_lock held, so
publishing RTM_NEWROUTE under the same lock is sufficient to guarantee
ordering. rt6_fill_node() does not sleep in this path, and the
notification uses GFP_ATOMIC, matching inet6_rt_notify() which already
broadcasts under tb6_lock.

The race was found by Sashiko during code review.

Fixes: 907eea486888 ("net: ipv6: Emit notification when fib hardware flags are changed")
Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/route.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 16dfac54a259..73db4f630dcc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6463,6 +6463,7 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 			    bool offload, bool trap, bool offload_failed)
 {
 	u8 fib_notify_on_flag_change;
+	struct fib6_table *table;
 	struct sk_buff *skb;
 	int err;
 
@@ -6491,22 +6492,33 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	if (!fib_notify_on_flag_change)
 		return;
 
+	table = f6i->fib6_table;
 	skb = nlmsg_new(rt6_nlmsg_size(f6i), GFP_KERNEL);
 	if (!skb) {
 		err = -ENOBUFS;
 		goto errout;
 	}
 
+	spin_lock_bh(&table->tb6_lock);
+	if (!rcu_dereference_protected(f6i->fib6_node,
+				       lockdep_is_held(&table->tb6_lock))) {
+		spin_unlock_bh(&table->tb6_lock);
+		kfree_skb(skb);
+		return;
+	}
+
 	err = rt6_fill_node(net, skb, f6i, NULL, NULL, NULL, 0, RTM_NEWROUTE, 0,
 			    0, 0, RT_DEL_REASON_UNSPEC);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
+		spin_unlock_bh(&table->tb6_lock);
 		kfree_skb(skb);
 		goto errout;
 	}
 
-	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_ROUTE, NULL, GFP_KERNEL);
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_ROUTE, NULL, GFP_ATOMIC);
+	spin_unlock_bh(&table->tb6_lock);
 	return;
 
 errout:
-- 
2.43.0

