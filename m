Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE73CCA13
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636685; cv=none; b=SVXyGWyNgYUDygf3BgAXB308ORlOWwgA51klnxDzXo0gG5m8JBiz21wwNNMUdlYfxgWgFVZPfv16f89uAnkgJf0f7rVCQJ3mSIncf2z5e20GJVLJqb5bIIkOVu9gbqPchh9EDHn9SRjIeJIBZwbOYZYYuJUN1152JDYv9XbTjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636685; c=relaxed/simple;
	bh=XZw/T/8/46yNyrlnFBqEDyGMY1qbvn6cakt1Jpo0LAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh1A3GkpZfYDaJSB7qZa0zJoLergQISp1i9BMfzcPA8+1yeiMhDkofOAM4UDaOf2DqlR7lXZ8FejQfHYwE/GwoSPjoWbWKSwEWTLoT2Szhn45bzU78qXwof907XnNThL3vKAM1vCSF+MxQ7F6/7i75tKcHhkMvbsf2sLtJNBsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xd2XhyOt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xd2XhyOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636684; x=1822172684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZw/T/8/46yNyrlnFBqEDyGMY1qbvn6cakt1Jpo0LAA=;
  b=Xd2XhyOtHYJ2heS1X7kc63LtfD08gLsbQaR/fsFbX84JUv8eQ7cS9Cxj
   3wOlb69NvHE76T6csxBPTLNf6OVwuXzKkoj03TZC/fIR8q8NfEubTgOpi
   j2D2PtTsrDC4ALZR5OuxJr9GXfAGpCPpFYOevROC93znrW+GK/PNgFQlP
   CCgDkUSIjCleRFET8P9mZ9UGMfuYugzp7Vd/IIFvBksdXasMBcVWwIjkU
   S/o1y7iEaVzpwArlVxX8vlvL/nPdLDvHpKs7XnZi18WkIl4QHR81Csnkc
   x+kiVwxFCJJbJce7eEU2UjYmtvG7men229P6vrVS+iq+iJp+4EFG2GALC
   A==;
X-CSE-ConnectionGUID: lno/xayETvu7TLDtt2tzZw==
X-CSE-MsgGUID: W+CfdzYuTtuqlua1qwonrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513253"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513253"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:43 -0700
X-CSE-ConnectionGUID: fCEaq5DIRD26nEXblPCIew==
X-CSE-MsgGUID: n5iD5XFhTyGFQhsC/PfQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317683"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	luoxuanqiang@kylinos.cn,
	bryan.fraschetti@canonical.com,
	tristan@talencesecurity.com,
	tomasz.lichwala@linux.intel.com,
	david.butler@appgate.com,
	horms@kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/6] idpf: fix possible race on remove during a reset
Date: Mon, 28 Sep 2026 16:04:22 -0700
Message-ID: <20260928230429.495442-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Reset and remove can race, leaving NAPI registered and enabled:

modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf

[145561.805104] WARNING: net/core/dev.c:7699 at __netif_napi_del_locked+0x11a/0x130, CPU#30: rmmod/22393
...
[145561.810238] RIP: 0010:__netif_napi_del_locked+0x11a/0x130
...
[145561.817678] Call Trace:
[145561.818125]  <TASK>
[145561.818653]  free_netdev+0x110/0x2a0
[145561.819109]  idpf_vport_dealloc+0x452/0x460 [idpf]
[145561.819668]  ? enable_work+0x9f/0x100
[145561.820133]  idpf_deinit_task+0x51/0x70 [idpf]
[145561.820694]  idpf_vc_core_deinit+0x32/0x170 [idpf]
[145561.821193]  idpf_remove+0x40/0x200 [idpf]
[145561.821667]  pci_device_remove+0x40/0xa0
[145561.822132]  device_release_driver_internal+0x1a9/0x210
[145561.822691]  driver_detach+0x4b/0x90
[145561.823161]  bus_remove_driver+0x70/0x100
[145561.823721]  pci_unregister_driver+0x2e/0xb0
[145561.824207]  __do_sys_delete_module.constprop.0+0x190/0x2e0
[145561.824715]  ? kmem_cache_free+0x312/0x550
[145561.825213]  do_syscall_64+0xc8/0x6b0
[145561.825709]  ? clear_bhb_loop+0x30/0x80
[145561.826216]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[145561.826602] RIP: 0033:0x7fe628130beb

Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of the
IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to tear
down NAPI in idpf_detach_and_close(), which runs under RTNL lock.

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..2c148377540c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1033,12 +1033,8 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
  */
 static int idpf_stop(struct net_device *netdev)
 {
-	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport *vport;
 
-	if (test_bit(IDPF_REMOVE_IN_PROG, np->adapter->flags))
-		return 0;
-
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-- 
2.47.1

