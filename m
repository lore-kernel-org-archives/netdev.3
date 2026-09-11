Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33393361DB8
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142889; cv=none; b=QC/vC3I+OyK8Efpl0NQZf+vtjrWxRwanjuPb7ZhxGCeqJ9HqjqcZ/39Iw0JbGgMgzC7e2z7f5M8Woq8pDBEGnctjsTIIgfoUzAY7s7woU+h1/2eAjWBEDDs3ln3JV8R6XlnqYf2caBoNUIVrpPXJ+9Hrxm7+Tr3QjRFNfhBo/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142889; c=relaxed/simple;
	bh=nqOw4/oEWmFmoj9RRzjVFfmf87c1d156un5YAkm/D64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pA2XuFbOzwjNo92ZV3arjIRAQvG6taFbgnV5vrGBkUIODTrFmWSXgsMvKiU+4qq8fbhSymz3XXv7rJeSmV+l3c0b9e94uZU6jzlz/QqDdtWIfyYI7fwPHDW00JSdWh+XtM0czE6SCK4C90AMWI2rf3jnPwZCz/hiPo4fEJ8/0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGQ0mfrD; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGQ0mfrD"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936e393061dso148121885a.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789142886; x=1789747686; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjxJI1JDm1sHO9mnj+2XbPSE01NULJXMdW/YFGzPLWg=;
        b=oGQ0mfrD3HthJegzQqaoCSPbjuSDZLFj0MTZWBchRf64BvesLEA+3jxAF1rgWYL/g9
         uYuFKAUc1dOf+nhR3V23fCt4uO/QMJHvLEFY6qA09E1DYNufVRfm0CeyUJtQumKBbKoc
         zlIImmQ2qWwnbsbcG6BF8BJKSQgaeUpD5dn9KWbF2aTAh+QaEeFl8Fhk3AulaZddtJ0I
         vWZhQjXKHC+tiPrVWgWhsFihRLumpfsTOaHraDj3gO4BROko2ljfM1rYRuSWW0MqN79y
         HXzG+JjtrMBBtYQevZGzi3GMKeqldeau52ZB1a4NRozeYEAQpO13sXLIMbqibMSR9u4I
         /3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142886; x=1789747686;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjxJI1JDm1sHO9mnj+2XbPSE01NULJXMdW/YFGzPLWg=;
        b=mgMC9RGXihKDWk67qrxkPaFwGXdD0xWcEVHO9YHgPp24zA/Fih3ogtPRcbYBfL9iUx
         b02qrePbF8wUY+4TQh8Tw7upWJpB3hSGz/XymZmwWsT9pQ4+oNn7mbqq7/ExBm2hMCDn
         YmasvbEG2yHxXR1vXP4doHkmH6evHRUi9NDC/Y07DVtdyJ/4USK4C20c/UdedTUcqHKU
         Cu1Hs/4I4oYRJdWktzRtJBne8Vtcqh7ZvdwqsuUwWBpGaWPrjLh8GGq0EZaw8D+tpKpa
         uQjL3W65+oAkmm0Ddet3v5eP0i6XNCPDRByxKNBIX93oa/kytJ5PpE4j70NAiH2G/9Cy
         mBzw==
X-Forwarded-Encrypted: i=1; AKwUvByhwB3WKc3V+9c5B4j0v0VN+U1MQVulj1qQYPPlq1dJ3663g+9H1moRkdBKfLZNU8wPjPQ1EPA=@vger.kernel.org
X-Gm-Message-State: AFuF++n6mmu5UjSsIK9t65SbXH5meGXYsZXMxXq1Pv87cgbFMndyR2vf
	PRXXorbw9/Q9PqB4MkqCF/mav1SUQuMEBVOZhaYws0UcCdUdE/e7qwccTxBc6OFi/8RU020xBwP
	f2UMUJMUPcoXZ/g==
X-Received: from qkoa9.prod.google.com ([2002:a05:620a:2e9:b0:939:1da2:297a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:29c2:b0:939:5cd5:e243 with SMTP id af79cd13be357-939ea01290fmr641062985a.6.1789142885309;
 Fri, 11 Sep 2026 09:08:05 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:08:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911160804.917099-1-edumazet@google.com>
Subject: [PATCH net] netlink: do not free nlk->groups while lockless readers
 can use it
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, James Burton <jamesburton@meta.com>
Content-Type: text/plain; charset="UTF-8"

netlink_realloc_groups() uses krealloc() under netlink_table_grab().
Whenever NLGRPSZ(groups) lands in a different kmalloc bucket, the old
bitmap is freed immediately.

Two readers of nlk->groups / nlk->ngroups do not hold the netlink
table lock:

1) sk_diag_dump_groups(). Hashed (bound) sockets are dumped from the
   rhashtable walk in __netlink_diag_dump(), which only holds RCU.
   Only the mc_list part of the dump takes nl_table_lock.

2) netlink_native_seq_show() (/proc/net/netlink), whose walk has been
   lockless since commit 21e4902aea80 ("netlink: Lockless lookup with
   RCU grace period in socket release").

Both can read a freed buffer, and sk_diag_dump_groups() can also read
past the end of the old (smaller) buffer if it happens to load the old
@groups pointer together with the new @ngroups value, copying the
result into a NETLINK_DIAG_GROUPS attribute.

This is the same class of bug that commit f773608026ee ("netlink:
access nlk groups safely in netlink bind and getname") fixed for bind()
and getname(); these two readers were missed. Simply grabbing the table
lock in sk_diag_dump_groups() is not an option, because it is also
called with nl_table_lock already held from the mc_list section of the
dump.

Make the lockless readers safe instead:

- Allocate a new bitmap and free the old one after an RCU grace period,
  instead of relying on the implicit kfree() done by krealloc().

- Publish @groups before @ngroups, both with release semantics, and have
  the lockless readers load @ngroups first. A reader can then never pair
  the new (bigger) size with the old (smaller) buffer, and a reader
  picking up the new pointer while still seeing the old size is
  guaranteed to see the initialized bitmap.

netlink_realloc_groups() is called from process context (bind() and
setsockopt()), so kfree_rcu_mightsleep() can be used, once the table
has been released.

Fixes: 21e4902aea80 ("netlink: Lockless lookup with RCU grace period in socket release")
Fixes: ad202074320c ("netlink: Use rhashtable walk interface in diag dump")
Reported-by: James Burton <jamesburton@meta.com>
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 42 ++++++++++++++++++++++++++++++++--------
 net/netlink/diag.c       | 20 +++++++++++++++----
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e6b1d9758c9c92ee465888ed206e84339ac8e52c..9fdf964224ab48407ff4915d2b07cc76325ae6af 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -922,9 +922,9 @@ netlink_update_subscriptions(struct sock *sk, unsigned int subscriptions)
 
 static int netlink_realloc_groups(struct sock *sk)
 {
+	unsigned long *new_groups, *old_groups = NULL;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int groups;
-	unsigned long *new_groups;
 	int err = 0;
 
 	netlink_table_grab();
@@ -938,18 +938,37 @@ static int netlink_realloc_groups(struct sock *sk)
 	if (nlk->ngroups >= groups)
 		goto out_unlock;
 
-	new_groups = krealloc(nlk->groups, NLGRPSZ(groups), GFP_ATOMIC);
-	if (new_groups == NULL) {
+	/* Can not use krealloc(), because the old buffer might be freed
+	 * immediately, while lockless readers (netlink diag dump and
+	 * /proc/net/netlink) can still be looking at it.
+	 */
+	new_groups = kzalloc(NLGRPSZ(groups), GFP_ATOMIC);
+	if (!new_groups) {
 		err = -ENOMEM;
 		goto out_unlock;
 	}
-	memset((char *)new_groups + NLGRPSZ(nlk->ngroups), 0,
-	       NLGRPSZ(groups) - NLGRPSZ(nlk->ngroups));
+	old_groups = nlk->groups;
+	if (old_groups)
+		memcpy(new_groups, old_groups, NLGRPSZ(nlk->ngroups));
+
+	/* Publish the new bitmap and its content: pairs with the address
+	 * dependency in lockless readers, which can pick up the new pointer
+	 * while still seeing the old (smaller) nlk->ngroups.
+	 */
+	smp_store_release(&nlk->groups, new_groups);
+
+	/* Then publish the new size: pairs with smp_load_acquire() from
+	 * lockless readers, so that they can not read NLGRPSZ(new ngroups)
+	 * bytes from the old buffer.
+	 */
+	smp_store_release(&nlk->ngroups, groups);
 
-	nlk->groups = new_groups;
-	nlk->ngroups = groups;
  out_unlock:
 	netlink_table_ungrab();
+
+	if (old_groups)
+		kfree_rcu_mightsleep(old_groups);
+
 	return err;
 }
 
@@ -2705,12 +2724,19 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 	} else {
 		struct sock *s = v;
 		struct netlink_sock *nlk = nlk_sk(s);
+		const unsigned long *groups;
+
+		/* Lockless read : netlink_realloc_groups() can change
+		 * nlk->groups under us. The old buffer is freed after an
+		 * RCU grace period, and this walk is RCU protected.
+		 */
+		groups = READ_ONCE(nlk->groups);
 
 		seq_printf(seq, "%pK %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8llu\n",
 			   s,
 			   s->sk_protocol,
 			   nlk->portid,
-			   nlk->groups ? (u32)nlk->groups[0] : 0,
+			   groups ? (u32)groups[0] : 0,
 			   sk_rmem_alloc_get(s),
 			   sk_wmem_alloc_get(s),
 			   READ_ONCE(nlk->cb_running),
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 0b3e021bd0ed29edc094fad2c79c7c067edcdd50..7979bd9b26060ea1812a7b4ac09f74ea74ff0759 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -12,12 +12,24 @@
 static int sk_diag_dump_groups(struct sock *sk, struct sk_buff *nlskb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (nlk->groups == NULL)
+	unsigned long *groups;
+	unsigned int ngroups;
+
+	/* Hashed sockets are dumped from the rhashtable walk, which only
+	 * holds rcu_read_lock(), while netlink_realloc_groups() can replace
+	 * nlk->groups and nlk->ngroups at any time.
+	 *
+	 * Read nlk->ngroups first : this pairs with smp_store_release()
+	 * from netlink_realloc_groups(), so that we can not use the new
+	 * (bigger) size with the old (smaller) buffer. The old buffer is
+	 * freed after an RCU grace period.
+	 */
+	ngroups = smp_load_acquire(&nlk->ngroups);
+	groups = READ_ONCE(nlk->groups);
+	if (!groups)
 		return 0;
 
-	return nla_put(nlskb, NETLINK_DIAG_GROUPS, NLGRPSZ(nlk->ngroups),
-		       nlk->groups);
+	return nla_put(nlskb, NETLINK_DIAG_GROUPS, NLGRPSZ(ngroups), groups);
 }
 
 static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
-- 
2.55.0.1007.g17ff1f9808-goog

