Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EBD27FB37
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287613; cv=none; b=NZ6QusOw4/l7OcTXVO9J/82wt9qsu1hNjcQHwI62KDnY7LJ+LBis+1UI1hBFyAeKuyUT7gXfwWADSQLl/WrtUmLJOQmfX8+V0St3t+76LL+oukm/28Hs28/C52HX3fwHmQIs+epzYks7fTB+EwuPDgmV508O2H2IkkiAAEpcUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287613; c=relaxed/simple;
	bh=phfX1FoWeDlAqDM7oAI1ohXm9XEgQkO45Ol1AGLXuuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOtpyj4r7Dx6KdbzNIemkXS0qIiam+lZBXQegnr9+HlRZDTG0qtfa73Agi6GqlbYglYPrJ1tnQwStmDboZk9D3+tbwbxzB9YtstisgImHDIbbWyVxpPsPNRvAJnTbSowkzR0006Vk1F77XA8vS4/QalTdK7pEj0S3CZJxd/hhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1lNz50y; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1lNz50y"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85321e37104so170437b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287612; x=1788892412; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chr9RRrsxXKdogNvQOPic+GvuwOBxly4Zu93Y98CVcc=;
        b=L1lNz50yDa0VrprJ/eaKjNVpKtbhPni0eFK9aIxNT409nxni+QhsNBkVgL7APSpivr
         fUf2lqkYpNxV4EEZoat4olJsnP5BcLqHJZ6cIWWQNVCBS+ztcE3+jW5ttWxwUwZ6GXE0
         SMYbtsL+iZPNx+PbXJ7mFSlg9jFi+H+MQTM9a/hVn63HrTgRO4mqe9AvRAys+SJRf0cG
         FmIIe67OjBBDcVyo/tPHmZZaS+7eLYwdzJYAcfbqR8Fsh5unKpfQSD0d9iDwwU/zkV9x
         OsZ1UjOQVzfMK9LvMp8OvqNQ+F57hDVOmPijUDixJ5PAkcaz2TT6MKujjjplHm2Hxpsr
         f6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287612; x=1788892412;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=chr9RRrsxXKdogNvQOPic+GvuwOBxly4Zu93Y98CVcc=;
        b=h4M+BlWJPOH4y7rVcOqmhWao1Qr5rAHrLcqI78WREp+sPM8/KpHQa0EuTGCL9n8eNK
         TXd/y7Kd8/8TsHCXXYoBDrblHtViBJjVDliIOte8gRYIhWLsCWDYvvrOzgg5xuLOn6Ac
         efNtVtfGGpWkv5aMNcwnCgzrPEBoi1n0IkharlddkJ7pK4g1Bbefx5RMTYkdSqyLN3nd
         Z8SbJOAUZmLwRbouiHLZi8N4qyKClUPeYFbGlX7hpxtYMpswbrF5z0qSRvlsHuoaK7i3
         aKUV7M8LD513JbZUdGDxrl1Q/9I3roF/GCbO5cdCCPiutUt7E1HZKmyu/rsr1N2z9gR9
         ASjg==
X-Forwarded-Encrypted: i=1; AHgh+RqykdblF9ykDWaf3Z4sMFbNwPMZsE+uye8kFIaiQvPhWYxr9sfvxFTPHMGg7N1kraeRSyFWUS0=@vger.kernel.org
X-Gm-Message-State: AFuF++lJdc8XD82tjneHbPt0PQNo+FPXxGmbnsfMbOuEHgB4MsDL2LT2
	NgMatGuzGu49NPbWospjtdk8L38WtfHjjBO0f1h849IHe4/QT4ya/ZtQwsJRoHMkVGr5MJ1mt67
	pxEv4rg==
X-Received: from pgdf25.prod.google.com ([2002:a05:6a02:5159:b0:cc1:5705:ff40])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d22:b0:3c4:396d:4a6c
 with SMTP id adf61e73a8af0-3d265a33636mr62610580637.5.1788287611476; Tue, 01
 Sep 2026 11:33:31 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:51 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-3-kuniyu@google.com>
Subject: [PATCH v5 net-next 02/15] neighbour: Remove __neigh_for_each_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

Since commit 6deb53595092 ("net: remove unused ATM protocols
and legacy ATM device drivers"), there is no in-kernel user of
__neigh_for_each_release().

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/neighbour.h |  2 --
 net/core/neighbour.c    | 31 -------------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc..7847c29496ae 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -405,8 +405,6 @@ static inline struct net *pneigh_net(const struct pneigh_entry *pneigh)
 void neigh_app_ns(struct neighbour *n);
 void neigh_for_each(struct neigh_table *tbl,
 		    void (*cb)(struct neighbour *, void *), void *cookie);
-void __neigh_for_each_release(struct neigh_table *tbl,
-			      int (*cb)(struct neighbour *));
 int neigh_xmit(int fam, struct net_device *, const void *, struct sk_buff *);
 
 struct neigh_seq_state {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..69a5f9dfa851 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3161,37 +3161,6 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 }
 EXPORT_SYMBOL(neigh_for_each);
 
-/* The tbl->lock must be held as a writer and BH disabled. */
-void __neigh_for_each_release(struct neigh_table *tbl,
-			      int (*cb)(struct neighbour *))
-{
-	struct neigh_hash_table *nht;
-	int chain;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct hlist_node *tmp;
-		struct neighbour *n;
-
-		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
-			int release;
-
-			write_lock(&n->lock);
-			release = cb(n);
-			if (release) {
-				hlist_del_rcu(&n->hash);
-				hlist_del_rcu(&n->dev_list);
-				neigh_mark_dead(n);
-			}
-			write_unlock(&n->lock);
-			if (release)
-				neigh_cleanup_and_release(n);
-		}
-	}
-}
-EXPORT_SYMBOL(__neigh_for_each_release);
-
 int neigh_xmit(int index, struct net_device *dev,
 	       const void *addr, struct sk_buff *skb)
 {
-- 
2.55.0.966.g6673acef38-goog

