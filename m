Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB733B42E6;
	Thu, 17 Sep 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628843; cv=none; b=MvofpTcyHhHII8CNoE0mS2XEAUdrW/vn9lDSSlZLznvbDjtGP2JzaiJ6aaJzegzigZdEg0MesWeqRoQ9CadpxuULgKI4MLTMR2muUYw7nqytsSbBCk8TiD7kvrc2N5DXvdmXDx+mEHtWA8MtQ+3rOHBN3C2Xq6eSc+HYyfvG7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628843; c=relaxed/simple;
	bh=1VBGEFMgNfs5Yr4FMLK0dtQpnUgrFbbiyvCshTptYek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBUbc/MzPi0LH87BhQ9X1dkV/TfxJECTTb76cMJ/0twPHhoIfaJGDLaX+sB8KuMcxhdfWSV99cH8C6JKpezYXFLQs5XGoHPu74mSxq27l0aFV3Zzy5Wb+1V4MizUDGWkKJkgPum9jTQ3XkYV2wTZfhm8uxA5IV0Yf5I2Gxtnsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sMoxL/3C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sMoxL/3C"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68H76gc363094124, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789628802; bh=AFesCvUUmcionXxA3qeOOHlRWnM8L4uxGTcaMx4zkf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sMoxL/3CD4ZUxhfM40gSbjV+81WJNsbw1BeY8/EV6S2KBFHzTdoedVllpP8jPKfF7
	 cSYNgVza61Y5hDCuZ2XXHWR+x27cxMJE5ctUfNGwX445ZA+MeAFWlY7Ok5riANW2ui
	 6g//w7IWMzDPIrzT4hb50yIkw2A0MCVP6+SNEuBnILQul5KFJAVz7YavldMr1OJ30I
	 9Jr6wVR+o0g7rL8C9WGaFNYL7X7OC3y+GsaMzAnqMqE81RHFcUrdLQGa02WaVm/Q0F
	 NnE0NsNiNC9xuI92GZxsUytuw/W6Z0+raT+tdl8uUqRubufQLfWrKa8Qee7CZPQq33
	 dCEanDAD4+vqg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68H76gc363094124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 15:06:42 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 15:06:40 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 17 Sep 2026 15:06:40 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v4 5/8] r8152: add rtl8157_unload and rtl8157_change_mtu
Date: Thu, 17 Sep 2026 15:06:34 +0800
Message-ID: <20260917070637.62827-6-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917070637.62827-1-nic_swsd@realtek.com>
References: <20260917070637.62827-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8157 and RTL8159 used rtl8153_unload() and rtl8156_change_mtu(),
which program power-cut and MTPS the way earlier chips require. Per
the datasheet, RTL8157/RTL8159 need r8157_power_cut_en() (already
used by r8157_init()/r8159_init()) instead of r8153_power_cut_en(),
and an MTPS scaled from the configured MTU (10K-16K, max_pkt_size /
64 capped at 0xff) instead of a fixed MTPS_JUMBO/MTPS_DEFAULT.

Add rtl8157_unload(), used only by RTL8157/RTL8159: calls
r8157_power_cut_en(tp, false), then the Interrupt Mitigation disable
that rtl8153_unload() used to gate on "tp->version >= RTL_VER_16"
unconditionally, since this function now only runs for those
versions.

Add rtl8157_change_mtu(), also RTL8157/RTL8159-only, and wire it up
via ops->change_mtu in place of rtl8156_change_mtu().

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 47 ++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d30031dbf2d38..f44dcb88b5c6a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7004,6 +7004,28 @@ static void rtl8156_down(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 }
 
+static void rtl8157_change_mtu(struct r8152 *tp)
+{
+	u32 max_pkt_size = mtu_to_size(tp->netdev->mtu);
+	u32 ocp_data;
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, max_pkt_size);
+
+	/* Use at least 10K for MTPS */
+	ocp_data = max_t(u32, max_pkt_size, 10 * 1024) / 64;
+
+	/* 16 * 1024 / 64 = 0x100, so the max is 0xff for 8 bits data */
+	ocp_data = min_t(u32, ocp_data, 0xff);
+
+	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, ocp_data);
+	r8156_fc_parameter(tp);
+
+	/* TX share fifo free credit full threshold */
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, 512 / 64);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_FULL,
+		       ALIGN(max_pkt_size + tp->tx_desc.size, 1024) / 16);
+}
+
 static void rtl8157_up(struct r8152 *tp)
 {
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -7028,7 +7050,7 @@ static void rtl8157_up(struct r8152 *tp)
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
-	rtl8156_change_mtu(tp);
+	rtl8157_change_mtu(tp);
 
 	/* share FIFO settings */
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
@@ -10151,11 +10173,6 @@ static void rtl8153_unload(struct r8152 *tp)
 		return;
 
 	r8153_power_cut_en(tp, false);
-
-	if (tp->version >= RTL_VER_16) {
-		/* Disable Interrupt Mitigation */
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
-	}
 }
 
 static void rtl8153b_unload(struct r8152 *tp)
@@ -10166,6 +10183,16 @@ static void rtl8153b_unload(struct r8152 *tp)
 	r8153b_power_cut_en(tp, false);
 }
 
+static void rtl8157_unload(struct r8152 *tp)
+{
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	r8157_power_cut_en(tp, false);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+}
+
 static int r8152_desc_init(struct r8152 *tp)
 {
 	tp->rx_desc.size = sizeof(struct rx_desc);
@@ -10344,13 +10371,13 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8157_up;
 		ops->down		= rtl8157_down;
-		ops->unload		= rtl8153_unload;
+		ops->unload		= rtl8157_unload;
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
 		ops->in_nway		= rtl8153_in_nway;
 		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
-		ops->change_mtu		= rtl8156_change_mtu;
+		ops->change_mtu		= rtl8157_change_mtu;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
@@ -10367,13 +10394,13 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8157_up;
 		ops->down		= rtl8157_down;
-		ops->unload		= rtl8153_unload;
+		ops->unload		= rtl8157_unload;
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
 		ops->in_nway		= rtl8153_in_nway;
 		ops->hw_phy_cfg		= r8159_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
-		ops->change_mtu		= rtl8156_change_mtu;
+		ops->change_mtu		= rtl8157_change_mtu;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
-- 
2.34.1

