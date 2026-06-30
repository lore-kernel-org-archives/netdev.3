Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C193191BD
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855853; cv=none; b=oVMqh6st/VoEEdvmdiK7P5wWifwjjfMV92COlJ0uFtzg3+JR5LMgY8VxbpsiPqBq8q7xycU78RL0HhjoiHAH1h8paqBbSmKDyq3uNxxZiX0tvjQDqO/o+NNH539IGUCs9G/6oPdQCt/8i6OoKX7sTB9BRDViSKyobRyIPtbpsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855853; c=relaxed/simple;
	bh=DB8Jy0O/QAKj2WKj3i2mZ5XNjpKqc3Atmbbw6HZZJb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usTM1Q1YHX9NKmeOW7Vkdm39SoBsRLb4cciuF7FxEVdw44kn3yfHvd+ccXxZf2c6h8y8uOV2/a9dOHOic9Jd1MoVskhWYiLN2srTCRS7Dg3AwhKxnlsbcoYrq94Bomn15i5zHTVne/u1yfENIcDkvy1jBbP2HpafSE6W+TfQdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In/F0pO6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In/F0pO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782855852; x=1814391852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DB8Jy0O/QAKj2WKj3i2mZ5XNjpKqc3Atmbbw6HZZJb0=;
  b=In/F0pO6Z5D+9ZpumiJxNw1KeGiwd3bpcsLnAsEJjaAUOMPl7UdxCI6v
   n/c5BEJXr0A94zYiBC24ZjQlKO9IBH+ggXn2l6IYwsL2pqt+ngayttYGx
   +cFI49/KHxYJlEzpciOXWQul/W2l6bPyrhaim1jWm0N2H9iAKT1RLlA5u
   c7g26Xkxqehv6Qk2A+d6T4MDAYKwreVW/LCyI4G5hN96MJRZGD8swuLPl
   O3FGaI7gN1MHemV4ZIZcktzqjW9H0Us7jb0xWgeQVw5agXFXS1yeM/47O
   5qWKKIW+NFXAzKW9JcMJAOt3ArpFe2L4LcpNRisPoOLOunfb2efeCJwgu
   Q==;
X-CSE-ConnectionGUID: voFcKybWQ8KjUz5WXx0B9A==
X-CSE-MsgGUID: NH1tbBu+Temy+Vv1sXL4NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83637556"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83637556"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 14:44:11 -0700
X-CSE-ConnectionGUID: yIadeugfQh2tXxy7Gqyt9A==
X-CSE-MsgGUID: 0Hq0ln96TAyT6ZEYM7+rAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254296564"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2026 14:44:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2026-06-30 (ice, idpf, igbvf)
Date: Tue, 30 Jun 2026 14:43:58 -0700
Message-ID: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aaron Ma adds a wait for reset completion before returning from resume
on ice driver.

Dawid completely disables and clears VF interrupts during reset on ice.

David Carlier adds handling for a NULL adev when reporting MTU change
event for idpf.

Matt Vollrath removes incorrect decrement of count which could cause
leaking due to off-by-one issue.

The following are changes since commit 2a00517db8de4be7df3d483b215c5544fb30a191:
  bridge: stp: Fix a potential use-after-free when deleting a bridge
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Aaron Ma (1):
  ice: wait for reset completion in ice_resume()

David Carlier (1):
  idpf: handle NULL adev in idpf_idc_vdev_mtu_event

Dawid Osuchowski (1):
  ice: fix VF interrupts cleanup

Matt Vollrath (1):
  igbvf: Fix leak in TX DMA error cleanup

 drivers/net/ethernet/intel/ice/ice_main.c     | 10 +++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 27 +++++++++++++++++++
 .../ethernet/intel/ice/ice_vf_lib_private.h   |  1 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 21 +++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 11 +++++---
 drivers/net/ethernet/intel/igbvf/netdev.c     |  2 --
 6 files changed, 66 insertions(+), 6 deletions(-)

-- 
2.47.1

