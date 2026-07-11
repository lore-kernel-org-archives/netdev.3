Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA529392C4B
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770077; cv=none; b=WdiN1NL/PZtrbjN3uqYJ5/l9QqWQ1YClMt7oaacHCaEVoUa19rP7iUgOVawjmTkz/f3iJ0yVa2IkN9zmvo7XPtlxFT1HwUlCJoCsdIyM/01fFgyOXTaHIBYI4M+e/pG6ieDICVpZ5eq25V9PGvtu81QcII286vw6fCCH7p6XtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770077; c=relaxed/simple;
	bh=ps7Y8E1rqhqXka4OPhnxSUyrSRb7cOLI+m5xwLf14hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ca9BYWTyVqo/V8OFpPgR7i2MHjWLG+IOekF4KCoAOM31+veoxMg7mnb0TZYq4JzQC76XrPqxT2eEJ2L9QRp7mdkoBiMAzgGeitHhS0iSVcCJEc5hrUw9Hp43C1WwNc4DexzIrzMPAOpjRJ7ZmZ9u5e8gl0PyKYLxJI0SZjTzems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX4KHHFD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX4KHHFD"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811f512167so2256664a91.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783770075; x=1784374875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLQoqPPcfbSVabfiloqaQboxTOY5hjDi7McFC+NKIs8=;
        b=XX4KHHFDcFCXqgsR24L3YPmr0Yfcw7bxmS9PrxX718TzsUZJXZ1s8p50twEJiKSOGx
         rYBCa3e0N+GDVZ7WadyVKO4Wz5KmEMjhAcVur8pys3/JNF5jXwhoIq8/6iCCHApLCDgz
         wmwU4+3j0H/T29j696HL7znNau+lG3FViKyU1y9lEUijYvslgxMUx7kaELZ/Xdux/Lkz
         ifxtvCFMXwYCb2vxv3nzypbL9X47237p6GaGcILYifPr2J2ciGAzS/Rt42kT4uwBltoZ
         oe+W3u0HPKqNNKDR3D6ecMDOwt4wWV3qhCr6vgVrtsdMzxuLFW9jrQCXEemE+hUuyiJ4
         5ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770075; x=1784374875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLQoqPPcfbSVabfiloqaQboxTOY5hjDi7McFC+NKIs8=;
        b=LIjfbrqld5UpX8IHlXM/1R+a4fmlFrT4dm7EIW6CzP5IoOF8CStIqaZGj51wGF2vdq
         S5x9VPAuPBFVf6G81bP60hoIpYsEZ1fEPhIxf3kmaEAgyYOaXtZA7dlmXabDp4Wx5QZ8
         EZSRQl10B5hqAYBxFDh5hmCDeiq5KCOTt6Is+m2yzvvNUHrT0AKNo4Ebo4StFj+wY6zN
         OI4iTwC9Djt4mHzPJC8GgpItBkH3MnXNPfTJT5DgAToUcrnKzGAJIrxPVKGzyheRW4Cj
         FmcfdODkPQva8V3Ki1RMSB5hS9ZN9FEggqmelC+UtUByDabUVZt9u0T72uVpB+9S3iIs
         /4LA==
X-Gm-Message-State: AOJu0Yx8rF95u4GprBX62/U9128jYDdiMyzKT7TxlY/2FficI7Zh0fBK
	oUlHs8jEQmyKaHxjlKUrT6qBeyd9EpZx2yntciqT7efJBOhb+6rvZI0CSITErt1y
X-Gm-Gg: AfdE7ckSOcNdKcbRLLfFg3rG93e6/Yyl51CjkkXMe78d9FjrTqz1s8IQHoqrdSOmlQX
	dSlCUT3jEXj1MB1wJQbSBLcj7qIyLUDjQ5DT1jXWYil976FbKH3uRJjo5nFUgUCUIwY4AO1i6H5
	10M69pBxd4JfjQ6PyHi8IHdFqmaCxwDIddinvP5hCN213CEQkoVryx+4s6oswlkGs8+fM1JObzy
	ryWnHkHWvC973202l7gxkTdkCz1KJMUj6/0vUQ6tTRtKyYI45OB+wuEO+NJyoyIyYJ9N/ZCK7Zl
	ebALpi474FqrYEA7X354HuNhdStc8x6sn3EQ6hkqSVJh34TVA+B8Lp4vdRSAOQ6XeYuGjd/bldw
	CXsUsDAvRBRq6Sh1DNRf6y6b+bagkp8Exs3JDWlO4OfAPgTskSk+kDzeLCX1MfgpPRSyK85owGr
	ujRgd0yS5H762AJoORJnpq
X-Received: by 2002:a17:90b:2241:b0:37c:6975:2e3d with SMTP id 98e67ed59e1d1-38dc73c330fmr2515609a91.8.1783770075031;
        Sat, 11 Jul 2026 04:41:15 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm32390087eec.24.2026.07.11.04.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:41:14 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net-next v2 0/2] net: dsa: mt7530: add EcoNet EN7528 built-in switch support
Date: Sat, 11 Jul 2026 15:40:59 +0400
Message-Id: <cover.1783770059.git.naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EcoNet EN7528 is a MIPS SoC whose platform support is already
upstream. It integrates an MT7530 switch, memory-mapped like the built-in
switches of the MediaTek MT7988 and Airoha EN7581/AN7583 SoCs, but with a
true MT7530 core, four Gigabit PHYs on ports 1-4 and a CPU port at a fixed
1000 Mbps full duplex link.

Patch 1 documents the compatible, patch 2 adds the driver support.

Changes in v2:
- patch 1: reword the commit message to explain what distinguishes the
  EN7528 from the other built-in switches and why it cannot fall back to
  one of their compatibles (Conor Dooley).
- patch 2: drop the setup-time EEE advertisement register writes. Instead
  leave lpi_capabilities empty for the EN7528, so phylink disables EEE on
  its PHYs via phy_disable_eee() and rejects enabling it from userspace
  (Andrew Lunn).
- Link to v1:
  https://lore.kernel.org/netdev/cover.1783680864.git.naseefkm@gmail.com/

Ahmed Naseef (2):
  dt-bindings: net: dsa: mediatek,mt7530: add econet,en7528-switch
  net: dsa: mt7530: add EN7528 support

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  5 ++
 drivers/net/dsa/mt7530-mmio.c                 |  1 +
 drivers/net/dsa/mt7530.c                      | 58 ++++++++++++++++---
 drivers/net/dsa/mt7530.h                      |  1 +
 4 files changed, 57 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  68e85666b6df ! 1:  2133035bb22e dt-bindings: net: dsa: mediatek,mt7530: add econet,en7528-switch
    @@ Commit message
         are connected to integrated Gigabit PHYs and its CPU port is connected
         internally to the SoC Ethernet MAC.
     
    +    Those three switches are MT7531-based, whereas the EN7528 has a genuine
    +    MT7530 switch core (its chip revision register reads 0x7530). The two
    +    generations differ in their register programming - for example the CPU
    +    port is selected through the MT7530-style MFC register rather than the
    +    MT7531 CFC register - so the EN7528 is not compatible with the existing
    +    switch compatibles and cannot fall back to one of them.
    +
         Add the econet,en7528-switch compatible, with the same constraints as
         the other built-in switches.
     
2:  1865eaedef97 ! 2:  8c7dfabd860a net: dsa: mt7530: add EN7528 support
    @@ Commit message
         an ID_EN7528 variant bound with the "econet,en7528-switch" compatible,
         reusing mt7988_setup() and the indirect PHY accessors.
     
    -    The switch core, however, is an MT7530 and not an MT7531 derivative: it
    -    has no MT7531 CFC register, and the CPU port to trap frames to is set
    -    through the MT7530-style CPU_EN / CPU_PORT fields of the MFC register, so
    -    add it to the MT7530 handling in mt753x_conduit_state_change(). For the
    +    The switch core, however, is an MT7530 and not an MT7531 derivative: the
    +    CPU port to trap frames to is set through the MT7530-style CPU_EN /
    +    CPU_PORT fields of the MFC register rather than the MT7531 CFC register,
    +    so add it to the MT7530 handling in mt753x_conduit_state_change(). For the
         same reason the MT7530 mirror and force-mode register layouts already
         apply to it as the default of the MT753X_*() macros.
     
    @@ Commit message
         EN7581 switches, whose CPU ports run at 10 Gbps.
     
         The LAN GPHYs advertise EEE by default, but negotiating EEE with some
    -    link partners results in an unstable link with dropped frames. Disable
    -    EEE advertisement on them at setup time, like mt7531_setup() does for the
    -    MT7531 switch PHYs.
    +    link partners results in an unstable link with dropped frames. Leave the
    +    LPI capabilities empty for the EN7528 so that phylink disables EEE on
    +    these PHYs and refuses to enable it from userspace.
     
         Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
     
    @@ drivers/net/dsa/mt7530.c: static void en7581_mac_port_get_caps(struct dsa_switch
      static void
      mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
      		  phy_interface_t interface)
    +@@ drivers/net/dsa/mt7530.c: static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
    + 				    struct phylink_config *config)
    + {
    + 	struct mt7530_priv *priv = ds->priv;
    +-	u32 eeecr;
    + 
    + 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
    + 
    +-	config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
    +-
    +-	eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
    +-	/* tx_lpi_timer should be in microseconds. The time units for
    +-	 * LPI threshold are unspecified.
    ++	/* The EN7528 GPHYs report EEE capability, but negotiating EEE with
    ++	 * common link partners (e.g. Realtek GbE NICs) results in an unstable
    ++	 * link with dropped frames. Leave the LPI capabilities empty so that
    ++	 * phylink disables EEE on these PHYs and refuses to enable it from
    ++	 * userspace.
    + 	 */
    +-	config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
    ++	if (priv->id != ID_EN7528) {
    ++		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
    ++
    ++		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
    ++		/* tx_lpi_timer should be in microseconds. The time units for
    ++		 * LPI threshold are unspecified.
    ++		 */
    ++		config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
    ++	}
    + 
    + 	priv->info->mac_port_get_caps(ds, port, config);
    + }
     @@ drivers/net/dsa/mt7530.c: mt753x_conduit_state_change(struct dsa_switch *ds,
      	 * forwarded to the numerically smallest CPU port whose conduit
      	 * interface is up.
    @@ drivers/net/dsa/mt7530.c: mt753x_conduit_state_change(struct dsa_switch *ds,
      		return;
      
      	mask = BIT(cpu_dp->index);
    -@@ drivers/net/dsa/mt7530.c: static int mt753x_setup_tc(struct dsa_switch *ds, int port,
    - 	}
    - }
    - 
    -+/* The EN7528 LAN ports are integrated GPHYs at MDIO addresses 9..12 (switch
    -+ * ports 1..4) on the switch internal MDIO bus, reachable only through the PHY
    -+ * indirect access registers. There is no mdiodev to derive the addresses from.
    -+ */
    -+#define EN7528_GPHY_BASE		9
    -+#define EN7528_NUM_GPHYS		4
    -+
    - static int mt7988_setup(struct dsa_switch *ds)
    - {
    - 	struct mt7530_priv *priv = ds->priv;
    -+	int i;
    - 
    - 	/* Reset the switch */
    - 	reset_control_assert(priv->rstc);
    -@@ drivers/net/dsa/mt7530.c: static int mt7988_setup(struct dsa_switch *ds)
    - 	/* Reset the switch PHYs */
    - 	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
    - 
    -+	/* The EN7528 LAN GPHYs advertise EEE by default, but negotiating EEE
    -+	 * with common link partners (e.g. Realtek GbE NICs) results in an
    -+	 * unstable link with dropped frames. Disable EEE advertisement on
    -+	 * them.
    -+	 */
    -+	if (priv->id == ID_EN7528)
    -+		for (i = EN7528_GPHY_BASE;
    -+		     i < EN7528_GPHY_BASE + EN7528_NUM_GPHYS; i++)
    -+			mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN,
    -+						 MDIO_AN_EEE_ADV, 0);
    -+
    - 	return mt7531_setup_common(ds);
    - }
    - 
     @@ drivers/net/dsa/mt7530.c: const struct mt753x_info mt753x_table[] = {
      		.phy_write_c45 = mt7531_ind_c45_phy_write,
      		.mac_port_get_caps = en7581_mac_port_get_caps,

base-commit: fe3e786ef4eb6e47d2901f568a27bd920477bbe9
-- 
2.34.1

