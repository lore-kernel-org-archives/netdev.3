Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4573A961E
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.60.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645757; cv=none; b=MmaTC1MWddPp1CdWYSbmakUf4wZ+SrfLQRWVmr68ug4TKujXLs92z5v8lh1Pas4v6+Oo4HSrfL77l2pIR7+DC1Dw5A2KqmfaE9x8QVQsg2EzFc7EP4dRYexoGRw86L+b64WSsWnMT0szCIcqaEcvC87VnZx2lOU0Vre2txYW8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645757; c=relaxed/simple;
	bh=JGkLD/BpbGS8zFcs76lrA5BBSbliqt5R4y2whqil170=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcOpjCB8fYvr0Wy8eTQNy+NbIsYOUl5k9KUCHFGGE6rhnBnstKLXPHIq39FVuXtNUCeAfO+V3PaSI3CgP2qBQUj4OCjlJfFZAmiW49miol4nPzdK3ipgjVqUGyyguRNTnoyL0+quuT7liqVTGvGRfzPXVNCLPh7R/3vuPGPjEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr; spf=pass smtp.mailfrom=corp.free.fr; dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b=SZyqe4wa; arc=none smtp.client-ip=212.27.60.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b="SZyqe4wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1791645752; bh=JGkLD/BpbGS8zFcs76lrA5BBSbliqt5R4y2whqil170=;
	h=From:To:Cc:Subject:Date:From;
	b=SZyqe4waAjIzOPLLUfUw46Y6f0TvQEcE2kkIACZQT5ZBRnf4ODZtzepT6BgC8tGbC
	 5rqvURa1kDcMnz7FGH0mWDtkBviaQ815z0dlvHCB8UtW4WbtgXE8/lbGfQo4ILHgTW
	 YloJONAlatUn6TktnFwjYO0kQ+1fxAxqqzEzRK2p3MpQULnXZ0ug5dKnbw8pxA/Sp2
	 hwJUYiX2FXmjIDn60RLEotoEa/DgApbmADLsv4mbSxWniTKMazDHdmiJ4N4dhcY7mx
	 AoVvxRg9TJeN4FKVenk/UfF+ykRY+/PqkURvPO7+D7koHu/mAJdzMfKzYbFsJEsxnh
	 Ib+KSNu0W29lQ==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 5F7FD44C0AB6;
	Sat, 10 Oct 2026 17:22:32 +0200 (CEST)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	netdev@vger.kernel.org
Subject: [PATCH net v2] net/sched: act_api: take tcfa_lock for hardware stats updates
Date: Sat, 10 Oct 2026 17:22:25 +0200
Message-ID: <20261010152227.401987-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actions without per CPU stats update their counters under tcfa_lock in
the software path but tcf_action_update_stats() adds hardware stats to
the same counters without it. A dump of a filter without skip_hw does
this even when nothing is offloaded, so such an action loses counter
updates. On 32-bit, readers holding tcfa_lock can also observe torn
64-bit values.

Callers disable preemption around this update for the per CPU stats.
PREEMPT_RT forbids taking a spinlock_t with preemption disabled. Disable
BH in the per CPU path instead. On 32-bit, this also keeps a softirq on
the same CPU from updating or reading these counters in the middle of
the update.

Discovered by manual code inspection while letting more actions honor
TCA_ACT_FLAGS_NO_PERCPU_STATS. Reproduced in a VM without kernel
changes, where the second action counts fewer packets than the first:

  ip link add d0 type dummy && ip link set d0 up
  tc qdisc add dev d0 clsact
  tc filter add dev d0 ingress matchall \
     action gact pipe action gact pass no_percpu
  yes "filter show dev d0 ingress" | head -10000 > batch
  while :; do tc -s -b batch; done > /dev/null &
  samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh -i d0 -t 4
  tc -s filter show dev d0 ingress

The 32-bit issue in the per CPU path comes from the Sashiko AI review
of v1 [1] and was not reproduced.

Tested with the reproducer and the tc-testing action, matchall and
flower tests with lockdep enabled. Also tested for regressions on
ConnectX-7 with firmware 28.48.1000.

Fixes: 5e174d5e73df ("net: sched: modify stats helper functions to support regular stats")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051703.3615846-1-acassen%40corp.free.fr [1]
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
v2:
- Fix the 32-bit consequence (Eric).
- Disable BH instead of preemption in the per CPU path (Sashiko).
- Say how the bug was found and validated (Jamal).

v1: https://lore.kernel.org/netdev/20261009051703.3615846-1-acassen@corp.free.fr/

 include/net/pkt_cls.h | 2 --
 net/sched/act_api.c   | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 5f5cb36439fe..9382405b2bab 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -316,10 +316,8 @@ tcf_exts_hw_stats_update(const struct tcf_exts *exts,
 				continue;
 		}
 
-		preempt_disable();
 		tcf_action_stats_update(a, stats->bytes, stats->pkts, stats->drops,
 					stats->lastused, true);
-		preempt_enable();
 
 		a->used_hw_stats = stats->used_hw_stats;
 		a->used_hw_stats_valid = stats->used_hw_stats_valid;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 6e48b4bc2d75..4ff553f3abb6 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -307,13 +307,11 @@ int tcf_action_update_hw_stats(struct tc_action *action)
 
 	err = tcf_action_offload_cmd(&fl_act, NULL, NULL, NULL);
 	if (!err) {
-		preempt_disable();
 		tcf_action_stats_update(action, fl_act.stats.bytes,
 					fl_act.stats.pkts,
 					fl_act.stats.drops,
 					fl_act.stats.lastused,
 					true);
-		preempt_enable();
 		action->used_hw_stats = fl_act.stats.used_hw_stats;
 		action->used_hw_stats_valid = true;
 	} else {
@@ -1597,6 +1595,7 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
 			     u64 drops, bool hw)
 {
 	if (a->cpu_bstats) {
+		local_bh_disable();
 		_bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
 
 		this_cpu_add(a->cpu_qstats->drops, drops);
@@ -1604,13 +1603,16 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
 		if (hw)
 			_bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
 				       bytes, packets);
+		local_bh_enable();
 		return;
 	}
 
+	spin_lock_bh(&a->tcfa_lock);
 	_bstats_update(&a->tcfa_bstats, bytes, packets);
 	atomic_add(drops, &a->tcfa_drops);
 	if (hw)
 		_bstats_update(&a->tcfa_bstats_hw, bytes, packets);
+	spin_unlock_bh(&a->tcfa_lock);
 }
 EXPORT_SYMBOL(tcf_action_update_stats);
 
-- 
2.43.0

