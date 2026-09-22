Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B835480954
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100514; cv=none; b=HFSS2aSo+cHecA6sWJI2JI5j1xEd/imN2052gy9P+Onx1KgGqXoNsJ6oufAQvWPgEJJ+ScHQeqshzniNBJO+pvVG4LrerjEayB8jk/yW00TEHWR4NTmP19cJJD4PD4kjhD7kXo7zSOA/AaBvdxS0n694Y9kSE8qQfq8eilOHrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100514; c=relaxed/simple;
	bh=vPWenbyyHGt72pia3E2iY9PCH1ARyceDooGNZ5KZsSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDTAuYQJFq9EAenVKM65jJjqlpvnmK8G20nIuQSkcriBYHoxJjIRDGArYPYMh/lPsINaRb93GA8m32aC50qbcVfcnY/CXFmmpXE030X3IgxXIg5iZ5L2oMWIQvBVYU/iW56WJRs52dSWZhf7O3FOXsH/WcqQaaRkS0yVd6xxhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk2KMcQF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk2KMcQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790100510; x=1821636510;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vPWenbyyHGt72pia3E2iY9PCH1ARyceDooGNZ5KZsSo=;
  b=Nk2KMcQFZzTCCOYQhy+zFzY9hikkEjtnbW/9W3dzwa8F7pl8AwMkJbir
   B5mj7BbYNSMvWak4ib/99epU68XUo4KWtSKf5mmbjcHHmscvmYcqTej7k
   cJNTVLnCIYAIyQOZFygCjwe/XZ871+id5Kx8qniG+PHOUZgQB6LLmzmiH
   gGlKin1YEg55xgmmqoTrD2RMseVXn/fho6TcsH8a1kJh+8XepbWhXSr/D
   VIfCNvPk69X+ZX8xgki1W156ftv9OagolGSbUwV6Bi9B9v8sG+gCOSqMC
   FnQiNUPDZbaYwjv3tRsCt0APt/HzCpfxq/EZo/O30MwDFZDqmgMhm3Yc3
   Q==;
X-CSE-ConnectionGUID: Q+76zmqvR42apbb1qHciPg==
X-CSE-MsgGUID: nDiitf5NSEyXgjOJje1M1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232038"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108232038"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
X-CSE-ConnectionGUID: CMnp7b2zS+m1KQ5NryrXdw==
X-CSE-MsgGUID: 3zC8NkJ6ShmPk7uUtAN+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="281315315"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 11:04:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:39 -0700
Subject: [PATCH iwl-net v2 06/15] ice: E822: flush offset verification work
 during reset preparation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-6-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=T1zzYwQG1f0nawDGBjFAXJfbTFuTGKQqNw4tAUKh1ww=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6UrfD4oBf5ZxGHN437n59/NXAI56RtPha+tu1a22
 +NlyhmOjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYy/TfDP82pcYcEAvkz76Uz
 Cm/PVv94qS/0fUDzMu8XL4T9tvzf8pWRYcn+jOBD0omumdz1RzLPhPSpm3IWr7GQD9p477THzLx
 ZfAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Karol Kolacinski <karol.kolacinski@intel.com>

The offset verification work task for E822 reschedules itself if the device
driver is resetting. However, it may already be executing and attempting to
access the PHY when a reset has begun. Flush the work to ensure that any
current execution has completed and will see the updated reset state. This
avoids the potential accesses to the PHY state while resetting. It is also
simpler than attempts to cancel the work which could lead to a race between
the clock owner PF and the port PF.

Fixes: 95af1f1c4c9f ("ice: reschedule ice_ptp_wait_for_offset_valid during reset")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 364f0f389d85..fccea0511eb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3015,6 +3015,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_flush_work(&ptp->port.ov_work.work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

