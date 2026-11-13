Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572335;
	b=GRl/Uhxs1QSreErPWH6JG2yBGlAQJqqS0uf+5r30MGdVJ+uQQe+LXq6bnG8U93R4SS+e
	 fb2AqGL7kEcsK6VcG/IbhrcYJ2NLpt072Ti4smg5sC6FVqzFfed4NAYyl3oCqbv/wQtL7
	 gloa83omYRQo/MGwuSJCtSDPr9N224dcerfhFNbOsyUPyumWqEeynUvXyBZXlL7f+y4R0
	 tFQ1cLuNYAQNf56cE/ATwqHmkZTc51v8S7ifcl9y0trbXGfRVNLWTbG1PUWdCNS4SCjBL
	 pkrT0nt0wVIhOK6Cn8JEEdGetTzLzjqozj1vLC4KOeZ1Tf42wt9PxGV2WVUiIWTaAYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572335;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Unn0F/ftD1finXNKWi/skeaXkk+/fQXZw2324bDO7PE=;
	b=e3LLBa3sLcn6iUpWzRtcDiO1BtrPrMKNe9wyLwO9XLEgjvkzymSP5IuYXMDXUsyQLGM9
	 A5JytLparHQvv5Jy3k3/xHTC7KNbV2GVY7q5VdNL9+0PXfXtVZn8z+68VjPsEpJcaUVb8
	 HkFsByAvMdt43tCxcH90QkB3skAuJ/DDAXxfNqbzSg+WwtSn1QmU4ST19FAs84eMGJov9
	 GUQBI68p7mM8vAvumGiTNhcGB/1lTYgh5FoVmdwd+2ChfbcCeMAKmi4js/lod3uIcTwrb
	 ozmyOn9VEso9H6oAA2f6g5WwxG5ovm+POZcoB18q0LlXevW4EKTOGd4Zs4tsu1c8GsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63177606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63177606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-497614c95f0so390293f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572334; x=1795177134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Unn0F/ftD1finXNKWi/skeaXkk+/fQXZw2324bDO7PE=;
        b=NOMmOArGzfpe84zB31apzhjXbmMAtLXfi2ttkKLSZ9mbaZFeozj6zUDL15HSJZxBpr
         kQcC5P5dhmom2lj9EbYWKQFW3CtKH2UFjIStM74HCSsgMm+fI6CL4jWH7RFFS1rolvcn
         SAChZFqPT4952n69QURRgj8PF0VRoqvFAe1BIbudUBFhnRdCZ+bJC6qRERrlhwaTmen7
         ORlqIcmu+6hCBLDQo1j+jhj4SWCsjw2Q8gx+rqBHHxrvnC8GogGC/c1E53WDEUsHXMX8
         rhGGOQfTopVtoHGLW3alYKt4PDtvML8d5Wn/KNMD/k+CeyZlBzi/yLBjUeaRRqcXFB6t
         SDyg==
X-Gm-Message-State: APuU4Z8pHTHTRweGTnINLb9RvHDXI2B44htUpNdArObCOZ1RJsfHt3MQ
	nMhA2kiUBPxwlJasuvsU1tFzo1yuNTMkBUOjsD85hjRQdHBGmht9mK9V
X-Gm-Gg: AYBFou2gQZ6KZLKE0jcmJJu/HEOoe3nZcvHEnDwYuXgh9Dv3m407a6E1TbfUVBgFf3k
	/AWcU2v8qR9JB2VNGuX1aazAsfBlqcwM3ngSb1tsDxEqZShzzxNAA1DGsZN36olQzHmCrf+AYlp
	5i+VrKibN1s1wBUuZzQ3FEp4yT40NlwnAUZM7+8rEnhTBj841BpO5hTgDaS3jmtovI/rpkVpkvs
	i6T2lbdpg9NIGYqUFuLDR1CNRcFCgugB02Vo5++Tpkw+K05O5BdwuGlBiLHDUMHugwwvpyWYlYU
	Ilf+cXN9mxarXSsF7e8lmtJr53fGO+7hS4EbnogY6Iu8RSzIRc1kzkPY71yMgky6GpzEVcTJA4x
	+t+pxLLqH8oR1E1XNZD0fo6nOR6Zu1UFU4g8Nzg4XoHckPU+2LHB8o3wzXQiGtcNlOA9LVVjfaj
	j8J8iQTYzBs4IiPc+dad8BFNa0G6sUOucIc6/9LtSXPxO9bWVOz/SY//thFlQkJpd7VV6FIbtYn
	ZB+TaKF26dg4oBeDiBJqJvn73qPOSNn06mho/dD5P0ZQYdDrrDYgFTDElVRSkDVywjBPs/rlVnM
	DW9ILXcPdI922ogmpyzQbqaTAsljUgxBcOixHM40q0Po3n1tTRRTFoppUH098u9xVXBP7apVCnO
	gcbhSPFD7Ac+/WXjnwYFOMDn7
X-Received: by 2002:adf:f14b:0:b0:492:dddc:64c3 with SMTP id ffacd0b85a97d-49c742a6580mr3860898f8f.41.1794572333528;
        Fri, 13 Nov 2026 04:18:53 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:53 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] Add ethernet support for the Amlogic T7
Date: Fri, 13 Nov 2026 12:18:45 +0000
Message-ID: <20261113121852.334604-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T7 has the same ethernet glue as the G12A. This adds the binding,
the driver support and the device tree nodes, and enables the port on
the Khadas VIM4.

Two clocks are new. The pipeline stage between the controller and the
DRAM has its own gate, which nothing else claims. The glue registers
sit in a block gated by sys_ethphy, so far claimed only by the MDIO
mux, which probes after the glue is programmed: every write to
PRG_ETH0/1 was lost. The T7 node lists that clock as "pclk".

The delays follow ethernet-controller.yaml: phy-mode is never changed,
the PHY adds the 2ns, and the T7 accepts only rx-internal-delay-ps, as
fine tuning. Its TX side is a quarter-period phase selector with no
small step, so tx-internal-delay-ps is not valid for it. The VIM4 is
plain rgmii-id.

Tested on v7.4-rc2 on the Khadas VIM4: 942/940Mbit/s with iperf3, no
error.

Changes since v6:
 - no Assisted-by trailer (Krzysztof)
 - patch 2: the T7 gets a binding file of its own (Rob, Sashiko); the
   pclk description names the glue registers (Krzysztof);
   rx-internal-delay-ps as constraints, default 0, maximum 3000,
   multipleOf 200 (Rob); tx-internal-delay-ps stays false, the
   meta-schema refuses "not" on a top-level property, so the reason is
   a comment above it (Rob); "snps,dwmac" dropped from the compatible
   list (Rob)
 - patch 6: "snps,dwmac" dropped from the node (Rob)
 - patch 4: Andrew's Reviewed-by

Changes since v5:
 - patch 2: the T7 block follows the Meson8b..G12A block instead of
   splitting it in two; default: 0 for rx-internal-delay-ps on the T7
   (Sashiko). The explicit false lines stay, as asked in review.

Changes since v4:
 - patch 4: the old delay code is left untouched; the T7 only gets a
   callback of its own, and the probe parsing it shares validates the
   RX value (Andrew); no NULL check on the callback (Martin)
 - 0 accepted for rx-internal-delay-ps, the T7 joins the G12A list
   (Andrew)
 - comment on the deprecated vendor delay properties (Andrew)
 - the MDIO mux and the on-chip PHY bus start disabled in the dtsi; the
   VIM4 enables the mux (Sashiko)

Changes since v3:
 - phy-mode untouched, the PHY adds the 2ns, rx-internal-delay-ps is
   tuning only, tx-internal-delay-ps not valid for the T7 (Andrew)
 - 0 dropped from rx-internal-delay-ps (Martin); vendor delay
   properties explicitly false for the T7 (Andrew)
 - init_delays callback; patch 4 renamed (Martin, Andrew)
 - VIM4 without tx-internal-delay-ps, the PHY TX delay works (Martin)
 - Meson8m2 moved to the dwmac-3.70a list; its boards warn in
   dtbs_check until Martin's dtsi patch lands (Martin, Conor)
 - the delay table in ethernet-controller.yaml dropped
 - Martin's Reviewed-by on patch 3

Changes since v2:
 - T7-only delay path (Andrew), PHY mode from
   phy_fix_phy_mode_for_mac_delays() (Maxime)
 - tx-internal-delay-ps checked against the hardware values (Sashiko)
 - vendor delay properties not valid for the T7 (Neil, Andrew)
 - no max-speed on either PHY (Andrew); VIM4 PHY interrupt on GPIOH_6
   (Sashiko)
 - the T7 node owns sys_ethphy as "pclk"
 - no longer RFC; Conor's Ack dropped from patch 2 and Neil's R-b from
   patch 6

Changes since v1:
 - the driver honours the generic delay properties; VIM4 moved to
   rgmii-id with tx-internal-delay-ps = <2000>, Neil's R-b dropped

Lucas Tanure (7):
  dt-bindings: net: amlogic,meson-dwmac: list the compatible
    combinations
  dt-bindings: net: add amlogic,t7-dwmac
  net: stmmac: dwmac-meson8b: add support for the Amlogic T7
  net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on
    the T7
  arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
  arm64: dts: amlogic: t7: add the ethernet controller
  arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port

 .../bindings/net/amlogic,meson-dwmac.yaml     |  29 +++--
 .../bindings/net/amlogic,t7-dwmac.yaml        | 112 ++++++++++++++++++
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  23 ++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   |  88 ++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   |  61 +++++++++-
 5 files changed, 297 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/amlogic,t7-dwmac.yaml


base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

