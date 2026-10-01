Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF104BD0EF;
	Thu,  1 Oct 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845947; cv=none; b=BNVFIUBohHpzE/GR55/RpGsRQz4XgFCcNbhzXA/FfNl7sgK4YTz6w/GWj+Sv3qBth9BhzmUetxdUVv+kri1b82/0x9hJUV4BQyPwwx8+6oEJSewzgx+Peaze5nrOW1jqsFfMrVBM0mhLlAnMiioh+8mGs/5skZhRGi7jsiMNuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845947; c=relaxed/simple;
	bh=X89IeMhaK+HJ4IgOXt4I/iet4z5PW6r9ULX9/YNR6Rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K05WIVfJwP20xn8fGZ3mUj/VuRX+U1I0WBajXxGmFtDYb6ybrDql3Er0kgnUzZ83V0rrpfbdGj108TqmvyTIi0ghKXiQO2E+gkfgNyedIcwfUy+sKphrDnkwQgI7jz4x4bN5WNwmRgQU2wP65b8jrNnrfkAGOt9NsGAYPI+9sOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R1ioxBJp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R1ioxBJp"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6919BnFR22836516, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790845909; bh=DX25omJVaSZXDh5GSTItipC9cSzKRuvRE6WUdR623/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R1ioxBJpkfKRQ20tXq4Y1eu5A/b/VA0OEp+tK0/cXJ+tu6+S8pcNLceh+jZTAdQbZ
	 iw7R2L/QUWFRNUh8W6gAxfUYouGSgiJjgbe1kcPPfK1+JJS763qMuj9tMIbprTrN5C
	 xayy8gsEsjuugXkVSz8n+pVYnGvNeniFJVjxgt4kTVVq/n0s3M07H4TLDeK96+b+gI
	 DoNWF7/cHE6C7UogW6NcE1If+lfxYUP3YbJCMs1TyabM1F9Gm5B02+RC+f/gRej1r2
	 5xz+W7iYe3DBwHscQJj4ypA3q8UdAp4e0A2iCVurZ4veUr34qyYbKCXA8HTRW5iQVu
	 3crlKBuLHj9Gg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6919BnFR22836516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Oct 2026 17:11:49 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:47 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 17:11:47 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v5 7/9] r8152: add TGPHY register access for RTL8157 and RTL8159
Date: Thu, 1 Oct 2026 17:11:42 +0800
Message-ID: <20261001091144.28191-8-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001091144.28191-1-nic_swsd@realtek.com>
References: <20261001091144.28191-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8157 and RTL8159 can reach PHY registers through the same
OCP-base-switching path as earlier chips, but they also provide a
TGPHY command channel (USB_TGPHY_ADDR/DATA/CMD) that needs no base
switching.  Use it for these chips.

Make ocp_reg_read()/ocp_reg_write() wrappers over new
rtl_ops.phy_read/phy_write hooks, set per chip in rtl_ops_init().
The existing code becomes r8152_phy_read()/r8152_phy_write(), and the
TGPHY code is r8157_phy_read()/r8157_phy_write().  A busy timeout
abandons the access, since ADDR/DATA/CMD form a single transaction,
and latches RTL8152_INACCESSIBLE so that later accesses fail fast.

A TGPHY access can fail, so the PHY accessors and the helpers built
on them (sram_*, sram2_*, ocp_reg_*_bits, MDIO bit helpers) now
return int.  The status is checked only where an errno would
otherwise be taken for register content or reported as success: the
pause parameters, rtl8152_set_speed(), SIOCGMIIREG/SIOCSMIIREG, the
PHY patch handshake and the PHY firmware version checks.

The remaining callers, notably the hw_phy_cfg and init sequences,
r8153_phy_status(), r8152_mmd_read(), EEE handling and the MII
library callbacks, still ignore the status and rely on the latch to
stop further access.  The LAN_ON WARN_ON_ONCE() in hw_phy_cfg is
skipped once the latch is set.  A latched device stays inaccessible
until it is reset or replugged.  Recovering from that is a separate
problem and is not addressed here.

Older chips are unaffected, as r8152_phy_read() always succeeds.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 489 ++++++++++++++++++++++++++++++----------
 1 file changed, 376 insertions(+), 113 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f805ef0763d70..be8b0db15033b 100644
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
 
@@ -959,6 +966,8 @@ struct r8152 {
 		void (*hw_phy_cfg)(struct r8152 *tp);
 		void (*autosuspend_en)(struct r8152 *tp, bool enable);
 		void (*change_mtu)(struct r8152 *tp);
+		int (*phy_read)(struct r8152 *tp, u16 addr, u16 *data);
+		int (*phy_write)(struct r8152 *tp, u16 addr, u16 data);
 	} rtl_ops;
 
 	struct ups_info {
@@ -1638,7 +1647,7 @@ static void ocp_write_byte(struct r8152 *tp, u16 type, u16 index, u32 data)
 	generic_ocp_write(tp, index, byen, sizeof(tmp), &tmp, type);
 }
 
-static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
+static int r8152_phy_read(struct r8152 *tp, u16 addr, u16 *data)
 {
 	u16 ocp_base, ocp_index;
 
@@ -1649,10 +1658,12 @@ static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
 	}
 
 	ocp_index = (addr & 0x0fff) | 0xb000;
-	return ocp_read_word(tp, MCU_TYPE_PLA, ocp_index);
+	*data = ocp_read_word(tp, MCU_TYPE_PLA, ocp_index);
+
+	return 0;
 }
 
-static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
+static int r8152_phy_write(struct r8152 *tp, u16 addr, u16 data)
 {
 	u16 ocp_base, ocp_index;
 
@@ -1664,16 +1675,33 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
 
 	ocp_index = (addr & 0x0fff) | 0xb000;
 	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
+
+	return 0;
 }
 
-static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
+static int ocp_reg_read(struct r8152 *tp, u16 addr, u16 *data)
 {
-	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
+	return tp->rtl_ops.phy_read(tp, addr, data);
 }
 
-static inline int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
+static int ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
 {
-	return ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2);
+	return tp->rtl_ops.phy_write(tp, addr, data);
+}
+
+static inline int r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
+{
+	return ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
+}
+
+static int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
+{
+	u16 data;
+	int ret;
+
+	ret = ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2, &data);
+
+	return ret < 0 ? ret : data;
 }
 
 static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
@@ -1792,16 +1820,32 @@ static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
 	return rtl_ip_w0w1(tp, addr, 0, set);
 }
 
-static void sram_write(struct r8152 *tp, u16 addr, u16 data)
+static int sram_write(struct r8152 *tp, u16 addr, u16 data)
 {
-	ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
-	ocp_reg_write(tp, OCP_SRAM_DATA, data);
+	int ret;
+
+	ret = ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
+	if (ret < 0)
+		goto out;
+
+	ret = ocp_reg_write(tp, OCP_SRAM_DATA, data);
+
+out:
+	return ret;
 }
 
-static u16 sram_read(struct r8152 *tp, u16 addr)
+static int sram_read(struct r8152 *tp, u16 addr, u16 *data)
 {
-	ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
-	return ocp_reg_read(tp, OCP_SRAM_DATA);
+	int ret;
+
+	ret = ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
+	if (ret < 0)
+		goto out;
+
+	ret = ocp_reg_read(tp, OCP_SRAM_DATA, data);
+
+out:
+	return ret;
 }
 
 static int read_mii_word(struct net_device *netdev, int phy_id, int reg)
@@ -1906,100 +1950,219 @@ static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)
 	ocp_byte_w0w1(tp, type, index, 0, set);
 }
 
-static void ocp_reg_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+static int ocp_reg_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
 {
 	u16 data;
+	int ret;
+
+	ret = ocp_reg_read(tp, addr, &data);
+	if (ret < 0)
+		goto out;
 
-	data = ocp_reg_read(tp, addr);
 	data = (data & ~clear) | set;
-	ocp_reg_write(tp, addr, data);
+	ret = ocp_reg_write(tp, addr, data);
+
+out:
+	return ret;
 }
 
-static void ocp_reg_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+static int ocp_reg_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
 {
-	ocp_reg_w0w1(tp, addr, clear, 0);
+	return ocp_reg_w0w1(tp, addr, clear, 0);
 }
 
-static void ocp_reg_set_bits(struct r8152 *tp, u16 addr, u16 set)
+static int ocp_reg_set_bits(struct r8152 *tp, u16 addr, u16 set)
 {
-	ocp_reg_w0w1(tp, addr, 0, set);
+	return ocp_reg_w0w1(tp, addr, 0, set);
 }
 
-static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+static int sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
 {
 	u16 data;
+	int ret;
+
+	ret = sram_read(tp, addr, &data);
+	if (ret < 0)
+		goto out;
 
-	data = sram_read(tp, addr);
 	data = (data & ~clear) | set;
-	ocp_reg_write(tp, OCP_SRAM_DATA, data);
+	ret = ocp_reg_write(tp, OCP_SRAM_DATA, data);
+
+out:
+	return ret;
 }
 
-static void sram_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+static int sram_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
 {
-	sram_write_w0w1(tp, addr, clear, 0);
+	return sram_write_w0w1(tp, addr, clear, 0);
 }
 
-static void sram_set_bits(struct r8152 *tp, u16 addr, u16 set)
+static int sram_set_bits(struct r8152 *tp, u16 addr, u16 set)
 {
-	sram_write_w0w1(tp, addr, 0, set);
+	return sram_write_w0w1(tp, addr, 0, set);
 }
 
-static void sram2_write(struct r8152 *tp, u16 addr, u16 data)
+static int sram2_write(struct r8152 *tp, u16 addr, u16 data)
 {
-	ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
-	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+	int ret;
+
+	ret = ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
+	if (ret < 0)
+		goto out;
+
+	ret = ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+
+out:
+	return ret;
 }
 
-static u16 sram2_read(struct r8152 *tp, u16 addr)
+static int sram2_read(struct r8152 *tp, u16 addr, u16 *data)
 {
-	ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
-	return ocp_reg_read(tp, OCP_SRAM2_DATA);
+	int ret;
+
+	ret = ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
+	if (ret < 0)
+		goto out;
+
+	ret = ocp_reg_read(tp, OCP_SRAM2_DATA, data);
+
+out:
+	return ret;
 }
 
-static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+static int sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
 {
 	u16 data;
+	int ret;
+
+	ret = sram2_read(tp, addr, &data);
+	if (ret < 0)
+		goto out;
 
-	data = sram2_read(tp, addr);
 	data = (data & ~clear) | set;
-	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+	ret = ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+
+out:
+	return ret;
 }
 
-static void sram2_set_bits(struct r8152 *tp, u16 addr, u16 set)
+static int sram2_set_bits(struct r8152 *tp, u16 addr, u16 set)
 {
-	sram2_write_w0w1(tp, addr, 0, set);
+	return sram2_write_w0w1(tp, addr, 0, set);
 }
 
-static void sram2_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+static int sram2_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
 {
-	sram2_write_w0w1(tp, addr, clear, 0);
+	return sram2_write_w0w1(tp, addr, clear, 0);
 }
 
-static void r8152_mdio_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
+static int r8152_mdio_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
 {
 	int data;
 
 	data = r8152_mdio_read(tp, addr);
-	r8152_mdio_write(tp, addr, data & ~clear);
+	if (data < 0)
+		goto out;
+
+	data = r8152_mdio_write(tp, addr, data & ~clear);
+
+out:
+	return data;
 }
 
-static void r8152_mdio_set_bit(struct r8152 *tp, u16 addr, u16 set)
+static int r8152_mdio_set_bit(struct r8152 *tp, u16 addr, u16 set)
 {
 	int data;
 
 	data = r8152_mdio_read(tp, addr);
-	r8152_mdio_write(tp, addr, data | set);
+	if (data < 0)
+		goto out;
+
+	data = r8152_mdio_write(tp, addr, data | set);
+
+out:
+	return data;
 }
 
 static int r8152_mdio_test_and_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
 {
-	int data;
+	int data, ret;
 
-	data = r8152_mdio_read(tp, addr);
-	if (data & clear)
-		r8152_mdio_write(tp, addr, data & ~clear);
+	ret = r8152_mdio_read(tp, addr);
+	if (ret < 0)
+		goto out;
+
+	data = ret;
+	if (data & clear) {
+		ret = r8152_mdio_write(tp, addr, data & ~clear);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = !!(data & clear);
 
-	return data & clear;
+out:
+	return ret;
+}
+
+static int wait_tgphy_cmd_ready(struct r8152 *tp)
+{
+	u16 ocp_data;
+	int ret;
+
+	ret = read_poll_timeout(ocp_read_word, ocp_data,
+				test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
+				!(ocp_data & TGPHY_CMD_BUSY),
+				2000, 20000, false, tp,
+				MCU_TYPE_USB, USB_TGPHY_CMD);
+
+	if (ret) {
+		rtl_set_inaccessible(tp);
+		dev_err(&tp->intf->dev, "TGPHY cmd busy timeout\n");
+	}
+
+	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : ret;
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
+	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : ret;
+}
+
+static int r8157_phy_read(struct r8152 *tp, u16 addr, u16 *data)
+{
+	return rtl_tgphy_access(tp, addr, data, false);
+}
+
+static int r8157_phy_write(struct r8152 *tp, u16 addr, u16 data)
+{
+	return rtl_tgphy_access(tp, addr, &data, true);
 }
 
 static int
@@ -4177,11 +4340,13 @@ static void r8153b_green_en(struct r8152 *tp, bool enable)
 
 static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 {
-	u16 data;
+	u16 data = 0;
 	int i;
 
 	for (i = 0; i < 500; i++) {
-		data = ocp_reg_read(tp, OCP_PHY_STATUS);
+		if (ocp_reg_read(tp, OCP_PHY_STATUS, &data) < 0)
+			break;
+
 		data &= PHY_STAT_MASK;
 		if (desired) {
 			if (data == desired)
@@ -4587,7 +4752,8 @@ static inline void rtl_reset_ocp_base(struct r8152 *tp)
 static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 {
 	u16 check;
-	int i;
+	u16 ocp_data;
+	int i, ret;
 
 	if (request) {
 		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
@@ -4598,25 +4764,29 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	}
 
 	for (i = 0; wait && i < 5000; i++) {
-		u32 ocp_data;
-
 		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return -ENODEV;
 
 		usleep_range(1000, 2000);
-		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
-		if ((ocp_data & PATCH_READY) ^ check)
+		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
+		if (ret < 0)
+			return ret;
+		else if ((ocp_data & PATCH_READY) ^ check)
 			break;
 	}
 
-	if (request && wait &&
-	    !(ocp_reg_read(tp, OCP_PHY_PATCH_STAT) & PATCH_READY)) {
-		dev_err(&tp->intf->dev, "PHY patch request fail\n");
-		rtl_phy_patch_request(tp, false, false);
-		return -ETIME;
-	} else {
-		return 0;
+	if (request && wait) {
+		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
+		if (ret < 0) {
+			return ret;
+		} else if (!(ocp_data & PATCH_READY)) {
+			dev_err(&tp->intf->dev, "PHY patch request fail\n");
+			rtl_phy_patch_request(tp, false, false);
+			return -ETIME;
+		}
 	}
+
+	return 0;
 }
 
 static void rtl_patch_key_set(struct r8152 *tp, u16 key_addr, u16 patch_key)
@@ -5331,10 +5501,14 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 {
 	u32 len;
 	u8 *data;
+	u16 ver;
 
 	rtl_reset_ocp_base(tp);
 
-	if (sram_read(tp, SRAM_GPHY_FW_VER) >= __le16_to_cpu(phy->version)) {
+	if (sram_read(tp, SRAM_GPHY_FW_VER, &ver) < 0)
+		return;
+
+	if (ver >= __le16_to_cpu(phy->version)) {
 		dev_dbg(&tp->intf->dev, "PHY firmware has been the newest\n");
 		return;
 	}
@@ -5381,7 +5555,8 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 
 	rtl_phy_patch_request(tp, false, wait);
 
-	if (sram_read(tp, SRAM_GPHY_FW_VER) == __le16_to_cpu(phy->version))
+	if (sram_read(tp, SRAM_GPHY_FW_VER, &ver) >= 0 &&
+	    ver == __le16_to_cpu(phy->version))
 		dev_dbg(&tp->intf->dev, "successfully applied %s\n", phy->info);
 	else
 		dev_err(&tp->intf->dev, "ram code speedup mode fail\n");
@@ -5389,14 +5564,17 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 
 static int rtl8152_fw_phy_ver(struct r8152 *tp, struct fw_phy_ver *phy_ver)
 {
-	u16 ver_addr, ver;
+	u16 ver_addr, ver, cur_ver;
 
 	ver_addr = __le16_to_cpu(phy_ver->ver.addr);
 	ver = __le16_to_cpu(phy_ver->ver.data);
 
 	rtl_reset_ocp_base(tp);
 
-	if (sram_read(tp, ver_addr) >= ver) {
+	if (sram_read(tp, ver_addr, &cur_ver) < 0)
+		return 0;
+
+	if (cur_ver >= ver) {
 		dev_dbg(&tp->intf->dev, "PHY firmware has been the newest\n");
 		return 0;
 	}
@@ -5415,7 +5593,8 @@ static void rtl8152_fw_phy_fixup(struct r8152 *tp, struct fw_phy_fixup *fix)
 	rtl_reset_ocp_base(tp);
 
 	addr = __le16_to_cpu(fix->setting.addr);
-	data = ocp_reg_read(tp, addr);
+	if (ocp_reg_read(tp, addr, &data) < 0)
+		return;
 
 	switch (__le16_to_cpu(fix->bit_cmd)) {
 	case FW_FIXUP_AND:
@@ -5719,10 +5898,10 @@ static inline void r8152_mmd_indirect(struct r8152 *tp, u16 dev, u16 reg)
 
 static u16 r8152_mmd_read(struct r8152 *tp, u16 dev, u16 reg)
 {
-	u16 data;
+	u16 data = 0;
 
 	r8152_mmd_indirect(tp, dev, reg);
-	data = ocp_reg_read(tp, OCP_EEE_DATA);
+	ocp_reg_read(tp, OCP_EEE_DATA, &data);
 	ocp_reg_write(tp, OCP_EEE_AR, 0x0000);
 
 	return data;
@@ -5787,7 +5966,8 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
 
 	r8153_eee_en(tp, enable);
 
-	config = ocp_reg_read(tp, OCP_EEE_ADV2);
+	if (ocp_reg_read(tp, OCP_EEE_ADV2, &config) < 0)
+		return;
 
 	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
 		config |= MDIO_EEE_2_5GT;
@@ -6243,8 +6423,8 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 	 * rg_saw_cnt = OCP reg 0xC426 Bit[13:0]
 	 * swr_cnt_1ms_ini = 16000000 / rg_saw_cnt
 	 */
-	ocp_data = ocp_reg_read(tp, 0xc426);
-	ocp_data &= 0x3fff;
+	ocp_reg_read(tp, 0xc426, &data);
+	ocp_data = data & 0x3fff;
 	if (ocp_data) {
 		u32 swr_cnt_1ms_ini;
 
@@ -6601,7 +6781,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 		if (!advertising)
 			return -EINVAL;
 
-		orig = r8152_mdio_read(tp, MII_ADVERTISE);
+		ret = r8152_mdio_read(tp, MII_ADVERTISE);
+		if (ret < 0)
+			goto out;
+
+		orig = ret;
 		new1 = orig & ~(ADVERTISE_10HALF | ADVERTISE_10FULL |
 				ADVERTISE_100HALF | ADVERTISE_100FULL);
 		if (advertising & RTL_ADVERTISED_10_HALF) {
@@ -6628,7 +6812,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 		}
 
 		if (tp->mii.supports_gmii) {
-			orig = r8152_mdio_read(tp, MII_CTRL1000);
+			ret = r8152_mdio_read(tp, MII_CTRL1000);
+			if (ret < 0)
+				goto out;
+
+			orig = ret;
 			new1 = orig & ~(ADVERTISE_1000FULL |
 					ADVERTISE_1000HALF);
 
@@ -6642,7 +6830,10 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 		}
 
 		if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
-			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
+			ret = ocp_reg_read(tp, OCP_10GBT_CTRL, &orig);
+			if (ret < 0)
+				goto out;
+
 			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G
 					| MDIO_AN_10GBT_CTRL_ADV10G);
 
@@ -6673,20 +6864,23 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 	if (test_and_clear_bit(PHY_RESET, &tp->flags))
 		bmcr |= BMCR_RESET;
 
-	r8152_mdio_write(tp, MII_BMCR, bmcr);
+	ret = r8152_mdio_write(tp, MII_BMCR, bmcr);
+	if (ret < 0)
+		goto out;
 
 	if (bmcr & BMCR_RESET) {
 		int i;
 
 		for (i = 0; i < 50; i++) {
 			msleep(20);
-			if ((r8152_mdio_read(tp, MII_BMCR) & BMCR_RESET) == 0)
+			ret = r8152_mdio_read(tp, MII_BMCR);
+			if (ret < 0 || !(ret & BMCR_RESET))
 				break;
 		}
 	}
 
 out:
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static void rtl8152_up(struct r8152 *tp)
@@ -7137,7 +7331,12 @@ static bool rtl8152_in_nway(struct r8152 *tp)
 
 static bool rtl8153_in_nway(struct r8152 *tp)
 {
-	u16 phy_state = ocp_reg_read(tp, OCP_PHY_STATE) & 0xff;
+	u16 phy_state;
+
+	if (ocp_reg_read(tp, OCP_PHY_STATE, &phy_state) < 0)
+		return false;
+
+	phy_state &= 0xff;
 
 	if (phy_state == TXDIS_STATE || phy_state == ABD_STATE)
 		return false;
@@ -7153,7 +7352,9 @@ static void r8156_mdio_force_mode(struct r8152 *tp)
 	 * 0: MDIO force mode
 	 * 1: MMD force mode
 	 */
-	data = ocp_reg_read(tp, 0xa5b4);
+	if (ocp_reg_read(tp, 0xa5b4, &data) < 0)
+		return;
+
 	if (data & BIT(15)) {
 		data &= ~BIT(15);
 		ocp_reg_write(tp, 0xa5b4, data);
@@ -7685,7 +7886,8 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 	rtl_eee_enable(tp, false);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
-	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON &&
+		     !test_bit(RTL8152_INACCESSIBLE, &tp->flags));
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
@@ -7792,19 +7994,20 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_clr_bits(tp, 0xa86a, BIT(0));
 
 		/* MDI SWAP */
+		ocp_reg_read(tp, 0xd068, &data);
 		if ((ocp_read_word(tp, MCU_TYPE_USB, USB_UPS_CFG) & MID_REVERSE) &&
-		    (ocp_reg_read(tp, 0xd068) & BIT(1))) {
+		    (data & BIT(1))) {
 			u16 swap_a, swap_b;
 
-			data = ocp_reg_read(tp, 0xd068);
+			ocp_reg_read(tp, 0xd068, &data);
 			data &= ~0x1f;
 			data |= 0x1; /* p0 */
 			ocp_reg_write(tp, 0xd068, data);
-			swap_a = ocp_reg_read(tp, 0xd06a);
+			ocp_reg_read(tp, 0xd06a, &swap_a);
 			data &= ~0x18;
 			data |= 0x18; /* p3 */
 			ocp_reg_write(tp, 0xd068, data);
-			swap_b = ocp_reg_read(tp, 0xd06a);
+			ocp_reg_read(tp, 0xd06a, &swap_b);
 			data &= ~0x18; /* p0 */
 			ocp_reg_write(tp, 0xd068, data);
 			ocp_reg_write(tp, 0xd06a,
@@ -7816,11 +8019,11 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 			data &= ~0x18;
 			data |= 0x08; /* p1 */
 			ocp_reg_write(tp, 0xd068, data);
-			swap_a = ocp_reg_read(tp, 0xd06a);
+			ocp_reg_read(tp, 0xd06a, &swap_a);
 			data &= ~0x18;
 			data |= 0x10; /* p2 */
 			ocp_reg_write(tp, 0xd068, data);
-			swap_b = ocp_reg_read(tp, 0xd06a);
+			ocp_reg_read(tp, 0xd06a, &swap_b);
 			data &= ~0x18;
 			data |= 0x08; /* p1 */
 			ocp_reg_write(tp, 0xd068, data);
@@ -7831,16 +8034,16 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 			ocp_reg_write(tp, 0xd068, data);
 			ocp_reg_write(tp, 0xd06a,
 				      (swap_b & ~0x7ff) | (swap_a & 0x7ff));
-			swap_a = ocp_reg_read(tp, 0xbd5a);
-			swap_b = ocp_reg_read(tp, 0xbd5c);
+			ocp_reg_read(tp, 0xbd5a, &swap_a);
+			ocp_reg_read(tp, 0xbd5c, &swap_b);
 			ocp_reg_write(tp, 0xbd5a, (swap_a & ~0x1f1f) |
 				      ((swap_b & 0x1f) << 8) |
 				      ((swap_b >> 8) & 0x1f));
 			ocp_reg_write(tp, 0xbd5c, (swap_b & ~0x1f1f) |
 				      ((swap_a & 0x1f) << 8) |
 				      ((swap_a >> 8) & 0x1f));
-			swap_a = ocp_reg_read(tp, 0xbc18);
-			swap_b = ocp_reg_read(tp, 0xbc1a);
+			ocp_reg_read(tp, 0xbc18, &swap_a);
+			ocp_reg_read(tp, 0xbc1a, &swap_b);
 			ocp_reg_write(tp, 0xbc18, (swap_a & ~0x1f1f) |
 				      ((swap_b & 0x1f) << 8) |
 				      ((swap_b >> 8) & 0x1f));
@@ -7920,7 +8123,8 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 	rtl_eee_enable(tp, false);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
-	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON &&
+		     !test_bit(RTL8152_INACCESSIBLE, &tp->flags));
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
@@ -8159,7 +8363,8 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	rtl_eee_enable(tp, false);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
-	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON &&
+		     !test_bit(RTL8152_INACCESSIBLE, &tp->flags));
 
 	/* PFM mode */
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
@@ -8356,7 +8561,8 @@ static void r8159_hw_phy_cfg(struct r8152 *tp)
 	r8153_aldps_en(tp, false);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
-	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON &&
+		     !test_bit(RTL8152_INACCESSIBLE, &tp->flags));
 
 	/* PFM mode */
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
@@ -9437,8 +9643,16 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 			 cmd->link_modes.supported, tp->support_10000full);
 
 	if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
-		u16 ocp_10gbt_ctrl = ocp_reg_read(tp, OCP_10GBT_CTRL);
-		u16 ocp_10gbt_stat = ocp_reg_read(tp, OCP_10GBT_STAT);
+		u16 ocp_10gbt_ctrl;
+		u16 ocp_10gbt_stat;
+
+		ret = ocp_reg_read(tp, OCP_10GBT_CTRL, &ocp_10gbt_ctrl);
+		if (ret < 0)
+			goto out_unlock;
+
+		ret = ocp_reg_read(tp, OCP_10GBT_STAT, &ocp_10gbt_stat);
+		if (ret < 0)
+			goto out_unlock;
 
 		if (tp->support_2500full) {
 			linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
@@ -9480,12 +9694,13 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
 		}
 	}
 
+out_unlock:
 	mutex_unlock(&tp->control);
 
 	usb_autopm_put_interface(tp->intf);
 
 out:
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int rtl8152_set_link_ksettings(struct net_device *dev,
@@ -9666,21 +9881,37 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
 	u16 speed = rtl8152_get_speed(tp);
 	u16 val;
+	int ret;
+
+	ret = ocp_reg_read(tp, OCP_EEE_ABLE, &val);
+	if (ret < 0)
+		goto out;
 
-	val = ocp_reg_read(tp, OCP_EEE_ABLE);
 	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
 
-	val = ocp_reg_read(tp, OCP_EEE_ADV);
+	ret = ocp_reg_read(tp, OCP_EEE_ADV, &val);
+	if (ret < 0)
+		goto out;
+
 	mii_eee_cap1_mod_linkmode_t(eee->advertised, val);
 
-	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
+	ret = ocp_reg_read(tp, OCP_EEE_LPABLE, &val);
+	if (ret < 0)
+		goto out;
+
 	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
 	if (tp->support_2500full || tp->support_5000full) {
-		val = ocp_reg_read(tp, OCP_EEE_ADV2);
+		ret = ocp_reg_read(tp, OCP_EEE_ADV2, &val);
+		if (ret < 0)
+			goto out;
+
 		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
 
-		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
+		ret = ocp_reg_read(tp, OCP_EEE_LPABLE2, &val);
+		if (ret < 0)
+			goto out;
+
 		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
 	}
 
@@ -9716,7 +9947,8 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	linkmode_and(common, common, eee->lp_advertised);
 	eee->eee_active = !linkmode_empty(common);
 
-	return 0;
+out:
+	return ret < 0 ? ret : 0;
 }
 
 static int
@@ -9956,7 +10188,7 @@ static int rtl8152_set_ringparam(struct net_device *netdev,
 static void rtl8152_get_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 {
 	struct r8152 *tp = netdev_priv(netdev);
-	u16 bmcr, lcladv, rmtadv;
+	int bmcr, lcladv, rmtadv;
 	u8 cap;
 
 	if (usb_autopm_get_interface(tp->intf) < 0)
@@ -9972,7 +10204,10 @@ static void rtl8152_get_pauseparam(struct net_device *netdev, struct ethtool_pau
 
 	usb_autopm_put_interface(tp->intf);
 
-	if (!(bmcr & BMCR_ANENABLE)) {
+	/* Without a readable PHY, or with autoneg off, there is no flow
+	 * control to report.
+	 */
+	if (bmcr < 0 || lcladv < 0 || rmtadv < 0 || !(bmcr & BMCR_ANENABLE)) {
 		pause->autoneg = 0;
 		pause->rx_pause = 0;
 		pause->tx_pause = 0;
@@ -10003,7 +10238,11 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
 
 	mutex_lock(&tp->control);
 
-	if (pause->autoneg && !(r8152_mdio_read(tp, MII_BMCR) & BMCR_ANENABLE)) {
+	ret = r8152_mdio_read(tp, MII_BMCR);
+	if (ret < 0)
+		goto out;
+
+	if (pause->autoneg && !(ret & BMCR_ANENABLE)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -10014,16 +10253,20 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
 	if (pause->tx_pause)
 		cap |= FLOW_CTRL_TX;
 
-	old = r8152_mdio_read(tp, MII_ADVERTISE);
+	ret = r8152_mdio_read(tp, MII_ADVERTISE);
+	if (ret < 0)
+		goto out;
+
+	old = ret;
 	new1 = (old & ~(ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM)) | mii_advertise_flowctrl(cap);
 	if (old != new1)
-		r8152_mdio_write(tp, MII_ADVERTISE, new1);
+		ret = r8152_mdio_write(tp, MII_ADVERTISE, new1);
 
 out:
 	mutex_unlock(&tp->control);
 	usb_autopm_put_interface(tp->intf);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static const struct ethtool_ops ops = {
@@ -10057,7 +10300,7 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 {
 	struct r8152 *tp = netdev_priv(netdev);
 	struct mii_ioctl_data *data = if_mii(rq);
-	int res;
+	int res, val;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
@@ -10073,7 +10316,11 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 
 	case SIOCGMIIREG:
 		mutex_lock(&tp->control);
-		data->val_out = r8152_mdio_read(tp, data->reg_num);
+		val = r8152_mdio_read(tp, data->reg_num);
+		if (val < 0)
+			res = val;
+		else
+			data->val_out = val;
 		mutex_unlock(&tp->control);
 		break;
 
@@ -10083,7 +10330,7 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 			break;
 		}
 		mutex_lock(&tp->control);
-		r8152_mdio_write(tp, data->reg_num, data->val_in);
+		res = r8152_mdio_write(tp, data->reg_num, data->val_in);
 		mutex_unlock(&tp->control);
 		break;
 
@@ -10246,6 +10493,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->in_nway		= rtl8152_in_nway;
 		ops->hw_phy_cfg		= r8152b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl_runtime_suspend_enable;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 16 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX;
@@ -10268,6 +10517,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153_runtime_enable;
 		ops->change_mtu		= rtl8153_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		if (tp->udev->speed < USB_SPEED_SUPER)
 			tp->rx_buf_sz	= 16 * 1024;
 		else
@@ -10291,6 +10542,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153b_runtime_enable;
 		ops->change_mtu		= rtl8153_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
@@ -10315,6 +10568,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8156_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
 		r8152_desc_init(tp);
@@ -10340,6 +10595,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8156b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		r8152_desc_init(tp);
 		break;
@@ -10357,6 +10614,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153c_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153c_runtime_enable;
 		ops->change_mtu		= rtl8153c_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
@@ -10379,6 +10638,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
 		ops->change_mtu		= rtl8157_change_mtu;
+		ops->phy_read		= r8157_phy_read;
+		ops->phy_write		= r8157_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
@@ -10402,6 +10663,8 @@ static int rtl_ops_init(struct r8152 *tp)
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

