Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F53542F8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194838; cv=none; b=DWlHNz1M9eJVc9+ZW6gfiVAqvf2PqN0sLvP0ziXDvVTEH8e+DJaqt7u/AH6FrL3zeWLm6XFNZ/efoU1ioeS5kUd9l6rNNafgHuP336O4YSP9B1bFxs8Njjs0C59A5FVuydOZyk4eWuEH0cufN4E8WVU+BMnud9ib5zAwoCGvPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194838; c=relaxed/simple;
	bh=bicA5KRrQzPR+gjJoc2RHFUbFtJrc8hacy54rrQ0fXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtHv4fgqF3AquZSfY7bGDFLA+WbE/cK9tK0qXhGQVpyLH3msphofK3q8hc4rFqj7RxJrgnmK3CxRD3sm53KtsK+C6MIapL9CYnYVgVx8DgOU7/d/jKlia7FIYE7g00sNJis1TGNeULGslBhBbtdEL7DvEeMjecA5yNpWZ0iL50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzHC46VN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzHC46VN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194837; x=1806730837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bicA5KRrQzPR+gjJoc2RHFUbFtJrc8hacy54rrQ0fXI=;
  b=VzHC46VNHq3ocfyftN4FgA2EBg3LM0iSwWo7UHUt70o1ofnii2zSXZTH
   ngVnsIlpTK8aHuImZtj3pVbaNcze2PfmqiIwIFlTug3j1Az0swfNSNDeq
   QBXdxqUpEj9g1NcY1CGFDYsCuI7bhoINE7JSR+VdyqIYVjDi6AXlq2tFG
   jGeYPRIkXJZo/SJZQjvE6ED9ZS//kyAcONXRUi+18EjcWggdh57YSiaQY
   +1KBZQUDCVFB1nasHgnRnoCFyA9zzpHozd+LXXPe6cc5kQQtGfDUkQhnf
   RWF/Ib4i06sT6J9bM23mefb3kTql2Fw1QO0QvYA4ugD3ki16g2n5CfzW9
   w==;
X-CSE-ConnectionGUID: s16r+04vTJSHLwCz0k8b5Q==
X-CSE-MsgGUID: 2WRvpMyXRF+YLCIg4EKuRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981746"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981746"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:37 -0700
X-CSE-ConnectionGUID: 9Mmf++qdReenl9xkMEe10A==
X-CSE-MsgGUID: SovLiNVwSDW+zN7A6aLDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904925"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:35 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net 4/10] ice: error out on CONNECTED state for input pin
Date: Fri,  3 Apr 2026 07:40:22 +0200
Message-ID: <20260403054029.3789616-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

DPLL's directly connected input pins must not allow the user to use the
CONNECTED state. DPLL_MODE_AUTOMATIC only allows SELECTABLE/DISCONNECTED
states. The current implementation silently treats CONNECTED as
DISCONNECTED instead of rejecting it.

Return -EINVAL if the user tries to set DPLL_PIN_STATE_CONNECTED on an
input pin.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Cc: stable@vger.kernel.org
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 397d16c..6a1465f 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -904,6 +904,8 @@ ice_dpll_input_state_set(const struct dpll_pin *pin, void *pin_priv,
 {
 	bool enable = state == DPLL_PIN_STATE_SELECTABLE;
 
+	if (state == DPLL_PIN_STATE_CONNECTED)
+		return -EINVAL;
 	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
-- 
2.52.0
