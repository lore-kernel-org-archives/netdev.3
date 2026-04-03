Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6373359A9B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194844; cv=none; b=cIbRgBsjNGEvk6uyYd4RhQAVEM3vCsv+7RKRxqegmptgIKVS6LKhkn7c7GRYCKf1YB0b9cBNaIX6grLNTcsri7x4c4pbWEELumjGtOLjNGeqEbgoGlQKfep/8uxZiSDuuZ+EbIDEqHyCR6oX+4ooKmjYZZhSKCtE7xPAtt+EWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194844; c=relaxed/simple;
	bh=amU8gMEzIOAMu+w5jaIGX/klL3sd7yHvI6CD1BjVPis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCw+XNm9pbIuejEctnVFiyNARJ0VXnrfgBKpwlsPjsZmACJ1ZBjM2Iv8KBSaKgP+S1rgS6x8gdBxte2IfiHiXD1ZEHE5CP+BdF+QE5bkCcJiPmFXAiYB2Z9SWknNk0jdaGXz/cPRJhew3vpn96BSX1RNd3v30TuOkQTu8OXeibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHNRUxzT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHNRUxzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194843; x=1806730843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amU8gMEzIOAMu+w5jaIGX/klL3sd7yHvI6CD1BjVPis=;
  b=JHNRUxzT1njRfdNwjGrYqzeeQotaKqhTVNsNjdDtBJ3Zn7gYcOLqM9Dq
   REOCDyM7h3v34rppAAbVipayarbokE8UcND1SZNSgYaFzIvyhbqhE70Ll
   2fdgm7g5+iXkHPQMtg9TzWgy68xcctDMGAj2nFzG2PBMwMN4/hDTOY4i5
   WIicke6i1tTTizzIrnFVcKktdDGyyQ89kyG/UXXBjfXB09c2i1xc98KOK
   /twFkrkFL8Z7VYdgP72AoQkUEMc4pq7GC/d1VJMHA2P9EaKH8Dtv8QkjP
   S9Vy+EVXLSQfMFDejuwQjGhOSfDTeAR0ds5bziP4HB487ksi2ToblFYZs
   A==;
X-CSE-ConnectionGUID: 4YtTnh6lSxOoorpZehiEpw==
X-CSE-MsgGUID: VWbtLcsoQgiyu+MU24KvFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981755"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:43 -0700
X-CSE-ConnectionGUID: m8TgYMABSoGuenA535VSWA==
X-CSE-MsgGUID: /Bw9DaiPQIqCQO/B5QhOjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904945"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Yochai Hagvi <yochai.hagvi@intel.com>
Subject: [PATCH iwl-net 8/10] ice: set ETS TLV willing bit in default MIB sent to firmware
Date: Fri,  3 Apr 2026 07:40:26 +0200
Message-ID: <20260403054029.3789616-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the FW LLDP agent is active the driver sends an initial
DCB configuration via set_local_mib. Currently the ETS TLV
willing bit is clear, which prevents LLDP negotiation and
renders the FW LLDP mode non-functional.

Add ICE_IEEE_ETS_IS_WILLING to document intent and use it to
set the willing bit so the FW can negotiate DCB settings with
the peer. This only affects the default configuration; SW LLDP
mode overrides it immediately afterwards.

Fixes: 7d9c9b791f9e ("ice: Implement LFC workaround")
Cc: stable@vger.kernel.org
Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.h  | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.h b/drivers/net/ethernet/intel/ice/ice_dcb.h
index be34650..91d6682 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.h
@@ -52,6 +52,7 @@
 #define ICE_IEEE_ETS_CBS_M		BIT(ICE_IEEE_ETS_CBS_S)
 #define ICE_IEEE_ETS_WILLING_S		7
 #define ICE_IEEE_ETS_WILLING_M		BIT(ICE_IEEE_ETS_WILLING_S)
+#define ICE_IEEE_ETS_IS_WILLING		BIT(ICE_IEEE_ETS_WILLING_S)
 #define ICE_IEEE_ETS_PRIO_0_S		0
 #define ICE_IEEE_ETS_PRIO_0_M		(0x7 << ICE_IEEE_ETS_PRIO_0_S)
 #define ICE_IEEE_ETS_PRIO_1_S		4
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e7308e3..75a48e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -971,7 +971,7 @@ static void ice_set_dflt_mib(struct ice_pf *pf)
 	tlv->ouisubtype = htonl(ouisubtype);
 
 	buf = tlv->tlvinfo;
-	buf[0] = 0;
+	buf[0] = ICE_IEEE_ETS_IS_WILLING;
 
 	/* ETS CFG all UPs map to TC 0. Next 4 (1 - 4) Octets = 0.
 	 * Octets 5 - 12 are BW values, set octet 5 to 100% BW.
-- 
2.52.0

