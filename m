Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F76346AE3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965754; cv=none; b=YT4O7qMQE6AngxVzR4wVsEvvYUbwpAr0p6x47IwrITToPPegb7OKYsHIOm2CJi9Y/Z6i1RhxzxgiQzuV9TweNhRPfy4fqNhgddmZ4fNG6q8gJsYBrVP5qCO7zNE5KfNXwM7KiEzFf/iqRXLQ/EUeEoxgnzEUsnPkRw/BhBrhKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965754; c=relaxed/simple;
	bh=b9RjjPBkTVAZsyYoXtKl+WlFu9H7N9xMiUnXQXIVnsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLqljs52kCiiEKtaEbF+hmNRKvAWyhjyTh9JfHGINRhxUFvO6OdMv+VoND9roHcRMe/jPATv+MuiPWM1ZrHOD1d0Jtdv0xGGebTc67Ddtmo2i+CGI0ZHzZGHlVuamWoku8kd65r0266Ww33qImJXK428Zrh3+QbKpHDzzA/FBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwRXyg4V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwRXyg4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965752; x=1817501752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b9RjjPBkTVAZsyYoXtKl+WlFu9H7N9xMiUnXQXIVnsg=;
  b=WwRXyg4V9FpPTbuqVe+65Bcae0tRzSxAd+psGO124IzNHpln1+KwHSyZ
   6vGiC1e324nvqutqxDXaW1yq3FlNhgDUSzEnpnRp3wF2J5yV5S7RI72bM
   q9pRXUoAMVNhj/RanitObDOpfKMQdE849cVtTBuSS1IPaypguuGts/nQz
   tmFlKrrKVaLGr6hNRYz+0TVP12Qmx9PC4cy1X5Av+DLuU2yOZoZ5SDaC3
   kGu8KDvIAVTpK/dR796/Ym1+/tk9En/IWWSnCEbLWZFGgkv+owz7GvqmK
   oi/fOO2P+W3rOo0BlOOkSyfJyHcsaB/YO+Ca93blz+8czV+sA0MKBb2Rr
   w==;
X-CSE-ConnectionGUID: QwfeMLMgT5WL9fn6QlTC/A==
X-CSE-MsgGUID: xpS/HJ4tTyGcDHGP7L0ubA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343539"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:48 -0700
X-CSE-ConnectionGUID: 7mpKGaR+Tf2wvT2rwhtfYw==
X-CSE-MsgGUID: B5S3VtMWSpmNxAb0U+8PZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576086"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 05/15] ice: add 0x88E7 handling to SW validation paths
Date: Wed,  5 Aug 2026 14:35:30 -0700
Message-ID: <20260805213541.2281287-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The virtchnl v2 VLAN capability handshake now includes the new
VIRTCHNL_VLAN_ETHERTYPE_88E7 flag for IEEE 802.1ah B-TAG support.
Wire up the corresponding software-path handling in ice so the PF
correctly accepts and translates 0x88E7 (ETH_P_8021AH) VLAN filters
requested by VFs.

Three software-only changes, no hardware offload path affected:

 - ice_check_supported_vlan_tpid() (ice_tc_lib.c): accept ETH_P_8021AH
   in the TC VLAN TPID validation switch so 0x88E7-tagged flower filters
   are not rejected early.

 - validate_vlan() (ice_vsi_vlan_lib.c): allow ETH_P_8021AH as a valid
   TPID when adding VLAN filters to a VSI, consistent with the other
   accepted dot1q/dot1ad/QinQ1 TPIDs.

 - ice_vc_validate_vlan_tpid() / ice_vc_get_tpid() (virt/virtchnl.c):
   bidirectional translation between ETH_P_8021AH and
   VIRTCHNL_VLAN_ETHERTYPE_88E7 in the virtchnl VLAN v2 filter path.

This does not add 0x88E7 hardware offload capability, does not change
outer-tag programming, and does not alter any datapath.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c       | 1 +
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 3 ++-
 drivers/net/ethernet/intel/ice/virt/virtchnl.c    | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c04127..4560e55c8f9c 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -174,6 +174,7 @@ static u16 ice_check_supported_vlan_tpid(u16 vlan_tpid)
 	case ETH_P_8021Q:
 	case ETH_P_8021AD:
 	case ETH_P_QINQ1:
+	case ETH_P_8021AH:
 		return vlan_tpid;
 	default:
 		return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 54984966851d..b67272e2f603 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -24,7 +24,8 @@ static void print_invalid_tpid(struct ice_vsi *vsi, u16 tpid)
 static bool validate_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
 {
 	if (vlan->tpid != ETH_P_8021Q && vlan->tpid != ETH_P_8021AD &&
-	    vlan->tpid != ETH_P_QINQ1 && (vlan->tpid || vlan->vid)) {
+	    vlan->tpid != ETH_P_QINQ1 && vlan->tpid != ETH_P_8021AH &&
+	    (vlan->tpid || vlan->vid)) {
 		print_invalid_tpid(vsi, vlan->tpid);
 		return false;
 	}
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index ca8018e3dd42..06d2f9be93ae 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -1702,6 +1702,9 @@ static bool ice_vc_validate_vlan_tpid(u16 filtering_caps, u16 tpid)
 	case ETH_P_QINQ1:
 		vlan_ethertype = VIRTCHNL_VLAN_ETHERTYPE_9100;
 		break;
+	case ETH_P_8021AH:
+		vlan_ethertype = VIRTCHNL_VLAN_ETHERTYPE_88E7;
+		break;
 	}
 
 	if (!(filtering_caps & vlan_ethertype))
@@ -2136,6 +2139,9 @@ static int ice_vc_get_tpid(u32 ethertype_setting, u16 *tpid)
 	case VIRTCHNL_VLAN_ETHERTYPE_9100:
 		*tpid = ETH_P_QINQ1;
 		break;
+	case VIRTCHNL_VLAN_ETHERTYPE_88E7:
+		*tpid = ETH_P_8021AH;
+		break;
 	default:
 		*tpid = 0;
 		return -EINVAL;
-- 
2.47.1

