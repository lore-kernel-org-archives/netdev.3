Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C43A9D8D;
	Mon, 27 Jul 2026 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120740; cv=none; b=PvA4vUzRGnvQietm0PQWFKZY1vZ73vOJ99wKvbBB6aJFlMRJFdsSIOJRF/ybvA3uoWaKc7qiKX2Sk1rW41VLsLz42S6Ko9tBw96lljo3SG9NOTyfae27mcyRAV3mvLTZfAX7CG05VSS0bvNue6W1w9Bv3Gsq3L0oGZCTQ1VabS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120740; c=relaxed/simple;
	bh=Sk5DH1qpuOBhupZmJA2XGj/yvV0yby0XvSGR0ToxIsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m3asJT5HydJvIKB62L8mp+49xaaxjVFXDg6rTT67YfYDJnbSfp1Rk71SYju1yLEFteWz4jESbipWm2Y3U4Mf0RVWKR9qqokvJUcQifEObjNCYY+wbX66F8gwhvH/CuKhIBj6mNfmtpwSgWgkLz0r92TMfxOmuUI10WnHu6iCa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h7jlr1lLxzKHMXG;
	Mon, 27 Jul 2026 10:51:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6215E4058C;
	Mon, 27 Jul 2026 10:52:11 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCHdUTZx2ZqzpVbAA--.58003S2;
	Mon, 27 Jul 2026 10:52:11 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH net v4] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
Date: Mon, 27 Jul 2026 02:56:45 +0000
Message-Id: <20260727025645.2600363-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHdUTZx2ZqzpVbAA--.58003S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUtr1rZFWrGF4rKrWUXFb_yoWrtF1kpa
	yfG3WUCr4rJr17Jw4xAr4jgF98CayDA3W5Ar12gw1F9F1j9FyUJry7GFW3Gr4xuFyktr9x
	tryDJa4I9F4UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

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
---
v4:
- Increase minimum BAR0 size to SZ_64K to cover ICH/PCH flash registers
  (~57.1KB) aligned to the power-of-two PCI BAR boundary. (Sashiko)

v3: https://lore.kernel.org/all/20260722031603.1471127-1-pulehui@huaweicloud.com
- Align the minimum BAR0 size to the largest register access offset. (Andrew)

v2: https://lore.kernel.org/all/20260720133049.1289167-1-pulehui@huaweicloud.com
- Update comment about E1000_MMIO_LEN_MIN. (Breno)

v1: https://lore.kernel.org/all/20260715035850.588070-1-pulehui@huaweicloud.com

 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..f8eac648ac9a 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7450,6 +7450,12 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
2.34.1

