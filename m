Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191464;
	b=P208SY2HIFtY2Tp7SvtIpsY8WLkSxwAHPKLy9DSyumS15P3Oajjb5qQ6OSyxY7XUq4Va
	 ZakL76yJEtHJ1RvyCSd1sjznTlWivqhO5DuycRbHrfmllVdog4fYPSckMA79Gakx/mDUg
	 s78JzwGSaxg4vhKrSEYOKfjyzSNHOW4YVkzPF0JPpx4URjsFzP/a4IkqE1Ilh3CXu+V3x
	 2rFPzYcIuFs+avnbBP2rNrCeCbti4PuAaLH2cKxqseA5wGXmdRGocGPx6DZE9jVzn2IIW
	 7hRpQa3LYSYFrhzyPVmgGjKe/5ZLNiWIgg1GUsOAWGbTEhI0sMeAvx3l6x4IngzWq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191464;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=4yryIkxc7awM2V3LUjT2LqUm4GqHSXVxs0HKbLqH8+E=;
	b=2olszxk7UaZ+Cglhz6x2tp6LpB8kJTxmGKdE/1bWMEFEMUEDbRspZ2GjCm6H9NdTcveZ
	 gLtE2wJ35nd/nRVmELpSHPDMg4O9PaNmcSQnKDUwiWm+T7L8d9GAeLEz4mx1FlHenQc5G
	 zuuyae6EgrqTtOtI97rWsx2Pno1ZuT6EagNOLYZXm9AdhPr4x4GAtWIssc/+qsmNi1G1D
	 8b5sNjnG9JUk6ZH5bi6MkR7dzhlxZQshQ3dz7N972jyealQqVBmN1wLX0A5J0hUfXlO52
	 M8Gw2YjnsU/mKdA/L+MuvwVyslkw7LmrNmtGAevDMg7AMKHnG0dZle4z1G29GYok8LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b="mg/VRS99";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E5606A336;
	Mon,  9 Nov 2026 02:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 186E5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=mg/VRS99
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A92UPnfC3939943, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794191426;
	bh=4yryIkxc7awM2V3LUjT2LqUm4GqHSXVxs0HKbLqH8+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mg/VRS99Oiy9RTdIdC0dj0pkeHatZeauNmCfh4mDMNu7ze1ewWTpngN284mWba+zA
	 paMYNSqFxSrtQzmhXcb11icKWdRWZL1y+lLpxXIaaNxIInDl4BSc6+uopd2eW6PYmD
	 l2zpV+R8jQtJNmDmp6VrcurQp+m9wP3fHgy75b/31GVhKvc7kZYoNVCWlV6q+fLBht
	 /Q6RLgvHqilu6NHhxTg76w4anrB4QEGpmQhJe1sqH/uLSDf262PY390bLXsjZAVnRS
	 ww7HJyEaizGzclF3xBDX/TrnGr27OGei9WQYzQnZdPBPK0r/SK4hvMmT6IVvLPSSIc
	 sUm5lA5enq9Cg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A92UPnfC3939943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 10:30:26 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:30:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 10:30:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 1/3] r8169: make PHY OCP access safe in atomic context
Date: Mon, 9 Nov 2026 10:30:20 +0800
Message-ID: <20261109023022.770-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261109023022.770-1-javen_xu@realsil.com.cn>
References: <20261109023022.770-1-javen_xu@realsil.com.cn>
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

From: Javen Xu <javen_xu@realsil.com.cn>

r8168_phy_ocp_read() and r8168_phy_ocp_write() wait for the GPHY_OCP
handshake with rtl_loop_wait(), which may sleep (fsleep(25)). Upcoming
PTP support for RTL8127A accesses the PTP block through the same PHY
OCP interface from atomic context (spinlock held, NAPI RX path), and
concurrently with phylib MDIO accesses.

Busy-wait for the handshake with readl_poll_timeout_atomic() instead,
keeping the previous maximum wait time of 250us, and serialize the
GPHY_OCP register accesses with a new spinlock.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 37 +++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index cd4ebc654dd0..96d3a2bd7094 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -20,6 +20,7 @@
 #include <linux/if_vlan.h>
 #include <linux/in.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/interrupt.h>
@@ -881,6 +882,7 @@ struct rtl8169_private {
 	} wk;
 
 	raw_spinlock_t mac_ocp_lock;
+	spinlock_t phy_ocp_lock;	/* serialize GPHY_OCP access */
 	struct mutex led_lock;	/* serialize LED ctrl RMW access */
 
 	unsigned supports_gmii:1;
@@ -1234,30 +1236,52 @@ static bool rtl_ocp_reg_failure(u32 reg)
 	return WARN_ONCE(reg & 0xffff0001, "Invalid ocp reg %x!\n", reg);
 }
 
-DECLARE_RTL_COND(rtl_ocp_gphy_cond)
+/* PHY OCP registers may also be accessed from atomic context (e.g. by the
+ * PTP code), therefore busy-wait for completion instead of sleeping.
+ */
+static int rtl_phy_ocp_wait(struct rtl8169_private *tp, bool high)
 {
-	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(tp->mmio_addr + GPHY_OCP, val,
+					!!(val & OCPAR_FLAG) == high, 1, 250);
+	if (ret && net_ratelimit())
+		netdev_err(tp->dev, "PHY OCP access timeout\n");
+
+	return ret;
 }
 
 static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
+	unsigned long flags;
+
 	if (rtl_ocp_reg_failure(reg))
 		return;
 
+	spin_lock_irqsave(&tp->phy_ocp_lock, flags);
 	RTL_W32(tp, GPHY_OCP, OCPAR_FLAG | (reg << 15) | data);
-
-	rtl_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
+	rtl_phy_ocp_wait(tp, false);
+	spin_unlock_irqrestore(&tp->phy_ocp_lock, flags);
 }
 
 static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 {
+	unsigned long flags;
+	int val;
+
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
+	spin_lock_irqsave(&tp->phy_ocp_lock, flags);
 	RTL_W32(tp, GPHY_OCP, reg << 15);
+	if (rtl_phy_ocp_wait(tp, true))
+		val = -ETIMEDOUT;
+	else
+		val = RTL_R32(tp, GPHY_OCP) & 0xffff;
+	spin_unlock_irqrestore(&tp->phy_ocp_lock, flags);
 
-	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
-		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
+	return val;
 }
 
 static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
@@ -6816,6 +6840,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->ocp_base = OCP_STD_PHY_BASE;
 
 	raw_spin_lock_init(&tp->mac_ocp_lock);
+	spin_lock_init(&tp->phy_ocp_lock);
 	mutex_init(&tp->led_lock);
 
 	/* Get the *optional* external "ether_clk" used on some boards */
-- 
2.43.0

