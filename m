Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63675357CFC
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126746; cv=none; b=f2hPfv7+TF1QCiOnunXY9KpW7jQNpZE8wjNTQzTyjjlR5HhVYIUFiyfQqJ9n1zl52tg3+VaPMxr+bbFXBdxhLDPgbhlqLn+2ZMZ1MzcOdJfzlHA9h0shKAsMwytTRKl3Q6rUrgMMYclwsibSWbogpU5gU0U3VwZl2Xvv++IDNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126746; c=relaxed/simple;
	bh=wvNxanIRdQM5aGw3gxWpcPj9WY2QwFj5Iap6gvL5Aes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zg0uiEL/DgNvh5WeJQpP8Lv8+zcw49NdlZtbjnV0hyoQIt+RoeOpgPlnwHprpkHG23aaqTm2B4Gq1wUjtj4MVI4cQm1DhOGnC7826DE17MhPJvboLV3xZbV9RLEoqFYESR2bWvDmtKPgKH63VjJBFp7pZy7RG53S+fa226bn2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQJow/Ma; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQJow/Ma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789126744; x=1820662744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wvNxanIRdQM5aGw3gxWpcPj9WY2QwFj5Iap6gvL5Aes=;
  b=jQJow/Mas+WNIDtXTsB4MHbu6fPC02NQ20nBGc68MxIpvW/3odlfgdqN
   NDgUgGgz9TW2UqurC/1hzH53lbzghDYpTsxp4d/4zhQFDD8tGoiCjf4xt
   YzbMba1AqprsVqeDUwaSafVOIcqdu2AjmBsaXOatBwRfMGNagPc5mjmxy
   +SkRL9ikUEQd0Y7V/cM0C9inxoKthLmkUGYNNbzxATCmNmIbuDBIkz5zW
   MB4okTnrNKUYYPfrlz+wdPO5XCuO6RBmX595x6jyOf3wdxniCYn19+OyU
   z7pSZlABYxqJcY6/dGQnZYxbSmrP4XH+OJ6vyOHiUcXQoul2Ip667JBxg
   w==;
X-CSE-ConnectionGUID: 8oCQbHaGTmamUrGcZPjJ2Q==
X-CSE-MsgGUID: RCf/eEQdTou2TiXb+2wwNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359884"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="112359884"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 04:39:04 -0700
X-CSE-ConnectionGUID: LUmrbq0lRBalY3egJKFS2w==
X-CSE-MsgGUID: PKySCI3RQ7mozg7lcFxRZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270135834"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:01 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EA9062877A;
	Fri, 11 Sep 2026 12:38:59 +0100 (IST)
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
Subject: [PATCH net v3 0/5] ice: fix stats array overflow via proper realloc
Date: Fri, 11 Sep 2026 13:26:15 +0200
Message-ID: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix OOB access to the stats arrays.

The first three commits are simple refactors to make the rest smaller,
the fourth one untangles the logic/lifetime of the stats array entries,
then we have the final fix by Michal for VF OOB access to the stats array.

Michal's fix was made prior to the rest, I have only slightly changed it
to base it on top of the pre-work commits, that should resolve all the
corner/error cases reported by AI.

The series was made anew vs the [v2], but the goal and spirit is similar,
but I have started from beginning instead of playing whack-a-mole with
yet another corner cases. We are also back to [v0] by Michal, as it turned
out to be more elegant finish with my first four patches already intact.

My intention is a direct apply to net, as this was already (v0, v1, v2) in
the past-iwl loop.

[v0]
https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com

[v2]
https://sashiko.dev/#/message/20260812204619.32253-3-przemyslaw.kitszel%40intel.com

Michal Schmidt (1):
  ice: fix stats array overflow when VF requests more queues

Przemek Kitszel (4):
  ice: extract __ice_vsi_free_stats()
  ice: extract ice_vsi_new_stat_arrays()
  ice: extract ice_vsi_get_num_qs()
  ice: rebuild ring stats arrays instead of reallocating them in place

 drivers/net/ethernet/intel/ice/ice.h        |   8 +-
 drivers/net/ethernet/intel/ice/ice_lib.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c    | 295 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |   4 +
 4 files changed, 183 insertions(+), 125 deletions(-)

-- 
2.51.1

