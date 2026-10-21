Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574202;
	b=e4lasm5UrlPW6aJil55X92kgcPuMrqIAtB/ZEd2eT0DZh3KKKCTG6/KGgomD2pkn7tSo
	 ylur0eJi88EoHMzGkWhAgwR3Saxcs3fDn8sBEO63sc5cRGi1XG0S+4T/+ULE1zSZ8i6tP
	 e7hSjr5kkwu9FX3NzeWIw4PbejVBB/xnzvPxEKedr5LDk1vfOq61edeHTYJuPO9zqNC31
	 0DPRAzjFJQsvcy16QhsuX+T7r47ffJ4c3NQKKEn65tgOJhPfVuUYnj5uZdwwMmLLeG8KL
	 yOWx9P34+slsDj7T9H3E9Rqwlsyl2R3UHPEJhvJaj6q8YTMGskNsbR2xz0Mg4biMpqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574202;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=RrMjYnMi8ktHxiTV2sSqusS5AhFq1o0nr7mByeFZK6Q=;
	b=HDJYIQcDYhz/3ryiZFp/3Cbdw3xUCFKj92J8dlUBC9xI5BemVZmtvT1DvJ2j2SY4nM5l
	 ZfH4zc16DlIAvpJR5Llwv3pcNuPGlFh8QGu9WJ005gMQkiFCFm9g3RPDDbJE7Zs7e81XC
	 LDuBEVAeYsFaunW+dMkOWaadv63iQxJZZ8f0gize21SZwiQQ7mbSihwC2woAKW6w7q0MI
	 7llFJqssbSRd4KNfiBfeYeShBBIAuBycv7ezI/YTk+hhyTHOEpfa1KS8mM+aDK/opkKSf
	 1GQy3ar0xZWmsaNklVSbCxF9/G+rOcftxBgUMb1JVW60fPv/12UuqOu9u+q1/kiLJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=fibocom.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZOUVZ7Me;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF53606A31D;
	Wed, 21 Oct 2026 09:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF53606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZOUVZ7Me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rr
	MjYnMi8ktHxiTV2sSqusS5AhFq1o0nr7mByeFZK6Q=; b=ZOUVZ7Metyj3KKF7Qj
	p4zjj7bNpa+z5XXRlAoRZ+BdX0DqpxjyYE3mQhJu18rbz37zLOY4//svu5CEoelf
	mjAyJzF7yhdYX/jbgG7RwBt8SIX80mhsHv/3LE1k8ZW0/SH9g+HwrDwEh/WJFUa/
	VsOEuv76ZvqAYr8JA/qJk/Hgw=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnr9PGgthqi5y2BQ--.62596S3;
	Wed, 21 Oct 2026 17:15:58 +0800 (CST)
From: Wanquan Zhong <wanquan.zhong@fibocom.com>
To: mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Wanquan Zhong <wanquan.zhong@fibocom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v6 1/2] bus: mhi: pci_generic: add Rolling Wireless RW135R-GL and RW151 support
Date: Wed, 21 Oct 2026 17:15:47 +0800
Message-ID: <7079b32572647d64207ce3f354ce63bbe481071c.1792573876.git.zwq2226404116@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792573876.git.zwq2226404116@163.com>
References: <cover.1792573876.git.zwq2226404116@163.com>
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
X-CM-TRANSID:_____wDnr9PGgthqi5y2BQ--.62596S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr45Cw1Utw1xCF17Xw47Arb_yoW3ZF4fpF
	WSyrZ5tr4kJw15uFW8Ary8GF9Yvan5GryUKrsrKw1Ig3W0ya10qay8K347trWYvw4vgr1F
	9Fn8Cr1xuanrJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiTmDUUUUU=
Sender: zwq2226404116@163.com
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0Q+k+2rYgs8LWQAA3s

Add MHI PCIe device configuration for Rolling Wireless modules:

- RW135R-GL (Qualcomm sdx35): SAHARA, DIAG, MBIM, DUN, FIREHOSE, ADB,
  NMEA and IP_HW0
- RW151 (Qualcomm sdx75): the same channel layout

Register PCI_DEVICE_SUB entries per chipset:

- RW135R-GL on QCOM 0x011a (sdx35): sub-vendor 0x2099, sub-device
  0x1300/0x1301
- RW151 on QCOM 0x0309 (sdx75): sub-vendor 0x2099, sub-device
  0x1500/0x1501/0x1502; HP OEM sub-vendor 0x103c, sub-device
  0x8fb8/0x8fb4

Use Rolling-specific EDL firmware paths under qcom/sdx35/rolling/ and
qcom/sdx75/rolling/.

Tested suspend-to-RAM (mem) on Rolling RW135R-GL and RW151 hardware: MHI
resumes cleanly and MBIM/wwan function after wake. Hibernate (disk) could
not be tested on this platform (/sys/power/state lacks "disk", ENODEV).

Tested-on: Rolling RW135R-GL hardware (MHI probe, MBIM, DIAG, ADB,
suspend-to-RAM)
Tested-on: Rolling RW151 hardware (MHI probe, MBIM, DIAG, ADB,
suspend-to-RAM)

Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
---
Changes in v6:
- Resend as a standalone series against current mhi-next; v3-v5 were
  incremental on an unmerged local tree
- Include full RW135R-GL and RW151 channel/event config (never merged)
- Add RW151 PCI IDs 2099:1501 and 2099:1502
- Drop no_m3
- Set RW151 MBIM ring size to 32 to match firmware
- Add SAHARA SBL channels for EDL
- Move NMEA from channels 14/15 to 60/61
- Align RW151 DIAG ring (64) and timeout (8000 ms) with RW135R-GL

Changes in v5:
- Add RW151 PCI IDs 2099:1501 and 2099:1502

Changes in v4:
- Drop no_m3 quirk per review; keep RW151 MBIM ring size fix only

Changes in v3:
- Increase RW151 MBIM ring size from 4 to 32

Changes in v2:
- Correct Rolling EDL firmware paths
- Fix RW151 PCI subsystem IDs
- Document suspend-to-RAM testing

 drivers/bus/mhi/host/pci_generic.c | 113 +++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index b636e2c23b4d..353e3a2c954c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -948,6 +948,98 @@ static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
 	.sideband_wake = true,
 };
 
+static const struct mhi_channel_config mhi_rolling_rw135r_channels[] = {
+	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(36, "ADB", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(37, "ADB", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(60, "NMEA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(61, "NMEA", 32, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
+};
+
+static struct mhi_event_config mhi_rolling_rw135r_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 128),
+	MHI_EVENT_CONFIG_DATA(1, 128),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101),
+};
+
+static const struct mhi_controller_config modem_rolling_rw135r_config = {
+	.max_channels = 128,
+	.timeout_ms = 8000,
+	.num_channels = ARRAY_SIZE(mhi_rolling_rw135r_channels),
+	.ch_cfg = mhi_rolling_rw135r_channels,
+	.num_events = ARRAY_SIZE(mhi_rolling_rw135r_events),
+	.event_cfg = mhi_rolling_rw135r_events,
+};
+
+static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
+	.name = "rolling-rw135r",
+	.edl = "qcom/sdx35/rolling/prog_firehose_ddr.elf",
+	.config = &modem_rolling_rw135r_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+	.edl_trigger = true,
+};
+
+static const struct mhi_channel_config mhi_rolling_rw151_channels[] = {
+	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 1),
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
+	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(36, "ADB", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(37, "ADB", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(60, "NMEA", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(61, "NMEA", 32, 0),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
+};
+
+static struct mhi_event_config mhi_rolling_rw151_events[] = {
+	MHI_EVENT_CONFIG_CTRL(0, 128),
+	MHI_EVENT_CONFIG_DATA(1, 128),
+	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101),
+};
+
+static const struct mhi_controller_config modem_rolling_rw151_config = {
+	.max_channels = 128,
+	.timeout_ms = 8000,
+	.num_channels = ARRAY_SIZE(mhi_rolling_rw151_channels),
+	.ch_cfg = mhi_rolling_rw151_channels,
+	.num_events = ARRAY_SIZE(mhi_rolling_rw151_events),
+	.event_cfg = mhi_rolling_rw151_events,
+};
+
+static const struct mhi_pci_dev_info mhi_rolling_rw151_info = {
+	.name = "rolling-rw151",
+	.edl = "qcom/sdx75/rolling/prog_firehose_lite.elf",
+	.config = &modem_rolling_rw151_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+	.edl_trigger = true,
+};
+
 /* Keep the list sorted based on the PID. New VID should be added as the last entry */
 static const struct pci_device_id mhi_pci_id_table[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0116),
@@ -961,6 +1053,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* Telit FE912C04 (sdx35) */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x1c5d, 0x2045),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fe912c04_info },
+	/* Rolling RW135R-GL (sdx35) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x2099, 0x1300),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw135r_info },
+	/* Rolling RW135R-GL (sdx35) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x011a, 0x2099, 0x1301),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw135r_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x011a),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx35_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
@@ -995,6 +1093,21 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	/* Telit FE990B40 (sdx72) */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x1c5d, 0x2025),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fe990b40_info },
+	/* Rolling RW151 (sdx75) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x2099, 0x1500),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
+	/* Rolling RW151 (sdx75) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x2099, 0x1501),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
+	/* Rolling RW151 (sdx75) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x2099, 0x1502),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
+	/* Rolling RW151 (sdx75) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x103c, 0x8fb8),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
+	/* Rolling RW151 (sdx75) */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0309, 0x103c, 0x8fb4),
+		.driver_data = (kernel_ulong_t) &mhi_rolling_rw151_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	/* QDU100, x100-DU */
-- 
2.53.0

