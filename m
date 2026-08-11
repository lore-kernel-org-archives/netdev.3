Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07839022A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415096; cv=none; b=cI0S+0B1WmEUZlPmyi7Pv6AcVBp8esVUtk8JtMTSGyyynru9itoW4+Q9fs4Fl/bbCYbMGYYWZ10E/rBBG2KGKovFvOqsffMEcb25vfKCw8q55P9dVmYvq44oFknBvvAahkXYkrWBzmufMF1/+ycq2TDeg3k2oxVqal8uFgXNLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415096; c=relaxed/simple;
	bh=1rk5HesVkv7e7mMKDakq6KHIJBmaBxLOwya1Z4zGIzU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0yCW/yN0MKpK1sNtdxhdTxavD+0CttQq+EkBtVWHHiJpvS1I2Bgt0smE3rSejyN9sSxI73EXl1hULRG8h3dhvlZZorPJIYzVud7ltapcnGA9TnzTbUe/Qd1zJVpfJqpJQ+yZ1OL88fI0ez44oGkIiDcza+3IxPobq87WkI41WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvvnrEES; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvvnrEES"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2caf4173b1cso52605755ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415094; x=1787019894; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YuevXFgaNTPcA5is/4FjNPXVGcji6BDZ+oJUkiEZqDk=;
        b=JvvnrEESPK1J3rY3hnuw6Ke1wUkVdPEyu/GPWMq0S/f4t/5+bc7WKhlCW4Q2VYJJTP
         jSgbrhwqY+KYqJBd+ZEE5BKEW5HSxF1i6kM1l6ePJ8rKz8OGFcMlCZ3an1prU/Diym0W
         KLnwf0vKJ2GaN33oUfz71lqy2W5mhThfqlht9/U88Ile5+DOU9ly+JhU5C5crUgHjOSe
         9TZu6hfBAWdwnV6asITkqjNNb5lCDH2uFgo3mS7ZHD4OIPCTwl99Ohj0X0gOYZtpJMkB
         g/1uYFkHW2q/nBk/x3SPeZi07Z518tqeImTzoa8MAtf2ldJ3buFTg9Yvo25LzQ+dlSoo
         rbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415094; x=1787019894;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YuevXFgaNTPcA5is/4FjNPXVGcji6BDZ+oJUkiEZqDk=;
        b=qHry1etcKFbvH1GIvD/3WRY3WKAUqfAgbHiTkzNcV0BRXAYNr8RzFR3u+e6R7WFwCN
         4DH0ITeU1qjpV8Xz1TROtqCnbMZ3BImb4utz84/FAjyh5brNWUXSVCbfvgL+2wh6Hx85
         0p4vR1jV5eHZnhPtN8b8xDQBAlITRfH1ASImBv3y/yDQlmQO6yiPR6C7skoaQ38hsogg
         G7sj2qMeabpEz6CDQcfxeklth3J4oOP0lRsuuFft49nC2E64rrNec6X9A+1qSdUZybWx
         FyCbCfxRDcTU9KtXaj7p30y6RDQwFrOmnroiP+s9ToXXtA6rUx+r8WHHmxiURovzMYPZ
         Rl5w==
X-Forwarded-Encrypted: i=1; AHgh+RoOxhsowMJ0+rPFsociJea1gtE5t5t8JCvlazaThv6rJVR/CXoGQ0p+RGBGDFPeHUMqZPAN3HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEow9vNFXHMXIlKyvScfPzjbTYc1W8RLRZRTNxIpPKcCe0ryI4
	b4qimEVpKSWdTZ1Rd6b1sT2IDaRJ6mYpff1rX17up4XMb9U7NBYb7veSLEw+rML2WJAgsWypiu8
	/ssAdeg==
X-Received: from plblo4.prod.google.com ([2002:a17:903:4344:b0:2cf:7d3e:e383])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40c6:b0:2cf:ca89:4990
 with SMTP id d9443c01a7336-2d3179333a4mr1605425ad.17.1786415093993; Mon, 10
 Aug 2026 19:24:53 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:37 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/15] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__neigh_update() could call neigh_update_gc_list() and
neigh_update_managed_list().

Both of them acquire neigh->tbl->lock and neigh->lock, check
neigh->dead, perform link operations, and release the locks.

Let's remove the lock dance.

Note that neigh->dead is always marked under neigh->tbl->lock.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 69a5f9dfa851..13eea09721c6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -135,6 +135,8 @@ EXPORT_SYMBOL(neigh_rand_reach_time);
 
 static void neigh_mark_dead(struct neighbour *n)
 {
+	lockdep_assert_held(&n->tbl->lock);
+
 	n->dead = 1;
 	if (!list_empty(&n->gc_list)) {
 		list_del_init(&n->gc_list);
@@ -148,11 +150,6 @@ static void neigh_update_gc_list(struct neighbour *n)
 {
 	bool on_gc_list, exempt_from_gc;
 
-	spin_lock_bh(&n->tbl->lock);
-	write_lock(&n->lock);
-	if (n->dead)
-		goto out;
-
 	/* remove from the gc list if new state is permanent or if neighbor is
 	 * externally learned / validated; otherwise entry should be on the gc
 	 * list
@@ -169,20 +166,12 @@ static void neigh_update_gc_list(struct neighbour *n)
 		list_add_tail(&n->gc_list, &n->tbl->gc_list);
 		atomic_inc(&n->tbl->gc_entries);
 	}
-out:
-	write_unlock(&n->lock);
-	spin_unlock_bh(&n->tbl->lock);
 }
 
 static void neigh_update_managed_list(struct neighbour *n)
 {
 	bool on_managed_list, add_to_managed;
 
-	spin_lock_bh(&n->tbl->lock);
-	write_lock(&n->lock);
-	if (n->dead)
-		goto out;
-
 	add_to_managed = n->flags & NTF_MANAGED;
 	on_managed_list = !list_empty(&n->managed_list);
 
@@ -190,9 +179,6 @@ static void neigh_update_managed_list(struct neighbour *n)
 		list_del_init(&n->managed_list);
 	else if (add_to_managed && !on_managed_list)
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
-out:
-	write_unlock(&n->lock);
-	spin_unlock_bh(&n->tbl->lock);
 }
 
 static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
@@ -1523,10 +1509,23 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 
 	write_unlock_bh(&neigh->lock);
 
-	if (((new ^ old) & NUD_PERMANENT) || gc_update)
-		neigh_update_gc_list(neigh);
-	if (managed_update)
-		neigh_update_managed_list(neigh);
+	gc_update |= !!((new ^ old) & NUD_PERMANENT);
+	if (gc_update || managed_update) {
+		spin_lock_bh(&neigh->tbl->lock);
+
+		if (!neigh->dead) {
+			write_lock(&neigh->lock);
+
+			if (gc_update)
+				neigh_update_gc_list(neigh);
+			if (managed_update)
+				neigh_update_managed_list(neigh);
+
+			write_unlock(&neigh->lock);
+		}
+
+		spin_unlock_bh(&neigh->tbl->lock);
+	}
 
 	if (notify)
 		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
-- 
2.55.0.691.gc56d675ccc-goog

