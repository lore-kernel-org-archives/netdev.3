Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB23909B9
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421656; cv=none; b=L5i1bNCEDn7eJ5d+qe3ZWz5EQhrqwU5Olp2X7d2h5gY9Il9Ph/z23I4H5I56Zwi7cq6EXAlzBvM+Ifwp1A9nbwRsbCNnMbCnaJiLR54wcnLRAqEjMv0RfQjM/g5JgFuYLnG3UBvB+B8QMMELQQqFAgJIB90dqZBLOHVSAwiwx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421656; c=relaxed/simple;
	bh=WSoJwlIhdcVAUExJcWDP3T0G3Ur8i8N17uAVaL3cxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOP2Uy7vhIomeupZTxjSpIPw7fZHcpsRgoTtO2Vkse6aCXDiaZtRSjWP0/yjh2h5+pQRmxiUSyrUEq18YVZzUls127Eo/PAYiAIXeBFvs2r1YFUOliDNjBq0z57f9/zRQw86uICKzv4ifSrqX0XirCwp95QeMln39hLe3DrLLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LXwRqazc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="LXwRqazc"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 25FD744B9B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788421653;
	bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=LXwRqazc2lQwPP2vH5bo0Q3sPj2vvqAd8xz8y0DH9m/8MxB1wPXD5vXkt2u7+tmVG
	 82keE0XeAOKGewLSDRxUFboJTkLIzKDQq+rWtkozelFg0neGVFjnSB5eR7Khx3VvKW
	 XhKn6cRUJ6iBaTyl+a2DfOyybvouuOUAcDmU+MxNNeHO2R6TxbkxI1NbnjnlJBHrWz
	 XKwWsZrqwgUTuvBZSYKZRMFFCyOceFDbhtvvVuBLar8HXQ3Z8YYR/+C+pz9WjPFxFw
	 qqXyyWK8/RcVwKwKy8A0st7esZ4KhLIvOxhacg/6A/Wa12E0kC1rJMZiUA8QcM54Ld
	 bzznJL506n1wTiXiAmQQseqZsBOYQ6j3p6jjEPS/8fN6Dgtbbqgf4AKELKZXEKejmj
	 tsOhWnHFoRXaXYQJcmD1/CxgkLUF9FrnNTozyEbu55CSCT2KHaO4jT6rUjeDWix0ed
	 dH/BJ7rXOcAFZiv0oJ9qijTzwgNAnObzPonwl6U26aTBEEntwhgHPwmylEo6DQU4is
	 +UdqH2iHYLj+FxOI3XW29qZfVmKzfTKJ/41hLnJCBKKINGdC5lchZxSTdlCtC5Ayb+
	 96TqV1Iby9WvWrI4AGZSQEvgGuDis+R7MeRkT7niMKel/Ant5IBJg2RYYLsyA2tDTZ
	 fPOgwgjLXz6XGNK27qV2veqI=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-399311947f6so3698806a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421651; x=1789026451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5nc9gEzX4k4ArZqgbiRbJBtB4XzQnqrHMx6w0QnIx1U=;
        b=YFCozMnNKuOTt0KaSLKGA8OnD3TtxcS7R2e6olM3Pm+UbmUBE3174FkP6vFHkU7ozS
         wfXjpjmgPbG4P0EJTv871Nlsy8RBBHLndS+nXWPMvbEShq0tEEGsTbMW7WSvhYlmGeOy
         AaWhGUuanP1GVAMp3uNO9laTPQxH51FRNE5eII6zp6n8nj7lpNglC5W2tdoMeFoH00/5
         fEIOkj4k1xJ1jpCLEaWB0ukDtebheDbmuLHmU7Gk6JdXrUZEr0/ICyka8S+A/+FZorGQ
         yUFgiTYSdCgp7QJT3RYfEHX4jhcczO71HN+VuFAKpgm6yHs94kXsUGefDrX2bFxdD/Uy
         99pw==
X-Forwarded-Encrypted: i=1; AKwUvBxAOVJiCPERiSAMMM5LEVHF0xnnX90IyzBwn2xiH5mNSJF3lRhLawDJ/uNFng+8DvFw5ouKq9s=@vger.kernel.org
X-Gm-Message-State: AFuF++kjkaUOz7dHKMEZXVhAI1E/S63fbanV9UamrTV9lBi+QXv/v8qr
	Rs1oDDW9efpcyi+4bczT9i489RS4E2/6WhDK0xNIswkdo2wvXMM7d3VJm7fWAZAu0XjOOCVYhCG
	9JU9IBqGzGfauYdInAGfiOvZQJw3l7psQaOqu7KuMifLoEAqFZz6ogyZd37diPzxjLtnn89rzKQ
	==
X-Gm-Gg: AYBFou0h0dTSrTEgFtfM5hrbFQvgph9hYcUSzU6TozUD4rowzGUcTqEL+Nkwi0tzFpt
	SylSTkAkQayRmkaQ1ClaCBCdE2TGL31PG5hhE9MmlHNHExZtT+LquZrFFAZF08P2/k7Dmpm8G4A
	hWb7mpBhzQe9mrAky7Dxls8oJNJCU3IQbWjkype7Qob3+pqVl5/Fz5IzVoSX/kMaGW7arXyo/1P
	2+XM0DpyDlRuJygHgg9wkCLp+ISmcYoQzgVXseCeDfWw7WDDh8+vVgtcwXzeMOGet86VNKUka3j
	lSU8jMH1Q1klZIGxjp0I1fVkaDKxrEU43+ebHoVHDi/atfnbAb7Y3TOTVCDOuzPPGgwd+Dr5sL/
	e1yFmknqUurL11bggt2ZNJhXXF/aAFXy8P5vB04a46l10jTAqExuAMudo+c6D1swJMocLbh6IM8
	gmbKgyjuvihCqlBx1zUYLy7+QwR5Icue3g3D8/DA==
X-Received: by 2002:a17:90a:ec8c:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-39aee04ace5mr17634618a91.16.1788421651491;
        Thu, 03 Sep 2026 00:47:31 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-39aee04ace5mr17634557a91.16.1788421651053;
        Thu, 03 Sep 2026 00:47:31 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae62a54f6sm2991223a91.1.2026.09.03.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:47:30 -0700 (PDT)
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
Subject: [PATCH 2/2] ice: clear Flow Director entries before reset cleanup
Date: Thu,  3 Sep 2026 15:47:06 +0800
Message-ID: <20260903074706.602087-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903074706.602087-1-aaron.ma@canonical.com>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
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

Clear the Flow Director handles before the hardware tables free their
entries. A successful replay installs new handles, while a failed rebuild
leaves them invalid for later cleanup.

Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 21 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
 3 files changed, 24 insertions(+)

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
index aceec184e89b2..faa16b5a12c0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -428,6 +428,27 @@ void ice_fdir_release_flows(struct ice_hw *hw)
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
+}
+
 /**
  * ice_fdir_replay_flows - replay HW Flow Director filter info
  * @hw: pointer to HW instance
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a97a1941cec6a..7aa1235447310 100644
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

