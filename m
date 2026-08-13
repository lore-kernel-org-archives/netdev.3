Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1F43F084
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608176; cv=none; b=fd0XimEUu3jy1SNiGIOZyT2q/Wkn/gpEgespvv51SsltSso++qqHzp5O4qMg9AhltFqwqEZbp8Tptx/O7FC0sLc1Gd7PcrB5xThWxidHrk8oVov6ATOANClbpIap2kNjHzIPRDyBd6z57mUy9SuuaAKncCfQfE06DvKdeMzNY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608176; c=relaxed/simple;
	bh=T0kPsx3CGJKLGUgoYe9A3Nn9xSqzq0HkMfUC1+wvH+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S9DioBSrho+OR/8XSW53qSWhP2d9NvHtLM6iCMDpIrycefqlMJBjfpFoeYcDJIrdJKrjJCQNq0dLUFwbGOBHxZDY1r2MUJwHJ3dgKDPuk9SGrVLzBoYjsCdVZiCk9mXOIbADd8HIDoIj+Rlfh46kC73cmGgkxIBLW/FOueiTWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smn3zBOz; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smn3zBOz"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc640dfde3so25957445ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608173; x=1787212973; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSBOQGWUdTGOIvN9Zcp0mZS7+qTIkVEAHy/DhgB+axg=;
        b=smn3zBOzLqn6hxjQdGKZOEjuES6btc7acIELtvbBiCztZDoIjSMEJ5HhEAtGEuk4Cv
         y1cauDPKl7OAAZ/jVtWy8D67I1iOy4Qa8KjDxYnE+zXZWa4Ej90rKnZTGQArXXG89sp8
         43frtkM+0NCrqETsJeegGBzhsfxH0RtLAPoOpyMZqwbPJ5miSwq1Uxc+Xb4cBgb/dqXw
         X2aQEC4xUAkSfnbTRVjSlSSQuF178Exu/MIzpsf77ntYcC8moFqfO0C4m97hO9/VAY17
         NThpZS+izOsCnQUIvH/LqgqSd/B1aYnrZv54F3EiEHX+JIGHPm0irHuLAuiE9PNF5Asw
         MdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608173; x=1787212973;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSBOQGWUdTGOIvN9Zcp0mZS7+qTIkVEAHy/DhgB+axg=;
        b=VYGChvQLmuz2vygeq9zElxmQHCSLX3MDsN39crQTzbcdt/o60X6x0tmHXNCiGNprry
         D+PXwfxkCy5ivKBmARZWWDIqlUdW25qWMExMkNVNQUEZ0aI0RxXfzhxEFRV9ZMklzS+o
         nehyX4MZW0gTc7A9VGt4yzrZEcmZ1FvtCjHQCYnJHF/s4J1NhdpJ3osYCAMvz0KSicDY
         g/6oKUIUSXrZ7x63vTqopyV9zyvSljwKYJHtD7QybSI3zHzNk4CdaGbPQM+lgVwCVFnK
         rbWPSD/E4ilCMCFRm40pm+VL2+o+eNQ54jvVY37cZQiomPCumqnqO8qTCdIbgXD32JuX
         nP9g==
X-Forwarded-Encrypted: i=1; AHgh+RodJauFpaQReIuNuO6BGxXKra6RCEg9/YWWfBgWg6zuqbCJcC/ETZj666VJvAYaI2+rSmMrGMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GPk/PjF+i7b25AJc8BUN/tBFoI8SuBzDYF/fFeQficJVWVQV
	X1S7o5/Z7d36GkCo7ToBS1hIQn9awLUuFDw9IWVbLN2EjfjaFbnOXFVxaYrYDulPAOMgtzKvRaR
	3gZCEaQ==
X-Received: from plbkt12.prod.google.com ([2002:a17:903:88c:b0:2ca:cdc4:8da])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:2bf:7b62:a038
 with SMTP id d9443c01a7336-2d37d885316mr45353815ad.9.1786608172699; Thu, 13
 Aug 2026 01:02:52 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:17 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-4-kuniyu@google.com>
Subject: [PATCH v4 net-next 03/15] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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

