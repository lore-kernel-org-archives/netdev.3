Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F757ED9C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721730; cv=none; b=b0ZK+TEPlkS/7e6G/6XcILerF5V5BKi7KxaI7ikD0+fzjP9L4+ZDDw+lqtJk/ge0fmN/zuWjwS++9rvAXLOtQQwLmkgF4xSAUoQKurEuzYzz0pB476Hc3DB6mpijCViHhZdBNKglgMHLFVvppuatp0A9nAI1ONvOMVw0plUAC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721730; c=relaxed/simple;
	bh=ySGYoCUKv0DHkZKfSI2Oj/UWAJwZDBeRTdaWg0Nuy3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPIe3TZucFn4W3JLoQH+swJcRGK3hD3RrB//LuSn2ePUsOLxFgKiZ5Se0W3loWf4trcJd69Q4r96+DRgbSYrOAvRQA+sM92Xc25W2c8hoMfzi0AS9lmmRLDxoIERrMJKko2nck4UQYv29pppfenkfswSu1ectU/hRs2A2MSKzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjNxGMWg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjNxGMWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721728; x=1822257728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySGYoCUKv0DHkZKfSI2Oj/UWAJwZDBeRTdaWg0Nuy3U=;
  b=YjNxGMWgn+YoSUyMfZ+W8rxw79+fF4VTr0Zn2GU6NaRK62X4PRNh1kT+
   Me8u13RSGE6BV5CYX2W1wMJp7NvZo9ttS95PMzf2e4nlXL5xgeyZAtlEu
   ujjDTktwi+XCkRQ85iOh+iTYlcwndujoD0sP2jMfGZClPLPO3x63Simqk
   WpV0q4tZujC+x8eQmCvtYJVXCqK0RkD6X5qImCq9sR2hCpZHlRYgtcf1o
   ooo6aQn/YLgvGcvyzDo7mQxvXh/jmyX2tGGBXX8vhUdDa113+Bbu4amTl
   7G4A/L4v3J7pZE+EAtv9135ZaV3cUBxxcVZ5pEEQcqgIi23TMc3LjL477
   g==;
X-CSE-ConnectionGUID: NI5W37SjTzaoQZ4uIWY7fw==
X-CSE-MsgGUID: I7uqkOqBQDulkjkZZJpFCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548893"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548893"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:02 -0700
X-CSE-ConnectionGUID: G7uccRIRTF+evg79lcccmw==
X-CSE-MsgGUID: E7XWiL/1Rj2RWE7ftHlkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452326"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Weimin Xiong <xiongwm2026@163.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: [PATCH net-next 07/10] ice: parser: use kcalloc for table allocation
Date: Tue, 29 Sep 2026 15:41:47 -0700
Message-ID: <20260929224153.1455466-8-anthony.l.nguyen@intel.com>
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

From: Weimin Xiong <xiongwm2026@163.com>

Use kcalloc() when calculating the parser table allocation size so an
overflow in the firmware-provided item dimensions is detected before
allocation.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index 3ede4c1a5a8a..d239102c52ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -102,7 +102,7 @@ ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
 	if (!seg)
 		return ERR_PTR(-EINVAL);
 
-	table = kzalloc(item_size * length, GFP_KERNEL);
+	table = kcalloc(length, item_size, GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.47.1

