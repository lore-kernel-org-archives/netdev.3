Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27F409102;
	Wed,  2 Sep 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340038; cv=none; b=Sak8E7fvdV2omxtAZJhyl4WmV+W1sLaZGaNBEC3IN2bb7jovBm3WuQR79NTf3i71hoygCEW7ES95oWTNxRl13Rqbaz326HSkIuwdo7ggSgSCKTxE8RSgdAqmkXbAuFtN+m4RFgkwiyX0U0+Q1PN6hmX27gwnHEGFeG6pl48qkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340038; c=relaxed/simple;
	bh=LX9uOqlwBPrBe410G69vSQhjrQxsEBebTvxfKqOcK3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apKEzm38oWmewMIF74ipZravgmdd2NN9nEITGtv5KPWSP6fbEtv3edBWSIa4HOW0clCXpmFoxqADYYkR0Ud0sOCFzlCfagLCeIx4tMRuQOKxn6f+U+e6WUYcfTBtCR+okp8g7ts3NjDsjifEmsCYpo8atkTABJxas6U5LWpF1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ezgSkWtH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ezgSkWtH"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68296kA522527055, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788340006; bh=mrX9eFLbyMxwFNjKobw0vdtjacMxILk8uqsqVOGoSIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ezgSkWtHM1NbA5pXS++UlzVImhTbvjh9YCndq4/bbB4x4jC43pqfluzqbXgzv0wXH
	 6s9zPhUlJuA/o4nRKMdxxkLIy79M/kEXlqPHte9fM32+8RClsAO6Cyv7YftxsuyoKU
	 uJJ1Bcpd6BbBhpjCGVaEQguSNPgYccwqgytzwcu4VXZ20UhQkH7xgRByNh0pjoY5LJ
	 gzmENycGO74eEgaXvblU01+GuD3oyLvAsMLoPlrTLrIWCtNZ4+QwZEbiqMz7AAKN5D
	 4aCEFVbi4E1qqW4rMHMLH0QVuqYDFOXqB7EZO8qobBYQ8xjCSbBliML7rMzW1DRqDt
	 yOepiFZ/v/aTg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68296kA522527055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 17:06:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 17:06:46 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Wed, 2 Sep 2026 17:06:46 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 6/8] r8152: add TGPHY access support
Date: Wed, 2 Sep 2026 17:06:30 +0800
Message-ID: <20260902090632.41844-7-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902090632.41844-1-nic_swsd@realtek.com>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add TGPHY read/write support for RTL8157 and RTL8159.

To dispatch the read/write helpers, add two new function pointers,
phy_read and phy_write, in struct rtl_ops.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 94 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0cc3e8cedb84d..b4c2cef0b9092 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -162,6 +162,9 @@
 #define USB_ADV_ADDR		0xd5d6
 #define USB_ADV_DATA		0xd5d8
 #define USB_ADV_CMD		0xd5dc
+#define USB_TGPHY_ADDR		0xd630
+#define USB_TGPHY_DATA		0xd632
+#define USB_TGPHY_CMD		0xd634
 #define USB_UPS_CTRL		0xd800
 #define USB_POWER_CUT		0xd80a
 #define USB_MISC_0		0xd81a
@@ -511,6 +514,10 @@
 #define ADV_CMD_WR		BIT(1)
 #define ADV_CMD_IP		BIT(2)
 
+/* USB_TGPHY_CMD */
+#define TGPHY_CMD_BUSY		BIT(0)
+#define TGPHY_CMD_WR		BIT(1)
+
 /* USB_UPS_CTRL */
 #define POWER_CUT		0x0100
 
@@ -960,6 +967,8 @@ struct r8152 {
 		void (*hw_phy_cfg)(struct r8152 *tp);
 		void (*autosuspend_en)(struct r8152 *tp, bool enable);
 		void (*change_mtu)(struct r8152 *tp);
+		u16 (*phy_read)(struct r8152 *tp, u16 addr);
+		void (*phy_write)(struct r8152 *tp, u16 addr, u16 data);
 	} rtl_ops;
 
 	struct ups_info {
@@ -1666,7 +1675,7 @@ static void ocp_write_byte(struct r8152 *tp, u16 type, u16 index, u32 data)
 	generic_ocp_write(tp, index, byen, sizeof(tmp), &tmp, type);
 }
 
-static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
+static u16 r8152_phy_read(struct r8152 *tp, u16 addr)
 {
 	u16 ocp_base, ocp_index;
 
@@ -1680,7 +1689,7 @@ static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
 	return ocp_read_word(tp, MCU_TYPE_PLA, ocp_index);
 }
 
-static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
+static void r8152_phy_write(struct r8152 *tp, u16 addr, u16 data)
 {
 	u16 ocp_base, ocp_index;
 
@@ -1694,6 +1703,16 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
 	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
 }
 
+static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
+{
+	return tp->rtl_ops.phy_read(tp, addr);
+}
+
+static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
+{
+	tp->rtl_ops.phy_write(tp, addr, data);
+}
+
 static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
 {
 	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
@@ -2030,6 +2049,61 @@ static int r8152_mdio_test_and_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
 	return data & clear;
 }
 
+static int wait_tgphy_cmd_ready(struct r8152 *tp)
+{
+	u16 ocp_data;
+
+	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB,
+							USB_TGPHY_CMD),
+			       !(ocp_data & TGPHY_CMD_BUSY), 2000, 20000,
+			       false);
+}
+
+static int rtl_tgphy_access(struct r8152 *tp, u16 addr, u16 *data, bool write)
+{
+	u16 cmd = 0;
+	int ret;
+
+	ret = wait_tgphy_cmd_ready(tp);
+	if (ret < 0)
+		goto out;
+
+	if (write) {
+		cmd |= TGPHY_CMD_WR;
+		ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA, *data);
+	}
+
+	ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_ADDR, addr);
+
+	cmd |= TGPHY_CMD_BUSY;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_CMD, cmd);
+
+	if (!write) {
+		ret = wait_tgphy_cmd_ready(tp);
+		if (ret < 0)
+			goto out;
+
+		*data = ocp_read_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA);
+	}
+
+out:
+	return ret;
+}
+
+static u16 r8157_phy_read(struct r8152 *tp, u16 addr)
+{
+	u16 data = 0;
+
+	rtl_tgphy_access(tp, addr, &data, false);
+
+	return data;
+}
+
+static void r8157_phy_write(struct r8152 *tp, u16 addr, u16 data)
+{
+	rtl_tgphy_access(tp, addr, &data, true);
+}
+
 static int
 r8152_submit_rx(struct r8152 *tp, struct rx_agg *agg, gfp_t mem_flags);
 
@@ -10339,6 +10413,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->in_nway		= rtl8152_in_nway;
 		ops->hw_phy_cfg		= r8152b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl_runtime_suspend_enable;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 16 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX;
@@ -10361,6 +10437,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153_runtime_enable;
 		ops->change_mtu		= rtl8153_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		if (tp->udev->speed < USB_SPEED_SUPER)
 			tp->rx_buf_sz	= 16 * 1024;
 		else
@@ -10384,6 +10462,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153b_runtime_enable;
 		ops->change_mtu		= rtl8153_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
@@ -10408,6 +10488,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8156_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
 		r8152_desc_init(tp);
@@ -10433,6 +10515,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8156b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		r8152_desc_init(tp);
 		break;
@@ -10450,6 +10534,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153c_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153c_runtime_enable;
 		ops->change_mtu		= rtl8153c_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
@@ -10472,6 +10558,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
 		ops->change_mtu		= rtl8157_change_mtu;
+		ops->phy_read		= r8157_phy_read;
+		ops->phy_write		= r8157_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
@@ -10495,6 +10583,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8159_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
 		ops->change_mtu		= rtl8157_change_mtu;
+		ops->phy_read		= r8157_phy_read;
+		ops->phy_write		= r8157_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
-- 
2.34.1

