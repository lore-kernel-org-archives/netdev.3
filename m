Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4537FF76;
	Fri,  8 May 2026 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242728; cv=none; b=W5aTheCuDQOklJoVm8XhTrJIzLqfwI8atGoVnTPle3jio9V9cA8uDcQ75dhZxzeXUOb3x8PpEpra93NKuTUXIULKoUql1H8cIniW752QFDXGToLA/sOGHB3I+OPefMIMdYLEFVZ7Mzbmz2XVi/l2X/jwAVcLYNDeimaGPx4qVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242728; c=relaxed/simple;
	bh=HzlGzjtblL4jvidgf42n7mKFXydAkszXVaDi9pBg5dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkkAEXUs1thsPrGY9DjrLE9oYq3jnExYSkdVEkiFJMUTkDnngObFby+pSNOQcmxW+mYvJHdEDyKUuvuMpHCDEoATky7OlMyLtImJDiYiM8pHPcv1gTwPzbz9tmjQL7189pq2Eq74VhhdNxue1oOjvMpdV1tWhxLRDhF51KROAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=EKjiO8F5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="EKjiO8F5"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 648CIDqnC3782632, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778242693;
	bh=xm9GDS7FzUZXxnv14977XSx4BIDEvLx8DPw2T2cAoug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EKjiO8F5u5t03qUKjYwzNWCsXc1cMvXY/l6O+UKmvoNew8K/CLItfkDElnsnoRka9
	 ForWZNw2yTpDcy1XhHs26gc03SCNc0nb900Jp/h82wP+amtfEhcmKK7sH9BU4C6Rij
	 K9khGMU9eeVKtRrZscTamLaJvuR3GN1Xe34DfR2P+n3hzVeMkihidE9hJleIMuRjsR
	 qJa315GhsAHNzidm2HWo8Yi6zvDyM9SpGgTsjWw0Jk8oMh3LbBgioZuJwniN6dtayP
	 jrZDV3QQ8HPXdhJ8d7VUEPMAK9SRggg+LD/EtcJZUQ6NUQPe8p0Ob4yFod5HhztYls
	 A+qH5NDSVT3Zg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 648CIDqnC3782632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 May 2026 20:18:13 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 20:18:12 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 20:18:12 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v2 4/7] r8169: enable new interrupt mapping
Date: Fri, 8 May 2026 20:17:58 +0800
Message-ID: <20260508121802.2010-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260508121802.2010-1-javen_xu@realsil.com.cn>
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch enables new interrupt mapping for RTL8127.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index bb72a2030f44..0ff0671fc2ac 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3965,6 +3965,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8125_hw_set_interrupt_type(struct rtl8169_private *tp)
+{
+	u8 tmp;
+
+	tmp = RTL_R8(tp, INT_CFG0_8125);
+	tmp |= INT_CFG0_ENABLE_8125;
+	RTL_W8(tp, INT_CFG0_8125, tmp);
+}
+
 static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 {
 	rtl_pcie_state_l2l3_disable(tp);
@@ -3973,6 +3982,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	RTL_W32(tp, RSS_CTRL_8125, 0);
 	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
+	if (tp->features & RTL_VEC_MAP_ENABLE)
+		rtl8125_hw_set_interrupt_type(tp);
+
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
 
-- 
2.43.0

