Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D992C375E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418627; cv=none; b=l/EwRiV2SMTId0zdAsMm9NgEOH+ZvVtx+b636Ic9+I1X+9FzbPa69nev8+4BNgNy69GS1MtaZgs8QlWW3jbfCvfrkTJs+g1iI8m3SWCyx5QwgXgUzZ63Z3dzZhxicUTYsgoD74e7rhQTnEtyxAU/Z9MMNWoW1Pv0rpcpUT6+y1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418627; c=relaxed/simple;
	bh=WRrEP0wxmuMbEtGGN8xgtXwm54c5/K1Y+jLf5Bs/DWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aC9jo8bQq1VALqeRbHIy38u3wGeniiBunYhMfTYgus1JW1p37t6f5Dp6Dd6VrXgPm23ABjT9v00PiMLXceR43ThR0+NSOoNBP+xzYqyVA8/2GImNBBeCWysBwy5LKoi3JF2jOXcDfkwDsEDZTCECC9t+Z8EvMiUho3d4eBOfPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUxY00w3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUxY00w3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779418625; x=1810954625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WRrEP0wxmuMbEtGGN8xgtXwm54c5/K1Y+jLf5Bs/DWo=;
  b=EUxY00w3fIBooX91xItGUSSu1SFe7Ncfyrp7qH/ROMkfunjvdTvkwiCt
   yJMYGvXH6KhX58pejdV5mG7eMCz6NlDY0qNyQ0IgwRf11134eg7JQSzkd
   avfh/5ROxnA+RIAWsTzB/eeeny3qjV8HMB8ZPrgJLlfa9mon2v/BLnML1
   Ky8ZB6oy2c2PQk5gavbz8epzyKbcUtXqg+gN0zxEHuZQuL+M5eWaRmnQ/
   MybfxiCdcaVxtdq5+BOCUuu47Vuln+h39Nfc4InMGXmRQ9MYcRRnDul3e
   aUXNCYSnQohICAzaoGP8fMeeU6D87raFio54NccKzH9wArziU5s/p90XK
   g==;
X-CSE-ConnectionGUID: FUpHf1ebQ++lAdm5YS1f8g==
X-CSE-MsgGUID: 0u3TOqGeSV+UbYFR8X8G9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105811754"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105811754"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 19:57:04 -0700
X-CSE-ConnectionGUID: i/xnYFoWRaGDmZRVZEpRcw==
X-CSE-MsgGUID: 3UykpI8PSk2WNorjK0kOMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245035636"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 21 May 2026 19:57:05 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/2] iavf: two small logging improvements
Date: Fri, 22 May 2026 04:57:00 +0200
Message-ID: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assorted small logging improvements for iavf. Add a dev_info() forwarding
the PF's own diagnostic string when a cloud filter add fails, and print a
netdev_info() when the PF confirms the primary MAC address.

Improvements only, no fixes; suitable for net-next.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Aleksandr Loktionov (2):
  iavf: log PF diagnostic message on cloud filter add failure
  iavf: log primary MAC address confirmed by PF

---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 25 +++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.52.0

