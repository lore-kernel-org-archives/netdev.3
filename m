Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE448382F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568866; cv=none; b=ay7NpoFLTcyHcXpe+RVHhArLeFBzXJ/mkdZ2N+FDkCuiFrK+VfNFmLDGkXsWhyGmGsBS5tmLFqSvTmGf9wCpDmAwBZt8AV4ZTbS4KExQIzukanzq2KhCRmn403HHpxlPzwXmUFDdwFIrCRHpL8eevCEGY7b1GoGEV24IDbgACwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568866; c=relaxed/simple;
	bh=GIMCHuDf0hSA7t84/iP8Kti6SO6m2OBoFJccYtnHjZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IU8GFi4IH4D01B1xFPtx2OYYbhLRRfcIm+G2WYZSeX/HBlAjX6rsQ9jG4YTjjLfPwOwsNbzM6pcNewRpI944fWdDUDXc6OCX+R3mGcqABcQEmYIKmtD70b32/4XEJhqFownlFr1c9wLIHJJbnH/tycXUW24QOuyZBUtg+pPGSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQAN/YhK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQAN/YhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786568864; x=1818104864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GIMCHuDf0hSA7t84/iP8Kti6SO6m2OBoFJccYtnHjZQ=;
  b=kQAN/YhK+u4SOxGsnp0vUMzEIbDSQPmQEyQtjPHifGOE8sNhsT0McZCF
   IMnq1Lm0jru/I4v7o8jUr4yrRqLW0BQDNyQ4WSZfkphCjrvErWfJrMM9q
   ocwFCrHs/ZcpufAQJRTOcp+ZTeag8JxYJgbeR3z40EBhL1DqpK3TfgwJO
   W+sCWWKarN/oWZQtmT9JyJWH7dPV1imAPb2FhOqX3daJDW8JhsW/9SsC/
   LRT6B7jpEWWf8RSLpnCMZQ7Ehlhkgm3b27N1Zn2dTDIZW2mdKJuiVLuqn
   QIeLDc+s3dGyvM5YONe443LWBoVTcvYera3NO3jsYyivfwV90/hkx7meq
   A==;
X-CSE-ConnectionGUID: js6teqNRQNa+BWDAyFDTDA==
X-CSE-MsgGUID: xdvXw2etRpSEUUceKcm+Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98652102"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="98652102"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:07:44 -0700
X-CSE-ConnectionGUID: dY/6M27yTneLviTVy8Ko4Q==
X-CSE-MsgGUID: Y5MTH+XPQ2iGtzJTZrFSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="261985762"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Aug 2026 14:07:41 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 77AA4332A4;
	Wed, 12 Aug 2026 22:07:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2026-08-12 (ice)
Date: Wed, 12 Aug 2026 22:18:04 +0200
Message-ID: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix an issue on ice which increasing VF queue count causes
out-of-bounds access of the statistics arrays

Przemek Kitszel (2):
  ice: move ice_vsi_realloc_stat_arrays() up
  ice: fix stats array overflow via proper realloc

 drivers/net/ethernet/intel/ice/ice.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 195 ++++++++++-------------
 2 files changed, 84 insertions(+), 113 deletions(-)

Previous revision of the fix was part of our last bundle [0],
but here I'm improving only my patches

[0] https://lore.kernel.org/netdev/20260804222205.1580328-1-anthony.l.nguyen@intel.com

changes:
 apply Sashiko feedback for edge cases, see the patch for details
 drop the rest of the patches for now - with the caveat that some
 could still be merged directly from [0] thread

-- 
2.54.0

