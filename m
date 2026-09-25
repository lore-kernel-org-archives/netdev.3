Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88393B14AA
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342828; cv=none; b=dlyPhNvUO3XADSmv1FLjeWhHk9RSToi4WSyFqGF1frxL/D2M8ZufjPbX2HWW00hv2odscwsaQyI3rnYEQUDNR+uLz6CucyM0Svw3w5l5AkO9uVL8IPiT0ql/nR+1EWgZiE2a3rpgKX8V2OaW2JP8L7iQ9L7QRAVlOF9FRqNfSEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342828; c=relaxed/simple;
	bh=25UpPq0UPIGVY0w45oEDvCYLB3/iWoNYVuagUka0bWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3XLcKPlMPCAsA4D18YOtDNwa98UIpIlPGLpFCmganp44ReIO10xbiST4Ol7xIJOFPc7Wc9kX4c/XKQQomIcv0JsBOL1pVvwr2wUVJ6l1yId897Nhx0YJ0lKAbRrxJeM3gajLCkUu00L9UBC9/QrrO+L6PpWgsdH2nMgiu2c1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEEEVn63; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEEEVn63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342821; x=1821878821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=25UpPq0UPIGVY0w45oEDvCYLB3/iWoNYVuagUka0bWk=;
  b=OEEEVn63RC175OvN+T3WAC4/KgKw7aHpVAdCp9GPNv1Fp0q7HPJueKGA
   VHUUZiqbi70fmug0K3Cdc3wLgM4bgCeB1uv9l0EmDlq80wu9wAzXTdwBB
   wlkG9zeyIGXeIfxpldhy1lAsSd9s3vmx/2AiXSWdDGz8VDXgajd0nE2As
   cohRIB7sqpcQpu2XUVJDsy5PSvZ6NXzLrqmXn7SPQ4ms+YVJuakAHBCIZ
   Jc7m6YZMSvxlnFQLiAK6+JEJhi31OLXlXaHde4pj6M1ANFyhSCOgrQDNR
   IwRyvdVTumtyeiUtKPZBPNmxbLafnlqTiAHdwENlbU9LHc6POXDcV70Ll
   Q==;
X-CSE-ConnectionGUID: xILBbI8aTvOX+Lp2u4V3Ow==
X-CSE-MsgGUID: 2S4SJkG1RwSeMFApJ4RSHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508242"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="107508242"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:26:56 -0700
X-CSE-ConnectionGUID: 2o8/wubERTSf+TOGvGI45Q==
X-CSE-MsgGUID: dWMzvWfVTBuYrZUbE/57hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282414660"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:52 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1FE7F2FC53;
	Fri, 25 Sep 2026 14:26:51 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 0/6] ice: fix stats array overflow via proper realloc
Date: Fri, 25 Sep 2026 15:15:42 +0200
Message-ID: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix OOB access to the stats arrays.

The first commit (new in v5) fixes stats code against VSI_CHNL case (ADQ).

Next three commits are simple refactors to make the rest smaller,
the fifth one untangles the logic/lifetime of the stats array entries,
then we have the final fix for OOB access to the stats array (combined
for both PF and VF VSIs.

v5 handles now also the PF VSI stats resizes better, fixing devlink reload
issue reported in v4 by Clashiko.

v0
https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com
v2
https://sashiko.dev/#/message/20260812204619.32253-3-przemyslaw.kitszel%40intel.com
v4 (a resend of ~the same v3)
https://lore.kernel.org/netdev/20260921182106.1015019-1-anthony.l.nguyen@intel.com

Most notable changes in v5 already noted in the cover letter, individual patches
have much more notes.
---


Przemek Kitszel (6):
  ice: skip stats handling for channel VSIs on rebuild
  ice: extract __ice_vsi_free_stats()
  ice: extract ice_vsi_new_stat_arrays()
  ice: extract ice_vsi_get_num_qs()
  ice: rebuild ring stats arrays instead of reallocating them in place
  ice: size ring stats arrays from the final queue count

 drivers/net/ethernet/intel/ice/ice.h     |   8 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 343 ++++++++++++++---------
 2 files changed, 210 insertions(+), 141 deletions(-)

-- 
2.51.1

