Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70C30C632
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194842; cv=none; b=Sk5/HMNea298abosNX2V5BImc8ToyZMhtZ4X9o1FpCq4l5ZGxRZpTm8ZM84+MPR/z4BBYi+T2fjgofNlFTmAlh+BX3bZMTC+m766DFwrE7ZXNOwNe732oNnjvBWNJBncODNe0xeejo4gCMHcTwQFW3QXp1c6Vo6zsEVgkIjaMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194842; c=relaxed/simple;
	bh=HT6+6y8kHjKZwAKXO8d3OVYIhr1SnK+5U5KWva9Y6hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJnTX7NlE7wn2/hMswHuqILp5aH0AXJHiv8VmUELP2sGI1qCzqVSjJSdHLPQgJaFZYxqLflSoE5lbGQuizcMYDU/YEXzkj8bloP5rEeJuUSRqMvapk6BIdNYqX04wOn9dGSyrUegiX/dZ6sctmG9k41dzbUwTlqnQuwx3WFXGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kf+EfEXm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kf+EfEXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194842; x=1806730842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HT6+6y8kHjKZwAKXO8d3OVYIhr1SnK+5U5KWva9Y6hU=;
  b=Kf+EfEXmeAljfrLKgHAkt6dns4O9HGkMYrl/QlpT3/qiPEUDCBmfy3WY
   kxVCK3V4t3noi+T/IJer+KA500bcwK6Z5/UkJGXfqHPuDXXJZQoG6BGpB
   L3a2ixA0t6G3g4eIvhRngT1Yj+jbrCvsLn9lqiWsijurm0M9TEqY/eEHJ
   PvIY6ZT95gryfLAsVRjUt4GdMisL22sBE3XxJk/N3sTFESlv/ONBHD422
   KILIBFDB6Kdh18Ih/SAUkz3zrmTnKz2uPhusJwxYkUqEfI7YAn7XI0Lzh
   1EizFULF6qR+H0AMnRAKNrIIvLgDo0r8/NjJtj/3EPGlEfwVnB78frSvS
   w==;
X-CSE-ConnectionGUID: ZWYvXxadRmeVcZ/GqEsypg==
X-CSE-MsgGUID: PkcGvV3sRhuaQ1Dg/EPhtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981752"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981752"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:41 -0700
X-CSE-ConnectionGUID: Qu7YQQCGT6aSwzqriAdn2A==
X-CSE-MsgGUID: R/t7P284T+yjc6nkPXFTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904942"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:40 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-net 7/10] ice: fix missing 50G single-lane ethtool link speed mappings
Date: Fri,  3 Apr 2026 07:40:25 +0200
Message-ID: <20260403054029.3789616-8-aleksandr.loktionov@intel.com>
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

The ice_adv_lnk_speed_50000[] map is missing the single-lane
50G modes: 50000baseCR_Full, 50000baseKR_Full, 50000baseSR_Full,
and 50000baseLR_ER_FR_Full. When a user tries to advertise one
of these modes the driver prints "Nothing changed, exiting
without setting anything." even on hardware that supports them.
Add the missing entries to fix the mapping.

Fixes: 982b0192db45 ("ice: Refactor finding advertised link speed")
Cc: stable@vger.kernel.org
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 44483bc..0279cc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -389,6 +389,10 @@ static const u32 ice_adv_lnk_speed_50000[] __initconst = {
 	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
 	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
 };
 
 static const u32 ice_adv_lnk_speed_100000[] __initconst = {
-- 
2.52.0

