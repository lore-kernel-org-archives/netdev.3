Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5F43E488
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608175; cv=none; b=ccGFMXLX2hk5V0pzvRtdJvMcu21pmJEIGVFevf6R0TG+M3C17Z7+5guuFDff+eCwyfG7RkDXxdGb6bo6nH1BEZ0rUt76DUMJexpKZpWDezHQN42ez7tfxCZOuVcoPniGMUcxt+a13VFyLJDFXbin3/bbB56Bz/owH444TAtsFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608175; c=relaxed/simple;
	bh=cEaSbzDXoY5ak1bsFdVxPcr4FzfLmE6rFRJgIajXyKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B5g8u0t5gZf/lSy0sGaKIAg8viWXzhLgtQmjMFisTGXa8TaXCEJC8pjrT98eTrlZpSWgetPXQh2G+z6OgAtRn2M7VixuBCCR67j2ALYUspAYuZr2TOF4QNbCwZRNTj7oiVhDvVRTCMAv+3L7mdposYFEnofKX5UlaPiRyN3int8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jth5MDyW; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jth5MDyW"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso27666415ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608172; x=1787212972; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqQY3lw5U/lRBvnZiE+TFtKZopJiM9Rkl5DHRPKA6ps=;
        b=Jth5MDyW6gBZ+ziwUeZOxTo3Yjz1erij4FVk+XGq1QeH6j72XO34tC1Z588OIX2Hfp
         CZj7oUx2iQGvMOB/TFSXCZBvB48nlKOssev8KdTfak4GRA7zdm4rlRBVQp2DGvWASumb
         dgYahN8u0Fz3h4ixF+Q3QloZDeaW/lsPXNXiCp2bu3JxG0Iquj+D/xl/tZUtE5/5Dhvl
         cBbL8fCHWS2iuvKanLWq9wfpi2fH/TJYKH9R5jJjRzh0cf3enyMkuqnGGNUuyqTjqlSy
         u840Ee+VTpb/oW0N4l8lYrED7u2ozCbbYDnwmUow+L25v50vjRWy/B4Aw0nekELzSee/
         wovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608172; x=1787212972;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqQY3lw5U/lRBvnZiE+TFtKZopJiM9Rkl5DHRPKA6ps=;
        b=FPbSUZYpWzFaahFv/5UG+CXWoCeZnMXE/cFBxBe5zdLrm3jOCnf1s5ZxB19b37nv/+
         KlD1CTL0TCtTIOZxAGGWc6F8aMcMigTFLMoBie6a2kXzp0IARYSrGzyNtDwaTM6IF5Hm
         EFgZhaUS9y34SdI7HHQt7Bpka5DbSx1TgzLMVZl6l4h/jEgFbfmZrMYR9v8/bPnVv51E
         45YRkhz/1UxDfoMBITCeQFwSbszD0Xci93PtrbRxDsI8kqKWLQQd1rs7X88ST+Pv6zOC
         nnU4mUyNQcxih7xFJHJ8dugaptLaKuuhG+8vVsYAnV/Oqia4upV8A1OatgrVTJFbj4aT
         QR1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8D1EV0zzzMmAGujzuvNja9Zc8YuK2qoaN0as2FACb4OnllwrSaotK5UVSyJx1GiiVApO2nvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JJqVVeHFVIspvF4HYdRzlJbLZ0FNUIuu0ZcyagXGeRgzgQaZ
	+5FVTUGheTwJfTkns3mNaJkA06dCebsNMNooyijIMEQF0SDmyah5FsiAaezr9s2Hz19jVGzoEVP
	8avwS/A==
X-Received: from plrs21.prod.google.com ([2002:a17:902:b195:b0:2ce:9080:3fce])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db06:b0:2ca:b8fd:f31
 with SMTP id d9443c01a7336-2d37e855113mr46204295ad.15.1786608171929; Thu, 13
 Aug 2026 01:02:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:16 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-3-kuniyu@google.com>
Subject: [PATCH v4 net-next 02/15] neighbour: Remove __neigh_for_each_release().
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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

