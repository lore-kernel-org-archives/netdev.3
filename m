Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBE41F379;
	Mon, 14 Sep 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379255; cv=none; b=IcxO7TWhC3t7+jDLytbY864MEmtbYfRDzp+ZrpoaBAsYV+DU9oYf2i3QG8lIlPVYLtgqL7hTtqtGAZ0EcwjtFxcwsOR70Vn4sLfq3tb7TtI5LXQPTpbczAmhnLSN2ZdfZvBu2jhysJl5H8PfwYO5UipPzC8xNsaPZxlTwkY6ZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379255; c=relaxed/simple;
	bh=MEqs3p0DVOvh19W5pBdtXGmxhDlmoDSDCgFKQD1EI6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqQu1QTZ3f1vGpuQuOoqoVHtCQRQtT1qn//dGMxkSTTZ4jtairbyL2siuaqNdMBMRnlhAe6sqFn6ABl24amZA10fjOkGgHubQXZNd0rBxAhonxzc4DVEuVXb45F434+hp48BW93Y1x/MftgGL0irhOqFbcsqsqO5jJkki8WFIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VrtCmVZV; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VrtCmVZV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A999A47BC;
	Mon, 14 Sep 2026 11:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789379247; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fwLF0QDbZ26CN9mks5XhzjeG+MelCcwE9NL21pmcHPI=;
	b=VrtCmVZVG7SQy+aYd7VqdVPx8gj8BchqIpT63YWzDxd9Kb0sfMLdjplQaWadMWvMhJ1LOP
	fQ8oMxC4zql7mlPlE71EH4ruonmbhHzKXuBX0dwA6w1P5vUVXlkBLe99I0jr2YOWDLaJdG
	UsvCiaajolCH35mrETKgNCm3slkB3E13g/pnfkLP7MxzQRUAbwCjmMkVKL53z7ut186xg1
	xhg6hBL7ZF2kAbEviRya/mZZ8YHjm/iC0LFZPF2xEKh9i5VIxYhHskV3gYizxQaMfhqzRL
	zPSkoikMATo83W/aWIS58QnOIYaE9Q5su4MZZK/UQQK02F2Lgne/8DwrZrAkjA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: broadcom: enable jumbo frames on BCM54xx
Date: Mon, 14 Sep 2026 11:47:02 +0200
Message-ID: <20260914094703.1093504-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Jumbo packets need two bits that default to off, extended packet length in
the auxiliary control register and PCS transmit FIFO elasticity in the
extended control register. The latter raises the transmit limit from 4.5
KB to 9 KB at the cost of 16 ns of 1000BASE-T transmit latency, and the
two together take copper mode to 10 KB.

Without them such frames are lost on a 100M link while the same frames
pass at 1G. On a Raspberry Pi CM5, which uses a BCM54210PE, 9142 byte
frames at 100M are lost 20 out of 20 with the MAC counting every one
as transmitted. The same frames over the same path at 1G arrive intact.

Set both, which bcm_phy_enable_jumbo() already does for bcm7xxx. The
frames then arrive and the payloads check out byte for byte.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/broadcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index d1a4edb34ad2..b515e3875504 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -537,6 +537,13 @@ static int bcm54xx_config_init(struct phy_device *phydev)
 
 	bcm54xx_ptp_config_init(phydev);
 
+	/* Transmit is limited to 4.5 KB without it, see the BCM54210PE
+	 * datasheet section 5.4.12.14.
+	 */
+	err = bcm_phy_enable_jumbo(phydev);
+	if (err < 0)
+		return err;
+
 	/* Acknowledge any left over interrupt and charge the device for
 	 * wake-up.
 	 */
-- 
2.53.0

