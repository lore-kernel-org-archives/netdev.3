Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7D3D3CF7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437837; cv=none; b=a7ED4DwGyqbRbYYiR2GgzgTJ3UR7zTzLElCS9vE0iiSNei+fiUbAC7Qj+/LwLbPBzUVMLgBgOYBWe+Rd5KRgTh+R7ldaVtEaAURx+f6e7Dr/Y1PuBn8C4G4VyZo5NWMw+gO34+gcku2Sm3DnYsa+mfskbsbfqxXJSTbQg1t/jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437837; c=relaxed/simple;
	bh=4KlU6IioCAwNk3jDxqQyOgDpHDc+AmeDeXmdSyc+iYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIoa7Uj/x25XR63cKbnHfwTSvP2JSyVlZwn4JWj8A/9A1qAvBB9crg61T0F3STNZ/bXwhrIErMVTh1AoWxdeG3uKFpedsvPQ1gvhM2LIqhXSBE+IJhEZt/NJjAJxjetfnQUmNu3SRnMNo+p4kTlLCWJbljGtflTVzJHzwhlIcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AXozjsoW; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AXozjsoW"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso2023416a34.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789437834; x=1790042634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/CaPcfjF5HqH3+aS6ruNpmYZeARPkCepH2Ne0CkwEFA=;
        b=AXozjsoWqy9neo+jCEGvb3bill5+DF9FUr2yVLJGa7+0kr+KvDCZFyiSeZ5Rb9Z8JB
         9IIM27xav14EzxUsYTwSLG3BYZ8+31FG+zkYwgradPE/8RSTZoD3noVSYnx5WoUjbLPH
         HOAfpNrP+Inn2bnBb84ckHlS5uRYMTpoMKdHHd/DIxVU4gMe5YXFYmbxA+PVZEztFHkt
         H8ef5cHIrEVo83Oe2Jeql/FBV/qLXjwsJLXgwxdE+L4I03f4TkPQPkoRJwX6BYQ8v0bh
         LmJTdJj6Vt/pPj/SAodfBro+7QrNkLDaIBq753jqcla2IQhiuulBx1Si4pj2huNmKgNH
         QiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437834; x=1790042634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/CaPcfjF5HqH3+aS6ruNpmYZeARPkCepH2Ne0CkwEFA=;
        b=xM1Mggt5tkrRhD22hNwBXqowZPwurlNtpWs2pvz+0hunhRCxZyR/As8jSymoTWkYbd
         EVI5q0t2IrP8WuUObqXyLETRSsiWb2TnW3b6wXp36pHarFBTDzhJYTsf5tcseQgLF6Z6
         4pUTxJ4GolfqglR9U9dRLgCPFkJXj1O6AxAM+kxuLDPUqdlqLKLr6Cq/NvmIuinR0An7
         hMUBneqI1VF6b4Y+l0mal/NxFdwrf3YXQ3ql+LxuUI7C2zVkdL4gSU+pqw2BDQYkcThN
         RkNw/TptNCQ+9By+3G8aKMa4a4ZPkDZmMDGhbhDxKf4v/n/WcC2unE1w+Vw+Xw2JmtRc
         XaJQ==
X-Gm-Message-State: AFuF++k1XHLdvjdPK4MBEf0FCEOvWjg7tXJWSzwTA/pCyUumwytFAAIL
	/DvQZrHD3+ot4dVeqO6s4n1ohPbbIq5+/QPj8KcfKsYu7SdUQO3ChEIv0dnIUXvDKTg=
X-Gm-Gg: AYBFou11bR0e66AuKxYs/NwpC8hJkxuiwDT2XlV9lSwLYevuWaTEoW7ndXaJMcKYQO2
	kQ07FwXYs8PCP41ZQ1OjaJRwW4VuLDigwYIiZ+EaK0NHUdVKxTd/QA554SXJef9VywxW+B6YU5l
	U/gkN8Vz8ppGzzlePRLi1FMCeDTWydkYS8S7cANXUUjOGsnSrIlq13EC3uTpaKhF1jwlReCkEUh
	BOKWe+1Xc5aHNeqX2Yi4M9x6QXE2aq0v2jMCURSSmjg9IhrsCGs7JtJjSak1EjU2UuT3kyyyGAy
	tMcUisPzntnAvCB7qyqIBzwxVj6ETdBrkcsNTM25bzfStnblQAFq+XFSsvBZpnNnoRVvmYJCQ1f
	fNfv+HNJ0STDsYoJFwkaj6jITW9oJA9iwMolDXvM321oTc15mASeJk7rJYru6int2hR3IRbxPSd
	gM+2yaOqgdLO0iR8MB0MKVOVWSBMVkpjkC3jUzQGrYnvFQMsOihHvZN/d9hgbTbbIRd9GkKCI=
X-Received: by 2002:a05:6830:8285:b0:806:1728:aed9 with SMTP id 46e09a7af769-8089759dffcmr5874003a34.5.1789437834177;
        Mon, 14 Sep 2026 19:03:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:2e46::49c:4c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-804de582afcsm10795696a34.16.2026.09.14.19.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:03:52 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Mon, 14 Sep 2026 21:03:35 -0500
Subject: [PATCH net-next v2 1/3] ipv4: hash uncached routes by device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-hash-bucket-route-lists-v2-1-29f6297d8a5a@cloudflare.com>
References: <20260914-hash-bucket-route-lists-v2-0-29f6297d8a5a@cloudflare.com>
In-Reply-To: <20260914-hash-bucket-route-lists-v2-0-29f6297d8a5a@cloudflare.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789437828; l=4312;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=4KlU6IioCAwNk3jDxqQyOgDpHDc+AmeDeXmdSyc+iYU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO7WoBzgXhIPhQvuy6eQZpcCD8KJdm3/hK/o2ENFnBRTFbGEk5OtQu7hB1DhZyQqI7qL7HYZVnS
 Zy/j/lz3suAo=
X-Developer-Key: i=carges@cloudflare.com; a=openssh;
 fpr=SHA256:Cun99EBiH0EV7wvmfTBF9eDrld2NJx+aD4ScWZ45Q5M

rt_flush_dev() currently walks every per-CPU uncached route list for each
device being removed. This repeatedly examines unrelated routes and makes
teardown increasingly expensive as the number of devices grows.

Replace each per-CPU list with a hash table keyed by the route's netdevice.
Keep the owning-list pointer in dst_entry so route removal remains
unchanged, while device teardown only walks the matching bucket on each
CPU. Hash collisions are filtered by the existing device comparison.

The table has 2^CONFIG_IP_UNCACHED_ROUTE_HASH_BITS buckets and defaults to
64. Larger values shorten each bucket, but every additional bit doubles the
per-CPU memory used by the table. The default costs approximately 1.5 KiB
per possible CPU on x86-64.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 net/ipv4/Kconfig | 13 +++++++++++++
 net/ipv4/route.c | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..7d40ca22d2b2 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -103,6 +103,19 @@ config IP_ROUTE_VERBOSE
 config IP_ROUTE_CLASSID
 	bool
 
+config IP_UNCACHED_ROUTE_HASH_BITS
+	int "IPv4 uncached route hash bits"
+	range 1 10
+	default 6
+	help
+	  This option sets the number of buckets used in the IPv4 uncached
+	  route hash table to 2^IP_UNCACHED_ROUTE_HASH_BITS buckets. The
+	  allowed values select between 2 and 1024 buckets. Larger values
+	  reduce collisions, but each additional bit doubles the per-CPU
+	  memory used by the table.
+
+	  If unsure, use the default of 6 bits (64 buckets).
+
 config IP_PNP
 	bool "IP: kernel level autoconfiguration"
 	help
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7da2f1acbb5..e28e2140cf62 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -74,6 +74,7 @@
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/inetdevice.h>
+#include <linux/hash.h>
 #include <linux/igmp.h>
 #include <linux/pkt_sched.h>
 #include <linux/mroute.h>
@@ -1552,11 +1553,21 @@ struct uncached_list {
 	struct list_head	head;
 };
 
-static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
+#define RT_UNCACHED_HASH_SIZE	BIT(CONFIG_IP_UNCACHED_ROUTE_HASH_BITS)
+
+struct uncached_table {
+	struct uncached_list buckets[RT_UNCACHED_HASH_SIZE];
+};
+
+static DEFINE_PER_CPU_ALIGNED(struct uncached_table, rt_uncached_table);
 
 void rt_add_uncached_list(struct rtable *rt)
 {
-	struct uncached_list *ul = raw_cpu_ptr(&rt_uncached_list);
+	struct uncached_table *table = raw_cpu_ptr(&rt_uncached_table);
+	struct uncached_list *ul;
+
+	ul = &table->buckets[hash_ptr(dst_dev(&rt->dst),
+				      CONFIG_IP_UNCACHED_ROUTE_HASH_BITS)];
 
 	rt->dst.rt_uncached_list = ul;
 
@@ -1588,14 +1599,19 @@ void rt_flush_dev(struct net_device *dev)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
+		struct uncached_table *table;
+		struct uncached_list *ul;
+
+		table = per_cpu_ptr(&rt_uncached_table, cpu);
+		ul = &table->buckets[hash_ptr(dev,
+					      CONFIG_IP_UNCACHED_ROUTE_HASH_BITS)];
 
 		if (list_empty(&ul->head))
 			continue;
 
 		spin_lock_bh(&ul->lock);
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
-			if (rt->dst.dev != dev)
+			if (dst_dev(&rt->dst) != dev)
 				continue;
 			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
 			netdev_ref_replace(dev, blackhole_netdev,
@@ -3771,10 +3787,16 @@ int __init ip_rt_init(void)
 	ip_tstamps = idents_hash + (ip_idents_mask + 1) * sizeof(*ip_idents);
 
 	for_each_possible_cpu(cpu) {
-		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
+		struct uncached_table *table;
+		int bucket;
+
+		table = per_cpu_ptr(&rt_uncached_table, cpu);
+		for (bucket = 0; bucket < RT_UNCACHED_HASH_SIZE; bucket++) {
+			struct uncached_list *ul = &table->buckets[bucket];
 
-		INIT_LIST_HEAD(&ul->head);
-		spin_lock_init(&ul->lock);
+			INIT_LIST_HEAD(&ul->head);
+			spin_lock_init(&ul->lock);
+		}
 	}
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	ip_rt_acct = __alloc_percpu(256 * sizeof(struct ip_rt_acct), __alignof__(struct ip_rt_acct));

-- 
2.43.0

