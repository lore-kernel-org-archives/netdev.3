Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534736A364
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350634; cv=none; b=b6OgELUT1JWN1RjUVERE1COmQO418MhiN9RaOaMSTwfBgcBV05vqZH52vXZ8r/859gxVqYkBN2QSO7Eh7XqvAyo+8mxN/kiXbD3xAxMLYRwHSULz1J4iqmlTVm/P3upaxhk9qA0oYb3iNTz2P52usZ7T7IQvDK5jjxx8P5mR+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350634; c=relaxed/simple;
	bh=T9SXqfsO/EFq+dYj0i1JvBToxhsvtWDwvs2JRGi+kgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCu+wlp3BUkodXqM1NZKIpEuvx3TFMwK0fI2ZKovlRHz5AuCBlMpjZisoe4pUrKRAwL6XxgGpR5MTpVnIiHgyeqe2+rhVdVc8j1eAIB2uIrtSZY+iuTYADqnfQyL9V1Uy7vhjNFUuqqpdTk9PR6oC8s5VtiFa2c+YC9yLs+ahqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfFxJsMV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfFxJsMV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37df0b86a82so229431a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782350631; x=1782955431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWrI8sitTaDcWEaHG+ZnIRCNC7VJeTwjUrHgR3uWgo8=;
        b=LfFxJsMVytxTBnqopl4HTZWKaCw7fr8/yIcl62JXLZeyiL1h1GTWPn2aNQg6tG5cPX
         0KbSKI/KMuaptoAM4ts/UomQOSxJ9DMv2gGkSE9CFkgCn4pX2WE/N+TKyFOLho5RUBQk
         E315W3LdoYVotNiWu71owoXTL+4L8j4NcUnRJhXMP4iYeTkPAFCOjL4gt0UX6+MuSbVR
         0O2WkB/lNvQl/0RdIPh0KmEjs1AYw6N7soUEFwZr57REJ6kjt7IRxW3tUjChKBCsrGK7
         7L+fVCFNnPf7hPBOpm5+GQbtMaeGmOEqTCZuJHcRIdg/l9+JE6UzbpYnERj/iKMTuVFX
         ISZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782350631; x=1782955431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XWrI8sitTaDcWEaHG+ZnIRCNC7VJeTwjUrHgR3uWgo8=;
        b=nhV3AHsbdA9T6b2G9Eq+abUR5bf5rv+ohZ1eepdVJWsnBVjD5Q2EW5/KqVlWmfPMc8
         00AfihFKQy9IY4jdY0i9Ya4Li0Xfhuq9HxCedXQNshw51mNHW3deowaFnBy4V2hS7n09
         BPMpE4qMVmOA5UZq0LLFvqCqDPdE8h14QMDb9QfGF9648eumyRib/8F536NR3WWRwaiV
         L7ReM/NXqm8uaSN1ysbHcVH9AO+Q4UAd7hiTD5iZoBTgB+vheS+EPJ6OVpF99Zt8tdWW
         krlNp6/TFQnZA2K5RQnEVyivTd2/bIlZBPvabzDglK//zMF140/Kg3rFdz4ExFLjxFY0
         uhYg==
X-Forwarded-Encrypted: i=1; AHgh+RqtKFC7EmqOI1fUZhAFkQGlzW1ZEXqjOTF+YOy/4CubzzXNLpDLY9CjQ1xsSiyRDI6rPHq2VHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLwVeMQvsO6F7seJv/8xynNY38GgbgFknVMEuSC52uPtcM2nK
	CNBss/bX4ZeFbQi/zrcaorgCprEhMJX1sMhWQdyQ40/fbj1d5i6q5yWbTquBw3JM7/c=
X-Gm-Gg: AfdE7cm2S7I9ndsGMSC3fnIlwc6Sogf09qrIFgifEoCoDpyPUj0ZCj0tfhU8veiRDsN
	P6tj6OCBaMYfNlZDrzj2+TxVLR7tdIgf53JwqvEOQ0vkTQSuISluXwLl/oU4VlmpqGvGTgsbm2s
	89Vei+jiJYuEAadAWTFWnRyiukcpSKthuDGVw4y9Xex5B8gS5p6uKpCIG1GviY6X4fVM2Tpmr+H
	t+LG4PvPyKW5SW8mbYlik5bCV42cl0qtRucpLhySUlZB8PNA+ns65TU5KMfcdWVhqjmMTMZ+rsB
	pElWvxciSSWXKV5Gft+8enewnaa6BCcWl4TiPmSmlL5QkcQyKCRiabC7ZK7i8jKfPYdskJOVtpX
	2UWkfPLBQD+bz6tpG2qjQ6HqnPgNY0rsNp+DF4Hz7MVrB7afwTnG2VXXv9aISQJkFY6HhEY4uAJ
	1xNdz/zHtVZ4m1Gd7cdp1rG6xzE54=
X-Received: by 2002:a17:90b:48d0:b0:373:302d:3ce6 with SMTP id 98e67ed59e1d1-37df911f73bmr384288a91.8.1782350631330;
        Wed, 24 Jun 2026 18:23:51 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df613b3a2sm158588a91.0.2026.06.24.18.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 18:23:50 -0700 (PDT)
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
	Pengfei Zhang <zhangpengfei16@xiaomi.com>,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: [PATCH v2] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Thu, 25 Jun 2026 09:23:44 +0800
Message-Id: <20260625012344.892480-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624171156.822055-1-zhangfeionline@gmail.com>
References: <20260624171156.822055-1-zhangfeionline@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Zhang <zhangpengfei16@xiaomi.com>

inet6_dump_fib() saves its progress in cb->args[1] as a positional
index within the current hash chain.  Between batches the RTNL lock
is released, so a concurrent fib6_new_table() can insert a new table
at the chain head, shifting all existing entries.  The saved index
then lands on a different table, causing fib6_dump_table() to set
w->root to the wrong table while w->node still points into the
previous one.  fib6_walk_continue() dereferences w->node->parent
(NULL) and panics:

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
 net/ipv6/ip6_fib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index fc95738de..bda492634 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -636,11 +636,11 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	unsigned int e = 0, s_e;
 	struct hlist_head *head;
 	struct fib6_walker *w;
 	struct fib6_table *tb;
 	unsigned int h, s_h;
+	u32 s_id;
 	int err = 0;
 
 	rcu_read_lock();
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
+			s_id = 0;
+
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

