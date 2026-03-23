Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BB382396;
	Mon, 23 Mar 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304764; cv=none; b=CL9IvbxEdI8F39HTTWC7uk+zbEfHxesI2E/VyAx2XxG4gZin+liB7VfN1gnT0pNHm+UPCZIRX4da5ELLQH9CbSILOY+24F3QVG7A5YglKPl2ukNhy8Cm3xfkve67cyFb4SHNbYYjmeA26asbJ1eVNx5zlpCWVGR3t+RbepGISsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304764; c=relaxed/simple;
	bh=2MZHnP/9cS14JCDWx6lZ3RRAkM3yTL2R5Dnn1mrIUqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDR+99n6owx0pnsL99FGas3CNBbNmzOdALfrFufCn9+xAER+xc/dIfQi58atH3JgV++fN7doUqBStB5JOXaiAxYfw0CWbDn0gz/UOepUKOryRfrn67yAQ2He2tbhfYIMsEcJ6rm3e4zIfjgh3ea/6B1/iEKZDRAHhKZ5h4j8svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Piy/wuB0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Piy/wuB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774304763; x=1805840763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2MZHnP/9cS14JCDWx6lZ3RRAkM3yTL2R5Dnn1mrIUqo=;
  b=Piy/wuB0EFG0jfZ69LLCz3itF60dK5M56P16zh628J5lpYEG3VCkXL55
   xt7XCxTZ0SoC6V10S2cOAIAryk+vzNM/I46/X2n430oxA2pLMhB95ws4R
   H0vQzU6uLIpy51C7nMB5oxhKlH8R0jVc5FrQmMeyJD2vl5s2KJ+gRq4Yl
   QuM+WXR5B289TcWm3gSNc3e+Ux7zrXdH6XF8dxFE0fFUhu8x42umh8EPS
   ukDAiTEyn1N9ChfZExIHgIAnpMwiP3Gt3Ky18t5Y1D3lYmuj9M0KBDBIi
   imCcIKd6Dvu8KKMWL26SmUGtsbNuh56gdRkQ7zaoIGiIaJHYBVAzJ76kd
   A==;
X-CSE-ConnectionGUID: Rcv7aUz4SwmFr6EIXh+veg==
X-CSE-MsgGUID: qcqspvioTL2yV1Nl/uSz4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221954"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75221954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:26:02 -0700
X-CSE-ConnectionGUID: oNXUv2jLTRCtpXWztQTyVg==
X-CSE-MsgGUID: wKD30q+dTMu1rZv0mZy53w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247207494"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 15:25:58 -0700
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
Subject: [PATCH v3 net-next 7/8] ice: add Tx reference clock index handling to AN restart command
Date: Mon, 23 Mar 2026 23:21:32 +0100
Message-Id: <20260323222133.1796997-8-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
References: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
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
index 859e9c66f3e7..a24a0613d887 100644
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
index ce11fea122d0..de88aec9137c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4126,12 +4126,13 @@ int ice_get_link_status(struct ice_port_info *pi, bool *link_up)
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
@@ -4147,6 +4148,8 @@ ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
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
index 689c6025ea82..c2c7f186bcc7 100644
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

