Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7184A92C6
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381466; cv=none; b=atKZE91v/Uqux+lMlFNM/F8UC5kXs+W8Ie5d1CKa25G0RbsvRQ+zYQE7zvqFYaiDp254Mq+Q1GqwXsGKdFkgGp642cHkP59zgXZp4FQ6LzeD80lB5s4FJQAtY5RDB3x/daWsE7eiy6Pw3ry9pB8CwgtyJJrp+tYUuGgQJ4OprB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381466; c=relaxed/simple;
	bh=Cjp+UcXJz8gmn9sKsJ/WOHNXs18pp2N9+xfvHCn8vEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M8mfLyZ0GYmdOpGrKz8mTSuJpaAUg2MMaBiJR/lhHnsW2OvfFpwfxKlaOsBhzlcWrG8DSb7tSS05t3E+DIsCBKLlRtuQLv7ckT2kdFFp7wHLnQleiOEJ9X7ogDyduecbAK/EEfj0ZtPdoYsYoJszOZyOj06ViZv/i2znxP6j0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9xKKmD8; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9xKKmD8"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85f3a39f3beso1651081b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381465; x=1788986265; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIsy4zWA+VfI71D7Yg+15yUjDDIHO8d4l2RU/CRJ5Ls=;
        b=n9xKKmD8QSiFr3FDDymnLArNftYYcOJcpjAYO/qJqslfirrJKFL/y3HRKOHgxcxR9P
         9E60zte1VF/tCMDYy4yeSy8tBS0YnXSWDKLp4sqn8V5xx4j9J5FmKOrz0pP1vn0lYr7X
         rP0ecfajUI7HMKfAVbM6zb3AmGQsYEjtvT/4hYlyKC4r0D3oaTU9PmEmySUtgXe8bZ8W
         URMKBhZwNYamoQ/Zy06PYsIhSd2z04n7QSgSOcTSnyXdExysawxk5PYFhl5DOGOWTWfd
         KU2friMk7wV9jCY0+9cmkS/dmhZp0LV/r/EfC3RR8ztLFr5DsWTGwMPmSE6UZYSFt+2U
         uwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381465; x=1788986265;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIsy4zWA+VfI71D7Yg+15yUjDDIHO8d4l2RU/CRJ5Ls=;
        b=To3dpSjcsob/iHK1P2yjG0E3TmgBImJVkGKSg8ebOx33xXQCXJqY+3Yf1LOnjBmd7z
         f7mMe+I5tmzil5eS9S4t07WBetCifAdJ0plw7Pj3E4penrt+OKX3cCmAo+H92d2TWHXh
         ztWm8qaVUM1h3t1ewAxhg6i4Pt42opAbTvYXPrKZPI51a+YY/p1tuHe9dFazxgWVeh2I
         KbGj7ZECLeo/vZCwimod4LB9WFvNA1NmCnf7JCL0YWYZyfzVDlkEP3pVDPnln2XLmUEA
         jkwLcrCSekC8ZXCpPpBC43Qxpqisig5Tw31ZFj0JPNZjyn4h/cs4LqofVkfpnwlDVz5k
         zZeg==
X-Forwarded-Encrypted: i=1; AKwUvByOhx96tUbmnZYA11C5PzRN6c+KtjTRo5WGvgX8btWmaZgUvzB3a/+zlujhcL+dpaKe8r90sWE=@vger.kernel.org
X-Gm-Message-State: AFuF++nfAbHfmEpEgs15UUSbIN8qXnpk5SX/o+YBKhK5lwIndrvN4fkm
	PEbzPxTplp8wOpIe/wTsK4K6zD0c9aE4E4Ubm8yRF2eUOi/ikpqvDFYDQZmqBcmU8ttjndjhWk1
	/1+50Qg==
X-Received: from pfj21.prod.google.com ([2002:a05:6a00:a415:b0:84a:3ba8:3bf2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d08:b0:857:726d:2e9a
 with SMTP id d2e1a72fcca58-85ed47379f7mr10578235b3a.23.1788381464413; Wed, 02
 Sep 2026 13:37:44 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:44 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-4-kuniyu@google.com>
Subject: [PATCH v6 net-next 03/15] neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
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
2.55.0.970.g62bdec98f9-goog

