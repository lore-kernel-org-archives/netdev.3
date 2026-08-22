Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C71DA62E
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357701; cv=none; b=ssiWwEXWuGy49GKfQGTuhRJS7bYTDzdlMKZwBst5DpkSTp9YopPAg0p4jnA7VfNhhJvvG5rcUvV7aB3WpUpkyfWJ5QIkHEu+50f54Pw51QoBpRslLqHf6/PqR92ynm7B9WdrGIzVT6QnUJyatFpYliesOS007FYyzlVP2oJDAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357701; c=relaxed/simple;
	bh=vWu93L1aH9mRZpG4WlKRxDjnhWyZBrPm4y8f8ZlKZRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAMOssTV8alyt2yt4iYeurkBLd/7neKJPX71zFim6Tku6ygKhAe84TLnCXKVjl/80vZ+Zfagofb2lmMgDiPywEaKwCfKmg38Gvr7TDbIAMDO78wMzy1c0uv4wi26stbsniQO9PGIMfgIxGbF7bSCzLo182jC5uiGItqsMrm/Lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E19WldNu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E19WldNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787357700; x=1818893700;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vWu93L1aH9mRZpG4WlKRxDjnhWyZBrPm4y8f8ZlKZRo=;
  b=E19WldNu66gRPftsXFU+bfxQ9Px07yaBP9IAfXB8NmODsOXN3SXvL6CT
   Be9YIEEQ1XKMizcHRBG4O/dtTRBIMbHGX0dBTMqFgUEWx8OIF7kVeXRnb
   jjwovi/ijnYnA9LspceDiCdRhNxFIcH1QIURNsmiCnaEOkAm7DzifR7N9
   xVAp5M+/J2wMXTGmxKvgYTMx11B3qTTMZIBfZuL6ENI9U239dDMFzgoNk
   LUaiGVfWkhMAXOEIsNygm1v4vlHP4wYcEUVQRYWb7celMt0Thw1PJK2Zu
   bKLQmRS6yu6e14lBAjwBu+NJbnxfXD7PWsp5dFoBPJmrO7lDzhEg/zOde
   g==;
X-CSE-ConnectionGUID: ItEq+SlyQiSGhyNDTO26MA==
X-CSE-MsgGUID: i/jFbilST1qAeLv7f8TpkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584758"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91584758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:57 -0700
X-CSE-ConnectionGUID: GxzQ9OUwTHihfokhp46Ccw==
X-CSE-MsgGUID: EyHP+bTwTVOpOUZFAo+Nag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="263836465"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 17:14:57 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:08 -0700
Subject: [PATCH iwl-net 03/12] ice: E822: cancel offset verification work
 during reset preparation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-3-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Q2gnlL9WCKEzu7czMr+gDV5QOyocVetwd2FMVaQsfKM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOlz8nyB6oOM142tqSUYyZ79WNhGO6mbf2XtQQSJuvM
 PPIFdZ1HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkynWGf5YuIl+E1/vohnb8
 9lCpWT9V/jVri2n3RG1XhUe7V+RsesDIsJ611DHGw7aKf/2371lB3CtamqTfzr2Var0oZ1nEI/d
 4LgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Karol Kolacinski <karol.kolacinski@intel.com>

Cancel the offset verification delayed work (ov_work) during PTP reset
preparation to prevent it from running concurrently with the reset
sequence.

Without this, ice_ptp_wait_for_offsets() can execute during a reset,
find that ice_is_reset_in_progress() is true, and re-queue itself in a
tight loop. Meanwhile, the reset path in ice_ptp_rebuild_owner() calls
ice_ptp_port_phy_restart(), which starts a new ov_work. This results in
two ov_work instances running simultaneously, racing over the PHY offset
registers and the calibrating flag.

Cancel ov_work in ice_ptp_prepare_for_reset() alongside the existing
cancellation of the Tx tracker. The comment in the existing code already
documents that ov_work interference during reset is a concern but only
cancels it during ice_ptp_release().

Fixes: 4809671015a1 ("ice: Fix E810 PTP reset flow")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9d99cbb42463..b8647a39db6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2994,6 +2994,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (reset_type == ICE_RESET_PFR)
 		return;
 
+	/* Cancel the offset verification work for E82x before releasing the
+	 * Tx tracker. If ov_work is running during reset, it may issue
+	 * sideband queue commands that will fail or timeout, and may
+	 * reference state that is being torn down.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC)
+		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
+
 	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
 

-- 
2.55.0.814.gc42f45431d0f

