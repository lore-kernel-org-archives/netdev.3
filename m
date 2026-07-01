Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700F3B27EE;
	Wed,  1 Jul 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899684; cv=none; b=Qdx1lt94rbwwaOXH0RUJUfzvPu5bD2an4mQZGDXc3+QBTAFesCzL5LhaosQC1kwp885ULqyC3NV249f1mHJkS7Nav2Y0acyDro9P+USBnyBNUkf/rLI6MTpqGssDQmBb14JNIgTvFLJ1ufK4PxVmdevcAi/aB42AH6Yxkm4E5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899684; c=relaxed/simple;
	bh=78GZqLBubj8E9uX/o9e6hxnuHbGruLQCoTLyXDTACW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGAOOTeWAArguTgkTUCXkTSa/+4qb7oH+jz4dvmFKmZAymb/7pGsXp7bU+4OBOHH4ilXeHWRuqHyiU1g4kpnccOHczP6z51/YDNq6wwZhc0XIgtgivwOObJXlGDbTsoUHemP1h75qF3MO25IReeSH0LiGXCPbsAhvfVB0YMy/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Oae3uNUB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Oae3uNUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=su
	nDimvKPAGXr1s3eNxIeBtTHJPCyhFgFWGTZXYX4go=; b=Oae3uNUBWnLZyIfBV6
	XXUfuPtOiKuT/5dHMyrN8XZHbgOyWsIJ1n05S3Fh7kwAQPdm9BFQ0ol/X2S0/cU1
	psXXdstEvL5HiIGKvJfN/vB2ypvXop1cWML9HfVeTF5Dlu0Z0xtezlDvzG2lPKz9
	qvsjXQAsEcJ7d6r+6SrcnMgIs=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnZKKq40RqU6VxHA--.29763S2;
	Wed, 01 Jul 2026 17:53:47 +0800 (CST)
From: zwq2226404116@163.com
To: mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Wanquan Zhong <wanquan.zhong@fibocom.com>
Subject: [PATCH v3 1/1] bus: mhi: pci_generic: fix Rolling Wireless RW135R-GL and RW151 support
Date: Wed,  1 Jul 2026 17:53:44 +0800
Message-ID: <20260701095344.309409-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnZKKq40RqU6VxHA--.29763S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWxCF15ZF18Gr18Gw13CFg_yoW5Gr1kpF
	4SvrWUtr4vvFyF9ay8A3s7GFyrXan8XrZrKF98G34xC34Yy34UtrW0g34agFyYvFZ2qFWY
	vrsYg3yxZF4UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um1v-UUUUU=
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0gvOJmpE46uzyAAA3s

From: Wanquan Zhong <wanquan.zhong@fibocom.com>

bus: mhi: pci_generic: fix Rolling Wireless RW135R-GL and RW151 support

- Increase RW151 MBIM channel ring size from 4 to 32

On HP and Lenovo laptop platforms the device probes successfully and
WWAN ports are created, but pci_generic enables runtime autosuspend
(PCI D3hot/M3) after a short idle period. Resume from runtime PM leaves
the modem in MHI SYS ERROR; driver recovery (reset) fails and the device
becomes inaccessible (PCIe config space reads as 0x7f). The failure is not
self-recoverable while runtime PM remains enabled; keeping power/control=on
avoids the issue.

Set no_m3 on RW135R-GL and RW151 so probe does not enable runtime M3
autosuspend for these modules.

Power management testing (separate from runtime PM above):
- Suspend-to-RAM (S3/mem): tested on RW135R-GL and RW151; MHI/MBIM/wwan
  function after wake.
- Suspend-to-disk (hibernate): not available on the test platforms
  (/sys/power/state lacks "disk", ENODEV).

Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>

---
v2 -> v3: RW151 MBIM ring size 32; disable runtime M3 (no_m3)
 drivers/bus/mhi/host/pci_generic.c | 4 +++-
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index d598bb3b3981..d0fee7e3ba3a 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -942,6 +942,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
 	.sideband_wake = false,
+	.no_m3 = true,
 	.mru_default = 32768,
 	.edl_trigger = true,
 };
@@ -949,8 +950,8 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
 static const struct mhi_channel_config mhi_rolling_rw151_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
 	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
-	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
-	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
@@ -986,6 +987,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw151_info = {
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
 	.sideband_wake = false,
+	.no_m3 = true,
 	.mru_default = 32768,
 	.edl_trigger = true,
 };

--
2.50.0

