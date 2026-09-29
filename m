Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210357D207
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721728; cv=none; b=hn6rqbtTJwKo0NFAsp4KxRJs1TLEEi+ZRBQef1UXPlXZ+r6flxVqJnhMRvGoLPg4r1q6wX1QBO3OYOw6dD2ddh7rUvJ1eUUTGTJgiXHQeMM7t7vjLhNT6LRviwRmuPjBOve+FBZ1f+MrT5JEavZ3WBNeCB8MQyQ1LXE47z4bORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721728; c=relaxed/simple;
	bh=7bRZs2ZFjpEX5hQaO45GeL+RMCc0AfusL2HmJKltij4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqo6BN+YCPNytHwOPNietsB1iF/RlM/Oq4rVlZJaOVvB+QUDnYKh4auBF15slAKsok8ATHpo1cIT6UWHh50KOvOugUr2lIuuafnyrwacNTHzdTWFlCmVr664Xwf3Nf4PLCg+yRVII2QO4K4Y9nlgTDWxiSCDYT0v7ThtAhdSS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jW852pDg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jW852pDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721725; x=1822257725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bRZs2ZFjpEX5hQaO45GeL+RMCc0AfusL2HmJKltij4=;
  b=jW852pDg+9dl/cNZlDPxcee8rjZmU3UpH+oDTo9vvFoxrSszA9v6vkoY
   BluQpEEI0BPUz4+jUDpWOA6YrRYrF32bPxNGkY48wh2pUsc8oOqhH9bFy
   AIkJXjnHceJcPGvUeNwXiQd22nN0EpDM9xFSkJgu/+vavxn9rrRoKHhws
   QqpLC02AFoYR7TYgkfLvJYaSzVGUy0zYKQFfs9kVU/QLWRIYtIgYhyzoj
   rXHF6Wu1D94Lmm4u8143qGYo1fa1ick5/9CBCTXJ8hR81KJG5bMhNw9h5
   K2lQVW27Dhs+DR7vB9uc71TmaJoazLt9uYXKI75614MO2hUir2Tb6+O2s
   A==;
X-CSE-ConnectionGUID: BTrpNi5cSceA1NszmeGMTQ==
X-CSE-MsgGUID: PsE+g8mXTF6RKTISimPFSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548864"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: Hspn2jG9Ta6wsm20xekCbA==
X-CSE-MsgGUID: bEqPeR6JTMywS4kF7RtmeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452305"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	przemyslaw.korba@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 03/10] ice: reorder ice_flash_info fields to eliminate padding
Date: Tue, 29 Sep 2026 15:41:43 -0700
Message-ID: <20260929224153.1455466-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_flash_info structure has a u16 sr_words field before a u32
flash_size value. This creates a 2-byte hole as well as 3 bytes of
padding at the end of the structure due to the blank_nvm_mode bitfield.

Re-order the structure to place flash_size first, which gives a better
layout and reduces padding.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f1a80da6239e..b8bdd7e8c768 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -529,8 +529,8 @@ struct ice_flash_info {
 	struct ice_nvm_info nvm;	/* NVM version information */
 	struct ice_netlist_info netlist;/* Netlist version info */
 	struct ice_bank_info banks;	/* Flash Bank information */
-	u16 sr_words;			/* Shadow RAM size in words */
 	u32 flash_size;			/* Size of available flash in bytes */
+	u16 sr_words;			/* Shadow RAM size in words */
 	u8 blank_nvm_mode;		/* is NVM empty (no FW present) */
 };
 
-- 
2.47.1

