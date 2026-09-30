Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5954E3238
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774556; cv=none; b=WHsSlGnQJtV03mzASbhRJdDw2PvzjZ2LesXce8FH3JELMBPHbSbah+v75eZZVqQpl3V799ynvsuZMCPal0jIFxqQUE0iPjvKTi4Hmklg3LXw2kXdI814K5ZAeW3c67b0tADtRstg7B+paBflCtqjetnlK7yBHgpzWtPklLf0+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774556; c=relaxed/simple;
	bh=rjK9iW4shIO0fKPXmJL055TD0TnsbDpeB/S6czl6ON8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRuNtyAVp4uWAOnZ+gCj598RSwzR5HR9ezOWiDekABTwD5k5gu+AAwIVjOJ1JkfUJiOBBCoBw/vVc4pCldJuTpsfqVZiwTPm+PACZDn1WWkLMda2F/W5L5qz3+24PdkRd9qdNAt+S8MfW/7ScpEVhKSIm5DG4BvZJx4VrH2oCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijh8MaQl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijh8MaQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774553; x=1822310553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjK9iW4shIO0fKPXmJL055TD0TnsbDpeB/S6czl6ON8=;
  b=ijh8MaQlEr31dGYqJBa5W24Lk1CtK65mAKHHayWzhhmWMk5ci6NIK4FZ
   hDehQjA/sefnFqvDnP48dfviikxNMQFblty6YbVjM4lZjNWMJp5JCRJAX
   +MsKO7F9Z6J33rid0VomUC7iXFkTr0cos4dsB2XlJ1KrkU9ZHy8XiIdDF
   D8xgZ6e4FbOQr8e4HlQObCffAd9L3zrU05y0a5dUdbvVoFp+mL4pDfnAa
   G699jK9X5PmfWqGLM+qsLf9S49oYH8jo7fOeOR33cVwPDjGYzbxTVtYIr
   BFDxNZZyvljdDrjAe1QS/OOviXB2JvIK6XcXUX5sy0WEjMp0b+9//dfGd
   w==;
X-CSE-ConnectionGUID: Lna0l4OSTdqzJd/MZpZvzA==
X-CSE-MsgGUID: RXnLA9/7Se6LfNXTu8UTeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102185787"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102185787"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:30 -0700
X-CSE-ConnectionGUID: 2SbCUcUzT+CArVeUK1hmKw==
X-CSE-MsgGUID: /zVthoK9RAu26RASLsagAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275827246"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:29 -0700
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
Subject: [RFC ethtool 0/2] add interface caps and PHY tests
Date: Wed, 30 Sep 2026 08:21:49 -0500
Message-Id: <20260930132151.932792-4-shubham.das@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930132151.932792-1-shubham.das@intel.com>
References: <20260930132151.932792-1-shubham.das@intel.com>
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
  ethtool: Add interface capability get support
  ethtool: Add PHY test and BERT support

 Makefile.am                            |   2 +
 ethtool.c                              |  21 ++
 netlink/desc-ethtool.c                 |  18 ++
 netlink/extapi.h                       |   6 +
 netlink/intf_caps.c                    | 230 ++++++++++++++++
 netlink/phytest.c                      | 352 +++++++++++++++++++++++++
 uapi/linux/ethtool_netlink_generated.h | 104 ++++++++
 7 files changed, 733 insertions(+)
 create mode 100644 netlink/intf_caps.c
 create mode 100644 netlink/phytest.c


base-commit: ec1ef702cb5e8bda6bd5fe3b2213419c8427bb7c
-- 
2.25.1

