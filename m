Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2463A6407;
	Tue,  8 Sep 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854244; cv=none; b=Sz59oiJ+0SLmQbAaownjSm3npU358EzkHI/2F3DSgfM+jY2OJlNSGOlS4pKhYkt38muwE5I7+rKyVJ1oRUTevVIUMgh3sReRr+a+HYUVexm9OlZkws/w38cAi9xGfXEqrpLfay0DdVPoWARKHKxoSs83WW3DpO1yQ4iCXHZP7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854244; c=relaxed/simple;
	bh=PqLhcG0aT5clGu5Dw1HqgmUKuL/pzEd3DSrWsCLf5G8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae6r6e6iws1OH21sthp5BIgTWTonrcKlsy605j/vsbCjO1vAL8+FukoMIbUD/MPoQrMYUqfLl15VQJl0FEjgfraIhs6zGnBida2LhZfGZe7/8/sYn69W7+K5aJ/hg5d3R8yQRbTto5hmbSIbOCIom6U2w5h3dltUoN8sms09GU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qgv6ZlDE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Qgv6ZlDE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6887uehO73640599, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788854200; bh=atd2Utawa9M71MPDDdppeWjH4Cv/NmZezF6KxsDcVBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Qgv6ZlDE2CoHz05RZUj+LXiAIehtapLAlAlzpkACfE74FnSfGkrE20uYDNFYFjJCo
	 N24hJmZIlUp91KtXiyZWUBDj5mDHi/Qn9v/OWt2E+39QeJMzP37GPTV0DYwnr5CK0d
	 YgOzbpMQvR1V/TIU/JCAdXvhQAG85Us7N6con7hDP8MPnEuUwUeQHRBYg1MdPvlT5e
	 hE9CuXHx3Z74bzvxW51zTneNz8p3nmrNNi3I6cfj4UHzL46nF8RzFV14q38UshNxJs
	 We66uWSevXZrDtftWYnNqRtMSH4yK+GMB4l5QbXqhujkzZed3f4Tlip74y4MOXiHLS
	 tcBGH9KZZ8XaA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6887uehO73640599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Sep 2026 15:56:40 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 8 Sep 2026 15:56:38 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Tue, 8 Sep 2026 15:56:38 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 5/8] r8152: support rtl8157_unload and rtl8157_change_mtu
Date: Tue, 8 Sep 2026 15:56:31 +0800
Message-ID: <20260908075634.23740-6-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908075634.23740-1-nic_swsd@realtek.com>
References: <20260908075634.23740-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8157 and RTL8159 need a dedicated unload callback to disable interrupt
mitigation and use r8157_power_cut_en instead of r8153_power_cut_en. They
also need a dedicated change_mtu that scales MTPS between 10K and 16K
depending on the MTU, unlike rtl8156_change_mtu which uses a fixed MTPS.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 47 ++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 679aead731f73..06fad895fce09 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7024,6 +7024,28 @@ static void rtl8156_down(struct r8152 *tp)
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
@@ -7048,7 +7070,7 @@ static void rtl8157_up(struct r8152 *tp)
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
-	rtl8156_change_mtu(tp);
+	rtl8157_change_mtu(tp);
 
 	/* share FIFO settings */
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
@@ -10174,11 +10196,6 @@ static void rtl8153_unload(struct r8152 *tp)
 		return;
 
 	r8153_power_cut_en(tp, false);
-
-	if (tp->version >= RTL_VER_16) {
-		/* Disable Interrupt Mitigation */
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
-	}
 }
 
 static void rtl8153b_unload(struct r8152 *tp)
@@ -10189,6 +10206,16 @@ static void rtl8153b_unload(struct r8152 *tp)
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
@@ -10367,13 +10394,13 @@ static int rtl_ops_init(struct r8152 *tp)
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
@@ -10390,13 +10417,13 @@ static int rtl_ops_init(struct r8152 *tp)
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

