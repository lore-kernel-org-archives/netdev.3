Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A649DBB5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287614; cv=none; b=PbcesMQH9YKSyXJ6Kl7YaHfa+VkGylujimUry/RZqMMo9ITs/gaBu+4fBRJeXhC9Ka1YIqYs1j8+bUgrll35GKO7AFltNotJFlyb08qyoBeJ9jRp/WVfxvUUHfKztbAwX5/7kLca9DGPbcs9i/RT2ioLsauh8vox2VslC4QvsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287614; c=relaxed/simple;
	bh=naOE/kKgwuhK1DO18nPWl0WuOz5XB+aU7yA6TdqE2XQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LK7HjQ5uK/kNtQi8uto+iWNRXKV7T2xiVaog6lBEVGZEtm1SWs5ElseGnn4tXBhGjwwdDEgVaNnqDo80ulFnRTto2/veo59KKC+WWpO6zfvsdNb0Gsr0nf+1k4h9gBlOp6FptOwy5jhORkQPol3UovUNVdn7bCyWuQqFwDICPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtBBAMFh; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtBBAMFh"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94a158dc8so1574335ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287612; x=1788892412; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekkoaOWou/iH2sA4C78iEPiTxi9oGZ2jZj4xSiHWhzo=;
        b=HtBBAMFhz7NkrbgSxVXzri6xgKDr7MwK0tf2+wDNQUg/U2qKDiNKA5Ux3196qlKwmx
         tVLLjnPSeVkeXn/0ZJaLZ1mhEKwkct8Ewf6BrisF5UaSs2QQwDqp+lQRYy71j5q5lzmg
         KGhcNdqxIS1nID8+N9pf2Tw23Eti4JU1KggLNYTTvcpVVPqLPdGNcfXAtHW6fhgTnYeq
         +JEAPN3/1JYZv5lszGC9v/+9dGExv5KCVLSHu608FJ0f5Z14x+6fZy34C12h0seN2OGM
         /iVd15t5or186mF9cRoJiwswxBXkdtvopyxAoSiFfizv6LhowlqK3p8Jd7t65vCI4HJz
         GG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287612; x=1788892412;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekkoaOWou/iH2sA4C78iEPiTxi9oGZ2jZj4xSiHWhzo=;
        b=UDXtyRX77E3SLiccupM3CDQXLHkuadMPp97pCVe4zlbv6MipeT50nDBUv8V92XMMzu
         8aecDGNWK7D09pOKtp74AJ7JUEoJJgrXMhMPSijzTmNPabZOW11tZ52jCvYl4jTjQRq3
         T8FKBCHrg4/rvT6kyltmSrPCwQFJqlSgEbXal7UjL/FSCkM/dcpQxZPgUqGumaxHcxlk
         ORyz+ZHAXLud0eTPGkfLnPBdAs/2wCo4+w+z+cku24+GK7zzCOy3KnOMFJyZhFpIEXxB
         99kumy+DskhiYzt41rN7/nl0LOcWCZ50HpcSK2rL8WNuZfGFpD2JZvn37ki4Ndp5bol1
         Yiag==
X-Forwarded-Encrypted: i=1; AKwUvByl39oMw1Ad3UrkaXGGusVP65pIc4d5gTLxykjm3HiGf9MUhfGPvd0S+jNNxY7aSLbCEqI3O54=@vger.kernel.org
X-Gm-Message-State: AFuF++mT5shNU9EhxSlH4R9ZG2brRg3L5Oa+KtGEPfr1fpz4VdGdDEN2
	X0PEymjEa9U6obytUNQHQMcJS/qkprHWo6WG2BiDN2fdzOVvF0Ycqu6bcR5U3TjaVfzgU8++bxx
	PjNgm2w==
X-Received: from pjbgp17.prod.google.com ([2002:a17:90a:df11:b0:398:a4ca:11c0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3143:b0:396:d28e:bd8
 with SMTP id 98e67ed59e1d1-39ae824c132mr103274a91.3.1788287612259; Tue, 01
 Sep 2026 11:33:32 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:52 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-4-kuniyu@google.com>
Subject: [PATCH v5 net-next 03/15] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

__neigh_update() could call neigh_update_gc_list() and
neigh_update_managed_list().

Both of them acquire neigh->tbl->lock and neigh->lock, check
neigh->dead, perform link operations, and release the locks.

Let's remove the lock dance.

Note that neigh->dead is always marked under neigh->tbl->lock.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.55.0.966.g6673acef38-goog

