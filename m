Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4A3B0AD3;
	Tue,  5 May 2026 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958141; cv=none; b=cxDO528Qocu9t3cMuM8wP9J4jR66vk0LysU4RSkZt0fnLVaXJ7nh+R+VGyrKnhP6eWg73oBTXNBYu8U+f4lALL4fNjAF+7i68Hu5FiKRb5IDE3VgftSwptWqxn2jpFmzqG5SUYtFktnI+OMjcECebSo54ObePZfzjf5Cskdf3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958141; c=relaxed/simple;
	bh=wY+GZStVgveeM4dDJUttYbOKSr5LYkYnE1B29ZaMNt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzcck2DZI1Wz5eQUZDjzlZ12WZlaubFRs+GW+buyI52Fswm0gJ++h6wySinpfidKjpyvRm/eZhE304kdzNlA194YFH2eJcatdOjDL+riy95iZvSBynZOgCuIXRDkknRDM9b0v5rGs9gBcU66EGl/WMtEGgVHlzX5+GAQozHHYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0QQQkIZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0QQQkIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958140; x=1809494140;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wY+GZStVgveeM4dDJUttYbOKSr5LYkYnE1B29ZaMNt0=;
  b=e0QQQkIZdkgK088XYGHV61voLgo2jdNUVOONcboDNt0NwMTK3Q2wztMG
   L1mvk8sF4kqaNU3NiqMBrPQkXApTveyHSUaPeMSCO5rE2vN8wjay6LC/C
   Rt8JjmKyLGhQzkuKR0jX0ANlWOleCL1gCXj5nC8RCo5ql86cRvf34cE5v
   AS1Rko4VGx6tyZTQbKcxZFNkvj1cPhqxLMsv6hkJCM9rv4N8e1K6J952o
   pakB2k9lCCvXwweeNItgCvcaf4iBfZgfgdYpsqsC3WQizVUekMATY6C2A
   pTjv8udB4aPs4XkTCRCKvLrCWK/n95jIy2X07DtXtBbXxdEOm78nKPxC5
   w==;
X-CSE-ConnectionGUID: BvZEU6eQR/+eJykoOnRXUg==
X-CSE-MsgGUID: 6DyQ5iGTTaeiRZ3Pt9Sc3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126433"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126433"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: YlccEYWPSW2WGcqvbwFsyQ==
X-CSE-MsgGUID: xHKzJR/NSMySe7mCZcW23g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683489"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:15 -0700
Subject: [PATCH net 02/13] i40e: Cleanup PTP pins on probe failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-2-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, Matt Vollrath <tactii@gmail.com>, 
 Kohei Enju <kohei@enjuk.jp>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QNjr6uUakcnLHlPppRVsn2hnfyH4eY5JOQgkwstJsQg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNV/PRFww2CIeGGDHOWtZioCskPKrmiSnRK6XpvlHs
 mrkfyzvKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCITyxgZfhy5H3FwxtNtyzax
 tzwxW3/8/Au5db/ktq4TzzA44afi8JeR4dLUW/9/6eRt+yC258vZH5nXvf+JMwef8t+h8vfm4f0
 bv/ACAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Matt Vollrath <tactii@gmail.com>

PTP pin structs are allocated early in probe, but never cleaned up.

Fix this by calling i40e_ptp_free_pins in the error path.

To support this, i40e_ptp_free_pins is added to the header and
pin_config is correctly nullified after being freed.

This has been an issue since i40e_ptp_alloc_pins was introduced.

Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
Reported-by: Kohei Enju <kohei@enjuk.jp>
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index dcb50c2e1aa2..83e780919ac9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1318,6 +1318,7 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
+void i40e_ptp_free_pins(struct i40e_pf *pf);
 int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
 int i40e_get_partition_bw_setting(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f06fcef644e5..6d4f9218dc68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i40e_clear_interrupt_scheme(pf);
 	kfree(pf->vsi);
 err_switch_setup:
+	i40e_ptp_free_pins(pf);
 	i40e_reset_interrupt_capability(pf);
 	timer_shutdown_sync(&pf->service_timer);
 err_mac_addr:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 404a716db8da..7d07c389bb23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -940,12 +940,13 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
  *
  * Release memory allocated for PTP pins.
  **/
-static void i40e_ptp_free_pins(struct i40e_pf *pf)
+void i40e_ptp_free_pins(struct i40e_pf *pf)
 {
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
 		kfree(pf->ptp_pins);
 		kfree(pf->ptp_caps.pin_config);
 		pf->ptp_pins = NULL;
+		pf->ptp_caps.pin_config = NULL;
 	}
 }
 

-- 
2.54.0.rc2.531.gaf818d63126a

