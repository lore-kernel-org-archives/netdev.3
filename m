Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06086402B9B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551970; cv=none; b=cfAogMTumiwps53NgPVYPZP1ZPF4iWgQgSQZ7AqbR0ecwos5CDFSBLNnVS5hRsfuucy4U6tIUYMW20GXjTAN1Atox68bLTejCdwSdN4uMuc31OgK6rD1+09Gsyyvfds+yj1CN0GSJyEHsLlstbbMfCUODaW/wlgAzmLgZ3pUyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551970; c=relaxed/simple;
	bh=iMyBM89b2seTFG8wKFYplgNuifzMOqRBwqYX3WhqWOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7wq44Ec7fKbi2vZvxoLf4UGH4k6mSE5vB2DoaXPDqcso3zU/oeIFUrNu67RWDcxYAG2gMbwDWW2TkLsmXiTSW4IpkOTUYlaNFbAK0lYF7WbjTasfTw18gGewXUE7Y+cQdTGKj3s2uW+nCXWVfEHM5wTjmTc3u9IkoVH1bPAFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4Uynsl/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4Uynsl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777551969; x=1809087969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMyBM89b2seTFG8wKFYplgNuifzMOqRBwqYX3WhqWOE=;
  b=l4Uynsl/p4DItv2+ucCAlT4nqgRQHVDm1zALqYYL/9FmgDRQDZsDftBO
   oLQeyAzO8wX8gCD7wCt3CWvnv1scLXnN+wwWH3n9PyI44EfJQl4Vam/Gt
   T93qD8JtMdihJ8HZL4J7tQZrOph1VoZ+uYbixlk3LwFVWJHcvf8nmfBAZ
   i6UtLGLKx5aPeZKaBUOgbHUvuCii171BAzQ/uo28jiGjW4qbUFFAu8LeW
   Vv2hIm0OmEz3/uX4koTUhKA5YVL6WNkQJMZ2cDCzzgI+XUURTJddpksHv
   qndUAmmXE++hkLj3RZWKPj+VJHE4h4j4uHxFEiYpaO9yi/viJxR200ANu
   w==;
X-CSE-ConnectionGUID: X0OuzMOcSFSYgmeFoj8yug==
X-CSE-MsgGUID: 4mXXhZTFT8+SMnmqI1fdGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78689189"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78689189"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:26:09 -0700
X-CSE-ConnectionGUID: 7kFlS1XZQzWuF31ND2ZbkA==
X-CSE-MsgGUID: TQq6O933TXaYRN5tKBHDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233538433"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa006.jf.intel.com with ESMTP; 30 Apr 2026 05:26:08 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 3/5] ice: add correct handling of SMA/u.FL states
Date: Thu, 30 Apr 2026 14:26:00 +0200
Message-ID: <20260430122602.126722-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ICE_SMA2_UFL2_RX_DIS bit name is wrong: the bit is active high
(setting it *enables* RX for u.FL2 / SMA2), not active low.  Rename
it to ICE_SMA2_UFL2_RX_EN and invert the use sites in ice_dpll.c so
that enabling the u.FL2 pin clears the bit (as it used to do) and
disabling sets it.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 6 +++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 62f75701d..7e8bb63 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -672,7 +672,7 @@ ice_dpll_sw_pins_update(struct ice_pf *pf)
 		p->active = false;
 
 	p = &d->ufl[ICE_DPLL_PIN_SW_2_IDX];
-	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_DIS);
+	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_EN);
 	d->sma_data = data;
 
 	return 0;
@@ -1264,10 +1264,10 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 	case ICE_DPLL_PIN_SW_2_IDX:
 		if (state == DPLL_PIN_STATE_SELECTABLE) {
 			data |= ICE_SMA2_DIR_EN;
-			data &= ~ICE_SMA2_UFL2_RX_DIS;
+			data &= ~ICE_SMA2_UFL2_RX_EN;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
-			data |= ICE_SMA2_UFL2_RX_DIS;
+			data |= ICE_SMA2_UFL2_RX_EN;
 			enable = false;
 		} else {
 			goto unlock;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index c1aa408..278d757 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -655,12 +655,12 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 /* SMA controller pin control */
 #define ICE_SMA1_DIR_EN		BIT(4)
 #define ICE_SMA1_TX_EN		BIT(5)
-#define ICE_SMA2_UFL2_RX_DIS	BIT(3)
+#define ICE_SMA2_UFL2_RX_EN	BIT(3)
 #define ICE_SMA2_DIR_EN		BIT(6)
 #define ICE_SMA2_TX_EN		BIT(7)
 
 #define ICE_SMA1_MASK		(ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)
-#define ICE_SMA2_MASK		(ICE_SMA2_UFL2_RX_DIS | ICE_SMA2_DIR_EN | \
+#define ICE_SMA2_MASK		(ICE_SMA2_UFL2_RX_EN | ICE_SMA2_DIR_EN | \
 				 ICE_SMA2_TX_EN)
 #define ICE_SMA2_INACTIVE_MASK	(ICE_SMA2_DIR_EN | ICE_SMA2_TX_EN)
 #define ICE_ALL_SMA_MASK	(ICE_SMA1_MASK | ICE_SMA2_MASK)
-- 
2.52.0

