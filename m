Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E553126D6;
	Mon,  3 Aug 2026 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723226; cv=none; b=chQmNBNrQIcS3tZvP2t/i6MBcfVxUF/xMkHHvvpUrir5ipEtSGvbQikbBuw8YEs/WXNYhVeYf+GiDVcAfv5RKEdcvfvPlUOcADMJmTBi67egn3fiQ113m8+lruS0xEbh5WvgRatlQWEsS3oPBPzy/tQJaex1mwN0Tb+VJ09/0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723226; c=relaxed/simple;
	bh=YpLtcmg4w7ZpGlfHNnRQhlvYKC1wEZ2379f06kzUH1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnKtqFtyC7xpipfAbpXsFGFTVO9FwQdbdlHK8ameBGUD2Qo/E19xW2JKhZkpVpSPG42VIodc2BesXVocPbm6jWtFVcgUykmy0pRU410PJHemCTJzXTXZhn1AeqOMlQC+RpaSo5ZVvwSA81W6OQsX9Zd3fJlMXbeYwVbVxQGzJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=a7PcsvAl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="a7PcsvAl"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6732D8Kv83810915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785723189;
	bh=hZnOBG91S3vUMMCnjP/mVvpHrXL+Rel8irlG/Z+4YIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=a7PcsvAl4GCENRiwNeRDFiFeAtVs0OnEjEWoYiGDDU8EI99yigUzxfod2huphndfj
	 jAbUOC3nQEAYKn3QzrhrziEvb2PfHn14ewJGIVzzkFUfHDiYGoBKsc8SviEqh1gAzz
	 An4tviFDY74fiI2OBZt+mwVzAXkzvWUb88iRW9sqb9VUQFPRhIqlaL9m6unvtIIl7l
	 1VlIF9T/zV6v2bLR5XK3nW5L35GWjKFd3YoueXCwpUXPr7f2dRp6zmqSbpXq6NsSgd
	 6czqKG40U/OXG9NckQoZqoKdSm3zIb2l+A2VwJYjiArYXRTJo404Oy9W+bwG+AuvUC
	 2m8i/GF5lDmsA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6732D8Kv83810915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Aug 2026 10:13:08 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Aug 2026 10:13:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 3 Aug 2026 10:13:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 4/7] r8169: enable new interrupt mapping
Date: Mon, 3 Aug 2026 10:13:02 +0800
Message-ID: <20260803021305.488-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260803021305.488-1-javen_xu@realsil.com.cn>
References: <20260803021305.488-1-javen_xu@realsil.com.cn>
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
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - no changes

Changes in v7:
 - no changes

Changes in v8:
 - no changes

Changes in v9:
 - no changes

Changes in v10:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6a7e9d875cf0..31f6d0c2e3d1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3937,6 +3937,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
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
@@ -3945,6 +3954,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	RTL_W32(tp, RSS_CTRL_8125, 0);
 	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
+	if (tp->irq_nvecs > 1)
+		rtl8169_hw_enable_vec_mapping(tp);
+
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
 
-- 
2.43.0

