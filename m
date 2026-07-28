Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3513AFAE7;
	Tue, 28 Jul 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220156; cv=none; b=ePS0fEsMK9bC7n9ncZVX3RetNZrtDoSu28TuqL1xTG4mIMRBF4cB+89UaUSXF38nA3XH47cv7BrhP1CJjY/FwiepslvDVkZU6o/w3P+9rfRh+GOA+XW9DAbGr2gqP0MZR2oivjhYs5CN4f0xjruaWIjHaOMbsrStPqn9Ejh+8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220156; c=relaxed/simple;
	bh=8VVI3zu/IljiNrmKFcDO5Rs9cgIGakJMClOGhZzqyZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKBCzW4j03JSdhSfvjx+LEWEKo8yugr/lwWnph+HbE7e7DVh3U2o1izMkj9tTPu1B+yVGz3OpNswE5cFZrI8+zKTh459Ot0zoUcxDvSBLad7BWwt5Q2ZBkRKj8WlW3x8nh41Ep3ciWQ+YIlHURTM9P5Rj5LX5jwvKIIfDKVF7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=W9QV8dcv; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="W9QV8dcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1590; q=dns/txt;
  s=iport01; t=1785220154; x=1786429754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o8nLSGsR1/3zpU+mwlYc0ZXixuk2P7beClYxIA9xeTU=;
  b=W9QV8dcvYnnuRI2BqbLNrBlLtT0GSMHX3JNJ/UnsRvEM5bWjKV0M0Zdf
   5jgUiFus4UiDO4Oz/YmDJ+199O+VJtP5Uq/xpHzuj6bKYhrsMQXQGuwef
   SWDGlAQ1Vtwz6bwRZ3fuFwNcFMzbn2rbAS/lGz/U9CkWMP+pE+nmPHM8P
   o6jLE7KnQcz7ZtS1rt9Sko9CYAVLYGGoiZlHbzhBz5BfPylQP+zdgewAd
   B+nph+j3yKuVYEN4q+WGuyOLdasal9ejv754drqQTjraCBk/Sa2F3Wwa7
   /NYUIhvEkMkRwlkvsatXQ98snaeKywvy2HqhZaF4p2CAv+XjQMSMXafPS
   w==;
X-CSE-ConnectionGUID: jyHkesg8TBq7a/SQMFyedw==
X-CSE-MsgGUID: fGk17n3LQsCHdJObcsxPug==
X-IPAS-Result: =?us-ascii?q?A0A/AgAZH2hq/4z/Ja1aHgEBCxIMggULgleBUkNJlkqeH?=
 =?us-ascii?q?hSBag8BAQEPUQQBAYUFjWUCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZdKwsBRoE9ARKDAoJ1A8BSgXkzgQHeRYFmAQsUAYE4hXGHb?=
 =?us-ascii?q?oVxJxuBSUSEfoQpAYZeBIMukkJIgR4DWSwBVRMNCgsHBYEzMwMgCgsSEhgVA?=
 =?us-ascii?q?hQvDwQWMh1wDCcSLBeBDBsHBYEdfy1hhFgjGTl/gTF1SnctaQESF4EagzwCg?=
 =?us-ascii?q?hUDCxgNSBEsNwYOGQQ+bgeNdSKCLQkHDoEAFIEbgXICpSuhD4QngWafdRozq?=
 =?us-ascii?q?mwuh10Jj3l7I6Q3hGmBaDyBWTMaCBsVgyJTGQ+OLRbRJScyPQIHAgcOAwuRa?=
 =?us-ascii?q?ASBegEB?=
IronPort-Data: A9a23:vrreM68PMTobvwybEju4DrUDQH+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 TcYXT/TPfeDa2v8KNp3bd/k/BlQusSAx4NjTFBvrH9EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mvyyHjEAX9gWAsbThLs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k0LK0b9/14UV1k7
 KMRbws0Sz6Siu6plefTpulE3qzPLeHxN48Z/3UlxjbDALN+GtbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Un1lQ/UPrSmM+zj2X+aD1bqHqepLE85C7YywkZPL3FbYOIK4PaGJoI9qqej
 mzp/D2mBEo+Dce06Tan1Xinnf/3gCyuDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcATA0Y85zgrZs1gxbnUNluCui2g8fzFDW2x
 CqFxAA4iqkfgNAjyaq25xbEjiiqq5yPSRQ6jjg7RUq/5Q9/IYrgbIuy5B2DtrBLLZ2SSR+Ku
 31sd9Wi0d3ixKqlzESlKNjh1pnwjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:1Im2/axPPB2rPXFWHuyKKrPwGL1zdoMgy1knxilNoNJuHvBw8P
 re/sjzuiWbtN98YhsdcLO7Scq9qBHnlKKdiLN5VdyftWLd11dAQrsO0WKb+V3dMhy70PJB3q
 F9dKU7ItjxAV9myfve2mCDYrMdKB3tytHOuQ8YpE0dKT1XVw==
X-Talos-CUID: 9a23:xnNQsGMSzDJDUO5DWjhH90MPFZAZWGSCxTDrGmqWGGtlV+jA
X-Talos-MUID: 9a23:b4QXWwiS/BOM+vuqgP8HecMpOuhruvuoU2Q0ir4mt+ujPydrKw+Ag2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,189,1779148800"; 
   d="scan'208";a="515978575"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Jul 2026 06:28:04 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id F24C018000593;
	Tue, 28 Jul 2026 06:28:03 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net] enic: fix tx_hang_reset use-after-free on device removal
Date: Mon, 27 Jul 2026 23:26:30 -0700
Message-ID: <20260728062730.2394873-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-03.cisco.com

enic_remove() cancels the reset and change_mtu_work items but does not
cancel tx_hang_reset. A TX timeout that fires while the device is being
removed can schedule enic_tx_hang_reset() so that it runs after
free_netdev(), resulting in a use-after-free.

cancel_work_sync() alone is not sufficient here: the still-live watchdog
and notify paths can re-schedule these work items in the window between
the cancel and unregister_netdev(). Use disable_work_sync(), which
cancels the work and blocks any subsequent schedule_work() from
requeuing it, and apply it to the reset and change_mtu_work items as
well so the same requeue race is closed for all teardown work.

Fixes: 937317c7c109 ("enic: do hang reset only in case of tx timeout")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e839081f9ee4..3f384b481ff0 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2956,8 +2956,9 @@ static void enic_remove(struct pci_dev *pdev)
 	if (netdev) {
 		struct enic *enic = netdev_priv(netdev);
 
-		cancel_work_sync(&enic->reset);
-		cancel_work_sync(&enic->change_mtu_work);
+		disable_work_sync(&enic->reset);
+		disable_work_sync(&enic->tx_hang_reset);
+		disable_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
 		enic_dev_deinit(enic);
 		vnic_dev_close(enic->vdev);
-- 
2.43.0

