Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873007;
	b=kwhQMRltsX++Z7zAtz2i/vy/pOWdooH2R1AKyprXNgA6pWW2GrGjNPacXw5vAMSu89D3
	 7CGx0t8bjUGR8jvTSra5OhUyE+6FCKjllNdtQAklxuU6WLmqGO8R2dCP9S+J2yKCSYla8
	 kN637gN/XnXY2vY56zvqaNXzqe9F4YgdUx1wmZV0GLNHT8laILEVvHkLVepDsHOACOxgO
	 ezE0CzDM7G/l+mDCsaN/tw7XwQpFXfMnq9gI04VnuWKEa1scKXqM34EKw6B0dHJoRlRgi
	 A6Qu3y4uy6AvoLR7hoYwvgSkq6K3tftComZENHwssjoRVR/MC5e0dwpSZOP99UAz53g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873007;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=R6cyamQMSGS+vKmEK5CyaNiN3MV88pM7I1W9QX3v1mg=;
	b=b/rlqqH7STrt9O0jWHuEJPJbJ/ct9o351f16/SvbJkcd/Q+D8EuxV1h3+6gdw9mHOIHu
	 B2kJ5Rfxx+ploeu5z+1IAV+uC7brivIuGkKqA4a3BrMn/o7TUAlBZJtXvuZewP9PuwH5f
	 TGlSLa2PYBY9KLyp0L+Td7GlO1Xn32Xenu/058vREHm5ECOD7+/jThRxIrxK6BW6K4fzC
	 3LB1U2LL9AMchbXRXLcsDdhFhkja6NgZrJgd0bBHr5/F2QyBU7jjI9aWfNJfhRXnJHARs
	 CYpavhhh1BOZgFFtz1yZM8w9TisgrrCl8Bh2f2yXCot9lZKsVQTQ38Jfp//RrVbL5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08A606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C08A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so17807325e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873005; x=1794477805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6cyamQMSGS+vKmEK5CyaNiN3MV88pM7I1W9QX3v1mg=;
        b=W1p7zc8C1rrDZyzo1Rd/Nft9s1CX9TrLKyisCE5/Uq2jIhl2syViycrhU+fYPCnuaB
         ZcSLlJXJnDjbZpehZ0wl7mSsJ/eM0LlUZhYdwh9qLqCZd6xHptIxlCIEZyKFcaN1qsUu
         1tiqyvZyn6Wecem7PdGcu/uoF0TRFYAmCWuLk6bMIX5XeNYfPZB9X+BCzKP3aZdBjTls
         x2BTwIqeMnBg5Mi+xg/qKe8Lh64COZ1GiEyUFTm9UG+NT62tj0ELx1laRUYzi8ZjTAGH
         HL/q71SZ4omRsmNJT9XbhgWGKLVIkbgBn0qgbn4LxIYrm09EZkxJhBl3EevVRj/3tsmv
         diJA==
X-Gm-Message-State: APuU4Z8rsRihcMexmm7+Ujif2Po7S18FbMz8biSY9walKHZlCHpMVZtC
	wV7m331oqdDXr2C2Cv/+WEQ5hirSdxtOM9r8G78c6b7ge3qCXbHuEN/A
X-Gm-Gg: AYBFou20YLW9sKe3KGB4jN3UvfugYfV4ivP2slLorbo4g/JDV+GU4ErRt8kqHTpiP5w
	jQnRs867XEEK4MPdsypWGtzyAdGyP1Dyoyh1wu9+Loy16to1iS69Gz02YyWwNIXvOWC9NBCsYTp
	+UAY3EFQJGsP2gAkjxrds0D5PxQUG4MtOTAedvQt4RDZsNFNKU6eudnh3Jlx0n9Daw21ye8hoPx
	QyfRTeoHUI1lMjLU3bRIWY3zA7gT5qPYhSaR4CilJAM2S54ptoQM8nvx52ijZJm+eC42aTsAh4M
	4Ls3yE149Px8yKvnEDrOHMfvOIjrZI3OJIgS7emXI77txGq5zvFPPPlNxjo7JmBqMvL6uJwJzhX
	Ux4EauTjOKwGJGj6EBe/5YXjwPQysRzE2q2hEhkzS5TEmuYW/DmLbX7wqjUQt1WIK555XlLWIEj
	ZMqNQx6LxPCIEyHoGygETcN4Rx0cfFLBhnKFXx24XUBCNpg1QekMFGeYbIuOXIOLbnsGTvfRsAl
	jDwC2U8Ze+Z7zLreTRJIgDtYcMT3NmhaaGG74kCAbOTMsH6Pmw//k7lfHuuOz3s9izJpI0Z6VwK
	Bm9eMjBzvwmKs5iH087gNn2RGsbyGDN6uh59XoW0fyYOA6jOHFsUA3r2IuHXhp1dDW05oiOdR05
	eut7dX0mvo44SItlZJ1X81Bm2Uw==
X-Received: by 2002:a05:600c:e547:10b0:4ad:5e09:ae43 with SMTP id 5b1f17b1804b1-4ad5e09ae61mr211533235e9.29.1793873004567;
        Thu, 05 Nov 2026 02:03:24 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:23 -0800 (PST)
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
Subject: [PATCH v6 0/7] Add ethernet support for the Amlogic T7
Date: Thu,  5 Nov 2026 10:03:15 +0000
Message-ID: <20261105100322.37816-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
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

Tested on v7.4-rc1 on the Khadas VIM4: 940/941Mbit/s with iperf3, no
CRC error.

Overlaps with Xianwei Zhao's "[PATCH v2 0/3] t7: add some nodes for
Amlogc t7."; I will drop or rebase whatever overlaps once we agree.

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
  dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
  net: stmmac: dwmac-meson8b: add support for the Amlogic T7
  net: stmmac: dwmac-meson8b: follow the generic RGMII delay rules on
    the T7
  arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
  arm64: dts: amlogic: t7: add the ethernet controller
  arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port

 .../bindings/net/amlogic,meson-dwmac.yaml     | 78 ++++++++++++----
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 23 +++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 90 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 61 ++++++++++++-
 4 files changed, 236 insertions(+), 16 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

