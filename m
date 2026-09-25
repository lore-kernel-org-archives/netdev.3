Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246C4FECFD;
	Fri, 25 Sep 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375651; cv=none; b=fCyIbXWV+0t18Cj4ixsg3z5L8AD93PC+tw0UA9XpHwT0f3LbO6I2TsUGom9QlZFmdrBUOpXaC/ltdDtQGxeT1nPOz5G9AxI1z6O8M0yAu2RsMAUup9kARBUZbFzkXTywOBqwpyHwy0whus0L0KIJyNlkVgrQK1qAdoXTNCCxMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375651; c=relaxed/simple;
	bh=sdj4njEDSoSp/umSPZjViadBoej1J72Eti9zbsLYbYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1SzVReY5m/U6OqaZxKY3E844etmFqzoPI6U/gVJgrEoNiJtqntYuQE30bxtRVXpvbsrPZ85aFZWretOiGK5JGrfSJs9tU3VSZEnoiVmhDxJwfx1cZte+7MgT4yg5hp34ralzF+7dVeW00KS9wENQ7MG8rjHDv3iMEXRfSKhVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVURONZn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVURONZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790375649; x=1821911649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sdj4njEDSoSp/umSPZjViadBoej1J72Eti9zbsLYbYM=;
  b=EVURONZn27giBEW8VtWQ2zkLUAcv2ZgTeSVm5yQLSflyz83PonAZGGKE
   Yv60foXdxkFKaotkP8E9HB2aNA1eSTWue3ZHlpZ8ctPcHBWDiJpx7embl
   NNHVrhMrvFo4XGgQLKdRkt27TnbKhkM13CBNB8TMkq9sL/7/Vq156WSjb
   d5QZ87Q3dr0Y/BZ9ARnvVkxR3PVIkFAxHkLfKk7AijnHGlmzSMijaWSK9
   0hb020ewe7SiZ2elnyfmpfNFtcppedOGWdfcsF8/ugW6s/l1xNO2Niw3e
   Ft3ssOjMNkFQotlBKsFbzTPNFHAfkVNF5e82QihTJhftah8cqBj6fZ1NI
   Q==;
X-CSE-ConnectionGUID: 1/zJm56qRPK9CAb30bV1oQ==
X-CSE-MsgGUID: OCX/Tc41RyKR/T5ZMhyIiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90071996"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="90071996"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 15:34:09 -0700
X-CSE-ConnectionGUID: lV4oakUWTie2Hg9p5M/RGQ==
X-CSE-MsgGUID: OhHepA3TQfu6hp/9eMkcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="273053432"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2026 15:34:06 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP command
Date: Sat, 26 Sep 2026 00:28:24 +0200
Message-Id: <20260925222824.270640-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260925222824.270640-1-grzegorz.nitka@intel.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cross-timestamp capture path programs GLTSYN_CMD with READ_TIME before
starting the ART/device capture and clears it with NOP afterwards.

It was assumed that this change was needed for E823 devices, which
turned out to be not true. The hardware supported by this driver
does not require it.

Since GLTSYN_CMD is shared with other PTP operations, touching it here
only adds a potential race source.
Remove the redundant source command programming instead of adding another
guard around it.

Testing hints:
Verify crosstimestamp path, for example with phc2sys tool, on
E822/E823/E825/E830 devices. Please note that the phc2sys tool performs
cross-timestamping by default when supported by the hardware. This can
be observed when the reported delay is 0, indicating that the system
time and PHC time were latched simultaneously.

Fixes: 88c360e49f51 ("ice: Support cross-timestamping for E823 devices")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fd97190a89a9..23c0a45050d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2229,9 +2229,6 @@ static int ice_capture_crosststamp(ktime_t *device,
 	/* Snapshot system time for historic interpolation */
 	ktime_get_snapshot_id(ctx->snapshot_clock_id, &ctx->snapshot);
 
-	/* Program cmd to master timer */
-	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
-
 	/* Start the ART and device clock sync sequence */
 	ctl = rd32(hw, cfg->ctl_reg);
 	ctl |= cfg->ctl_active;
@@ -2258,9 +2255,6 @@ static int ice_capture_crosststamp(ktime_t *device,
 	*device = ns_to_ktime(ts);
 
 err_timeout:
-	/* Clear the master timer */
-	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
-
 	/* Release HW lock */
 	lock = rd32(hw, cfg->lock_reg);
 	lock &= ~cfg->lock_busy;
-- 
2.39.3

