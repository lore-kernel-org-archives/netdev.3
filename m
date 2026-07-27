Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3C3EFFC6;
	Mon, 27 Jul 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145282; cv=none; b=R/0DgOg7MDK0CXZFWt5CbyW4YkZ47rOKDW3ZM3IwLQcWE0cTndEwjcxT5mYSF2rM51T0c57sq8B7tpz7WOgoTZt99Wl2vLr+XxazU88sfBMNUa+lSkWQBiD6dq6y5nPjS+iao1jEX2TbafNK8L8Pd5vBfK2mTtYyBpLmbjruLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145282; c=relaxed/simple;
	bh=QsU1Hl3KDTq2kPCdus7O9KPkLsBxoZKo06tRa8xywEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwgCICeQlhYXiV699FpkhVC7Mlf31kLlx6jRPpT7DDROGC7NsX9djVyJvRmgL5z2NW8zQ/0Y7qMmTXIrl1N5amxlCqim8nivrTbek5dRoVWZhfn8ZmKyQEoUWFJryNlRBFupfS/UNOE3c4OooRD2SlMkwPVUP5o43Um5/O5+mwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4e8d3050899f11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a521b600-eccc-4a26-8ed1-aac81545c42f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:7917a2cf90a553cd1e3dfb8a78cee128,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e8d3050899f11f1aa26b74ffac11d73-20260727
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1949693590; Mon, 27 Jul 2026 17:41:13 +0800
From: Minhong He <heminhong@kylinos.cn>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ap420073@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: [PATCH net] ipv6: mld: use ma_put() after canceling mca delayed work
Date: Mon, 27 Jul 2026 17:41:07 +0800
Message-Id: <20260727094107.168272-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cancel_delayed_work() succeeds, MLD drops the work reference with
refcount_dec(). Unlike ma_put(), that does not free the ifmcaddr6 when
the count reaches zero.

Use ma_put() on stop paths. On restart paths, re-arm the delayed work
before dropping the old reference, matching the ordering used for IPv4
IGMP timer updates.

Similar to commit 3546deaa0c30 ("ipv4: igmp: Fix potential memory leaks
in igmp_mod_timer() and igmp_stop_timer()").

Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv6/mcast.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index aaba4c2aae23..32b194c97236 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -76,6 +76,7 @@ static struct in6_addr mld2_all_mcr = MLD2_ALL_MCR_INIT;
 static void igmp6_join_group(struct ifmcaddr6 *ma);
 static void igmp6_leave_group(struct ifmcaddr6 *ma);
 static void mld_mca_work(struct work_struct *work);
+static void ma_put(struct ifmcaddr6 *mc);
 
 static void mld_ifc_event(struct inet6_dev *idev);
 static bool mld_in_v1_mode(const struct inet6_dev *idev);
@@ -724,7 +725,7 @@ static void igmp6_group_dropped(struct ifmcaddr6 *mc)
 		igmp6_leave_group(mc);
 
 	if (cancel_delayed_work(&mc->mca_work))
-		refcount_dec(&mc->mca_refcnt);
+		ma_put(mc);
 }
 
 /* deleted ifmcaddr6 manipulation */
@@ -1156,6 +1157,7 @@ static void mld_report_stop_work(struct inet6_dev *idev)
 static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 {
 	unsigned long delay = resptime;
+	bool put = false;
 
 	mc_assert_locked(ma->idev);
 
@@ -1165,7 +1167,7 @@ static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 		return;
 
 	if (cancel_delayed_work(&ma->mca_work)) {
-		refcount_dec(&ma->mca_refcnt);
+		put = true;
 		delay = ma->mca_work.timer.expires - jiffies;
 	}
 
@@ -1175,6 +1177,9 @@ static void igmp6_group_queried(struct ifmcaddr6 *ma, unsigned long resptime)
 	if (!mod_delayed_work(mld_wq, &ma->mca_work, delay))
 		refcount_inc(&ma->mca_refcnt);
 	WRITE_ONCE(ma->mca_flags, ma->mca_flags | MAF_TIMER_RUNNING);
+
+	if (put)
+		ma_put(ma);
 }
 
 /* mark EXCLUDE-mode sources */
@@ -1641,7 +1646,7 @@ static void __mld_report_work(struct sk_buff *skb)
 	for_each_mc_mclock(idev, ma) {
 		if (ipv6_addr_equal(&ma->mca_addr, &mld->mld_mca)) {
 			if (cancel_delayed_work(&ma->mca_work))
-				refcount_dec(&ma->mca_refcnt);
+				ma_put(ma);
 			WRITE_ONCE(ma->mca_flags,
 				   ma->mca_flags & ~(MAF_LAST_REPORTER |
 						     MAF_TIMER_RUNNING));
@@ -2622,6 +2627,7 @@ static void ip6_mc_clear_src(struct ifmcaddr6 *pmc)
 static void igmp6_join_group(struct ifmcaddr6 *ma)
 {
 	unsigned long delay;
+	bool put = false;
 
 	mc_assert_locked(ma->idev);
 
@@ -2633,7 +2639,7 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 	delay = get_random_u32_below(unsolicited_report_interval(ma->idev));
 
 	if (cancel_delayed_work(&ma->mca_work)) {
-		refcount_dec(&ma->mca_refcnt);
+		put = true;
 		delay = ma->mca_work.timer.expires - jiffies;
 	}
 
@@ -2641,6 +2647,9 @@ static void igmp6_join_group(struct ifmcaddr6 *ma)
 		refcount_inc(&ma->mca_refcnt);
 	WRITE_ONCE(ma->mca_flags, ma->mca_flags |
 		   MAF_TIMER_RUNNING | MAF_LAST_REPORTER);
+
+	if (put)
+		ma_put(ma);
 }
 
 static int ip6_mc_leave_src(struct sock *sk, struct ipv6_mc_socklist *iml,
-- 
2.25.1

