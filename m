Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050E411685
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542916; cv=none; b=hIj7YFSLdQ629TOwf65GdSJqs18q6hQA7uQSg2G/e9jjXQZogb5iGFEHRyV0Dfh3eJ5bjstejRO4gy0FuBG0Pgi8f53SaMm1arXI0wuxwf4LeyvFtSQ6cLPrhBcmECcngk1WeFQjTOTDg7TuuqQnp0XVBf7BRJuJxBmHQo7MdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542916; c=relaxed/simple;
	bh=0J/oAEakk4BD9tvxfNCH+XPnSPAuOSaiT0DCGvBBdaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeTb4669anzasPQj8XxHo224+QLDZL5FuGSLY+yONYxlaRmBRpYXjN0+xiTdZqfbJD+5+/awcRpjOUIY5uib6GwzsJG7gDTAWB/0DNOS2w/OCUnhWoZfHXGJqFa5GBVYh/qlYmGGyMMj9p3ydg+XrCe82zEfZBF5tP2QODxuaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9AhH/+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9AhH/+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC561F00A3A;
	Mon, 15 Jun 2026 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542915;
	bh=sGtLmxPjMDZyguEmEeotgCNveyilaUDETbsaLZi5yP0=;
	h=From:To:Cc:Subject:Date;
	b=U9AhH/+SBMFQlhxSGcTtMQ2CVbfVKPv1eOlklWHfw7tMwLLVS7VtbWRoTPzanW9m7
	 H/4U4DAGz+o/mX1TYZB+Zv1UbmimaCxGEk9oekHrFO+AvdTzjB1uiS4fm49Qqxnl79
	 3eV0pYjq8G14ExaXXEd7X3jwubaeKljPmHq/ChtDx+vA66lkAo1yLyh0E70sc6FwTe
	 3qKNNognQ1PPJe7+15b/aUEbbnYf1V27fQdPysFZseJF4qkn0aruKpRxFA1GzEqtRo
	 93XI4dmLIRZlNgTxQMMG6BWM9Ct8OOftEcTAHYslmu6xIEp48vuFegBuOL0/2qPpyt
	 vGvpGSPhVDtXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	leitao@debian.org
Subject: [PATCH net-next] eth: ionic: delete the incorrect link_down_count reporting
Date: Mon, 15 Jun 2026 10:01:53 -0700
Message-ID: <20260615170153.592171-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of the statistic is quite clear,
struct ethtool_link_ext_stats says:

   This statistic counts when PHY _actually_ went down, or lost link.

Reportedly this is not how the device-counted stat on ionic behaves.
The goal is to detect flapping links, due to bad cabling.
ionic reportedly uses this for some firmware stat of how many times
the traffic was stopped. This is _not_ what should be reported here.

Link: https://lore.kernel.org/20260610061830.51037-1-eric.joyner@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: brett.creeley@amd.com
CC: eric.joyner@amd.com
CC: leitao@debian.org
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..f7dcfe3d032d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -111,15 +111,6 @@ static void ionic_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 	memcpy_fromio(p + offset, idev->dev_cmd_regs->words, size);
 }
 
-static void ionic_get_link_ext_stats(struct net_device *netdev,
-				     struct ethtool_link_ext_stats *stats)
-{
-	struct ionic_lif *lif = netdev_priv(netdev);
-
-	if (lif->ionic->pdev->is_physfn)
-		stats->link_down_events = lif->link_down_count;
-}
-
 static int ionic_get_link_ksettings(struct net_device *netdev,
 				    struct ethtool_link_ksettings *ks)
 {
@@ -1132,7 +1123,6 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_regs_len		= ionic_get_regs_len,
 	.get_regs		= ionic_get_regs,
 	.get_link		= ethtool_op_get_link,
-	.get_link_ext_stats	= ionic_get_link_ext_stats,
 	.get_link_ksettings	= ionic_get_link_ksettings,
 	.set_link_ksettings	= ionic_set_link_ksettings,
 	.get_coalesce		= ionic_get_coalesce,
-- 
2.54.0

