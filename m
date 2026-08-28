Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E573E5A21
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906748; cv=none; b=Bf305gVLs108sPe8fCwXItmlLEALX1oV6Ekph5mXCbxnCMtGR8Tp92nFN6vyliT4eDAl0XNo4Q9qH63HtbFBDM7YtDF/nP/SWvGo91Cyn8RBiPDmjXXMRv/M6E0zNxjxsiRQGKftt9kVw/vjc0IUn3emruEZCgDJ795/ASBcBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906748; c=relaxed/simple;
	bh=mKPMeff3ITvX9TBhuc34HK/gU0Pymz6ubyE2WPP1SGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQlxISasQhdt59K2aOOHnhIKTILYMLYxXQ3j17+VVkGtijc/f4AXdHPu8f6lHih3Th/QTyfWQS6w2jrLYqpZYOjI7oGFctlQLT7p9AOPg0kDnA262aLAa95IFGXGT05oBX++ga4dwwOSiZCj+FH4/S0uRPGyX6o+/2N/LSI3Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cae/OTcl; arc=none smtp.client-ip=209.85.219.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cae/OTcl"
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ef8249f871so6306406d6.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906745; x=1788511545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTmkG1mJd7a0w+JixNvK735nzP/GgEQ/B6WOUEIvr1s=;
        b=Cae/OTclBu41WTqxff8IuWKrZkpAw1oVKyWOFCywnOG9h473nxxmjQDIXYnjUHaGwS
         fHlCb8WNUVRUFAebzQnu6nCdb0YnnFlLqe31DKoA9seYRppXWbCQo/cxqjkH+WbZHecm
         s8GoaWeUxcThUAZTA++KKCbogekuqh0xrRtImFt+6QlrJ1TKguWYYyF39RgIp4TQHxrm
         MU6ubhGjtTRNiWKkT1MJu6pz4GQiQynXkgkmjf7QpObLiiEeLESQTmaLwjLBUiRxvp81
         CKrHJi7aB1C9pJWhdvwjGaADNaXzYL21I0o+vXEkJrRPFAUizp7iOk7Gpj5MsUpBKzcj
         VlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906745; x=1788511545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTmkG1mJd7a0w+JixNvK735nzP/GgEQ/B6WOUEIvr1s=;
        b=LFyLA6obLJrzkXLEjWahm5Y/GT9l7xmwUFwUHWDKDoFyLRUIK1I+ZVxKT9YrmCY+cQ
         eSyETWdI5aZ2nwnr63WUzvXeA63FcIV3A57UkS/MkPE8oJtg40Tw7PRjcwEyZnUacWW2
         3uX4+W+eTo2wl1z+Bu0VLTiL8lVfnEv85+QH3FtlWt5s8lJZlmSNOn2z+pbEnHMXt09R
         8CQCrkqm+vVBUkmi+FTlCdS0M3MAcLCxu+6vKNJ3d+9nztrentqYz/28Lxz5vtE54n7o
         80uBu7Hjah8mdzNc4ty10aJoAHKHV+WlgS/XDgO9MmZmg5GWtsXa9Qcp7e8OixJuJUvG
         8gsw==
X-Forwarded-Encrypted: i=1; AHgh+RrJpKPyjrqbCm73vEqw3IQ+0894rczCH/yQFPtYoPr8OWeIU+qavoy/bs3vkjIs/3tfkz9zC9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nLUkTy04RAfqyELQmvtDJ/tYZosQF1yTt63FiyXrt/EZ3wBhRl
	a/pQo0tsCZ1EQuAjNze1mzRy42ONsYkldAMo9L9v2kcjuIRyKS+iDC5gOJ9yLNNyOtmgOR62RzW
	PGfEWZEk4kBLefw==
X-Received: from qvmt3.prod.google.com ([2002:a0c:e583:0:b0:907:5aad:bfd3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2a86:b0:90c:cce2:afcb with SMTP id 6a1803df08f44-90ce0f1d77bmr64393186d6.23.1787906744756;
 Fri, 28 Aug 2026 01:45:44 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:45:30 +0000
In-Reply-To: <20260828084531.1826790-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828084531.1826790-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828084531.1826790-5-edumazet@google.com>
Subject: [PATCH v2 net 4/5] ipv6: mcast: use rcu_assign_pointer() for __rcu
 list updates
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Several places in net/ipv6/mcast.c update RCU-protected lists
(np->ipv6_mc_list, idev->mc_list, idev->mc_tomb) using direct pointer
assignments instead of rcu_assign_pointer():

1. In __ipv6_dev_mc_dec(), unlinking a group from idev->mc_list did:
       *map = ma->next;
   without rcu_assign_pointer() while concurrent readers traverse
   idev->mc_list locklessly under rcu_read_lock().
2. In ipv6_sock_mc_drop() and __ipv6_sock_mc_close(), unlinking a group
   from np->ipv6_mc_list directly assigned *lnk = mc_lst->next and
   np->ipv6_mc_list = mc_lst->next without rcu_assign_pointer(), racing
   with lockless readers in inet6_mc_check().
3. In __ipv6_sock_mc_join(), mc_lst->next was initialized to
   np->ipv6_mc_list via raw assignment before publishing mc_lst.
4. In mld_del_delrec() and __ipv6_dev_mc_inc(), __rcu source pointers
   passed into rcu_assign_pointer() lacked explicit dereference helpers.

Fix these by consistently using rcu_assign_pointer() along with
mc_dereference() / sock_dereference().

Fixes: 456b61bca8ee ("ipv6: mcast: RCU conversion")
Fixes: 88e2ca308094 ("mld: convert ifmcaddr6 to RCU")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
---
 net/ipv6/mcast.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 4423b90dc9abffff9661da22caa4b9e2f618def7..2290457eb8d3dd7a8d19fa9bf19f97160b7d2492 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -240,7 +240,8 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 		return err;
 	}
 
-	mc_lst->next = np->ipv6_mc_list;
+	rcu_assign_pointer(mc_lst->next,
+			   sock_dereference(np->ipv6_mc_list, sk));
 	rcu_assign_pointer(np->ipv6_mc_list, mc_lst);
 
 	return 0;
@@ -300,7 +301,8 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	      lnk = &mc_lst->next) {
 		if ((ifindex == 0 || mc_lst->ifindex == ifindex) &&
 		    ipv6_addr_equal(&mc_lst->addr, addr)) {
-			*lnk = mc_lst->next;
+			rcu_assign_pointer(*lnk,
+					   sock_dereference(mc_lst->next, sk));
 			__ipv6_sock_mc_drop(sk, mc_lst);
 			return 0;
 		}
@@ -333,7 +335,8 @@ void __ipv6_sock_mc_close(struct sock *sk)
 	struct ipv6_mc_socklist *mc_lst;
 
 	while ((mc_lst = sock_dereference(np->ipv6_mc_list, sk)) != NULL) {
-		np->ipv6_mc_list = mc_lst->next;
+		rcu_assign_pointer(np->ipv6_mc_list,
+				   sock_dereference(mc_lst->next, sk));
 		__ipv6_sock_mc_drop(sk, mc_lst);
 	}
 }
@@ -798,9 +801,11 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 	if (!pmc)
 		return;
 	if (pmc_prev)
-		rcu_assign_pointer(pmc_prev->next, pmc->next);
+		rcu_assign_pointer(pmc_prev->next,
+				   mc_dereference(pmc->next, idev));
 	else
-		rcu_assign_pointer(idev->mc_tomb, pmc->next);
+		rcu_assign_pointer(idev->mc_tomb,
+				   mc_dereference(pmc->next, idev));
 
 	im->idev = pmc->idev;
 	if (im->mca_sfmode == MCAST_INCLUDE) {
@@ -980,7 +985,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 		return -ENOMEM;
 	}
 
-	rcu_assign_pointer(mc->next, idev->mc_list);
+	rcu_assign_pointer(mc->next, mc_dereference(idev->mc_list, idev));
 	rcu_assign_pointer(idev->mc_list, mc);
 
 	mld_del_delrec(idev, mc);
@@ -1014,7 +1019,8 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 
 			WRITE_ONCE(ma->mca_users, new_users);
 			if (new_users == 0) {
-				*map = ma->next;
+				rcu_assign_pointer(*map,
+						   mc_dereference(ma->next, idev));
 
 				igmp6_group_dropped(ma);
 				inet6_ifmcaddr_notify(idev->dev, ma,
-- 
2.55.0.897.gb25b4bd76c-goog

