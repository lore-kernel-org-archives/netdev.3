Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F333A9E2
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939793; cv=none; b=T4g2RLZKpgVT41xf7u8JDN2eN4LxOxm9omF3lAOaEur9i/oxIcC6NBkxk24axGgBdddrrX+8YiMFStA/yxrGUFLS49wyaj5CDRAjPlenlRCMSc8TkrCpNfzEwXOG2YlgszYYd0LwEa5KWV4vYdNvlhkIGpnboY+bbGw9dEHLPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939793; c=relaxed/simple;
	bh=SQqFVOzuXUCbL1gov3F0GqYQC/GrGCj28QjkeFELkIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzgAcuc+U6MCPqpLGHlUgx3NvLdNIBZDWGuUBv5beOxGwQV7eTpOnmyMd7hK2fMRHd/1sSwrXh9ZU/BaOsD8NlD1SgQ2A7KJIdLweMGV+DSPpmTd5h8A7sbbcRzEMUFAnPH8yaaNuBLZEIzKXqf3fqwmxe8lRpavEuGTW6XX2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdPsrfNU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdPsrfNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939791; x=1814475791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQqFVOzuXUCbL1gov3F0GqYQC/GrGCj28QjkeFELkIg=;
  b=VdPsrfNUtlmrZBd+XXzo27R+lKBF5mqBlk6D/j+1W4Yyu0QofR55UZUg
   rczb5bMPTHWp4VCHEYY1BoSPWx3Bv4n2Td3jfJH+H+UkLqhjfhDNPyEgn
   smoGUH4aUrZSsN3Iu4dz5Rqr80JaBtaD7mNWurUToaXsC5D6blakOtw2I
   n2r42UvWpBkh/teu3q5eYbNK23Q3ifizUsKLrAykVfAdSe20XS88+PrEw
   J/MvP/ia+sNq/YHCEHNw/eVJL997mzSa3Hv2wmwyaP6nKAXvD21axKnp2
   5Wmx0gUHXaJPKjNA/Nj2yKG9KvHL1ygDKtC4lfQHN6kHCjlE0JR2udJFS
   w==;
X-CSE-ConnectionGUID: 2OgHQ134TeOa9tshXegAMA==
X-CSE-MsgGUID: Kx09sTMIQYmBFrO74w4BcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069076"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069076"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:09 -0700
X-CSE-ConnectionGUID: xmz42nBwSFCRoFVNjzanaA==
X-CSE-MsgGUID: WZYrJ2Q7RJuNiGILkTaQeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561391"
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 01/11] igc: prepare for RSS key get/set support
Date: Wed,  1 Jul 2026 14:02:50 -0700
Message-ID: <20260701210303.1745310-2-anthony.l.nguyen@intel.com>
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

Store the RSS key inside struct igc_adapter and introduce the
igc_write_rss_key() helper function. This allows the driver to program
the RSSRK registers using a persistent RSS key, instead of using a
stack-local buffer in igc_setup_mrqc().

This is a preparation patch for adding RSS key get/set support in
subsequent changes, and no functional change is intended in this patch.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  3 +++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  8 ++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 46d625b15f44..17f213cc93e4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -30,6 +30,7 @@ void igc_ethtool_set_ops(struct net_device *);
 
 #define MAX_ETYPE_FILTER		8
 #define IGC_RETA_SIZE			128
+#define IGC_RSS_KEY_SIZE		40
 
 /* SDP support */
 #define IGC_N_EXTTS	2
@@ -302,6 +303,7 @@ struct igc_adapter {
 	unsigned int nfc_rule_count;
 
 	u8 rss_indir_tbl[IGC_RETA_SIZE];
+	u8 rss_key[IGC_RSS_KEY_SIZE];
 
 	unsigned long link_check_timeout;
 	struct igc_info ei;
@@ -361,6 +363,7 @@ unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter);
 void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
 			      const u32 max_rss_queues);
 int igc_reinit_queues(struct igc_adapter *adapter);
+void igc_write_rss_key(struct igc_adapter *adapter);
 void igc_write_rss_indir_tbl(struct igc_adapter *adapter);
 bool igc_has_link(struct igc_adapter *adapter);
 void igc_reset(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0122009bedd0..f01222f12776 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1460,6 +1460,26 @@ static int igc_ethtool_set_rxnfc(struct net_device *dev,
 	}
 }
 
+/**
+ * igc_write_rss_key - Program the RSS key into device registers
+ * @adapter: board private structure
+ *
+ * Write the RSS key stored in adapter->rss_key to the IGC_RSSRK registers.
+ * Each 32-bit chunk of the key is read using get_unaligned_le32() and written
+ * to the appropriate register.
+ */
+void igc_write_rss_key(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 val;
+	int i;
+
+	for (i = 0; i < IGC_RSS_KEY_SIZE / 4; i++) {
+		val = get_unaligned_le32(&adapter->rss_key[i * 4]);
+		wr32(IGC_RSSRK(i), val);
+	}
+}
+
 void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..5ef229a5931f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -785,11 +785,8 @@ static void igc_setup_mrqc(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u32 j, num_rx_queues;
 	u32 mrqc, rxcsum;
-	u32 rss_key[10];
 
-	netdev_rss_key_fill(rss_key, sizeof(rss_key));
-	for (j = 0; j < 10; j++)
-		wr32(IGC_RSSRK(j), rss_key[j]);
+	igc_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
 
@@ -5048,6 +5045,9 @@ static int igc_sw_init(struct igc_adapter *adapter)
 
 	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
 
+	/* init RSS key */
+	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+
 	/* set default ring sizes */
 	adapter->tx_ring_count = IGC_DEFAULT_TXD;
 	adapter->rx_ring_count = IGC_DEFAULT_RXD;
-- 
2.47.1

