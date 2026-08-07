Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC636E46C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126652; cv=none; b=I3grrzUyk0+ew9uUPYl9P7XbeZPs9lsM46s5wTpUXOYa2AdS5oj0iXU62Vgr/PfhfLXUrfxjLr4PqMkYfif1XrSSSHFewLQpGaUOsVWF4YgGGsY3PjaY3GOJo/eH6s0AlQiFpbrGuDGxc8xuMHORsJmonc+tl1AC3QACDcZ5lUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126652; c=relaxed/simple;
	bh=iHqdeXDvyAh8OuI3xDZM2Mg8lwsinPA8tT43LXr/qDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jviIuU8ObjtmAKzApGoe5xBNnVANXRXE3VaqbkJcBqeoQPTEGSosWCo+pqEHZgh1tYcDnhQFBP6i330QDjk06G25ZZ6POt/g5aEclsvprnwH5lO/f5uQfozHPPwIRC3ON+cMXc5US+ieQP/FaBLgyUf1C1vHWC59ux7UDWsteZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkOWBv+z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkOWBv+z"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe41618110so338889a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786126650; x=1786731450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8YehZV8pGgThZgWk/4T4DcEH08k8INHztawGZMSNBxg=;
        b=RkOWBv+zoJSKKl3WaJQqSc0AGch/Bt253cNcGlUplcaHkPc/Mk1HoyVkfOm0EX6PuR
         iXHnT0xHm2d4JR0TiszLzCg4MIu7zCw8EVW3A4abxbo+ZTUbMSX1Tre6qXlZ+dXllOnz
         f79Zc4DlyQ/Cl+fA/WltE4rJqaZ9SpnTVsRkeB8K5QFn9cUlGxjO+yVsLMGZF9rhcC/r
         4ZuDpGIfTD1oLIW8tJavTa4TwWFQgoxDxSPTvgrC8SpYl+EWMblNywcm6+g+Lwm0/iC2
         AvJmCSNTtXVRfgfl5rh9gYrnLfCcTn+AC0DURlRBuFT4i+yOpT3/pyCFJ1f4JCOXoSZT
         g/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126650; x=1786731450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YehZV8pGgThZgWk/4T4DcEH08k8INHztawGZMSNBxg=;
        b=Fazx58uhedxFf2Q/e2Lp5+71M+/kCe7lziR0tUAgD44gZJfBPlFePz1te58Gk5lFww
         rb1buQWC6GpO57p2Rxo7FW7u9JrwQGe/cSJzH5DAXK4X++cdRNw9Mcbrfihh1Qq1o0hm
         r+2EsIZ1rGTw/w89GJZqAwhcaUKqLgUTPmQA5NxnhXySrzImFvNKoKEILVlo4vXZjUWi
         ytXt0XdFDsc69mdh7bLnhb7ibJwf33D19jwosOVEv9NVttFj5i1Jx2fbNnPgfU7H1Fgw
         TNjjxTJkTxtA36NZwb3Md1eS+bMfU4o+ElmRWNsHL/aA3svMnsXhcrIwC+0/kigoIr5x
         UdgA==
X-Gm-Message-State: AOJu0YzsmKxCIw5MZSU5+hxrB21u9VS2NhW5mnYYaz25bFXissprPbql
	JIK7C0E06X9a2d8pui+GXRF78vNWuUu3nq/xTh5hqhqOwQ+sJg3Xi+mL
X-Gm-Gg: AR+sD11OA58mTODwJU8Tl5mVOaJcBKjqaf8XPzxq9Yc7ejA7apP/BQWNzJ/lUCiK+D1
	q87xmVKz9AuQkXQMf+VVnm/zkfl8qyAYlxf8HWx07PHC8FKr8W7d2n+SCKJzIbRr823ZVFQ2VxG
	TYHbk3FrAGtiD4aiAFlpl+Pqp8JLTEVwVa4ACq6Ehp2aRoR+9yqYcFgS4op+gH8q4C9Wnestf7m
	cMnqdQuogyMM/qeReFhaMmDBPOq1qpIhf+B698KjlFmCcq8Jr1Yi1ctSAv+IwejSvokbzSJeOtZ
	aL0lY4f1epcF5AZmBcDI1Hy1dtPLRKndxAlWtorOR5aZTOdHi45G2PzSdbEDpKFSe9znB+3Akty
	x+w0nbhKvUfncJEmAfWpAFu+lIIARHGhJt6i+dIUSWgxvqfa7wiwaPjW7hTPruoZTnRjkMibeeg
	RxBurtiXNe0GKBVr93iK8CnbTDYYDKKrfUL2hQ7FqhPMM+6Z4IThpL+DxhEzT1s3+ys/iNxCIey
	l2wk43jGHHDipCjPsloRYejJmujx9V1Ow==
X-Received: by 2002:a17:903:1b2b:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2d0caa9bb8bmr211590575ad.2.1786126650048;
        Fri, 07 Aug 2026 11:17:30 -0700 (PDT)
Received: from localhost.localdomain ([14.216.81.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbeaaa0sm12947345ad.50.2026.08.07.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:29 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] ipv4: fix use-after-free in fib_nhc_update_mtu()
Date: Sat,  8 Aug 2026 02:17:10 +0800
Message-ID: <20260807181710.1178747-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
RTNL does not serialize this walk with PMTU exception updates. The walk
uses rcu_dereference_protected() with a constant true condition without
holding fnhe_lock.

The following interleaving can therefore occur:

  CPU 0                              CPU 1
  fib_nhc_update_mtu()               update_or_create_fnhe()
    load fnhe                          spin_lock_bh(&fnhe_lock)
                                       fnhe_remove_oldest()
                                         unlink fnhe
                                         kfree_rcu(fnhe, rcu)
    <quiescent state>
    access fnhe after grace period

KASAN reported:

  BUG: KASAN: slab-use-after-free in fib_nhc_update_mtu+0x3df/0x410
  Read of size 8 at addr ffff888107d49000 by task poc/90
  Call Trace:
   fib_nhc_update_mtu+0x3df/0x410
   fib_sync_mtu+0x7a/0xd0
   fib_netdev_event+0x229/0x3f0
   netif_set_mtu_ext+0x33a/0x570
   dev_set_mtu+0x88/0x120

The same walk updates fnhe_pmtu and fnhe_mtu_locked. These fields form a
pair and other writers serialize them with fnhe_lock. RCU alone prevents
reclamation, but would still allow concurrent writers to leave a mixed
pair.

Walk the table under RCU and acquire fnhe_lock only while updating each
exception. RCU keeps the current entry alive while the short critical
section serializes its paired PMTU fields. This avoids holding the global
lock while scanning all 2048 buckets for every nexthop.

Fixes: af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU changes")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

---
Changes in v3:
- Walk the exception table under RCU.
- Move the PMTU update into route.c and take fnhe_lock around each entry
  update instead of exporting and holding it across the full table scan.

Link: https://lore.kernel.org/netdev/20260806133309.731709-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260731162938.3388534-1-nicoyip.dev@gmail.com/ [v1]
---
 include/net/route.h      |  2 ++
 net/ipv4/fib_semantics.c | 34 +++++++++++-----------------------
 net/ipv4/route.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f90106f383c5..45290177a33c 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -276,6 +276,8 @@ int fib_dump_info_fnhe(struct sk_buff *skb, struct netlink_callback *cb,
 		       u32 table_id, struct fib_info *fi,
 		       int *fa_index, int fa_start, unsigned int flags);
 
+void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig);
+
 static inline void ip_rt_put(struct rtable *rt)
 {
 	/* dst_release() accepts a NULL parameter.
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 78f84ae3ee12..0483519b7fb0 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1895,42 +1895,30 @@ static int call_fib_nh_notifiers(struct fib_nh *nh,
 	return NOTIFY_DONE;
 }
 
-/* Update the PMTU of exceptions when:
- * - the new MTU of the first hop becomes smaller than the PMTU
- * - the old MTU was the same as the PMTU, and it limited discovery of
- *   larger MTUs on the path. With that limit raised, we can now
- *   discover larger MTUs
- * A special case is locked exceptions, for which the PMTU is smaller
- * than the minimal accepted PMTU:
- * - if the new MTU is greater than the PMTU, don't make any change
- * - otherwise, unlock and set PMTU
+/* Walk the exceptions of a nexthop after its first hop MTU changed. The
+ * chain is RCU protected here, while fnhe_update_pmtu() takes fnhe_lock
+ * for the update of each entry.
  */
 void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 {
 	struct fnhe_hash_bucket *bucket;
 	int i;
 
-	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	rcu_read_lock();
+	bucket = rcu_dereference(nhc->nhc_exceptions);
 	if (!bucket)
-		return;
+		goto out;
 
 	for (i = 0; i < FNHE_HASH_SIZE; i++) {
 		struct fib_nh_exception *fnhe;
 
-		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		for (fnhe = rcu_dereference(bucket[i].chain);
 		     fnhe;
-		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
-			if (fnhe->fnhe_mtu_locked) {
-				if (new <= fnhe->fnhe_pmtu) {
-					fnhe->fnhe_pmtu = new;
-					fnhe->fnhe_mtu_locked = false;
-				}
-			} else if (new < fnhe->fnhe_pmtu ||
-				   orig == fnhe->fnhe_pmtu) {
-				fnhe->fnhe_pmtu = new;
-			}
-		}
+		     fnhe = rcu_dereference(fnhe->fnhe_next))
+			fnhe_update_pmtu(fnhe, new, orig);
 	}
+out:
+	rcu_read_unlock();
 }
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 152d8cb28f65..b82401a6baed 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -741,6 +741,35 @@ static void update_or_create_fnhe(struct fib_nh_common *nhc, __be32 daddr,
 	spin_unlock_bh(&fnhe_lock);
 }
 
+/* Update the PMTU of an exception when:
+ * - the new MTU of the first hop becomes smaller than the PMTU
+ * - the old MTU was the same as the PMTU, and it limited discovery of
+ *   larger MTUs on the path. With that limit raised, we can now
+ *   discover larger MTUs
+ * A special case is locked exceptions, for which the PMTU is smaller
+ * than the minimal accepted PMTU:
+ * - if the new MTU is greater than the PMTU, don't make any change
+ * - otherwise, unlock and set PMTU
+ *
+ * fnhe_lock keeps fnhe_pmtu and fnhe_mtu_locked consistent against
+ * update_or_create_fnhe(), which sets both under the same lock.
+ */
+void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig)
+{
+	spin_lock_bh(&fnhe_lock);
+
+	if (fnhe->fnhe_mtu_locked) {
+		if (new <= fnhe->fnhe_pmtu) {
+			fnhe->fnhe_pmtu = new;
+			fnhe->fnhe_mtu_locked = false;
+		}
+	} else if (new < fnhe->fnhe_pmtu || orig == fnhe->fnhe_pmtu) {
+		fnhe->fnhe_pmtu = new;
+	}
+
+	spin_unlock_bh(&fnhe_lock);
+}
+
 static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flowi4 *fl4,
 			     bool kill_route)
 {
-- 
2.43.0

