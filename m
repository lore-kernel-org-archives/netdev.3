Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB93F4845
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145376; cv=none; b=PkCvKIwUJaYUUSmu/w1mBWZl70tinkQW/q3haKJHG+7+V5V8S9UrvqTqX2l2IbrGFPVVNrVgoXGdUknhXNRQC660yDhINfBOIKt5/xAcPm1eaGYjaC3ebw+x5HxLi2P44AU2K7QSsFiL0ufQnpK2ilI66bCHamx6ST6F1qRneNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145376; c=relaxed/simple;
	bh=OmpN6/0A6ira9q/KdqPD/SdhtPNDOzBSm1ugVtAQ7sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMdWT6XN4kNDUNd5RPLq4K4xTOv9nXdERR5aPZPvmutO3Q4+M3SuLVvmW4d0OEQjg0Ktw0jRr6M0YdlLMLff353JQ1DsypGVIPRVYmvENTadh6fSoER5RvXNhkh/MluebUT6cmDOInlqOANhtXRKev1Mhok5X9GqFQ5aLfu3jSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yi7P1q2Q; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yi7P1q2Q"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e024d2129so112673b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145375; x=1786750175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4smYRD0UYgKyriuQPGkmNrfE7wLz1kFYgUlyCs+ykA=;
        b=Yi7P1q2QsDjjWkxX1/K3DhcCU8CfjYVEjf9RS/RZcEzAMmI4QkXEbG84NlK/wkze2W
         PrmjSLBx4oQsKL0z4m1p4pX+LUy3+Ud3Nu9Vg+4HSTdqqe268+o/sDZIJtMeqP2+3ZfA
         6ms411sH69zRlJNolKrVVHLnDaBWKC6IVfIGFKjFIKTpw6+QAljOqKc2pkON8xMMjgCw
         NGLsCqzMPLGyFmjruQpbo+NxWirMkZb/HD14ymGQce2AMD5sLfs6QEkw2DfByhZcIUDC
         y9V9P7Yppc5Ya0gG5CHCSk5yM8UwoW5QCBBzyQahq1skKtyXLsYYNyVII5q0j349vbPE
         2mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145375; x=1786750175;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4smYRD0UYgKyriuQPGkmNrfE7wLz1kFYgUlyCs+ykA=;
        b=kDZcAtuVLt+AdPlb76zSwQkQN3eb54e+pr4L9Cu1/BZI3An930OxEP3/e9k7EjjQ4l
         C4mqMouBk9QNl4CAvFl+8/dPJQErcMMn90xrFcS5EY8wxppK8ujKNiTs/dCBgcl0tPZe
         sSHmluMfr5cY851MZNZ0ydafPmaZ07cpfDbxVosuFO2qojLjeCzFNumZbWdpZX3DPhMM
         0UAeTIS6QTwl+oPaXAxFmhhdjcTN9QzqWyfqalMXaAdsAfPsENwMUD750+q73XWlIKTZ
         ZPKEfDpiu0qEixjVrYpuZaW2mQwbrZoXMKTqoB+9vGEQ8V7cTOhaNClLINsIqVm/7dwA
         XFsw==
X-Forwarded-Encrypted: i=1; AHgh+RrTmVQk/Ww+Lw6xpjsRw5x4RUTmBxQDBdAUWdgQZ/n6NPZoKLB4MAdEtMyVCY2n+CD6cuTBK3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsxoaAqKSmN3VLXdTpBnqCneFZDpwd2ZYedLB6xi/lEbEinfZ
	3YF+3kFqyQqhMJSuO6EE8UfF+5sxxa+znZcYk6KvXt7ILjr5P5Gjbpho/N6YJC2BMFI3muHGlsV
	0OjCr+Q==
X-Received: from pfll27.prod.google.com ([2002:a05:6a00:159b:b0:848:335b:a5c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4086:b0:848:6895:b754
 with SMTP id d2e1a72fcca58-84f5e0c1d21mr8983346b3a.28.1786145374787; Fri, 07
 Aug 2026 16:29:34 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:39 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/13] neighbour: Remove __neigh_for_each_release().
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
2.55.0.679.g6767b8d81c-goog

