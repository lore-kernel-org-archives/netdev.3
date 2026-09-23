Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DD5187E0;
	Wed, 23 Sep 2026 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165831; cv=none; b=EaWfi7c4vtb3PKPgTOZRXjP5RPKpiXpQ0ocGGqNu6eRIRrGa5ta9xZTH0m+AuwfnhnyBMY6rG0WZTma4BOymPjx7UrK8Bb1F/2YFTWh3ibKO9OQLIGZqU1GEIQ3rNvkRHaa8tQuV5ATGDCRj1cleAVe3ZwCeC0ABjuau3uxyZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165831; c=relaxed/simple;
	bh=ovsAtgEi6L1M2RO1lkZMwC93Fl5nrIiLA+OFFMvsVfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAbsr/Qkz4U5zQTDKF7+K2Yfa4don136cP0VSGcEzLNCJ1iOru+Kx4loFEszhmcG8XauINkGk60TuLPnGSPl3nYfZs9UFY9a4k3VHKslAzZG7pY4pc0sWpHXa+KDis1WG6LDiIFBlh50RTenDc7yXzm/OgM1+A9cpMJM4C1dvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=BbCi5bol; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="BbCi5bol"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C804A4AA6;
	Wed, 23 Sep 2026 14:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790165814; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GzLk9AHxyejvus2S9q+Bu2XrtqNIw34QVfpPbaQXNKk=;
	b=BbCi5bolnm1vv0bWnb5PcVrM7s6BCRFbAyuGz1B7f82rR1/k43IqmT/K4DBA6H6ts93zHH
	eRGO9LE6g3f4Cvz8GFh+0zvEk6qnkERAz9OYUaXewxZoNTo0yECV5soD2SH36ysfE2tsaN
	9cFAOLLgXoesfXlZbthi+eRzaajmU/p9EoxxpkKkhkaZRN5kXiU8tLIRnGPwiUMeevJiqG
	vh2fBX5AfAfpnOKum+sHb54uNGRUJ3XeDsQ/kM5N2AGY2g670l2nkCyElh2KAVeIC3uh5B
	4DCLKxS7Gh0+TIFK3F5Fu2BUSKWY71Ugz3ko8dl0CVp1L6yXb/z7Pq4uGrzCZg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: vadim.fedorenko@linux.dev,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: ethtool: don't match a hwtstamp provider on a device without a PHC
Date: Wed, 23 Sep 2026 14:16:42 +0200
Message-ID: <20260923121644.2194183-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923121644.2194183-1-nb@tipi-net.de>
References: <20260923121644.2194183-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

A device without a PHC reports phc_index -1. A request for index
0xFFFFFFFF is stored in an int and becomes -1 too, so the two match and
a netdev provider is selected on a device that has none.

Fix this and only match a real PHC index.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 net/ethtool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 23db40618fed..23e8282563cc 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -980,7 +980,7 @@ int ethtool_net_get_ts_info_by_phc(struct net_device *dev,
 	if (err)
 		return err;
 
-	if (info->phc_index == hwprov_desc->index &&
+	if (info->phc_index >= 0 && info->phc_index == hwprov_desc->index &&
 	    net_support_hwtstamp_qualifier(dev, hwprov_desc->qualifier))
 		return 0;
 
-- 
2.53.0

