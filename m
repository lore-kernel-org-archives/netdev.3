Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72033066E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065441; cv=none; b=PIsF4ezyTuhS3/cQUHDCw1+FUV3dsXXByL7XEvXUJGCrtcPWOTN2UVzQ+jiNx09tCK8SnEFTzpBG1mSu/pwt+QiZ4j0CYkTYhltpP5yfHBWDh0BvUH9DA5xDERLZfLC572hjEd6sacI2lmFP0iDDEc3WQ7aGVza3g6Q1uchLjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065441; c=relaxed/simple;
	bh=o4EwR0Xo5xKCLDvZvQXhj/2eep7F0Czko5HtN8yB3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMibQbQ9HtmPBvBkcxqoy118Y2axI64GQPiMCSeMMEtnEw4bfoJObNJgfTMK47UlL/6+59EWWHN0IWEuGdxu3vuxlhzgBYzUZ0fJd/OOLolsB3J29aCmMslVaDxwEdFQhxdxDOF6LeVHLAG/As9OAk/sArTmFqZpJrVyy5l8AFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgLPUN+W; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgLPUN+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776065439; x=1807601439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o4EwR0Xo5xKCLDvZvQXhj/2eep7F0Czko5HtN8yB3qA=;
  b=hgLPUN+WO727wlgU8lHf6JNwuq5iB478JVsVzvg68mkX2YPBL4eoPKo/
   /chKgw5llhW0qyJ8V0JRum8TDls4iIYjNx8h4rrToXtFuj+FnQ69DItaN
   8sZfw8zXjf/j8/S9BmsjnRVREyEtL4pypsao6YrbG5PmHF8mLPHaO/vQV
   EMotkCvAV1QvslcXHVcImxoKEw5MEzWnohNQ1Y+4jti9MeDxXy35kD8p2
   IbEIhakg2T2vI7wg2a52OI7qyJSiZ1wcogGKeX/hwWpGtpbx/bU5aA6+N
   zQIWV00zqfoVW8E4r+aHu5VNqrZ4iTVpXayJ3c0SM2wsrEDwZlYnvFTgE
   Q==;
X-CSE-ConnectionGUID: djJWGCR4R5mClMHTb88K4A==
X-CSE-MsgGUID: Je5o0TRKQD6uPGecSCE6dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876618"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80876618"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 00:30:38 -0700
X-CSE-ConnectionGUID: Yn6+Ooj5Re6ZlgSGRhw+lQ==
X-CSE-MsgGUID: 3nNRPr0rQyWITNDhb04X3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="267700520"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:37 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 0/5] iavf: five correctness fixes
Date: Mon, 13 Apr 2026 09:30:30 +0200
Message-ID: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small batch of iavf bug fixes.  Patches address a NULL-pointer dereference
crash in the hung-tx detector, a spurious free_irq() call in the misc-IRQ
error path, a VSI-state-corruption race when ethtool changes ring parameters
during an active reset, an inverted TC-boundary comparison that silently
steered frames to non-existing traffic classes, and an -EINVAL that confused
upper layers when a TC flower filter was looked up after its qdisc had
already been torn down.

All five are genuine correctness fixes with no functional changes for the
common path.  Best routed via net.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Avinash Dayanand (1):
  iavf: fix TC boundary check in iavf_handle_tclass

Kiran Patil (2):
  iavf: fix null pointer dereference in iavf_detect_recover_hung
  iavf: return 0 when TC flower filter not found after qdisc teardown

Piotr Gardocki (1):
  iavf: fix error path in iavf_request_misc_irq

Sylwester Dziedziuch (1):
  iavf: prevent VSI corruption when ring params changed during reset

 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  5 +++++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 14 +++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c    |  8 +++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.52.0

