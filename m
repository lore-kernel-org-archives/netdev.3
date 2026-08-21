Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39378471CEC
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325898; cv=none; b=O/bgjj6gpYjENktRhmXVvx7jSm+V3wZWkKhPFMbB0INg8JoRRbLuiEfICSIvK70LpKl11G7eqYLnZqX1QKBGgdWpQoeSjkVmDBo0Dn4Ih+SI9L1TibwJOCG6pCNWRvtVU3oD8K5kiR6gvR22fTQ/QOkGc6m7Q6agGaGX3Vojaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325898; c=relaxed/simple;
	bh=3nqvV05BEYnRsWzI27qZWjAJmHetEw8qaEIxCxBHfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhTGjIsbi1gxJ/pLHVwTBO54EfxBjBpfnycoe0Mv2lyzXQ/lTf8iCxcyjVK+F3lJgH0X2B6ypPBMcHUCmoxnRXszlRV5+wmMm0VXSKv2A5g0v1icnLkYa1Zlqigv+2il1FCOyE6kGM+cCHU7NM3ZWcbWs/XE/WcGMDHRrbO8Oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBoVKTvr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBoVKTvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787325896; x=1818861896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3nqvV05BEYnRsWzI27qZWjAJmHetEw8qaEIxCxBHfHg=;
  b=YBoVKTvrGrO5qUYFUNNdn5Zc3vnCJ6g8ZS7eDI7gBhBvMagE+4ZDKo6k
   QOXZf7gu1mt9SAnr1uqD4MLM/IHXIWzTdsQRd2BnTHwP19mnUKuby42XO
   f6V4IokQv0CnVddodQomKYPCz9nDoXpFv6cbhw93Je39b3L0DT9U/52WL
   gPVs+tA2hWr0JgrD/i81E3suPmb6mXUk9hjlX3O7bXZSahh6478JuJSsH
   3vm5rs5oJUsmUeUMz6u9Cnw3qMJOmENLyNnNuP0Eiy28Bxe6cyD/xbeiT
   tEE+be7vBtSwEg38W0zPqdmG/3d8tI1Ff+6ipMichfvwIvrowBoWLtjyw
   Q==;
X-CSE-ConnectionGUID: lBH7X3WPSPStWjXkDxWbqQ==
X-CSE-MsgGUID: yZZrYeCYQkSM6u52XlYn/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553196"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="91553196"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 08:24:55 -0700
X-CSE-ConnectionGUID: WLPZN9GQRTymEGeVyaK6bA==
X-CSE-MsgGUID: IQ/fr3ycRSi/EAz28aHApA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="270602186"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:24:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 0/6] Rework dpll pin control
Date: Fri, 21 Aug 2026 15:24:48 +0000
Message-ID: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reworks and clarifies DPLL control logic. Contains
refactoring changes for better readability as well as the changes making
the pin controls compliant to design requirements.
Bounds checking is added to avoid any potential out-of-bounds access

Previous version: https://www.mail-archive.com/intel-wired-lan@osuosl.org/msg19128.html

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks
v2->v3: Fully rework the rollback codepaths, rearrange changes

Sergey Temerkhanov (6):
  ice: dpll: Add the MUX tables to the documentation
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Check for bounds when updating the pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 574 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 478 insertions(+), 97 deletions(-)

-- 
2.53.0

