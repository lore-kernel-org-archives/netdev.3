Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAB395AFE
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734129; cv=none; b=kmLQj5hO1Dgw0mL03Wbwco69pYfT18ZaaaFPBP5wUJr0IOiwcRA48wfmf89Dp9GjT5smUe9Hj1UPql7GoKafV6NkJekWUPl0pMC0y/sty7/mm27rCHs2p3fZZWCgQA4d/77C8NNIvS1/DogJ1kRtav+28oR2lmbsG71Nu/4LfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734129; c=relaxed/simple;
	bh=APfgpJTVA4pOI91gbDaanL4SMg80qg6DwGibNA5NVGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sksvJ78MXQiwpyzpaiY2FuO8S5nAbAb/yv0voN/fzxFs9aL+Lcmp4UQdNS+OVWUPrsw7oxL5JZpwymo+OfaEYuYQSc73GHAWYD5iA1paUU6coRK/aRMdlIwbYoIaYSA+e6BoBZlewURjqN8pVUK3Cg7iVtcFal6IpGBnMdXA5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDHdkEZd; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDHdkEZd"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ebd88be784so1889290a34.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734126; x=1786338926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkDHET87UFExhpdvkNx3ant78q307rzdUT3zfbIoItk=;
        b=XDHdkEZdvzQfxCnplBGuU+kQYf1S11Qng9ussEFMuE6mG9NJC441s1IJ3/SCFYLhQB
         ZgO2nEVzP1zrlkPSRTEvT2TDCb0hGA3Gb+FwvQGfR+RaSJRIRPJGQfp6997KVl7xvqMH
         Ic7CHVR6Q9VFTJRI9IzSRLsbs+5pQSO46cVxxoTiwdZFA4eUgdnqTjrZBR9j2AKaNPdM
         59CrBpYTvY0jn+oX5axSmDtWM0BUWyouYsLwhTGjYrAxedPjNFjir2bE92hLptkE2YHn
         QMjT0YElC5xkoEGHUombxzE6wPsSrFmNCL7IgXlXhzUPsDY3qYJffjlW4/pTs0f5vrv4
         qyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734126; x=1786338926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkDHET87UFExhpdvkNx3ant78q307rzdUT3zfbIoItk=;
        b=rfXTLgSBzg4wJCv4BAuaSbpAPmtv5Z4woQqGGpjJpLYUYu7SnRpxa5Xt14b7b4fQZi
         Jw6/0cWz71uW7AV2JgorP8EdbgneRQPFdaYheM+J4pWxAECPQDP6lnPya12oSWnhEmAw
         7vydsvhbgJWBNuufG+ek6fYs4uc6MbceA31y49i1TP89vCB4a2lfoR9bVa4SEIYQG4fd
         1QZRhlS+eqsAb55cNb0/hFLpofi6lMpSKhGh144BNKahjwwORO7JfOjwVc7V5TkMk6Sr
         m2rHcLJpe3KSIjkg/qgtTiigyMsCYcosEzAOgfaEgpFGOqiQ9nYcedq0pLkZY3z3XXrQ
         IfhQ==
X-Gm-Message-State: AOJu0Yy8M/ocUxNPXNZLutDW9NHEBM6/3pgsYlRggConGc0rFajOA70n
	OGY99gh0qGYgxSl2/kyWhoK7IW3BRWnthTnM3AA+STyT7Gm4NKVyKKDj
X-Gm-Gg: AR+sD10tqNmaO6PEuAOlM8oZZyGkZIyHTPOE1BQtwwzxziZCDBhtyQCrsQCwrIX/Zib
	d7Nkm5EP3iZ46XydLsVI+QS2SO0Fc7+KwJDJfzRua1mH/QynAreVUMmLXknM/lo5Hoo79AZnHAN
	MLhjMrWu1M0877FcA0jsdn12TIlfKkmgbW1QSsFDf4zrUNRikBx/U0RKyyAGDWWM0+6/MsO/INR
	nm8IQJeb1FYQb7mItwDO/+4pRy4hQYOO22uS+pLiJgzTyduWb5bWD6+pp9BKPocCsVWcP0XCxg7
	xMXF5CGefz4SCcZh4xnchmgoe7myrycRCYKAnOK1DpuEA6pJAKWSWUYukM9HnxvjFPi+uHthkP2
	IOt5rebeFOnq0tLjgF69OB2Hm2pQZTkpFSyWVw5RYk6dNxOPxnmf4QOY0YJnndK2QMo9Ra+UIas
	4//TysIT/azFDR0NopSGEnIx/PA5C9esJPF7YQcXBoGSmaakgluFbIGV757SM2RCFhKQwbXnVGM
	Et3QCM/HOTn39UbyrKIewXXZrVhXYvkK6MzUsOfU2B7HI/S2GEdQ1YMiLo10WbJkIwuQdpVmou0
	Onv1vOV9byPoITDiRncVlTYvbtAtAQdCm8Kk10eKO2V89jvbEX/ShmDc+hump1RiKhWv9+eYNF0
	IEEYud58pZwhDvD5+q4CI0BtuBFR1u4U1/rJRvw==
X-Received: by 2002:a05:6830:8389:b0:7e9:e709:44f6 with SMTP id 46e09a7af769-7f196ea3b40mr13694676a34.12.1785734125552;
        Sun, 02 Aug 2026 22:15:25 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:14 -0600
Subject: [PATCH 04/21] net: mdio: factor out OF child registration helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-4-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Live OF reconfiguration needs to create the same PHY and generic MDIO
devices as initial bus population, including legacy PHY nodes that need
address scanning.

Factor fixed-address child registration and PHY address scanning into
helpers. The old scan loop also visited every free address for a child
without a reg property even when the child was not a PHY. Reject that case
before scanning while preserving enumeration of valid PHY and generic MDIO
children.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 66 ++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b8d298c04d3f..051e449bbe7c 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -77,6 +77,15 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 	return 0;
 }
 
+static int of_mdiobus_register_child(struct mii_bus *mdio,
+				     struct device_node *child, u32 addr)
+{
+	if (of_mdiobus_child_is_phy(child))
+		return of_mdiobus_register_phy(mdio, child, addr);
+
+	return of_mdiobus_register_device(mdio, child, addr);
+}
+
 /* The following is a list of PHY compatible strings which appear in
  * some DTBs. The compatible string is never matched against a PHY
  * driver, so is pointless. We only expect devices which are not PHYs
@@ -136,6 +145,32 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static int of_mdiobus_scan_phy(struct mii_bus *mdio,
+			       struct device_node *child)
+{
+	int addr, rc;
+
+	if (!of_mdiobus_child_is_phy(child))
+		return -ENODEV;
+
+	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+		if (mdiobus_is_registered_device(mdio, addr))
+			continue;
+
+		dev_info(&mdio->dev, "scan phy %pOFn at address %i\n",
+			 child, addr);
+
+		/* -ENODEV means that scanning should continue. */
+		rc = of_mdiobus_register_child(mdio, child, addr);
+		if (!rc)
+			return 0;
+		if (rc != -ENODEV)
+			return rc;
+	}
+
+	return -ENODEV;
+}
+
 static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
 				   bool *scanphys)
 {
@@ -164,10 +199,7 @@ static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
 			continue;
 		}
 
-		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
-		else
-			rc = of_mdiobus_register_device(mdio, child, addr);
+		rc = of_mdiobus_register_child(mdio, child, addr);
 
 		if (rc == -ENODEV)
 			dev_err(&mdio->dev,
@@ -197,7 +229,7 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 {
 	struct device_node *child;
 	bool scanphys = false;
-	int addr, rc;
+	int rc;
 
 	if (!np)
 		return __mdiobus_register(mdio, owner);
@@ -238,27 +270,9 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		    of_node_name_eq(child, "ethernet-phy-package"))
 			continue;
 
-		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-			/* skip already registered PHYs */
-			if (mdiobus_is_registered_device(mdio, addr))
-				continue;
-
-			/* be noisy to encourage people to set reg property */
-			dev_info(&mdio->dev, "scan phy %pOFn at address %i\n",
-				 child, addr);
-
-			if (of_mdiobus_child_is_phy(child)) {
-				/* -ENODEV is the return code that PHYLIB has
-				 * standardized on to indicate that bus
-				 * scanning should continue.
-				 */
-				rc = of_mdiobus_register_phy(mdio, child, addr);
-				if (!rc)
-					break;
-				if (rc != -ENODEV)
-					goto put_unregister;
-			}
-		}
+		rc = of_mdiobus_scan_phy(mdio, child);
+		if (rc && rc != -ENODEV)
+			goto put_unregister;
 	}
 
 	return 0;

-- 
2.53.0

