Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE5284880
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548641; cv=none; b=eOFD2p0stuj/9xOzr/54BbOZgkMNMxWyEmpKBc3JVvcJ2d1XMDI6abVMtgNQcP5V0MJ5pQ037r4C90vrVrYUUyGbVGuNd4c+3CzmkMJ9rG9AyabOD/X2ZzdOlA5DtjsNmGq6VbHk7Ov/yGlmWMzxS+CHwajgSnu6hVbKQHiaRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548641; c=relaxed/simple;
	bh=M68xv6HlU6/MqcTSfEZ0+bgus933krCLokA4of/Bqpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aUHxwqpo6kqiZJ0pHz4GXoyHaqfWKZ9oMbY7OSjD2Loe+rFB+E+6c+E+i9xwIkVMcoEqfoT8frgcZsvmHf4V33D2ic2qui8OGIqUiom0aOSjzznGqLqkvt+6GE+8/FNTeOPU2psUmhjjercXOOcDGygYnfAiobX3wo1m0c77Ygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyUScxTm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyUScxTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790548638; x=1822084638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M68xv6HlU6/MqcTSfEZ0+bgus933krCLokA4of/Bqpc=;
  b=gyUScxTmmVlqnYFHcw2gwmEV209+Ur6o2fLIqCiOh4ijzx/DraQRqQ+J
   iGpIVFNKOBcRQcXOkKKJgXeFuoqL4BRsFBAldBGvIMeSbbi2GFhYnq8kV
   EmsSwqDCU4Lg9b2ITmn9PsWDZGCYGQjuyvE7LLvdqBndHLB//H2Qdlqgn
   hf06tuPMthxbPvWDmFoTj56vnglPbmM009oiQFfK5/n0ruWR3M/+Udd+l
   LNrO1X+9iYwSAXvPD1ePyhC/3YTfzimymtEifP3CmJ4fiM5nSR3DWwrqL
   f8V85PL54hEAx04FVXnV0p/ty1FJVDMKeIst1Enz4TGXvZBMez56yTcpI
   A==;
X-CSE-ConnectionGUID: McpUC+3pTG2A9LFFYNF8dA==
X-CSE-MsgGUID: Lytyzc1NSN+MLSvdssFNKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="102617780"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="102617780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 15:37:16 -0700
X-CSE-ConnectionGUID: Azm/W2qtTaGxL3vm4UbXUw==
X-CSE-MsgGUID: oBsaebCIRHuCXP2YOcFVrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="271365760"
Received: from unknown (HELO axxiablr1.gar.corp.intel.com) ([10.190.162.100])
  by fmviesa009.fm.intel.com with ESMTP; 27 Sep 2026 15:37:10 -0700
From: Siddaraju DH <siddaraju.dh@intel.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>
Cc: Siddaraju DH <siddaraju.dh@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Shubham Das <shubham.das@intel.com>,
	Susheela M Doddagoudar <susheela.m.doddagoudar@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob E Keller <jacob.e.keller@intel.com>,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Anjali Singhai <singhai.anjali55@gmail.com>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	David Laight <david.laight.linux@gmail.com>,
	Eric Joyner <eric.joyner@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next] net: ethtool: add BaseC2C medium & AUI C2C link modes
Date: Mon, 28 Sep 2026 04:06:56 +0530
Message-Id: <20260927223656.2528362-1-siddaraju.dh@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IEEE 802.3 defines a family of chip-to-chip (C2C) Attachment Unit
Interfaces (AUI) and SFF-8418 defines the 10 Gb/s SFI equivalent. These
are electrical interfaces between two ICs on the same board, with a
fully specified lane count, signalling rate and modulation.

Add a new BaseC2C link medium (ETHTOOL_LINK_MEDIUM_BASEC2C) and the
following C2C link modes, that will use the BaseC2C medium:

==========================================================
Link mode            Interface    #Lane  Specification
==========================================================
          10Gb/s per lane (NRZ, 10.3125 GBd)
10000baseC2C/Full    10G SFI C2C    1    SFF-8418

          25Gb/s per lane (NRZ, 25.78125 GBd)
25000baseC2C/Full    25GAUI C2C     1    IEEE 802.3-2018 Annex 109A
50000baseC2C2/Full   LAUI-2 C2C     2    IEEE 802.3-2022 Annex 135B
100000baseC2C4/Full  CAUI-4 C2C     4    IEEE 802.3-2018 Annex 83D

          50Gb/s per lane (PAM4, 26.5625 GBd)
50000baseC2C/Full    50GAUI-1 C2C   1    IEEE 802.3-2022 Annex 135F
100000baseC2C2/Full  100GAUI-2 C2C  2    IEEE 802.3-2022 Annex 135F
200000baseC2C4/Full  200GAUI-4 C2C  4    IEEE 802.3-2022 Annex 120D

          100Gb/s per lane (PAM4, 53.125 GBd)
100000baseC2C/Full   100GAUI-1 C2C  1    IEEE 802.3ck Annex 120F
200000baseC2C2/Full  200GAUI-2 C2C  2    IEEE 802.3ck Annex 120F
400000baseC2C4/Full  400GAUI-4 C2C  4    IEEE 802.3ck Annex 120F

All new modes will use the BaseC2C medium.

Link: https://lore.kernel.org/netdev/SN7PR11MB6900FFD91358B67F27D981A19ACC2@SN7PR11MB6900.namprd11.prod.outlook.com/T/#u
Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
---

 include/linux/ethtool.h      |  1 +
 include/uapi/linux/ethtool.h | 11 +++++++++++
 net/ethtool/common.c         | 24 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c4c9ce0..4c9dac8 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -247,6 +247,7 @@ enum ethtool_link_medium {
 	ETHTOOL_LINK_MEDIUM_BASEF,
 	ETHTOOL_LINK_MEDIUM_BASEV,
 	ETHTOOL_LINK_MEDIUM_BASEMLD,
+	ETHTOOL_LINK_MEDIUM_BASEC2C,
 	ETHTOOL_LINK_MEDIUM_NONE,
 
 	__ETHTOOL_LINK_MEDIUM_LAST,
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 986d70c..8cc956e 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2103,6 +2103,17 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
 	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
 	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
+	/* Chip-to-chip Attachment Unit Interfaces (AUI C2C) */
+	ETHTOOL_LINK_MODE_10000baseC2C_Full_BIT		 = 125, /* 10G-SFI-C2C SFF-8418 */
+	ETHTOOL_LINK_MODE_25000baseC2C_Full_BIT		 = 126,
+	ETHTOOL_LINK_MODE_50000baseC2C2_Full_BIT	 = 127,
+	ETHTOOL_LINK_MODE_100000baseC2C4_Full_BIT	 = 128,
+	ETHTOOL_LINK_MODE_50000baseC2C_Full_BIT		 = 129,
+	ETHTOOL_LINK_MODE_100000baseC2C2_Full_BIT	 = 130,
+	ETHTOOL_LINK_MODE_200000baseC2C4_Full_BIT	 = 131,
+	ETHTOOL_LINK_MODE_100000baseC2C_Full_BIT	 = 132,
+	ETHTOOL_LINK_MODE_200000baseC2C2_Full_BIT	 = 133,
+	ETHTOOL_LINK_MODE_400000baseC2C4_Full_BIT	 = 134,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index b4e766e..96350db 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -242,6 +242,16 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(1600000, KR8, Full),
 	__DEFINE_LINK_MODE_NAME(1600000, DR8, Full),
 	__DEFINE_LINK_MODE_NAME(1600000, DR8_2, Full),
+	__DEFINE_LINK_MODE_NAME(10000, C2C, Full),
+	__DEFINE_LINK_MODE_NAME(25000, C2C, Full),
+	__DEFINE_LINK_MODE_NAME(50000, C2C2, Full),
+	__DEFINE_LINK_MODE_NAME(100000, C2C4, Full),
+	__DEFINE_LINK_MODE_NAME(50000, C2C, Full),
+	__DEFINE_LINK_MODE_NAME(100000, C2C2, Full),
+	__DEFINE_LINK_MODE_NAME(200000, C2C4, Full),
+	__DEFINE_LINK_MODE_NAME(100000, C2C, Full),
+	__DEFINE_LINK_MODE_NAME(200000, C2C2, Full),
+	__DEFINE_LINK_MODE_NAME(400000, C2C4, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -289,6 +299,9 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_VR8		8
 #define __LINK_MODE_LANES_DR8_2		8
 #define __LINK_MODE_LANES_T1BRR		1
+#define __LINK_MODE_LANES_C2C		1
+#define __LINK_MODE_LANES_C2C2		2
+#define __LINK_MODE_LANES_C2C4		4
 
 #define __DEFINE_LINK_MODE_PARAMS_PAIRS(_speed, _type, _min_pairs, _pairs, _duplex, _medium) \
 	[ETHTOOL_LINK_MODE(_speed, _type, _duplex)] = {		\
@@ -469,6 +482,16 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(1600000, KR8, Full, K),
 	__DEFINE_LINK_MODE_PARAMS(1600000, DR8, Full, D),
 	__DEFINE_LINK_MODE_PARAMS(1600000, DR8_2, Full, D),
+	__DEFINE_LINK_MODE_PARAMS(10000, C2C, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(25000, C2C, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(50000, C2C2, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(100000, C2C4, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(50000, C2C, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(100000, C2C2, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(200000, C2C4, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(100000, C2C, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(200000, C2C2, Full, C2C),
+	__DEFINE_LINK_MODE_PARAMS(400000, C2C4, Full, C2C),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 EXPORT_SYMBOL_GPL(link_mode_params);
@@ -484,6 +507,7 @@ static const char ethtool_link_medium_names[][ETH_GSTRING_LEN] = {
 	[ETHTOOL_LINK_MEDIUM_BASEF] = "BaseF",
 	[ETHTOOL_LINK_MEDIUM_BASEV] = "BaseV",
 	[ETHTOOL_LINK_MEDIUM_BASEMLD] = "BaseMLD",
+	[ETHTOOL_LINK_MEDIUM_BASEC2C] = "BaseC2C",
 	[ETHTOOL_LINK_MEDIUM_NONE] = "None",
 };
 static_assert(ARRAY_SIZE(ethtool_link_medium_names) == __ETHTOOL_LINK_MEDIUM_LAST);
-- 
2.25.1

