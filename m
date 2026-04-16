Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130E257844;
	Thu, 16 Apr 2026 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305920; cv=none; b=J+p8svubizyg46Jd9kgdaDip3cvh0Zq9C6O8gL+K2vZYsrtgx/p9rrG1lzhfqrhIx6OzDBOKfyuD0AgSdwLAOftdjByR9Yt+9RCyrTRB6ZlkQh8iy7bxmJ1T4qCiRYs2+nZNtNjVYFAe1rz4e5KnKFSFJQIf9bhjiVaZ9oFizfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305920; c=relaxed/simple;
	bh=gLZdUWehz2CnGY9z/fhytGrTHfZiwQXVAh5sMsRRzkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSjV9BmUTT4XJkLAZWLJzXADRes+konQkMVP9MkeyW2oOm20qtF3gQCqdIMPEdpgk1Zh3LWBkYXrB670K51rKZ2utnl1h+ZnwTr7dy/fOEY5wGI1zKlGOM1dmAPThzvhOoY/lOdWbKN0oCqMfJ22vzVSre/QF5gv0v72QQufNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUQGTePE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUQGTePE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776305916; x=1807841916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLZdUWehz2CnGY9z/fhytGrTHfZiwQXVAh5sMsRRzkE=;
  b=YUQGTePEIxqZU9CienjUdPgVIgGKr2JD/eSEvcn9ehDhSeSQ/2qSIQOm
   K1jlsIztgW1OLdssFyz9+RZxoe7oHAmel+GV2UgLq/wQ5Pkqh+wDoFmy3
   fmlgxGm7phO5OQ/wzY4N8woB0vwF92RPPxlYI77QqJPBS2kP7fSqfz2pv
   Zo+m3a5srDt/OL2nsdljzUeFVANgMkwt7d4RHhznMoafO2AR3UN0KgIUV
   dcu9pi/khY5TQvEkRnGInEGSciwKDL7tuNxtxp1Y9acK+jXN/ea+a3g/c
   tqHr7UHRfcDOo9ZpVLoRSG11bC14Qva/h6cJmdRdlQ2rhgkuXcubEpALm
   A==;
X-CSE-ConnectionGUID: oUi8wWcsSVCzkGUTBF3Hrw==
X-CSE-MsgGUID: 9mdWmS7YRBOLWYrwtVsunQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81168800"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81168800"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 19:18:36 -0700
X-CSE-ConnectionGUID: CvtgE75lStGQS2UNjJ1dAQ==
X-CSE-MsgGUID: xjIpfms5R4ulvO2oqIEPQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227442200"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 19:18:33 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Looi,
	KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-next v2 2/3] igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
Date: Thu, 16 Apr 2026 09:55:19 +0800
Message-ID: <20260416015520.6090-3-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
References: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Move the advertised link modes and flow control configuration from
igc_ethtool_set_link_ksettings() into igc_handle_autoneg_enabled().

No functional change.

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 72 ++++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0122009bedd0..cfcbf2fdad6e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -2000,6 +2000,49 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }

+/**
+ * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
+ * @adapter: private driver structure
+ * @cmd: ethtool link ksettings from user
+ *
+ * Records advertised speeds and flow control settings when autoneg
+ * is enabled.
+ */
+static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
+				       const struct ethtool_link_ksettings *cmd)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u16 advertised = 0;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  2500baseT_Full))
+		advertised |= ADVERTISE_2500_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  1000baseT_Full))
+		advertised |= ADVERTISE_1000_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Full))
+		advertised |= ADVERTISE_100_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Half))
+		advertised |= ADVERTISE_100_HALF;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Full))
+		advertised |= ADVERTISE_10_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Half))
+		advertised |= ADVERTISE_10_HALF;
+
+	hw->phy.autoneg_advertised = advertised;
+	if (adapter->fc_autoneg)
+		hw->fc.requested_mode = igc_fc_default;
+}
+
 static int
 igc_ethtool_set_link_ksettings(struct net_device *netdev,
 			       const struct ethtool_link_ksettings *cmd)
@@ -2007,7 +2050,6 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
-	u16 advertised = 0;

 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -2032,34 +2074,8 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);

-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  2500baseT_Full))
-		advertised |= ADVERTISE_2500_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  1000baseT_Full))
-		advertised |= ADVERTISE_1000_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Full))
-		advertised |= ADVERTISE_100_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Half))
-		advertised |= ADVERTISE_100_HALF;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Full))
-		advertised |= ADVERTISE_10_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Half))
-		advertised |= ADVERTISE_10_HALF;
-
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->phy.autoneg_advertised = advertised;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = igc_fc_default;
+		igc_handle_autoneg_enabled(adapter, cmd);
 	} else {
 		netdev_info(dev, "Force mode currently not supported\n");
 	}
--
2.43.0

