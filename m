Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF752E7164
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579453; cv=none; b=Y4RktRnSvoi9HnMoJc4lFaZG8C+WTR5J73oVmPpfbQRZP1+bypNkoqik3KtsSfR4qiBvOWhVFUvYWxJXdeYbI7/kQs49i1wjVi/OD+3SXPTwwvNUaSjDb4gFytEjU3n+9svCxDqI26wu8+/00YLGejjEv29VXgknr2FlLyjRaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579453; c=relaxed/simple;
	bh=rhBvuqypf5LHhK3Z0/md04qrIWQLJc20kETHaLtkhz8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N5Y88gGZYLz4t9/iRjJHVP62CECaKk/2fwvwPiRoBSE2eTJbT95dmuKrtl31/NRpda/87OIRPidOrqUr2dy8d2ma0kFtqMYViQtmonyHMf+eDP/UMTog1J8fNSqs2iGrE+e93MRg87/NpEWlIVzOrF0qjWclfSVD+OFbE3K/ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeGKyT9p; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeGKyT9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771579453; x=1803115453;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rhBvuqypf5LHhK3Z0/md04qrIWQLJc20kETHaLtkhz8=;
  b=JeGKyT9pa92vQN7UX05YGETqCvMfXdgkmJs2lIF7pocsMk6Cji7J3p/f
   USu2RHHU+pzXtcLg8Mwha4gwlQvDhb+XG6wX7JORpJY/XSCM2G6tg7XVY
   9vvCBxQV4OzOFPVcE7AJ/WsdADohy0Gk+B27k/NpYmNUsbn2oM61mgPmi
   3DBZJ0kNV4rahsdToaOWrV4nOEf34WmWZt+Z9sM4P4jfjGPzmOG2nhIcU
   bNftELFHzzKabe2+opyF9e7NDJ2rGwZylwuFeoFoKpmSYe85SVa+30O1q
   8AjhM3ow/k2/A14rtzlZayYDiyBr07Z6I9QPeEyBakNxU047JrXZfBxyJ
   Q==;
X-CSE-ConnectionGUID: +fZGV8O+R9+yB4sMaIM4Vg==
X-CSE-MsgGUID: VnGrUMqFQG2cfkaDMQdVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72715187"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72715187"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:24:12 -0800
X-CSE-ConnectionGUID: tWQIHYZHSsus2y38fK6yhg==
X-CSE-MsgGUID: 9JoX8r6PQXmTcNyQmNS0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="245382077"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2026 01:24:11 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 0/5] iavf and ice: GTP RSS support and flow enhancements
Date: Fri, 20 Feb 2026 10:24:04 +0100
Message-ID: <20260220092409.718632-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Receive Side Scaling (RSS)
configuration of GTP (GPRS Tunneling Protocol) flows via the ethtool
interface on virtual function (VF) interfaces in the iavf driver.

The implementation enables fine-grained traffic distribution for
GTP-based mobile workloads, including GTPC and GTPU encapsulations, by
extending the advanced RSS infrastructure. This is particularly beneficial
for virtualized network functions (VNFs) and user plane functions (UPFs)
in 5G and LTE deployments.

Key features:
 - Adds new RSS flow segment headers and hash field definitions for GTP
   protocols.
 - Enhances ethtool parsing logic to support GTP-specific flow types.
 - Updates the virtchnl interface to propagate GTP RSS configuration to PF.
 - Extends the ICE driver to support GTP RSS configuration for VFs.

changelog:
v2:
   - reduce much repetition with ice_hash_{remove,moveout}() calls
     (Przemek, leftover from internal review)
   - now applies on Tony's tree

v1/RFC: https://lore.kernel.org/intel-wired-lan/20250811111213.2964512-1-aleksandr.loktionov@intel.com

Aleksandr Loktionov (4):
  ice: add flow parsing for GTP and new protocol field support
  ice: add virtchnl and VF context support for GTP RSS
  ice: improve TCAM priority handling for RSS profiles
  iavf: add RSS support for GTP protocol via ethtool

Przemek Kitszel (1):
  ice: extend PTYPE bitmap coverage for GTP encapsulated flows

 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  119 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   31 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   89 ++
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   91 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  251 ++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   94 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |   20 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
 .../net/ethernet/intel/ice/ice_virtchnl_rss.c | 1404 ++++++++++++++++-
 include/linux/avf/virtchnl.h                  |   50 +
 11 files changed, 2070 insertions(+), 128 deletions(-)

--
2.47.1
