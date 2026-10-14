Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8879388E69;
	Wed, 14 Oct 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966000; cv=none; b=UtPzlvPHvSBHNE1R4caGgv+z727F9Da05Cen7v6NFEDAczQddrXi5x+6dvRRUFKQoPj7atsmfKoGC97lJSk4rVi1lqytuZE6VQE+Ej+RW1wekttScCYqWEpWGOVWfytmlRYHOUJrcP6t0FZFH0h0CUOWEXMHAcmthPWyBSaRH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966000; c=relaxed/simple;
	bh=QToJfVcXwfASE/VQLqMuhQusguavV2qKKaSk17PBqiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOUIND1KHhH1cOWcfjI3E8qN/L+77DkTjKOxzdG3vhW8vaTrdbL7kTnKjghABGBVXM8OHptn4DTMDJkjYdFe0aQgD4q11Um4uN9TTK909eDQUunMvoeBiRXs97KqJtPJuGqt6L4XSa+d9sKW3z8jLK65/wXvRxSTPDaNRJPJHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tp77NYzh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tp77NYzh"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8JBaK41418223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965951; bh=rP2wsVcnwxP+VM9zdfFBT6ya9QZ/G7Z2Nx+Vgl2hSKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tp77NYzhaNGeFeLkQ7a1XlxJ53kBhTcwiQz2SxP1I7EPXUPxhwyHCQRmLt5byM/fe
	 jGLrsJpfIlyKRzXz80ATk1DmVhyslcmFJwhiMTD9n3NzGZgHByUViYfGrySL3qeswm
	 793kZMmMLcDNh9+eUuU/JA4tYRMFQNsvTgp0asyxwvK+yDmBMwLB7KnzVh3k0t74wI
	 Akor00pyDVCrFIXmclAa1VtulSMfQUrnd6db/Sl2+RM7u9vVW6avO/Op4qeEWw6xpG
	 fjSTc8wRiICRUwQaONpwUDXBHXvi3JCALMNIh32W2HIw8jYkvI1Pe+KlEVUR2YAmPn
	 yJeJHddXF+XNQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8JBaK41418223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 16:19:11 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 16:19:07 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 16:19:07 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 07/10] r8152: add rtl8157_unload and rtl8157_change_mtu
Date: Wed, 14 Oct 2026 16:19:01 +0800
Message-ID: <20261014081904.6491-8-nic_swsd@realtek.com>
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

RTL8157 and RTL8159 used rtl8153_unload() and rtl8156_change_mtu(),
which program power-cut and MTPS the way earlier chips require. Per
the datasheet, RTL8157/RTL8159 need r8157_power_cut_en() (already
used by r8157_init()) instead of r8153_power_cut_en(),
and an MTPS scaled from the configured MTU (10K-16K, max_pkt_size /
64 capped at 0xff) instead of a fixed MTPS_JUMBO.

Add rtl8157_unload(), used only by RTL8157/RTL8159: calls
r8157_power_cut_en(tp, false), then the Interrupt Mitigation disable
that rtl8153_unload() used to gate on "tp->version >= RTL_VER_16"
unconditionally, since this function now only runs for those
versions.

Add rtl8157_change_mtu(), also RTL8157/RTL8159-only, and wire it up
via ops->change_mtu in place of rtl8156_change_mtu().

Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 47 ++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index c31ce65d6a586..558ccb4682c27 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6889,7 +6889,7 @@ static void r8156_exit_oob(struct r8152 *tp)
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
-	rtl8156_change_mtu(tp);
+	tp->rtl_ops.change_mtu(tp);
 
 	switch (tp->version) {
 	case RTL_TEST_01:
@@ -6999,6 +6999,28 @@ static void rtl8156_down(struct r8152 *tp)
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
@@ -9988,11 +10010,6 @@ static void rtl8153_unload(struct r8152 *tp)
 		return;
 
 	r8153_power_cut_en(tp, false);
-
-	if (tp->version >= RTL_VER_16) {
-		/* Disable Interrupt Mitigation */
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
-	}
 }
 
 static void rtl8153b_unload(struct r8152 *tp)
@@ -10003,6 +10020,16 @@ static void rtl8153b_unload(struct r8152 *tp)
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
@@ -10181,13 +10208,13 @@ static int rtl_ops_init(struct r8152 *tp)
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
@@ -10204,13 +10231,13 @@ static int rtl_ops_init(struct r8152 *tp)
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

