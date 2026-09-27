Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201B3BF660
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540682; cv=none; b=peDeZOzCArYf+YKa0SjzMb2zwGkwmEV8/K1yfY2Z8yVY2scDiUZTzBv/yfP3ihp+n41IhhORRh4y7zB72/iYsakC24AnvzPfHMcBsEpb1Hb9kZbgSaqGtikYvyoIsOat2365GbDf4wZwO4avPMhy13nd7Fzx6cxB+6IhjYtbLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540682; c=relaxed/simple;
	bh=MYUiPAThlpXy3hDK8F98xpinNcjd1TVcnXxGddmia60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HPyQEU+aVU8sx6Z70jWW9POAFO+ZTDTf6C4pHZafF+8R3C6jkyRHtjNsHuqLrNkK8xkZyTjINBtKQp1NPNpIxA7IpeQJ85wddOxgvQJxOcbJaSyIo29aRrgnD1ikaDapjg93cbHPRHVWGhbv57256xNyIA9GfNyVCQvpJKJ5txI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8fA2m4Y; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8fA2m4Y"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a0ad137e87so3776243a91.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790540681; x=1791145481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1rGGJ63C4FV3mScHHJc7Dvo/NCy52SWK0T6aRtJEMk=;
        b=u8fA2m4YKzr+1RouyAoyGQHV0e8pNHS5A6ltmqHkefWvMgAw54K0OIaefVA32UFxqu
         Iiufp9jMHm5dccx0QWuoP9p5YWhmDuqurHGdLj36waGhqlMIG4QEkasrdxpGQ7jaAaue
         dhRKofH4CzG06zyDxxiZ2wq2C9mDUyciTjthty/l8XjW+Iso/sPrGodKZDQg3PKIHG3S
         oIXedRMTSLVrtTri6vMJA8u68BnM2UFQlH/WQAjA6zP0nVOUJ8nV8/UNih76cJfSSdyQ
         ojJJ2mEm5nBJPA9RQKN67RuLIbdVu5GpvhcwA9+/igaYGgMMIVdBbvpHnh32aMRxy58c
         n79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540681; x=1791145481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B1rGGJ63C4FV3mScHHJc7Dvo/NCy52SWK0T6aRtJEMk=;
        b=oAKf956AFhCwB5OVLnvDx+4BQqBE8knIYF88Ub3p60Mbz+hIsaEYQ5zTb6mJqTNS46
         ZNC5PWmcBfu1lanrS+iTepoUl1rKAyTUz8YPjZ3d5DGhlrlcPVQC05qQA9Fp+QZMJ4TB
         93qB8iKpkCrNQmK7Z2JYrkxUPJfBIUoHjF2ObPhPua00cj/7oVNZj6Cus1s/py3SUQsO
         uKswWnlhOmqd705yXY7bQUOIQssOfT3kEu/OsQHhDRlQp4PQXI69CSkVZjeOMOUy23oE
         3Afkc+tgLJeWpN63NoSNk/flLE4YytqaNPvETBL/DsVEJJFSs7ruXlFv/jOUxN5vuwsV
         K7zA==
X-Forwarded-Encrypted: i=1; AKwUvBypAmZ3VhUGLqf2AzwuzDBcBpS1f/3GnqLNphuwFrLYKJQKkgXQ85XFnK0qEIZKOEPHmhrj8AM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdJPswjwW0etjnesFHca/98oSSpwav1gaRnhdRHLLGwoLMetYs
	BIHDRpGpWUlGfREHxKpffPfmOqsxqdxFlyc7dJWA5GWvfC2TGotIAwHq89UKNwEytfLnUGi97sa
	cb0C49A==
X-Received: from pgei15.prod.google.com ([2002:a05:6a02:526f:b0:cc7:62a0:c318])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d41:b0:39e:4c81:6c5f
 with SMTP id 98e67ed59e1d1-3a0986079a8mr5677886a91.26.1790540680259; Sun, 27
 Sep 2026 13:24:40 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:23:40 +0000
In-Reply-To: <20260927202429.2452589-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927202429.2452589-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/5] net: Track state in ops_undo_list().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will call rt_flush_dev() and rt6_uncached_list_flush_dev()
from ->pre_exit_batch().

Then, we want them to return early when called again from
 ->exit_rtnl() or default_device_exit_batch().

However, we cannot simply return early when !check_net(net).

In the following cases, even if check_net(net) is false,
we cannot skip rt_flush_dev() / rt6_uncached_list_flush_dev():

  1. some ->pre_exit() call unregister_netdevice() before
     fib_net_ops (e.g. ovs_pre_exit_net(), l2tp_pre_exit_net()).

  2. ->dellink() could call unregister_netdevice() for another
     netdev in a dying netns queued for the next cleanup_net()
     batch, for which ->pre_exit_batch() has not been called
     yet (e.g. veth).

Thus, we need a clear flag to indicate that ->pre_exit_batch()
has already been called.

Let's add net->undo_state and update it only for dying netns.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/net_namespace.h | 9 +++++++++
 net/core/net_namespace.c    | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 58b2601bb869..6a817326fbb8 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -57,6 +57,9 @@ struct uevent_sock;
 struct netns_ipvs;
 struct bpf_prog;
 
+enum {
+	NET_PRE_EXIT_DONE = 1,
+};
 
 #define NETDEV_HASHBITS    8
 #define NETDEV_HASHENTRIES (1 << NETDEV_HASHBITS)
@@ -125,6 +128,7 @@ struct net {
 	 * it is critical that it is on a read_mostly cache line.
 	 */
 	u32			hash_mix;
+	u8			undo_state;
 
 	struct net_device       *loopback_dev;          /* The loopback */
 
@@ -364,6 +368,11 @@ static inline bool net_initialized(const struct net *net)
 	return READ_ONCE(net->list.next);
 }
 
+static inline bool net_pre_exit_done(const struct net *net)
+{
+	return READ_ONCE(net->undo_state) >= NET_PRE_EXIT_DONE;
+}
+
 static inline void __netns_tracker_alloc(struct net *net,
 					 netns_tracker *tracker,
 					 bool refcounted,
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 476fbf913bad..9e2462bfa478 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -226,7 +226,9 @@ static void ops_undo_list(const struct list_head *ops_list,
 			  bool expedite_rcu)
 {
 	const struct pernet_operations *saved_ops;
+	bool dying = ops_list == &pernet_list;
 	bool hold_rtnl = false;
+	struct net *net;
 
 	if (!ops)
 		ops = list_entry(ops_list, typeof(*ops), list);
@@ -248,6 +250,11 @@ static void ops_undo_list(const struct list_head *ops_list,
 	else
 		synchronize_rcu();
 
+	if (dying) {
+		list_for_each_entry(net, net_exit_list, exit_list)
+			WRITE_ONCE(net->undo_state, NET_PRE_EXIT_DONE);
+	}
+
 	if (hold_rtnl)
 		ops_exit_rtnl_list(ops_list, saved_ops, net_exit_list);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

