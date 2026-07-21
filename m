Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3A3859EF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646424; cv=none; b=D1386aoQxeNBM8K+YGYluYLWpLsACqcowRQT/O1tOFSTQ5/cVXfQu3Od4Y45FoDo545/bFX0J5OGh6+JvOr5H5jH384d5HZivy0BLBhyoaSMa2wcwx7Zaaj3ZSX/JxOMtQrE0MQymoW9xvFugHapvayydlS6VWFN0DC0cYc9Fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646424; c=relaxed/simple;
	bh=YMxuhHJhwyQuhdGzdrv1FAUVqYLEZ+YKUP8/Q3R2J1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=payVhNMqJJoclWuVp9weJxWKeZ6DgFZ1C4e1d4iV4gxGQ8Cik7ABEqC6jEFcRMqRUmWUCoyzUZdjiRiY/Yvl99WpqvQArzKFfVZGL4h2Yt8lgGd3pUdZOs4BUvzWjWvXUf/jadtrwo0niNdPTl1F7LoZaYfgCElml2k0IqXXC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b052aZuP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b052aZuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784646422; x=1816182422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YMxuhHJhwyQuhdGzdrv1FAUVqYLEZ+YKUP8/Q3R2J1k=;
  b=b052aZuPnefgkVuSAza+aT8E5VVD585WP+Dnu5JbX4J8049sgoRgaJ0P
   qdVDFjLJJh8lOhDl5EKHY/sbInLjSreQd59tVi1IyKoBboPXlTG83jJS2
   4a+BTeXslmlE4aUSgmDAlyAIFxz8RXqyZCkHmC3+RdHbJetfft/Res8L8
   gFDzZuVgsTwAeXGKJ0oKjV/Rs8ev7AJEk5UeCxuYHXs48gWWh3TkYIFIl
   wuzyUkzx2TAZQkH/nK5NBiy2D8GNdGonlr02DM5xoNEzmTFGgec5qJNCs
   K0YzZ2Rcv0E+2ctlxoYAmXwzg1J8W7pdJGC//nmYxnCwVMqkXLyzos+pw
   A==;
X-CSE-ConnectionGUID: bwPZBQanRqyNBKX6L99QVQ==
X-CSE-MsgGUID: cflepWr6R1uhW+Z7RdWAFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96614445"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96614445"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:07:02 -0700
X-CSE-ConnectionGUID: sx4UNRx2TsS0H+zjOt7NLg==
X-CSE-MsgGUID: HhHrz/g+T7eIs89GwvUQaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="282298686"
Received: from axxiablr1.iind.intel.com (HELO axxiablr1.gar.corp.intel.com) ([10.190.162.100])
  by fmviesa001.fm.intel.com with ESMTP; 21 Jul 2026 08:06:58 -0700
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
Subject: [PATCH v3 net-next] ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
Date: Tue, 21 Jul 2026 20:36:38 +0530
Message-Id: <20260721150638.3084698-1-siddaraju.dh@intel.com>
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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

