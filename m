Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83B4F405E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798618; cv=none; b=hkUCsjUKea0QGeAtQQjchAUOTKC2954M9d0OknNZ1AE0TIvwI10iDyaJDG2pmRcLAUTo2vGoMWUlkd8YUvmfnZ06MONX4QPG1c/1LpkiSXJ1eEs45EicKFRv4vdKM2GdkQSO0WutZTEKqsb+CgHs1my8xkqw5bHVkjAyKimTRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798618; c=relaxed/simple;
	bh=fduMoCN4qpesNUs85dHqO9bkvPjdVxar1NEMQVvAp80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZzRccrxw6QaaGQOwkNM6/MXOx3L087l/uCPJRysZ91gU1EZih3KUliaE+/U+mtB2gEUGeKCyPHWecfMGl3oqkq8OkJmCZI2tIh/xp4dMfqC2HsGeeX2gn7GCNjZGnEYaFUrqArLtOAjJNF03YcHGKc5iNjmU14b/jK7rEPwgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/IagAYp; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/IagAYp"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso9917196a91.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798617; x=1791403417; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEu69i/6nYWqMt8Dv0HJ6k3MZL0pVH1CeNeO9p5XzlY=;
        b=J/IagAYp6dqYugTAdATLkKo//C3xi5zb0ODRNxE2JS0W/uSR5kqyUg57PFxrMvw/+p
         xvU8hj0nfKyX69LjpZgeLvg2orSuibNu1jM2marklnZwxa1eI50f2r6KvvxhOZE23qoI
         McVTkrN3jPldm94wC0uJFAxdF/ELxOUWMkW+xvUAn5vVBypvSI8SUxuqwv0kGRhheyvu
         AbOjcAWGQZ5QrNrR2WbijtGOjh6pUTk/GAHV8YV9dqvbHCoJ+FOQontuesXMfEEdSReU
         m7zVYRIgDX/y8QXSXTflEkDka1M13vs3zcpZlw6UDESjv/kuEiYxhPWtm65SVMHRC0Uz
         /HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798617; x=1791403417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEu69i/6nYWqMt8Dv0HJ6k3MZL0pVH1CeNeO9p5XzlY=;
        b=Y1zFRLrt56vE2M9Vj4fZM8ZQ5ve15JfXwj8DB3BgmCykGrK0DPlixnEkQogpSt59QT
         Y/q+dZJGy1V8Z4eMqI5ZRq2BMyi/t/XgLZqYGiBvqFqHoxJRIv5lqNulylQd6fm5oNUV
         H3Dgx6e0Yzr6Ha1MRj2qh/oE0kTS82Fpmuu0SYL5tYw8NO0A1uLH4JJ5GZ9vYZnnC6Gc
         LgnPL22tWTlpmm2rXZuBYv648K3v26KdRN1nSK87QM1GI4uP4/X2npqkartXHKHr4SZM
         /Y7OsRhls1ssypL44M7nAqAwuxF8jmaNXU+V0Bjf+o52AqP3MNh3PpqZcHdV9MWmrLyU
         0hFg==
X-Forwarded-Encrypted: i=1; AKwUvBycJ4cHcf4EhJCN75Qdi4IRe3vI7URmTGm5AG9qeoZ/cyCLGvOe2VDiRjwd8fFrvK5SVhqndZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLPMLp8ejDvGDlv8ISoqXTpWBDkeJkrxlLipEZPN9AeWwULZ/N
	4HbFbhZkshmKB+HG+8vZRNtt48LCi7ND/w8WIrvDMrbXfRxg/8EdAxckc/Fxlenqd8gpeqLuz+c
	lTnOnCQ==
X-Received: from pgbcq3.prod.google.com ([2002:a05:6a02:4083:b0:cc7:8db3:2682])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:1c89:b0:3a4:f381:6752
 with SMTP id 98e67ed59e1d1-3a4f3817664mr371130a91.35.1790798616415; Wed, 30
 Sep 2026 13:03:36 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:16 +0000
In-Reply-To: <20260930200326.718459-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930200326.718459-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930200326.718459-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 8/8] neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Both __neigh_lookup() and __neigh_lookup_errno() not only
look up but also create a new neighbour entry.

The names were misleading and there was __neigh_lookup(..., 0),
which should have been simply written as neigh_lookup().

Now, each helper has only 1 user left.

Let's convert the last users to neigh_lookup() and neigh_create()
and remove __neigh_lookup() and __neigh_lookup_errno().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h | 24 ------------------------
 net/core/neighbour.c    |  9 +++++++--
 net/sched/sch_teql.c    |  4 +++-
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index ed9d9ae6d3a6..79a5a548a129 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -554,30 +554,6 @@ static inline int neigh_output(struct neighbour *n, struct sk_buff *skb,
 	return READ_ONCE(n->output)(n, skb);
 }
 
-static inline struct neighbour *
-__neigh_lookup(struct neigh_table *tbl, const void *pkey, struct net_device *dev, int creat)
-{
-	struct neighbour *n = neigh_lookup(tbl, pkey, dev);
-
-	if (n || !creat)
-		return n;
-
-	n = neigh_create(tbl, pkey, dev);
-	return IS_ERR(n) ? NULL : n;
-}
-
-static inline struct neighbour *
-__neigh_lookup_errno(struct neigh_table *tbl, const void *pkey,
-  struct net_device *dev)
-{
-	struct neighbour *n = neigh_lookup(tbl, pkey, dev);
-
-	if (n)
-		return n;
-
-	return neigh_create(tbl, pkey, dev);
-}
-
 struct neighbour_cb {
 	unsigned long sched_next;
 	unsigned int flags;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6ed8eb075146..0d883c043956 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1569,8 +1569,13 @@ struct neighbour *neigh_event_ns(struct neigh_table *tbl,
 				 u8 *lladdr, void *saddr,
 				 struct net_device *dev)
 {
-	struct neighbour *neigh = __neigh_lookup(tbl, saddr, dev,
-						 lladdr || !dev->addr_len);
+	struct neighbour *neigh = neigh_lookup(tbl, saddr, dev);
+
+	if (!neigh && (lladdr || !dev->addr_len)) {
+		neigh = neigh_create(tbl, saddr, dev);
+		if (IS_ERR(neigh))
+			neigh = NULL;
+	}
 	if (neigh)
 		neigh_update(neigh, lladdr, NUD_STALE,
 			     NEIGH_UPDATE_F_OVERRIDE, 0);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..7054265fa8dd 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -257,7 +257,9 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	if (dst->dev != dev) {
 		struct neighbour *mn;
 
-		mn = __neigh_lookup_errno(n->tbl, n->primary_key, dev);
+		mn = neigh_lookup(n->tbl, n->primary_key, dev);
+		if (!mn)
+			mn = neigh_create(n->tbl, n->primary_key, dev);
 		neigh_release(n);
 		if (IS_ERR(mn))
 			return PTR_ERR(mn);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

