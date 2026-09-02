Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91727473
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317539; cv=none; b=XUE8aXO8QTRBrPm6iYZTtj+HFdnGR9+ObIR5Yo1JlbvPVNURmaWQqdg02c3G9kqErpbIRrKeGN5LPbFPOgol2oiejjQsCT0JPLA3C6y0i6ObYR7DcsDbKQNA1K//o233Sv6REv9oy8h+7vWYgZXdqTSSRmaxS7U9/4oPBcrLVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317539; c=relaxed/simple;
	bh=YeV15R2lDRiVzc/laEc1ZaaizGWz3jJF/D0Qx6RqRec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI5+HDKNeVX+DZn3aF3Klub4TShvyAF7cactXFYmHgshdcdYwoOL6TlEVbBGCaJ+CuiEYocMhn9P/wRlz9rmdmvIL+ZBjNPb1IdT4MRPkWY9ewUeALvCoi/wQvP+xH1gNWcoUPee0ySWq0aZv3/McwdZATcSq0IK6fgw/Aa06yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/7I0AbV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/7I0AbV"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso719514a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788317537; x=1788922337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yzTJ93PCaEZ5D5jmlYA5kUGeF6TKHbLfz1jwc+xMCyE=;
        b=r/7I0AbVBo3d8GKzPF22GrmiLD4h7cwcx2qnft4p/akNjwJoLEDFz5BGIAAOsWMbDG
         m7cPx3LfbCdzovd2UXIxVqXfGRtnZIe8vf3FFrrrcsIZm84FhGrkGo57nRKwM4v9K0xS
         JoP2pAY7PIf1y291nzCg1nS1tkRFgTU0j6djqCYkkuAOnf4S/b6/RQkPfnKd93SH8sIB
         NlTzoyzOwpPpzAs56kGsTm7AoyVgyLcSaEWuunUQwmCFz5RfpLr0ffCIFhy8gLyl3C5K
         3e7ceYvkbmpZyCIDg1gZwxW+K8DM4wv94yastM6jRN/MjAAiolP1GTsalaeG/71nwAJ0
         +G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788317537; x=1788922337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzTJ93PCaEZ5D5jmlYA5kUGeF6TKHbLfz1jwc+xMCyE=;
        b=CHTl4frSFpXiPPEXcdY2mOL7bhq5XCWYQDE8YqJkFPLZPh2hg8MIVa9orL2rgo1K0S
         JTbJL9bcqrtFhSeMDmDswoueNHJjPsvG/RIPMIW4/RRhjekY134761kF0woSaUPmbIqd
         5naahihpNrUxeUxN3dmws9E6rEoNecokZVdH8ajoOxJQ2hY7kgR0pZKzuytgyIMAh+rx
         NVFXvEZWJqZWly/Ih79lz3n/kWt1zmSX2rGE54LHyc7NjE22dczbVJwUmVrUKVEE09Xm
         ow+oOrDnVhw8S2AuOAROavwWWDc7xVsj90jU4FVTuSU3OQZo9PzcyY4I2AHXb+rfKQ4Q
         HOhw==
X-Forwarded-Encrypted: i=1; AKwUvBzqirBFgxUWDxBtZj2eJsV6wdRnfuk/hnpnKYNpIiGFJg/lwaekonx11TS2zAgNGfh7RwqEU1s=@vger.kernel.org
X-Gm-Message-State: AFuF++kb0y2WSIG+fHHz10fEZuNfm4bUMKYcZ7vY+kcoPn705xDEVM/z
	TgE1Hfy7b5l+8P8vTw5jHp8/WZSEWOK7XKDk5WLV3IL0wdLkqbW4FNjG
X-Gm-Gg: AYBFou02VQakV8eSNejEugZuq+RNTa31b+3zvp5kRR3nrm7YD/KBudxa1/cjeOSD9X1
	6f7L6jOSwts2RLno3ZLrAbRSDmqUwgWV4oMvuuhjg9otV3kEh+FcMjO9shPE80K4c7wil0Suic4
	s/JGLr96Ct/vYaRl8OL0BWirBRjHlJDNOtG9Io5z9UleRu/hgpeZgmDWJJZzOzmhQdijhAlx22i
	Ufopa15mhQKD45u/Rma5sEeofvGrM8qN2yYGKF+OxKWtf1XhDgjL4FZAr5yMQ3tNYOjaCrBMOgX
	7STT14P0TdUGS8DoZgIp4raMAU7zHIqJ+DBU+xfxbHw/aYm133K/a1TAoxD4jZMRKvsdKxiR5WT
	fUHK0YRtVvWL2rA94Fe1O9PF0gUDOAVjLP9f1XC4qxHTLCVaOC4EdCWhI9xs5AWQU1momk8Fv7f
	pxN1vISYSzGEc61WQ0mT1mE6oNklcl67HHqeDp8sp/5Y/8mVZ4ZdPZRpfITwpcStDmiVc9CSp9q
	lWfOGqOBKyZf9nnWkDt6GGkSIsb7mNdNZFpJaYz
X-Received: by 2002:a17:90b:52cf:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-39af57d22cemr27654a91.1.1788317537183;
        Tue, 01 Sep 2026 19:52:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1d85:2435:e053:31e9:f73:7a2a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae60a8e61sm531263a91.0.2026.09.01.19.52.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 19:52:16 -0700 (PDT)
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
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Wed,  2 Sep 2026 10:51:50 +0800
Message-ID: <20260902025203.4741-1-nashuiliang@gmail.com>
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
v6 -> v8:
- simplify code and fix errors in AI submissions by Simon Horman
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
 include/net/rps.h          | 28 +++++-----------
 net/core/dev.c             | 66 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c |  8 +++++
 3 files changed, 82 insertions(+), 20 deletions(-)

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
index 38336858c168..b27839eb594d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5052,6 +5052,8 @@ struct static_key_false rps_needed __read_mostly;
 EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
+struct static_key_false rps_feat_llc_affinity __read_mostly;
+EXPORT_SYMBOL(rps_feat_llc_affinity);
 
 static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
@@ -5263,6 +5265,48 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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
+	u32 old_cpu = old_val & net_hotdata.rps_cpu_mask;
+	u32 new_cpu = new_val & net_hotdata.rps_cpu_mask;
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
@@ -5318,6 +5362,28 @@ static void rps_trigger_softirq(void *data)
 
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
index eb35da3556f4..9b6702f5eab1 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -210,6 +210,7 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 	kvfree_rcu_mightsleep(tofree);
 	return ret;
 }
+
 #endif /* CONFIG_RPS */
 
 #ifdef CONFIG_NET_FLOW_LIMIT
@@ -554,6 +555,13 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= rps_sock_flow_sysctl
 	},
+	{
+		.procname	= "rps_feat_llc_affinity",
+		.data		= &rps_feat_llc_affinity.key,
+		.maxlen		= sizeof(rps_feat_llc_affinity.key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key
+	},
 #endif
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
-- 
2.47.3

