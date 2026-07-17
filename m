Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C738F658
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314427; cv=none; b=r3ByZI8tMbMpkFZV8f9m4+SYDx7tm3pSMAkyzHpgNOwEsuTLyhT+XBO6azGBphTEW4sGD0xy4g8BaK5eBVEVeJIl9U7kyqmf4UDU0NQ/rqXmCPjQMR1SYyG+k4pyzGqSSzFr8NNldqwNh7bMYboHRrnzo22TCMKR1kV7jQ2Z2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314427; c=relaxed/simple;
	bh=OJJcur2OL12T1aRKF+O2ibsxMUE1Isfps4/h7QLTsGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxA4O8fs9/g6QukN6Nb6EqC8Tj/3OundaFS/ARN091vqiAWTlFLiwEAFX+s/hIPyEy9FG6/Gy26W8LXSLfsUGLZpYqHeae7UC13v4cQ1Fz+VJ+/vB1acjfVKodHtt3/01WNe8wQMac8J/GRF2c5c8gGv6hlwJN5zK7friK00HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bk8DO7tF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bk8DO7tF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314426; x=1815850426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OJJcur2OL12T1aRKF+O2ibsxMUE1Isfps4/h7QLTsGs=;
  b=Bk8DO7tFuhJSVF5KchjeYm+BIdyuhCmx7EZXpODLq80fKv8hNDGm3qX5
   31f2jOY5879u4fyDTlrxQ28Sf8ei5Cd/1395wSbUfQ0mGxVcoPh4UecA+
   Ly+UA51Ezyhxuj1Qlysb+Wean4CeODbF9J+G4TIIEF/5rKBBHLzYJ4/JZ
   BhsafCqK4OBsGkFYiNQYwedDD8z5WbyW7kfUoKFrDhjqtpAbXGEbMD8Y6
   7XxPJJn1qsPfmO8uf5h5TyERGuJ/WHUm5FmXm/xzlswR1QGfP/ovJ2q7G
   J9aCSZt4Hv6EmYOiRv06sABIve8j/j25vjxoU32k52RNkvxk0vsLASXjl
   g==;
X-CSE-ConnectionGUID: aWi9jbA3QoOOulicVTI3yA==
X-CSE-MsgGUID: xHEHCJOcSW2ztR8wIMO75Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347578"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:45 -0700
X-CSE-ConnectionGUID: XdBMeziTRwGkPScJv/kghQ==
X-CSE-MsgGUID: G4jQX+3aQ0i/91rrXslLPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827220"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 00/13][pull request] Intel Wired LAN Driver Updates 2026-07-17 (ice, idpf, iavf)
Date: Fri, 17 Jul 2026 11:53:22 -0700
Message-ID: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Vincent Chen fixes issue preventing VF creation when switchdev is not
enabled in the configuration.

Michal fixes issue with checksum advertisement and handling with
extension headers.

Additional details:
https://lore.kernel.org/intel-wired-lan/20260428070647.777141-1-michal.swiatkowski@linux.intel.com/

Marcin corrects iteration value for profile association that was
truncating profiles.

Karol bypasses, unnecessary, waiting on sideband queue PTP writes which
can cause failures with phc_ctl program.

Sergey adds READ_ONCE() to access of PHC time to prevent torn read on
32-bit systems.

Paul adds a check for uninitialized PTP state before attempting to
rebuild it and restricts check of TxTime to be for PF VSI only.

Alex adds bounds check on PTYPE to prevent possible out-of-bounds write.

For idpf:
Emil defers setting of adapter max_vports value to prevent inadvertent
use if interim allocation errors are encountered.

For iavf:
Junrui Luo checks and clamps VSI size from virtchnl to prevent
out-of-bounds accesses.

The following are changes since commit 56d96fededd61192cd7cc8d2b0f36adfd59036c3:
  mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Aleksandr Loktionov (1):
  ice: reject out-of-range ptype in ice_parser_profile_init

Emil Tantilov (1):
  idpf: fix max_vport related crash on allocation error during init

Junrui Luo (1):
  iavf: validate num_vsis in VIRTCHNL_OP_GET_VF_RESOURCES response

Karol Kolacinski (1):
  ice: support SBQ posted writes with non-posted support for CGU

Marcin Szycik (1):
  ice: fix LAG recipe to profile association

Michal Swiatkowski (3):
  ice: pass the return value of skb_checksum_help()
  ice: always do GCS if hardware supports it
  ice: use NETIF_F_HW_CSUM instead of IP/IPV6

Paul Greenwalt (2):
  ice: fix PTP Call Trace during PTP release
  ice: prevent tstamp ring allocation for non-PF VSI types

Sergey Temerkhanov (1):
  ice: use READ_ONCE() to access cached PHC time

Vincent Chen (2):
  ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
  ice: remove redundant switchdev check in ice_eswitch_attach_vf()

 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 26 ++++++++--
 drivers/net/ethernet/intel/ice/ice.h          |  3 ++
 drivers/net/ethernet/intel/ice/ice_common.c   | 25 ++++++++--
 drivers/net/ethernet/intel/ice/ice_controlq.c |  4 ++
 drivers/net/ethernet/intel/ice/ice_controlq.h |  1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |  3 --
 drivers/net/ethernet/intel/ice/ice_lag.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  4 ++
 drivers/net/ethernet/intel/ice/ice_main.c     | 21 +--------
 drivers/net/ethernet/intel/ice/ice_parser.c   |  3 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  7 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 47 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 14 +++---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  3 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  7 ++-
 18 files changed, 124 insertions(+), 71 deletions(-)

-- 
2.47.1

