Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D964C33FA
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005604; cv=none; b=Mp6E8kD1d58pYnT1uJCJXsgwKTmRB32jKYtmyhTxJSoAG+1SjvHhsFmn2xZmF5S9IdxEuDkyas3bXm67nn4squwYzri6aB2lBU2SJNxMgjny2CFov+Cger7TaK2Y4LReiX+2DEmFegQXNVJ+RT8WUfsjmwCn9TLFktH4zJETfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005604; c=relaxed/simple;
	bh=nv3YvRAEtdu2sntH79pYqskZL25598XWqtwbdjqCBmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOl9gSgkSkmvHanhV7fPof/mnuJ1vUhIvSuefBKNFzwUSAufmIEhT/SirHHPZCNk6nY5shAYkeBtMkc4MPFDc6LiRUAcP88tRmhwZ5wTwB9W71hFw4rC0C0vnEi0/Pl33X0q8brymqE2vTB+WIH//iDU66wnLBrbipRf3CmfE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDlm9Z+G; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDlm9Z+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790005602; x=1821541602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nv3YvRAEtdu2sntH79pYqskZL25598XWqtwbdjqCBmU=;
  b=ZDlm9Z+Gz6j/7+YwcU8AmObn2X/52gG1nqlwxAEqKIlms8uSH64JPaAK
   uRJTXUR183+J+oo6Q9q9LprW16VDFL/Iyaa7NMdb2vpyo1Vrgy4HIUIeh
   aUdtYraZnuOI2iTIpsAEThfBXaPNMvA+CsQjsZFJM7hFZfqBLHLoapYIu
   T2nT03yzTxl5OPQ5PdGy+Px/Alq0oQmfKht+JelyTCamOqDWtmokqsnfp
   A4W7lcw7rg87G3VdowOCjzydWUxCFqdZG5Jez1OsgC3+cOBw5NJuaCCO0
   GS3b/F/YY3PUM9yQx2/3BE3/tTO0kYbCtMHjj7S3R4JGTcKlNlTbhS5pT
   w==;
X-CSE-ConnectionGUID: YlOitjdrRqiYE6SgzspMbw==
X-CSE-MsgGUID: 2xVQSBA2QOipqjC+C6gONg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90553441"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90553441"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:46:41 -0700
X-CSE-ConnectionGUID: Xdzm+8AASmeL8SayeB4i1Q==
X-CSE-MsgGUID: /3JgFcKMQYaa6zorm2GjpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277498892"
Received: from txandevvm17u.an.intel.com ([10.122.196.193])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 08:46:41 -0700
From: Pei Lee Ling <pei.lee.ling@intel.com>
To: andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: shubham.das@intel.com,
	siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com,
	pei.lee.ling@intel.com
Subject: [RFC PATCH net-next 0/1] Add Clear fec-stats ethtool handler
Date: Mon, 21 Sep 2026 10:46:36 -0500
Message-ID: <20260921154637.2376544-1-pei.lee.ling@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool: Add Clear fec-stats ethtool handler 

During optical cable re-seating, transceiver swaps, or Bit Error Rate (BER) 
troubleshooting on 25G/100G/400G+ links, operators need to establish 
a clean baseline for physical-layer FEC error counters (corrected/uncorrectable blocks).

Introduce a standardized netlink fec-clear operation using the ETHTOOL_MSG_FEC_SET 
message type with an ETHTOOL_A_FEC_STATS_CLEAR attribute. This provides a consistent and
non-disruptive management interface that can be uniformly supported 
across all required drivers.

Pei Lee Ling (1):
  ethtool: Add Clear-fec-stats ethtool handler

 Documentation/netlink/specs/ethtool.yaml      |  3 ++
 include/linux/ethtool.h                       |  1 +
 include/uapi/linux/ethtool.h                  |  9 ++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  1 +
 net/ethtool/fec.c                             | 30 +++++++++++++++++--
 net/ethtool/netlink.h                         |  2 +-
 6 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.43.0

