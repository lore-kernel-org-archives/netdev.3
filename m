Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94630357CF3
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073149; cv=none; b=tKmDTTiQmcT6Xyu+1RWDT0Q87EHx5Lf1LiHTDbkyrXel53bSbqd4GaTrERAUqr1HU592vNUb1qzu3WkWKM1HbHMKKkiSfPjghcWuHBRvlfifEOF6vrvq1uJid4OEuu5YK2TETMNs4bFM59PwaibkXdXhmJUXiqANAoKwNDQ/xkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073149; c=relaxed/simple;
	bh=4zjIJdFMFRWzwIR7XjnRYjmbK8Pf6eqzs1NjHUPYXX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CGffNzUMrwBRR1i/nLetRWaIN2PWYGQaje//yX5ufJDvPu5/pfuLa+3IH8Mx+HEIeHT29JNTptA886vLBi0lsVX5+9Lg9SEHqsXYxPTqjDpgNuxkUdIVTbVMuAf+AuXtqEKa9kb2xmDyCjvBrt3rD1tNHK7QD1KuupKOk8xCzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWGp9E1q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWGp9E1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783073148; x=1814609148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4zjIJdFMFRWzwIR7XjnRYjmbK8Pf6eqzs1NjHUPYXX0=;
  b=jWGp9E1qqzQsaMs/yZ7iqQEEo/nMx5TYFpk1lBecwrPpbX62+RYW0qFI
   pPkrFowBGc8E56iSYS7+qs6K2A9ZRbeflNnxkP63lIH04T1MXGjHwD8/2
   +YvkJa6s7CliRWIDHV11C0qFc0zP91lu7Z/FYNK32FKjKrcKDvdAUDDuJ
   n3dU4lmPcOEfOWJ7RYNBcS753pd2GqIsp+xAcOnIWMQ4hHNaacdHL3NJ3
   HbNtUiBo9Vb8dhMoPiAVSlxSyGcu0r79gD02r1dEsIf93j/5fV2GHkLLk
   sOPneJ2qG8B8GlOcGY7pHSpRMOtoaVwyOgH5inJJsRBSIJoBJJnQjyITo
   w==;
X-CSE-ConnectionGUID: htkKHXy7RW+keHa47JMaGw==
X-CSE-MsgGUID: tx3ebwTIThKNaaIZdhZzug==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87740037"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87740037"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 03:05:48 -0700
X-CSE-ConnectionGUID: xg8xJ0AqR62I2TOSbR4/Tw==
X-CSE-MsgGUID: td/1NGd0Tc6UaVqWWCl5Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="254996468"
Received: from axxiablr1.iind.intel.com (HELO axxiablr1.gar.corp.intel.com) ([10.190.162.100])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2026 03:05:43 -0700
From: Siddaraju DH <siddaraju.dh@intel.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: Shubham Das <Shubham.Das@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>,
	Siddaraju DH <siddaraju.dh@intel.com>
Subject: [PATCH v2 net-next] ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
Date: Fri,  3 Jul 2026 15:35:37 +0530
Message-Id: <20260703100537.1109838-1-siddaraju.dh@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comment to clarify the physical media 10000baseCR follows.

10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
It has no autonegotiation, no link training, and no mandatory FEC.
The industry standard for this media type is SFF-8431 Appendix-E
Direct Attach cable, also known as 10G_SFI_DA.

Link: https://lore.kernel.org/r/SN7PR11MB69003D33489DB1D6B17EF72A9AF52@SN7PR11MB6900.namprd11.prod.outlook.com

Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
---
 include/uapi/linux/ethtool.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index a2091d4e00f3..986d70caec33 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2013,7 +2013,13 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT	= 39,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT		= 40,
 	ETHTOOL_LINK_MODE_1000baseX_Full_BIT	= 41,
+
+	/* Despite the "baseCR" in 10000baseCR, this is not an IEEE 802.3 baseCR
+	 * It represents SFF-8431 Appendix-E SFP+ Direct Attach (10G-SFI-DA).
+	 * The name is kept as-is for uAPI backward compatibility.
+	 */
 	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT	= 42,
+
 	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT	= 43,
 	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT	= 44,
 	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT	= 45,
-- 
2.25.1

