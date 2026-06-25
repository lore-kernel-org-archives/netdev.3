Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB32DF136
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371127; cv=none; b=sVJnlb80q0QZ515T/MQq2lQ1z3mXbjJfqZY0vdtxpthI9hj5i3NUTUOS6eG//FlsF8Egay9smTlsBtU8hIucCJV2Wxd+1uQqd16l1X+AnKIJNY4/2q9d8cfR7skXk+3Yrw9UAr2ZRwfGDWgP5++ncYbkopV+af4z03Vwk4SyMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371127; c=relaxed/simple;
	bh=sozevHDQszseOf1dQTv17dZ96y/NfOOSZzfBF4CtGIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQv8NCOll3fp8awERJkaf8tlSa+0HAf3xEwKfGqZ5NinqtbxgTsG1/5gopZRZzpe06XU6W7UvCN9cPyUqHxgmFfrvCygCAw7iAYv9xVApMXPjJ5sTr/KlsTznqrlHxduJnbqR5cZs50b1wfYxGMB1eUhjLnCV2fe78iPfq4sngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSFM7YCk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSFM7YCk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c7f385883cso4272985ad.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782371124; x=1782975924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3myBgouSemGQyy63uNOanLWZfrnwzbhR0El07JRzF80=;
        b=rSFM7YCkO4Oll8rFlcXWVmDVRECV4Es6Ua67Dzkasfjj6tOyC1GUhkIWaAFG1DNQqC
         2k7pbFfIjGDxJn1Hke5VxmWUCHP1m56f3qhI9JdhBijmCk1pJ7soGIo044i2uZOHEFyT
         q02xrQuw+nmrp0b/jvJdfB5/RJp4Xr+pbcfz7QHe6ZJSRY9tEEfMZGb4jn+XinYEJkOe
         eCohWl7L8KVTtGnPK7mFFyJW6BNYIfzZfG0OnHvdPEoiSiFYEZyD8TW5wzGW1OvSZhF4
         EVljw9+9gZThdgrwMlaPRN1IIxz/qwos5nUSZmCza6ufD4sgcFQUtGuHVVcxkclnM162
         28mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371124; x=1782975924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3myBgouSemGQyy63uNOanLWZfrnwzbhR0El07JRzF80=;
        b=QIs4iT16I40NIib8c7ezKgJttF8kenRV8jKj7im0aWHG8Jq/6NXd555Zyyeh/rV5jL
         9+pHqysAzVcY+ft2tpz1ltn6A6bTHrahI1T2k8f6zQHYK2IWkBgHixE/YRM4h9H+bfBt
         6CRyp9UV1RzD5KqdgUuk7+k6kQ2BwAUhd9ObVceyRIlhZmsFnlfynZTaiqCBTetR4POR
         hSJR+YqRIn1vUkNIp5ZVmGv9RMXyzxTMk5am/+mubqk5RTVjbPut4crEGXiasOBAAJ3B
         tPwWeza4FS9mmRRWlsOUB3LxvLnMgkNriKm1hh7bBTHSVK1WQ/rZ+LXrjR18fY95XKGm
         b6UQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXoWO9TFYTZ+J2UIRmaEe337Yxw/A52EtwkEa5HQ9D8VmSKYQ8tzUeJ30lrTto9HBM8kLD3Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp6M/t2jQdTBDXBWXvYwn7ZG0aeEshoL/xpaMejLU4fQuLXZy
	AY/O2SDr2EVe6f8GQTwldeL5pClNAbmqY1Hs0/HN5gfugGKtT9GK8LWt
X-Gm-Gg: AfdE7ckLptSxhQCfwxMneXq2lMK9Tsg70rjXD8T3/MILbesgUHVb45b9detKAHTIw5i
	zm88FdGlD3nch9/6WcWLNMKWCSNjkkJXoy/Lo6s5FWFmTt8pWoUPLktgj7FmiiSBQE/wOIR7u+v
	hlzgUCHh53sWrocXM0xUH64oQrs7sjzfmm6fNWFixKSh1eATN+zDe94VLNKGRgmXCcjwm9Ud3Cm
	1F+avbafn+p7YmBRCMO+lGQAmvkn5EtnJV4ZuiRtqNV7wRGeLx/YUAlVaTW8+gJwqT8MZ2E/DBL
	1bA6hufZDmkxyObqJPBlElwJ0lqhxMHp6EMiX5KnWjcpznUvmEE0LW+6IamMfD2LRQ+BOtI6S9o
	2DBMfwJwZKIO7QL/G+RqfuBP04so9WPI3b1UGp/N5e6jlU+RWi8PBx3j3kv04s3PhBlUzbhzMuS
	rRO0oUj+EUXp0G3ivjYiaN33jnRYU=
X-Received: by 2002:a17:903:2286:b0:2c1:d49c:8397 with SMTP id d9443c01a7336-2c7fc68d9a2mr15417205ad.12.1782371124237;
        Thu, 25 Jun 2026 00:05:24 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8e3csm13539915ad.10.2026.06.25.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 00:05:23 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com,
	baohua@kernel.org,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: [PATCH v3 net] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Thu, 25 Jun 2026 15:05:17 +0800
Message-Id: <20260625070517.965597-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet6_dump_fib() saves its progress in cb->args[1] as a positional
index within the current hash chain.  Between batches, a concurrent
fib6_new_table() can insert a new table at the chain head, shifting
all existing entries.  The saved index then lands on a different
table, causing fib6_dump_table() to set w->root to the wrong table
while w->node still points into the previous one.
fib6_walk_continue() dereferences w->node->parent (NULL) and panics:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:fib6_walk_continue+0x6e/0x170
  Call Trace:
   <TASK>
   fib6_dump_table.isra.0+0xc5/0x240
   inet6_dump_fib+0xf6/0x420
   rtnl_dumpit+0x30/0xa0
   netlink_dump+0x15b/0x460
   netlink_recvmsg+0x1d6/0x2a0
   ____sys_recvmsg+0x17a/0x190

Fix by storing tb->tb6_id in cb->args[1] instead of a positional
index.  On resume, skip entries until the id matches; a concurrent
head-insert can never match the saved id, so the walker always
resumes on the correct table.

Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
v3:
 - Fix Author/SOB email mismatch (use gmail for both)
 - Drop "RTNL lock is released" from commit message (RTNL removed from IPv6 FIB)
 - Reorder local variables to follow reverse xmas tree
 - Move blank line after continue for readability

v2:
 - Add Fixes tag

v2: https://lore.kernel.org/netdev/20260625044101.939070-1-zhangfeionline@gmail.com/
v1: https://lore.kernel.org/netdev/20260624171156.822055-1-zhangfeionline@gmail.com/

 net/ipv6/ip6_fib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index fc95738de..a130cdfae 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -636,12 +636,12 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	unsigned int e = 0, s_e;
 	struct hlist_head *head;
 	struct fib6_walker *w;
 	struct fib6_table *tb;
 	unsigned int h, s_h;
 	int err = 0;
+	u32 s_id;
 
 	rcu_read_lock();
 	if (cb->strict_check) {
@@ -701,23 +701,22 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	s_h = cb->args[0];
-	s_e = cb->args[1];
+	s_id = cb->args[1];
 
-	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_e = 0) {
-		e = 0;
+	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_id = 0) {
 		head = &net->ipv6.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-			if (e < s_e)
-				goto next;
+			if (s_id && tb->tb6_id != s_id)
+				continue;
+
+			s_id = 0;
+			cb->args[1] = tb->tb6_id;
 			err = fib6_dump_table(tb, skb, cb);
 			if (err != 0)
 				goto out;
-next:
-			e++;
 		}
 	}
 out:
-	cb->args[1] = e;
 	cb->args[0] = h;
 
 unlock:
-- 
2.34.1

