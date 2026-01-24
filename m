Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC281A945;
	Sat, 24 Jan 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216207; cv=none; b=rYdnXX+ziUNaSlRP7R0E8XYXuED6qnQH3Ri1Hig6+TuTUy81Yd6MFfHl5ViQ4kOIdamkrqmAt6xRYePFXeOSe/TZRvlQ4ceL64qWAAFPOLWC7yLznw0EPrK5eBjDWaPMvaYDj1rZkBbQH1ukbSkwtjULwWhxMcq1oCvetshpDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216207; c=relaxed/simple;
	bh=tjwDfVUOCv7OweMTrTAC/NmQxTm0fJ23jK+CFiLTyI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz5wA3ATCFUtCguj0kIB/yC+q9roda2y/uj4n89fP3c8ty5baSe+hJm4mqOYSwGJwoRCn64ibP2OYXkCtjQPqieB/46lwh7WnzvBYe+ucm4pmOR/SJ26jGFXs+62ZXtGKSF6EhSlDijis+mpZwnGc25JZlofmloYaPLUtBf4kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GibuF+cw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GibuF+cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769216206; x=1800752206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tjwDfVUOCv7OweMTrTAC/NmQxTm0fJ23jK+CFiLTyI4=;
  b=GibuF+cwbOIUMFvfZv9MCVxy8ql7w5Gw8IXAYYU5JQJPRHbIkzQx+tMZ
   sLAGPcYea+VyVNlWTulHgVS6YJDzeF7HauykUyT0G3GQAME3gKpdw9cgl
   5xcCbI5sqSRNlu1yzpXH3stqMpeWxMiselcdFFOyyD41Qr6cSiCeJQamT
   XbyXLYpRMqf46PeQd0Ymft0VMUksGhRO4KGKiMj50TLVy1QBIzFIGinXC
   zTraCCf5iE1OyG6fA4nisBgHGrb6ocFYzP139kWzrzxPGEnji20Wu43E8
   +GYw8hsoeQBkDKwNiGHVMRdw7bO5qlVYK/jZ9ekeajjoCkUhpy997B/9B
   g==;
X-CSE-ConnectionGUID: xoO76KYKQXuEJ/WEUZ1Mfg==
X-CSE-MsgGUID: +/pMsyM6TYacmK+0fbCoDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81584997"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81584997"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 16:56:46 -0800
X-CSE-ConnectionGUID: twLP+ktBTQCGufqTGUO+jw==
X-CSE-MsgGUID: gzGievpnQ2ejZLrJO/1Erw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="237815430"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 23 Jan 2026 16:56:43 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0955195; Sat, 24 Jan 2026 01:56:42 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] i40e: Add missing header
Date: Sat, 24 Jan 2026 01:56:39 +0100
Message-ID: <20260124005639.3175766-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cleaning up another header I have met this build error:

drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
  105 |         val1 = (u32)(upper_32_bits(pa));                                \

This is due to missing header, add it to fix the possible issue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.50.1

