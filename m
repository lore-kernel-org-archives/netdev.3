Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0B3A9627
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725830; cv=none; b=ti1WS2bHdWyLzDsBo2R7IJtaHrqa40sTE1lxUEA+gOLPGIFzfmW6J1b6+4bTcsgrlerMJ2t3n9z3ZBCi2xZ1rRWY/QNyBLa/4tMmi60Y6qmftCFL90iw2+R3SqaGEd+LGZIHgvLL66Y9rKkOpI72uQl3TuThHLgUSeDr56JuDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725830; c=relaxed/simple;
	bh=88cwRlOGDn0vpOQmUYNZUGYEdRzAeKkeMTlTyzUNsZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmGGCpkTKOpSKkwaGAZXVkiJDpYmJzNDFrLaFIXIaPLuSj6HqIYawMKOjYx19EfvfTI/LNn/SxmGszPj/u5YDpvyUyeUoKdao6mCUTdl6bcGp5CDqMUfiGCy9pgQsj6cbVfyRmqn47ONdRA9qEmaah5uut5SmENVOnngpyhqrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBXkCEJ6; arc=none smtp.client-ip=74.125.230.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBXkCEJ6"
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-39c689d1d48so2777371fa.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 23:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787725823; x=1788330623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ltu0ibAXLu3xOE6Vns9ZIohMj7npj3m+gIbL5j+64fw=;
        b=ZBXkCEJ6FKvXL7u4d6F3MzhYY5B8APtuSxPxw6roiPKBN98gRySghXrg5VOjElkJPu
         n6NbFttPRob3PV+Kz91j+KHJGE3enb1ET+mJppySypsWQFM3dPBGtXAyLzN41BVWXqRV
         qwl7OI3iarYV+8+71/Lir/z8EJPrD6ltwtMvM1dU6Fl/pYaO5zKrQ1zbwOc7SDcCbf95
         lARn/BeHdFajJNIzbW3jSjoh+IjWRaqPHkE84wuIykbgKCoLg8G81bgJihcz3h7S+vRy
         Hkcv4fjEgcTCiVmYZ0D18KlKBUUyy8pddKQ7xVm32ts21l8tMSuryoymwon7pkapzjcL
         6gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787725823; x=1788330623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ltu0ibAXLu3xOE6Vns9ZIohMj7npj3m+gIbL5j+64fw=;
        b=C0UG0QbuIArY0ksGokXJf2KAPmIrpgKrEvDDgCyKW8bK7FlceOy+aVXeI3mOpGaB8H
         sobiC0m0Pg3/OgH6EctMJaeEsvoC6V/w8xiTV32lVViaCx36JHBO+cCk7hfABXyeXT6Q
         s0QMDtyM030ZSZNQZYrrpPASUiJ69SoGrXyljZwbjiUCgqxi32p10Ln68MR6Av7bv9IO
         8ppye46CRWNW1p8lctSTrLAQrXdMzlSN8hsaIi1pzvKuedfPieoSJtPudSVfVD0zxPNz
         RuGodg4WRZtY0HRHNzGwPnUnNoIkNhfzuLgezzNQ8sU8bESB5ViG4WqxTb1qd/wbxn7S
         QdKw==
X-Forwarded-Encrypted: i=1; AHgh+RoaXI/IBd2dg5RAx5brCZwYiS1MSAePQ1gXBqzdvAB3nYhrKrOD3twhWu+NynbdpS9KZ7AP+Ng=@vger.kernel.org
X-Gm-Message-State: AFuF++nM99mrMsF6v4OiBv/MnNfoliraRgm6jI07UMxnHwtj+2fFAkXb
	i07EKw7iYfSwJiXWSb2nNE8J4Se5LScUjmMm03IIa0vitaWg/Pn63xPn
X-Gm-Gg: AR+sD1265qTK1EMzFadhxiPXPY2c3JXoRn8XchHVu8xpGqfk1NXLhPMkNkmLn2asR61
	vRA9O2uzEGF15VQu6ZS6OAgkMddLvPK2Vv64DGXTfafsbQT/dx8g9GuR+hw6hPV773G2ddQ+b/6
	SjtGhrxqHjuTcKZsFdkPjFlemEklxnGzpDzPrLQWL/NlLXDgru1RWBbFK3+aTbha/xIWG2D8Tyx
	lfYPREAFZrAT0QqfOw4z+oyYoJIkkmr1x0BzEi7J2FXTUB8AyvuPrm/ltrRVjfQBgZJJjgJCiSj
	I2c4hoc/0ChuHuXJ1BySMb2K265HtbZDuBPF2+7nIRAkpcLvUuNlh+3TdWlisk9/iXZvbUkdtSX
	y1+UpQIuXDG6ko8cM/ooHRMq7DDYRX9tio9tuTTgQsyh/ZwLyFGnZNgECbZ5wHRqqn+i4qTO36Q
	O3PYe6vHDWZ2S2USQCLgEoWCdfooqwliybt+YbWnPpoWfB+0jOlJ8Afvq8LJLR0lnbfrSNk8n9V
	IXrLg==
X-Received: by 2002:a05:651c:a38a:20b0:3a1:a0fe:990a with SMTP id 38308e7fff4ca-3a1fd63423emr6446281fa.10.1787725822342;
        Tue, 25 Aug 2026 23:30:22 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a1fd0eb0d7sm3336591fa.24.2026.08.25.23.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:30:21 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Arnaldo Carvalho de Melo <acme@mandriva.com>,
	Yan Zheng <yanzheng@21cn.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Leo Lin <leo@depthfirst.com>,
	David Ahern <dahern@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10] ipv6: mcast: Fix use-after-free when processing MLD queries
Date: Wed, 26 Aug 2026 09:29:38 +0300
Message-ID: <20260826062942.5272-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

commit 791c91dc7a9dfb2457d5e29b8216a6484b9c4b40 upstream.

When processing an MLD query, a pointer to the multicast group address
is retrieved when initially parsing the packet. This pointer is later
dereferenced without being reloaded despite the fact that the skb header
might have been reallocated following the pskb_may_pull() calls, leading
to a use-after-free [1].

Fix by copying the multicast group address when the packet is initially
parsed.

[1]
BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:1512)
Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118

Workqueue: mld mld_query_work
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_address_description.constprop.0 (mm/kasan/report.c:378)
print_report (mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
__mld_query_work (net/ipv6/mcast.c:1512)
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
</TASK>

[...]

Freed by task 118:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
pskb_expand_head (net/core/skbuff.c:2335)
__pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
__mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multicast")
Reported-by: Leo Lin <leo@depthfirst.com>
Reviewed-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260603101811.612594-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53275

 net/ipv6/mcast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index e15c3e2318d7..c4a9866ea45b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1414,9 +1414,9 @@ void igmp6_event_query(struct sk_buff *skb)
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1448,8 +1448,8 @@ static void __mld_query_work(struct sk_buff *skb)
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1501,7 +1501,7 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */
-- 
2.53.0

