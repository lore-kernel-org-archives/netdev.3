Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574624;
	b=lpwIEcwptaF750KsOISDOTjWwByKJG1u/l8T0eO2sxPAZK8HEvxqkcSG9kaaPg3mRZdu
	 JeK7NbBKkmjmSJOgV8qcXeN0T7d1jRUSVoUh2RbFXcsS44vAbkyFSufjbB7jb2A1TPVaA
	 kaG32k3QVpAuKrAmCFyrRdTefaFdFSzACze7iO5O5LOJB+HSh1Gy2aV0Eie/f25S8qx4y
	 HHHXqmQCCTWGHMYycUfVIilssam1fFNwODo5OwIcRNWZUG6WtIqLeoeAzJChKEHbwD2Sf
	 FBfFbtiDWQZ4otrNUVQ+T5w9ZahfIMF7Yhhv/SP5OZEroPjZHsy0vvqnI4t1ESUIwjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UFW11CE2+fUhenv8lk9VuUbA+Kdqs1KCmSCPY5Hz71g=;
	b=tgS9LwNUxJa6XdX89XforEwJzpvdkZw2SITUdwme/bvO4BlVVCtq7rRKNIpIf5wNMB+K
	 RS/ILmiCDQO9TuXL1B7m6Vr6qnOyoyvB6VTr7LvjAPQc3lgYJ88sts3LloQIbPmQ79en+
	 jIFPbPLOXUFAis7a3TsQHh7N4hXyc3yzte9mAGMV9WMWTmAX4IpJOJaOyQC991NjHLQKT
	 083xRfTWu1ZpGAY2P5Wd3bsWd11tOPkld+77jJ4b77Kenphd+rS1+398+R8gL6+pSDALg
	 h0d3oVvZe0dGWPng5Sf9+9dQ38XNJk0uZgFvk/TJfIu4N8u0tBnhlxgNjI+B5qlCkzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nk9UrQAA;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D415606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D415606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nk9UrQAA
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso5184095ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574623; x=1795179423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UFW11CE2+fUhenv8lk9VuUbA+Kdqs1KCmSCPY5Hz71g=;
        b=Nk9UrQAAeFLsnTKMzVvAeSI0D9fVT5PKtZAKDEqUF+zGFyKb3SmRKoso44dE3HHAgU
         vD5sB4msnfLkk6JeMGxTnp+lWRHZJ9oSlmRayqqSihctqh8rHZ0d9gHQLHCNgsA3+s7Y
         PBKq5OY75McV+r+FJyKs91BW0gVEmraTuk3H5Om25ORN0woMdtxU3ZPEHzfDPSW84hlU
         y/dSGTLU8yPSxYzXnvLLa0tOvgqGdyW43TLQnMVhwCdAs/UCbXAtdjntoDRIWQn6S/lS
         +kupnnOI/PrEANESBoe3CQBxok3RcLkGdUV6DlVi2lV7TwhaPcgObjih1Y0axbDNUNHk
         gLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574623; x=1795179423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFW11CE2+fUhenv8lk9VuUbA+Kdqs1KCmSCPY5Hz71g=;
        b=DKKmNVX64zzXbZtWICaAAOUI7xn/yoWA4d8gLuwVWWeZ1+haHYDNRzaQ3ap/nO8Lts
         aJtX8YAXy7WPoB0tycqrnLeSVBUif+EtaG4RaSRog2CloP9/s8zM5lVK3ptY0WLwS73F
         LDT/Vg9UtclgpqjHTYoQGq2McbhyKJGMRTIKnwFnAWfwJXgddo/MZfawvCQtOW0tLkK+
         SOxlgT7WRPOr6cgtGjibwBJ9K2TVCvqJ0f/4wLoBMwM1Nk+oxO3q79J2p9PcxFED34BZ
         0Xg1n0ep44qGs6/hvDDfAC0t3MMKa7R4fFkuGCiHVGdoY9h9JZmnCif9bpLuVJTce7r5
         uYKw==
X-Forwarded-Encrypted: i=1; AL+hErEGv2Tz9YF9GdL6UIyfeyZtecsVnNJjZZ8i3WtdZI3VtDjv8MH7BLh+hd1/jIXdfslKlnn79pY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8em3dN2SWowHVW7g+R5aeeMNqyQASsTy1BNbq26VgyQP2848tU
	gD5+GP83QJFsTWCaBBOLgAIQWBwPFqzxlIyqboEADDf7SH7/TyQQd2Tt
X-Gm-Gg: AYBFou1MsW4PwNcBN1xmGwyOocPB3QXGVL4d0ENtsQnf/C86YYODfskRX2LuwFCLhGU
	eQwAmuS3Oaf9o8199tJHE5EKjssGWGxxmx9pmzDQy12S+a9A5T8x8y3HeqREuLdGG4SCkHpnDnS
	eMXvTEJRIudOdoXc3NwBqZjtLRLRrmRrLJEwwmMmxcsW6sL0VudjJnsQmv1Viyf/c+jgUXZfntP
	HAhyjE02xNHW3u9HMWKoft74mzCgDPBcACw8PCH3sciHaBCNXKw6vzK+FtjqVqW6ypyDrDSyRbS
	PqM4KcOsSkSHxCDN6J7QBec1NT7s1JuBVNS6O2MENujXtmbrmJD1pmZC8gvssqSiBxYfPeSublU
	WTKsJWwBZluXTWgc63QH2DM8VuG54IqhvciQapNXtYsKL9eoLsgKaieZS+86zpMml9xsHhsq9uO
	hTSutTeS0Zkd7QGTssYG6VfFiCKfa7XFQkPA7BpS8SeLXL2rX1iHLSGunbEMXZ9LdAKbNOa4CHe
	BYprFPVKDJOnpkZfhht5g/lotcs7fOo7AlbJQ7JFChEhw8aMqCmRBzgbIUhIh9wqlHM6R2WybRZ
	uKgfugjBbUszZHQxFSHmYTkWBG0qL59yN1X2Nn01aVkszD2c4dkAtjA=
X-Received: by 2002:a17:903:1844:b0:2ed:2104:9a6f with SMTP id d9443c01a7336-2ee0dac323cmr24731165ad.22.1794574623291;
        Fri, 13 Nov 2026 04:57:03 -0800 (PST)
Received: from localhost.localdomain ([223.167.122.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f4acd77sm9593215ad.3.2026.11.13.04.56.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 04:57:02 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v13] net: reduce ARFS flow updates by checking LLC affinity
Date: Fri, 13 Nov 2026 20:56:34 +0800
Message-ID: <20261113125643.2255-1-nashuiliang@gmail.com>
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
v13 -> v12:
- add rflow->filter != RPS_NO_FILTER check in set_rps_cpu, per Simon Horman
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
 net/core/dev.c                       | 15 +++++++++++++--
 net/core/sysctl_net_core.c           |  9 +++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

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
index 3b60b15e2175..6d3dd2d9ae82 100644
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
@@ -5273,6 +5277,13 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
 		    !(dev->features & NETIF_F_NTUPLE))
 			goto out;
+
+		if (static_branch_unlikely(&arfs_llc_affinity) &&
+		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
+		    cpus_share_cache(old_cpu, next_cpu) &&
+		    READ_ONCE(rflow->filter) != RPS_NO_FILTER)
+			goto out;
+
 		rxq_index = cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
 		if (rxq_index == skb_get_rx_queue(skb))
 			goto out;
@@ -5402,8 +5413,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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
2.47.3

