Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1F38F651
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811281; cv=none; b=ABOSOMemiSltK5JRGF9GsVNOTRICRQW/+5eBJKaHKp+Iy+H0dC/0Bd68N4Y13NR9LPDIsRvUxVEaiPEahtH1FDgo4fgbhRv1fHcUHJgqzGs+vW9cnaDSO737j54NIvAme2OPUXOz1pwQu5A8Smf7E6F7SWlSjkf0SH4bxpnUyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811281; c=relaxed/simple;
	bh=MqL9TW9N4CENql6gpeGpeHYkUTGAtQIOnqiZnaosYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMBFvfxwAtlBMZoPXPCTuUNy23c+sWUFeDeejAtSGVSnd6plzpnho15Qy/D18gO30+2GN0kqrFvap9kPBMlR6aDSciVafi9U9ApXTzFgNfUmilNXYSITG9UGwHBF3shGVyfO5d+mw6dUqhSCAIl0+D9ZtfZJoVQozywHaq5vAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL+1HZRk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL+1HZRk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so2169348a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785811279; x=1786416079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R99t18r/MBBn5fJI0PrkYBnwX+CoZ157t3+2kby/7/w=;
        b=NL+1HZRk9/EAx2rI/Q3o2rVqyz/vg/vYgwiYZwWfD9WyNVO6iM7ziqbYNNYD3+FRjp
         dKbpa6P2kkiWN9w3xqkg+lKgjkz5gQWSsVJFxvFMdIxXPo50AFbkNSoo40ovU9UGBDVr
         D8+9eYmnLmK59KspcH/H69sjQnUuBd1HpONSUYKzB/MgBVxgH+vwFtGpySI0zCjfERFF
         OVuYs2v7KKZ/lx6rsQYJ2CytC5eNa96lurRFrG0wCQ5afd34bF5PULhIggLvFnCLooGS
         2w8i6vJwnWaQaIFrUO1fvFU5ooU/IWvCLD3zHfdHZd6o/lNV1IhNfz2k1UGXbGI1Fygg
         +csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811279; x=1786416079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R99t18r/MBBn5fJI0PrkYBnwX+CoZ157t3+2kby/7/w=;
        b=hjiuMIgYFT3QJUUXlqQeU8q/rI1lvZyKBDg9j+ydFN5abZm3l6uysMgDFDJ+7M9y23
         l0VLkHiWKqOwdS9SWAXJqC2E3HpQqB7kT+3F3QyB6BuF0OlwzzcWWelHSyepp4l8q7Eg
         WahQ+DQ9j56ts0OXP5coU/P57pU+Q6s2KinEBmirzqf8HvqfhiremVWoaENXBbPTXfqt
         pvmWn482tX27M0jv1ug2Hmq/JvITOOv3KV/WH7IIQQrxKsba7j+Dhr+lyn+16V3hxivf
         lUeeZb1HcIbUwg0oznFD2++ejKD8/XyOb5iKSE5ne665FMx/P9T3sMNbZ3gUJf7jJzvw
         u0oA==
X-Forwarded-Encrypted: i=1; AHgh+RoKnHQaDtgcMox/cZPbp0ukB2Df/vGbAj2hE6Fydb9Ihv4oGj44B4U4i88NQQ4X1rmWHQvUZ/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97PFSW7eWsKvxkTNyg63/ExDluUPN254DoT90K3XUDOMJU8Wp
	BTyXidNwxHCou/bE8gEaqCBYApPj1oQDNHp1YHTXXCB7kvbLxGTJ9d53
X-Gm-Gg: AR+sD12oejIBGzvDFPT/nyB5PRdDNYJXgJ8R/aGCsvbiMaXH6JWlJkKTBsSLVHwCvbF
	quLrL0F0I8sIjnHNA4Snxhx79sqAYrDgQPapb5QnsfVsQodn/0D7G85X42R31i8sbLHV/uOmI1C
	y8XBRTWdeZ/snErkbGQfx/34/hQKe+BmUSU8w9aZnXGwYeGv5EfoObZyfUBkw1y1wNId43fZSTu
	FE7a4kjhI/NpMF0qyGe9RrCNQYhQh/VUMJUSsQ1+PXytGt4N2JJ0NtqOSAiPnesBHH4z5XC+QyO
	sbHU/5ATfKuSoGVAfCA1ari2ixS6vw54TWJV1KTe+CyzW+67VVn90VuovFsTn5bHGYQJ1JHXXXC
	XnoCvJ1vcgIWdI0LCtcOWnIdANB0i/xWi0D/Ehw6XZtjMfQcqDmqsQVEZclP34S46pv4pS1oV1s
	+btR9h7oFO+MCkShs+b51B+KhDtkIGe+PTGa5IlCGnGTdB6ao4fp/77FX1lKI86IRkoW7u9UhAM
	mB2kqf/cdLAhr6xBvPRvPgyj5txXqAGJqIDKEkd
X-Received: by 2002:a05:6a21:3a87:b0:3bf:7994:ddc6 with SMTP id adf61e73a8af0-3c92a750fa2mr12585060637.25.1785811278533;
        Mon, 03 Aug 2026 19:41:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:8f06:144e:50c1:4365:3125:59b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963ddb8sm4349836a12.3.2026.08.03.19.41.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 19:41:18 -0700 (PDT)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Tue,  4 Aug 2026 10:40:39 +0800
Message-ID: <20260804024053.765-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of rps_record_sock_flow() updates the flow
table every time a socket is processed on a different CPU. In high-load
scenarios, especially with Accelerated RFS (ARFS), this triggers
frequent flow steering updates via ndo_rx_flow_steer.

For drivers like mlx5 that implement hardware flow steering, these
constant updates lead to significant contention on internal driver locks
(e.g., arfs_lock). This contention often becomes a performance
bottleneck that outweighs the steering benefits.

This patch introduces a cache-aware update strategy: the flow record is
only updated if the flow migrates across Last Level Cache (LLC)
boundaries. This minimizes expensive hardware reconfigurations while
preserving cache locality for the application. A new sysctl,
net.core.rps_feat_llc_affinity, is added to toggle this feature.

Additionally, export sock_rps_record_flow_hash() and
sock_rps_record_flow(). This resolves a symbol visibility compilation
error triggered by 'tun' using sock_rps_record_flow_hash() in
tun_flow_update() when CONFIG_TUN is built as a module. The same logic
is applied to SCTP, allowing it to use sock_rps_record_flow() safely
when built as a module.

Performance Test Results:
The patch was tested in a K8s environment (AMD CPU 128*2, 16-core Pod
with CPU pinning, mlx5 NIC) using brpc[1] echo_server and rpc_press.

rpc_press Commands:

  for i in {1..8}; do
    ./rpc_press -proto=./echo.proto -method=example.EchoService.Echo
    -server=<IP>:8000 -input='{"message":"hello"}'
    -qps=0 -thread_num=512 -connection_type=pooled &
  done

Monitor mlx5e_rx_flow_steer frequency:

  /usr/share/bcc/tools/funccount -i 1 mlx5e_rx_flow_steer

Frequency of mlx5e_rx_flow_steer (via funccount[2]):

  Before: ~335,000 counts/sec
  After:   ~23,000 counts/sec (reduced by ~93%)

System Metrics (after enabling rps_feat_llc_affinity):

  CPU Utilization: 38% -> 32%
  CPU PSI (Pressure Stall Information): 20% -> 10%

These results demonstrate that filtering updates by LLC affinity
significantly reduces driver lock contention and improves overall
CPU efficiency under heavy network load.

[1] https://github.com/apache/brpc/
[2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v6 -> v7: no change; keep discussion;
v5 -> v6:
- remove the multi-check 'old_val == new_val' by Xuan Zhuo
- fix 'modpost: "sock_rps_record_flow_hash" [drivers/net/tun.ko] undefined!' by kernel
  test robot
- fix 'tcp.c:(.text+0x3e90): undefined reference to `sock_rps_record_flow'' by kernel test
  robot
v4 -> v5: fix 'modpost: "rps_llc_check" [net/sctp/sctp.ko] undefined!' by kernel test robot
v3 -> v4: add rps_llc_check by Eric Dumazet
v2 -> v3: patch net -> net-next by Jakub Kicinski
v1 -> v2: add rps_feat_llc_affinity; add brpc tests

 include/net/rps.h          | 28 +++++----------
 net/core/dev.c             | 73 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c | 35 ++++++++++++++++++
 3 files changed, 116 insertions(+), 20 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..6dacf0888a6c 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -12,6 +12,7 @@
 
 extern struct static_key_false rps_needed;
 extern struct static_key_false rfs_needed;
+extern struct static_key_false rps_feat_llc_affinity;
 
 /*
  * This structure holds an RPS map which can be of variable length.  The
@@ -55,11 +56,14 @@ struct rps_sock_flow_table {
 
 #define RPS_NO_CPU 0xffff
 
+bool rps_llc_check(u32 old_val, u32 new_val);
+
 static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
 {
 	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
 	u32 val = hash & ~net_hotdata.rps_cpu_mask;
 	struct rps_sock_flow_table *table;
+	u32 old_val;
 
 	/* We only give a hint, preemption can change CPU under us */
 	val |= raw_smp_processor_id();
@@ -68,7 +72,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
 	/* The following WRITE_ONCE() is paired with the READ_ONCE()
 	 * here, and another one in get_rps_cpu().
 	 */
-	if (READ_ONCE(table[index].ent) != val)
+	old_val = READ_ONCE(table[index].ent);
+	if (old_val != val && rps_llc_check(old_val, val))
 		WRITE_ONCE(table[index].ent, val);
 }
 
@@ -136,25 +141,8 @@ static inline bool rfs_is_needed(void)
 #endif
 }
 
-static inline void sock_rps_record_flow_hash(__u32 hash)
-{
-#ifdef CONFIG_RPS
-	if (!rfs_is_needed())
-		return;
-
-	_sock_rps_record_flow_hash(hash);
-#endif
-}
-
-static inline void sock_rps_record_flow(const struct sock *sk)
-{
-#ifdef CONFIG_RPS
-	if (!rfs_is_needed())
-		return;
-
-	_sock_rps_record_flow(sk);
-#endif
-}
+void sock_rps_record_flow_hash(__u32 hash);
+void sock_rps_record_flow(const struct sock *sk);
 
 static inline void sock_rps_delete_flow(const struct sock *sk)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259..53bad3c801dc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4997,6 +4997,8 @@ struct static_key_false rps_needed __read_mostly;
 EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
+struct static_key_false rps_feat_llc_affinity __read_mostly;
+EXPORT_SYMBOL(rps_feat_llc_affinity);
 
 static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
@@ -5208,6 +5210,55 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	return cpu;
 }
 
+/**
+ * rps_llc_check - determine if RPS flow table should be updated.
+ * @old_val: previous flow record value.
+ * @new_val: target flow record value.
+ *
+ * Return: true if the record needs an update, false otherwise.
+ */
+bool rps_llc_check(u32 old_val, u32 new_val)
+{
+	u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
+	u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;
+
+	/*
+	 * RPS LLC Affinity Feature:
+	 * Reduce RFS/ARFS flow updates by checking LLC affinity.
+	 *
+	 * Frequent flow table updates can trigger constant hardware steering
+	 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
+	 * contention on driver internal locks (like mlx5's arfs_lock).
+	 *
+	 * This strategy only updates the flow record if it migrates across LLC
+	 * boundaries. This minimizes expensive hardware updates while preserving
+	 * cache locality for the application.
+	 */
+	if (static_branch_unlikely(&rps_feat_llc_affinity)) {
+		/* Force update if the recorded CPU is invalid or has gone offline */
+		if (old_cpu >= nr_cpu_ids || !cpu_active(old_cpu))
+			return true;
+
+		/*
+		 * Force an update if the current task is no longer permitted
+		 * to run on the old_cpu.
+		 */
+		if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
+			return true;
+
+		/*
+		 * If CPUs do not share a cache, allow the update to prevent
+		 * expensive remote memory accesses and cache misses.
+		 */
+		if (!cpus_share_cache(old_cpu, new_cpu))
+			return true;
+
+		return false;
+	}
+
+	return true;
+}
+
 #ifdef CONFIG_RFS_ACCEL
 
 /**
@@ -5263,6 +5314,28 @@ static void rps_trigger_softirq(void *data)
 
 #endif /* CONFIG_RPS */
 
+void sock_rps_record_flow_hash(__u32 hash)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_record_flow_hash(hash);
+#endif
+}
+EXPORT_SYMBOL(sock_rps_record_flow_hash);
+
+void sock_rps_record_flow(const struct sock *sk)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_record_flow(sk);
+#endif
+}
+EXPORT_SYMBOL(sock_rps_record_flow);
+
 /* Called from hardirq (IPI) context */
 static void trigger_rx_softirq(void *data)
 {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..b6d4ebcbb6a6 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -210,6 +210,33 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 	kvfree_rcu_mightsleep(tofree);
 	return ret;
 }
+
+static int rps_feat_llc_affinity_sysctl(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp, loff_t *ppos)
+{
+	u8 curr_state;
+	int ret;
+	const struct ctl_table tmp = {
+		.data = &curr_state,
+		.maxlen = sizeof(curr_state),
+		.mode = table->mode,
+		.extra1 = table->extra1,
+		.extra2 = table->extra2
+	};
+
+	curr_state = static_branch_unlikely(&rps_feat_llc_affinity) ? 1 : 0;
+
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		if (curr_state && !static_branch_unlikely(&rps_feat_llc_affinity))
+			static_branch_enable(&rps_feat_llc_affinity);
+		else if (!curr_state && static_branch_unlikely(&rps_feat_llc_affinity))
+			static_branch_disable(&rps_feat_llc_affinity);
+	}
+
+	return ret;
+}
+
 #endif /* CONFIG_RPS */
 
 #ifdef CONFIG_NET_FLOW_LIMIT
@@ -554,6 +581,14 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= rps_sock_flow_sysctl
 	},
+	{
+		.procname   = "rps_feat_llc_affinity",
+		.maxlen     = sizeof(u8),
+		.mode       = 0644,
+		.proc_handler   = rps_feat_llc_affinity_sysctl,
+		.extra1     = SYSCTL_ZERO,
+		.extra2     = SYSCTL_ONE
+	},
 #endif
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
-- 
2.47.3

