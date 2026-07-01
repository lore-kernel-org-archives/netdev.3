Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332303A8739
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939793; cv=none; b=bcNQEsAbfnGs/MGnNyf358JWEXLqCHH7eWydMrlLY88jyhFoONlkTzNmx/q6KMhUw1/MWW8BfUUP95+UrM0nMlPOBFZ+9M+RUNs+hOk74YNHL+lnzisSgr56IrO0yOIXC+oTx13dXQWZKxjHzZbdgcrTmt7I24bGfa+hBPvPS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939793; c=relaxed/simple;
	bh=YKi1Ytc5nn5iMhkn7ySgYfTkJdBOyJ082isRyb6GFuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuGi47e/YHakivYGCB/AvbmSIJe+f+wvUc+caUCOfSop9kD3jHbDpftEkx2i+FozlWfYyVsSEGU7eyXLBjfqWLrRY9Lu0EycWFv+QvAuayC223Pj3tvra4g36sRVlgQlFTxOWfjlGZ762/3C6tyiXW+4jNsB0ck4KJVqyd58Lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKP7H5Xw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKP7H5Xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939792; x=1814475792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKi1Ytc5nn5iMhkn7ySgYfTkJdBOyJ082isRyb6GFuY=;
  b=LKP7H5XwYWfuQL2lPsfphS8ZVTO7zgrGB+8R3saUVpL0i8cj2bXjhWab
   fRDLQO/OYwZtrFnp0CogQGylB7135ZkZSGhltg53xGLoIBtWiM/3a+qVD
   uDoI/wtHL9/o0Hy7KVqqew1mBrIOo6CRae4+c3ZFrczm03le5omMrCQSG
   n48HK+Tqo8MXEZRyxDJzflE0zM+GsjK8wTf2CDjugS3xElI6NkS/pq1o9
   HGIFAFyFAIypJAUFTm1WQCBlpAEuGEEFg8K+6Ou5iGE8OGapgxesy6Bq7
   5ga5tXCxlkrjPbDsSvw6pUgztrgsPj9008rPsHZIeuJKt/b5xc5bDO1B7
   w==;
X-CSE-ConnectionGUID: wtKCZDkoREynK8Xn0WCLpA==
X-CSE-MsgGUID: TzeJkehVQuyrNrrqxitRUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069095"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069095"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:10 -0700
X-CSE-ConnectionGUID: Ucg6y6++R2O3rK7mE9C2gg==
X-CSE-MsgGUID: szqycWZkRcycJdFWYrlV7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561399"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	kohei.enju@gmail.com,
	horms@kernel.org,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 03/11] igc: allow configuring RSS key via ethtool set_rxfh
Date: Wed,  1 Jul 2026 14:02:52 -0700
Message-ID: <20260701210303.1745310-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <kohei@enjuk.jp>

Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
RSSRK registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 +++++++++++---------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0e76ffe7be65..fbba3e84673a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1539,24 +1539,28 @@ static int igc_ethtool_set_rxfh(struct net_device *netdev,
 	int i;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	/* Verify user input. */
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
 
-	igc_write_rss_indir_tbl(adapter);
+		igc_write_rss_indir_tbl(adapter);
+	}
+
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igc_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.47.1

