Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193288;
	b=ouYfXWB+CwuXPow8YjpcvUKbV/muV5PlFPW+nUpKob0a0aymAxc14knssVDVHQc2Gbuk
	 7Wj8n9W5iVAtZ3gZi3l60w+TQSaOjxpwxFp1bqwGML4k6L4eoK2fgVEddeQFmoLUhv2HK
	 Mnsnw/9UIGr2xYAfMF+j57RHHPMScyv4wlrqU2QD5VYpjkPuUpRL3iL5Q0jldvFo1WCkV
	 fEeygVQB2YmiXlFRixj86VKmveAITEezZSa8qOeWy3m5fmmqZQ9IEgOTaRrctyx1EpnaI
	 OQMTIUiz7n4GUVPI8lVuscSD18MaA6CDE5b/7Kskkq58G9gIOPKLLUgiCiQXsSp96Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=au/ycR8YCGbRgk4UR5scTYEiXwJwUFZkGT7G4NUC5NI=;
	b=tcAjNcnnVxfKlx7q32KtR62BDLDiuWlZlZpqOLdg9vgQ7rJNA0nbPlMgr3OQvx7ssnDG
	 XBfxGtSuiP1aXhAd/jxFfn6ChOOahOndUgLRXhR/6oqstmR66Vtkmr5L0fjzh9s4edQN4
	 7RWoY/tW6Tyuj3DdIwYReFRCwTQXRv/nyvpdEQEGYQBBAspyZzu+LukQ5A+/U2ZEd5N2m
	 XinD6AUXS8TlgTKDnbWN/RzOJJMRlttnayT6Ivgq8bN9yUy3WT/CfBWmBxxtyHBxdd9+i
	 0uX5bug21yM7vU98+VZco+VQ35QropnP4Pj80MXAmk0G2U+8WkVmP9Th1WMgID9SFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfgyTlgq;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AE606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 03:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8AE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfgyTlgq
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb628232d2so212891a12.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794193286; x=1794798086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=au/ycR8YCGbRgk4UR5scTYEiXwJwUFZkGT7G4NUC5NI=;
        b=mfgyTlgqT1/r2PHrqge7oNsYoEg6ZgbcZdDUcaPsar99gW7jtiQWIx9x8dXvMLldvn
         Gkwu4LjQwZ/rA9lLQ512wk+0J2r4plQUm68LW5Gvev8aGB7uEVrRycrcxPJ5I72NvPff
         /QoDdIsyMbTXJ5bF6uOns1Dqj5lKDkr3dmEH4Av0r6zn+f62D4AFT5zEJqcC8SkzgoHG
         324POKwusnbuEN5//tIRY0AcY+1/Mqa8VKKqGEsTWQcBiwn6SYaaVZSpV+k7Gg5+aTCZ
         rljPRjpJf6hM5BGbbFFH5BnfkgzN5p/fI5WdtcsjrnGzbxF7bacPsKYrWG5nUH3FfkRn
         UIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193286; x=1794798086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=au/ycR8YCGbRgk4UR5scTYEiXwJwUFZkGT7G4NUC5NI=;
        b=UWFlrnbBFOZDCHpgEUCPVNRapUe7uND36rDbfSrFsSNliCSaRLQq8vGumLTszQ/tP4
         IIEACa98jnwrgWf5DCDVvhqO9EgBerl+uQ45FqgEqV407aB1fUY4SeLz96QKoys7k/BV
         RqFi2KV3ISHEBDJP1LGkwKtmz7XRmhJyvhS1pkEAY/8wkA6vl2JPIK2mLK78sD4EWBSb
         VZ9uiwVZPW+dp7fpdP79wjdCamfk0TXYXRF4m0hImH6/qJu/bMGf0rIa8kWMlrzv+B2n
         zZ2dr9Q76JdDPSNp0uZe+Z3HWvI/c8sY7HErERMeL918JUCr5rMUFN01PjxtToVBWk0k
         iUjw==
X-Forwarded-Encrypted: i=1; AL+hErFPWaW/EvaBzGYDRcVPe7bEeV7Cat7awIXXZKbAGfGCJEazXSgd736dFO3ihbjmf9UKZ/ZMZUg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fRdZqGH/Iu32vxZeXAthpRNy9BD1pxwVuUwTZmxhaMC8Zvc2H
	ohqljGank7RWGn/BkdgfG7bPuMdG8XTOSB8GWe6rgZyMSTwdP4rHBGrh
X-Gm-Gg: AYBFou1M/q9mlU8SA5q3XNbXQds0LxYOkQ5KC68dc+NdAwfXhIlPbzp2vympy2Rt5mp
	Wdzwthp1nxnaVU4cZThu5r5h6q98a3m2J149zkoTIsOxCkJAOO2bGJBFhTUPvypGe3lBV/slglx
	cK6EX9Ymz4iy1vQLCcykbK+Q0ibmjVUg7pgUVe0UnMGayY89HIwKe0WSum8jD+Gi+ewr4S0vFHT
	EId6I2Hln9mB2KFfDQCc5vRb352CRCq2u3Bou7yXzHwCJNdDdeLBRvczKFMAfuG7pUd4RV4LtYK
	XN41gy1vBWCKZNHCKkr/Lup8JkUeVNWN8sMIN4i38WXwu4sXbJFaCPhZePM+9WmFsBGwY8NMJ22
	nl97BTLcvzvhTWA2+tQq6cEfvlwOCM6YbZjM8b0YjDCZxRXp74YY6OXx7Q7cgQWxFRenk9u+GSh
	5yMRDBvJCfdsF8/cAqepnpN/JflxM3p+b9ogJLaXGOfMsFiAahPUF1ee+ZWGO53DccSWhTyA7Gq
	CbE7WdQXB4FxgCaFf+1Kqzqsd5IaZ9mbmmWAeMWMurKzSK9YDN0B3uyF+omRveEPwgwGcxGM7j0
	JLfPbsL7qE/GsE6AdrXa0x8pIwZxX9TdBZ0B7eSLSLa1X9lJ/T4PBgU0eEJ6nXLrAwRyiik=
X-Received: by 2002:a17:90b:4a52:b0:3a8:6a6b:596d with SMTP id 98e67ed59e1d1-3b12d441cf4mr3066492a91.26.1794193286533;
        Sun, 08 Nov 2026 19:01:26 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1ba1:286a:1908:5381:2f2c:6143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm4920933a91.6.2026.11.08.19.01.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 19:01:25 -0800 (PST)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12] net: reduce ARFS flow updates by checking LLC affinity
Date: Mon,  9 Nov 2026 11:00:34 +0800
Message-ID: <20261109030042.2956-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
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

When an application migrates to a different CPU, RFS records the new
CPU in the global rps_sock_flow_table via rps_record_sock_flow().  On
the next packet of a flow, get_rps_cpu() notices the change and calls
set_rps_cpu() to update the per-queue flow entry.  With Accelerated
RFS (ARFS), set_rps_cpu() also invokes the driver's ndo_rx_flow_steer()
callback so that the NIC steers the flow to a queue close to the new
CPU.

Threads that migrate frequently trigger this on every migration.  For
drivers like mlx5, each steering call serialises on an internal lock
(arfs_lock), and under heavy load the contention on that lock can
outweigh the benefit of the steering update itself.

This patch introduces a cache-aware update strategy: the hardware
steering update is skipped when the flow's previous target CPU and the
new one share the same Last Level Cache (LLC), as cache locality for
the application is preserved either way. The per-queue flow bookkeeping
(rflow->cpu) is still updated, so RFS keeps steering packets to the CPU
the application is running on. A new sysctl, net.core.arfs_llc_affinity,
is added to toggle this feature (default: off).

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

[1] https://github.com/apache/brpc/
[2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v11 -> v12:
- drop the comment block above the LLC check, per Jakub Kicinski
- guard the arfs_llc_affinity declaration, definition and sysctl entry
  with CONFIG_RFS_ACCEL
- document the sysctl in Documentation/networking/scaling.rst, per Jakub Kicinski
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
 Documentation/networking/scaling.rst |  9 +++++++++
 include/net/rps.h                    |  4 ++++
 net/core/dev.c                       | 14 ++++++++++++--
 net/core/sysctl_net_core.c           |  9 +++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 6c9836000a8d..d85fe7a9e9bf 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -468,6 +468,15 @@ of CPU to queues is automatically deduced from the IRQ affinities
 configured for each receive queue by the driver, so no additional
 configuration should be necessary.
 
+When the flow's previous target CPU and the new target CPU share the
+last level cache (LLC), the hardware steering update can be skipped,
+since the application's cache locality is preserved either way. This
+reduces contention on driver-internal locks when application threads
+migrate frequently between CPUs sharing an LLC. The functionality
+remains disabled until explicitly enabled through::
+
+  /proc/sys/net/core/arfs_llc_affinity
+
 
 Suggested Configuration
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..ff2f490a4e9a 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -13,6 +13,10 @@
 extern struct static_key_false rps_needed;
 extern struct static_key_false rfs_needed;
 
+#ifdef CONFIG_RFS_ACCEL
+extern struct static_key_false arfs_llc_affinity;
+#endif
+
 /*
  * This structure holds an RPS map which can be of variable length.  The
  * map is an array of CPUs.
diff --git a/net/core/dev.c b/net/core/dev.c
index 3b60b15e2175..0011cec29640 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5217,6 +5217,10 @@ EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
 
+#ifdef CONFIG_RFS_ACCEL
+struct static_key_false arfs_llc_affinity __read_mostly;
+#endif
+
 static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
 	return hash_32(hash, rps_tag_to_log(tag_ptr));
@@ -5254,7 +5258,7 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash)
+	    struct rps_dev_flow *rflow, u16 old_cpu, u16 next_cpu, u32 hash)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -5273,6 +5277,12 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
 		    !(dev->features & NETIF_F_NTUPLE))
 			goto out;
+
+		if (static_branch_unlikely(&arfs_llc_affinity) &&
+		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
+		    cpus_share_cache(old_cpu, next_cpu))
+			goto out;
+
 		rxq_index = cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
 		if (rxq_index == skb_get_rx_queue(skb))
 			goto out;
@@ -5402,8 +5412,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
+			rflow = set_rps_cpu(dev, skb, rflow, tcpu, next_cpu, hash);
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 9226b96f2e89..64ae4c07f1b1 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -562,6 +562,15 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= rps_sock_flow_sysctl
 	},
+#ifdef CONFIG_RFS_ACCEL
+	{
+		.procname	= "arfs_llc_affinity",
+		.data		= &arfs_llc_affinity.key,
+		.maxlen		= sizeof(arfs_llc_affinity.key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key
+	},
+#endif
 #endif
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
-- 
2.52.0

