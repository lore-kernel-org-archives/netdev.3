Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54B39901A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939792; cv=none; b=C0da6bxCCTREx0At4Fog9LrHDK2VrFSGSan9hHL9XolCoc0vdaEZPM289Bb9fyd27OIhueMieZEbrgt2OCh+UanCdc0Xov0UMrJeEnqe84+XoHfGtBhG42TLhkSB2W1AjLY6IyJq4BioOthJ7//b2GeByuX8J4YTYNy7DI6kXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939792; c=relaxed/simple;
	bh=QSgmcgD0TwlnZ3zOTrAKCwHywWHmRRKExdXm4KamcVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQnd3ca9RNdBkxVqWUOb6Gs2CWDOruRhOcwmE3j+jKtaa4sfR/8CqA9JjIan1i5FLeflVJszc61HYMOlt3yRNTkteIJYB2yBYOjfNlbovJggT38agROUsIA82EZzTkaoxbTJOfyTsX2zLIrHjkJbxQSoYUng6IS5061ZdwzUWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwJXHtwm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwJXHtwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939791; x=1814475791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QSgmcgD0TwlnZ3zOTrAKCwHywWHmRRKExdXm4KamcVY=;
  b=NwJXHtwm+15xbrzwJIEro5Tu00q1kQEMNreaz46mIg6vFKIU6F78TUUd
   6FGDBAfJwXw5hmbEchjgupEJtuyDChFA5m/vFPoSciV0v0C6pxFhVNb+V
   56T1MbFoCDgXUW8dLgNOFr6ny9tCkZOmOidOJGoKZjBbNoaXdH4xKO6Rb
   5xMXxaEjQnwjpYnVPgOaEq8OIkUsDdlUscmKTwKxbFBAfX2rtHMGTITtA
   FrmcKwcUUxAT2BNir5G7Abjwe7hOX/LRtaiv1YuZjOOk4V84HVNJ7vgDX
   QShGqWQEABWKGfj//8Qwpt27EiIqTgO84DVarFbiVlHTeWkLf9cRj+4nw
   Q==;
X-CSE-ConnectionGUID: XFfh9vlTTIaFF2jeGRsoMA==
X-CSE-MsgGUID: T+B4JraMQfCNK0/CwQ6EgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069086"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069086"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:10 -0700
X-CSE-ConnectionGUID: 5qlrCsfFQ/KM3pcCLqMpSg==
X-CSE-MsgGUID: noo5t7o0TAayNnPEnIxEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561395"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:09 -0700
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
	Avigail Dahan <avigailx.dahan@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 02/11] igc: expose RSS key via ethtool get_rxfh
Date: Wed,  1 Jul 2026 14:02:51 -0700
Message-ID: <20260701210303.1745310-3-anthony.l.nguyen@intel.com>
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

Implement igc_ethtool_get_rxfh_key_size() and extend
igc_ethtool_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f01222f12776..0e76ffe7be65 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1502,6 +1502,11 @@ void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
 	}
 }
 
+static u32 igc_ethtool_get_rxfh_key_size(struct net_device *netdev)
+{
+	return IGC_RSS_KEY_SIZE;
+}
+
 static u32 igc_ethtool_get_rxfh_indir_size(struct net_device *netdev)
 {
 	return IGC_RETA_SIZE;
@@ -1514,10 +1519,13 @@ static int igc_ethtool_get_rxfh(struct net_device *netdev,
 	int i;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (!rxfh->indir)
-		return 0;
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->indir)
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->key)
+		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter->rss_key));
 
 	return 0;
 }
@@ -2195,6 +2203,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_rxnfc		= igc_ethtool_get_rxnfc,
 	.set_rxnfc		= igc_ethtool_set_rxnfc,
 	.get_rx_ring_count	= igc_ethtool_get_rx_ring_count,
+	.get_rxfh_key_size	= igc_ethtool_get_rxfh_key_size,
 	.get_rxfh_indir_size	= igc_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= igc_ethtool_get_rxfh,
 	.set_rxfh		= igc_ethtool_set_rxfh,
-- 
2.47.1

