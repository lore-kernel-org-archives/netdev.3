Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF44E0B68
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834337; cv=none; b=Ta9+AlNlv2bSAX/e9uxoqskCGuQ3NmRZFCFcxtDxMHukPBsxrpKGs+qyEq66t/yaTv1EsD4ZuITk3DQRkUSiTDB0tfCaMypPzNNX6Z4qDUMcljmdeT3pfkzQQK4wETYBgFsYRha3iHIaMWYzmn7uxjV6Q9IpV0AjVLTklm10qyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834337; c=relaxed/simple;
	bh=RSul1KyVt2A5AS1gK2QuRhRnlau9f0Dmc+h63H9JR1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=haooZ2ZcXf28/ti869hD+ObguLPHHMqvocdVCe+3nkVJDQ41BYkg0FVLFKnuHhxNgnGU/pXBHB7Y/vHriiPJXmk5lof1Sw+8VSaO7+9TWUIF3KOyTJMzbuz+vqbzz+0db1GnkKxK/dqBA442SVF9rF7BVjm3a59K/RjIdmIWb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXD+TFpE; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXD+TFpE"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-892ccb01fbfso1928217b3a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834335; x=1792439135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THas/x/xxuv16ei+XdPr5thqMykdchtFQAjMqvfflU8=;
        b=fXD+TFpEMT88pA0xG2IMPo30XJseGfHtbw0KYxwXBbxCBnQlA1sNeYy8KwconakA9F
         KIj8pbl57wpTljpu0mDH8Ux8RZdTj8/V97n5iBcMYtniruK/jstm+D2Ft3lo4k+hNsNo
         4p0KjY0mysJd1pla4sdriAtyqrV1Ul6EVlXaDeHIOvBZfSpx9DbJAaloxlfYo6d6uQK1
         d5zKrpjLGDDMMJCWLkXUWhpeZOAZlNHiYrSETWQLCGnL0EJWYwNEJDoLdGq/jc4FQn15
         m0j62UDC1tq1mt5DlcYbAfZGzxD/bQysrq75Io1/V83KiooIPjd44puLazXTN9fWtxKZ
         dHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834335; x=1792439135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THas/x/xxuv16ei+XdPr5thqMykdchtFQAjMqvfflU8=;
        b=bNs22ni0IdwWMmzhIl93PE5YqsRhhoExt59F8sUjRXgCqf/5cQ2SAmEwhS4bopl22I
         PgNXUe94dKwJs0f2AgDAMlo1GM6IAfm7q17hLkPdxYOceqSf0uaIZmQhGXz4wMPpFxWe
         s/ySxPd9ZFWDthmGD/uNnjWn3rLrqdQo1wLv1i97SDPXDHVK3Pu74tjRCEOepq89MAm4
         71bZdzvopbiEYMQdnVvuOl0iXVrKOOOV7V7u3HlnYaTXKYTlpBAlAVRT4x9Fh/6ou/m2
         keLQ6qlcaPxaSCkstHi2Xnc2fldY5tuPQSBO73GNutShcMtHbIH0bVplVYhLwDFD0crm
         seZw==
X-Forwarded-Encrypted: i=1; AKwUvBxL4lBIz3Eogx0q9VZ1iHuyBQus+/vW6qPLMFGkLJioyzTuCQbZB3NG1tGguUo3aTIKvnJRyoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgDbyAIIgWzZjyIIghKQEZyB8fu4JQpmNTAjMgBd5dc+akFElY
	4E+bPhoRMqrRU2uUesFTNGuv9jcXokNJceNousKEK8U0Vja4ZgGVfxjhqazWrDXZFaHFtMAu3V/
	Xbn8F/Q==
X-Received: from pfwp46.prod.google.com ([2002:a05:6a00:26ee:b0:898:85c2:fe8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2343:b0:87f:dcc3:62f
 with SMTP id d2e1a72fcca58-897c7fc4042mr8304559b3a.60.1791834335289; Mon, 12
 Oct 2026 12:45:35 -0700 (PDT)
Date: Mon, 12 Oct 2026 19:44:58 +0000
In-Reply-To: <20261012194530.3751034-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012194530.3751034-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012194530.3751034-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/4] neighbour: Schedule neigh_managed_work only
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

