Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0373D9DC3
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.60.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523036; cv=none; b=Kf+6oUPSViD57CVCDVEnmaJYr++j7fuuImwoS/3IR/tKEek39iYthLZ3mg96gheXmGmiNXWEH+I5mZ1a1pOWVyly/6UBZIOIvy59M3yDp1Fcw6C9LdLItrMKiSEnoVBpik0e3q1bPuIdGdu7zvAUbcQ1HRCXHLDR72TZ4vXrc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523036; c=relaxed/simple;
	bh=/Oz/7P25W1iIZQrB+QXlBefYtAstYQBjGN4+H0fjGmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxX2pupJhS4pHGpgWeVdEs9n02cDVt7Ts+14vvqn0tHd7HUwJC/WWUUMipLV4E32/Y5Qasfz706nUpGgoLL6aFJAeESUoPA+QN0ig92OmiUsyiQyr2zh3jKjzI4hnaPtEQ5wbGfoyTCCLXGtMmlEa5IQ/3yZoy2GLahfWi7rJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr; spf=pass smtp.mailfrom=corp.free.fr; dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b=n5RwjQ4F; arc=none smtp.client-ip=212.27.60.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b="n5RwjQ4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1791523031; bh=/Oz/7P25W1iIZQrB+QXlBefYtAstYQBjGN4+H0fjGmE=;
	h=From:To:Cc:Subject:Date:From;
	b=n5RwjQ4FbztuyXd2tE7joPkGQLXv8Kl6OR37qFMRME0HHwyBe/oYvK30HAfJQgpKF
	 7LMNbHnyyd1iYeXO5VyKJVkETn9iY1yskf3v1EsvllWJrKDJjbq4S900JRfOOZV4b8
	 sOadpSAqkQKQUlk6dB+IAYLtEdYxKbkZqLPI7wDI5QwIb9CdFaFMUzYf2qkXCO24Kr
	 zEOWIntpnsi96T6hG/vzUq5f9ENU7ffwTNa4fuU1syT5xMykQX5LWUnYD2DXW6ekzx
	 +UYY/vWcSp8DZ5I03YcYH4JKN9xx1vxi5YVmZE77+RCwtAsw++7oWO1I6u+i10vuAU
	 FDnJVnllYeQ3Q==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id F22F344C0678;
	Fri,  9 Oct 2026 07:17:10 +0200 (CEST)
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
Subject: [PATCH net] net/sched: act_api: take tcfa_lock for hardware stats updates
Date: Fri,  9 Oct 2026 07:16:59 +0200
Message-ID: <20261009051703.3615846-1-acassen@corp.free.fr>
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
the same counters without it. An offloaded action that also runs in
software can then lose counter updates. On 32-bit the race can also
leave the u64_stats seqcount odd and make its readers spin forever.

Callers disable preemption around this update for the per CPU stats.
PREEMPT_RT forbids taking a spinlock_t with preemption disabled. Pin
the CPU in the per CPU path instead.

Tested for regressions on ConnectX-7 with firmware 28.48.1000.

Fixes: 5e174d5e73df ("net: sched: modify stats helper functions to support regular stats")
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
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
index 6e48b4bc2d75..f634c23d6a65 100644
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
+		preempt_disable();
 		_bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
 
 		this_cpu_add(a->cpu_qstats->drops, drops);
@@ -1604,13 +1603,16 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
 		if (hw)
 			_bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
 				       bytes, packets);
+		preempt_enable();
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

