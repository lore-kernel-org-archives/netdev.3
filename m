Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01F4779A7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476935; cv=none; b=En5whuD8JlYe1MIweOVOy3ehbeXiiQVpz82AIhioJcTzZo2gZwzFhjZNlTHbZ58duJN789oAp5P0OS2brBBJ+iGBEeOPbGmmhihbes8miF0ZaA1jxruuxri77vj9v85q+IaKPxA5N4ZqQ0ou/fqzOWf39PTAeXjk8ItrCGVaKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476935; c=relaxed/simple;
	bh=QbXm+JwgBf8365ZN3NtaaxWY/NhmO4xPGoE/XzAJmhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4SOCQIqHO63oxg5vixLp76g3lXfuukP3KS2m7Q3RpkIz/kRfj+nl30j2tUvA5azLvCG1YUcW6jzPR4LaYjcCFCRqhlOxTiL/wtrLC7whJsCIaAnC89kDwM5sYz+vC+Wf4qYt8Me1ED1uF1zcuzCim7xXU5kejdYcs1geSAXUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYZEt3SR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYZEt3SR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476933; x=1821012933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QbXm+JwgBf8365ZN3NtaaxWY/NhmO4xPGoE/XzAJmhI=;
  b=OYZEt3SRHpksGncR+uKwSYRi11Cs+oGgWS4goLIyG889dB4ounEZY8Jz
   qWmWXxzcSeILqPUNIVHOE5Sznr7JqcNEUbDGiyJhmtymR80oPvKEgG4PC
   0hGxyQgHj3YVdqFYsdoOKZMPSiSk0UEEgLlzWNXki3bxyjD2zKlYTI1wS
   OYeahBCg/ReY+6LAjZIredVWn7+aCrm+wxe5Y/WFPjyWOVC1mXbHYezzn
   +QnO7T2IDk3bnGm8nlc4ozbQ70UHXJprgiNvZ1ixHR2OR0uJi0OeffyBu
   QBUNBtUcIHPoi9pkl1uW3PCyFr1W0iM7xviun0jEmadYkjWBIxZx5QT7f
   Q==;
X-CSE-ConnectionGUID: y7cQUnQ4Ta2qfq4Jb3Nm6A==
X-CSE-MsgGUID: 8HIBqzUEQSWuli9l3T/4rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853102"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89853102"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:33 -0700
X-CSE-ConnectionGUID: pTgahotrQbupyL3qGrp0ww==
X-CSE-MsgGUID: mgikFVEPRIeVfRK9SXRZRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225176"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:32 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: [PATCH iwl-net v2 1/3] ice: fix asymmetric pause negotiation reporting in ethtool
Date: Tue, 15 Sep 2026 14:55:27 +0200
Message-ID: <20260915125529.3975723-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
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

