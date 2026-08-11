Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882F390204
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415095; cv=none; b=s1YnF2s9df568qB7Qz0MbADzRvaR/4qZ0qN4ltcFoeMTgRjMvRqOHsR8ewb49RM4h0Yahjgi2asEuc7WngfZqOZ3H/fvrqZ4NTAAuadNBkWfRsFXyp7tE6h2GGzCLVMlfHHuoWWMQiM59do70Fk+lSmBZu2Vgraq0vaqRY95JgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415095; c=relaxed/simple;
	bh=N/ZUDdGYAyUW/zivZ/z/GPgDOzZUitHgY+9oMowjKRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jma9HKUfmm0t9Qay9DjxpFZgvgr7/VLEZQpcqtWc8AxjgQYTMm881gnsRnFgAb4Md69TLlDyhaycBfO/1w3FTlqGhm+2ENeotylwJ2zMDTXs94WpgfPuiOlgykCQ3uHTJBv/htJWPj8ynI/N0mFkePAINCi7Yoiyjm3aEnaebTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtQD1v/L; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtQD1v/L"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc640dfde3so33403375ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415093; x=1787019893; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5UXF9WF/ApTaePQGCdCcU+QE8dH9Q5x4NXOPYDuF2o=;
        b=DtQD1v/LurFMbmK6TZNLt0T5T7y9zvqdVF+pCqFrNm5u2JSPfrcfaHoJBVJ51MZKiR
         r4Tz7fgTnlugElH1HrteXZCw1xMYtYSbv6+xVI6Wnvvk47F0xPdZZ3InTk9BshE92Hr9
         kyxb8BHTm8qP5grZxd1aHCf8ol7NAz18Y9fjNZG20tB5aHCUsmP+B2QR9zgMbXKRl22F
         e0lGqMRVwKtzCNbN1eEp2lNHSC5ikNArw/ppcy0z6KVbiYo2jhzxHE0dYBXFNElFQRJc
         2oEfaFbmAEtztGAmRugVnCN7akbMbKh1fowYX8mTPrHoDT/2Zp+PMk25HjqsnFB3OJrT
         ECKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415093; x=1787019893;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5UXF9WF/ApTaePQGCdCcU+QE8dH9Q5x4NXOPYDuF2o=;
        b=nQAStW1eTcaabqetgcnsBWwIKyjQ0GdebsFoWyB0ZAdSBx/50ZFJxVFSFWtT72z8/6
         rUtBEB+tFOKxFDrXdO4D95cuk/8sMYaBARVCi2e4PMttl2mLJfi3IXKAfeCb0DC1QTb3
         BaUe+9OmKTItK50Qxm3mIezE1tMRRaMUVF6S9yG6qjsfc+o1JB6eHgSXBHSz8nwCYpC9
         E52IpsL/iD2yH4rHBAdsX41JDeioNUdp6qN3XtDp9qouHXFBfQGKox3+adOVEdzcIydv
         1LTGUxB5L2H0dJdQRCdSfYd6gHHsh90AHbE05DhpR7/fIECRbPR1L6alyHEvpQXKt7eZ
         DPIA==
X-Forwarded-Encrypted: i=1; AHgh+RoYUhp4f8bEZjtormhWohccWRrojlQ2144O2Oi2FwDULtQEZfu2LjMSBydRhDYo6gLSnV9snnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12Ihe+onPvvOahyZGsEIUyIgfPrWwiJV0UUZyCDbWKsXXDNVH
	H6suVfHeBMyyoZFA+makeUb8GbwD66uEx7parzqKuETfiRp+QUR4195esXClYTuJCiYI7fTIIwc
	hQFc+Cg==
X-Received: from plhq17.prod.google.com ([2002:a17:903:11d1:b0:2c7:de3c:549e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a83:b0:2c9:c952:6e9
 with SMTP id d9443c01a7336-2d317785d98mr2098975ad.2.1786415093177; Mon, 10
 Aug 2026 19:24:53 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:36 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/15] neighbour: Remove __neigh_for_each_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit 6deb53595092 ("net: remove unused ATM protocols
and legacy ATM device drivers"), there is no in-kernel user of
__neigh_for_each_release().

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
2.55.0.691.gc56d675ccc-goog

