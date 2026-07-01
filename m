Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88319481FAD;
	Wed,  1 Jul 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909894; cv=none; b=DLKRErBSJm77JH+bi3DQF21gR8WYx+/hDHWG6iNtJgJ82dAeHFrCe8Nh5/3K2O29P0ZxCWfR4tm/G2oewHnhyceJlvIYhMDXyO+EDcx7LpqKutrMVRuKaA+WM1o4oSHZZwx22nrEvzzMYipaoG4ST1J4cap7ow8qPK+fxDuKYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909894; c=relaxed/simple;
	bh=Yr3lik8JzUo69MwblyRdg2QtwNYxJKp6ok3TZ7g+abQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMJaKmyId7gTWEJQpB/JlNqM7CaCNxSE6+Fhy0mnDDrPk9jLoRcRyeDGDtXnFHzfiJcgqFCFkC2SpUr96vZmDVQxbRIl1zAOCybeoH+MEWKnqM5fuuEAVZ/Pki29YieswM4lyYT+3kNc61UrToFqU3eYPJz3fY7yIrmUE24g930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=F9hqdLH2; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="F9hqdLH2"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 448185dde;
	Wed, 1 Jul 2026 20:39:30 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: pablo@netfilter.org,
	laforge@gnumonks.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Date: Wed,  1 Jul 2026 20:39:25 +0800
Message-Id: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f1db10d6403a1kunm755b42b019ca6d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQk5IVk4YQhgfTk8aSkgfGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=F9hqdLH2D2YW9qW4SNiPxmaIE/EPlWiVfD4Sssq/Jiry2EfD8ptvrCHPE6nCqWt16HCInKvi4xJ9QXZf/DiNQ/e5mMg0HCAQUW5vXnHcpd/lrUNXzNmdgy6xh03HxjzX0xeFSsdlQDvXVFv7wFGiI+YhugcBu4rPPnVAzX4cGwE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=BYssoUQdOZAvOiOsJT1JwJbdyewbrrCK1EtSJORyWoc=;
	h=date:mime-version:subject:message-id:from;

The GTP PDP lookup helpers are shared by RCU-protected data and report
paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
helpers walk RCU hlists, but they do not currently pass the RTNL
condition for the control-path lookups.

Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
RCU-reader callers remain valid because the RCU-list macros also accept
an active RCU read-side section; the added condition only documents the
non-RCU protection already used by RTNL control paths.

This was found by our static analysis tool and then manually reviewed
against the current tree. The dynamic triage evidence is a
target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
to documenting the existing protection contract.

This is a lockdep annotation cleanup. It does not change PDP lifetime or
hash updates.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/gtp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5cb59d72bc82..b94073c55f17 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -151,7 +151,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_rtnl_is_held()) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
@@ -168,7 +169,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_rtnl_is_held()) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
@@ -185,7 +187,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_rtnl_is_held()) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms.addr.s_addr == ms_addr)
 			return pdp;
@@ -220,7 +223,8 @@ static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
 
 	head = &gtp->addr_hash[ipv6_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_rtnl_is_held()) {
 		if (pdp->af == AF_INET6 &&
 		    ipv6_pdp_addr_equal(&pdp->ms.addr6, ms_addr))
 			return pdp;
-- 
2.34.1

