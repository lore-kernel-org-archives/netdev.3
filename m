Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828695FDA7;
	Tue,  1 Sep 2026 06:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243627; cv=none; b=o1Wzp/5w1UrA26PwstJ9VK0y0Cz0MShjl+VTHa/1rRP+p+LySbcXsiYW9FMWERYzvYJ+smltXRXgtUmorptVD08N1JE/oLL9t+5K7cr32rr3c/gUrXemG1Lf2QtXMXIQG72PFSGe1MDepHkeO1GuCtjDCe5Mf4XzahOyEd6dfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243627; c=relaxed/simple;
	bh=YxiFU9/82jDAV6JYBPDzG7V683ieSGbBZ51OOgOUV9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/sH3IwimrC78X6XYhGcx+9UlwLy2x+1EXJRL1AWykOM/QDNuIpYrdZQkbBG9qbYMilMZz3iOM6EqU8n/DA8rfPirKYPvTDfq5xtA7nTEMTead8MqttbEgtQMGrQhae+cd3oCeAKADiTJwqFNbIyuGgn6yexzC4yIU0gBs8UV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pAfB3HYW; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pAfB3HYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aJ
	7PhLxxl4PYQ5oEasx3MRN7GPE1zqCps2cOFgmWAvc=; b=pAfB3HYWGvDac7V2Iy
	ibBuvAl1Uy0CaCxA01Z5QR5U1dgSpDJr2xby0nrhTLRKg0fKX25QJEXqW88iLJJD
	p/+zgmscmK2mkEutq7c8sbEmYWl9kmfTkTFq+ect7a9f3bmQwrMakYnnMgK70poO
	c8XeL55jJmTfKFQN/iQOcfZc4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn78FjbpZqEUZBTQ--.7422S2;
	Tue, 01 Sep 2026 14:19:16 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cuiguoqi@kylinos.cn
Subject: [PATCH] net: phy: motorcomm: keep chip delay defaults when firmware provides none
Date: Tue,  1 Sep 2026 14:19:15 +0800
Message-Id: <20260901061915.3410228-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn78FjbpZqEUZBTQ--.7422S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryUWry7Xw4fKFWxCry3Arb_yoW8tFy7pr
	W5XFWYqrWqg3W8Gwn8tan7ZryFqan3JrW7Gr1rWw1F9ws8AF9Yvr48KFy7tF1UCrW8Xa1a
	vrZ5WayDuas0krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvMKtUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-gT0XWqWbmT87wAA32

From: cuiguoqi <cuiguoqi@kylinos.cn>

ytphy_rgmii_clk_delay_config() unconditionally programs the YT8521
RGMII delay registers. When firmware describes neither
rx-internal-delay-ps nor tx-internal-delay-ps,
ytphy_get_delay_reg_value() falls back to the default 1950 ps values
and those are still written into CCR and RC1R, overwriting the chip
strap/OTP settings. With phy-mode "rgmii-rxid" this clears the RX
internal delay the MAC relies on, causing CRC errors, packet loss and
link training failures at gigabit speed until the link falls back to
100M.

The fallback only supplies a value and does not skip the register
write, so the check belongs in the caller. Since the hardware links
cleanly at gigabit with the chip defaults untouched, return early when
firmware provides neither delay property. Delays supplied via DT or
ACPI _DSD are still honored.

Since commit fffedfece2b4 ("net: phy: motorcomm: use device properties
for firmware tuning") switched the driver to the generic device
property API, this applies to both DT and ACPI platforms.

Fixes: a6e68f0f8769 ("net: phy: Add dts support for Motorcomm yt8521 gigabit ethernet phy")
Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
---
 drivers/net/phy/motorcomm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 5071605a1a11..a8b8ebbd4d6b 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -895,6 +895,18 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 	u16 mask, val = 0;
 	int ret;
 
+	/* When firmware provides no delay properties, keep the chip's
+	 * strap/OTP defaults untouched. Rewriting the delay registers here
+	 * would zero the RX internal delay that rgmii-rxid relies on,
+	 * which breaks gigabit links (CRC errors and intermittent link
+	 * training failures).
+	 */
+	if (!device_property_present(&phydev->mdio.dev,
+				     "rx-internal-delay-ps") &&
+	    !device_property_present(&phydev->mdio.dev,
+				     "tx-internal-delay-ps"))
+		return 0;
+
 	rx_reg = ytphy_get_delay_reg_value(phydev, "rx-internal-delay-ps",
 					   ytphy_rgmii_delays, tb_size,
 					   &rxc_dly_en,
-- 
2.25.1

