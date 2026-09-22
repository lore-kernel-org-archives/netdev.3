Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF7346A0A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037929; cv=none; b=IXw18x70oO6llV4M5ju79p7x5CrbEUrrVP0JxJuV+UPFd1dabxL952vAbneHNCd6f0Ljo5EX5agg29x4hHAB67btEJK1mgSqjkbx1CW1QDQACwd38e/ipTzwSkhORMSRKNW3BfVMrbffDTcXPs3OvMiIkHsLsHd6y2m7dVd508M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037929; c=relaxed/simple;
	bh=iYob4REqadu0E5LMJQUvWHZge0MxmBjAeGhfjKnxPMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j/8VZuCky/yYdGNAEr6z6D3Jm2mTW/jZnqywTwuAjrnJcy0bafmTeo1mW7WgoMq16PLDC+oGx8X6M0Ep+9bWfXWtGTwAtN+lkn9W0S7i78CUnY8t1pyyH9BYcrrfj9RZt9kOGQvSlPddi8t0m5wBSOnwJ0bW63SjzsF5MyQxVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akwbkY+U; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akwbkY+U"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a3ed715so2226991b6e.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790037926; x=1790642726; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/OAn78xm1OSx5ilLefyLSI7VeBwJOO8ghkxmHGyO8o=;
        b=akwbkY+UzPi34DmaQGni1DtUhlX3nud4X9312ne97+KTTN3K9rxzoK24hVmId/ZMsm
         87TQQpHZ4Azb4d4TLgvCXg+yLRhMtE2Nh+/yWU7dSgx1HnFwPzi6GmTA3+f1KKASEBi/
         2XeSLt+eoGC0m8miR7g6aby85tpzrPQJt8pm/IjieEj4qvZUoD/P/VULNw+720ssbqx5
         KSDyGsxkIxqK3lqGx/tAYYAhDSpOEBzZhJvAEdj9vm8jaKne2BJ8FovapXMaWdV4dkMf
         WEkkExkcU1l7Y3aEe6GnXEAYqRtk91qEo/Pdv5n+0s1O5Rel6DquDoE0XliBEz8x33U9
         HL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037926; x=1790642726;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/OAn78xm1OSx5ilLefyLSI7VeBwJOO8ghkxmHGyO8o=;
        b=fXr364chX3Yz2Oy0Twd9QUxlg0n/gTtmtd0oO7vilmYEfz5+Y+5MEKzUprc4n4UNys
         upWFneaIULKcb0YQ6KwnBgpvczgypR/N4xr1uZMUwCdDaoEF9vN0u5P0DsaiDaNgWB9W
         YuiU0lhR7nOwLcpjQi/I8S5i75OCY589hUi8E22rMWPQS1RPfKblDXKGIseYW795pvfp
         46n5dyX26LgOJEy1DVHQUPPLLoU+6hlrl1PE8l8nnv20BU/8K6VgYF1c9Q2KJrzJL4ks
         Fugsq8GZ+38r/xNuDPhTOA8queSkoZxpNo4QQi1Q8E5Pqcl5W+teKvcw6MaLlBJIBEyU
         afag==
X-Forwarded-Encrypted: i=1; AKwUvBwkv2DdYlkXLJo95D8t6f1jo6pKkCFaCXVyuslg44Jyvn8jGMQi7tCG6QudM0thT3bMIVa9SV4=@vger.kernel.org
X-Gm-Message-State: AFuF++lt1gWsfwcc0+fIgeo+T6U9clypqfVXekciIeHIdK/A27JbCMzN
	pTjUE153BdAJ0+HngWFnXEGLdo5NXKs97AVw3XAzDtCTnRoGQBm/SMlt
X-Gm-Gg: AYBFou2rUdFdQdI67K3RWdGEIOLJV2cajp++lo7srMPg+UdC4UmvY0KlcpJfGrAXkHG
	6c2JbuW65dUhFuxkMmrRw+W3IecKbCVuNSECTimH11ID0rjJa0KpCGR+9UBV37lXsoaMfknwPZR
	33Az1QaYi174ajgvk4+WOpJnyeuHj1GeCahKi5OVQAmj4VyoCOopfdgT5ecVveg97mkICiZaa8l
	uOolwl3cTV79T91apaJdjNH6xzasM+0WL/Lvj2xVdgx7IOoiLoSiBCB4gIVOTvncGKQm85dU4XA
	0us3NWteMcWwmy+yXp6oCoeja3flzC6Z7E3KoFKAjiDuI/477r18u23QISHTlMj1t5ucsZHyEvN
	HlzXlnMXvkq1H7hWpf9iSxTHIklRK2kRo2pAlAjg2P4vdR90DV2P3RDDm6clohOuly/Kmh22jDg
	SqzrEQzbzBhbhArQ1w4Fjrc4Ko8AiPaLPclmod10b+zG8kIa4bu1zG+O1Orpm8MR2MXqkTdyOdu
	3PJcFVJRnQBa/xpxA+qxXjtaBTSz7LPkv7jNLRcRHB47aRSDfcGM96zi56O5BPCv+T/QUTsJRyh
	rA8DM3vDMVAkxTJbakgzhSk/vrp48G3dw1Dv3hxOdDi9i3QQSRd3CtZ5DUNyJSccepOIDmNVttX
	aj1Fuqh+MmDX1xu/4mxxA7g==
X-Received: by 2002:a05:6808:680a:b0:4b2:8d7b:390b with SMTP id 5614622812f47-4d464080f0dmr1026002b6e.19.1790037926314;
        Mon, 21 Sep 2026 17:45:26 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d4bb6be7b3sm60201b6e.0.2026.09.21.17.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:45:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v5 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
Date: Mon, 21 Sep 2026 18:45:23 -0600
Message-Id: <20260921-submit-h616-emac1-v1-v5-0-ada661ed9e9b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OwWrDMAwG4FcpPs/Fkh0n2WnvMXqwHKVxWZIRu
 6Gj5N3npjuEskJBFyHp+3UVkafAUbzvrmLiOcQwDrkp3nbCd244sgxN7gUqtKoGI+OZ+pBkZ8F
 K7p0HOYMEo0ulK4OOSOTT74nbcFnZTzFwkgNfkjjcJ1k4sU839bbbhZjG6Wf9YIb14i+s+D8sl
 5JQFw0rImgr93HsXfja+7FfI2Z8BcGMaETSyEYx1Y+I3iLlE0RnxKKnSoNlqOkRMRsE1RPEZKT
 SpmxaRqay2SLLsvwC4mFjqqMBAAA=
X-Change-ID: 20260914-submit-h616-emac1-v1-143703842abb
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: Alastair D'Silva <alastair@d-silva.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a separate
system-control clock register at offset 0x34. Add its binding and a
sun8i stmmac variant using that register. A distinct compatible without
an older fallback prevents the driver from using EMAC0's clock register.

EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and has
no external PHY pins. Leave PHY initialization to the PHY driver instead
of using the H3 internal-PHY controls. The RMII-only variant does not
expose the RGMII clock-delay properties.

First move the MAC software reset from probe to the DMA reset callback,
after PHY initialization. This lets the MAC and its MDIO bus remain
registered when the PHY driver or one of its suppliers is not ready yet.
Mask interrupts before requesting reset and clear DMA and interrupt state
even if it times out. Keep the separate H3 MDIO-mux reset sequence
unchanged.

The AC200/AC300 EPHY driver and package bindings are already in
net-next. This series separates the H616 EMAC1 MAC driver and binding
support from the earlier combined series. PWM, MFD and device-tree
enablement are being handled separately.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:
- Split the three generic phylink/stmmac recovery fixes into a separate
  net series, as requested by Maxime Chevallier. Keep the sun8i MAC-reset
  change, EMAC1 binding and variant in this net-next series.
- Add the originating driver's Fixes tag to the sun8i reset patch.
- Link to v4: https://patch.msgid.link/20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com

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
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>
To: Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
James Hilliard (3):
      net: stmmac: sun8i: reset the MAC after PHY initialization
      dt-bindings: net: allwinner: add H616 EMAC1
      net: stmmac: sun8i: add support for Allwinner H616 EMAC1

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 13 ++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 69 +++++++++++++---------
 3 files changed, 57 insertions(+), 27 deletions(-)
---
base-commit: 1b4efa0399f549d9b9bf82b3e2450e10a06d65b8
change-id: 20260914-submit-h616-emac1-v1-143703842abb

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

