Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE6411675
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680850; cv=none; b=uLAUZmwzjeELGUmnwcLUm+/gWF1Rgqm65Zsq1FsmFOEm6PBXYzvqU9NUpsMbpDpvCX+aGC5iJiWeRSUSxgbAIMD0Ip7aPQHS9Lgx5sjUvPk+ju78hyzZcq4M8EMxcU3M4h8YPOsv3boWND5f0eaSO66Gan8r7U5oGz51Keet8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680850; c=relaxed/simple;
	bh=xGzgHIEvWioMJ3fkiFs2XDNJ3kJUshkAsCOMvGfBvAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWSkgLWPQGI7XNq44SpO5HfNWb5UmaX3ov8UIa6Rf4uzzx8eg36DPrB1Fhl2UAcaPkgEymXu+FenIzalkcXliHFD9FAF8Llt6jWVY5WflzQ6KJpe7lQNhoW0+3QsyHOtH0aAZ/NDzxMPlf8ECIVR9d5BWUv/qRMWpxyOd0NRr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpTgqZ/K; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpTgqZ/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783680846; x=1815216846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xGzgHIEvWioMJ3fkiFs2XDNJ3kJUshkAsCOMvGfBvAg=;
  b=GpTgqZ/Kf5WlicHLkkmpsaH/UBv7Lmu48mZSfnhPcjj8xduHC6YIZnOl
   UFBufqB/tX9BikQBD9GfSCRCI7mheVLnpvjzEQ+brNaY1DTNlCrcmbWJc
   w0xZ3hy4EkR1UIsXoN5Lx+dHrF17+wQb/q9IWTQb5sVyOnemd4h/FiaRt
   WYfi6fYfE86914ckuoF6h+wZ1+VvnjJAU+ZsN1C7eP3UUvGetVEoVdqL5
   ss9ofy+dvwPCAExHZCHDH0lTlG3hqPfJwjd41FZacQubgQ6N8BEYDMWHY
   jbwHaLPPynDWr9/WJUF4llZDmqH3hESMR30v/+YP89nBqLWTG/od70277
   g==;
X-CSE-ConnectionGUID: fCdFJwM1R0WoliMqpPFwPg==
X-CSE-MsgGUID: 08Vh56HJTtSUILvlwt00zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86920265"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="86920265"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:54:05 -0700
X-CSE-ConnectionGUID: NNZh9D0wTEuxLzFA86UMMg==
X-CSE-MsgGUID: 4sHwm16ZS5yC4ATfrqmazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259750952"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa005.fm.intel.com with ESMTP; 10 Jul 2026 03:54:04 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v1 0/2] Implement ixgbe PCI reset
Date: Fri, 10 Jul 2026 10:54:01 +0000
Message-ID: <20260710105403.1050025-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an ability to properly perform PCI level reset
via sysfs to the ixgbe driver.

To achieve this, several operation handlers are refactored to
check whether the netdev is available during the invocation, and
the actual reset handlers are implemented which prepare the device
for the reset and re-initialize it afterwards.

Sergey Temerkhanov (2):
  ixgbe: Refactor device operations to check whether netdev is available
  ixgbe: Implement PCI reset handler

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  34 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  20 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 112 ++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   4 +-
 6 files changed, 159 insertions(+), 29 deletions(-)

-- 
2.53.0

