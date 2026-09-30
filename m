Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E74E1C76
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774540; cv=none; b=aby6AS6skv68nUCAKMLKv9Al7dw532Oqyy7FQkx9rUADAdDWUwRcbRwubcuq1D8nVuLBROugsEHtPfuB2JfA0v0OFSLCFS/RlKDt/f1SwgfNCrez+jDg28U+J51w1BrYoxgyzTD1nrh/Fk5+FvTf/l7hCVb185I/6LuBzF0dOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774540; c=relaxed/simple;
	bh=8nuYhBckcXm3Lx1n2iltz9D9qVXsPaSk/WsfjDAw6cY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sF/rF9G0BwApEnojKNXcD6NP2Bj0X+4S7TJfXQAUbU2mKdxK6eQBT6VtxDs0nhchgu/c8guLfbusUhE2cEcL4ZkjhXRs1AMJjSVLoIKb6fycTTT4UlxmMBS4oDQwbQzYXqFFgkqtgnUAkfRALZjXpsZUfQxJQVC564wZhoMJPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IL75oGad; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IL75oGad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774523; x=1822310523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8nuYhBckcXm3Lx1n2iltz9D9qVXsPaSk/WsfjDAw6cY=;
  b=IL75oGad5hhNU6yakfDRy+/iMv6Z9SSqCv6NXfqtX8xixfwVHdixVVeo
   fPyeuRidlS/jX45xQJVT7qCVfVdetg3NEamUj4sniHn6v81PiJO0o9Cyh
   yc+weAkRa7eEjgm8M0HdjYaSS5mvPGcYE55lai2elqzgSaXs3I5DhgZMt
   a8Viy7Fc/WfoYTsBPZpHzQqacK7JDiDHanKo8lIYpho8TDe5sEXacSkPX
   TCb4teIby/XVo3LR8jlxiKvTBl8wZ9Echl02RgShNKbVOkr0yIt+gXaw3
   D+vVQnWUAhNEWk4ZMm7Rw7yN+WE06AQkKEJ1r50cXHF6nTkX4xVIo7lAd
   A==;
X-CSE-ConnectionGUID: yT3CV+OsSD6eDUBXsFMqfA==
X-CSE-MsgGUID: pTun3YmmT5GPLscT9pj8vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91375414"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="91375414"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:21:58 -0700
X-CSE-ConnectionGUID: WlwF9JjpTnSbTXRd58NOgg==
X-CSE-MsgGUID: gH6TBX33TAaEw5q/PUtp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275730763"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:21:58 -0700
From: Shubham Das <shubham.das@intel.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	alexander.duyck@gmail.com,
	lee@trager.us
Cc: siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com,
	dasshubhamk@gmail.com,
	magnus.k.lindberg@ericsson.com,
	jonas.wirandi@ericsson.com,
	Shubham Das <shubham.das@intel.com>
Subject: [RFC net-next 0/2] ethtool: add interface caps and PHY tests
Date: Wed, 30 Sep 2026 08:21:46 -0500
Message-Id: <20260930132151.932792-1-shubham.das@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds two new ethtool netlink commands:

1. intf-caps-get: Discovers the functional block layout of a network
   interface. Each block represents a hardware point (MAC/PHY/MODULE) at
   a specific 802.3 sublayer (RS/PCS/FEC/PMA/PMD) with its supported
   capabilities (loopback, test patterns, BERT, error injection).

2. Add ETHTOOL_MSG_PHY_TEST_GET and ETHTOOL_MSG_PHY_TEST_SET for per-block,
  per-lane PHY testing using test patterns, BERT (Bit Error Ratio Test),
  and error injection. The block_id from intf-caps-get identifies which
  hardware point to test.

The block model uses:
  - component: identifies the hardware entity (MAC, PHY, or module).
  - sublayer: identifies the 802.3 sublayer (RS, PCS, FEC, PMA, or PMD).
  - instance: identifies multiple instances of the same component, such as
    internal and external PHYs.
  - depth: identifies the host-side or line-side block within the same
    sublayer.

Prior discussion on this proposal:
https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2

Shubham Das (2):
  ethtool: add interface capabilities query (intf-caps-get)
  ethtool: add PHY test framework (phy-test-get, phy-test-set)

 Documentation/netlink/specs/ethtool.yaml      | 211 ++++++++++++++++++
 include/linux/ethtool.h                       |  94 ++++++++
 include/linux/phy.h                           |  16 ++
 include/linux/phylink.h                       |   7 +
 .../uapi/linux/ethtool_netlink_generated.h    | 106 +++++++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/intf_caps.c                       | 130 +++++++++++
 net/ethtool/netlink.c                         |  24 ++
 net/ethtool/netlink.h                         |  10 +
 net/ethtool/phytest.c                         | 183 +++++++++++++++
 10 files changed, 782 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/intf_caps.c
 create mode 100644 net/ethtool/phytest.c


base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe
-- 
2.25.1

