Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2113B3BE6
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939804; cv=none; b=Vv1i16Nyselk0kaEPwEz3WSgaq3oCNbPhQpYlXtqTu2PJgV/pzRIdaqdZseZk+mlGj6V+l+Fyc8J8EX2sPT6r7GMkjQbnhpTOBORUQo2m4Um+Yu6cX9hvwEn8ReugtQwVjtVUbmSJiks/cLUymmx0iyyTUyfKO9ejJuKGiVEbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939804; c=relaxed/simple;
	bh=55q7elZfgaltNkGTCH0WrO9eoE2wpgE8P0YrmDqSQNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J79pfx4OLw/ttI49/gscipcP6Y60KH9GtjMj7KBhgOOCbE80Ontul4I8Qw3f7krmg5aapKWXbwn8iP4/mbfAe6ogMMkMg0GKhGqs8rkfpIyBCHtgpAWE19bx5dsxq48FPRemGPn8bryXEfpFSjA8r2UTvxasBfPaY2leN6y0+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivKlekgy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivKlekgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939795; x=1814475795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=55q7elZfgaltNkGTCH0WrO9eoE2wpgE8P0YrmDqSQNg=;
  b=ivKlekgyv5AVgFjGT+K67D76V7pNz59x14uuBJwbLGALMqDoW0vtYgfk
   7usNydQt9jvEhvmNvYVTVouU5Jb3L+kqP6A50zeBnur+VJHG0wE/U8v+N
   v9078xeb+T0U1kTvFY4NrjKqu9a+mieQpxGwym2E02GcEtSnqrZg6nszD
   q7VT+bkWRWuNshpyiKEkFxt1WBVbjs3hhH/Yk0yBrOu+t/ekzzjYWRGDF
   Yc0avoSyeDAEvHMNzRQXXf0iQeh2Eaz9Ak5Gknu0Z2foVZ6z5JkS5dphn
   /m7lNJQVAY6dFOt1JJLljY8hSJrNd8OA9UuGChanPDWOb6JVbUvYHX7bw
   A==;
X-CSE-ConnectionGUID: hNNV2U/kSPaLa7kApl5yGg==
X-CSE-MsgGUID: sO0KO0GaReC5Wue6LIqiNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069140"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069140"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:13 -0700
X-CSE-ConnectionGUID: 6M+JShzPQ3WYhDwstDokcQ==
X-CSE-MsgGUID: UibIih7zR22m7YNfdUYlww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561425"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	khai.wen.tan@intel.com,
	khai.wen.tan@linux.intel.com,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	hector.blanco.alcaine@intel.com,
	dima.ruinskiy@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net-next 08/11] igc: remove unused autoneg_failed field
Date: Wed,  1 Jul 2026 14:02:57 -0700
Message-ID: <20260701210303.1745310-9-anthony.l.nguyen@intel.com>
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

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

autoneg_failed in struct igc_mac_info is never set in the igc driver.
Remove the field and the dead code checking it in
igc_config_fc_after_link_up().

The field originates from the e1000/e1000e fiber/serdes forced-link
path, where MAC-level autoneg timeout sets it to signal the flow-control
code to force pause. igc supports only copper, so it never needs to set
this field.

Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
 drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index be8a49a86d09..86ab8f566f44 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -92,7 +92,6 @@ struct igc_mac_info {
 	bool asf_firmware_present;
 	bool arc_subsystem_valid;
 
-	bool autoneg_failed;
 	bool get_link_status;
 };
 
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 7ac6637f8db7..142beb9ae557 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
  * Checks the status of auto-negotiation after link up to ensure that the
  * speed and duplex were not forced.  If the link needed to be forced, then
  * flow control needs to be forced also.  If auto-negotiation is enabled
- * and did not fail, then we configure flow control based on our link
- * partner.
+ * then we configure flow control based on our link partner.
  */
 s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 {
 	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
-	struct igc_mac_info *mac = &hw->mac;
 	u16 speed, duplex;
 	s32 ret_val = 0;
 
-	/* Check for the case where we have fiber media and auto-neg failed
-	 * so we had to force link.  In this case, we need to force the
-	 * configuration of the MAC to match the "fc" parameter.
-	 */
-	if (mac->autoneg_failed)
-		ret_val = igc_force_mac_fc(hw);
-
-	if (ret_val) {
-		hw_dbg("Error forcing flow control settings\n");
-		goto out;
-	}
-
 	/* In auto-neg, we need to check and see if Auto-Neg has completed,
 	 * and if so, how the PHY and link partner has flow control
 	 * configured.
-- 
2.47.1

