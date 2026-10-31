Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413625;
	b=lAAhb8Qn+vqvnFONouFNWqwCpFEJVfc5O8slVqnNHgsrF9GT35HmLoFfjkYgrku61Bj6
	 nw1tQtnzQ5MpDDX0i3Zz2YJgpf5H/8pFCToFX8TsWYx1QgFz3U5QCEbEbVwxSskTWFNkM
	 pKW5fGHOuBhrU1elRExh2UI+Ib/cLq1U+O0kZBvKADi5mLdA5WA7P7mlovlLl2rRVTlyo
	 I6RBrtiiQeKJArMq0U4mUpG6kKqE0ha1zJ9MVTKZ7hJt8FYBTVz/EThoPVcYyHBnS2YQN
	 HMi2xUlqkvdo5j47HIdTVOaHr5skMSKKRZf6UHXnEukVzwmyJ2u1TJ9NnO6jIGR+XFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413625;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=29lzrQDKQhJkd273yOHGbx0kds4ErzcM/57QFd0LIGI=;
	b=wTjkc4tg9vs2e3BFwJ2jbHXHfOyPfcinKJKsKykUqvwARZJ0hsO0RVtP+rJaPqq9BkN5
	 87SJFKhYMLGs1D+PTnlawHMmG04bWdSEmpVONMN7HNa/TDUnDNZrGn7QgyqKDmpqayXHa
	 vECdn2GNa0Jza3O225eqSebygfoxUWcKsX6fsDdkX8kJVmmUZclst8PozHFp52ua8+J9e
	 6Vbcs78FK5Doc6PzZwsisFJABW9+Sblp5knVcT34+9JxkaF6ZlivWBEPrvnA5je5mNx7T
	 QQe4BLkd0bYVJmlkKChY+UF3qiMc4Tt1R2nuMILSeXI91EDmG/61KgCjlXzRS0O3Gbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Iu/N8xG2";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F9606A330
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217F9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iu/N8xG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793413622; x=1824949622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BycSqTNFSvvJvts+gcHeLU/qGm1sRGULL4Af3Kj5hw0=;
  b=Iu/N8xG2f6t9V4gBep9Zj+kFnaDJ2NjQ0MeWLjmF6exbWH9NgxrGORNe
   IAGRjsJ6uwOP2NNH8BN/7JNuuRXGe8CVLXLdnIYDQtSnLEmHOGpoXvW1v
   sm6jaFuv58hHPTgREEoU57CJrsXGsLc38EBLoLA3/MuaHeJ+SBVnui4OR
   N159X4FyhW7maID2dyNEyw8hlkiUxCtveqHYQqcBK+sz6/zXu7WetSFM4
   dp+KPm9SaGVEK/JXh/w7Y3zhoJ4Us0my1dIzpVGzqdN4lEFPaFnO6Qn6r
   qceIZ42unoDdiqH6CBY4TIN2wnZqoKohD7MobS6hMGV9yPbPVAb/3tFgD
   w==;
X-CSE-ConnectionGUID: gL1sZB8gRWqOW8h7zPay4g==
X-CSE-MsgGUID: b1dUggBZTC2NFS0jUKc3zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2186560"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2186560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:26:56 -0700
X-CSE-ConnectionGUID: vx2Kve73R0S6Cyy0HVnGxg==
X-CSE-MsgGUID: x6pKkIznRuKREOvxK1IfTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5476450"
Received: from liyifan1-desk.bj.intel.com ([10.238.152.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:26:54 -0700
From: Li Yifan <yifan2.li@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Li Lili <lili.li@intel.com>,
	Wang Jie <jie.wang@intel.com>
Subject: [PATCH iwl-net] igc: Disable PTM after the last device reset on remove
Date: Sat, 31 Oct 2026 10:19:28 +0800
Message-ID: <20261031021928.1714612-1-yifan2.li@intel.com>
X-Mailer: git-send-email 2.43.0
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

I225/I226 have a hardware issue: after a PTM dialog, the next device
reset through the RST bit of the Device Control register (CTRL.RST)
can make the device send a PTM Request. The device sends it even if
PTM is disabled in its PTM Control register (PCI config space), the EN
bit of its PTM_CTRL register (MMIO) is clear and Bus Master Enable is
clear, so the driver cannot stop it. Commit c080fe262f9e ("igc: Fix
possible system crash when loading module") disables PTM before bus
mastering because of a related issue (PTM Requests with bus mastering
disabled), but that does not stop the request at CTRL.RST.

The request is harmless while the upstream port has PTM enabled. Since
commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
upstream port when the last user goes away. igc_remove() calls
pci_disable_ptm() before unregister_netdev(). If the interface is up,
unregister_netdev() then resets the device through igc_close() ->
igc_down() -> igc_reset(). The upstream port now handles the PTM
Request as an Unsupported Request. On an Intel Nova Lake-S system with
an I226-LM, this triggers DPC on "modprobe -r igc". Recovery fails
because the driver is unbinding, and the next probe fails:

  pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
  pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
  pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000

Message code 0x52 in the TLP header is a PTM Request from 81:00.0.

Reset the device while the upstream port still has PTM enabled, so
that the PTM Request gets a response. Then disable PTM and bus
mastering. With this order, a later reset sends no PTM Request (tested
on I226-LM). igc_ptp_stop() has already cleared IGC_PTP_ENABLED, so no
new PTM dialog starts after this reset. If the interface is down,
unregister_netdev() does not reset the device, so reset it explicitly.
PTM is still disabled before bus mastering, as the related fix above
requires.

Skip the reset if the device cannot respond: error recovery is in
progress or has failed (pci_channel_offline()), the device is gone
(pci_device_is_present()), or igc_rd32() has already reported "PCIe
link lost" (IGC_REMOVED()). Otherwise the reset accesses a device in
error recovery, or polls all-ones register values for about two
seconds until igc_disable_pcie_master() times out.

Call pci_disable_ptm() only if PTM is enabled. pci_enable_ptm() can
fail in probe, for example if the upstream port does not support
PTM, and probe continues without PTM. The PCI/PTM change above
also made pci_disable_ptm() use a reference count: it decrements
dev->ptm_enable_cnt without a check, and then does the same for the
upstream port. Before, it did nothing if PTM was not enabled. After
a failed pci_enable_ptm(), the count of the device becomes negative
and stays negative after the driver unbinds. pcie_ptm_enabled()
returns true for a negative count, so after the next probe
igc_is_crosststamp_supported() reports PTM support and igc_ptp_reset()
starts PTM cycles on a device that does not have PTM enabled. Commit
650f197d8ea6 ("idpf: disable PTM on probe failure and on remove")
adds the same check to idpf.

Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Co-developed-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Yifan <yifan2.li@intel.com>
Tested-by: Wang Jie <jie.wang@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b8ac2f4fea5a..3ee8b05f0515 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7406,9 +7406,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	igc_ptp_stop(adapter);
 
-	pci_disable_ptm(pdev);
-	pci_clear_master(pdev);
-
 	set_bit(__IGC_DOWN, &adapter->state);
 
 	timer_delete_sync(&adapter->watchdog_timer);
@@ -7427,6 +7424,22 @@ static void igc_remove(struct pci_dev *pdev)
 	igc_release_hw_control(adapter);
 	unregister_netdev(netdev);
 
+	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
+	 * CTRL.RST, even with PTM and bus mastering disabled on the device.
+	 * Reset the device while PTM is still enabled on the upstream port,
+	 * so that the request gets a response. unregister_netdev() resets the
+	 * device only if the interface was up. Skip the reset if the device
+	 * cannot respond (error recovery, surprise removal or an earlier
+	 * "PCIe link lost"). Then disable PTM before bus mastering.
+	 */
+	if (!pci_channel_offline(pdev) && pci_device_is_present(pdev) &&
+	    !IGC_REMOVED(adapter->hw.hw_addr))
+		adapter->hw.mac.ops.reset_hw(&adapter->hw);
+
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
+	pci_clear_master(pdev);
+
 	igc_clear_interrupt_scheme(adapter);
 	pci_iounmap(pdev, adapter->io_addr);
 	pci_release_mem_regions(pdev);

base-commit: c550c1c9727726dcae121221c252013153fa5945
-- 
2.43.0

