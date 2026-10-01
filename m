Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D14BD787
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893514; cv=none; b=tZE/6zHgminBH+xvcddKrohlCZHt+UwwyqLaZNh0Y/wnPoMaR1OFvu9d5HQC1JbFDXnmTOu8wrAXPum+Q391HMed6QrBbGsQ1s34SrojFo2IRK+Fzwpvzzt8b2A89ixFgiZ59cvLIpnTmOpbMbSa97Core3xLEnTqMLOamOjKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893514; c=relaxed/simple;
	bh=POSl68kFPGbCoRjtqqaB1NYVe0qtrdkZ4chVJ+5N+TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqF0wVra3wOKw8UxZTEJAv6wY7xFgILkFAQqi7mzgHHrIy4RW4ar3pWAptKcU7r8OwSm4I4AfDb4jdJgGH2jrehITweHrnqWN02y8Y2a5eJWodU8D7LOZtFxZvYZoGhEoH2/3uvJnMaTCGM/PlVt/N1pr9w4C8fdrNYvuJA7CRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIay4Eqv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIay4Eqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893503; x=1822429503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=POSl68kFPGbCoRjtqqaB1NYVe0qtrdkZ4chVJ+5N+TU=;
  b=kIay4EqvQ+a/3v8fbYLvcbwqCRUKS9efm9lLNYTkeNgUvmklw5si4uPm
   9R8Uz1crw149wO9N1VVkQOaTb7+Zu4vcHhDg6Mpg+yQBuIt9URbAtAzTM
   6BuHNwI2mIbChqLBASyAiMQSC/fu9iqfoC7rnPKItO+AKe390KYIyuqrS
   R+yKFliG912jOim0oy9POqPA8RcXwpSbgH43VtbWdV6FADcc4xKkzqN7L
   M9K5HGKJU77Jm0tQqS8YO/BsZhNTrUOCai334+GbmPRVYmhKUcN/8QvNI
   bynNQjHLwGfScbpbyjmdYhWp6ImYsBJCjXszrpWWUZqo5e9leuN5VFpeO
   w==;
X-CSE-ConnectionGUID: MqtvI2kcR8OSbiK95UGcQw==
X-CSE-MsgGUID: Se2mtstwQs6ekBJkoB0pvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567748"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:59 -0700
X-CSE-ConnectionGUID: apN3S6SzQEi0mHeX7OdaNA==
X-CSE-MsgGUID: itn4LVJaQYShuI6Ex/cdew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863777"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Pu Lehui <pulehui@huawei.com>,
	anthony.l.nguyen@intel.com,
	florian.bezdeka@siemens.com,
	meng.ding@siemens.com,
	p@1g4.org,
	tkusters@aweta.nl,
	jiayuan.chen@linux.dev,
	dima.ruinskiy@intel.com
Subject: [PATCH net 5/6] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
Date: Thu,  1 Oct 2026 15:24:38 -0700
Message-ID: <20261001222443.3500206-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pu Lehui <pulehui@huawei.com>

Syzkaller reported a kernel panic caused by an out-of-bounds MMIO
access in the e1000e driver.

[   82.868719][  T404] e1000e 0000:00:02.0: The NVM Checksum Is Not Valid
[   82.872328][  T404] Unable to handle kernel paging request at virtual address ffff80008894e090
[   83.085218][  T404] CPU: 2 UID: 0 PID: 404 Comm: bash Not tainted 7.2.0-rc2-g3f1f75536668 #1 PREEMPTLAZY
[   83.129013][  T404] pc : e1000_get_cfg_done_82571+0x70/0x158
[   83.140092][  T404] lr : e1000_get_cfg_done_82571+0x68/0x158
[   83.151196][  T404] sp : ffff80008ac37410
[   83.158922][  T404] x29: ffff80008ac37410 x28: ffff0000cd6a11b8 x27: ffff0000c58190d0
[   83.173919][  T404] x26: ffff0000cd6a11b8 x25: ffff0000cd6a0bc0 x24: ffff0000cd6a0000
[   83.189417][  T404] x23: 0000000000001010 x22: ffff0000cd6a11c0 x21: ffff0000cd6a11b8
[   83.205195][  T404] x20: 0000000000000064 x19: ffff80008894e090 x18: 0000000000000000
[   83.220545][  T404] x17: ffff800081c1a3f4 x16: ffff800081c19c10 x15: ffff800081e86510
[   83.235764][  T404] x14: 0000000000000001 x13: 0000000000000001 x12: ffff60001bc8a8b3
[   83.251301][  T404] x11: 1fffe0001bc8a8b2 x10: ffff60001bc8a8b2 x9 : ffff800081eae25c
[   83.266705][  T404] x8 : 00009fffe437574e x7 : ffff0000de454593 x6 : 0000000000000001
[   83.281919][  T404] x5 : ffff0000cf2b9640 x4 : 0000000000000000 x3 : dfff800000000000
[   83.297317][  T404] x2 : 0000000000000007 x1 : ffff0000cd6a11c0 x0 : 0000000000000000
[   83.312601][  T404] Call trace:
[   83.318662][  T404]  e1000_get_cfg_done_82571+0x70/0x158 (P)
[   83.329748][  T404]  e1000e_phy_hw_reset_generic+0x17c/0x1a8
[   83.341541][  T404]  e1000_probe+0xbd8/0x1988
[   83.350334][  T404]  local_pci_probe+0x84/0x130

Repetition steps:
1. Find PCI device which BAR0 size <= 4K. If it's:
   Device Addr: 0000:00:02.0   BAR0 SIZE: 4K
   Vendor/Device ID: 0x1af4 0x1004
2. Unbind the above PCI device
   echo '0000:00:02.0' > /sys/bus/pci/devices/0000:00:02.0/driver/unbind
3. Set the above device to e1000e new_id
   echo '1af4 1004' > /sys/bus/pci/drivers/e1000e/new_id

During e1000_probe(), the driver maps the device's BAR0 memory region.
If the device has a 4K BAR0, ioremap() maps only 4K of space. Later in
the probe process, when the NVM checksum validation fails, the driver
attempts to perform a hardware reset and falls back to the err_eeprom
cleanup path.

This cleanup path will trigger an OOB access kernel panic:
e1000_phy_hw_reset
  e1000e_phy_hw_reset_generic
    e1000_get_cfg_done_82571
      er32(EEMNGCTL)
        readl(hw->hw_addr + EEMNGCTL); <-- EEMNGCTL(0x1010) > 4K, OOB access

Fix this by verifying that the MMIO length (pci_resource_len(pdev, 0))
is at least SZ_64K before calling ioremap(). This accounts not only for
standard registers up to E1000_SYSSTMPH, but also for flash registers
mapped on ICH/PCH chipsets (up to offset 0xE074 / ~57.1 KB). Since PCI
BAR sizes are power-of-two aligned, SZ_64K is the minimum valid BAR0
size required to ensure all subsequent MMIO accesses remain strictly
within the mapped boundary.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 746a39586999..ad9b88c9af22 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7455,6 +7455,12 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mmio_len = pci_resource_len(pdev, 0);
 
 	err = -EIO;
+	/* Smallest BAR0 that covers every register the driver accesses */
+	if (mmio_len < SZ_64K) {
+		dev_err(&pdev->dev, "MMIO len is too small\n");
+		goto err_ioremap;
+	}
+
 	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
 	if (!adapter->hw.hw_addr)
 		goto err_ioremap;
-- 
2.47.1

