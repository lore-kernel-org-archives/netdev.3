Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F53921DB;
	Thu, 14 May 2026 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799893; cv=none; b=f26I5D2YMDGguyd00GusttUW7DmapwWTxwu36p028XqxKirkShJmlptZRXRFypUJUk/gIymUptOOq48i/jqa+lQ4bTYbdpFbUWJSftiCLvPsCMADvo5R6KTStTWDk9350CrhxVyZtfsE5YMZkiQP22ORtZrPmN9VEZAPHdSvq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799893; c=relaxed/simple;
	bh=jhnNpw7Tz9YNTDn5gSXM/OGnATSxI7/qoJ9Vwt+/2hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifHWJCf0RvEQ90U4ebB/C9FFltsHtplKAV1V8CcLcg4gza3mIzB6upf1Ygu1yK9xDdcU4vbElZepSQ2nPcMIiJ0Pq2dcwq1SQAce7JqMAfZiRuLOi2UkNvMN7GXpLMgT4hXC2k8dj1RGNIZp0IdbxBX/gsS0X/oRHfVjv8kFiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsESiJ14; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsESiJ14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778799892; x=1810335892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhnNpw7Tz9YNTDn5gSXM/OGnATSxI7/qoJ9Vwt+/2hQ=;
  b=XsESiJ14Nh2BvgPP+jmQlUrMHmg6A+1p5EZ4CLD+OuM1/0qgEhtu816c
   L44spugYZr8S2cnREOgs1leY4VQW87BwUj2tw8xlsavY1vB85B5AxF8nR
   28VfXDAtvSDfchK7qmGy+086ZeR95pvib2iBAPuyxxcVXH7iV7daTOnwa
   pwWflmlrCvy8StrVf7vPII/8fNMvv4fE1eCNNJPza8qgSxk/mizU8T0pk
   Q7xbYmUL7eCy6rBmCJufGDRtHuJKNlyDt+4ULuZlR0cR2pMimDiUpQHqz
   f9YGKmKkj0qvSkxid/M6VSbFgWurbWrgV7f1j+totB/j3QAnTgi3eNmjg
   g==;
X-CSE-ConnectionGUID: gkjn63sqQDeewsULM1uLlw==
X-CSE-MsgGUID: BCst6rUSTgGpM7nbUcaMWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79924622"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79924622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:04:52 -0700
X-CSE-ConnectionGUID: d/h4XfvHSj6qXGnfsgYpmw==
X-CSE-MsgGUID: Z0V9xQdzSjeHAwBFCa35/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="262275920"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2026 16:04:47 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v9 net-next 7/8] ice: add Tx reference clock index handling to AN restart command
Date: Fri, 15 May 2026 00:59:45 +0200
Message-Id: <20260514225946.2885623-8-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Restart Auto-Negotiation (AN) AdminQ command with a new
parameter allowing software to specify the Tx reference clock index to
be used during link restart.

This patch:
 - adds REFCLK field definitions to ice_aqc_restart_an
 - updates ice_aq_set_link_restart_an() to take a new refclk parameter
   and properly encode it into the command
 - keeps legacy behavior by passing REFCLK_NOCHANGE where appropriate

This prepares the driver for configurations requiring dynamic selection
of the Tx reference clock as part of the AN flow.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 ++
 drivers/net/ethernet/intel/ice/ice_common.c     | 5 ++++-
 drivers/net/ethernet/intel/ice/ice_common.h     | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c        | 3 ++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 3cbb1b0582e3..42878abac9eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1169,6 +1169,8 @@ struct ice_aqc_restart_an {
 	u8 cmd_flags;
 #define ICE_AQC_RESTART_AN_LINK_RESTART	BIT(1)
 #define ICE_AQC_RESTART_AN_LINK_ENABLE	BIT(2)
+#define ICE_AQC_RESTART_AN_REFCLK_M	GENMASK(4, 3)
+#define ICE_AQC_RESTART_AN_REFCLK_NOCHANGE 0
 	u8 reserved2[13];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b617a6bff891..ee7fa4654fe3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4124,12 +4124,13 @@ int ice_get_link_status(struct ice_port_info *pi, bool *link_up)
  * @pi: pointer to the port information structure
  * @ena_link: if true: enable link, if false: disable link
  * @cd: pointer to command details structure or NULL
+ * @refclk: the new TX reference clock, 0 if no change
  *
  * Sets up the link and restarts the Auto-Negotiation over the link.
  */
 int
 ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
-			   struct ice_sq_cd *cd)
+			   struct ice_sq_cd *cd,  u8 refclk)
 {
 	struct ice_aqc_restart_an *cmd;
 	struct libie_aq_desc desc;
@@ -4145,6 +4146,8 @@ ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
 	else
 		cmd->cmd_flags &= ~ICE_AQC_RESTART_AN_LINK_ENABLE;
 
+	cmd->cmd_flags |= FIELD_PREP(ICE_AQC_RESTART_AN_REFCLK_M, refclk);
+
 	return ice_aq_send_cmd(pi->hw, &desc, NULL, 0, cd);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index e700ac0dc347..9f5344212195 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -215,7 +215,7 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		enum ice_fec_mode fec);
 int
 ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
-			   struct ice_sq_cd *cd);
+			   struct ice_sq_cd *cd, u8 refclk);
 int
 ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, struct ice_sq_cd *cd);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 837b71b7b2b7..8cdc4fda89e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3769,7 +3769,8 @@ int ice_set_link(struct ice_vsi *vsi, bool ena)
 	if (vsi->type != ICE_VSI_PF)
 		return -EINVAL;
 
-	status = ice_aq_set_link_restart_an(pi, ena, NULL);
+	status = ice_aq_set_link_restart_an(pi, ena, NULL,
+					    ICE_AQC_RESTART_AN_REFCLK_NOCHANGE);
 
 	/* if link is owned by manageability, FW will return LIBIE_AQ_RC_EMODE.
 	 * this is not a fatal error, so print a warning message and return
-- 
2.39.3

