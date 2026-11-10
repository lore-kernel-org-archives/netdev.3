Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291993;
	b=kNxYrlDT4T5hPON2seufQP0XjRjTQA8DAjJEUie1fNpGzl1Q5glE+RNrSu9yRo4TnJii
	 KpWt8bxlgd3XHPOczTVLryMpeO+t05I/kLzyj/mUqyQclrU9NMfwjcK2KPmFv6AxqrF5D
	 ny952D4y4CIzoo1qDD74Nv57/Nww0ydZh+wHh7+kosN1rW7+TNhRwAH7X7EVfZL1cz9vA
	 yQFWSeyOzTOhFrPFVsjnB433acP6GXs2Xg65qmVaJjbVa4NAsjHCFDSbWGzXt2aOansaE
	 0H8Q/LJrzdTR0BrHPQVIxcpYGwuSQrq4hsKBfNgfD1hooi3GWFOsrnxfwrA+5AqSS2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oKvhQdlmyU8cbBHUZLAQB3dkciqsGQQ8nvZbNqziVrc=;
	b=UAYfbqCH0u0Zv+4UV1rbv21QyZhDxRvSDXpLbi239XQzgGn58XhQT7egc6kZp72jr1j/
	 BW2D9UFEa3O8L7jmBAi11FIr4T1anm/qDucW21VjAJZFHqAjNW7BJP+QIRORjWucFdzt3
	 2+3tXLMPec1mv7qZooCdfUF0mkiwpz6w7r9NdqgMFIiz83987iPN0WFGyFL9qX7dl0SBZ
	 dEDS0ClxDFcywOk9ACcxY+ACayZi8J6IR68K1LpPEOTP2PMKUXcWtvKul/utSNjfgah7k
	 vhafo7f6WYBXArKSdM93GJhpt9ATgEloj/A+e4wQXgWBLcgrDLdI9u6NQHmgWYuvlTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCMDowx0;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29C606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB29C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCMDowx0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794291992; x=1825827992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WJ29dS6C9oitKWR92y4jzuIZaytkUqpFhiLPrPhz5kE=;
  b=HCMDowx0r4i3RBjVD+D/wA899ohBc2IRMMhmHHFYeLlzlnEq907wnVSW
   Q7UXwbvg4uxbIgHT/9R3lNZ0GkWhxGhW5hEs8pfCyA7hnQl2v2tV3BLPb
   stVS7LTt+e/wLXWkcUfzFcqffDHAVoppqYdAy9m47f1DKRjiygIsk/8RT
   754j8kKfAiKZgwlKWZhj6IuGV1qnyooK1K7lNYJFAfLR90vEJ7CRxJZg0
   r+aB8OsIsT2uSpqsD/CnNg6vbEHhHtQuj5JQ5xBHWrDGbARxt1azD2VQO
   5T1UwISbgJiHfotKNip50T48TMEVdTHzKfD+PD4xs9hFnjijg/3hEcD2s
   g==;
X-CSE-ConnectionGUID: uAaTzOITSG2ho7RPvTViTw==
X-CSE-MsgGUID: a1LcePS4QHm399gKy3tYUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2931882"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2931882"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 22:26:31 -0800
X-CSE-ConnectionGUID: ktim06GRT6ScK9ed0WPx+Q==
X-CSE-MsgGUID: dCt1uj24TBKTFI/E+YO5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8048139"
Received: from liyifan1-desk.bj.intel.com ([10.238.152.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 22:26:26 -0800
From: Li Yifan <yifan2.li@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Li Lili <lili.li@intel.com>,
	Wang Jie <jie.wang@intel.com>
Subject: [PATCH iwl-net v2] igc: Disable PTM after the last device reset on remove
Date: Tue, 10 Nov 2026 14:20:51 +0800
Message-ID: <20261110062051.2730678-1-yifan2.li@intel.com>
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

After a PTM dialog, I225/I226 can send a PTM Request at the next device
reset through the RST bit of the device-specific CTRL register
(CTRL.RST). The device sends it even when the PTM Enable bit in its PTM
Capability is clear. This is a hardware defect: a PTM Requester is
permitted to request PTM Master Time only when PTM is enabled (PCIe
r7.1 sec 6.21.3.1). The EN bit of the device-specific PTM_CTRL register
is also clear at that time, so the driver has no control that stops
the request.

The request is harmless while the upstream port has PTM enabled. Since
commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root
and Switch Upstream Ports"), pci_disable_ptm() also disables PTM on the
upstream port when the last user goes away. igc_remove() calls
pci_disable_ptm() before unregister_netdev(). If the interface is up,
unregister_netdev() then resets the device through igc_close() ->
igc_down() -> igc_reset(). The upstream port now handles the PTM
Request as an Unsupported Request, as the spec requires (sec 6.21.3).
On an Intel Nova Lake-S system with an I226-LM, this triggers DPC on
"modprobe -r igc". Recovery fails because the driver is unbinding, and
the next probe fails:

  pcieport 0000:80:1d.0: DPC: containment event, status:0x1f01: unmasked uncorrectable error detected
  pcieport 0000:80:1d.0:    [20] UnsupReq               (First)
  pcieport 0000:80:1d.0: AER:   TLP Header: 0x34000000 0x81000052 0x00000000 0x00000000

Message code 0x52 in the TLP header is a PTM Request from 81:00.0.

Call pci_disable_ptm() after the last reset of the device, so that the
upstream port still has PTM enabled and responds to the request. If the
interface is down, unregister_netdev() does not reset the device, so
reset it explicitly. Skip this reset if error recovery is in progress
or has failed, as igc_down() does before igc_reset().

Tests on an I226-LM show that this reset also clears the state: the
device sends the request only at the first CTRL.RST after a PTM dialog,
so a later reset sends nothing unless a new dialog runs.

No new dialog runs after this reset. The PCIe spec makes the mechanism
that starts a PTM dialog implementation specific (sec 6.21.3.1), so a
device can start dialogs at any time while PTM is enabled. I225/I226
start a dialog only when PTM_CTRL.EN is set and the driver sets the
TRIG bit in PTM_CTRL (the "PTM trigger mode" in commit 8e404ad95d2c
("igc: fix PTM cycle trigger logic")), or in an automatic cycle mode
that igc does not use. The request at CTRL.RST is the only exception
that we know of. igc sets EN and TRIG only in the PTP code, and
igc_ptp_stop() runs before the reset:

  - igc_ptp_suspend() -> igc_ptm_stop() clears PTM_CTRL.EN.
  - ptp_clock_unregister() removes the PHC and waits for the
    igc_ptp_getcrosststamp() calls in progress, so no new TRIG comes.
  - IGC_PTP_ENABLED is cleared, so igc_ptp_reset() returns early in the
    reset path and does not set EN or TRIG again.

pci_clear_master() stays where it is, so PTM Enable is now cleared
after bus mastering is disabled. This keeps what commit c080fe262f9e
("igc: Fix possible system crash when loading module") needs: the
device starts no PTM dialog while bus mastering is disabled, because
PTM_CTRL.EN is already clear.

Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Co-developed-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Lili <lili.li@intel.com>
Signed-off-by: Li Yifan <yifan2.li@intel.com>
Tested-by: Wang Jie <jie.wang@intel.com>
---
v2:
- Call CTRL the device-specific CTRL register. Describe the defect as a
  PTM Request with PTM Enable clear, and remove Bus Master Enable from
  the description of the defect (Bjorn).
- Leave pci_clear_master() where it is and move only pci_disable_ptm()
  (Bjorn). Retested this order on the I226-LM (v7.2.7 with the same
  change): reload x20 with the
  interface up; unload with the interface down or never up, then a
  manual CTRL.RST (no PTM Request); S3 and s2idle; unbind/bind;
  remove/rescan; runtime suspend; reload in parallel with S3 for 10
  minutes. No DPC.
- Explain why no new PTM dialog starts after the reset, and that
  starting dialogs only on TRIG is device-specific (Bjorn).
- Add PCIe r7.1 references for the defect, the Unsupported Request at
  the upstream port, and the dialog trigger.
- Keep only the pci_channel_offline() check before the reset (Bjorn).
- Drop the pcie_ptm_enabled() check before pci_disable_ptm(). The PCI
  core fix [1] (applied to pci/ptm for v7.5) handles a failed
  pci_enable_ptm() for all drivers. Without [1], this is the same as
  the current code, which also calls pci_disable_ptm() without a check.
- No erratum covers the PTM Request at CTRL.RST yet. I reported it to
  the I225/I226 hardware team and waiting update now. I

[1] https://lore.kernel.org/r/20261104121457.2108515-1-yifan2.li@intel.com

v1: https://lore.kernel.org/r/20261031021928.1714612-1-yifan2.li@intel.com
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 62a7c5178700..712b6db8e31b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7428,7 +7428,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	igc_ptp_stop(adapter);
 
-	pci_disable_ptm(pdev);
 	pci_clear_master(pdev);
 
 	set_bit(__IGC_DOWN, &adapter->state);
@@ -7449,6 +7448,17 @@ static void igc_remove(struct pci_dev *pdev)
 	igc_release_hw_control(adapter);
 	unregister_netdev(netdev);
 
+	/* After a PTM dialog, I225/I226 can send a PTM Request at the next
+	 * CTRL.RST, even with PTM disabled on the device. Reset the device
+	 * while PTM is still enabled on the upstream port, so that the
+	 * request gets a response. unregister_netdev() resets the device
+	 * only if the interface was up. Then disable PTM.
+	 */
+	if (!pci_channel_offline(pdev))
+		adapter->hw.mac.ops.reset_hw(&adapter->hw);
+
+	pci_disable_ptm(pdev);
+
 	igc_clear_interrupt_scheme(adapter);
 	pci_iounmap(pdev, adapter->io_addr);
 	pci_release_mem_regions(pdev);

base-commit: ca719d9d18e87e63f672fe6f0bcd53ad68b9248a
-- 
2.43.0

