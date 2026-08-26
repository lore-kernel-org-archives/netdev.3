Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B93C0A09
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745558; cv=none; b=NX5PVqV7tkZ5IKlG9o2QSr5yOgnXiODe+Nn4D/ixhfLX2UgG0ZHBsB/fu3CXM4ThbzV6+Nhb01VQiquhNz109ZXPc6Ip8kagid00t6eMayHTjrJxS/vgidOJzwABATtYXaFYRhxVHWjMZcNBdHXuIUHvpvMZwfnHKq+jw/D0cRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745558; c=relaxed/simple;
	bh=V0lkkd2SLnjXkXHmscA4oZWJ6JRTnfmKDzQurpj273w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jdLzJjVpigChZFTpDuEv4S04tYjo1QZ4nj90WVHgQptExCykU7yNbXcwSMO62J8RG7PeqoqgzKdDHHIGQCTIUb0sDsJgh2HD5oE4pWYhpP0RoXJWsv8NXNJCTuUPmC68l8zBlBrxra24zUHd/0hKD7snCxc1+lzVtcAorsNKu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSFdvbCl; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSFdvbCl"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so85264185a.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787745555; x=1788350355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=srMG3e9/9HNSscOpo47zsqJQ+5Gyqnn1dFwcQ5rd78A=;
        b=JSFdvbClYrguB7g0r09GP1L1DNpAtHbpW47a7ZOfs3m4XyKwHEWW3wKfPI0O4SOkcU
         RMklOrkxaA3922CJh43ZKQn6yeUeSAKlEYUgVS9goLRYTSTpUXsuAzOc9Sj1gp2D4frS
         2WQEPy21CtXkcrtYRXcIuH4FcePLQqpXJn8JF52cYxcNe/unPT0DbttdXV7UnzXODp6i
         2pLCw8i1x4OmQEfyy9Yo3OSoYIPsA3wXiU0Ax+TIvng6XrR7EPGYh7OVGKq3lEJRWDkQ
         /iIhgnihOuYDrF/YzAOoHdy4JEPsyrgvJvV02rqwfM/EAvBozjEXkktIwIZcvUE/GcsU
         yJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745555; x=1788350355;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srMG3e9/9HNSscOpo47zsqJQ+5Gyqnn1dFwcQ5rd78A=;
        b=tRXiik+MJz67svkSoWTJV52jag3KiTC2CzJ4XDYU0NfpdvJ9TMcW4oUljNc20hIjnk
         APJaWyvERJnsMsWtXDk2POU2tQD7dDprBt4mE5cTGMVn/2vKSP3GtduVvVjrccDJwAV1
         pKF7hSd7s9BE9ldzrbDWFMAweSZaJbuDswWTEJZOPs0NCz9qJ2VfzSyeIN2I5LiWV/79
         fVOpzCz8dNWvtrb7UwiaieJ5LfD1AK//nk9n9rZWv7degnzbeQf2273rE+FiS/g47HAP
         x+cFmm33k4nOhg7eNkFDy4ZEvGRbT8gWBJYgpBnw3W/nBCA3jE4rcFKEq7l4fXhLeBbz
         9D+w==
X-Forwarded-Encrypted: i=1; AHgh+RphWeFjYQ0m6suokWoR4liDaNjfxv0h3cIq7zY8TLwychNScJ0JdrP+pDxm2C9y9Vu0101KVgA=@vger.kernel.org
X-Gm-Message-State: AFuF++mni/5x5BDIqJdPropNFoaYB7rY3gJdQNDteZVho3ZO1yHftitD
	H7mX8o7TVdJVL7DulQKV4MSNKdAsepJ/B2c9T5cdln+ARralF+jFugzuRd+Puq2KgjJvC0fpPU4
	EsviTmcqP+qc42g==
X-Received: from qkog2.prod.google.com ([2002:a05:620a:40c2:b0:92e:4e8d:f405])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:17a3:b0:915:688b:aba with SMTP id af79cd13be357-93780446b43mr484612685a.35.1787745554334;
 Wed, 26 Aug 2026 04:59:14 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:59:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826115913.3381537-1-edumazet@google.com>
Subject: [PATCH net] igmp: convert struct ip_sf_list to RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+a5a07d2f6a71972dc5ed@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Commit 23d2b94043ca ("igmp: Add ip_mc_list lock in ip_check_mc_rcu")
added spin_lock_bh(&im->lock) to ip_check_mc_rcu() to prevent a
use-after-free while iterating im->sources during concurrent deletions.

However, ip_check_mc_rcu() is called from RCU read-side critical
sections in packet receive and route lookup fast paths (e.g.
__mkroute_output(), ip_route_input_rcu(), and __udp4_lib_rcv()).

When igmpv3_send_cr() or igmpv3_send_report() holds &pmc->lock and
calls add_grec() -> igmpv3_newpack() -> ip_route_output_ports(),
an XFRM policy matching a multicast destination triggers
xfrm_tmpl_resolve_one() -> xfrm4_get_saddr() -> __mkroute_output() ->
ip_check_mc_rcu(). This attempts to acquire &im->lock while &pmc->lock
is already held on the same CPU, triggering a lockdep recursive locking
warning / deadlock.

Fix this by converting IPv4 struct ip_sf_list to RCU, mirroring the
IPv6 implementation in net/ipv6/mcast.c:

1. Add struct rcu_head to struct ip_sf_list and annotate sf_next,
   sources, and tomb as __rcu pointers.
2. Use rcu_assign_pointer() and kfree_rcu() for list updates and
   deletions.
3. Remove spin_lock_bh(&im->lock) from ip_check_mc_rcu() and traverse
   im->sources locklessly with for_each_psf_rcu(), reading and writing
   counter fields with READ_ONCE() and WRITE_ONCE().

Note: RCU conversion of /proc/net/mcfilter will be done in a
separate patch.

Fixes: 23d2b94043ca ("igmp: Add ip_mc_list lock in ip_check_mc_rcu")
Reported-by: syzbot+a5a07d2f6a71972dc5ed@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a8ed434.1d9ded08.62e62.00a9.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/igmp.h |   7 +-
 net/ipv4/igmp.c      | 204 +++++++++++++++++++++++++++----------------
 2 files changed, 132 insertions(+), 79 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 3a2d35a9f3078f12213f49cba90bd59582c134fc..a0cf0398519fd7fc8b05bc625a7f099a1ed6b82a 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -57,20 +57,21 @@ struct ip_mc_socklist {
 };
 
 struct ip_sf_list {
-	struct ip_sf_list	*sf_next;
+	struct ip_sf_list __rcu	*sf_next;
 	unsigned long		sf_count[2];	/* include/exclude counts */
 	__be32			sf_inaddr;
 	unsigned char		sf_gsresp;	/* include in g & s response? */
 	unsigned char		sf_oldin;	/* change state */
 	unsigned char		sf_crcount;	/* retrans. left to send */
+	struct rcu_head		rcu;
 };
 
 struct ip_mc_list {
 	struct in_device	*interface;
 	__be32			multiaddr;
 	unsigned int		sfmode;
-	struct ip_sf_list	*sources;
-	struct ip_sf_list	*tomb;
+	struct ip_sf_list __rcu	*sources;
+	struct ip_sf_list __rcu	*tomb;
 	unsigned long		sfcount[2];
 	union {
 		struct ip_mc_list *next;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b80b8a92f46e5f3dc4b9f906bec0a4035e4fbf70..5516329c9caa5f6f3ec7a2f633bda5d1a16eb4ec 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -188,6 +188,10 @@ static void ip_ma_put(struct ip_mc_list *im)
 	}
 }
 
+#define pmc_dereference(e, pmc) \
+	rcu_dereference_protected(e, lockdep_is_held(&(pmc)->lock) || \
+				     lockdep_is_held(&(pmc)->interface->mc_tomb_lock))
+
 #define for_each_pmc_rcu(in_dev, pmc)				\
 	for (pmc = rcu_dereference(in_dev->mc_list);		\
 	     pmc != NULL;					\
@@ -198,13 +202,28 @@ static void ip_ma_put(struct ip_mc_list *im)
 	     pmc != NULL;					\
 	     pmc = rtnl_dereference(pmc->next_rcu))
 
+#define for_each_psf_mclock(pmc, psf)				\
+	for (psf = pmc_dereference((pmc)->sources, pmc);	\
+	     psf;						\
+	     psf = pmc_dereference(psf->sf_next, pmc))
+
+#define for_each_psf_rcu(im, psf)				\
+	for (psf = rcu_dereference((im)->sources);		\
+	     psf;						\
+	     psf = rcu_dereference(psf->sf_next))
+
+#define for_each_psf_tomb(pmc, psf)				\
+	for (psf = pmc_dereference((pmc)->tomb, pmc);		\
+	     psf;						\
+	     psf = pmc_dereference(psf->sf_next, pmc))
+
 static void ip_sf_list_clear_all(struct ip_sf_list *psf)
 {
 	struct ip_sf_list *next;
 
 	while (psf) {
-		next = psf->sf_next;
-		kfree(psf);
+		next = rcu_dereference_protected(psf->sf_next, 1);
+		kfree_rcu(psf, rcu);
 		psf = next;
 	}
 }
@@ -349,7 +368,7 @@ igmp_scount(struct ip_mc_list *pmc, int type, int gdeleted, int sdeleted)
 	struct ip_sf_list *psf;
 	int scount = 0;
 
-	for (psf = pmc->sources; psf; psf = psf->sf_next) {
+	for_each_psf_mclock(pmc, psf) {
 		if (!is_in(pmc, psf, type, gdeleted, sdeleted))
 			continue;
 		scount++;
@@ -494,7 +513,8 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ip_mc_list *pmc,
 	struct net *net = dev_net(dev);
 	struct igmpv3_report *pih;
 	struct igmpv3_grec *pgr = NULL;
-	struct ip_sf_list *psf, *psf_next, *psf_prev, **psf_list;
+	struct ip_sf_list *psf, *psf_next, *psf_prev;
+	struct ip_sf_list __rcu **psf_list;
 	int scount, stotal, first, isquery, truncate;
 	unsigned int mtu;
 
@@ -517,7 +537,7 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ip_mc_list *pmc,
 
 	psf_list = sdeleted ? &pmc->tomb : &pmc->sources;
 
-	if (!*psf_list)
+	if (!rcu_access_pointer(*psf_list))
 		goto empty_source;
 
 	pih = skb ? igmpv3_report_hdr(skb) : NULL;
@@ -533,10 +553,12 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ip_mc_list *pmc,
 	}
 	first = 1;
 	psf_prev = NULL;
-	for (psf = *psf_list; psf; psf = psf_next) {
+	for (psf = pmc_dereference(*psf_list, pmc);
+	     psf;
+	     psf = psf_next) {
 		__be32 *psrc;
 
-		psf_next = psf->sf_next;
+		psf_next = pmc_dereference(psf->sf_next, pmc);
 
 		if (!is_in(pmc, psf, type, gdeleted, sdeleted)) {
 			psf_prev = psf;
@@ -583,10 +605,12 @@ static struct sk_buff *add_grec(struct sk_buff *skb, struct ip_mc_list *pmc,
 			psf->sf_crcount--;
 			if ((sdeleted || gdeleted) && psf->sf_crcount == 0) {
 				if (psf_prev)
-					psf_prev->sf_next = psf->sf_next;
+					rcu_assign_pointer(psf_prev->sf_next,
+							   psf_next);
 				else
-					*psf_list = psf->sf_next;
-				kfree(psf);
+					rcu_assign_pointer(*psf_list,
+							   psf_next);
+				kfree_rcu(psf, rcu);
 				continue;
 			}
 		}
@@ -655,28 +679,29 @@ static int igmpv3_send_report(struct in_device *in_dev, struct ip_mc_list *pmc)
 /*
  * remove zero-count source records from a source filter list
  */
-static void igmpv3_clear_zeros(struct ip_sf_list **ppsf)
+static void igmpv3_clear_zeros(struct ip_sf_list __rcu **ppsf)
 {
 	struct ip_sf_list *psf_prev, *psf_next, *psf;
 
 	psf_prev = NULL;
-	for (psf = *ppsf; psf; psf = psf_next) {
-		psf_next = psf->sf_next;
+	for (psf = rcu_dereference_protected(*ppsf, 1); psf; psf = psf_next) {
+		psf_next = rcu_dereference_protected(psf->sf_next, 1);
 		if (psf->sf_crcount == 0) {
 			if (psf_prev)
-				psf_prev->sf_next = psf->sf_next;
+				rcu_assign_pointer(psf_prev->sf_next, psf_next);
 			else
-				*ppsf = psf->sf_next;
-			kfree(psf);
-		} else
+				rcu_assign_pointer(*ppsf, psf_next);
+			kfree_rcu(psf, rcu);
+		} else {
 			psf_prev = psf;
+		}
 	}
 }
 
 static void kfree_pmc(struct ip_mc_list *pmc)
 {
-	ip_sf_list_clear_all(pmc->sources);
-	ip_sf_list_clear_all(pmc->tomb);
+	ip_sf_list_clear_all(rcu_dereference_protected(pmc->sources, 1));
+	ip_sf_list_clear_all(rcu_dereference_protected(pmc->tomb, 1));
 	kfree(pmc);
 }
 
@@ -710,7 +735,8 @@ static void igmpv3_send_cr(struct in_device *in_dev)
 				igmpv3_clear_zeros(&pmc->sources);
 			}
 		}
-		if (pmc->crcount == 0 && !pmc->tomb && !pmc->sources) {
+		if (pmc->crcount == 0 && !rcu_access_pointer(pmc->tomb) &&
+		    !rcu_access_pointer(pmc->sources)) {
 			if (pmc_prev)
 				pmc_prev->next = pmc_next;
 			else
@@ -896,7 +922,7 @@ static int igmp_xmarksources(struct ip_mc_list *pmc, int nsrcs, __be32 *srcs)
 	int i, scount;
 
 	scount = 0;
-	for (psf = pmc->sources; psf; psf = psf->sf_next) {
+	for_each_psf_mclock(pmc, psf) {
 		if (scount == nsrcs)
 			break;
 		for (i = 0; i < nsrcs; i++) {
@@ -927,7 +953,7 @@ static int igmp_marksources(struct ip_mc_list *pmc, int nsrcs, __be32 *srcs)
 
 	/* mark INCLUDE-mode sources */
 	scount = 0;
-	for (psf = pmc->sources; psf; psf = psf->sf_next) {
+	for_each_psf_mclock(pmc, psf) {
 		if (scount == nsrcs)
 			break;
 		for (i = 0; i < nsrcs; i++)
@@ -1228,11 +1254,12 @@ static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im,
 	if (pmc->sfmode == MCAST_INCLUDE) {
 		struct ip_sf_list *psf;
 
+		for_each_psf_mclock(im, psf)
+			psf->sf_crcount = pmc->crcount;
 		pmc->tomb = im->tomb;
 		pmc->sources = im->sources;
-		im->tomb = im->sources = NULL;
-		for (psf = pmc->sources; psf; psf = psf->sf_next)
-			psf->sf_crcount = pmc->crcount;
+		RCU_INIT_POINTER(im->tomb, NULL);
+		RCU_INIT_POINTER(im->sources, NULL);
 	}
 	spin_unlock_bh(&im->lock);
 
@@ -1271,9 +1298,18 @@ static void igmpv3_del_delrec(struct in_device *in_dev, struct ip_mc_list *im)
 	if (pmc) {
 		im->interface = pmc->interface;
 		if (im->sfmode == MCAST_INCLUDE) {
-			swap(im->tomb, pmc->tomb);
-			swap(im->sources, pmc->sources);
-			for (psf = im->sources; psf; psf = psf->sf_next)
+			struct ip_sf_list *sources, *tomb;
+
+			tomb = rcu_replace_pointer(im->tomb,
+						   rcu_dereference_protected(pmc->tomb, 1),
+						   lockdep_is_held(&im->lock));
+			rcu_assign_pointer(pmc->tomb, tomb);
+
+			sources = rcu_replace_pointer(im->sources,
+						      rcu_dereference_protected(pmc->sources, 1),
+						      lockdep_is_held(&im->lock));
+			rcu_assign_pointer(pmc->sources, sources);
+			for_each_psf_mclock(im, psf)
 				psf->sf_crcount = in_dev->mr_qrv ?:
 					READ_ONCE(net->ipv4.sysctl_igmp_qrv);
 		} else {
@@ -1310,8 +1346,8 @@ static void igmpv3_clear_delrec(struct in_device *in_dev)
 		struct ip_sf_list *psf;
 
 		spin_lock_bh(&pmc->lock);
-		psf = pmc->tomb;
-		pmc->tomb = NULL;
+		psf = pmc_dereference(pmc->tomb, pmc);
+		RCU_INIT_POINTER(pmc->tomb, NULL);
 		spin_unlock_bh(&pmc->lock);
 		ip_sf_list_clear_all(psf);
 	}
@@ -1990,7 +2026,7 @@ static int ip_mc_del1_src(struct ip_mc_list *pmc, int sfmode,
 	int rv = 0;
 
 	psf_prev = NULL;
-	for (psf = pmc->sources; psf; psf = psf->sf_next) {
+	for_each_psf_mclock(pmc, psf) {
 		if (psf->sf_inaddr == *psfsrc)
 			break;
 		psf_prev = psf;
@@ -1999,7 +2035,7 @@ static int ip_mc_del1_src(struct ip_mc_list *pmc, int sfmode,
 		/* source filter not found, or count wrong =>  bug */
 		return -ESRCH;
 	}
-	psf->sf_count[sfmode]--;
+	WRITE_ONCE(psf->sf_count[sfmode], psf->sf_count[sfmode] - 1);
 	if (psf->sf_count[sfmode] == 0) {
 		ip_rt_multicast_event(pmc->interface);
 	}
@@ -2011,19 +2047,28 @@ static int ip_mc_del1_src(struct ip_mc_list *pmc, int sfmode,
 
 		/* no more filters for this source */
 		if (psf_prev)
-			psf_prev->sf_next = psf->sf_next;
+			rcu_assign_pointer(psf_prev->sf_next,
+					   pmc_dereference(psf->sf_next, pmc));
 		else
-			pmc->sources = psf->sf_next;
+			rcu_assign_pointer(pmc->sources,
+					   pmc_dereference(psf->sf_next, pmc));
 #ifdef CONFIG_IP_MULTICAST
 		if (psf->sf_oldin &&
 		    !IGMP_V1_SEEN(in_dev) && !IGMP_V2_SEEN(in_dev)) {
-			psf->sf_crcount = in_dev->mr_qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
-			psf->sf_next = pmc->tomb;
-			pmc->tomb = psf;
-			rv = 1;
-		} else
+			struct ip_sf_list *dpsf = kmalloc_obj(*dpsf, GFP_ATOMIC);
+
+			if (dpsf) {
+				*dpsf = *psf;
+				dpsf->sf_crcount = in_dev->mr_qrv ?:
+					READ_ONCE(net->ipv4.sysctl_igmp_qrv);
+				rcu_assign_pointer(dpsf->sf_next,
+						   pmc_dereference(pmc->tomb, pmc));
+				rcu_assign_pointer(pmc->tomb, dpsf);
+				rv = 1;
+			}
+		}
 #endif
-			kfree(psf);
+		kfree_rcu(psf, rcu);
 	}
 	return rv;
 }
@@ -2060,7 +2105,7 @@ static int ip_mc_del_src(struct in_device *in_dev, __be32 *pmca, int sfmode,
 		err = -EINVAL;
 		if (!pmc->sfcount[sfmode])
 			goto out_unlock;
-		pmc->sfcount[sfmode]--;
+		WRITE_ONCE(pmc->sfcount[sfmode], pmc->sfcount[sfmode] - 1);
 	}
 	err = 0;
 	for (i = 0; i < sfcount; i++) {
@@ -2083,7 +2128,7 @@ static int ip_mc_del_src(struct in_device *in_dev, __be32 *pmca, int sfmode,
 #ifdef CONFIG_IP_MULTICAST
 		pmc->crcount = in_dev->mr_qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
 		WRITE_ONCE(in_dev->mr_ifc_count, pmc->crcount);
-		for (psf = pmc->sources; psf; psf = psf->sf_next)
+		for_each_psf_mclock(pmc, psf)
 			psf->sf_crcount = 0;
 		igmp_ifc_event(pmc->interface);
 	} else if (sf_setstate(pmc) || changerec) {
@@ -2104,7 +2149,7 @@ static int ip_mc_add1_src(struct ip_mc_list *pmc, int sfmode,
 	struct ip_sf_list *psf, *psf_prev;
 
 	psf_prev = NULL;
-	for (psf = pmc->sources; psf; psf = psf->sf_next) {
+	for_each_psf_mclock(pmc, psf) {
 		if (psf->sf_inaddr == *psfsrc)
 			break;
 		psf_prev = psf;
@@ -2114,12 +2159,12 @@ static int ip_mc_add1_src(struct ip_mc_list *pmc, int sfmode,
 		if (!psf)
 			return -ENOBUFS;
 		psf->sf_inaddr = *psfsrc;
-		if (psf_prev) {
-			psf_prev->sf_next = psf;
-		} else
-			pmc->sources = psf;
+		if (psf_prev)
+			rcu_assign_pointer(psf_prev->sf_next, psf);
+		else
+			rcu_assign_pointer(pmc->sources, psf);
 	}
-	psf->sf_count[sfmode]++;
+	WRITE_ONCE(psf->sf_count[sfmode], psf->sf_count[sfmode] + 1);
 	if (psf->sf_count[sfmode] == 1) {
 		ip_rt_multicast_event(pmc->interface);
 	}
@@ -2132,13 +2177,15 @@ static void sf_markstate(struct ip_mc_list *pmc)
 	struct ip_sf_list *psf;
 	int mca_xcount = pmc->sfcount[MCAST_EXCLUDE];
 
-	for (psf = pmc->sources; psf; psf = psf->sf_next)
+	for_each_psf_mclock(pmc, psf) {
 		if (pmc->sfcount[MCAST_EXCLUDE]) {
 			psf->sf_oldin = mca_xcount ==
 				psf->sf_count[MCAST_EXCLUDE] &&
 				!psf->sf_count[MCAST_INCLUDE];
-		} else
+		} else {
 			psf->sf_oldin = psf->sf_count[MCAST_INCLUDE] != 0;
+		}
+	}
 }
 
 static int sf_setstate(struct ip_mc_list *pmc)
@@ -2149,27 +2196,31 @@ static int sf_setstate(struct ip_mc_list *pmc)
 	int new_in, rv;
 
 	rv = 0;
-	for (psf = pmc->sources; psf; psf = psf->sf_next) {
+	for_each_psf_mclock(pmc, psf) {
 		if (pmc->sfcount[MCAST_EXCLUDE]) {
 			new_in = mca_xcount == psf->sf_count[MCAST_EXCLUDE] &&
 				!psf->sf_count[MCAST_INCLUDE];
-		} else
+		} else {
 			new_in = psf->sf_count[MCAST_INCLUDE] != 0;
+		}
 		if (new_in) {
 			if (!psf->sf_oldin) {
 				struct ip_sf_list *prev = NULL;
 
-				for (dpsf = pmc->tomb; dpsf; dpsf = dpsf->sf_next) {
+				for_each_psf_tomb(pmc, dpsf) {
 					if (dpsf->sf_inaddr == psf->sf_inaddr)
 						break;
 					prev = dpsf;
 				}
 				if (dpsf) {
+					struct ip_sf_list *dpsf_next;
+
+					dpsf_next = pmc_dereference(dpsf->sf_next, pmc);
 					if (prev)
-						prev->sf_next = dpsf->sf_next;
+						rcu_assign_pointer(prev->sf_next, dpsf_next);
 					else
-						pmc->tomb = dpsf->sf_next;
-					kfree(dpsf);
+						rcu_assign_pointer(pmc->tomb, dpsf_next);
+					kfree_rcu(dpsf, rcu);
 				}
 				psf->sf_crcount = qrv;
 				rv++;
@@ -2181,17 +2232,19 @@ static int sf_setstate(struct ip_mc_list *pmc)
 			 * add or update "delete" records if an active filter
 			 * is now inactive
 			 */
-			for (dpsf = pmc->tomb; dpsf; dpsf = dpsf->sf_next)
+			for_each_psf_tomb(pmc, dpsf) {
 				if (dpsf->sf_inaddr == psf->sf_inaddr)
 					break;
+			}
 			if (!dpsf) {
 				dpsf = kmalloc_obj(*dpsf, GFP_ATOMIC);
 				if (!dpsf)
 					continue;
 				*dpsf = *psf;
 				/* pmc->lock held by callers */
-				dpsf->sf_next = pmc->tomb;
-				pmc->tomb = dpsf;
+				rcu_assign_pointer(dpsf->sf_next,
+						   pmc_dereference(pmc->tomb, pmc));
+				rcu_assign_pointer(pmc->tomb, dpsf);
 			}
 			dpsf->sf_crcount = qrv;
 			rv++;
@@ -2231,7 +2284,7 @@ static int ip_mc_add_src(struct in_device *in_dev, __be32 *pmca, int sfmode,
 #endif
 	isexclude = pmc->sfmode == MCAST_EXCLUDE;
 	if (!delta)
-		pmc->sfcount[sfmode]++;
+		WRITE_ONCE(pmc->sfcount[sfmode], pmc->sfcount[sfmode] + 1);
 	err = 0;
 	for (i = 0; i < sfcount; i++) {
 		err = ip_mc_add1_src(pmc, sfmode, &psfsrc[i]);
@@ -2242,7 +2295,7 @@ static int ip_mc_add_src(struct in_device *in_dev, __be32 *pmca, int sfmode,
 		int j;
 
 		if (!delta)
-			pmc->sfcount[sfmode]--;
+			WRITE_ONCE(pmc->sfcount[sfmode], pmc->sfcount[sfmode] - 1);
 		for (j = 0; j < i; j++)
 			(void) ip_mc_del1_src(pmc, sfmode, &psfsrc[j]);
 	} else if (isexclude != (pmc->sfcount[MCAST_EXCLUDE] != 0)) {
@@ -2262,7 +2315,7 @@ static int ip_mc_add_src(struct in_device *in_dev, __be32 *pmca, int sfmode,
 
 		pmc->crcount = in_dev->mr_qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
 		WRITE_ONCE(in_dev->mr_ifc_count, pmc->crcount);
-		for (psf = pmc->sources; psf; psf = psf->sf_next)
+		for_each_psf_mclock(pmc, psf)
 			psf->sf_crcount = 0;
 		igmp_ifc_event(in_dev);
 	} else if (sf_setstate(pmc)) {
@@ -2278,13 +2331,13 @@ static void ip_mc_clear_src(struct ip_mc_list *pmc)
 	struct ip_sf_list *tomb, *sources;
 
 	spin_lock_bh(&pmc->lock);
-	tomb = pmc->tomb;
-	pmc->tomb = NULL;
-	sources = pmc->sources;
-	pmc->sources = NULL;
+	tomb = pmc_dereference(pmc->tomb, pmc);
+	RCU_INIT_POINTER(pmc->tomb, NULL);
+	sources = pmc_dereference(pmc->sources, pmc);
+	RCU_INIT_POINTER(pmc->sources, NULL);
 	pmc->sfmode = MCAST_EXCLUDE;
-	pmc->sfcount[MCAST_INCLUDE] = 0;
-	pmc->sfcount[MCAST_EXCLUDE] = 1;
+	WRITE_ONCE(pmc->sfcount[MCAST_INCLUDE], 0);
+	WRITE_ONCE(pmc->sfcount[MCAST_EXCLUDE], 1);
 	spin_unlock_bh(&pmc->lock);
 
 	ip_sf_list_clear_all(tomb);
@@ -2866,20 +2919,19 @@ int ip_check_mc_rcu(struct in_device *in_dev, __be32 mc_addr, __be32 src_addr, u
 		rv = 1;
 	} else if (im) {
 		if (src_addr) {
-			spin_lock_bh(&im->lock);
-			for (psf = im->sources; psf; psf = psf->sf_next) {
+			for_each_psf_rcu(im, psf) {
 				if (psf->sf_inaddr == src_addr)
 					break;
 			}
 			if (psf)
-				rv = psf->sf_count[MCAST_INCLUDE] ||
-					psf->sf_count[MCAST_EXCLUDE] !=
-					im->sfcount[MCAST_EXCLUDE];
+				rv = READ_ONCE(psf->sf_count[MCAST_INCLUDE]) ||
+					READ_ONCE(psf->sf_count[MCAST_EXCLUDE]) !=
+					READ_ONCE(im->sfcount[MCAST_EXCLUDE]);
 			else
-				rv = im->sfcount[MCAST_EXCLUDE] != 0;
-			spin_unlock_bh(&im->lock);
-		} else
+				rv = READ_ONCE(im->sfcount[MCAST_EXCLUDE]) != 0;
+		} else {
 			rv = 1; /* unspecified source; tentatively allow */
+		}
 	}
 	return rv;
 }
-- 
2.55.0.860.g4b6b3295ed-goog

