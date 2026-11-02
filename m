Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616395;
	b=sxFNN3sN0HEhXFjmcJLfj1MUUvNcAj0yhYiHiiaBqPws/MIPng/RBn++xuKRzzG80FRZ
	 JTrBII9+QoI+ayJzul9MluU7gZyMaPoWJqwsg6tPSlzy2JkvmuZZD3FzH6+BZcZKH7l4P
	 f4XM4j/SKzqzAp2M/piLbMGw2AOtJUZ3P5ejT9VERVpbuKjomNOwrN7zH5Q3HRbtoMe1c
	 061QpzLjJH1ORPmI8PpwwEFwFsfgOIi87vzm8hCfGLb6kBpQOKs5tyDTyzBRPIx7ITfgT
	 k5ZpcsUX39vFmE3f/9Y//GwDLGARl/sF+KiBvZXF1HPrqoG5JuWYpxbDfgBdDfOxXPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zHSmpNjZA4OHD0kaKYRjCibed8j1ZDUSgLmnw5VW5yE=;
	b=yIPj47nOClajWIncHUouFlXoAJusUj0xGxC/zRhHlVeiePnQn5kdv59piqdY6rxLcRGN
	 FqZvPW7naq22WKjGPu5zVicyBQf0C0Gx+EfxrAHyo/kHippuuVh/3EmaMA8m5mDIhmdrw
	 MkfIPYbbfBiMEgecWMHWFhxcMj8IvfJ3W4860/AyZrXpEabCilwflAu8r1BYBiJqaaj9z
	 8QHChZ/olrk6EXFUohu1AbPZGF34U/aycd11VjsjWh5deEgvPyu7ZjQuuxPUG2j6xUa+g
	 sQjL3ekmn96KhuiX1aagr7tDrxfMVpU/v7fGpakcfgEFNmqRWCJywX5gvz/uxsJwpiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mOn5WUp9;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C777606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C777606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mOn5WUp9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616392; x=1825152392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D4V9gd+Xqwjl12KLRjwuCHhH4KI+pNnwUUv/GRXM4aw=;
  b=mOn5WUp9vmKwGnRwMYG6kb60p+RjAaMT2+MC67RXmk++Dr5gdTd1vbEf
   NhZ1w22Oss8zr29Nq0iBEc6y1zfGED2+yRmBarta5cE2re5hqJeEGCJcT
   YzZV4ZOnrnkEV5HDnucTqRNOSdhgW/S7VpLje6STrvveM13qkLjSmUdyt
   LSwCBKz3b/54/0zDydjDKy+EIzth+7YTBAHhXm89Yn6LR6wOX2qIho1+X
   ot97oljgIpyHZOt4vu2dvDUKgqErbmah6T/Pzw9jbX8sSd1i7ejnUnJ3U
   oUq9I2Cl7GCCJUcj2miWMBJOGqIORb6zn2XpsyZ+B0qp4atZZ8ja5oKUz
   g==;
X-CSE-ConnectionGUID: IC9JgP58TH68m0CN9aHrbQ==
X-CSE-MsgGUID: nbrWnVv7R9WQQu/opy3EiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305016"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305016"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:31 -0800
X-CSE-ConnectionGUID: cK87MUbwRJG1TYiUYD7kgQ==
X-CSE-MsgGUID: GLlgcrQxTSCZmT0RG51kfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6011998"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:28 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EBC1728769;
	Mon,  2 Nov 2026 10:46:27 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 0/6] ice: fix DCB lock ordering
Date: Mon,  2 Nov 2026 11:50:15 +0100
Message-ID: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
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

Fix deadlocks and lock inversions around ice DCB configuration, between
RTNL, pf->tc_mutex, the PF devlink lock and pf->vfs.table_lock.

RTNL becomes the outer lock of all DCB configuration paths. dcbnl ops
and ndo_setup_tc() already run under it; patch 2 makes the LLDP MIB
change handler and ice_dcb_rebuild() take it too, so patch 5 can drop
the now redundant pf->tc_mutex. Patch 1 goes first, so that a dcbnl op
does not wait out a reset, whose rebuild now needs RTNL.

Enabling DCB in switchdev tears down the devlink-rate tree, which needs
the PF devlink lock and pf->vfs.table_lock, both taken before RTNL
elsewhere. Patch 4 only tries them, and only when a tree is exported,
which it tells by rate_node pointers, no longer left dangling by patch 3.

Patch 6 is an unrelated fix of the ice_init_lag() error path.

Reproducers are in the commit messages, each verified to trigger the
lockdep or KASAN report before its fix and not after it.

Petr's "ice: fix RTNL vs auxiliary device lock inversion" [0] touches
the same ice_setup_tc() and ice_pf_dcb_cfg() code, so one of the series
needs a rebase. With this one applied first, his patch 2 is not needed.
[0] https://lore.kernel.org/intel-wired-lan/20261023070258.730168-1-poros@redhat.com



Przemek Kitszel (6):
  ice: don't wait out a reset in ice_dcbnl_devreset()
  ice: take rtnl before tc_mutex in DCB MIB change and rebuild
  ice: clear stale rate_node pointers in
    ice_tear_down_devlink_rate_tree()
  ice: don't block on locks in ice_tear_down_devlink_rate_tree()
  ice: replace tc_mutex with RTNL
  ice: register LAG event handler last in ice_init_lag()

 .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  1 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  | 52 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 46 ++++++++++------
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 35 ++++++-------
 drivers/net/ethernet/intel/ice/ice_lag.c      | 15 +++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 ++-
 8 files changed, 108 insertions(+), 52 deletions(-)

-- 
2.54.0

