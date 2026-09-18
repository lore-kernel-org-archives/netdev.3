Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071D4FD268
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738360; cv=none; b=uArF3KHnJCUa62RWYBeMf9ff7pjCNVtNk/2wNeJgRAKdLcPLJffpXYYSiqhinaCrcHU/zXXdGZWIYMH52eFHxbvaingsI276mAAu/LgSADDmxx7+zFzllaWmg0TA+cKmf0aWFzfsXftuFLEofC7WzWmAV/UL00FRLivjJy9TF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738360; c=relaxed/simple;
	bh=VChwflk0shkuBtKgGE57//Nbv9qLEN/7fd5WM7wrFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVfO3xXH6aBYKjhw0ke56m4L9X5fujdmrl7zaMYVObMOsE/ibaZOSkKu3o4dpFOX/dk5BqWVReujTYphvpCdWQI2WDodiQ2/5Ci718ZHxvg7Eb/2SFBY75adtsy3vxErPnH0uXOs92xPNl1ipRFQi/Lb0WxXu3ZxE6jdPxS26gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVFxNXiA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVFxNXiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738359; x=1821274359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VChwflk0shkuBtKgGE57//Nbv9qLEN/7fd5WM7wrFSc=;
  b=lVFxNXiAHexzwW/biycMOffXUZEjM8o3vcvpcF2qPxrVT9P1Gh5U3tYA
   rcVsl6UR8XqBbKtlJQpOEDTCJaugU5FbDG1VTKUQGyUN17T4Fhu8imIUL
   969lk6SMxWKDWiFC8asLc++hYPty+pekcz0IJIniO55x5N5E1QOQXOHKC
   aZ8sQsXghNlgv7mY8qt19JuIDow1BVmp95xVKtfeLPJVtQviYCOXD3mlh
   pWowyaRmQSti0i0JUykdMtVo2ykg8Ezqo4JVGU+hrxv10D1Zq4ObyFrAS
   IJvPKUSgF0fnk+dqTcgwE+raRn2ZPePv22CXCPOR5xauDG6Bf9d1+roao
   w==;
X-CSE-ConnectionGUID: xk7bmU6kTjqqjAMH7iwEPg==
X-CSE-MsgGUID: KDH5Lk9zTXC+L+AerMeZag==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776411"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776411"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:32:38 -0700
X-CSE-ConnectionGUID: zY1nWEEXRpWb3zN5q2op9Q==
X-CSE-MsgGUID: 2G2F19iuR+OAsedfePvrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835241"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:36 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Tomasz Lichwala <tomasz.lichwala@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 1/3] ice: fix asymmetric pause negotiation reporting in ethtool
Date: Fri, 18 Sep 2026 15:32:32 +0200
Message-ID: <20260918133234.4169074-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Lichwala <tomasz.lichwala@intel.com>

Add Asym_Pause to the supported link modes so that asymmetric pause
negotiation is properly reported via ethtool. Without Asym_Pause in
the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
for asymmetric pause configurations, even when pause is properly
negotiated and functional at the hardware level.

Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index bf9a821..a257b7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2365,8 +2365,9 @@ ice_get_link_ksettings(struct net_device *netdev,
 		break;
 	}
 
-	/* flow control is symmetric and always supported */
+	/* flow control is symmetric or asymmetric and always supported */
 	ethtool_link_ksettings_add_link_mode(ks, supported, Pause);
+	ethtool_link_ksettings_add_link_mode(ks, supported, Asym_Pause);
 
 	caps = kzalloc_obj(*caps);
 	if (!caps)
-- 
2.52.0

