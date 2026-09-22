Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600051EE1A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076977; cv=none; b=r90Mxs826PyHPc1LOkUi4pMn2HICs9ZQA45bZcuUQAfKBngSOrHSx7ZtgHXsauKy44XkocY3R8H3Cz8MOU5zJaC08Zs7Sbhqw9hV6joo3FHQmMI1Zpb3nW5OJczSapXR0UW60Z5BGrUYjNvmfTvqqjS8jN8MN1tSpgs/ldQuZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076977; c=relaxed/simple;
	bh=0oxY2IqGDY/2V7icmio8r/7J85s/Evd99fGLb1HfZ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ3jypHYns88W7DzNxS6g0Am8uPZ2JYrfHkS7Kf32CGmdzOsEbvMnRCWjb0r8MrGxmqkIrvkmdPkgDQH4k4JA2kSIm7PYBUu5D1YWJpjXAPtT83X86zGpUv1F1F3ccg01F89UtdUGD+y8vD/tcOJdxe15tSSU8MEmpUXADnJSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSKjc6kd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSKjc6kd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790076972; x=1821612972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0oxY2IqGDY/2V7icmio8r/7J85s/Evd99fGLb1HfZ/k=;
  b=ZSKjc6kdoS9+eUnUib9mFwttLj/GPUuq3fBejde748HJaxCHKJQGfsJv
   b0xEYXGGZadMpnW/JoS82xZCMp6SjfTK3b8HOGmlDukHefeDtNGJ+AWf5
   pjFm1sSiJfezo3fHVY1ZwEUhc0Qu3D6HAB+628ac6RY+Je+TA6Tz+ts6v
   WLClzRABgTB3+ZFTgQjaLJ0GwXtQgtsoo+7SFv1oaHoh8fBC20p48LikU
   9myXz4rabxAY/7VFDudxXLq5aV39+OWVnXDLwkQzYgxBk5TLKN9JhzBpJ
   z5NKzxnURM+jDRwK4r9l+LExmsTlAyYV3WfJ2JDm9SwDWd32SChqhVom9
   g==;
X-CSE-ConnectionGUID: cbBVpTiLTZSahT0ZfzSjtw==
X-CSE-MsgGUID: LWYPJFf1SUu6HQ7YQWdlzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787336"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90787336"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:36:02 -0700
X-CSE-ConnectionGUID: n76H0qB8S6asiwsFcamHDQ==
X-CSE-MsgGUID: 9X/MHD//TvuXvEuRHV/vsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272591995"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:02 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v2 3/4] ixgbe: Restore previous XDP program on ixgbe_setup_tc() failure
Date: Tue, 22 Sep 2026 11:35:57 +0000
Message-ID: <20260922113558.2288111-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enabling or disabling an XDP program requires a queue
reconfiguration, ixgbe_xdp_setup() swaps in the new program with
xchg() before calling ixgbe_setup_tc(). If ixgbe_setup_tc() fails,
the adapter was left pointing at the new program even though the
reconfiguration did not complete, leaking the reference to the old
program and leaving inconsistent state.

ixgbe_setup_tc() may have already reconfigured the queues for the new
program before failing. The XDP ring layout then no longer matches the
previous program, for example when removing a program has removed the
XDP TX rings. Restore the previous program and rebuild the queues for
it so adapter->xdp_prog remains consistent with the ring configuration.
Otherwise, a later open could run XDP without XDP TX rings and
dereference a NULL ring. ixgbe_setup_tc() handles the device having
been left down by the failed reconfiguration.

Fixes: 3fe1d0a48d21 ("ixgbe: XDP: fix checker warning from rcu pointer")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1f23a035a90b..6ef51b822a50 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7348,6 +7348,25 @@ static void ixgbe_free_all_rx_resources(struct ixgbe_adapter *adapter)
 			ixgbe_free_rx_resources(adapter->rx_ring[i]);
 }
 
+static bool ixgbe_ring_resources_allocated(struct ixgbe_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		if (adapter->tx_ring[i] && adapter->tx_ring[i]->desc)
+			return true;
+
+	for (i = 0; i < adapter->num_xdp_queues; i++)
+		if (adapter->xdp_ring[i] && adapter->xdp_ring[i]->desc)
+			return true;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		if (adapter->rx_ring[i] && adapter->rx_ring[i]->desc)
+			return true;
+
+	return false;
+}
+
 /**
  * ixgbe_max_xdp_frame_size - returns the maximum allowed frame size for XDP
  * @adapter: device handle, pointer to adapter
@@ -9921,6 +9940,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
+	bool running;
 
 	/* Hardware supports up to 8 traffic classes */
 	if (tc > adapter->dcb_cfg.num_tcs.pg_tcs)
@@ -9933,7 +9953,17 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	 * match packet buffer alignment. Unfortunately, the
 	 * hardware is not flexible enough to do this dynamically.
 	 */
-	if (netif_running(dev))
+	if (!netif_device_present(dev))
+		return -ENETDOWN;
+
+	running = netif_running(dev);
+
+	/* If a previous ixgbe_open() failed, the netdev can still be
+	 * administratively up after IRQs and ring resources have already been
+	 * released. Skip ixgbe_close() only in that state; ixgbe_down() leaves
+	 * resources for ixgbe_close() to release.
+	 */
+	if (running && ixgbe_ring_resources_allocated(adapter))
 		ixgbe_close(dev);
 	else
 		ixgbe_reset(adapter);
@@ -10972,8 +11002,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 			synchronize_rcu();
 		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
-		if (err)
+		if (err) {
+			xchg(&adapter->xdp_prog, old_prog);
+			err = ixgbe_setup_tc(dev, adapter->hw_tcs);
+			/* An ndo_bpf error leaves old_prog attached in the core. */
+			if (err)
+				return err;
 			return -EINVAL;
+		}
 		if (!prog)
 			xdp_features_clear_redirect_target(dev);
 	} else {
-- 
2.53.0

