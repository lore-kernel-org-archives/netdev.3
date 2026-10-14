Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808094AEBD4;
	Wed, 14 Oct 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966006; cv=none; b=t6kyRSbsNxjDSiGS0LNwdlMQ7qai7AZrXwqEyDYFrkz0yCNhFQwE9ZtJ/Us8IvMH6FmlFM0/Mrcyr2LLAPSeF3RRi7xHeAOHPbVVmuhXjtQUJX84D0B+y7BJHn1OIHXjFWrkWK5MLWnKTS8H9FbfAehCFsGqDxvb++2kFzM9jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966006; c=relaxed/simple;
	bh=TNx2R5Lnh1XNaIxKoRtdH+D1U+A0GOtSwAZ6j+V9S0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BE8Mq/pCnjWMuPXWZAalGgfl3Mq+oa0zdlHjq6d3Y/vKhQnemGFGQH351HdxrYb8ekZV8QZJL+LnbdOsSxnrHmhvnd1vyfJeuSIpSIkx+pjl5ePySqDtI62Rw6iHEzgnEPn3O2fzKUt/GkYtW9V9HmwtTLaYJ/j814PuAOQiDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sLeb5MFE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sLeb5MFE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8J7cF41418052, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965948; bh=RByEro9CZDNnvP5GeL3W9/vOqquTrB770YYXXSsemOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sLeb5MFEk6qEGrgN7v8xwpBw6OtGcdotzHWvEB0LMb2YmlOL4HDdGiE49p2Xt+h2I
	 DuOYVQfgGVJfDDMNtI40D6xaWh1mw6FVDJ/xmkC/KYs0hQ5rWUiv+MWaC5Zw0HTV7p
	 UF9cMd0iGZRFArrEqDJ9hTJz7IIpSFeWiOGrxT19FpF0akieP2NuGhEIr8jTFdtHDj
	 MGUuBPGucHrtTtGABIjGP6qv2l9DTOnxAN5AWiH6m+lGZCA6q7KNVGHpwbJnDcC3oG
	 RsJOAfI4Bc8VJims8cPmY2Mvhje3wVo/EcLuJokWR7oaV2WFRLpZ/xt6Thny/T+x+6
	 VpWjOjiBUmETw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8J7cF41418052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 16:19:08 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 16:19:06 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 16:19:06 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 01/10] r8152: split r8156_init by generation and factor out wait_autoload_done
Date: Wed, 14 Oct 2026 16:18:55 +0800
Message-ID: <20261014081904.6491-2-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014081904.6491-1-nic_swsd@realtek.com>
References: <20261014081904.6491-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8156, RTL8156B, RTL8157 and RTL8159 shared a single r8156_init(),
gated by a dense set of tp->version range checks. That made the init
sequence hard to follow.

Split r8156_init() into two functions by chip generation:
- r8156_init (VER_10/11 and VER_12/13/15, RTL8156 and RTL8156B)
- r8157_init (VER_16/17, RTL8157 and RTL8159)

The members of each generation have near-identical sequences, so they
share a function and branch on tp->version only for the few real
differences, such as the RTL8156B-only flow-control setup or the
RTL8159-only backup-restore wait.

Also factor the repeated "poll PLA_BOOT_CTRL for AUTOLOAD_DONE" loop
into wait_autoload_done(), reusing read_poll_timeout() instead of the
500 * msleep(20) busy loops. r8153_init(), r8153b_init(),
r8153c_init(), r8153b_ups_en() and r8153c_ups_en() are converted to
use it too.

wait_autoload_done() only reports failure (nonzero) when
RTL8152_INACCESSIBLE is set; a plain AUTOLOAD_DONE timeout is logged
but otherwise treated as success, same as every one of the loops it
replaces, which only bailed out early on RTL8152_INACCESSIBLE and
otherwise fell through to the rest of the init sequence. The two
failure modes are not equivalent: once RTL8152_INACCESSIBLE is set,
generic_ocp_read()/generic_ocp_write() short-circuit to -ENODEV
without touching the device, so returning early costs nothing. A plain
timeout means the device is still reachable, so skipping the rest of
the bring-up would leave real hardware state half-configured.

No functional change intended.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 307 +++++++++++++++++++++++-----------------
 1 file changed, 180 insertions(+), 127 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index af3d7dcb2f141..518a2b42c2200 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4172,6 +4172,23 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 	return data;
 }
 
+static int wait_autoload_done(struct r8152 *tp)
+{
+	u16 ocp_data;
+	int ret;
+
+	ret = read_poll_timeout(ocp_read_word, ocp_data,
+				test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
+				(ocp_data & AUTOLOAD_DONE),
+				20000, 10 * USEC_PER_SEC, false, tp,
+				MCU_TYPE_PLA, PLA_BOOT_CTRL);
+
+	if (ret)
+		dev_err(&tp->intf->dev, "autoload done timeout\n");
+
+	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : 0;
+}
+
 static void r8153b_ups_en(struct r8152 *tp, bool enable)
 {
 	if (enable) {
@@ -4190,16 +4207,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
-			int i;
-
-			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-					return;
-				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-				    AUTOLOAD_DONE)
-					break;
-				msleep(20);
-			}
+			if (wait_autoload_done(tp))
+				return;
 
 			tp->rtl_ops.hw_phy_cfg(tp);
 
@@ -4227,16 +4236,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
-			int i;
-
-			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-					return;
-				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-				    AUTOLOAD_DONE)
-					break;
-				msleep(20);
-			}
+			if (wait_autoload_done(tp))
+				return;
 
 			tp->rtl_ops.hw_phy_cfg(tp);
 
@@ -7225,22 +7226,14 @@ static void r8152b_init(struct r8152 *tp)
 static void r8153_init(struct r8152 *tp)
 {
 	u32 ocp_data;
-	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_u1u2en(tp, false);
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			break;
-	}
+	if (wait_autoload_done(tp))
+		return;
 
 	r8153_phy_status(tp, 0);
 
@@ -7341,22 +7334,13 @@ static void r8153_init(struct r8152 *tp)
 
 static void r8153b_init(struct r8152 *tp)
 {
-	int i;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			break;
-	}
+	if (wait_autoload_done(tp))
+		return;
 
 	r8153_phy_status(tp, 0);
 
@@ -7411,8 +7395,6 @@ static void r8153b_init(struct r8152 *tp)
 
 static void r8153c_init(struct r8152 *tp)
 {
-	int i;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
@@ -7425,15 +7407,8 @@ static void r8153c_init(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_USB, 0xcbf0, BIT(1));
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			return;
-	}
+	if (wait_autoload_done(tp))
+		return;
 
 	r8153_phy_status(tp, 0);
 
@@ -8330,90 +8305,64 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	set_bit(PHY_RESET, &tp->flags);
 }
 
-static int r8159_wait_backup_restore(struct r8152 *tp)
-{
-	u32 ocp_data;
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if (!(ocp_data & PCUT_STATUS))
-		return 0;
-
-	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
-			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
-}
-
 static void r8156_init(struct r8152 *tp)
 {
 	u32 ocp_data;
 	u16 data;
-	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	if (tp->version == RTL_VER_16 || tp->version == RTL_VER_17) {
-		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
-	}
-
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
 
-	if (tp->version < RTL_VER_16)
-		ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
 
 	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15)
+	switch (tp->version) {
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
 		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
+		break;
+	default:
+		break;
+	}
 
 	r8153b_u1u2en(tp, false);
 
 	switch (tp->version) {
 	case RTL_VER_13:
 	case RTL_VER_15:
-	case RTL_VER_16:
-	case RTL_VER_17:
 		r8156b_wait_loading_flash(tp);
 		break;
 	default:
 		break;
 	}
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			return;
-	}
-
-	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp)) {
-		rtl_set_inaccessible(tp);
-		dev_err(&tp->intf->dev, "init failed, backup-restore timed out\n");
+	if (wait_autoload_done(tp))
 		return;
-	}
 
 	data = r8153_phy_status(tp, 0);
 	if (data == PHY_STAT_EXT_INIT) {
 		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
-		if (tp->version >= RTL_VER_12)
+
+		switch (tp->version) {
+		case RTL_VER_12:
+		case RTL_VER_13:
+		case RTL_VER_15:
 			ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+			break;
+		default:
+			break;
+		}
 	}
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
-	if (tp->version >= RTL_VER_16)
-		r8157_u2p3en(tp, false);
-	else
-		r8153_u2p3en(tp, false);
+	r8153_u2p3en(tp, false);
 
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
@@ -8421,11 +8370,7 @@ static void r8156_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
-	if (tp->version >= RTL_VER_16)
-		r8157_power_cut_en(tp, false);
-	else
-		r8153b_power_cut_en(tp, false);
-
+	r8153b_power_cut_en(tp, false);
 	r8156_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
@@ -8435,7 +8380,10 @@ static void r8156_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15) {
+	switch (tp->version) {
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
 		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
 
 		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
@@ -8450,43 +8398,148 @@ static void r8156_init(struct r8152 *tp)
 		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
 
 		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+		break;
+	default:
+		break;
 	}
 
 	r8156_mac_clk_spd(tp, true);
 
-	if (tp->version < RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_data &= ~CUR_LINK_OK;
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
+
+	set_bit(GREEN_ETHERNET, &tp->flags);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
+
+	switch (tp->version) {
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
+		break;
+	default:
+		break;
+	}
+
+	r8156_mdio_force_mode(tp);
+	rtl_tally_reset(tp);
+
+	tp->coalesce = 15000;	/* 15 us */
+}
+
+static int r8159_wait_backup_restore(struct r8152 *tp)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
+	if (!(ocp_data & PCUT_STATUS))
+		return 0;
+
+	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
+			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
+}
+
+static void r8157_init(struct r8152 *tp)
+{
+	u16 data;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	/* Enable SW reset */
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
+
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
+
+	r8153b_u1u2en(tp, false);
+
+	r8156b_wait_loading_flash(tp);
+
+	if (wait_autoload_done(tp))
+		return;
+
+	switch (tp->version) {
+	case RTL_VER_17:
+		if (r8159_wait_backup_restore(tp)) {
+			rtl_set_inaccessible(tp);
+			dev_err(&tp->intf->dev,
+				"init failed, backup-restore timed out\n");
+			return;
+		}
+		break;
+	default:
+		break;
+	}
+
+	data = r8153_phy_status(tp, 0);
+	if (data == PHY_STAT_EXT_INIT) {
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+	}
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+
+	r8157_u2p3en(tp, false);
+
+	/* MSC timer = 0xfff * 8ms = 32760 ms */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
+
+	/* U1/U2/L1 idle timer. 500 us */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
+
+	r8157_power_cut_en(tp, false);
+	r8156_ups_en(tp, false);
+	r8153_queue_wake(tp, false);
+	rtl_runtime_suspend_enable(tp, false);
+
+	if (tp->udev->speed >= USB_SPEED_SUPER)
+		r8153b_u1u2en(tp, true);
+
+	usb_enable_lpm(tp->udev);
+
+	r8156_mac_clk_spd(tp, true);
+
+	if (rtl8152_get_speed(tp) & LINK_STATUS)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
+	else
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
 	/* RX aggregation / 16 bytes RX descriptor
 	 * BIT(11) is specific to RTL8159, with unknown meaning
 	 */
-	if (tp->version == RTL_VER_17)
+	switch (tp->version) {
+	case RTL_VER_17:
 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
 				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
-	else if (tp->version == RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
-	else
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_ZERO_EN);
+		break;
+	default:
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+				  RX_AGG_DISABLE | RX_DESC_16B);
+		break;
+	}
 
-	if (tp->version < RTL_VER_12)
-		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
+	/* Disable Rx Zero Len */
+	rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
 
-	if (tp->version >= RTL_VER_16) {
-		/* Disable Rx Zero Len */
-		rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
-		/* TX descriptor Signature */
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
-	}
+	/* TX descriptor Signature */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
 
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
@@ -9851,7 +9904,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
-		ops->init		= r8156_init;
+		ops->init		= r8157_init;
 		ops->enable		= rtl8156_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
@@ -9873,7 +9926,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
-		ops->init		= r8156_init;
+		ops->init		= r8157_init;
 		ops->enable		= rtl8156_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
-- 
2.34.1

