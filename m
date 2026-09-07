Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8452489888
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781976; cv=none; b=WSmMfNAE0PoXsZKCIIv0qYs7Vi9E7x74VPK0ayYLzPmIaayFix1KYBqIDmdKnmK5x6K37sjzD8etnEhpJdZ9ULJCMFQEh8a1DZt2f7ROcWvWyt+nUwYPjwnfvKFL+8xiMtw1u4AD5dkX5+4bpzfLwfR/f41RO0sN57iIObWWFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781976; c=relaxed/simple;
	bh=40/pWuMmhrmQ327BpTkiE1YZ9HbTMqwKJSk/jESlSqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmdkAMNXt3ahP/7628HvEOXVcx3iXIU74XIOFIf0wZnS3M1U1vjamYoS8tD1f1gIRtz7+drr88bACejoFWBlrwWS8ofQ7fimVvDkEM+ldAcnc5rBQhgoG/IGaPVSJLQaQgLZ+erI38uecutbILi/5M5Nr20K40JZVSdgrebyXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Whg17Uq2; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Whg17Uq2"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 49FEA3F1DD
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788781972;
	bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Whg17Uq2/9WJNAegTGAoRBoMdMxoEFNHFHP81S4ZW7ob1Asyaxd5HMQk3zV7lvAa3
	 zduU+p0BFfnna34vftKjn2hLsKKpJuuWQ0fMgTM/JXQ/PUPAZIdtzCJT4JWMjq2PiK
	 kI+C/+13T+J6xbH5SIs2hnmtKJxzOkT/EkHSEyIdwPKmGPUzTlA4OUFneScWUxyoEm
	 2/LxtbljXV9XRfQEQZfHwE/sntZfCy5iyfprJD8FLHEtUlLerLBqTjVA1Ewh0PlkZb
	 Qlx76N67kta1QVuZ6PGLSt0Th4tAFJ5rX2FDUh3ivl7L4t2CzyliVeM8pC2dNN0WXI
	 ZOWHcfA34tk4eHGDtakUGIS+LNyPV12UgyHGtafgsMCdagFOys8xbjq9x5PxVL0pXZ
	 DvNExD6r9oyeqU3BBy5ZDA9wRfonJTmRWJpxCyDqzwmzVLlAGXCRP91Pnk5GlxktyT
	 RfGnBTBd2b70tJNEx2G5EfV5kgGUK0J0ka6SPdPyZFovTaLwE6B4watCoDpq1wZdto
	 JZbVYFTML8czicUow6m68GQtiWV5M0C0S1+4iELdLUdjBaG2RmV8UyMSkC0LHUlpu9
	 91x1nJzaSxKyiodh3G+cTSQXvlQRq5Xk0rR7QyKWISEl5Zb06ID2G88fDZoUfNQyfD
	 jo1JfMNjENs3kBoCOFf4FQTk=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968dfff779so4922727a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 04:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781971; x=1789386771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f719CSeWdbk3xX0dreB43mfMPTEcjgTdJiglOAe4/WA=;
        b=rE4DzcI/wnTocN/AidXFC6z9A83ksP/v+JpBAofgcWsjBEnGd3tTTrYlQtK3a4IvlU
         Xxgb+ARhGwGP+pr9xfx36GuPXUvc93xLZk/b5JJVgmdpiTn6THs+VtLAQBL7J96VYvmv
         jhF5J46Jq9/geY8cFUaniD6E+Uj25x+8x3xW9HLukXeFNHtnlytQ0gSHSUCG/GWt0Kqk
         izJCBG9zoBupInkmoK1t6CvinDVY9OW7edm8h3tWzp8HGfHC1176PBMRby5wHK+wyzzg
         YMztK7eoyzDd4ES3Df7JRG0feq0RrcsFYzNwbVJEE1rsgbN90pomnsOKZvFdgAFePzK/
         0BIA==
X-Forwarded-Encrypted: i=1; AKwUvBzbPyqaaPT1H+9zVDLwXv7N7b7wgNXpz5bYgKO6Aa5WhR5iam7AOZtBuDL4oz0s2BEUxh/pBPY=@vger.kernel.org
X-Gm-Message-State: AFuF++mCv/1sWrrVx8DcM6PfAUJYkbYEXJ/BXxgedXuxiNihbEzrqWYO
	lAt0wRwRZEe1An23k255Wj+FtGXbdl31uMIMLqSLAxajM2N1ViCvr0BAxDGLiRpN4zUbjPxRa36
	jw6Ljnr1hR4UNyNpyLpX8OH0ih0hOKzN0cjaNf7pN4CghUCkPDnetBOQt1vtcTTjlD7mFZ9Oi+Q
	==
X-Gm-Gg: AYBFou0Rmfvstt85bv2+tL4fr9i63F0wztXOeg5HsPZY+HhbkTbAgoxb/xDimvUuP/b
	/+66WXXZ+nA81ShN03HJN3F88y5t3T423dfaCMeorRBlDxXcjenoV3560LsKmc7Q0uV6ZvVM+8X
	kpNMDyGdZH2f0wel945lI3DH3nTIkuoUP9nu57DxgpuT7LbMFmhtsgqIp0UsAbmtYYmAfduQjvv
	q2AGjoWF+sD6kgpp9hAR5QhyHtIYwDQhpMo1yfD6OF74lBaksdjOjmPMi/WFeCtVX2K4VP4AN1a
	63Aef6vQ3BDqPkWzdIQyas943VgLdBOgYM9Id5eKbfghzAmYC4+c8AQc2zEBtMZXLU4kKL2XpmS
	cmaAnxEF6hUdiNs1/yjGIs+E09gV2KJ5bKYW8smx7Si3NjUub6CNnGkDXoE08/zTvGNCWg0j3CF
	t1IGV2hxxIPBHLM1BXDzGA6BKDDs1+Tys/hfrqGRw=
X-Received: by 2002:a17:90b:5110:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39b8bd4aef3mr422549a91.7.1788781970702;
        Mon, 07 Sep 2026 04:52:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5110:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39b8bd4aef3mr422518a91.7.1788781970233;
        Mon, 07 Sep 2026 04:52:50 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39227sm26922513a91.9.2026.09.07.04.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:52:49 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Henry Tieman <henry.w.tieman@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH v2 2/2] ice: clear Flow Director entries before reset cleanup
Date: Mon,  7 Sep 2026 19:52:21 +0800
Message-ID: <20260907115221.926007-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907115221.926007-1-aaron.ma@canonical.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flow Director profiles retain handles to generic flow entries. Reset calls
ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
handles unchanged until replay replaces them.

If rebuild fails before replay completes, later driver removal follows a
stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
KASAN reports a wild access to list poison from
ice_fdir_erase_flow_from_hw().

The failure is reported as:

  KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
  RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
  ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]

Clear the Flow Director handles while holding hw->fdir_fltr_lock before
the hardware tables free their entries. A successful replay installs new
handles, while a failed rebuild leaves them invalid for later cleanup.

Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v1 -> v2:
- Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
  synchronize with concurrent ethtool filter add/del.

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c4..4739ff882b9ec 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs);
 void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
 void ice_fdir_release_flows(struct ice_hw *hw);
+void ice_fdir_clear_flow_handles(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
 int ice_fdir_create_dflt_rules(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index aceec184e89b2..04510b36aa56b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -428,6 +428,32 @@ void ice_fdir_release_flows(struct ice_hw *hw)
 		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);
 }
 
+/**
+ * ice_fdir_clear_flow_handles - clear handles freed during reset
+ * @hw: pointer to HW instance
+ */
+void ice_fdir_clear_flow_handles(struct ice_hw *hw)
+{
+	int flow;
+
+	if (!hw->fdir_prof)
+		return;
+
+	mutex_lock(&hw->fdir_fltr_lock);
+	for (flow = 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
+		struct ice_fd_hw_prof *prof = hw->fdir_prof[flow];
+		int tun, i;
+
+		if (!prof)
+			continue;
+
+		for (tun = 0; tun < ICE_FD_HW_SEG_MAX; tun++)
+			for (i = 0; i < prof->cnt; i++)
+				prof->entry_h[i][tun] = 0;
+	}
+	mutex_unlock(&hw->fdir_fltr_lock);
+}
+
 /**
  * ice_fdir_replay_flows - replay HW Flow Director filter info
  * @hw: pointer to HW instance
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index abb6e850ec09f..164428ba116a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 		netif_device_detach(vsi->netdev);
 skip:
 
+	if (hw->fdir_prof)
+		ice_fdir_clear_flow_handles(hw);
 	/* clear SW filtering DB */
 	ice_clear_hw_tbls(hw);
 	/* disable the VSIs and their queues that are not already DOWN */
-- 
2.43.0

