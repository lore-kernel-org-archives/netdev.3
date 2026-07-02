Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC88381E99
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004020; cv=none; b=r/YHEUuvik7fBhqN9Wjz0C7nyD2nJysesHxHsEH/s+BBbER8W9ZdAhgXxEMX0sK/EBk6Sy1uE4lLCIQho/oNyG+xIfG7uh189dJMwgQuxhyxyNlF/LkCkJ/T1pmhcvg4bllAExI8YfJZN2c/tsW+be56m0RqM+JqOG9I6HA6y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004020; c=relaxed/simple;
	bh=hXxEauG5BZGJdya1zFQS99RKMHpc8yojTtxoCHfr6jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AbjcR+QELNQT1RnZABZ41HrbwzhjYuqDsIOVjZdn8YQFy35+StgsnqP+SOVGxjtm/ltS6XvDat06MymtV9SP6tv7oA3L+2bzDchiDUInqXJIoQ7VP++fqfMgisMyB3MY8wDO7POR+hpJS11qvIy6Ur/jz0yg4XmFit7Z/3xJLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iyp3y6Cz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iyp3y6Cz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783004019; x=1814540019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hXxEauG5BZGJdya1zFQS99RKMHpc8yojTtxoCHfr6jg=;
  b=Iyp3y6CzkXPK0cxabbump2EDRoWFIumHC3X3uzw5B19BkmQxasmwSbVM
   63l3aBZONtz4gBLuPhRKBo8leWIbqhIW9z6FPgFxP+P4Ya35OFR6LQDRa
   nJWYWxuHQdNGgqvY1hvnxlTr4XpnyO/FNpcNjWtHc5/VOy2iVUWSntxYR
   ex/3ghNUchU2m5G6TZZ+aTH1achtFFzeL4T2M85G4jSnx/peQtA4ZTbg7
   ttuYeCz3YREFTDHVfd4e1DvcfrXJb8qYYBgH9G18Gt0LtqyqUK/MCnCHK
   LM47/k8RYByO+5hqeTrxJIRhWGN4X2l4CbmE/JSJqILdvxAzrv9j2Lu+D
   g==;
X-CSE-ConnectionGUID: EMDS4fbqQ+W7HZQKHF4SZw==
X-CSE-MsgGUID: ZOIx5MC8RPWolFFiAUT1ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83537879"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="83537879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:53:39 -0700
X-CSE-ConnectionGUID: xO+iR3LQSMK/ayqJWuPrxQ==
X-CSE-MsgGUID: Qps4nFcIRiiiqgaWW9zZ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="251160904"
Received: from axxiablr1.iind.intel.com (HELO axxiablr1.gar.corp.intel.com) ([10.190.162.100])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2026 07:53:35 -0700
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
Subject: [PATCH net-next] ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
Date: Thu,  2 Jul 2026 20:23:26 +0530
Message-Id: <20260702145326.1024800-1-siddaraju.dh@intel.com>
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

This change follows the conversation from netdev mail thread with
subject: "the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?"

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

