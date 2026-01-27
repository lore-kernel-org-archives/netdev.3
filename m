Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9832BE65F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504302; cv=none; b=ptXo4Nr83Q+VMSrJknILwCGMX/aKgRv8Uo+192L2o0Qdm5UZbpP9QpgGqKTbGYphGCKnhPSBV2j4Og4/8vwSy6YRsvsXGonN30ugtOlUp8gg8As3G/dfRZj70p3jBEhNLz6GJ2SN1SW50qxy5L1FCcpU9u5ERmWXioHpP0JMDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504302; c=relaxed/simple;
	bh=uy0R3ruCI/qIqTm5UziPDABY7MS7MCPyOPk1CAcGHZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGbyy/0ojSyO1oROq/HY2UrKMK9KSDeLFg0p91NF0hQwTlK5p58wz0q/QlcvmzMHSWdWgV9fWG+o+wtjaGwxmS6Rkkck2lX0HO7Thgu4PqcKC9p3x4C0ceX9NanZcvHB02+G/BXY3PL2bfIrXd9b9dvp+YTGYFN+SQrmpfhDmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LjXrrlep; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LjXrrlep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769504300; x=1801040300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uX/5mrMkeTkN9LjvZeBrGkA31EqPLswoMX6OI/4YseM=;
  b=LjXrrleptJQ0bx9Ci85PxQRXjkOfygbQYI84vGQWr/jIGUD+i7+AXBAq
   a50/xEEgDarwp7T87G4PFIuQVbYHBRfhzbi/Y79o8kNUcVUo9TDXAxXG5
   Roq/zlV5IaJGc/jdd2heldBHEIOmIHbrkqqPdqiQJzkSxwoe/e1DRwVOy
   qhPrtkN4Q+S028BYE6ro01Vq65iRV1It1niJow8yiw5GO9tZ+qu8QF3y4
   26fc+eZCHSsGwwn8n39kBoLfIVlkwTw8iL5w1T29IrNJopOovsu6IK9xx
   cBQH8CrL34FGhuaRNpS0123Ui87Qh2J68ShsFH3rWZ5RjT/UD6HcptRmc
   A==;
X-CSE-ConnectionGUID: Yuatk1bvSKOSx5SsuqALRg==
X-CSE-MsgGUID: +JWy8BhZQ7+lBNDztTlZiw==
X-IronPort-AV: E=Sophos;i="6.21,256,1763424000"; 
   d="scan'208";a="11489358"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:58:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:9193]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.66:2525] with esmtp (Farcaster)
 id 14b8c192-8f08-4013-8f10-c3ddba579f9f; Tue, 27 Jan 2026 08:58:17 +0000 (UTC)
X-Farcaster-Flow-ID: 14b8c192-8f08-4013-8f10-c3ddba579f9f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 08:58:17 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 08:58:15 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
	Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v5 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Tue, 27 Jan 2026 17:54:10 +0900
Message-ID: <20260127085410.79645-8-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260127085410.79645-5-takkozu@amazon.com>
References: <20260127085410.79645-5-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Change igc_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
E1000 registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 48 +++++++++++---------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b387121f0ea7..b4eef14c09d5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3357,35 +3357,39 @@ static int igb_set_rxfh(struct net_device *netdev,
 	u32 num_queues;
 
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
 
-	switch (hw->mac.type) {
-	case e1000_82576:
-		/* 82576 supports 2 RSS queues for SR-IOV */
-		if (adapter->vfs_allocated_count)
-			num_queues = 2;
-		break;
-	default:
-		break;
-	}
+		switch (hw->mac.type) {
+		case e1000_82576:
+			/* 82576 supports 2 RSS queues for SR-IOV */
+			if (adapter->vfs_allocated_count)
+				num_queues = 2;
+			break;
+		default:
+			break;
+		}
 
-	/* Verify user input. */
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
 
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
+
+		igb_write_rss_indir_tbl(adapter);
+	}
 
-	igb_write_rss_indir_tbl(adapter);
+	if (rxfh->key) {
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igb_write_rss_key(adapter);
+	}
 
 	return 0;
 }
-- 
2.52.0

