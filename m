Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713A19E96E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906843; cv=none; b=SkcrVp2UON8ly0cAA7LBnQn7bexaXHPLKQWYnwU/jIJljytVV2kjeYbH8qUJOGP/mIcheYIb8CDc2ayv7IcnKHfsjLts/77GFFBG73fnvxW/9xLvqceA/b4pwmj0vbowjPQUhjWjMaN6U6MPi1+/xj+5DbM2jvEbhULlGu6N0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906843; c=relaxed/simple;
	bh=2OIgWPFkq62kbTJzKTTe6VrV/odH0TUrHZFqe0kt9zg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I1brXZ38BvZbKf7mzBJrzAhdQmSPLNV+/ITQvsG4UwaVl7kNohfM96unseUih5V6FIten/IH4A1iolTSrYwqrzOod8TlvIPgkD5gwzY94DCc3IPHunklkp1F4rvKZ1dMge9YUnaWA/IxvcRDbPG1CI0oj6H/YMxbkVxgnWFqv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 594C67F0003D;
	Mon, 14 Oct 2024 19:53:49 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: netdev@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid
Date: Mon, 14 Oct 2024 19:53:21 +0800
Message-Id: <20241014115321.33234-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

pnetid of pi (not newly allocated pe) should be compared

Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for Ethernet devices")
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: change commit header as Gerd Bayer suggested
Sorry for not CC all maintainers, since this patch was rejected by netdev twice

 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 1dd3623..a04aa0e 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -753,7 +753,7 @@ static int smc_pnet_add_pnetid(struct net *net, u8 *pnetid)
 
 	write_lock(&sn->pnetids_ndev.lock);
 	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
-		if (smc_pnet_match(pnetid, pe->pnetid)) {
+		if (smc_pnet_match(pnetid, pi->pnetid)) {
 			refcount_inc(&pi->refcnt);
 			kfree(pe);
 			goto unlock;
-- 
2.9.4

