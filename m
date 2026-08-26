Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F63C277C
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740641; cv=none; b=idmWG8KCqduVtwn5mGvTt6A9r8Hahg67LbPcTBxKV9X3g6oLgICgBe+voAqXB8ku5dI4Oj9g2/Ge3tnoSXFJHv7hu4QGFqDYV+iiP64OzEm7zjKZ0WXOmzYsX7t67W/rVkFa5W3TU4l9Iy74E5/nsIsRtAXdJx6NjOm8fzLjtI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740641; c=relaxed/simple;
	bh=ya+buSE/kJ2UpHFtq+7foi2eWZDEg6EnY3Hevyu0tTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=psgRzQxNTQt4veCzx+KKkniRdBhQ9WTlSJejiHVyCXXF9uiezlRu0Ma3qUKgNfA8qHpiRoaSnsfCgfVf5DOebIxzO0wNSYy+dMw8Tz3fIwK//+MuxZeRt8ubMeoZAFFfACfqSJueI1DMHM0rd3/5r5wcJZ4YPWsakTbKQXQMnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZeauH02E; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeauH02E"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so69518285a.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787740639; x=1788345439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SgcjFk2z0J94B2emamXgbLtJPahGmrgcFRaGIilhMi0=;
        b=ZeauH02EqRAtBsJYQy2Ps2Otr0L7HhVq4VpslGFJCBZuJMB1xKxCZqxNcFmwjVSxOs
         aMqiB2pMKFJzjDWuigr0HDpC+NUKm763XG2+JC3S7NsUrF+wYtIH1bUlQSqduG6GmtXu
         4cTZO09IOfSRCAuh/OzvqjqlqyVTPBihanJvXLIJlaZpJu2Ti1GOxBFn8KrTeGtETM+D
         C4r74Rt4q3LXSlrQbceoCYb+/OMsxEwR1TZrsrwccioLhosJSbw1WqP+hoeUiZNyBcsO
         3pwIBVfbnZoICUZKwtfn733K9ibX/XDb6q2ku0LFP0vSBI0ghgXwg955tqN3UeeKYyEc
         DG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740639; x=1788345439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgcjFk2z0J94B2emamXgbLtJPahGmrgcFRaGIilhMi0=;
        b=IN5NO/Dzc78smJLc3QKCKoJJ39sGWh6kn12kqaOqcw1ME/b6OLU0IY0QIOSnpE5tLz
         KmABzwuuQfiYXqPc8xgBgR/jdK+/241DPjahgZHprbcJvXhGs+b6Udyr2Fk1EsPMgwqb
         QbuBrOUchZaFTVQ0B8viJqGF+E03PeokUibMMLQHiGREL4UAlL8r3ODmB/Mt3DYPBch/
         s2pOEwvFXpHneRPzA3Ua/YhfcopWfZVuPh0FuiNav6dbzPNvyxuvIOjp3BlAzctiwID3
         mQH9Gy5mUQV4JoZsgJ/Av1UWh+B2nYK+OxHI35uD9UKySBtq9+CeIhn+W2zuoDJb/gDJ
         PEHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbNjXrqyNWNQN7OGgfEIHIJotRqGWNtf7mLBbKm/0G8BawMGlwA2u8lDkY3hyxxBVckaZlP80=@vger.kernel.org
X-Gm-Message-State: AFuF++mH7FSmnlogxqQUN4/3CyIZ4Op24F4Fbb+vsl2G7c/oAeRH66oI
	6uengnMLtyshw/6djp1Q/UxpLZbxbR2GI6OFDCo5LMlMkjpOnvk2+wYeNznVnjFX+RYe/3YrcnJ
	OgZ4zcf1nYbYziQ==
X-Received: from qkcc23.prod.google.com ([2002:ae9:e217:0:b0:92e:ee45:7631])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:b8f:b0:936:c026:be61 with SMTP id af79cd13be357-9378016ac83mr370881385a.13.1787740638579;
 Wed, 26 Aug 2026 03:37:18 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:37:10 +0000
In-Reply-To: <20260826103711.3302915-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826103711.3302915-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826103711.3302915-5-edumazet@google.com>
Subject: [PATCH net 4/5] ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
index 44fdde940dcdcd16a7642b2be60c6866c574ce92..a90dddba719726f36e0d5176c5e0574d1a488d5e 100644
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
@@ -799,9 +802,11 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
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
@@ -981,7 +986,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 		return -ENOMEM;
 	}
 
-	rcu_assign_pointer(mc->next, idev->mc_list);
+	rcu_assign_pointer(mc->next, mc_dereference(idev->mc_list, idev));
 	rcu_assign_pointer(idev->mc_list, mc);
 
 	mld_del_delrec(idev, mc);
@@ -1015,7 +1020,8 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 
 			WRITE_ONCE(ma->mca_users, new_users);
 			if (new_users == 0) {
-				*map = ma->next;
+				rcu_assign_pointer(*map,
+						   mc_dereference(ma->next, idev));
 
 				igmp6_group_dropped(ma);
 				inet6_ifmcaddr_notify(idev->dev, ma,
-- 
2.55.0.860.g4b6b3295ed-goog

