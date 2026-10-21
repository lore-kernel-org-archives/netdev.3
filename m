Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620821;
	b=cQ/4RA1zrZeQbOaqGqdZAUQ0AwlGEkCXn0/Fi0RqFXx+GyDktMqFw8u/dU+IPmYEZE1f
	 3B8Scp0XWBLmEkJl66MlzrChjbsStLvGaoR85a477q5FkvgVMvdifO1Ol1vf0fNiaBoLZ
	 x69JgE25CX3sVxMCOib2v7qeCk8RP+NFNo4v9RaRNzoZJ1QNdQGx23mM57YPtX4CmKbPJ
	 HaBhfDxvk0FWdFm3jHsvmjwyvMxp6eNMriXMvLHiHnx0MGrPI0wWjhNP1bMlwcrmPmPfd
	 B2ce8axU0CJWoCXVilkrlolNRZchLuhWUpA7z/aUYuc5SVXwK4D32gwzF0qKNRKKqZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620821;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z/Pa94rFYlPtV3j48C83OMNuEjMwJ0fSIZ0h8P0yQq8=;
	b=UtLjAiySY9YxUA1DBMOgd+kRBjY7tEKkl8H4Soi/N3HERlfopVydH5JNRFF8zT1i7Q67
	 wOqJogrFwPolgL27ijaNslJ3hpR4WtrKJGTDbTlg/qHAxwyEkN6DFgE0HWq5eiUbps9U7
	 PM+ehVX20tvV2fTxyuWsyaCsjGhR0U2qZdCezem2RwIV/U1kWcbQ3hci70/HRpS9em9IS
	 JCIrCE5JePqXWDKB6PA/3OT6RTL3vkVqFyxPeGpa8Ql5TWVTWvuVgzCjQBW/ZG52Tm6bh
	 XuyOzaXnaUbCb3Oj80gUtMDOSipLekm5wfo9Xfg5C4CmAiI1KhH0E1qs908z3IMNTsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=(null) smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UmOU35IX;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E019606A335
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E019606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UmOU35IX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792620810; x=1824156810;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XsjetVIii/93DQtAsL6Rw9RDyeifpQ7+LPMqyDF+Rw8=;
  b=UmOU35IXJnTT2FRu10bTdnEcU4A1NOTyOxP+i/0F38H2aB9Sedun9pG3
   OTNBQI3UGmX5Ud1XZ2spu6fd2Pa6tgJMbroeNQC8NFi5XoSk17k9sd1lx
   xsamvbIqdHbn32qHeD6udrLz02OzZNakmn2Yj1Jb7zQrwpam5bZDDlxin
   snmc2+89AVC92V4sth4kjnnQIUKZTHv5kzeCkgDgXIsiea4FdVp+rduTy
   lHFfK1+NuK1ROdG7jHGJjSEq1hmKWP7ZqR5DhaumcRq7zO6PYjbscD4Uk
   1ihM2tTQ+5klO+IchhvU9nSbGhFIiVRwChGUG2N186Z6Lfe5YQ/ALxgRA
   Q==;
X-CSE-ConnectionGUID: FEbuAAAgRMi4pKSy8v/CPw==
X-CSE-MsgGUID: jvO+V24vQM+9VJiukF3gDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1363223"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1363223"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:13 -0700
X-CSE-ConnectionGUID: gXP4OYh5RHK5evy+AFUQiQ==
X-CSE-MsgGUID: WXVUOzxjT7SCIX4PBXABsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3275488"
Received: from orcnseosdtnuc.amr.corp.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 15:13:12 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 21 Oct 2026 15:12:55 -0700
Subject: [PATCH net v5 10/13] ice: E825: perform a soft reset when starting
 the PHY timer
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-10-72289a4ac8eb@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, jacob.e.keller@intel.com, 
 maciej.machnikowski@intel.com, przemyslaw.korba@intel.com, 
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com, 
 richardcochran@gmail.com, horms@kernel.org
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=XsjetVIii/93DQtAsL6Rw9RDyeifpQ7+LPMqyDF+Rw8=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGrZOPDIdBDKe0d0jg8qW/5sTloPlg5DGlgankDoQwYCUb72X
 oh1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmrZOPAACgkQapZdPm8PKOizXwEAlvS4
 kra3YwRAmX88yvmRT39M3oezsZ4KBDFBmlGMumABAP8HWaRdVNKqCPoJWye+aEHepWT9WI9teB0
 FKV1gPIwB
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

To ensure that the E825 PHY timer begins in a clean state, initiate a PHY
soft reset prior to programming the PHY. This ensures that we clear any
outstanding Tx timestamp memory, and ensures that the PHY internal state
including its timestamp counter has been reset.

Note that despite the name, this PHY soft reset only impacts the timer
block of the PHY, and not its regular Tx/Rx functionality. Additionally,
many configuration registers such as the PHY_REG_TS_INT_CONFIG and
PHY_REG_TX_OFFSET_READY are not reset.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 5637925c0e68..2d000251b185 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2128,9 +2128,11 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * @hw: pointer to the HW struct
  * @port: the PHY port to start
  *
- * Start the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Perform a PHY soft reset and then start the clock for the PHY port.
+ *
+ * This must be done as part of the flow to re-calibrate Tx and Rx
+ * timestamping offsets whenever the clock time is initialized or when link
+ * speed changes.
  *
  * Return:
  * * %0     - success
@@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+	if (err)
+		return err;
+
 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
 
 	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
2.56.0.212.g129ede20d986

