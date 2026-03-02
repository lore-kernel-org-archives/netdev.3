Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5633F392
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494873; cv=none; b=K1o0efB8DvzjbxtYf9N1eZsg/sJl2RBZKGX8GNyoRFbtTHgm0e0fJTP68HXXCHjGngBzkabVnvblm84zRwHtQOyb5YgueJiDCCvb5HxKTslYWXkTHwqEqLLaP5Y4s4VPtK9ZjkJ91KpG7dwO9K5hhXznql6mRgVDQDNd4GNxbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494873; c=relaxed/simple;
	bh=ytepuY22OlVNr54CCrS/0+EiaVWmLBEpbKURMQi7258=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQbPPpdoan9v7Kg21eGCPpaHlu8ghVbqwLkpa+3S7ZFR9ota5c81nvrH5o2ZzVaSOgOT5yzBsGKWwEuQv0+RQVZt75iipmU1wZDZRYBO8xLPP4pSvy2aYwZ2VFOCW0xdYbMPy5TdVpTX29rYfnnGIu8y60Mv+xgNeX54bC8BGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/LRcWtr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/LRcWtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772494872; x=1804030872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytepuY22OlVNr54CCrS/0+EiaVWmLBEpbKURMQi7258=;
  b=N/LRcWtrnLVpr8kRjgbj3PLjFltVgdtWAUEb5ZjgFPxjcCOpSkRjYTbl
   T5hRbLasULUSaxXlhx6lwc0ZF1aSC75yvAAIrVB8okhF0kLDaoE9BX+lI
   xqJAV7CDoxfJF4nRqby+3VaZgG7jMhM2aD6t9UU1veHUVw9WSy2i+XeQ2
   HVtph8lATKESYWOvBH6XqDkZ6jEPieVvDor0X9SrwXUdoXqCCs+4n+AN3
   XFK5nldpjYqOHqhd1kCSjcHJsp4gesvwS0tlJtT/Xs85Tr7G/CFREvztR
   uLbFg7YYQjIF1s6ZJ75RoqXMX93XnI6gEmUlfNPwO0iYG+U1Nd5gXZwmw
   w==;
X-CSE-ConnectionGUID: MKmTkPcHTTu9ZV4qsYoAMQ==
X-CSE-MsgGUID: sNLTGKS1RaCpEoie6cQ2bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73585745"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73585745"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 15:41:10 -0800
X-CSE-ConnectionGUID: OXKL0OS7SIGrsefozWOmEQ==
X-CSE-MsgGUID: N43PK24xRLW+r0VYLWnJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="216233672"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 02 Mar 2026 15:41:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 3/4] i40e: Add missing header
Date: Mon,  2 Mar 2026 15:41:01 -0800
Message-ID: <20260302234105.2658400-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
References: <20260302234105.2658400-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 480e3a883cc7..967711405919 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include <linux/wordpart.h>
+
 #include "i40e_alloc.h"
 #include "i40e_io.h"
 #include "i40e_register.h"
-- 
2.47.1

