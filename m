Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950623AE6EE
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865422; cv=none; b=cODqdRkXvyztudrQw0aHSn+YQLQsPGusFF1jfci6IH+ecK/SVKnVnmw+r8KfAl2FfZgd/jfFt9tNGvHVpHQcpIpDeQ/mAbrBA/VYbLMd6wY3hfkQtln44wvap6qpR+Cpid7Wicc5bCJkLkk/JBKmpeOxmrm1JjvRscGpsaB986A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865422; c=relaxed/simple;
	bh=Ju5/GtZUNmq9EkakiqzNl6VV/VQHeho4RgezUb60ctw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP2A9s6zD2YEEjei5QwO3nft+yHJHArfq3mQEHskUBPTU3spa0ZcR9Lzy/79eyrTzPoSNqtv+EEbK5NgRLEIAF0JTEoZGn57kPBYtrgFMJCrXYZobfd2zPnrGGH/4BwqToDzXug58IG2swyJw7HApR8at5YK7hQsP9UVfZL7h6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BdD7UYXR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BdD7UYXR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e5733a5aso183146f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787865419; x=1788470219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tz5ILNw9DexVi+q49WPazou/vKYmLq2Kzp04C8PpRoI=;
        b=BdD7UYXRO+O2r5OrsmhZWlGpBZJRrplPzZBE8XWg7g5rWDLxOadVpa5lmxWf5pKjPA
         EX9KYDlmUAkKXXED0ApzL+ONYWMh2gBK+x8f9dO0kO0/oKcoM4Yd/MUracjSTIllTCni
         BARK1fZGmnHEAoTCpVAirrY5alEcUvJZosflEWjOqYYprqWjb2+C1kkB26ey0BsJKsHu
         Qjc9xQ7SeCbfYFzHEowXTGdbnNAxzP4IfUBXPHt2lOQzhXIMGygR3E+QNMHhxDPuP4ki
         rOv0Xi4Q276b5vQo7MPraIHde9bfaIbbjJhwIgOA+ZY87FLITpNH1IjEbOZrkxsYS/lm
         sdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787865419; x=1788470219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tz5ILNw9DexVi+q49WPazou/vKYmLq2Kzp04C8PpRoI=;
        b=XwjexXVM+1gcdlMoCHu3ekhoW2xDCX490F40cGBUKqPHY7vphy0TZ27aqd9WY2roIU
         LnLoeLTkiYTZSpF6mzTN4tqh5cOulNW0bwNqIYHd3acnh1ihbC2hD7FV6dUux7gYd9iX
         L++fVEscSjFsOKRGTbVKcjKSL2Cbdc/onLC8qcUwMEWyj0Fg2qhIqmwsLkqKe4lq8zKJ
         FH+B824zM0+FMew8lAUK/RrOwAFO6cG29CZHSNPdvRQNyq7bNDbMEOf9NwsQ3CgjJNP9
         DHlBfZ4F7YsI0JB3LZy6HEg993akPk8VRP2y5OReLBLMexn3vje02DOogLP1KumiLH9s
         HRpA==
X-Forwarded-Encrypted: i=1; AHgh+RotksCynCPKO61XN6lPfk4ThLOU3iJ/RzGSebEXxuTcTWqXcdOQ08i61/3HGXdgbygHhMAwyT0=@vger.kernel.org
X-Gm-Message-State: AFuF++kpskfdL+AeG8vXKiebibOzuitRYsriiKURggXipoHAUuaURcEK
	K0cwuLTQeabdlH00kTd8oMgwja/ZBmHruy0W2dJXW4s2zyvtx+rYz5xxRGhoHx01Nx8=
X-Gm-Gg: AR+sD12fltGYsh+UYkaCNdfo5vHIWwnNzwJfXdWbVUD/Pm88JPvSi+6Xwvz94PxlvzZ
	36evuOe/4DHp1TPWjmJW05c5lzwqszJ7v0EU0uFjiXD45noJgOoPDK4xymisNaL7u7Fa1Bf3ZEq
	ALD+jqiHxDpl9bdCYDEAiSq2ek9NKCQ7DJTXPhmHNmFte4Z6/DTEMaOZHVPrj/Z2pVQ/i+ne4BI
	Jg/jKGej2as11GXP//ws7p9f9tUFTCAd3dj3WxaDUFplzFf/jb7O/qC7BAN2oTTB5lycc7V6+3+
	7R0dChLoTh608LryvcwI3gXBvGILeTg87e33kN6dB3LeupjL/sboP2kfG6RQLXhDlweAYgQVaCU
	W7ZBoQtePIev+ZQ20ZUBAqbiS6ZVDVzmtafexgickC4fXNovUxolIB+dQwi3pL0RV3XxJsVCjda
	sXv1RJYMkAirvhGg6dogBmWkfwhzwZGohOtTZTfVdxVTyfTqRyMLdzsGs=
X-Received: by 2002:a05:6000:40ce:b0:482:e2f2:19c5 with SMTP id ffacd0b85a97d-482f79cc09fmr1611455f8f.4.1787865418791;
        Thu, 27 Aug 2026 14:16:58 -0700 (PDT)
Received: from ownbook ([31.146.92.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27aa050sm11004557f8f.12.2026.08.27.14.16.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 14:16:58 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v3 1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
Date: Fri, 28 Aug 2026 00:16:51 +0300
Message-ID: <20260827211652.63504-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827211652.63504-1-f@lex.la>
References: <20260827211652.63504-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_create() decides once and for all that a MAC supports managed
EEE, and it requires the tx_lpi ops plus non-empty lpi_capabilities and
lpi_interfaces. mt753x_phylink_get_caps() leaves lpi_interfaces empty.

So ever since the conversion to phylink managed EEE, ethtool has
answered "Not supported" on every mt753x port, and phy_disable_eee()
has locked userspace out of turning EEE on. That undoes what
commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
switch on all boards") arranged: EEE off by default, but reachable
with ethtool.

Leave the speeds above 1 Gbps out of both bitmaps. PMCR folds
SPEED_2500 and SPEED_10000 onto PMCR_FORCE_SPEED_1000, so
PMCR_FORCE_EEE1G would govern LPI on such a link, and that is
unvalidated rather than known unsupported: MediaTek's SDK driver sets
the EEE force bits for 100 Mbps and 1 Gbps only, and the unit of the
wakeup timers is undocumented with the port clock at 2.5 times the
rate.

LPI stays off until userspace enables it, but the EEE advertisement of
a PHY that advertises it out of reset comes back, since phylink stops
force-clearing it.

Fixes: 9cf21773f535 ("net: dsa: mt7530: convert to phylink managed EEE")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Ports that support neither 100 Mbps nor 1 Gbps are skipped because on
MT7988, EN7581 and AN7583 port 6 is 10 Gbps only and shares
PHY_INTERFACE_MODE_INTERNAL with the user ports, so the interface mask
alone cannot tell them apart. MT7531's internal PHYs keep the
advertisement mt7531_setup() zeroed and EN7528 keeps both bitmaps
empty, so EEE stays fully off there.

Two pre-existing things this patch makes live, neither addressed here:

- The unit of LPI_THRESH is still unspecified, as the comment above
  lpi_timer_default says. ethtool now reports 30 for a switch port
  against 1000 for the SoC MAC, which is a driver constant already in
  microseconds, and mtk_eth_soc treats a structurally identical field
  as milliseconds. Does anyone have the datasheet answer?

- mt753x_phylink_mac_enable_tx_lpi() sets the PMCR force-EEE bits
  without checking the resolved speed or interface, relying entirely on
  phylink never calling it above 1 Gbps. A check there would make the
  driver robust independently of lpi_interfaces being right.

v2, with the full argument for leaving the higher speeds out:
https://lore.kernel.org/netdev/20260824024117.46154-2-f@lex.la/
 drivers/net/dsa/mt7530.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b7be091c056..4ed6218df64b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3172,23 +3172,37 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
+	priv->info->mac_port_get_caps(ds, port, config);
+
 	/* The EN7528 GPHYs report EEE capability, but negotiating EEE with
 	 * common link partners (e.g. Realtek GbE NICs) results in an unstable
 	 * link with dropped frames. Leave the LPI capabilities empty so that
 	 * phylink disables EEE on these PHYs and refuses to enable it from
-	 * userspace.
+	 * userspace. Ports that run at neither 100 Mbps nor 1 Gbps are left
+	 * empty too, since LPI above 1 Gbps is unvalidated.
 	 */
-	if (priv->id != ID_EN7528) {
+	if (priv->id != ID_EN7528 &&
+	    config->mac_capabilities & (MAC_100FD | MAC_1000FD)) {
 		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
 
-		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
+		/* PMCR folds SPEED_2500 and SPEED_10000 onto
+		 * PMCR_FORCE_SPEED_1000, so LPI above 1 Gbps would be
+		 * governed by PMCR_FORCE_EEE1G and is unvalidated rather than
+		 * unsupported. Leave it out of both bitmaps: lpi_capabilities
+		 * gates on the media speed a rate matching PHY reports, not
+		 * on the speed the MAC runs at.
+		 */
+		config->lpi_capabilities = MAC_100FD | MAC_1000FD;
+		phy_interface_copy(config->lpi_interfaces,
+				   config->supported_interfaces);
+		__clear_bit(PHY_INTERFACE_MODE_2500BASEX,
+			    config->lpi_interfaces);
+
 		/* tx_lpi_timer should be in microseconds. The time units for
 		 * LPI threshold are unspecified.
 		 */
 		config->lpi_timer_default = FIELD_GET(LPI_THRESH_MASK, eeecr);
 	}
-
-	priv->info->mac_port_get_caps(ds, port, config);
 }
 
 static int mt753x_pcs_validate(struct phylink_pcs *pcs,
-- 
2.55.0

