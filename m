Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611555;
	b=Tz37QAz3Nm+HQ9XOaUL3yeDg3PocTEYc/k61Ulu2em/1AJpsqhkARuqsLPD3jrOesPUy
	 MvhHKnA2IjvZA67owfwl6XWUpyr8t/D6pdbG7J/XwpndaJDCI+MEFrrmMH87mw7ge+I07
	 vHv6/A0sfl+0WvFsoQjUBmqwKYuGoCmyby0zcqTWfU7QoQ6+N8HPqc0xBy0Co7RL2iq5x
	 +L5c666Shf3dWfnN+OQPynFKAyDrjAu+r5gymDTafJLRyDzva5MgE/c70ljTd/osHoJbi
	 a8ujLogwOy+1OBASaxMAeXCS3uJjB5b8qaRM3dNUa7NX5A+a6JnECYeSQjIJ5z62pTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611555;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=V9PZhjrTCrDhVXEdwzdQFoO4FessefQ72vw+Q16/f6c=;
	b=HiX9Rf2B4RJu4yoiPuWr/tloPDVIw/D5e55AJe9sQcEkz8WKH5/xlS/Fy7xWS1BiDxw2
	 G3phRf6pIQLPR1iH+CAmEJorxZ7Siu8Jixf7LXaB8H6VatCSWjXTNIz3KSkf8FoXg1h3B
	 JQr8elnm92/O5NyEFJ645dGw7WoQnnYBrMUhD4SNdsIqAk1bb8TgzQPhMZ6vBd+zIpCcH
	 kJXV6MkRcarcgWJk5sHe1z0Gh+hCQNezKzC8hYYlc+sPTSI7Bx8MnB2tRIoFdYXrYuzKX
	 Z6u9nLQo24dzPU7HA2rXrZNURaLbT+p0CAbx7ldjeWSFSWgzwbpfCMu0zu2KJ1iJ05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a20QVWno;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA5606A33A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BA5606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a20QVWno
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611553; x=1826147553;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LRd827PbuYs6eVFfFjo/e84HgaB8FbYO8LuSq/zd5GA=;
  b=a20QVWnosvDLfxEgSqI+RP+JfrSJW06uNFy7HGLPDAVWq+zWCqz6U4lb
   9iF5z1wezNhwpD5IjqZduOOliqsDTFG8fZPHkNsSaL7p9tzAFWxd9YUUz
   uPP1naWzyUVPQwFzEWcB47dDFGjjrAjL9ri8VWNfYuCQtsKxQlTIyn0xJ
   zgTMF7ylr9JZvb2J36UGfUPFqorIwk2/53g0uWklEa7g4Kf8IoNzgDcnb
   +I3DKaGpYnlhkgE/wIUgl6rESrZGGd/9TTjzciXgO0kjOvsXv5clCvYy0
   4AQOBpZPMPR5+1gac+DAYZm/OFZWkxaqRwkXkjvC/2vSrdDpKVaEZgaXd
   Q==;
X-CSE-ConnectionGUID: qGlZmrL7RaiqxPg2xZc4jg==
X-CSE-MsgGUID: XT/voBpSQguXhmedu2t1IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443130"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:33 -0800
X-CSE-ConnectionGUID: 3NxxxmOzSA680osU6177cw==
X-CSE-MsgGUID: WjD5+rQhTBGd788wpqJ10A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360975"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2026 15:12:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	poros@redhat.com,
	david.m.ertman@intel.com,
	pengpeng@iscas.ac.cn,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2026-11-13 (ice)
Date: Fri, 13 Nov 2026 15:12:17 -0800
Message-ID: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski fixes TC to-queue offload for non-PF0 by switching to
use of global queue indexes.

Petr Oros resolves a couple of promiscuous uplink default VSI Rx rule
issues; avoiding redundant per-VLAN rules and preserving the uplink's
default Rx rule. He also fixes an off-by-one read issue for devlink NVM
read.

Dave Ertman corrects LLDP filter handling by preferring the newer command
when supported and falling back to the legacy command otherwise.

Pengpeng Hou fixes ETH56G deskew checks by propagating register read
failures and poll timeouts which were previously treated as success.

The following are changes since commit ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6:
  Merge branch 'bnxt_en-fix-pm-resume-on-vfs'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Dave Ertman (1):
  ice: Fix incorrect LLDP filter assumptions

Michal Swiatkowski (1):
  ice: use global queue index in TC to-queue offload

Pengpeng Hou (1):
  ice: propagate ETH56G deskew poll failures

Petr Oros (3):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release
  ice: allow reading the last byte of the NVM and Shadow RAM regions

 .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 -
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |  18 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  18 +--
 drivers/net/ethernet/intel/ice/ice_main.c     | 109 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  42 ++++---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   3 +-
 7 files changed, 138 insertions(+), 55 deletions(-)

-- 
2.47.1

