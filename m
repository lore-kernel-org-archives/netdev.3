Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B41A00F0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582892; cv=none; b=gTs9zvGN+StUbalZN+BMju34ZfCPr+in3886K3E1q2dSgJhyb2noN+hidlY8BuqQ8c2nJY/lvmutWzBfaivgmPTM2wdBZ9rIIU52HdAwVofMSUYMMLXuoaK/eXDDF8X0UbOx4RtzrxuRzcQC3c3/cLS7q/OqmF5DJtVZVsnS4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582892; c=relaxed/simple;
	bh=ToaY1IjwIXX4dzvjVB9KZQR5bgLLcK6AimfbkfYOhw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzuKNALdQZfQcOw3ggBcEqU482lFIc2iPlJwAsQP2hCBymFeRU0yfTGT7STLpsA8jey2vK5PhklP9mTk5bwGzG4uO6DmFsMpgrJ3zGL1NsxQDGRXXVIeCcd2OjEjtA0fPyeaXG+r0zLYJK15tQUR1L3ZuGVUQDz0PAi3CBtAFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DW9RvVIn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DW9RvVIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772582891; x=1804118891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToaY1IjwIXX4dzvjVB9KZQR5bgLLcK6AimfbkfYOhw0=;
  b=DW9RvVInRIqSAWkCUm3CN+uQOKeKdwK3accUe7BpwQ2yujo6HmMAvC6x
   2R4sd4yhd/vkq2H673LCUgFAimnQKDVlZ+a1G+xTpuAawqm8OIIhY83cC
   tc7Z9QgrycmfVGOj8xmtOmm50SZQl/ww4lozl50wozjEnOfjRqVdsiM2y
   xTtfPAu4R5MrCCx7iRd2WqtgD6/12Qz35VYnJqXg/lgRdIgvddjmVE1I6
   bdY4GN8T0muSPoeVw+MuUys4AS/d3I2TicsHOQmk2cC0sEhwertcvPoGH
   Za3lY/Nrc1N9stvNfjkpijNEkrLUvOl5Anc/5wp+zwITfMTQy+obUxNPZ
   g==;
X-CSE-ConnectionGUID: MfdVsuYGQVyKhK4mYLAFuQ==
X-CSE-MsgGUID: k69bOFtQSrCFa3xaFAEliA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77243040"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77243040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 16:08:08 -0800
X-CSE-ConnectionGUID: 157TUKkITi2hd/e92VoLKQ==
X-CSE-MsgGUID: qxiSI50wQkGWL2zHDbsw6g==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 03 Mar 2026 16:08:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 3/4] i40e: Add missing wordpart.h header
Date: Tue,  3 Mar 2026 16:07:55 -0800
Message-ID: <20260304000800.3536872-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
References: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
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

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

