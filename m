Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAEB30C631;
	Sat, 26 Sep 2026 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463692; cv=none; b=EpC2EmihzPOnbbCBT/JgyKrfK2McjxSkDTV7iXeXcKaS7pDizkxih75jEOG1mb7P7nCbZebrDzuRRG/24W/7J2nzLr0ViFAhaOrTLJOSkfPUmwR0wIJ1hJqQklTk1jCxtP80KyoBjJB/9vc/sCtmKnT/Bg3cpG2fBSTT0WG6II8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463692; c=relaxed/simple;
	bh=EW+gpQ5WLWD45WtO6TAVherGPg+xo/AO6cUjY2hcB3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skHrJpxIcBet2pvAc2YxJml8EskQ8R/kT7hSjPfpaylHAfeZqp2/hjhMKy0dnSSAoeCjJz13FJzXHXPyYjjWfM6LLUj+EL4PygGXMChJNLFXTKCphlNWIDQTYW94IrNHZyXbWlfGu2b1PFEN4mQNlU927kat11xK9Gwc5siPL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c/Ewr26Z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c/Ewr26Z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7433E169C;
	Sat, 26 Sep 2026 16:01:24 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 333E83F632;
	Sat, 26 Sep 2026 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790463688; bh=EW+gpQ5WLWD45WtO6TAVherGPg+xo/AO6cUjY2hcB3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/Ewr26Z4AGrQHxktygAU7TFaSiQGW6ZJ4q1wKRB2HQbf9xCTrRrnWlAV3uStJvBn
	 eBwLxoHfuf8tsEFCGsMY/CeRVXZWrn2QFAwNOlfN4q49mpqTZfe1rp5pvgcoT7ckMm
	 J/d01Uxb/aICP0a5jFqIqtdp+B0TTLHyw/SCo2D8=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/5] net: phy: maxio: prepare for more DT properties
Date: Sun, 27 Sep 2026 00:56:23 +0200
Message-ID: <20260926225625.25969-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260926225625.25969-1-andre.przywara@arm.com>
References: <20260926225625.25969-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe routine for the Maxio PHY returns early if the optional
maxio,clk-out-frequency-hz property is not found. That prevents looking
for other properties.

Refactor the routine to handle the property in an if-clause, to allow
more actions in the probe routine later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/phy/maxio.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
index d2cb238956460..9ba82c1cd8b13 100644
--- a/drivers/net/phy/maxio.c
+++ b/drivers/net/phy/maxio.c
@@ -43,18 +43,20 @@ static int maxio_mae0621a_probe(struct phy_device *phydev)
 
 	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
 				       &frequency);
-	if (ret == -EINVAL)
-		return 0;
-	if (ret)
-		return ret;
-
-	if (frequency != 125000000) {
-		phydev_err(phydev, "invalid CLKOUT frequency %u\n", frequency);
-		return -EINVAL;
+	if (ret) {
+		/* the property is optional, so ignore -EINVAL */
+		if (ret != -EINVAL)
+			return ret;
+	} else {
+		if (frequency != 125000000) {
+			phydev_err(phydev, "invalid CLKOUT frequency %u\n",
+				   frequency);
+			return -EINVAL;
+		}
+
+		priv->clk_out_125m = true;
 	}
 
-	priv->clk_out_125m = true;
-
 	return 0;
 }
 
-- 
2.46.4

