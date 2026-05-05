Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2803CC9E2
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965626; cv=none; b=C1ZSJbv+8hA1vsPBv0u5dUBFdcyzYl8dLv5s6rlTzWpWsHLpnFPbUlYeVdEvWSjBlwCvcSOYvhi1aXsSvXCf7IMf/CEB6EYXxI6CQqgPyXtGMLPqACjKJPXyHMYI2mH6AzMRzQfkJcbRnb6hfml6eF4IhBR3ZZeVkaoRuLrnfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965626; c=relaxed/simple;
	bh=lX3/cikTXdsSWmYhnFJIwfxPeUjb7oER4YyFpC9sMTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyymrhqgdhSfd+X1+/Tl2aZN6Pwv8SZxzOtU4aXD568aPvB7jD2eU6CeHXLescEq1RB4/CWFARWL7ERoPwtUeBjhLFao8lueyd3BBCXvGnTvAS3645RfoYpuFGaFZXZqvuNk/KJILbLo0UEWjBvK6kBsq1c1/x8rJ9PcIdxUhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnW2r4XU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnW2r4XU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83975e992e1so132397b3a.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965624; x=1778570424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwjbtkwr2FWhUlTbYPqxcC7rI+ouC/k6Ix4Q9N1Kqz8=;
        b=DnW2r4XUNE2mVbot61dbvBrf0XdqHa1YG+fsIrqUf5mEdHWwwilDYWzZAUlZLOy5Dp
         PmALLlnRN6lQN/O6v0GTHp6sODdqUGFTqlhbCUqhpaGXLj9mqHGEueOdSvAqi/yyHnCq
         KAEut3+y9gCmKqDBSReCNJl0NlZBkhl+52RrZeCO+vODDktuUutaL/XOfJS9Zscal3W5
         04JLGS0vskTzgmvF6rHK+jQ9blMoPhb5j5Pn/F5k4JNWjT0m08L239/uiEsvc9nxGiz3
         I9qkKlq8BNkhONPCpZUCqfYydcWOrJVljR61glvTzzd8i2GVccibX5aYDH6UZ5rDB4Uu
         T/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965624; x=1778570424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qwjbtkwr2FWhUlTbYPqxcC7rI+ouC/k6Ix4Q9N1Kqz8=;
        b=s1q3MHVmxW+hx5FBwhv1LQpXkZvLmvPAMTu+cIhqiUh514TbFhX+prDmBxUWSsI71v
         MPgvi+MZ/hnsLyZFoRMQxx7McaS56XLWIEhQl3uGPVm+l9ZwDOUbU1dBczMtjQw/uuHI
         a4U2AD+Z9MgBy4txA2Z8+peP0wr5VA0yAczVAcQjMZQqQKxUA2h9H7LdtinvjDTlQkLb
         zeASg8fGhSDfeqw5HfMMDupwF/DRv2Q+67YlgyY5wONaRcCxrlIc30E4mwuksQ4gbCR+
         /CEOQY2T4rLkdyNN/5iK/5oAUqxjgAsW39lBd9JcAtReAA/h7XYDVMWXLz09bLXC97RQ
         zQ6Q==
X-Forwarded-Encrypted: i=1; AFNElJ82VNxMJVkvRg61P6/USCM1vHnSq4qpxlGTOMIsosh+AP3Xjx4LUiDUotk9pi5BIkrfm6DXjKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PGhk09JtSmfQBAJSmC3qxjYCTf2YV8MJBklbbTQbEPTG2kMU
	hS8v5zo2qeHK+dr2SyYp9G78UqNG0KsSQuT+XyrFHJt7g81vtsiE6uUO
X-Gm-Gg: AeBDiesobXZ5qGl7MtbtK4PqkXXhNgT1RaROfQW4RVK+MtWymFoBqFLrL/4+EC7AQdA
	751hLkWfL9NeTJv4nK1eAXq5QVnnyNJuioGpkCcdBYN7WqafcvQNbx9GSPTS2/k1kAGwhxICmeq
	rhu/fGhAVE7egnj65cV6pgJi5blq1GCNCITUVBgCGHh+j9Z2pkmUSYieW81QWE6zTwHwwtWzPPy
	157x5sXcsz97CrkD5axPwwC5Fn2G7hJpX0km27df7LupObO8uYNh1l/KiB82PYJD1dEyF28HIic
	nZxNiy+OmWSsnFx5RY3QrLyaO1lmNIMkuzO0A45i6dx4o1xqld9BfCmRuCkoWY/q448J1zlg8Dl
	cLqO25DlOcHAloqn11agn6bNATvXYgd0xMsmtniKR/ojDTofA2+6nJsFeBe00GjA9TGTjAyD+gB
	kIGJuTnrbLF30NJkyEOFJEFGXAAR3ay9S4U9H5zS4C2LHnZ8NNodetr/psTrY6f/nE6O2pWg==
X-Received: by 2002:a05:6a00:2e17:b0:82f:5d4f:7355 with SMTP id d2e1a72fcca58-839242a6080mr2160599b3a.33.1777965623740;
        Tue, 05 May 2026 00:20:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a4bffsm1036227b3a.56.2026.05.05.00.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:20:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v7 1/2] ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
Date: Tue,  5 May 2026 15:20:14 +0800
Message-Id: <20260505072015.1672730-2-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mem_check() in net/ipv6/ip6_flowlabel.c reads fl_size without
holding ip6_fl_lock. fl_intern() takes the lock immediately
afterwards. The two checks therefore race against concurrent
fl_intern, ip6_fl_gc and ip6_fl_purge writers, which makes the
mem_check budget check approximate.

Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
fl_intern() into its only caller ipv6_flowlabel_get(). The
mem_check() call now runs under the same critical section as the
fl_intern() insert, so the budget check is exact.

With all writers and the read of fl_size under ip6_fl_lock,
convert fl_size from atomic_t to plain int. The four sites that
update or read fl_size are fl_intern (insert path), ip6_fl_gc
(garbage collector, the !sched check and the per-entry decrement),
ip6_fl_purge (per-netns purge), and mem_check (budget check), and
all four now run under ip6_fl_lock.

This is a prerequisite for adding a per-netns budget alongside
fl_size. The follow-up patch adds netns_ipv6::flowlabel_count and
folds it into mem_check().

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/ipv6/ip6_flowlabel.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..43b5e9ce9 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -40,7 +40,7 @@
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
-static atomic_t fl_size = ATOMIC_INIT(0);
+static int fl_size;
 static struct ip6_flowlabel __rcu *fl_ht[FL_HASH_MASK+1];
 
 static void ip6_fl_gc(struct timer_list *unused);
@@ -163,7 +163,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
 					fl_free(fl);
-					atomic_dec(&fl_size);
+					fl_size--;
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -172,7 +172,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 			flp = &fl->next;
 		}
 	}
-	if (!sched && atomic_read(&fl_size))
+	if (!sched && fl_size)
 		sched = now + FL_MAX_LINGER;
 	if (sched) {
 		mod_timer(&ip6_fl_gc_timer, sched);
@@ -196,7 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
 				fl_free(fl);
-				atomic_dec(&fl_size);
+				fl_size--;
 				continue;
 			}
 			flp = &fl->next;
@@ -205,6 +205,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 	spin_unlock_bh(&ip6_fl_lock);
 }
 
+/* Caller must hold ip6_fl_lock. */
 static struct ip6_flowlabel *fl_intern(struct net *net,
 				       struct ip6_flowlabel *fl, __be32 label)
 {
@@ -212,8 +213,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 
 	fl->label = label & IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock();
-	spin_lock_bh(&ip6_fl_lock);
 	if (label == 0) {
 		for (;;) {
 			fl->label = htonl(get_random_u32())&IPV6_FLOWLABEL_MASK;
@@ -235,8 +234,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 		lfl = __fl_lookup(net, fl->label);
 		if (lfl) {
 			atomic_inc(&lfl->users);
-			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock();
 			return lfl;
 		}
 	}
@@ -244,9 +241,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->lastuse = jiffies;
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
-	atomic_inc(&fl_size);
-	spin_unlock_bh(&ip6_fl_lock);
-	rcu_read_unlock();
+	fl_size++;
 	return NULL;
 }
 
@@ -464,10 +459,14 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
-	int room = FL_MAX_SIZE - atomic_read(&fl_size);
+	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
+	room = FL_MAX_SIZE - fl_size;
+
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
@@ -692,11 +691,19 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	if (!sfl1)
 		goto done;
 
+	rcu_read_lock();
+	spin_lock_bh(&ip6_fl_lock);
 	err = mem_check(sk);
+	if (err == 0)
+		fl1 = fl_intern(net, fl, freq->flr_label);
+	else
+		fl1 = NULL;
+	spin_unlock_bh(&ip6_fl_lock);
+	rcu_read_unlock();
+
 	if (err != 0)
 		goto done;
 
-	fl1 = fl_intern(net, fl, freq->flr_label);
 	if (fl1)
 		goto recheck;
 

base-commit: ebb639024ebd47a13a511cce6ae630c15e4b3126
-- 
2.34.1

