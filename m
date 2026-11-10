Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281109;
	b=Y+QTGAnhkIPri2CSHOmO5ymfBzv6OgwDaUgQMtvazQ3kL/nkLa6RVQ48qJ7+ntS6vtXm
	 CuZZvOEj2z8OnjJempE45BSKrbFZ1lXRDKOXhNakAztUhVjd3Q5c5tk+qw0WV8ui3HEzd
	 CQOLYwGqlusZQ9bqGjOc0rOKZnpSTZI+p9ksQHTSinlOgzzS9QSJ+9NLAUTzxWrumhe5Q
	 pR65XHbIg7EzFZZe3L/q8RILp9TNAzFQ6Q36Y1mN3QbbKR9y20za7G+uzfyL+1f+kUyEk
	 oAyZeyPE7cLxsPOQSHNSi4FoWRti6xotLiOyw3Q7p8/ixqk3CEp9XkZcn+ElQ6+hqHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281109;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=WoG/74J+v5M1YILJG9Hx6pGgKh3H1o1ye63nQq+T2x8=;
	b=PzbdGpDmYdGj39bjttcWvqeH8lgXfNJ2T6ajlbGrCnpv7lMdJU5oq6hZ4e20OIH+m3yI
	 5pFNhcVYPh/WdyX9i2B9H2JcbaYwXkzf5YgFGEzWCFwULqLcdDMCYuwFvHUwlnWSUY0Q9
	 X0RTza1kU76s5PCQy09uKvvJgbvdtUx1vJHs3FU+6Cbo/Z3P1h0MvqG1Sa++23pKzKMGq
	 OjPBgAm/coaUWXhWhDpFjw0BL1lNbFCnOOZA+UieCC+gYd91eMbjDxk7iiqR/TTYJJlil
	 dkDI8ey6jLDGx1+a8Te9QHikV+Ox4BnaLxEUBq45LpCapJfvLk5HexTpdgklMfhxeXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=DuSfsd68;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95360A2621;
	Tue, 10 Nov 2026 03:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA95360A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=DuSfsd68
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3OOO80884407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281065; bh=WoG/74J+v5M1YILJG9Hx6pGgKh3H1o1ye63nQq+T2x8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DuSfsd68m2/z3JFbRO1c7Zqk/ZHvADqbuEtAAuH/MLaPoRSRhOBl0UvN3vq+/QsK/
	 4ciM/nZI6DFbqh8bXjeUD4a9g2XNMQCiaKYvkxMOYVC88xeuOFwzDVBPcAh7SN9231
	 cFBcjFKHX7L/NfZf91U7j8aRs0ATSG02LN/CN7QtCgGhuisHjp+tBHcupAzHoT6KzC
	 LhVtF7Mmh6q6GoN2XbSIUutgcatefoHz0A+RNYqp+Nwp5LseHNokAjgRpdgZ2P1Jr7
	 Cj8y63SLoEbgYCZdDuyFaoEspue1ZMTqrnA06dfQFavG7OgWrFBKrsIkiBdTin0KJt
	 aubMkSD7k5+rQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3OOO80884407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:21 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:24:21 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 10/11] r8152: add TGPHY register access for RTL8157 and RTL8159
Date: Tue, 10 Nov 2026 11:24:15 +0800
Message-ID: <20261110032416.16968-11-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110032416.16968-1-nic_swsd@realtek.com>
References: <20261110032416.16968-1-nic_swsd@realtek.com>
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
Content-Type: text/plain

RTL8157 and RTL8159 have a TGPHY command channel
(USB_TGPHY_ADDR/DATA/CMD) for PHY registers that needs no OCP base
switching.  Use it for these chips; older chips keep the OCP path.

Route ocp_reg_read()/ocp_reg_write() through new rtl_ops.phy_read and
phy_write hooks, set per chip.

Unlike the OCP path, a TGPHY access can fail: the busy bit can time
out, or the device can be gone.  The access is then abandoned and
returns an errno (-ENODEV if the device is inaccessible).  A timeout is
logged ratelimited, so a stuck busy bit does not flood the log, and
does not mark the device inaccessible, as for the ADV command channel.

The PHY accessors and the helpers built on them therefore return int,
and the callers where a failure would be taken for register content or
for success now act on it:

- rtl8152_set_pauseparam(), rtl8152_set_speed(), SIOCGMIIREG/
  SIOCSMIIREG, rtl8152_get_link_ksettings(), r8153_get_eee() and
  r8152_mdio_read() propagate the error.  A failed write in
  rtl8152_set_speed() leaves the cached advertising and a pending PHY
  reset untouched.  rtl8152_get_pauseparam() reports no flow control
  when a read fails.
- The PHY firmware version checks skip the patch when the version
  cannot be read.
- rtl_phy_patch_request() returns the errno of a failed write, and
  releases PATCH_REQUEST when a later step fails, so a failed access
  does not leave it asserted.
- r8153_phy_status() treats a failed read as "not ready" and keeps
  polling, so one failure does not end the wait early.
- rtl8153_in_nway(), r8156_mdio_force_mode(), r8156_eee_en() and
  rtl8152_fw_phy_fixup() stop on a failed read instead of using stale
  data.
- read_mii_word() reports a failed read as 0.  The MII library takes
  the return value for register content, and an errno would look like
  a BMCR with autonegotiation enabled.

The hw_phy_cfg and init sequences, the ocp_reg_*_bits() and sram_*()
callers that write PHY configuration, r8152_mmd_read() and the MII
write callback still ignore the status, as does recovery from a TGPHY
timeout.  These are left to a follow-up series.

Older chips are unaffected, as r8152_phy_read() always succeeds.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 544 ++++++++++++++++++++++++++++++----------
 1 file changed, 417 insertions(+), 127 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fad4473caf2a4..703ec5483778b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -163,6 +163,9 @@
 #define USB_ADV_ADDR		0xd5d6
 #define USB_ADV_DATA		0xd5d8
 #define USB_ADV_CMD		0xd5dc
+#define USB_TGPHY_ADDR		0xd630
+#define USB_TGPHY_DATA		0xd632
+#define USB_TGPHY_CMD		0xd634
 #define USB_UPS_CTRL		0xd800
 #define USB_POWER_CUT		0xd80a
 #define USB_MISC_0		0xd81a
@@ -516,6 +519,10 @@
 #define ADV_CMD_WR		BIT(1)
 #define ADV_CMD_IP		BIT(2)
 
+/* USB_TGPHY_CMD */
+#define TGPHY_CMD_BUSY		BIT(0)
+#define TGPHY_CMD_WR		BIT(1)
+
 /* USB_UPS_CTRL */
 #define POWER_CUT		0x0100
 
@@ -964,6 +971,8 @@ struct r8152 {
 		void (*hw_phy_cfg)(struct r8152 *tp);
 		void (*autosuspend_en)(struct r8152 *tp, bool enable);
 		void (*change_mtu)(struct r8152 *tp);
+		int (*phy_read)(struct r8152 *tp, u16 addr, u16 *data);
+		int (*phy_write)(struct r8152 *tp, u16 addr, u16 data);
 	} rtl_ops;
 
 	struct ups_info {
@@ -1643,7 +1652,7 @@ static void ocp_write_byte(struct r8152 *tp, u16 type, u16 index, u32 data)
 	generic_ocp_write(tp, index, byen, sizeof(tmp), &tmp, type);
 }
 
-static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
+static int r8152_phy_read(struct r8152 *tp, u16 addr, u16 *data)
 {
 	u16 ocp_base, ocp_index;
 
@@ -1654,10 +1663,12 @@ static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
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
 
@@ -1669,16 +1680,33 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
 
 	ocp_index = (addr & 0x0fff) | 0xb000;
 	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
+
+	return 0;
+}
+
+static int ocp_reg_read(struct r8152 *tp, u16 addr, u16 *data)
+{
+	return tp->rtl_ops.phy_read(tp, addr, data);
+}
+
+static int ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
+{
+	return tp->rtl_ops.phy_write(tp, addr, data);
 }
 
-static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
+static inline int r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
 {
-	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
+	return ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
 }
 
-static inline int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
+static int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
 {
-	return ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2);
+	u16 data;
+	int ret;
+
+	ret = ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2, &data);
+
+	return ret < 0 ? ret : data;
 }
 
 static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
@@ -1797,16 +1825,32 @@ static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
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
@@ -1822,7 +1866,10 @@ static int read_mii_word(struct net_device *netdev, int phy_id, int reg)
 
 	ret = r8152_mdio_read(tp, reg);
 
-	return ret;
+	/* The MII library takes the return value for register content,
+	 * so a failed read must not be passed on as an errno.
+	 */
+	return ret < 0 ? 0 : ret;
 }
 
 static
@@ -1911,100 +1958,221 @@ static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)
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
+	if (ret)
+		dev_err_ratelimited(&tp->intf->dev, "TGPHY cmd busy timeout\n");
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
+	/* A failed control transfer latches RTL8152_INACCESSIBLE */
+	if (!ret && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		ret = -ENODEV;
+
+	return ret;
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
@@ -4187,18 +4355,20 @@ static void r8153b_green_en(struct r8152 *tp, bool enable)
 
 static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 {
-	u16 data;
+	u16 data = 0, val;
 	int i;
 
 	for (i = 0; i < 500; i++) {
-		data = ocp_reg_read(tp, OCP_PHY_STATUS);
-		data &= PHY_STAT_MASK;
-		if (desired) {
-			if (data == desired)
+		if (!ocp_reg_read(tp, OCP_PHY_STATUS, &val)) {
+			data = val & PHY_STAT_MASK;
+			if (desired) {
+				if (data == desired)
+					break;
+			} else if (data == PHY_STAT_LAN_ON ||
+				   data == PHY_STAT_PWRDN ||
+				   data == PHY_STAT_EXT_INIT) {
 				break;
-		} else if (data == PHY_STAT_LAN_ON || data == PHY_STAT_PWRDN ||
-			   data == PHY_STAT_EXT_INIT) {
-			break;
+			}
 		}
 
 		msleep(20);
@@ -4597,36 +4767,52 @@ static inline void rtl_reset_ocp_base(struct r8152 *tp)
 static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 {
 	u16 check;
-	int i;
+	u16 ocp_data;
+	int i, ret;
 
 	if (request) {
-		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		ret = ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
 		check = 0;
 	} else {
-		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		ret = ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
 		check = PATCH_READY;
 	}
 
-	for (i = 0; wait && i < 5000; i++) {
-		u32 ocp_data;
+	if (ret < 0)
+		return ret;
 
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			return -ENODEV;
+	for (i = 0; wait && i < 5000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
+			ret = -ENODEV;
+			goto err;
+		}
 
 		usleep_range(1000, 2000);
-		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
-		if ((ocp_data & PATCH_READY) ^ check)
+		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
+		if (ret < 0)
+			goto err;
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
+			goto err;
+		} else if (!(ocp_data & PATCH_READY)) {
+			dev_err(&tp->intf->dev, "PHY patch request fail\n");
+			ret = -ETIME;
+			goto err;
+		}
 	}
+
+	return 0;
+
+err:
+	if (request)
+		rtl_phy_patch_request(tp, false, false);
+
+	return ret;
 }
 
 static void rtl_patch_key_set(struct r8152 *tp, u16 key_addr, u16 patch_key)
@@ -4646,8 +4832,11 @@ static void rtl_patch_key_set(struct r8152 *tp, u16 key_addr, u16 patch_key)
 static int
 rtl_pre_ram_code(struct r8152 *tp, u16 key_addr, u16 patch_key, bool wait)
 {
-	if (rtl_phy_patch_request(tp, true, wait))
-		return -ETIME;
+	int ret;
+
+	ret = rtl_phy_patch_request(tp, true, wait);
+	if (ret)
+		return ret;
 
 	rtl_patch_key_set(tp, key_addr, patch_key);
 
@@ -5341,10 +5530,14 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
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
@@ -5391,7 +5584,8 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 
 	rtl_phy_patch_request(tp, false, wait);
 
-	if (sram_read(tp, SRAM_GPHY_FW_VER) == __le16_to_cpu(phy->version))
+	if (sram_read(tp, SRAM_GPHY_FW_VER, &ver) >= 0 &&
+	    ver == __le16_to_cpu(phy->version))
 		dev_dbg(&tp->intf->dev, "successfully applied %s\n", phy->info);
 	else
 		dev_err(&tp->intf->dev, "ram code speedup mode fail\n");
@@ -5399,14 +5593,17 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 
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
@@ -5425,7 +5622,8 @@ static void rtl8152_fw_phy_fixup(struct r8152 *tp, struct fw_phy_fixup *fix)
 	rtl_reset_ocp_base(tp);
 
 	addr = __le16_to_cpu(fix->setting.addr);
-	data = ocp_reg_read(tp, addr);
+	if (ocp_reg_read(tp, addr, &data) < 0)
+		return;
 
 	switch (__le16_to_cpu(fix->bit_cmd)) {
 	case FW_FIXUP_AND:
@@ -5729,10 +5927,10 @@ static inline void r8152_mmd_indirect(struct r8152 *tp, u16 dev, u16 reg)
 
 static u16 r8152_mmd_read(struct r8152 *tp, u16 dev, u16 reg)
 {
-	u16 data;
+	u16 data = 0;
 
 	r8152_mmd_indirect(tp, dev, reg);
-	data = ocp_reg_read(tp, OCP_EEE_DATA);
+	ocp_reg_read(tp, OCP_EEE_DATA, &data);
 	ocp_reg_write(tp, OCP_EEE_AR, 0x0000);
 
 	return data;
@@ -5797,7 +5995,8 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
 
 	r8153_eee_en(tp, enable);
 
-	config = ocp_reg_read(tp, OCP_EEE_ADV2);
+	if (ocp_reg_read(tp, OCP_EEE_ADV2, &config) < 0)
+		return;
 
 	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
 		config |= MDIO_EEE_2_5GT;
@@ -6351,8 +6550,8 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 	 * rg_saw_cnt = OCP reg 0xC426 Bit[13:0]
 	 * swr_cnt_1ms_ini = 16000000 / rg_saw_cnt
 	 */
-	ocp_data = ocp_reg_read(tp, 0xc426);
-	ocp_data &= 0x3fff;
+	ocp_reg_read(tp, 0xc426, &data);
+	ocp_data = data & 0x3fff;
 	if (ocp_data) {
 		u32 swr_cnt_1ms_ini;
 
@@ -6704,7 +6903,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
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
@@ -6726,12 +6929,19 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 		}
 
 		if (orig != new1) {
-			r8152_mdio_write(tp, MII_ADVERTISE, new1);
+			ret = r8152_mdio_write(tp, MII_ADVERTISE, new1);
+			if (ret < 0)
+				goto out;
+
 			tp->mii.advertising = new1;
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
 
@@ -6740,12 +6950,18 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 				tp->ups_info.speed_duplex = NWAY_1000M_FULL;
 			}
 
-			if (orig != new1)
-				r8152_mdio_write(tp, MII_CTRL1000, new1);
+			if (orig != new1) {
+				ret = r8152_mdio_write(tp, MII_CTRL1000, new1);
+				if (ret < 0)
+					goto out;
+			}
 		}
 
 		if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
-			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
+			ret = ocp_reg_read(tp, OCP_10GBT_CTRL, &orig);
+			if (ret < 0)
+				goto out;
+
 			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G
 					| MDIO_AN_10GBT_CTRL_ADV10G);
 
@@ -6764,8 +6980,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 				tp->ups_info.speed_duplex = NWAY_10000M_FULL;
 			}
 
-			if (orig != new1)
-				ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
+			if (orig != new1) {
+				ret = ocp_reg_write(tp, OCP_10GBT_CTRL, new1);
+				if (ret < 0)
+					goto out;
+			}
 		}
 
 		bmcr = BMCR_ANENABLE | BMCR_ANRESTART;
@@ -6776,20 +6995,26 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 	if (test_and_clear_bit(PHY_RESET, &tp->flags))
 		bmcr |= BMCR_RESET;
 
-	r8152_mdio_write(tp, MII_BMCR, bmcr);
+	ret = r8152_mdio_write(tp, MII_BMCR, bmcr);
+	if (ret < 0) {
+		if (bmcr & BMCR_RESET)
+			set_bit(PHY_RESET, &tp->flags);
+		goto out;
+	}
 
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
@@ -7205,7 +7430,12 @@ static bool rtl8152_in_nway(struct r8152 *tp)
 
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
@@ -7221,7 +7451,9 @@ static void r8156_mdio_force_mode(struct r8152 *tp)
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
@@ -7861,19 +8093,20 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
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
@@ -7885,11 +8118,11 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
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
@@ -7900,16 +8133,16 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
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
@@ -9388,8 +9621,16 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
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
@@ -9431,12 +9672,13 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
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
@@ -9617,21 +9859,37 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
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
 
@@ -9667,7 +9925,8 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	linkmode_and(common, common, eee->lp_advertised);
 	eee->eee_active = !linkmode_empty(common);
 
-	return 0;
+out:
+	return ret < 0 ? ret : 0;
 }
 
 static int
@@ -9907,7 +10166,7 @@ static int rtl8152_set_ringparam(struct net_device *netdev,
 static void rtl8152_get_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 {
 	struct r8152 *tp = netdev_priv(netdev);
-	u16 bmcr, lcladv, rmtadv;
+	int bmcr, lcladv, rmtadv;
 	u8 cap;
 
 	if (usb_autopm_get_interface(tp->intf) < 0)
@@ -9923,7 +10182,10 @@ static void rtl8152_get_pauseparam(struct net_device *netdev, struct ethtool_pau
 
 	usb_autopm_put_interface(tp->intf);
 
-	if (!(bmcr & BMCR_ANENABLE)) {
+	/* Without a readable PHY, or with autoneg off, there is no flow
+	 * control to report.
+	 */
+	if (bmcr < 0 || lcladv < 0 || rmtadv < 0 || !(bmcr & BMCR_ANENABLE)) {
 		pause->autoneg = 0;
 		pause->rx_pause = 0;
 		pause->tx_pause = 0;
@@ -9954,7 +10216,11 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
 
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
@@ -9965,16 +10231,20 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
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
@@ -10008,7 +10278,7 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 {
 	struct r8152 *tp = netdev_priv(netdev);
 	struct mii_ioctl_data *data = if_mii(rq);
-	int res;
+	int res, val;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
@@ -10024,7 +10294,11 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 
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
 
@@ -10034,7 +10308,7 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 			break;
 		}
 		mutex_lock(&tp->control);
-		r8152_mdio_write(tp, data->reg_num, data->val_in);
+		res = r8152_mdio_write(tp, data->reg_num, data->val_in);
 		mutex_unlock(&tp->control);
 		break;
 
@@ -10197,6 +10471,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->in_nway		= rtl8152_in_nway;
 		ops->hw_phy_cfg		= r8152b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl_runtime_suspend_enable;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 16 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX;
@@ -10219,6 +10495,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153_runtime_enable;
 		ops->change_mtu		= rtl8153_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		if (tp->udev->speed < USB_SPEED_SUPER)
 			tp->rx_buf_sz	= 16 * 1024;
 		else
@@ -10242,6 +10520,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153b_runtime_enable;
 		ops->change_mtu		= rtl8153_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
@@ -10266,6 +10546,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8156_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
 		r8152_desc_init(tp);
@@ -10291,6 +10573,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8156b_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8156_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 48 * 1024;
 		r8152_desc_init(tp);
 		break;
@@ -10308,6 +10592,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8153c_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8153c_runtime_enable;
 		ops->change_mtu		= rtl8153c_change_mtu;
+		ops->phy_read		= r8152_phy_read;
+		ops->phy_write		= r8152_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
@@ -10330,6 +10616,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
 		ops->change_mtu		= rtl8157_change_mtu;
+		ops->phy_read		= r8157_phy_read;
+		ops->phy_write		= r8157_phy_write;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
@@ -10353,6 +10641,8 @@ static int rtl_ops_init(struct r8152 *tp)
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

