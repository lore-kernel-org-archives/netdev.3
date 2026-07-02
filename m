Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33442B32B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984913; cv=none; b=WVlE5NYe12LN9Vpp5M1FXRcbmRJLDrMxDGsqzKKEdWQbxCrsk+uPe9IYEK0EkiMKB/7il5SFKW5xPhWW0OhpzpSvP8iVEj1jBY5tx6gfRnEReqDSuyVoeKJ1nYOopcgXipY2iFW4zz3emyf3cTTvQQ0K+4gg1H96VShOAkEYPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984913; c=relaxed/simple;
	bh=+3smbMZN9q9hfDM0psll/UkMFyPSBbzwLxtftVIxZSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SOYubze34JyAjhQpv+d5Ph1oIgLouzDE87v1dfMT7U9il8fP/te5HhEH00iy5zWFS+kM0ksRaWoIyNx3l70jZjpIkN9qmuQcnZjF3nk1ytK3Vd2cB6Vcx4WTfHVP3h7uIcoJCOl3RZHBvUVlU5Vtw5UxvK9l5Fszg0wOCcsTG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2zpXtl2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2zpXtl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984911; x=1814520911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+3smbMZN9q9hfDM0psll/UkMFyPSBbzwLxtftVIxZSY=;
  b=V2zpXtl21hado1hNbNUSQ3HYdp8qUAfbvFoiTl9+sBm8zXsThfaxi5ib
   7JeEhdmgRROUwAIHQ/XL3tdM2lZtuVpnHb4lsx7G2AJMdihu1UpdQcUGb
   7QVyvkB3gJvI87nwIBtUQZQUjWMg+1RPspFGLGUUdqrPyqeZYlc2fnRky
   bftiYeuVbPf8g4wx6Hs5qSEip9VaTvSArCaL+ATZIwF/8OLTZwUz/BpA0
   MkIn9vQcKIQqIV2tBVt5HG9xE6bhwMGQ3h1dnRgaPCvjWQ05EEvU9hi50
   n7cu64IxV+jn2lMJzJJ1RbNDglDmjvlv8zONsHorgtS1u1GhfZ+UtDiJ/
   Q==;
X-CSE-ConnectionGUID: ES5cHfoYS7O1jHgIk9pWTA==
X-CSE-MsgGUID: 1mGvxQbeRleQrLRs5EyIyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649799"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:11 -0700
X-CSE-ConnectionGUID: 8CcPIbC2SbywBWf03FR83A==
X-CSE-MsgGUID: bhC1K6BYSMWnom7kKuS2Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476401"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:10 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 0/6] ixgbe: improve FW/SW data synchronization
Date: Thu,  2 Jul 2026 11:15:47 +0200
Message-Id: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some possible discrepancies between data shown by the driver
with the actual NIC/FW state.

First 4 patches address problem with link state correctness. In some
scenarios FW may not be able to notify the driver about link change.
Along with fix, refactor the whole approach to LSE (Link Status Events)
enablement. As there's no any reasonable argument for disabling LSE
during driver life cycle, make them constantly enabled.

5th and 6th patches address problem occurring when FW changes MAC address.
There's no any kind of notify/event accompanying that change. Therefore let the
driver to poll for the new address.

Jedrzej Jagielski (6):
  ixgbe: E610: init Link Status Events mask just once
  ixgbe: E610: prevent from disabling LSE
  ixgbe: E610: do not disable LSE on driver down/remove
  ixgbe: E610: re-enable LSE unconditionally
  ixgbe: E610: add MAC address runtime refresh
  ixgbe: take rtnl lock before ixgbe_reset() is called

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  49 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   4 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 100 +++++++-----------
 5 files changed, 63 insertions(+), 93 deletions(-)

-- 
2.31.1

