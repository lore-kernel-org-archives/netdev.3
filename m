Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985E3B388E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978717; cv=none; b=FdPNTuxz9Jy6v6G1oXIn0DXEv781J/wiQVINjJc8i04jz7c3wrbTtxZgNbUYuL+4OOIGTZd4n87tgLdebcVi1pM5Hpk/2Y0bPsfEvvSSF0wNrlx2onU+TTv6Kh8aeyQAPd+t2xtm3Nzzv5gmnJhsd2p+VhQedzJJWMhJOLIDrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978717; c=relaxed/simple;
	bh=OmpN6/0A6ira9q/KdqPD/SdhtPNDOzBSm1ugVtAQ7sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rdJ4RaMiYCjijp7YGXl7he09HcbKFJVIx7fojThPXinjW2msTKuOeIj/l7Fss5KJ8h8Ph17s9Mk3UX1oz5prnEjYu9ATrhp6uJSxnI/EHg/LvJW1mGRuZorR2V/gt06qoao2XD0vHLpCFNrNHtWTddq4fUHrXSCn2Kk2YDKOb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9CIXEBO; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9CIXEBO"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so464846a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978715; x=1786583515; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4smYRD0UYgKyriuQPGkmNrfE7wLz1kFYgUlyCs+ykA=;
        b=J9CIXEBOu2nOOUsGZbBDp1m/dABnJ897p/2VNFGfQxAdzY6rGj9XuLvy9lrBQ1U7Y/
         6xTpkjoBlpsuZW7oP8E1zLz4Qp0aZw8Hd4w//DKGyqca2e4F+LGFJUaqeXrs77CPpNN1
         wK6bqwhSiMD5tOQuanvS8Gv/hGp2ULsxgZd2J0b3gsTyt2OFt/+ue3es0C3NelG56Yi5
         rFh8G419t0KgPrBmic6rArjI1vMsOWvMy0PJk8iv9LcDfuZgPH8+feRGBZ368T0/rQwN
         6Z2mFjOhlHmFFR+AXu+kVgEj+/ylikwnXo8g/S/6kzlMiQGZF+wux4V/3xkclRzBaBZL
         YlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978715; x=1786583515;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4smYRD0UYgKyriuQPGkmNrfE7wLz1kFYgUlyCs+ykA=;
        b=n5ksnwVHmTu5gXZ6nbkIkW7Qpuw5XojNz0UlEYoqpFg/6vi/rGo74YF6Suj/Po5any
         c8FTrXkTRVeCn+HRfgu9v3cfDX3eGSdT+qXMy8S9/zNSf3DkuxhHOx3KlHF8eP3d8sUx
         TEitYT9ocgvZtzvUeD43u42iVfI8eDKkbFvARDxRIpWIgtOBIpPeW1NOt87re9Stc4gK
         iDObIXaPvjFxW2l9QjB/pLc8WwNAEw0W6EGALzar3rhRixS9ZEBH2gnf1WvBqA/Pm2xD
         mkm16mJv/SZvkp/ykoEv6DFoYjYyTgUheC4Wfl9GNTdDRA1EnZAU+VJoSLAAvecQhcUS
         jPzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyVgsbGHtz40ClNTp80Xj1AKtCl5ZD3joWep7cZjEHHR4nDhMIBxlA25yiatvDxo2n4mmA2l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxycb6bbkTPifQY1BRoP3go84NQX372n5RKIz0OnckVAJWN4ujo
	4ttkF61hn2BoLI9bJCJWqwl9n7xeCXX/jsu/7WvLwh37ItPBsbOFGaOrYrnS6ZXn9cpHckTVdI3
	5MX61ow==
X-Received: from pjbqb1.prod.google.com ([2002:a17:90b:2801:b0:38e:4ba3:1d9d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1cc8:b0:38e:7297:a92e
 with SMTP id 98e67ed59e1d1-3908979a96dmr318146a91.9.1785978715068; Wed, 05
 Aug 2026 18:11:55 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:23 +0000
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/11] neighbour: Remove __neigh_for_each_release().
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

