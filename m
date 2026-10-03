Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955249E5DA
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062651; cv=none; b=uyuwrp0cyWZkhDsS8gfbpCuRdLQWXHGQQy/kT1lL14c5yqSqrqpXKdfN/A73AT8zdSvxk7rJYh8a+akoq/ogzizKz0we29ym6Y92CoK7Wy8x9XLfiLPuTpyr5UUgjBUe9SiKUr5UFU1xB4z75kG/PYb3XTcPoBJLDncJJL+0TE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062651; c=relaxed/simple;
	bh=jeDe/kcGdMj1CLYSh26UKDvPMxv99opCV5Y/zz2oSmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l5Ev4k1KoVASvz6/tZUtWe51+0RndFPPcMmsR8eqMywEXfb2txzj6AmK4/EK/S4Gj1D1iUW+faAFtk+n6khEG4t5FZhkPv7zxID8ocgghZrpDVsSU36Vi/2WbvE1T71S+X2KnkFI4/8+x4Oax2elkCd4TCaxf2OFfefd6ntp6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4UYdllt; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4UYdllt"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8872ada18d7so590421b3a.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062649; x=1791667449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIaeqdtUwgyzDL+86YQeRNihTC9xzsOl3hDEc98RvT0=;
        b=d4UYdlltIEjFynEwH/cwvmBLQpbhsPcgogYlEAJ4ptgwIDCfOGM/Nz4rCfMED5zYRW
         C3+ravO0M3B2JUVP/m9N/U1SATXTKsUIqUkk0ytVe+/JcaGTgKe3lr1LBiXtNMxhapnZ
         QnlW77DIRYkqNPQsiGZD9aSRfcD+a/sz6fJI+90U6farYyuKg6qg+0d3ZYLwvVqYEz2C
         xsNi9JM5aHlqjNfFqkm94kLDi6OXi0fTxrCOEtyXbpi3ucOPSNdBRJLyyPvmi94Srq3R
         uIF4gIBtsVBeD4rhaeNugiRMWJhK8yJR0oJc2qyLzqSylO3t1S6LoEHznbwe1P7aHZ16
         dfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062649; x=1791667449;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIaeqdtUwgyzDL+86YQeRNihTC9xzsOl3hDEc98RvT0=;
        b=17l6HoAB+hMUTnVcUgMELizMNYeUMySSAhmguvRNAVczYvhks3MqvD5fYycMkHMMF9
         QkTD+uS6FII0Wg4Ay6Y2kJR2lMh90lRbTd424da9UTL/n1VJb/SlbiFemkgYdbLbiIkR
         Fwta0J0BXkntOrW5xrGXdMsyQAYl3rsz0jklomxxj3WvZziQLHrk4YVsj9rXmt7mf7KU
         ZEEKGa+IwshB5wbh913MfDea25lcZTRvvut6WPnyj/zdCKiWPDM0V2461OQhxb0W0sz8
         MZYS0LSGow4EAWEO7e8dfYN2Ii8X+if8eMoHM4gtN8MyA03UPfmY1bTguZfoRDuKcG2w
         RoUg==
X-Forwarded-Encrypted: i=1; AKwUvBx10zs6cXrJSQNHmsv97ZF6NIUxY7AgiVW3Od962kO4kgzDRwBB7WWFk5LexCuewybfdMdfkuw=@vger.kernel.org
X-Gm-Message-State: AFuF++njI/ddNv9huw7PfI4jvPGTLOjvOgGeqUlP30dRjDjLUyNxn/DF
	nAq2CDiWGHOA3n2lel/RRlIQlPwsR8OnGepG/NRBovfDL49F5lzGci3HbmY/a0qaP4b5530sUbc
	ELhbnhA==
X-Received: from pfbfs14.prod.google.com ([2002:a05:6a00:818e:b0:88a:f8c3:9c75])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f86:b0:874:708d:b633
 with SMTP id d2e1a72fcca58-88c62be94aemr2686596b3a.31.1791062649161; Sat, 03
 Oct 2026 14:24:09 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:21 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 8/9] neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().
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

Now, __neigh_lookup() has only 1 user left.

Let's convert the last user to neigh_lookup() and neigh_create()
and remove __neigh_lookup() and __neigh_lookup_errno().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h | 24 ------------------------
 net/core/neighbour.c    |  9 +++++++--
 2 files changed, 7 insertions(+), 26 deletions(-)

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
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

