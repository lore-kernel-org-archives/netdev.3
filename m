Received: from mail-oa2-f17.google.com (mail-oa2-f17.google.com [74.125.231.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013F4F7CD7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667723; cv=none; b=WlXAhouYxgQVSTtKupirDZT6PFkxq7WqHRjOuCfxZMJW5o8hBGBPQlEFq2SGAU9cQLjSrQhp35SKmVHQ1U3R9CkT2VS4L97TGcsOS0pLJ3QFKxk58yDy5FwDxfzQfi30Z3PDPjwJRmgJPxTv2KJJKDEExhS6WKDDbwdaOTQ09hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667723; c=relaxed/simple;
	bh=V3VlQ/ggAL7FMDjaee6fyKxwwR97SAVyTjtCuxfkY6c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EqqmGJ6clrs0DJpLOyeCDM6LMRZ4j/gZRhxUuuJ5g0VDIsYMiotFPBcyXoFyrPGKyVxGqo8Akm5T1JMa+Jjk6AXxzwQ2HCVSKoZ9HyRy+AZnWHqpp0pwSgdpFdDXnxnnn2Ao1g3n4KNeRIeRTrJ3FJEGWhGucTLAgTov8lu0QzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnqiZVU1; arc=none smtp.client-ip=74.125.231.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnqiZVU1"
Received: by mail-oa2-f17.google.com with SMTP id 586e51a60fabf-466cc88a0d7so623343fac.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667721; x=1790272521; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rtt5XejF/bWF3GOuFvls4LbhkcGw1Hah+9I1v10tav4=;
        b=qnqiZVU1xk2ci0JununmEKYH498dXr6yEVWpzQbyXyygkr+YPeNSI34rderpBDAaQ5
         soZ2FITYXg9D9ENk+ijlqDQ5Je5hXT/jhmgNLlft1U8rd6TbaipRQRMNI8vEFWFL6FC6
         xQTrFVEiruWbziLrrb36yEu638j+HIopMO0hp3xe8EHIbZLziGcGnju4g2gNxpOfDi03
         wPjGBG3wiaNqfbW2UkqmjLht6FuS8xA08y9mnMLY+exkD7+jyCLLqywdqkx2kW+6I2Iu
         UNJlCo6mL3Cs+qBSiZa5buBgK6xrUYDNJy7N9eaYMEHppW9Tu/rjPI25fke4txXO72I2
         WdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667721; x=1790272521;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rtt5XejF/bWF3GOuFvls4LbhkcGw1Hah+9I1v10tav4=;
        b=yEDk+qlsYO8zmkHsdKrs495c/1eDZDncj9V2/hzjySXrKqyIu3X2Xu+38/Nb4RkeR6
         7e3JaU6PJKgHNj3GkN+rIuDEPL8yCLZoV5w7RH2/V6VRCb6dt2Fu5bd7AitVtXVczE87
         o6yipIdGgxjh+xcFn4ZuyEs+o/j/I8RuAJO+vLwASMvuk3F1+cqiP3BM/6e7BNyzaudH
         T5Np8V9yHa04yFRBnUGkxsZhoP1ijMMwUodm5EF5GB/oHozBO5Bn1x9gJkqgPDRIkieP
         Lu0TEP8njjqs1zWipgfJYcDSuDoXRpImojwHtWbi5sVocWYfHEHZl3TcEhBoHQL1G0lV
         6XzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiCaHzpFvuz+0H/OPKI8tvdi8yw0008MblV5gTY/ALiJ2DLbnZ8Bh6APprU28abRI/C7tudjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++njTMTLpOUz4z7/FeG8NCg59pq4YyT91GMt5G2pu4POdVWZ5g/1
	pqImBV+tMtw+qrHl3Zg1R74T9jA+bOq07eeF2zy9WGU15j2ptyOixc6i
X-Gm-Gg: AYBFou3BVCPkbvwTuSu9kfPkWriSzpyWyZqRo8/C6IZpxJZCMnMy5chPhuvqI11xRW9
	Q/93GEQwa4ZhnyVGfPbaRkabh9glwk/w0narGCqBIqZgNww8fS+Zr194Ibu3UeCOJvOTiJWW5Fg
	04cHqprsiCQGSIV1BJkCLdmIOCaoE8YQixveL17dw2m64fgofYEKa/J3eIB/6SOCkTC6Njyj77Q
	Xb3NMnq27y8RVZKKZZ7ZmcTNQ8V2iw1vmM4QzN+mgFSXeywhYXaxQj2DZ8wZJE9MchtmOhmy6/e
	ZR8TbbrFAswvip3ogSROUoW3rD8I8GQVSzwmif/QDqFNWc9sxn8pIF79J+v4xW2Uw5KJmGeeoz3
	T8Zpgi2Nx5uzHrGtdZ0LzzMsHEimYulyuce//5b3EATVjlrOuHquUN7E4XGIJ3oXh+Vcm0IsiZK
	Y5oRDJPgFh8B4YljXfaLWiRy5otqOC76e/bq+74/4fDPAuKNG2W8FP/r6+V1rQHu7yYfY9QSPXC
	WMqN1+BpZidyjr2x6DIKs0HSOMjUYJxifiNb3/T1u2yh6OVYmw5XsyBjeLy2N3dOWaqwADQCFpd
	ZI6jkRm/+PCEH2WY1PKkLLbxN5mEiR07rIDzWOCHvZxxjPwiWzjD1q2G8JT2Eymdkm2Es0Oa+KD
	TtRx5+o/ZZewxF4iBbURj
X-Received: by 2002:a05:6870:41d2:b0:475:a1ec:9613 with SMTP id 586e51a60fabf-48476c61b11mr7860909fac.21.1789667720572;
        Thu, 17 Sep 2026 10:55:20 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-486ab6c1f31sm578446fac.10.2026.09.17.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:55:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v3 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
Date: Thu, 17 Sep 2026 11:55:11 -0600
Message-Id: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oyw6CMBBFf4V0bU1fILjyP4yLtgxQI8W0tcEQ/
 t1SXbhwYTKbm5l7zizIgzPg0bFYkINovJlsCnxXID1I2wM2bcqIEVaRhgrsH2o0AQ8VrTCMUlM
 cKaaCHwivBZNKoVS9O+jMnLFnZCFgC3NAl/cmEa6gw0bdbgfjw+Se+YNIc+MjK3/L0hBMm7IFo
 hTtannqR2luez2NWRHZPxCWIJwxxRkIAqr5hqzr+gK92Q3iGQEAAA==
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
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
Keep the separate H3 MDIO-mux reset sequence unchanged.

The AC200/AC300 EPHY driver and package bindings are already in
net-next. This series separates the H616 EMAC1 MAC driver and binding
support from the earlier combined series. PWM, MFD and device-tree
enablement are being handled separately.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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

---
James Hilliard (3):
      net: stmmac: sun8i: reset the MAC after PHY initialization
      dt-bindings: net: allwinner: add H616 EMAC1
      net: stmmac: sun8i: add support for Allwinner H616 EMAC1

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 13 +++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 66 +++++++++++++---------
 3 files changed, 55 insertions(+), 26 deletions(-)
---
base-commit: 26ee8cd69d46a14b37ba5e512084fe80d730127a
change-id: 20260914-submit-h616-emac1-v1-143703842abb

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

