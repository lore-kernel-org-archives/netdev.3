Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D45540AA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925106; cv=none; b=rq0B+LCbv6OqDtbexvgn0GvFrck9qswDwMQhdiNx+zT9IGcsRuGDKBo6GsxWbS6h4P3QGEsz5Mcq4AlFOuBPT8WBITpgDPXaA0YVt0XE9uQh8euqPr661MbHz5sg678I3YY2z79kRRLnxQTB3/QqqZFrsh9eLAKnmlNC03Grd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925106; c=relaxed/simple;
	bh=RSul1KyVt2A5AS1gK2QuRhRnlau9f0Dmc+h63H9JR1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JZVDQXuN01BMiKPCQ9iDqHBc+tzMcWhPE0/GXLbp6fZ3jjDbemNlFfKa9T+zWQqXBLGQc9Pk/BciMCpZd/FAb6yREa3TMprvURcy22HkzWQNlWrwAgqX3HzZPAZaF2UNzWHP1cSV+XtGLN6fTJS8al+7nHLxCaeb6vNBsN/BlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxequgFg; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxequgFg"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so164414a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791925104; x=1792529904; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THas/x/xxuv16ei+XdPr5thqMykdchtFQAjMqvfflU8=;
        b=pxequgFgREKbrIlueMRuS/DFg7DLygI3NUZHPhf0as0HOkFN0pLGnD7tmT6Spk9Lgq
         K+g/2FuV1JGsj2vOu/dnuPOX3y5lkAUrEKhZSiQmlsficL6ky2e2Sq6nwSNpLOqhRpw0
         BphhdUZWZjgzenUXTYtjuALQdKuCQTN0XIt2hKnX6ikT9dFPDSt2R+aspZJj6MFhTTTa
         lyZ5g5z9Zm7NWssz/M+p+DGlua8i85IYt1bTxBvXi5JYb808zGpKaY16AbAAcL8f0bjG
         nk9MXxZ1dgpgJEVWGMOE2ouAWy2FEpYx0tCKKUK7IJ9WEUontVZ7y0vaFRGAHv4Bd7SJ
         RLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925104; x=1792529904;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THas/x/xxuv16ei+XdPr5thqMykdchtFQAjMqvfflU8=;
        b=Xbej4rKmNyqZkBi59uyvy8ScTBRX643j51QcBDvazWsXlQ3zweK+ByjpwZOc+/Ugup
         47lGs9+8XKe9j6f9Mo7lDSzmYYSERIcHgADdEfDCOk07KJiKLsBo5OmwdR3lgotvaoJu
         CwEEZ+81u1aejiVO6Z6EsbdiFlyn/D2CEEdcjHD7/AQX4jbuAEa6kuCCYz7dfbjSyDTT
         PAaeSnFSD7HFPL8WcGIGm4Pp15XpFwvbVUIpzYNn0pP+lnm5dWSCsok9Bh7k6yyTefKT
         l/t0uW6IwLK8lKGScDNDQNECNq/R30ngaE0rPcO8bur70Slxkg0y8lS9XoyM2XrzXR2D
         W2cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRPOOu+MgECjS25/XP3L6hIWjy0aPHFihqBcrUS1YLsfZN7mGTWvxYXoRdhVljXe+2iqqZNhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ14cacpgCvBArfUo4/OzyUDWqsQ7SZR8+qve2bBsh7Is8MRQK
	C3OwSvbkkGoA2a54o5mmRRcWHId9F8TV/003yBJDK2oEE3MAiLOXqJ3Zk9dwHGgPOHi8l4sAlm1
	p1VJp2w==
X-Received: from pfeu14-n1.prod.google.com ([2002:a05:6a00:c0ce:10b0:892:71f1:bcd7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7303:b0:3d1:39e9:b267
 with SMTP id adf61e73a8af0-3e16bb738famr12310336637.3.1791925104181; Tue, 13
 Oct 2026 13:58:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:57:30 +0000
In-Reply-To: <20261013205816.1642597-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013205816.1642597-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013205816.1642597-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/5] neighbour: Schedule neigh_managed_work only
 when needed.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_table is now per-netns.

tbl->managed_work is scheduled when netns is created and runs
periodically even though the netns does not have any NTF_MANAGED
entries.

Let's delay scheduling the work for the first NTF_MANAGED entry
and stop rescheduling if tbl->managed_list is empty.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 90335895b415..6b0569aa5d64 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -184,6 +184,15 @@ static void neigh_update_gc_list(struct neighbour *n)
 	}
 }
 
+static void neigh_add_managed_list(struct neighbour *n)
+{
+	list_add_tail(&n->managed_list, &n->tbl->managed_list);
+
+	if (list_is_singular(&n->tbl->managed_list))
+		queue_delayed_work(system_power_efficient_wq,
+				   &n->tbl->managed_work, 0);
+}
+
 static void neigh_update_managed_list(struct neighbour *n)
 {
 	bool on_managed_list, add_to_managed;
@@ -194,7 +203,7 @@ static void neigh_update_managed_list(struct neighbour *n)
 	if (!add_to_managed && on_managed_list)
 		list_del_init(&n->managed_list);
 	else if (add_to_managed && !on_managed_list)
-		list_add_tail(&n->managed_list, &n->tbl->managed_list);
+		neigh_add_managed_list(n);
 }
 
 static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
@@ -708,7 +717,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (!exempt_from_gc)
 		list_add_tail(&n->gc_list, &n->tbl->gc_list);
 	if (n->flags & NTF_MANAGED)
-		list_add_tail(&n->managed_list, &n->tbl->managed_list);
+		neigh_add_managed_list(n);
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
@@ -1670,10 +1679,14 @@ static void neigh_managed_work(struct work_struct *work)
 	struct neighbour *neigh;
 
 	spin_lock_bh(&tbl->lock);
+
 	list_for_each_entry(neigh, &tbl->managed_list, managed_list)
 		neigh_event_send_probe(neigh, NULL, false);
-	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
-			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));
+
+	if (!list_empty(&tbl->managed_list))
+		queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
+				   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));
+
 	spin_unlock_bh(&tbl->lock);
 }
 
@@ -1873,7 +1886,6 @@ static int neigh_table_init(struct net *net, struct neigh_table *tbl)
 
 	INIT_LIST_HEAD(&tbl->managed_list);
 	INIT_DEFERRABLE_WORK(&tbl->managed_work, neigh_managed_work);
-	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work, 0);
 
 	return 0;
 
-- 
2.56.0.385.gd3acb90ef8-goog

