Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B52331EC2
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757174; cv=none; b=hlQxPUm04MRvcfOGdiY6g+kC4zkVV5LQpu348yVPD0t4h3MS2k+JID157Szv1dH06YTjyXuToVDiRkYtt7PCOk31nJpjr35tUeG/P3jalqnoLWMI/a/JyqgvqUgmhzElxkjKDNXORutvpFh2tLp21UTRAi1g9gZwrSHIQy0hSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757174; c=relaxed/simple;
	bh=dcsgQrkver+q/4LGCAlK3SVRW0F7/9cy9Twe0HOK0Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hp13tv1aB1BS4uhx8kTljYmAWDuCgpqI/Dim3TGzL9/4ByUheDKaDZlgzUJvQE/n1x7of5kyxBOqnfcer8/VeKbqPk4ggLeP8bPasE1peZA8aB7n3x6Ygqahix7v8BG+cbIMc9LrwODYrxXGbi9CUsszjBXqZ96f2dK6BzjsEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol26tb1G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol26tb1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786757172; x=1818293172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dcsgQrkver+q/4LGCAlK3SVRW0F7/9cy9Twe0HOK0Jk=;
  b=Ol26tb1Gt34S+0AAZxBE7sTgcfqLOjldWsHcxVhA7RpqX9bObgAurvFk
   XV7q2t44PFzRxUoAIdD68xgh4bFGGXy3kQYPEr9ncVCdwKutatqR+UP4u
   zyiTCwn/hj0hi8i+YnE64v2kdBNt2sEwl1KGEHHuPSM1UuXPLhU0EfKVg
   uNLLkLAhgwkfAg8R5FMKN3GVz57R4iOExhNSHPuLAlzvJfymbP0PjBLU+
   1OpcTW/C3gC9+eDgFTB8PB/+CFYUSancsfq1bTTEeWJDf+AfNSzWhSZ1G
   /OtVRp09ON+4KPGvXK56SpGVERSwF+AYQ1re5op28rohf7nfbN1jCqiPf
   A==;
X-CSE-ConnectionGUID: SII4+JJfS/qKMA+jUL5cnA==
X-CSE-MsgGUID: iDuIQFSsSZKOqGwbsj5JDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194377"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="87194377"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 18:26:11 -0700
X-CSE-ConnectionGUID: j+d/s5SIR3qjRJW8f6QWtQ==
X-CSE-MsgGUID: XvHn7fRvRouF8IgOWc5+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="287844719"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:11 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 0/3] idpf: add devlink info support with selftest
Date: Fri, 14 Aug 2026 13:49:16 -0400
Message-ID: <20260814174919.4177289-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial devlink info support for idpf and a matching selftest.

Patch 1 fixes probe unwind by clearing drvdata on the error path.

Patch 2 introduces an idpf devlink instance and reports:
  - serial_number: device serial number for NIPA CI identification
  - fw.mgmt.api (running): driver-device communication protocol version

This follows a phased approach and reports stable, readily-available
information. Firmware version support will be added in future patches as it
becomes available through virtchnl.

Patch 3 adds a hardware selftest that validates basic devlink info
reporting and matches test patterns used by NIPA CI.

Paul Greenwalt (3):
  idpf: clear drvdata on probe error path
  idpf: add devlink info support
  selftests: net: hw: add devlink info test

 Documentation/networking/devlink/idpf.rst     |  29 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 .../net/ethernet/intel/idpf/idpf_devlink.c    |  79 ++++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    |  45 +++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  13 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 119 ++++++++++++++++++
 8 files changed, 285 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

-- 
2.52.0

