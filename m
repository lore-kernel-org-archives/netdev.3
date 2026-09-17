Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FB3064B5;
	Thu, 17 Sep 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677951; cv=none; b=nkTeH68Am/2Tmk4NC5biYmkszUPCTAlYebp86OybXtx65d7n8oMyD/x9Xo3yUNBmkHRfUy0IuoixEXU9RhYkIayQYfQcVcxNdWYx0cSUVPXzRlFl5FxG/h5B7tjCRUu0H7oxAcUopUaMBuns5DNt4Nhx6whojFs9uK5OlAdDth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677951; c=relaxed/simple;
	bh=6h2ET/czH94AUBMIbJrqUDxH7pFf3R8w/S/LKVkMXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5zsmp6FcKF+9dbexEa4VuVeXAy8jT9Avou/8wekfmhfobIxL67XmXt8eLwmb4MJXRiXwivhDvmVPb+KXj+qZxRIRec/9c+f1KWrlnSoh03gc9P7ll3whlbTq9JQwtb0CFHa4F64D0CZn1HBY0wnbd4nwvrVMNFCmwEZEssr6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dATjc1ny; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dATjc1ny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789677950; x=1821213950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6h2ET/czH94AUBMIbJrqUDxH7pFf3R8w/S/LKVkMXeg=;
  b=dATjc1nyJQeagVzbwaGwWKwxMUk7w3uSJvd2BRLZlEaPHKn2su028Ywq
   yQ4nnF6O6H1cDl+e4rHb3A1+U5FnnvEQgFAHAuXzcV7C2brCP9Nd+fzPx
   jTWjEsrA/tDZ93dIJZg6f5Wc0q9z1b34BDkjVko+97kFxqHMOVcuOWZIi
   AtqletcfheNnhch7RbH7mBjCJVfArOV72w7Xy5TRuIdPTo4GdE7pwhdRr
   gpB7eEGE7rMxpkbbztJYGocL8aEERkAvRVT5XEjI6QsvT6Bs4gKvjpdjp
   u6/tpuX/tUKvsAycFpK1AqU+g35156vKMst69on8HtIKCkIHM67clJTBY
   w==;
X-CSE-ConnectionGUID: t/GJFjwgQ32XwTIEwNLhGw==
X-CSE-MsgGUID: 646dFh26QsC/XZezCVRmzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100739282"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100739282"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:45:48 -0700
X-CSE-ConnectionGUID: g9BaIqJVRYyuZ5HcpWcmzw==
X-CSE-MsgGUID: TCQXq+cTTVeKX+QyLhj3GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297502056"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 13:45:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	mheib@redhat.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 0/3][pull request] i40e: add runtime-tunable ATR sample rate
Date: Thu, 17 Sep 2026 13:45:37 -0700
Message-ID: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mohammad Heib says:

This series makes the Flow Director ATR sample rate configurable at
runtime through a devlink parameter.

On systems with many queues and high-rate TCP workloads, the fixed
default sampling interval can cause frequent Flow Director
reprogramming and TCP packet reordering. The optimal interval depends
on the workload and system configuration.

Patch 1 moves atr_sample_rate from per-ring to PF level, since it is
a global policy.

Patch 2 exposes it as a devlink runtime parameter so administrators
can tune it without rebuilding the driver.

Patch 3 fixes a pre-existing issue where re-enabling ATR via ethtool
private flags did not trigger a ring reset, leaving fd_ena stale in
the TX queue HW context.

The following are changes since commit 26ee8cd69d46a14b37ba5e512084fe80d730127a:
  net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Mohammad Heib (3):
  i40e: move ATR sample rate from ring to PF level
  i40e: add devlink parameter for Flow Director ATR sample rate
  i40e: trigger PF reset when re-enabling ATR via ethtool

 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  7 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 ++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +-
 7 files changed, 72 insertions(+), 10 deletions(-)

-- 
2.47.1

