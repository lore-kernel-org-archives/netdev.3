Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7A23C51D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784937; cv=none; b=bCnAhGm0F7ZsCeShxRZHhtOvVVRgQxY27dw7tQTL5VsbD5eGWMRDMf4ZLPo8XXo1uwjRvGwnMby3CCyXCz7HYojRxlrqgDT8OuPlH6CrgmBMyHgFhV7EY1Qqk6bgCux8DerdQlN4VeUNEmdS7e08EtelT6mRXthzDBAPYbSoHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784937; c=relaxed/simple;
	bh=3ds6Kxo8KcToMGKlp0BSgF6Z+8tStFHjy+wAKuW4LJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMnv05FQb3VwTbfWDBiVVwlzvvYfFQ1kfzkWy0+Uw5xozr9IyQZNqOVq7N7UnBhNMXyjluMrg9ca0tYUR3nd+M3N16TGcAyEjOTj9ZE6OtY8wHeZGtm/5VFvPP5nVhG92usHOLEtnrBc+H+gYxrr+xsjdBLtjh7Usj62VfHqkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpKEVUJg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpKEVUJg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6d28aa26cso6541575ad.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791784936; x=1792389736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/ggKxDXF1W4YTObb0Gqmnak9Gw8ra8VXEN2yWLxx6o=;
        b=fpKEVUJgS+E8Ugk5K/rMEtfMNqEQ/gSzQtjKnVZNG0WxiLYl3WSLXvBs1C4JNf3tT0
         KihZhyE5c5aXMow/hEW7WSBA/8fJuifFI5MV20quz4QeuhbKFnybP4GAF2yUFpeEKLha
         4yw7wHjKm5sP2OEl0zoqYag3+L4LuMc7U9xh+WGXAy+NbQJaLxYsqtGPtW7H4gXeDOoK
         oiN3zd7vMf46M9moQ571LWSFpShqoETOI3206Cg7x8aT/WU0aclIXmyXMACnm50RyKJT
         9+ezW9gyUFNRLOHWPKGbR15W1GzVXVObAwQHUWXJQoZJwSgeBjfW72eQQQf0yo8OuQCj
         3MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791784936; x=1792389736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/ggKxDXF1W4YTObb0Gqmnak9Gw8ra8VXEN2yWLxx6o=;
        b=hBNx27QUBDQWcS6z0TaT4wWZtO/P6ePwTUlqIkS56vUheLtAjQZG3J9nyX966TEUwx
         3vBRIGgoTh39YC4e9sXE1I4LTKG+zIhCepIaVjAvTh5289JaWaTnzZoExX+TLtgPw3JZ
         ra+QCSijPFO26DhZpDgMFcAJQgiT83LMmrdhKWnVONPcGNbSMHWBTa7VF0WwJ03QhFn0
         kkQlmwpxc15sh706p9/VbFGEI1O/4udRiqcLQzGHQEOvIJMLwnzjBUW4ggYUnJrkrw+i
         EDyZtWNzp1hfYYkugcPQzdJWqE6h2ENnfcAuu8zxM2w0ECez9JD3t4ptYEVtX9pel8Us
         LufQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSV8+JRHYNsRkBnKMiN8jnxeYeKxg99p3HEqgsdlMWVLqvZyMnNM8qKMONcEU4Jghkz+0ulE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8IzS2mDYDCGZImFZGc/HoXCzzngc46FNNnJVV/sAAoaa3IE5q
	SnfHsigFBCTHTG4Smxdj1tPAkpHBz7y7tJOpE8mXncpu6OJ4YBAAFZTQ
X-Gm-Gg: AYBFou32yYeLMstTKMFHOGhytRZVCzQUlIZWYRgNLGbg/2fIdhUUA0bw/KMuXzU7v2k
	X4KG+6FktwjTpkKQd9rgPtqTQOqR0o80nacaaYYllRFFjo1ZcPdI47TC5/QI1+7fal4gyow4akd
	LCpZWi62eRtT1L52yeWwKXYxyxVNHPAytxyKK7kfK72byTDzq4+/4Yt6MYn4a7OPypZ8G7GAxgc
	tG5BVTARRtKm5dzoYxiFPvtV+BfXr5b0bALfVG7nEujko2VeVfuMFQ0B9hgaKp61w+TKz9Z9X8X
	if5hNTXafvr0xpUkRF20bwCTb9J41vxh4lhJ0wD35x4utQwC0yTC5Q2O2i1OjOs2czxtri3BC9+
	QolYEs4rMi6tyT+7hLFyfkmK9KZJE6DJEdXYBCMySV9QTgRS+HxGsYxH8GlN6+KP9Z2grCUMNjn
	M4KD4L6t7ee2orxoOjJTiZ0J4uNS0iBvsDibKm4HdgyKKKFptmLUi4+ynRDPXBt8h1Tg1SWUBxL
	rW2kxSKpjKzR7x9h6MgzkUk/+EtWVUhLYAdjg==
X-Received: by 2002:a17:902:d2c8:b0:2e6:646:8ee5 with SMTP id d9443c01a7336-2e842cd3e90mr71251985ad.39.1791784935605;
        Sun, 11 Oct 2026 23:02:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a03:88e9:69f9:d4b:a47:6619])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219f2bfsm39746645ad.21.2026.10.11.23.02.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 23:02:15 -0700 (PDT)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11] net: reduce ARFS flow updates by checking LLC affinity
Date: Mon, 12 Oct 2026 14:01:08 +0800
Message-ID: <20261012060152.2930-1-nashuiliang@gmail.com>
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
(e.g., arfs_lock). In high-load scenarios, this contention often becomes
a performance bottleneck that outweighs the steering benefits.

This patch introduces a cache-aware update strategy: the hardware
steering update is skipped when the flow's previous target CPU and the
new one share the same Last Level Cache (LLC), as cache locality for
the application is preserved either way. The per-queue flow bookkeeping
(rflow->cpu) is still updated, so RFS keeps steering packets to the CPU
the application is running on, and subsequent packets take the fast path
in get_rps_cpu() (tcpu == next_cpu). A new sysctl,
net.core.arfs_llc_affinity, is added to toggle this feature (default:
off).

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

  Before: ~200,000 counts/sec
  After:       ~10 counts/sec (reduced by ~99%)

These results demonstrate that filtering updates by LLC affinity
significantly reduces driver lock contention and improves overall
CPU efficiency under heavy network load.

[1] https://github.com/apache/brpc/
[2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v10 -> v11:
- rename the sysctl from net.core.rps_feat_llc_affinity to
  net.core.arfs_llc_affinity, per Neal Cardwell
v9 -> v10:
- move the LLC check from rps_record_sock_flow() into set_rps_cpu(),
  so that only the ARFS hardware steering is skipped while rflow->cpu
  is still updated, per Eric Dumazet
- drop the sock_rps_record_flow_hash()/sock_rps_record_flow() exports,
  which are no longer needed
v6 -> v9:
- simplify code and fix errors in AI submissions, per Simon Horman
v5 -> v6:
- remove the multi-check 'old_val == new_val', per Xuan Zhuo
- fix 'modpost: "sock_rps_record_flow_hash" [drivers/net/tun.ko]
  undefined!', per kernel test robot
- fix 'tcp.c:(.text+0x3e90): undefined reference to
  `sock_rps_record_flow'', per kernel test robot
v4 -> v5:
- fix 'modpost: "rps_llc_check" [net/sctp/sctp.ko] undefined!', per
  kernel test robot
v3 -> v4:
- add rps_llc_check, per Eric Dumazet
v2 -> v3:
- patch net -> net-next, per Jakub Kicinski
v1 -> v2:
- add rps_feat_llc_affinity; add brpc tests
 include/net/rps.h          |  1 +
 net/core/dev.c             | 23 +++++++++++++++++++++--
 net/core/sysctl_net_core.c |  7 +++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..6664970e68d6 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -12,6 +12,7 @@
 
 extern struct static_key_false rps_needed;
 extern struct static_key_false rfs_needed;
+extern struct static_key_false arfs_llc_affinity;
 
 /*
  * This structure holds an RPS map which can be of variable length.  The
diff --git a/net/core/dev.c b/net/core/dev.c
index a6951ea08961..434ad5499906 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5122,6 +5122,7 @@ struct static_key_false rps_needed __read_mostly;
 EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
+struct static_key_false arfs_llc_affinity __read_mostly;
 
 static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
@@ -5160,7 +5161,7 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash)
+	    struct rps_dev_flow *rflow, u16 old_cpu, u16 next_cpu, u32 hash)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -5179,6 +5180,24 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
 		    !(dev->features & NETIF_F_NTUPLE))
 			goto out;
+
+		/*
+		 * ARFS LLC Affinity Feature:
+		 * Reduce ARFS flow updates by checking LLC affinity.
+		 *
+		 * Frequent flow table updates can trigger constant hardware steering
+		 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
+		 * contention on driver internal locks (like mlx5's arfs_lock).
+		 *
+		 * Skip the expensive hardware steering update if the flow's previous
+		 * target CPU and the new one share the last level cache: cache locality
+		 * for the application is preserved either way.
+		 */
+		if (static_branch_unlikely(&arfs_llc_affinity) &&
+		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
+			cpus_share_cache(old_cpu, next_cpu))
+			goto out;
+
 		rxq_index = cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
 		if (rxq_index == skb_get_rx_queue(skb))
 			goto out;
@@ -5308,8 +5327,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
+			rflow = set_rps_cpu(dev, skb, rflow, tcpu, next_cpu, hash);
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 473c162736d6..9ce0bbe454c8 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= rps_sock_flow_sysctl
 	},
+	{
+		.procname	= "arfs_llc_affinity",
+		.data		= &arfs_llc_affinity.key,
+		.maxlen		= sizeof(arfs_llc_affinity.key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key
+	},
 #endif
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
-- 
2.47.3

