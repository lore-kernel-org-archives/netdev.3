Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB6479877;
	Wed, 16 Sep 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549292; cv=none; b=eU1QCoo8twrpkVnwFv8IOe+pRxY+zkB2m0TIH1YvttWZkF3/q1ptrm9cwf9d0Y5oz54ZHfrZs55WG2eOj86/V0P2W3s223kgR7C3YYHWLd4aZ1aV7i487s84vk6PHAdQTwc4p1/3t50OX4kktyoeXtfnwNOhWIy9eGVr+eN1vd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549292; c=relaxed/simple;
	bh=Lh2YpoweQWTV782T1aSpLLm143KnrvMJcpmoWZTmQ8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEFwJjF5rW1Wpl12oe/mt5jgb7/dnXJtcLzu+kYp6e8T4juAaNicTWA1ZpOGMInjlgDTBAbPMIbjfcQMHA/1KSNMiuwfxLLLLs7gqx5017Z92d5Z8s835KiHzFPn7EVq6qRkKnPFUaEgDUiKCMGGf+BQFqsDXenF1DW5OGJLi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: andrew@lunn.ch
X-PTX-Original-Recipient: luizluca@gmail.com
X-PTX-Original-Recipient: olteanv@gmail.com
X-PTX-Original-Recipient: davem@davemloft.net
X-PTX-Original-Recipient: edumazet@google.com
X-PTX-Original-Recipient: linusw@kernel.org
X-PTX-Original-Recipient: kuba@kernel.org
X-PTX-Original-Recipient: pabeni@redhat.com
X-PTX-Original-Recipient: o.rempel@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: a.fatoum@pengutronix.de
X-PTX-Original-Recipient: alvin.sipraga@analog.com
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: netdev@vger.kernel.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B696201E6B;
	Wed, 16 Sep 2026 11:01:03 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x6lVn-001CpZ-1f;
	Wed, 16 Sep 2026 11:01:03 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x6lVn-00000001Sqg-1r0W;
	Wed, 16 Sep 2026 11:01:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: dsa: realtek: rtl8365mb: extract PHY OCP address halves with FIELD_GET
Date: Wed, 16 Sep 2026 11:01:01 +0200
Message-ID: <20260916090102.349157-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916090102.349157-1-o.rempel@pengutronix.de>
References: <20260916090102.349157-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the two OCP address halves with FIELD_GET() before handing them
to FIELD_PREP() to build the ADDRESS register value.

rtl8365mb_phy_ocp_prepare() previously fed FIELD_PREP() the raw
ocp_addr >> 1 and >> 6. FIELD_PREP() masks the value to the field at run
time, so that was correct for the current callers, which all pass a
run-time register address.

FIELD_PREP()'s compile-time width check only fires for a compile-time
constant value. None reached it here: the address is computed as
PHYREG_BASE + regnum * 2 from a run-time regnum. The EEE support that
follows adds callers with constant OCP addresses (0xa5c4 etc.); clang
folds those into the inlined ocp_prepare(), so the shifted constant now
reaches the check, overflows the 5-/4-bit field and breaks the build
(gcc does not fold it here). FIELD_GET() narrows each half to the field
width first, so the value already fits.

No functional change.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
New in v3, fixing the clang FIELD_PREP build failure Jakub Kicinski
reported against v2.
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index f8220d832e46..efde1f3b604e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -199,6 +199,14 @@
 #define   RTL8365MB_GPHY_OCP_MSB_0_CFG_CPU_OCPADR_MASK	0x0FC0
 #define RTL8365MB_PHY_OCP_ADDR_PREFIX_MASK		0xFC00
 
+/* The full 16-bit OCP address is split across two registers: bits [15:10] are
+ * the prefix (RTL8365MB_PHY_OCP_ADDR_PREFIX_MASK above), and bits [9:1] go into
+ * the ADDRESS register as two fields, [5:1] and [9:6]. Bit 0 is always 0 - PHY
+ * OCP registers are 2-byte aligned.
+ */
+#define RTL8365MB_PHY_OCP_ADDR_5_1_MASK			GENMASK(5, 1)
+#define RTL8365MB_PHY_OCP_ADDR_9_6_MASK			GENMASK(9, 6)
+
 /* The PHY OCP addresses of PHY registers 0~31 start here */
 #define RTL8365MB_PHY_OCP_ADDR_PHYREG_BASE		0xA400
 
@@ -871,6 +879,8 @@ static int rtl8365mb_phy_poll_busy(struct realtek_priv *priv)
 static int rtl8365mb_phy_ocp_prepare(struct realtek_priv *priv, int phy,
 				     u32 ocp_addr)
 {
+	u16 ocp_addr_lo = FIELD_GET(RTL8365MB_PHY_OCP_ADDR_5_1_MASK, ocp_addr);
+	u16 ocp_addr_hi = FIELD_GET(RTL8365MB_PHY_OCP_ADDR_9_6_MASK, ocp_addr);
 	u32 val;
 	int ret;
 
@@ -887,9 +897,9 @@ static int rtl8365mb_phy_ocp_prepare(struct realtek_priv *priv, int phy,
 	val = RTL8365MB_PHY_BASE;
 	val |= FIELD_PREP(RTL8365MB_INDIRECT_ACCESS_ADDRESS_PHYNUM_MASK, phy);
 	val |= FIELD_PREP(RTL8365MB_INDIRECT_ACCESS_ADDRESS_OCPADR_5_1_MASK,
-			  ocp_addr >> 1);
+			  ocp_addr_lo);
 	val |= FIELD_PREP(RTL8365MB_INDIRECT_ACCESS_ADDRESS_OCPADR_9_6_MASK,
-			  ocp_addr >> 6);
+			  ocp_addr_hi);
 	ret = regmap_write(priv->map_nolock,
 			   RTL8365MB_INDIRECT_ACCESS_ADDRESS_REG, val);
 	if (ret)
-- 
2.47.3

