Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991438F62F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636685; cv=none; b=RZe25Yacff4Tg1+8vcGdHQRZrY+8B28Vb8ynHL7YVF0EhWUPMf3suWG/GErx54wEEXpgwAkF7dZSvAPGBL4Vh96QAyxHasbtv+lBv7SXSDS32YRgXUZmbrJChQKq+DHNnER/m81zOb5bfN+gY/4uNIG3nbSQ/kiMVUN+tp0FAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636685; c=relaxed/simple;
	bh=0xXetb9xEfgzxJlMEyuUXTE0q5//hRICnZtyMRfJvIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxZYM/KR1PjcLeK07B8DkPUv7XK0qYqHbD8Po6kcspF+aPFhkwsqNweH7Jp2rUV+hOfYltycRcy1nz2xlVZZ3vbnmTE8l2V6fUVtKAzaMuri1w/3Wc83rfxCr9WG/L+KGsnkaQTlmSY1zfxAgICZTlrTqCAQMa4iRQsnNW1srrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoN468LW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoN468LW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636683; x=1822172683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0xXetb9xEfgzxJlMEyuUXTE0q5//hRICnZtyMRfJvIw=;
  b=PoN468LWL/vFVVcvhrr/WVtw8IxLzqdoEWxFcD646T6VP85X9tubs5ar
   IbGcPWupitYhV4j6LExb3/GssSDmZ+s9MLMSoG0zRzsZJvFN5Uvpsgo15
   AxCuM5ZB4dzprDHYbHlZyD6sXTt2pAlbJHch9kg712/WQ+Gyrt7NiS9sh
   YKk8JzJS9wmxSIAVGknCpHPie7uTspUuXvdU4H2qMROxVYoD45FFCM+vc
   yOKDbe+gxuCPl8fouA7HXsfuDjAnL90gOCIW7edatDkeZ1luJPH66i4/q
   mOkGF8BZAo+XeU/8sV1MAzwaRd67OhJ5lcuO0Pmj/Z7vckeJ++viatS4l
   w==;
X-CSE-ConnectionGUID: 7VyCYVP2TZigitQQM9WTdA==
X-CSE-MsgGUID: SkdaqBRTRiSAp0xKjXarqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513247"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513247"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:42 -0700
X-CSE-ConnectionGUID: lzdbtYGYRkOKowdydIaqQw==
X-CSE-MsgGUID: 2upVVBcjSuyT7YPhaSSQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317680"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	emil.s.tantilov@intel.com,
	luoxuanqiang@kylinos.cn,
	bryan.fraschetti@canonical.com,
	tristan@talencesecurity.com,
	tomasz.lichwala@linux.intel.com,
	david.butler@appgate.com,
	horms@kernel.org
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-09-28 (idpf, ice, iavf)
Date: Mon, 28 Sep 2026 16:04:21 -0700
Message-ID: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:
Emil fixes a remove/reset race by always stopping the vport during
idpf_stop() so NAPI is properly torn down.

For ice:
Xuanqiang Luo resolves a use-after-free issue by changing order of
operations so index is used before being freed.

Bryan Fraschetti restores ordered MMIO writes for ice Tx doorbells
by replacing writel_relaxed() call with writel().

Tristan Madani fixes representor use-after-free by releasing
metadata_dst through dst_release() to ensure it is not freed until
all references are dropped.

For iavf:
Tomasz fixes reporting of statistics by always requesting statistics
while the adapter is running as PTP commands can interfere with the
previous fallback stats update mechanism.

Dave Butler caps the advertised maximum packet size to the hardware's
single-buffer limit, preventing PF queue-configuration failures caused
by oversized multi-buffer frame limits.

The following are changes since commit a7bfaba4823e3c165bb2004c74eff7c096672bc7:
  ipv6: fix prefix route expiry in modify_prefix_route()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Bryan Fraschetti (1):
  ice: Restore Ordered MMIO Writes for Tx Doorbells

Dave Butler (1):
  iavf: cap advertised max_pkt_size at the single-buffer HW limit

Emil Tantilov (1):
  idpf: fix possible race on remove during a reset

Tomasz Lichwala (1):
  iavf: fix VF stats not updating due to PTP command preemption

Tristan Madani (1):
  ice: fix metadata_dst refcount handling on representor teardown

Xuanqiang Luo (1):
  ice: fix use-after-free in dynamic port cleanup

 drivers/net/ethernet/intel/iavf/iavf_main.c     | 14 ++++----------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  8 ++++++++
 drivers/net/ethernet/intel/ice/devlink/port.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c       |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 ----
 6 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.47.1

