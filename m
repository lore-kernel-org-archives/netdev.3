Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8145D931
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254772; cv=none; b=QPdfuLbj0cWRu2baMctv/XxAjLefVK7TzQ368g/SVRu8F8YkeHRK+isFNjgCGAJ3V2g4sC6CU5htFMnFydIemPqXXbhN3NTM8YW26+OqHeZVYuBmuyW/xXrUuOqJOP2YG0dw+jbKdOIbpvtAcXrcP4UrG1fCxUk+S5Usbv9a/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254772; c=relaxed/simple;
	bh=0tf+p1G4D3ewn7KDhH/n7CLlgziNzxiJx9suljYesq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIHSSIdkkHu+m9h+BanxKcH56emt9qHNoFFGUKk2TYFaJsyyibwpt4+YZiwudE+ir8V1+qKNeCItRNqMHWvnCwWwjbwnVIW00b8byBU6x4F4jSypNA+26I6q/V5ywamG2ztU0I6s7h4iC81lhUHFWXiZ9tWHAnRvLwrUCRC8i7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch1wcEzB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch1wcEzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254770; x=1821790770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tf+p1G4D3ewn7KDhH/n7CLlgziNzxiJx9suljYesq0=;
  b=ch1wcEzBRZQcP1ayURyvt+0pQQW9k8DHs+CjZQEx9RyM7TRC3KcxqP35
   BTcpBlPJGxUfOUzGMQs7kVXAVZFDzSSINhAEVDj8BFvMMFMDRnzKFWOk7
   rWdHRXMjXVFschTgg/MPWoUDxVsoFHec1e6wVb7IBX8p8c739GT/88p1x
   w9LbnR7Iz3h30QN1IJdYk6Hl4bRrRqGRNz9hNVDQwOWlFMv7UcgE6tDSO
   JBBGqlEV0RJO4wgM44uAqxO6qm7W/+Oc+6fg5F1+32/iQNVRT7wNQ8O/M
   oJPIOU18Pto4GTORYtwDa0TZVsdeq4K4/6Ob3Mf10pr8Z4MN2EvBzZLL2
   w==;
X-CSE-ConnectionGUID: kjIHyffbQSy+8VoZrqJbug==
X-CSE-MsgGUID: C0KGL0HeQNOpeW1w3FSxGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249214"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90249214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:19 -0700
X-CSE-ConnectionGUID: Xley8Jw9QrOW76oTx4Cunw==
X-CSE-MsgGUID: lY7UqxcBRxivS2vcLB1msQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311934423"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:18 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 1/8] ice: Unlink the PTP port before destroying its ps_lock
Date: Thu, 24 Sep 2026 12:59:09 +0000
Message-ID: <20260924125916.2796499-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

err_clean_pf destroys ptp->port.ps_lock before ice_ptp_cleanup_pf()
removes the port from adapter->ports.list and drains the outstanding
references, so while the mutex is being destroyed the port is still
reachable by every other PF on the adapter:

ice_ptp_settime64()
  ice_ptp_restart_all_phy()
    list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node)
      ice_ptp_port_phy_restart(port)
        mutex_lock(&ptp_port->ps_lock);

ice_ptp_setup_pf() publishes the port before ice_ptp_init_port() runs,
and a link event can set port.link_up at any point after that, so the
walk does not necessarily skip it.

Call ice_ptp_cleanup_pf() first and destroy the mutex once no other PF
can reach the port, matching the order already used by the
ICE_PTP_READY path in ice_ptp_release().

Release the Tx timestamp tracker here as well, so the label frees
everything the port owns. ice_ptp_init_port() allocates it through
ice_ptp_alloc_tx_tracker(), and any failure unwinding through
err_clean_pf after that point would otherwise leak tx->tstamps,
tx->in_use and tx->stale. The tx.init guard is needed because
err_clean_pf is also reached when ice_ptp_init_port() itself fails, and
ice_ptp_alloc_tx_tracker() leaves tx->lock uninitialized in that case.

Fixes: 23a5b9b12de9 ("ice: fix PTP cleanup on driver removal in error path")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a735dfa2b03e..5104ccc70d4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3587,8 +3587,14 @@ void ice_ptp_init(struct ice_pf *pf)
 	return;
 
 err_clean_pf:
-	mutex_destroy(&ptp->port.ps_lock);
+	/* Unlink the port before tearing down anything it still shares with
+	 * the other PFs on the adapter: ice_ptp_restart_all_phy() can be
+	 * walking adapter->ports.list and taking ps_lock until this returns.
+	 */
 	ice_ptp_cleanup_pf(pf);
+	if (ptp->port.tx.init)
+		ice_ptp_release_tx_tracker(pf, &ptp->port.tx);
+	mutex_destroy(&ptp->port.ps_lock);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
-- 
2.53.0

