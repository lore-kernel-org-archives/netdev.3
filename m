Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41A226D05;
	Fri, 25 Sep 2026 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375641; cv=none; b=Jz+ZwDYk4YdKN+DHh+UvKzRxse5+13OxqE8dyQ0vlDShv9MaV8PDame0LW7boUfXPwVhZKllHyofY8g2G8kgU1wuVPFddFSoiMA2yyCS17z07mIPUQ3G7h8HDs0stG/jKkQewXWh8MPN/DuvcktxwuGFjLRL70TonKqa0nRrDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375641; c=relaxed/simple;
	bh=glUuKZKx5cqmlLMf4KB/vt8XRQXqy6FVeihuH84SKGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2de9+/M3gVzCX5WODKBLWB8dBo3C5glU3/mypZvv98IIv4ClvOIJe7M6tSg8IF+XOfnP/+2Rq1+57cH61zS6mR5DZH4cOKj1Fnfy7O9Ou7z8m8SW9SE8neBKEAKv5rYKIQ0ifS07z0SNQ+vIFb7HR9avyNhmXg7mKqjbdMFenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2xd7uEU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2xd7uEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790375639; x=1821911639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=glUuKZKx5cqmlLMf4KB/vt8XRQXqy6FVeihuH84SKGQ=;
  b=S2xd7uEUU6wop8zfoRzL1su8jv3ee5MW7VJUw9uEymNqFbh6xocmnWYB
   RhngZGvcFRZZSwwaYOJ946mowTe/kinAC0Tb1kEm4JWgYZf64ALnxa3+D
   psWO7zhQ3tKnCpoCSgojCEwFbrq7anhnYho4yITLKlG+Z3+WJvuedOpc/
   xvk9MDmgtRuq1QVLnqIHButmVY5wT/R+DXscVYgWz/KqevhrAdmY0PD1W
   xrhNAcPFCNd1F1Eah3LJEOY3Vyn0R0Fh2jViw47N3L45mFU/6UrgKD1mp
   QS4uG2UN8FYKKobvnGfjOG6zCM3DT50y/QekbI7KkYAAlRmHisztswIp7
   w==;
X-CSE-ConnectionGUID: OsVGUB3eTNebHdlAzBOBfA==
X-CSE-MsgGUID: nnkG7F4ISPSbYSQNxEiM0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90071979"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="90071979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 15:33:58 -0700
X-CSE-ConnectionGUID: sb/G1GFnRDaZ59yprzIAoQ==
X-CSE-MsgGUID: ohN2STdoQ9+JR583vsyCXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="273053379"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2026 15:33:55 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-net 0/2] ice: fix E825 PTP timer race and drop redundant cross-timestamp access
Date: Sat, 26 Sep 2026 00:28:22 +0200
Message-Id: <20260925222824.270640-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a race in the E825 PHY timer start path and removes a
redundant cross-timestamp command programming sequence.

The first patch serializes the E825 PHY timer start sequence with the PTP
lock and keeps the shared GLTSYN_CMD register access and incval programming
within the same critical section. This prevents concurrent PTP updates from
clobbering the source timer command and leaving the E825 PHY clock offset
from the PHC.

The second patch removes the redundant cross-timestamp programming of
GLTSYN_CMD in the capture path. The register accesses were mistakenly
assumed to be required for E823-class devices. In fact, it was the
E824-family (not supported by this driver) not E823.

Grzegorz Nitka (1):
  ice: remove redundant cross-timestamp PTP command

Maciek Machnikowski (1):
  ice: ptp: serialize E825 PHY timer start with PTP lock and incval

 drivers/net/ethernet/intel/ice/ice_ptp.c    |  6 ---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
 2 files changed, 21 insertions(+), 33 deletions(-)


base-commit: 349099e5d8082ab01e60d91fba9d107591c17371
-- 
2.39.3

