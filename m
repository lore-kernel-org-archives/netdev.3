Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD521A23A6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632633; cv=none; b=oikHXhN/ZrjGxAIw1xN62rne45JTzLQofZLk3/SjTswBJ4Eok0skXWldfVC22dVkLzFJwFhrJfEUZW1mtZ1vqSw4KhbawiTz6enEbKx0YWPmvIQZNsESwp0iGIyEAkXocMG7VGc+dfj81RPi7OOjIyQEHp8oKVjf8LNc/IV3D2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632633; c=relaxed/simple;
	bh=hN0ccrB5kxvEcNpBHc4VO3mVvNz403UkgPYLDeDGAmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MDmhLk7Qse9ZZp3rHjYnRF9rjyRgbFv05PAs996okn8EEhgHxal/42pU7Hcs3bixG7UIDRg7a8YKbDXeAQdVo3h8WT7jb+S2F2n7XkppxrGBBSMy2MqaQEFiQdPYz2FY2xUu1QHOQGjBigq1Ymgx9vPt8RE6cj/Pg5rZpeZwQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4KYMvPl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4KYMvPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787632632; x=1819168632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hN0ccrB5kxvEcNpBHc4VO3mVvNz403UkgPYLDeDGAmk=;
  b=T4KYMvPlBhxajJhz4DuL7C9Lf9QRqDAFRAk7yl3wQIvgB6d9Yu4eqz/5
   j3PsDep3qc3nUGGUmwM1SdI6kxdjN9NONid6EIbjoux1hOS+RaL9G33wO
   9Y1abR+29ylp/2bzGdSvTy6b0H9bfFZNL9IDLGcZkikPZpsmr/fyX2tyw
   FxI2JOLTgYHC0avgU7R/oW353OCGqh+Oyj+0gy4enF0HAu0ESPRRXuFDm
   i4WuQwyJLB41mVzko4F6iBmbgor+kKdwCw7QwghKzBrs9uoIgkP71Cbfg
   8zap+Ma/Mx8S4SelAzTpeVghinR/+cQ+EN+q+9Zl+5BYmkcf1W4BSepNF
   w==;
X-CSE-ConnectionGUID: eteMj6wtQ6CrVNF5ajLS6g==
X-CSE-MsgGUID: OBp7rfhLSSGW4nuDJUQMdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105622519"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="105622519"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 21:37:11 -0700
X-CSE-ConnectionGUID: CRXZRvTvTQSt2eeotUiuiw==
X-CSE-MsgGUID: dkKeM28GTgCD92LbW0fROg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="262871909"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 21:37:10 -0700
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
Subject: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and PHY test
Date: Mon, 24 Aug 2026 23:37:06 -0500
Message-Id: <20260825043708.1512634-1-shubham.das@intel.com>
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
   interface. Each block represents a hardware point (MAC/PHY/MODULE)
   at a specific 802.3 sublayer (RS/PCS/FEC/PMA/PMD) with its
   supported capabilities (loopback, test patterns, BERT, error
   injection).

2. phy-test-get / phy-test-act: Per-block, per-lane PHY testing using
   test patterns, BERT (Bit Error Ratio Test), and error injection.
   The block_id from intf-caps-get identifies which hardware point
   to test.

The block model uses:
  - component: which hardware entity (MAC, PHY, MODULE)
  - sublayer: which 802.3 layer (RS, PCS, FEC, PMA, PMD)
  - instance: identifies multiple instances of the same component
    (e.g., internal vs external PHY)
  - depth: host-side vs line-side within the same sublayer

Prior discussion on this proposal:
Link: https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com/

Shubham Das (2):
  ethtool: add interface capabilities query (intf-caps-get)
  ethtool: add PHY test framework (phy-test-get, phy-test-act)

 Documentation/netlink/specs/ethtool.yaml      | 206 ++++++++++++++++++
 include/linux/ethtool.h                       |  92 ++++++++
 .../uapi/linux/ethtool_netlink_generated.h    | 104 +++++++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/intf_caps.c                       | 130 +++++++++++
 net/ethtool/netlink.c                         |  24 ++
 net/ethtool/netlink.h                         |   7 +
 net/ethtool/phytest.c                         | 171 +++++++++++++++
 8 files changed, 735 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/intf_caps.c
 create mode 100644 net/ethtool/phytest.c

-- 
2.25.1

