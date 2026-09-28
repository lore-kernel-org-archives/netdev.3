Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD3502D47
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636686; cv=none; b=I9AneUFTO8BzZJRJyMlQ12J0tvmUKQ4AX6QORAboNZVRdnxbNIUc6xjDQaPxzeqqARCgxbSzYaY4as/mnQPprGenNQmCVagcRyZXvW0cndpXJng9EqMvaA/BRoOtH5SXvDVI3rH+8TSfElqXBrb/gO17F0d2hDRt6TBjg02j3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636686; c=relaxed/simple;
	bh=pQcNXblQBkDyqW2CcpHURR4kgPBjC5wUo+b4AaprSYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imKLiSEYvwzQa59hFa1skSz/uqz0rzyJ8yoTTqdQyw6dWBilyAZSnK/cOz8l1nK7RguSNOGeXhHVMy6qabQ4bAXXU5GR3Zpymmhmyt5DzSDOjdQK0wG80e6kamtoVlZhK9xtHw3FFLe+9NIxdiPd6YU7F6WyBKDuv0vnQRSuOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OK/piCXs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OK/piCXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636686; x=1822172686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQcNXblQBkDyqW2CcpHURR4kgPBjC5wUo+b4AaprSYo=;
  b=OK/piCXsM8bt/iqSxct33+EyOxQrjxveh6xpfyT4xR880hGXRcw60sX7
   dov9lcx8jlj1DWAvz711iav5b+NaqOhdJycBtiMgZREcx3WDb5HGsalRA
   3kMumCAyx0yTJfRNvjJrRBkayh6T8P4aXdDb5riYCwBnjFkt4yHSbzu2D
   QsypBAi/q8OGhb+yjLJOVt2GNUlZgtfUq1TsatyetVz6lGwT6AGap4SHe
   EEU87OIzfEmlC5zS0yQKuepaZBHeGptZb6B5hiGJwtbivV3dEJ7s75s1a
   Mrw6YmyEBE90Hdny0OXPucdGNikuE+At0LVLOMxigd03FLMrU8YbhZme3
   w==;
X-CSE-ConnectionGUID: AObpFUoaTYe4WC+T8MAciA==
X-CSE-MsgGUID: U7e6crNsSRWXq/nWRT38mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513272"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513272"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:43 -0700
X-CSE-ConnectionGUID: DXXWEPCYQuiatdInU+tgeg==
X-CSE-MsgGUID: fbFi29EYR5+Q/Sh9KeqhzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317689"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Bryan Fraschetti <bryan.fraschetti@canonical.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	luoxuanqiang@kylinos.cn,
	tristan@talencesecurity.com,
	tomasz.lichwala@linux.intel.com,
	david.butler@appgate.com,
	horms@kernel.org,
	paul.greenwalt@intel.com,
	maciej.fijalkowski@intel.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 3/6] ice: Restore Ordered MMIO Writes for Tx Doorbells
Date: Mon, 28 Sep 2026 16:04:24 -0700
Message-ID: <20260928230429.495442-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan Fraschetti <bryan.fraschetti@canonical.com>

The DQL accounting state which tracks the number of bytes queued for the
NIC to transmit, namely dql->num_queued, is updated by the ICE driver
when it invokes __netdev_tx_sent_queue(). Subsequently the driver
updates the hardware queue tail allowing the NIC to begin processing the
work queue. The queue accounting update should be ordered before the NIC
begins transmitting descriptors.

The transmit path currently updates the hardware doorbell using
writel_relaxed(), which (on arm64) does not provide the same ordering
guarantees between writes to normal memory and writes to MMIO registers
that writel() does. This introduces a potential race where the NIC
begins transmitting descriptors before the dql->num_queued update is
globally visible. If the NIC finishes before the update is observed by
dql_completed(), it detects an invalid state where more bytes have been
completed than have been queued. When this happens the following BUG_ON
is triggered.

  BUG_ON(count > num_queued - dql->num_completed);

This has been observed and manifests as the following crash (note that
the trace has been trimmed) in an environment with sustained network
load that uses an Intel Corporation Ethernet Controller E810-XXV for SFP
(rev 02) on an arm64 machine. Replacing writel_relaxed() with writel()
in a test kernel eliminated the crash in the user's workload, which
previously reproduced the issue reliably.

  kernel BUG at lib/dynamic_queue_limits.c:99

Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
pc : dql_completed+0x268/0x2a0
lr : ice_clean_tx_irq+0x1d4/0x620 [ice]
Call trace:
dql_completed+0x268/0x2a0 (P)
ice_napi_poll+0x94/0x520 [ice]
__napi_poll+0x48/0x3f0
net_rx_action+0x194/0x420

This restores the behaviour prior to commit ccde82e90946 ("ice: add E830
Earliest TxTime First Offload support"), which changed the notification
mechanism from writel() to writel_relaxed().

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161572
Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Bryan Fraschetti <bryan.fraschetti@canonical.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 31303ab5be17..a2c7c4962882 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1561,10 +1561,10 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 			}
 		}
 		tstamp_ring->next_to_use = j;
-		writel_relaxed(j, tstamp_ring->tail);
+		writel(j, tstamp_ring->tail);
 	} else {
 ring_kick:
-		writel_relaxed(i, tx_ring->tail);
+		writel(i, tx_ring->tail);
 	}
 	return;
 
-- 
2.47.1

