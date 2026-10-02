Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746D47CC71;
	Fri,  2 Oct 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935245; cv=none; b=IGJFH1CLFBQEUHaFZ42vKp/Mn04tI7PSYV6joOY+AX0uWEBzGkhpEo2GEJqJR3PJy9zrL22Hn6hY9pm1+cT/GjrOIzpeqHfI0DzrnOtWhU/91g45rqunrasi8O+a++TI0fakbmD7BKoP7v73BGFbNEs9uFdGWYBKkP5Zw3z0/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935245; c=relaxed/simple;
	bh=fovFvxFCsFots1UbJEW9CpYvUA8dHTEdAKixyNsbE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHOVxHfzhebEkl+Ja+hDBMT4Tifl3WK3CR33/K0zDJP2dQuqbN+5GbMV8RPO9EWM9LAymdv7gPWDDVLWqNSqsjAusgidzfwHQ4mZMZx7oFeHqQb1NEm4sZrRgcmZEs+vm1uxFcRRI1yWWZUza6Z5K58FHSTkz7gyzWJSAy6n95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is4cpZV8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is4cpZV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935244; x=1822471244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fovFvxFCsFots1UbJEW9CpYvUA8dHTEdAKixyNsbE+0=;
  b=is4cpZV8QwWzND6fRAQLUDtst8AGoa0umu6NWIwTG0oHVwqRxf6jfiY8
   vQg8kCPiHCtvvcDYG6cipyopL+FVEXoxNZYu4CvINvtVorZj7qxbRBRA7
   Up+CCVWMYYd/0QHKm8zxGv0TtWddM+Rd+fmi0tynvbdcVBeUlYt59SDGt
   arhCDPTG9pBAhflup2lmg6xZHfx/2XDMsZw5q8/OF/rS2nL/HC2Pu3C2Q
   ihO/mrkQoFLyB3Gn+fUskHsv+W7rb0pIGRwpGU/uhddpf7/1VFDEtQHRj
   ZYoKcmBISkcjpl2afxGoTuoGKT3IGrnYTvuebUdj/rTVDssk1i9CCtG4f
   A==;
X-CSE-ConnectionGUID: 9dzSFQ2wTwG8xxOrvrRgCw==
X-CSE-MsgGUID: Exh4cUkGRXSaL+3lF/qKSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113484685"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113484685"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:00:40 -0700
X-CSE-ConnectionGUID: gdxA7CNzTXiZg38gs9YUWg==
X-CSE-MsgGUID: TDzhRxy6QYK30U364Rr0jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279959893"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2026 03:00:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5005A9D; Fri, 02 Oct 2026 12:00:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 2/5] eea: Remove unneeded assignment
Date: Fri,  2 Oct 2026 11:59:20 +0200
Message-ID: <20261002100035.863275-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial err is not used anywhere, drop the unneeded assignment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
index f2284fc885c3..4876f8a1e686 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -266,7 +266,7 @@ int eea_create_adminq(struct eea_net *enet, u32 qid)
 	u32 db_size, q_size, num;
 	struct eea_ring *ering;
 	struct eea_aq *aq;
-	int err = -ENOMEM;
+	int err;
 
 	num = enet->edev->rx_num + enet->edev->tx_num;
 	aq = &enet->adminq;
@@ -347,11 +347,12 @@ static void qcfg_fill(struct eea_aq_create *qcfg, struct eea_ring *ering,
 
 int eea_adminq_create_q(struct eea_net *enet, u32 num, u32 flags)
 {
-	int i, db_size, q_size, err = -ENOMEM;
 	struct eea_net_cfg *cfg;
 	struct eea_ring *ering;
+	int i, db_size, q_size;
 	struct eea_aq *aq;
 	u32 reply_len;
+	int err;
 
 	cfg = &enet->cfg;
 	aq = &enet->adminq;
@@ -483,7 +484,7 @@ void eea_adminq_config_host_info(struct eea_net *enet)
 	struct device *dev = enet->edev->dma_dev;
 	struct eea_aq_host_info_cfg *cfg;
 	struct eea_aq_host_info_rep *rep;
-	int rc = -ENOMEM;
+	int rc;
 
 	cfg = kzalloc_obj(*cfg);
 	if (!cfg)
-- 
2.50.1

