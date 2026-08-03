Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396F3377ABF;
	Mon,  3 Aug 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752108; cv=none; b=rRcGKCq96ERxmc+EcdWlCevLBZ86gi4BpOoTzJ5x5mRv6NrTd28QIb+oqUWDf336vD39eMLHhoSA0RjHhkLbjhqPp4oUzsyaetGp2R7GwV5RIAYuISpEDdyXdmc8a+EmVmApivdtSFRzW1X6q1aevb28RB1XCwJQgh3tavjxmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752108; c=relaxed/simple;
	bh=VDCFDjjzMueT3uC3KTWgxQYVR++dcRtmQp4VgUJgJnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXJKRelZw7ch5TKuw75E0NOHjHVdGeeryuVRuzZnHc6P2p5nZqNQ9XGPEeOfT043NLnjjyz6Wvoqo6EbImhuMzZ5VXrPcKauQqigc6zJOV0T4XcYN6i5CQ2hy1ND2yA1CWMpP1OpvBKTAhb6yTGa1myNW6MLk+kKdwRH8hvZSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c2Fm56IH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c2Fm56IH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EDB81476;
	Mon,  3 Aug 2026 03:15:02 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A633F632;
	Mon,  3 Aug 2026 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785752106; bh=VDCFDjjzMueT3uC3KTWgxQYVR++dcRtmQp4VgUJgJnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2Fm56IHDW776AjxEwkEjJlr6yeoqh9t4NrATKRW0HPew47HNVW+d3aVw98NGOVSG
	 mUWTWK8ohP0FGpaP7JYvEbrlDMHHnklUwdo5zhxg5TJ2PrG4dSad8a+uWCoyl2y1ut
	 kwYPVOw2g7KwHReAshZZfGQ8CoL73f9K218Enoq0=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Liu Changjie <liucj1228@outlook.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] net: phy: maxio: prepare for more DT properties
Date: Mon,  3 Aug 2026 12:14:47 +0200
Message-ID: <20260803101452.2993721-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101452.2993721-1-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
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
 drivers/net/phy/maxio.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
index d2cb23895646..95a2169f25df 100644
--- a/drivers/net/phy/maxio.c
+++ b/drivers/net/phy/maxio.c
@@ -43,18 +43,18 @@ static int maxio_mae0621a_probe(struct phy_device *phydev)
 
 	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
 				       &frequency);
-	if (ret == -EINVAL)
-		return 0;
-	if (ret)
+	if (!ret) {
+		if (frequency != 125000000) {
+			phydev_err(phydev, "invalid CLKOUT frequency %u\n",
+				   frequency);
+			return -EINVAL;
+		}
+
+		priv->clk_out_125m = true;
+	} else if (ret != -EINVAL) {
 		return ret;
-
-	if (frequency != 125000000) {
-		phydev_err(phydev, "invalid CLKOUT frequency %u\n", frequency);
-		return -EINVAL;
 	}
 
-	priv->clk_out_125m = true;
-
 	return 0;
 }
 
-- 
2.43.0

