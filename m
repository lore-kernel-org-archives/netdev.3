Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AA26982C;
	Mon, 15 Jun 2026 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781493272; cv=none; b=BxVqKIUP0K+kgWP6edVoByBPzbUAianHPGOuNPsk/eAbrlmYi6rrbPfxuLyvaY0BAAaH8QYHiGQHGIIhb3iPA/ZJCNeYkM6yacILLjsQ3F3K4jjX8BBT364xEQcVjc0D7W3H4IR2ybmB8sX4ct8XPApIaH3Z+6S/ICzQjYQKK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781493272; c=relaxed/simple;
	bh=N3c1/tJFqlWIRkPnC4zG+cJcGCRYcW7HaBYHMDGUflM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9lR4uSs5lvMA9HduqL4mYv9hnj4MtzbIMQIGOrbWYSJgPR2Ma+oIjv5o6vhz9J3YPcGFfa0eG5MSCrKnbrSBrNnUltoM43ExoCCqhdaYJAnd+kt0Phrp9DrK3HMz2VmvQ4ybjbg8tXRcxqvAw+qLnejg5JJ9c/gSlxdmwUKAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Kma+VwBA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Kma+VwBA"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F3DnQyA457249, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781493229;
	bh=+4YxkP6YfP64UBDZZEZ5eq4qEisJwZ15hPIwJF48eaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Kma+VwBAUvE+CmFTbwPbzbMHlrP8RehmBU83RWdAt3LQVrHmnHdJ68Eh8YnpifSWF
	 0rl3Ho1Du4JQLIwMtAgNn50fzFU25EFCZZh7O7HHkyA/5yjcsVVuNTp5kK9JDykrGv
	 Ml5OoV8GxCHB6pfUKwQYBbH6xjFr9gneAgGIsHut/a7/h95YuTdyjGaxN0xaXt8gBl
	 MR5G0N3TyAw/GzKbpvTwTI1DEBBHrbvyS2Wa/vjmNf1p1b1YVNhvcpg2jCt3Isc4l1
	 HQIpaa3jF+KkUB/FGCjrznONr0kjuYaTMHYlyKywwy5pZDTwwEwYcdw+wxVx5aJgMt
	 EZPLFgNIIalaQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F3DnQyA457249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 11:13:49 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 11:13:49 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Jun 2026 11:13:49 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 4/7] r8169: enable new interrupt mapping
Date: Mon, 15 Jun 2026 11:13:42 +0800
Message-ID: <20260615031345.548-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260615031345.548-1-javen_xu@realsil.com.cn>
References: <20260615031345.548-1-javen_xu@realsil.com.cn>
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
---
 drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f90ea515da48..75f6401fa6cb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3945,6 +3945,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
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
@@ -3953,6 +3962,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	RTL_W32(tp, RSS_CTRL_8125, 0);
 	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
+	if (tp->irq_nvecs > 1)
+		rtl8169_hw_enable_vec_mapping(tp);
+
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
 
-- 
2.43.0

