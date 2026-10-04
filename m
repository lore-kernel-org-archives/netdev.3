Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD447606D
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143053; cv=none; b=HhnvcGri+n3Rd+EZBSXCyfYnuZtFSvQM0j1CTQ4lX8GrVzFPiIR2S/LUgCf1MwEEitzrqo5IywSZ1QEtaQ6+hH/yyMcmO6OUefrL4FLaaHPrjKwXGNo5dOpCG9dzgCsZHWK4DSaFFUSAmW01zWa3NPo5EhinRvwcJmyguxES4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143053; c=relaxed/simple;
	bh=AU3mmbErzbRmm4skdHe3O1ykKv0nigZVz4bPkXKlZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsVQqz7pGsjWbydCC2vheTBQOqf7xSMYR7gtQFPxiRfYuO2ytB5KXrGHqqv92e6ADtdCE4gibdMo1zZCEFS6qP7RtKmqbSszXjp5f5liIQIE3998aHp01zCPBgJ+6uFzpAvCBngwrz+Rh+j+Lhy19pvxQZ5yI9iqIuU1fz3GcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 913FE47979;
	Sun, 04 Oct 2026 21:44:01 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Don Skidmore <donald.c.skidmore@intel.com>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Viacheslav Tyryshkin <s@tyryshkin.me>,
	Melissa Romanus <melissa.romanus@proton.me>
Subject: [PATCH iwl-net 2/2] ixgbe: do not enable MDD without VFs
Date: Sun,  4 Oct 2026 21:37:00 +0200
Message-ID: <20261004193704.2895700-3-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791143040630

MDD is meant to be enabled only while VFs exist, see commit
d5e3152037f3 ("ixgbe: add MDD support"), and ixgbe_watchdog_link_is_up()
accordingly only enables it if there are VFs. But ixgbe_set_rx_drop_en(),
which disables MDD while rewriting SRRCTL, re-enables it
unconditionally. It runs on link up unless DCB with PFC is enabled, and
on DCB PFC changes, so MDD ends up enabled on X550 and E610 adapters
without VFs, where it can block PF queues and raise events for VFs that
do not exist.

Only re-enable MDD if there are VFs.

Fixes: 1a3ebc59f717 ("ixgbe: turn off MDD while modifying SRRCTL")
Reported-by: Melissa Romanus <melissa.romanus@proton.me>
Closes: https://lore.kernel.org/netdev/bqzPMb-F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=@proton.me/
Reported-by: Viacheslav Tyryshkin <s@tyryshkin.me>
Closes: https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-7152464b93e2@intel.com/
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2d..e35265f96ac08 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4132,7 +4132,7 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
 	}
 
-	if (hw->mac.ops.enable_mdd)
+	if (adapter->num_vfs && hw->mac.ops.enable_mdd)
 		hw->mac.ops.enable_mdd(hw);
 }
 
-- 
2.47.3


