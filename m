Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C33AEF51;
	Tue,  5 May 2026 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963308; cv=none; b=OCGzP6ZQFCHgRlC2Mw5+R/oZgZIAA2iCWH1X9Tcxw4Uk7GHFaNgdqF9qZDXQXEFQRjCO6RVwS+fzqMBjDzl5DU/R5TxWfELqnS+JUfb1yL5Italk9wiUj1KyHUEdrGC05/WndjpaOSW3ub3jauOxv8bu0/GgMM0xBRfEhfdvCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963308; c=relaxed/simple;
	bh=bd8HXVzKt09cazmBut29dDGWpM6jev+aRdtNqHSOPdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hh6kdHCyxaGGOCU6sKYprJnxt5ItYUXr8EPHE8J7TegTWKJe8LkA3RiUlkLnq1/ZDeweDm4O91TZM0+PAzqouK4u7h377a1eqpXPHabos8JOj+4TAcplwGoFt1+J3VgpPvD0kNFhj8bj0Oqmy4iXHlvDvVcFTjlKuc+2msCpIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lWNtwTnb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lWNtwTnb"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6456fN1111054291, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777963283; bh=y+eLeNqDY5wDt54smZX4UeBsdpOUB49t/62TAoSFw0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=lWNtwTnb8WqE9C1x0l8bMkcwapMDigJLoSSbaCzOnJzvM//kx85f15gMRy+pWFPDZ
	 RubnoOEAh3f1CG42u5yR9jyQfTLQVG1QWMIvlxceUpfUXdH7oEuHOybTVnorgjGewp
	 C1glV0JzYEtWBWvuu5POjrmpG+9iZlwTqMHuJvzqLehpr/b8bcLqAr3SJryYbSZVh2
	 wFR97zl4GEqfo2XH16Jkshwb0GKZ7EbAX4mdYjarUKySVcCommZd+pKIVD+7zj7kik
	 YrkrbD4kMVBaUz18xPg0XgCm1Cx1uZI8rU+PY2WsvPQdYvO8KfcwV8qwJXXJzZlDAB
	 qMptSh0nhKPlg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6456fN1111054291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 14:41:23 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 5 May 2026 14:41:23 +0800
Received: from RTDOMAIN (172.21.42.225) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 5 May 2026 14:41:23 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v2] rtase: Fix flow control configuration
Date: Tue, 5 May 2026 14:41:21 +0800
Message-ID: <20260505064121.31286-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The hardware has two sets of registers controlling TX/RX flow control.
The effective flow control state is determined by the logical OR of
these two sets of bits.

RTASE_FORCE_TXFLOW_EN and RTASE_FORCE_RXFLOW_EN in RTASE_CPLUS_CMD are
the bits used by the driver to control TX/RX flow control according to
the ethtool pause configuration.

RTASE_TXFLOW_EN and RTASE_RXFLOW_EN in RTASE_GPHY_STD_00 are another
set of TX/RX flow control enable bits. Clear them by default so they do
not keep flow control enabled independently of the driver setting.

With the RTASE_GPHY_STD_00 bits cleared, the effective flow control
state is controlled through RTASE_CPLUS_CMD, so the ethtool setting can
take effect correctly.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
v1 -> v2:
- Rebase onto net-next.
- Expand commit message.
---
 drivers/net/ethernet/realtek/rtase/rtase.h      | 4 ++++
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index b9209eb6ea73..9bd6872474c1 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -153,6 +153,10 @@ enum rtase_registers {
 #define RTASE_FORCE_TXFLOW_EN BIT(10)
 #define RTASE_RX_CHKSUM       BIT(5)
 
+	RTASE_GPHY_STD_00 = 0x6024,
+#define RTASE_RXFLOW_EN BIT(7)
+#define RTASE_TXFLOW_EN BIT(6)
+
 	RTASE_Q0_RX_DESC_ADDR0 = 0x00E4,
 	RTASE_Q0_RX_DESC_ADDR4 = 0x00E8,
 	RTASE_Q1_RX_DESC_ADDR0 = 0x4000,
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index ef13109c49cf..bde9bccfb5a9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -974,6 +974,9 @@ static void rtase_hw_config(struct net_device *dev)
 	rtase_hw_set_features(dev, dev->features);
 
 	/* enable flow control */
+	reg_data16 = rtase_r16(tp, RTASE_GPHY_STD_00);
+	reg_data16 &= ~(RTASE_TXFLOW_EN | RTASE_RXFLOW_EN);
+	rtase_w16(tp, RTASE_GPHY_STD_00, reg_data16);
 	reg_data16 = rtase_r16(tp, RTASE_CPLUS_CMD);
 	reg_data16 |= (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
 	rtase_w16(tp, RTASE_CPLUS_CMD, reg_data16);
-- 
2.40.1

