Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDC1A6817
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407400; cv=none; b=mBJD+2ckHD1ovnUKUXmlk3bmwJXcIVsXd6W4e6AOKsyoUqa6ebECFXq2gX8LwRrvEySyYUdfjvTmjAUXJ2pkQgBAYCBmKMcW0CtAChUMLY8UxDUYsF4fzbuYbk/VCbf+6GHkwKYBoXjqhtJn0shmpw3UYniFwCjAyiNdNmM4Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407400; c=relaxed/simple;
	bh=Ft/kcfML2Lvq20vgPFkL9YTpdxCIU+mdWRUQIMyuaGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1rTsYbKjB9U4G3oBO7YOL426MxVYZABG2zRDT4IPCFT4IN7OM3wn6V3FjvjoUpT8e8w+U+ZpenlT9BZrWqQjJHWHemqem8dcFfCuhIa8ObU/5yqkx19BMoPvdL93j0uolMmc4TmLq/pI13JWKlE29xdY1/T+Jw75SBdtOPGrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+XIJVwL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+XIJVwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776407399; x=1807943399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ft/kcfML2Lvq20vgPFkL9YTpdxCIU+mdWRUQIMyuaGs=;
  b=J+XIJVwLy9NI+QJHk9LoLOOGYBXPqS7YeJKBoXotyYXKlkYUNF3zUJ40
   Cq812ksd82E3bTpeLX8cBHppLOSN2tWpkOus1aUF3xp1moo2U66KqSclI
   TgsJNGwI5J/FeEvkjo1BNQedo2AQ9zHAv7AQ3QpzzH0K9L6GE3BS1mMdk
   Eu34Uxx/X5Lpu6rM1DnFI2h3w+G87ftX2tZ9pP7pBk3OnG3SZiqZyJmtu
   /MxjToBG9gHVUETkBFCCatwKKVxtrq9M6TmaN3voLONAijk0EGEbZWzKr
   SuRGWjRnlctBbVo/S8l9jOj5CeddrXfRmMvY5kbfpCChKzW9VjGRjw2T3
   A==;
X-CSE-ConnectionGUID: C/lm8fw3SIyri8plVcE3uw==
X-CSE-MsgGUID: XiazRW83Qm6c/fV14rk8Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94987400"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="94987400"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 23:29:58 -0700
X-CSE-ConnectionGUID: hjiE5TySS0mSobvm8mwu2w==
X-CSE-MsgGUID: nSUJVnO1Qt2511GUbNuZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235329565"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 23:29:57 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: [PATCH iwl-net 1/4] ice: fix asymmetric pause negotiation reporting in ethtool
Date: Fri, 17 Apr 2026 08:29:51 +0200
Message-ID: <20260417062954.1241900-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
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
index e6a20af..30d2550 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2373,8 +2373,9 @@ ice_get_link_ksettings(struct net_device *netdev,
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

