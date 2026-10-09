Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FC3A48CA
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.60.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523189; cv=none; b=TxZXN25D5maDXRNbznKUeLVvGvbtLsqSaMGP5EOO4kQF7Y2FS4Jqr9bsjTMns7OXpbs2Cd+bFQ4eswne0jLj7lYHGoJ0wWPcNdSut5sqNTCWBiD86/lwXx4v6f2gydPRDQfWj9971CIxn/HvfxV7IcaUKYdhIzsbjgSMeNuYyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523189; c=relaxed/simple;
	bh=rhH61IChsnAg5Ulcb20Uln6iE/PqoDjSPmwfZo8/GaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIreFlhIly2oxRHAnu2O9zY+9QLCXoC+IJ/9W7AP274Y7hG+NYVqx1zGrQ9Pi8HdWKvr5gO/zogocsOs1MgYFZCgE8FPRMcUWOni1zJBaZWjLSKWItki4bFVeyLoOGdLZihjfIOG3gIyR/MBnTbLe9//oVXfY4vAQcThA8/rt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr; spf=pass smtp.mailfrom=corp.free.fr; dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b=dZd0EDp0; arc=none smtp.client-ip=212.27.60.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b="dZd0EDp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1791523178; bh=rhH61IChsnAg5Ulcb20Uln6iE/PqoDjSPmwfZo8/GaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZd0EDp0m6O5IfA8G6c1lj32OW0PIphtYaXbUTg3SGgqhnyDCV+l5NPJ6DNVW7hGs
	 tlHM5c2xqS9HwC0Pd1jZ2oHYjtHLaw8GQiF4s1f6ZxYgsX7ArAByAgQv9+1h0yg+X5
	 9YdP0WPWVqaETS8mjAnT3cXh9yZlLRh3bIix1TTcC7W+0ByFg7QXapRDKeiiWxYloM
	 2Yh5lo3oUXj24Ekc2M7KHrNNrTLydzlEUFmjg86m1Xttfi6SeGqqjGTKoTfWXrqY4v
	 FQNOZoSmHQ6VIIoaS89fVD8WNpmJmEuHwNhxJP8utLT59EbkiJSbAbvOYIwxL3gzsw
	 VnnzlC03itoWw==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 13B3B44C0A98;
	Fri,  9 Oct 2026 07:19:38 +0200 (CEST)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
Date: Fri,  9 Oct 2026 07:19:28 +0200
Message-ID: <20261009051930.3619697-2-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009051930.3619697-1-acassen@corp.free.fr>
References: <20261009051930.3619697-1-acassen@corp.free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbedit, police, mpls and sample store and dump
TCA_ACT_FLAGS_NO_PERCPU_STATS since commit 40bd094d65fc ("flow_offload:
fill flags to action structure"), but still allocate per CPU stats.

With the flag set, these actions update their counters the same way gact
and mirred already do via tcf_action_update_bstats() and the qstats
helpers, which take the action lock and use atomics when the per CPU
counters are absent. Those helpers are correct in the software path. The
problem is the hardware stats path used when an action is offloaded but
skip_sw is not set: tcf_action_update_stats() writes the same counters
without holding tcfa_lock, so the two paths can race on tcfa_bstats.
gact and mirred carry this same race today, these actions only come in
line with them. I will send a separate patch to fix it.

For example, a per subscriber policer offloaded to hardware:

  tc filter add dev $DEV ingress protocol ip flower skip_sw \
     dst_ip 10.0.0.1/32 \
     action police index 1 rate 1mbit burst 10k \
     conform-exceed drop/pipe no_percpu

Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 net/sched/act_mpls.c    |  8 ++++----
 net/sched/act_police.c  | 10 +++++-----
 net/sched/act_sample.c  |  6 +++---
 net/sched/act_skbedit.c |  9 +++++----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index aa56521b7179..a870386386d9 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -60,7 +60,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	int mac_len;
 
 	tcf_lastuse_update(&m->tcf_tm);
-	bstats_update(this_cpu_ptr(m->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&m->common, skb);
 
 	/* Ensure 'data' points at mac_header prior calling mpls manipulating
 	 * functions.
@@ -123,7 +123,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	return p->action;
 
 drop:
-	qstats_cpu_drop_inc(m->common.cpu_qstats);
+	tcf_action_inc_drop_qstats(&m->common);
 	return TC_ACT_SHOT;
 }
 
@@ -196,8 +196,8 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a, &act_mpls_ops, bind,
-				     true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_mpls_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 3f8147f37549..0b0c09e3dfd9 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -80,8 +80,8 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, NULL, a,
-				     &act_police_ops, bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, NULL, a,
+						&act_police_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
@@ -259,7 +259,7 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	int ret;
 
 	tcf_lastuse_update(&police->tcf_tm);
-	bstats_update(this_cpu_ptr(police->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&police->common, skb);
 
 	p = rcu_dereference_bh(police->params);
 	ret = p->action;
@@ -313,10 +313,10 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	}
 
 inc_overlimits:
-	qstats_cpu_overlimit_inc(police->common.cpu_qstats);
+	tcf_action_inc_overlimit_qstats(&police->common);
 inc_drops:
 	if (ret == TC_ACT_SHOT)
-		qstats_cpu_drop_inc(police->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&police->common);
 end:
 	return ret;
 }
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 44319a159b55..3029e93c4dea 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -69,8 +69,8 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_sample_ops, bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_sample_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
@@ -173,7 +173,7 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 	int retval;
 
 	tcf_lastuse_update(&s->tcf_tm);
-	bstats_update(this_cpu_ptr(s->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&s->common, skb);
 	retval = READ_ONCE(s->tcf_action);
 
 	psample_group = rcu_dereference_bh(s->psample_group);
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 26258b353cde..1f958b7d2a60 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -45,7 +45,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	struct tcf_skbedit_params *params;
 
 	tcf_lastuse_update(&d->tcf_tm);
-	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&d->common, skb);
 
 	params = rcu_dereference_bh(d->params);
 
@@ -85,7 +85,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	return params->action;
 
 err:
-	qstats_cpu_drop_inc(d->common.cpu_qstats);
+	tcf_action_inc_drop_qstats(&d->common);
 	return TC_ACT_SHOT;
 }
 
@@ -221,8 +221,9 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_skbedit_ops, bind, true, act_flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_skbedit_ops, bind,
+						act_flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
-- 
2.43.0

