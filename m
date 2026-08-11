Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92125334C1F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468668; cv=none; b=GL0R2/5bx6hb8+NrEWxMVVTrOjVs4C/1oli8ER72cCk9BdVn872aUZF4Uih/nwUioF2804Okx8Jsv0YdUsZsVbavSGdXnYfxhJ/mIJJbQD/TNd1NKurmcY5/V8PyECw79ctrzi+CKXk2Uds2Z+36QASAZrmZq9yFj0sQ/Y3WBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468668; c=relaxed/simple;
	bh=pLbyMQYE8Aq6GirsTWhIic/NlIg0CHyFaHO9DYKDLYU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GqshXkRtxyd3HIW/9/GIcOPzYoEBoFHhJIkKtElwZUsY2EhL8XS7i8SC7T2D1MHqxL9TUUFa1FJiPgFBYT2OX4YjQQs4zSEQo1dR4HxPlxVSddZat076RPuj7OooAO7vD7keCyBiGB2mIchmO2wv88h3D2TKduoB8GSlwEdB92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlJVYvS6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlJVYvS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786468667; x=1818004667;
  h=from:to:cc:subject:date:message-id;
  bh=pLbyMQYE8Aq6GirsTWhIic/NlIg0CHyFaHO9DYKDLYU=;
  b=GlJVYvS6lYjg8wKiEKTbXrFT75S2ULouXbcP/509HGetwPf5mqTFXEKn
   0prMqw86yek43duYbG5YI50ugzTFQKcbNMBidsQ98HhjuiUI/L5drzFgg
   2vfRY31SPtOuVyeYsZG/1S5bS1IiueRXviPcQU3Rh0XaSqYCppJyBZn0Y
   bwxrc/zvcXgoA6e+ko2J5v/pl1zCI2jakZA/SvGkq2dDpiwZK3FsMfOTH
   1HzUDwoYIz8hLGKzX3Oxynn0jIdQVQQauL+CV/Qo/7Ijl56+Mm+n0WR/T
   aCmvis4Yh4Bp18i+1z12FmVhRYmgnJBNwp0CteQBXWGLXrP261WO/AAXZ
   A==;
X-CSE-ConnectionGUID: AbTv9FOFSOSJsbU4b7jKWg==
X-CSE-MsgGUID: uhPM8ViSTRKR4hcfDpvFWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98524028"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="98524028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:17:46 -0700
X-CSE-ConnectionGUID: jVcwHTueSJS5qhT6N12w7g==
X-CSE-MsgGUID: PW778NRWTKmYmGXFbI7Xqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="261640800"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2026 10:17:46 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	joshua.a.hay@intel.com
Subject: [PATCH iwl-net] idpf: fix possible race on remove during a reset
Date: Tue, 11 Aug 2026 10:17:51 -0700
Message-Id: <20260811171751.22165-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bb81e620c5c8..c2d7d92d0bf1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1031,12 +1031,8 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
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
2.37.3

