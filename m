Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281107;
	b=d36nRlfey3mPxSkFuEQHallnJm3TqdnItTt2gQWkLIQRAbOqYeM6t8eTsj4aQYbmbdIX
	 Q0JV7KJmz7AgPtiOlKk72Jh/ahc2G/pX+OXobfl9F0Fnz02DPu6esYl+VXdmeAgztZ0Lf
	 YC0iC9YxxQUsSRKSxqmKUTXtloQnCLD7vsOGII8P6fyLC/RmwlX2m97rESed3cs1h+JAl
	 g/gSOo+uS8/Kjaq6NPODBniaf1zhwybWzCOkTSuoQWoIW+5eJkN54C3TELXaVcJ793VV+
	 WxJhGjqM5PzqmzsceRzIlCKHQ9QkeO4HV0RyVSB2P0K7KQMmhfJOpAM07BFGiMaZPeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281107;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=LHfrTOMBua6GXQUw0lFn7woJp3q39K7l7mtv+0KaE8A=;
	b=r3Icned1GZw4mFT2N7PN6cFQWd9HT/GDyYbyT4/4AJ3o8RnUi7fVy9qcSWrMOyejhga5
	 JeHgAcauvsUdlH61x55D4IbjSLVcipijP+NuwdvJI+Do8/OS81Lqu1ExqnAE3zzVpEfDo
	 AmA5NBn2f7/7zlOD1lUtuRaKqXyLtvmIGxfNno8ZYNwZVBGsK1LvX24PLdCXikqnekgK7
	 H5tEOmha/R60rw0uWPFlq+3yKJGDY8K/Wq/wZh07XadH/sVeBwNuf6dfMrSYA5aHYfJwM
	 EtRglMVwTYPzdyEPIqdwSOG0MpLfrjecE5+GNcsiYieKYhuISA1xewNBAocAWzstryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=qAelGHH3;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4F606A326;
	Tue, 10 Nov 2026 03:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC4F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=qAelGHH3
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3ONO00884407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281063; bh=LHfrTOMBua6GXQUw0lFn7woJp3q39K7l7mtv+0KaE8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qAelGHH3h3gAyjI6bzAKDhKAvPY5fZlDeTq14R1bDseH5X8VC9FI9OeUpSyWEfX0O
	 5TPKjuwvAm8wpCeQ54HKQD+8hU/ieSHsWOnwfPsXORxrFSOEeZ3vjNTh85acD0bp7/
	 lmukf/kxeX4OtyJs5Gb2nEbokH2ZDap02uN2cmbnJtZCbgZKXvCKi/iDjQpT3/YqMP
	 H04DIRU2YlfX75fyFo5oO4qdX5TZiVvUiYtvCgM9271UuQeHsFlXrQBGbCXDtMqjGP
	 nIZ0kKSppTBW7bMOPcAcAQHOBPf06OTUmAr6otCYUQ5jTYxWz37b6pj9kW9uj4102I
	 b/RSKJfBPzSdA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3ONO00884407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:19 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:24:19 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 03/11] r8152: add rtl8157_change_mtu() for RTL8157 and RTL8159
Date: Tue, 10 Nov 2026 11:24:08 +0800
Message-ID: <20261110032416.16968-4-nic_swsd@realtek.com>
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

RTL8157 and RTL8159 used rtl8156_change_mtu(), which programs a fixed
MTPS_JUMBO. Per the datasheet they need an MTPS scaled from the
configured MTU instead: max_pkt_size / 64, at least 10K and capped
at 0xff.

Add rtl8157_change_mtu() for them. Since rtl8156_up() is shared with
these chips, have it call tp->rtl_ops.change_mtu() instead of
rtl8156_change_mtu() directly so each chip gets its own helper.

Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index bb4106f238a3a..1517753f843ef 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6800,6 +6800,28 @@ static void rtl8156_change_mtu(struct r8152 *tp)
 		       ALIGN(rx_max_size + tp->tx_desc.size, 1024) / 16);
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
 static void rtl8156_up(struct r8152 *tp)
 {
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -6826,7 +6848,7 @@ static void rtl8156_up(struct r8152 *tp)
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
 
-	rtl8156_change_mtu(tp);
+	tp->rtl_ops.change_mtu(tp);
 
 	switch (tp->version) {
 	case RTL_TEST_01:
@@ -9900,7 +9922,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->in_nway		= rtl8153_in_nway;
 		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
-		ops->change_mtu		= rtl8156_change_mtu;
+		ops->change_mtu		= rtl8157_change_mtu;
 		tp->rx_buf_sz		= 32 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
@@ -9922,7 +9944,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->in_nway		= rtl8153_in_nway;
 		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
-		ops->change_mtu		= rtl8156_change_mtu;
+		ops->change_mtu		= rtl8157_change_mtu;
 		tp->rx_buf_sz		= 48 * 1024;
 		tp->support_2500full	= 1;
 		tp->support_5000full	= 1;
-- 
2.34.1

