Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594334825B4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933542; cv=none; b=OTC0T5Jkbe8JPzFTklhodl/oIsp3L98AiBPBl4/LVUvveO2xigZco/ctg4ILnovI/MOqO/gfmZwTTJ9Yz006uTM3R/NR434YCQVTc+UwQYhbbralWUUQUdFchZDTdS+a5WVHaBQbnxAKRPeio5bK2fHfXYTQU06WRfvyjNTUsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933542; c=relaxed/simple;
	bh=lPaUeF7IJpjaq75aykVKQZ2IAKhTtUHjZTkLNARPGUo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JZoM1Es3naJPiB445SxD7Tv91gaMa0AYiBkYl1+mkkFa6bmZjyiujT9vubOs4jIw10vsWBG/No6u/tvjXMRG5EF4aQJlcd5jpYbe52KzXgOn7MbzFL6e6TcGb1kCX0bFpGsgdnllRLiS7VEQp+uilcpixH6mYkZNJg4BzLzEhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKkpq16n; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKkpq16n"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f1dso1516028fac.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933539; x=1790538339; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F5XD7E1guV/vtraPrPS4BySY9EoY0nGlYAqlZQZKu0s=;
        b=HKkpq16nrPRBi8fW9/7ViGipTKFnIVpnZlbcIA7ZSvift7AHYRcY5nv/LXfFcZ2xzG
         t+lwoprK4ORt2sK9uAxTCWcfsE1G1SqNBy2FGq4PJdsDN3kdC90TjaFEmYCQtoWIIX5i
         mdIDOrtGLfzAJ6oGOUpYDKcWYxabMA49jIQtPBiC20jwVoZPohQMDtEFB3pjJqUEKeHf
         NtP4Eu0NyFPgT+fdiPcTggYRa1L44faa2i+bSgKhk+lC5hziT2diXDOp0qbWfL/AZjY+
         8t6DYFkLGhUIBiA3cHna1FWaopLS2HUw5OByYzydfTrCh0M2/WtKc09Rl2e1EsDno/e+
         BFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933539; x=1790538339;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F5XD7E1guV/vtraPrPS4BySY9EoY0nGlYAqlZQZKu0s=;
        b=Zilhlx1VAVwH697TDLQP397u5pzrS2Gji7lhMYHRvwc/GUZoT69yNHdOgs+GLUO59N
         4bJLBgUZ0txQz6e73/ZqbabCTsBfkI5YquykU7fhOMU1vEzTWcDYONU1GuTUKjZC/iPd
         vOUXsHjag6P+NzYOZqBZPs9Jza/4okk3t9boWdj0BI0yRdCX+kAiy9Xq3fK0hoTTxSjX
         QGr/xJjd+P4pr5ejyjGcADBdFjaUPL7DV5JXO74amIno2Nk+uEMGiydKg9ufDRvpzFEX
         kUdOZdYabAsB0f1MF4f5P+JeCLB4g1flYcwWKUOo+xW8nEOyMjkWg7jb+XPnJPR7YGvh
         gzdw==
X-Forwarded-Encrypted: i=1; AKwUvBysp3wdszyM+91Az9/IIy5q3U9B9OE9tEgPExaqT3MW2+LyXxLdmnp0i8H3ppH4j7NJgOaViG4=@vger.kernel.org
X-Gm-Message-State: AFuF++lnUbcsI6Dn0emmgtJ68NiCHg9RBzSpd+a6eGHaZONrduFXUBIq
	VCdNvhjFhDkYfF7QQoZXrQSZjaBeNjbH++Qr28SkuM9GAjaZeD101Nxj
X-Gm-Gg: AYBFou1qyfXDrKlOE8/jXhF6aBpaqGWlCQXeFu4VgqAZ8LqqelhFjPRHy2VuSNi4g/t
	Hx5qEGNoxEADC59vfqrHSIUQPIeJ+aOD5mBKAw29DeuHKxD/mqN8iX86mFcCJet9qRSIHa76DYq
	5I8vppbiYzSiNHo4HcKRlTKsTwkH/JXOwNDIkyk+eAhS9HlUBURYwHRgom+4omOva3J/ZQDCQmN
	DBlXecT8fHymlL9NXUNd6+U1Gv4U0Aa3QSNDlPcWrk+FwTtfCDg2d56VVh+QBqD/EajNL+Dz7VT
	X910xY0NyLCPbTYXJZzZVVmbPVoM8aHjJZmr9UUAO3X6gDUCgB0IpZO6tgoO9nV5cs+8TxaZVu7
	xucarSXGuXB5CKTZiPSIqyYpF9AFeVhIU5ta3iyWhxxRF1grTmy/+egYCzjVfvwp+o1mv0m/Sgp
	x92E1jL422hl6u5XAtkYX8CAnffI1PS+On1Xrs3+mTBw6nAoGOYHW4ezAjuX8kf4Q6RTcuKLLoB
	5gNRyiLpHtYnsuTBtqscKFxEwm+3nDsRs70FHiCwDGxp54kRj8IoAr7uzl/ehKkmOaCvNj0SxXG
	VbwyBDSr/kJmFQtGIZt1IGCqZ+cGbGPSgF0fC2eBJ51AOufF86Iq83NrKgrGmLQmaUlTigvgCcu
	2CM4aJvy2UIF6W6jCW81bUw==
X-Received: by 2002:a05:6870:c04:b0:47b:d505:86e8 with SMTP id 586e51a60fabf-486dd636e17mr7766380fac.7.1789933539109;
        Sun, 20 Sep 2026 12:45:39 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v4 0/6] net: stmmac: add Allwinner H616 EMAC1
 support
Date: Sun, 20 Sep 2026 13:45:26 -0600
Message-Id: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwQrCMAwG4FeRnq00aa2bJ99DPDQ1uorbZK1Dk
 b27dXoQURByCUm+PzcRuQscxXJyEx33IYa2yY2ZToSvXLNnGba5F6jQqhKMjGeqQ5KVBSu5dh5
 kDxKMXihdGHREIp+eOt6Fy8iuRcNJNnxJYvOcZOHAPj3Ux24VYmq76/hBD+PFK2z+PSyXklDOt
 6yIYFe41b524TjzbT1G9PgPghnRiKSRjWIqPxH9jix+IDojFj0VGixDSe/IMAx3ppIpa14BAAA
 =
X-Change-ID: 20260914-submit-h616-emac1-v1-143703842abb
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a separate
system-control clock register at offset 0x34. Add its binding and a
sun8i stmmac variant using that register. A distinct compatible without
an older fallback prevents the driver from using EMAC0's clock register.

EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and has
no external PHY pins. Leave PHY initialization to the PHY driver instead
of using the H3 internal-PHY controls. The RMII-only variant does not
expose the RGMII clock-delay properties.

First fix failed MTU-change reopening and hardware-resume cleanup in the
stmmac core so the interface is closed without repeating NAPI shutdown
or resource teardown. Allow phylink to stop a suspended instance without
restarting its link. Then move the MAC software reset from probe to the
DMA reset callback, after PHY initialization. This lets the MAC and its
MDIO bus remain registered when the PHY driver or one of its suppliers
is not ready yet. Clear DMA and interrupt state even if the reset times
out. Keep the separate H3 MDIO-mux reset sequence unchanged.

The AC200/AC300 EPHY driver and package bindings are already in
net-next. This series separates the H616 EMAC1 MAC driver and binding
support from the earlier combined series. PWM, MFD and device-tree
enablement are being handled separately.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Add a prerequisite stmmac core fix closing the interface after a failed
  MTU-change reopen without repeating DMA, IRQ or NAPI teardown.
- Close the interface after failed hardware resume, and let phylink
  finish shutdown directly from its suspended state.
- Retain DMA and interrupt-register clearing when the sun8i MAC reset
  times out, and return the original reset error.
- Link to v3: https://patch.msgid.link/20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com

Changes in v3:
- Add a prerequisite fix moving the MAC software reset to the DMA reset
  callback, after PHY initialization, so delayed module loading and
  deferred PHY probes do not tear down the MAC and its MDIO bus.
- Preserve the H3 MDIO-mux reset and propagate hardware-reset failures
  through the normal stmmac hardware-setup error path.
- Add Alastair D'Silva to Cc and rebase onto current net-next.
- Link to v2: https://patch.msgid.link/20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com

Changes in v2:
- Drop EMAC1 TX/RX clock-delay property support and keep the existing
  RGMII-only delay descriptions unchanged, as requested by Maxime Ripard.
- Clarify that EMAC1 connects internally to a co-packaged PHY, not an
  external PHY or the H3-style internal-PHY controls.
- Rebase onto current net-next.
- Link to v1: https://patch.msgid.link/20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com

To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Russell King <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>
To: Jose Abreu <joabreu@synopsys.com>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org

---
James Hilliard (6):
      net: phylink: allow stopping a suspended instance
      net: stmmac: close the interface after a failed MTU reopen
      net: stmmac: close the interface after failed hardware resume
      net: stmmac: sun8i: reset the MAC after PHY initialization
      dt-bindings: net: allwinner: add H616 EMAC1
      net: stmmac: sun8i: add support for Allwinner H616 EMAC1

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 13 ++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 69 +++++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 30 +++++++---
 drivers/net/phy/phylink.c                          | 16 +++++
 6 files changed, 98 insertions(+), 34 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260914-submit-h616-emac1-v1-143703842abb

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

