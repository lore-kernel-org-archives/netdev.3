Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228386;
	b=bjRSSHoDstJgHMdj18lhZ7tfd4io5cd9speUfjW4ZT9oGUEUryKkLubHT5ziBWz1qO0n
	 VDCWoL+Wt7JKhVTBshY6mmzi8esAXmUfANSx+c8yE6XI94pkvpD4D+mNA26tBnRqBcgPC
	 9MhvDT9ADc/HdYa2FI/2p5U5RSvnUk1uBkyInKYiNPKfxMRGNuIYYFDkSXD0AKpGBwqnl
	 b9Ae4ov3001/pBjcdtnmvJIQKZVzjNcJmX5mEy7YlJL/dwZTQqI/GgR5FkncrG1E+mWz4
	 ojOSp6xtfIymAsx19y4URka0ETojVtE9orXrXA7BbeW5upLXG0tybftdg2nTxnf+FNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228386;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tbvE3ophgrCUQZIitAd161cuT38XHDTnYd9KZkSD83M=;
	b=iY94rRccPFLBWkmEv8jYUG7EDi+HYTDZjFRhdNg6lpkqEuRiqhVve3wa/AUTksoaC3vn
	 65Vq9SGwNtYQ2TquIe4FUtmxn7QEEFlHhNAubjr6DTHLwxQ2Y5ArxLFC7N6m4i1XBlHIc
	 JwfmPcImAyonxb4mx8U+aDpS9FYzB7Ih8KCOgsIp4+7KE5ajR1qxbaDBQHuuJsrzqY9Wm
	 bt0kVBQ/i5Dge3zwkc2PjqV79xlOvPozll5AqLRabeNbuI3chqU8m38XwxC5JPYWFZFi5
	 iiWQKiM6SskoqvARI+2C102kfVvqXIWFPJ1tXBpAkZrlP4Y0qavf9MIzCrYkargXiLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=SqpZePNg;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5F606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA5F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=SqpZePNg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794228383; bh=erhRTUimfQJ4m5/y91hsFMpy4dgpR2za3cl+zBj1KbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqpZePNgfnEeQUeB7nLCEbEypN1kfNbn0ETKnuoUedkdJ858ktL3fpFAkkBF1kKBs
	 X2SdG4gG9/3wHZ2Jp7H9kqUE2tYMmLY1sTu8V8nhAdBjSuV2oGv4fm7l69ioNbAHn3
	 QdX+9Oz7J48ODSfQsA0MWV+tknFha+O/KOVGWJ8luwQgJoWfzvaauC6RVjR4OSdicr
	 zu2ezrZS5ahQhScc2tATzCHQmP2XOgJ8fTHFViHmq/xypk30Om2BOQKuI6DHH90tC0
	 0uLbRAYAZanSD6SQetyoHq16diAToz73H6FhBIsP92SDHpENUot8tsxzkNI2/15T2m
	 +mthp20PTePaQ==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id A9CD544C0591;
	Mon,  9 Nov 2026 13:46:23 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
Date: Mon,  9 Nov 2026 13:46:12 +0100
Message-ID: <20261109124618.933149-2-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109124618.933149-1-acassen@corp.free.fr>
References: <20261109124618.933149-1-acassen@corp.free.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbedit, police, mpls and sample store and dump
TCA_ACT_FLAGS_NO_PERCPU_STATS since commit 40bd094d65fc ("flow_offload:
fill flags to action structure"), but still allocate per CPU stats.
These take about 8 KB per action on a 128 CPU host.

Honor the flag as the other offloadable actions already do. For example,
a per subscriber policer offloaded to hardware:

  tc filter add dev $DEV ingress protocol ip flower skip_sw \
     dst_ip 10.0.0.1/32 \
     action police index 1 rate 1mbit burst 10k \
     conform-exceed drop/pipe no_percpu

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
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

