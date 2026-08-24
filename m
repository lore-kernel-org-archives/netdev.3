Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBA374169
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539291; cv=none; b=cGgaroCZaaQi4AEzdS46By21Ve5BG1z3/yYX+SZd2yocAQEgDuupueCPRl/U2p109Y4TSZZnypHVYR/dG1SIvgGpc78ZeIcWur76kQmSCVKXhza1x2zsQARrKthDdS7mWVzn5qaDKE/RStdksNJR+SMejVTIws/NUVIUy2bLEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539291; c=relaxed/simple;
	bh=SDSa7BtdilxKJxAuJe9gwz7nnNXSQ/tSrnRfRU7KXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROEI8cbhOURoVvtrSCG3ZYTUaDDhUjU8HCDrCnVvjwE878ricXQi3rgHH1mAexTNcTtpFg/J7LVK0lwJT64MZcOkK4b9bf69YihhYu2ns5Ohf/BrtScUZMkOlBL13DT+u8MHkhIED/oskDZkrJfPlfw0Mf5zwShA0uaCcMwvvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=YD6OZT3k; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="YD6OZT3k"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so5631410a12.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539286; x=1788144086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sG09oMeCLLGrjaF3KS0dxUwY4QMRP5eQuHdTPgxNNbs=;
        b=YD6OZT3kdeNx4E3mVj7DC17PiR+Fsiv5dCDJYaqHrWVUNyiXyiyywCo0PdJuFa4Pn9
         OSgTCaLx+YV8PmPwRUaAfUpM6ETFbEY1GL4knVHn2lyzHiTOTU3Xd/U+NrAJ6P4eJ1AW
         gZXVtBmkkLvBBfIyp6ZWGc/TsbBTr/1/7BbsuJACGGSEXJ5bCCcBKdgVH6x1RFb6JA6K
         aJQ835Dg34IjMuooiHZk69IKCve78bHLmnSxZip+4bZ3oHnU7hLTkDCoys0sCZtnH5/k
         2+ID1wRAL5oIr076hbep6pZQhGiZy4N1F+NhFE0knQgaMyiZdaBMCo/38Zh/mq+m/VrM
         XzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539286; x=1788144086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sG09oMeCLLGrjaF3KS0dxUwY4QMRP5eQuHdTPgxNNbs=;
        b=fFJ2Xk044Ri5urOAPq+6P1/n3Kl1JP6AxSXf1Ly14eyXGP00R6+l1f5q1Eu9xzQO7P
         74wtg6dOmKQy8u/HxaJFMGZYT2H1AlDvH0VHLNnS5QFBK1abzxsROJkh0JZegNgpNrvl
         5hi2/Z51rOwzd3VM/C/IYk7wiNpctjPClgcMlVq1gIZsdYhC6mMGNhN79QWHROGpKR4q
         lAS+66APeEJzYhbB6IDnIRAPes+WVO6FgiJTjC7d4QhQ8gyR1OfKRAafWPvYBbh7FBE+
         XJPqwT+9kmJnK2AmkR0ZJpboakBTB/GPmfmg3rdDJ0/rTZyE3lQ3c4hKCHmuQyCEirbx
         Is9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqZhK1R50l6ykr+ednbs9utniIdsjwBvbHxfIjDdjXepEA18SwdAtM0WvO51EHobCOw4lRz4fQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lLpNoG/wzQCKv9BnIBDe5AZ+FLSVOWhezAEEGrlfI0pVpf9a2T
	ScR6z/wS1cw6jnm954XyNukLhPgy4u/yhPQzTWc8cFPLP8saaX23WIEA32SUMr+FKt0=
X-Gm-Gg: AR+sD11hQoxps6stKzpr+jptNagHw88x7jby2i6SYDe4u8ZqV3ngrW82JinvjBLL9T6
	ZoyWxtQv6ZrftYKtuD8roeivMNpC7o1lu3vIUAjzzlSkXS0WTVCbJXDYnzMz6PpYOxv7biH3Xhk
	Iuk5Rckt4/Z0A41LYunCTb6+wu9Oi6PgwL214Uk5/Smin6w5dU8KcSSirs4WiPbr8iE/OeI/Ds+
	wS0Rxr0NFSoy+hB4U+ALxaxyhEZCBF+6g6bAKYjxHhBqqXoqH3RvOw4Oq815D/dyBmPPSFYuDvV
	CvsQG4no6qSim7GA7TaKCxf8SFj0f5Pe+TXTvIDYUJ32oFwvCDrNZUgfe32RqCpuh9HlaYIlgis
	aKdUEszd7GOuaxkyFTmn7w3SoDu8Aj1Es1jxl/XRUVg20XNPBY2LH/YLg3wnePfboBWGxQs64Xb
	ESF/0Ld0wWlxq1XjBWhifaiGkI19AMWEdef9XRjxLEnqT5CykhHxvw0ub2
X-Received: by 2002:a17:907:d408:b0:c21:96e8:578d with SMTP id a640c23a62f3a-c246a684291mr2660691566b.15.1787539285591;
        Sun, 23 Aug 2026 19:41:25 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249686e37bsm949008466b.55.2026.08.23.19.41.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:41:25 -0700 (PDT)
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
Cc: Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v2 1/2] net: dsa: mt7530: populate lpi_interfaces to fix EEE support
Date: Mon, 24 Aug 2026 05:41:16 +0300
Message-ID: <20260824024117.46154-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824024117.46154-1-f@lex.la>
References: <20260824024117.46154-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt753x_phylink_get_caps() fills in lpi_capabilities and
lpi_timer_default but never lpi_interfaces, so phylink treats the MAC
as not supporting EEE: ethtool reports "Not supported" and
phy_disable_eee() keeps userspace locked out. That undoes what
commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
switch on all boards") arranged: EEE off by default, but enableable
with ethtool.

Copy the supported interfaces into lpi_interfaces after
mac_port_get_caps() has populated them, and leave the speeds above
1 Gbps out for now: drop 2500BASE-X from the copy, drop MAC_2500FD
from lpi_capabilities, and skip ports that support neither 100 Mbps
nor 1 Gbps. PMCR folds SPEED_2500 and SPEED_10000 onto
PMCR_FORCE_SPEED_1000, so PMCR_FORCE_EEE1G is what would govern LPI on
those links, and it is unvalidated rather than unsupported: MediaTek's
SDK driver sets the EEE force bits for 100 Mbps and 1 Gbps link speed
only, EEE signalling on 2500BASE-X is outside 802.3, and the 1 us unit
of the wakeup timers is undocumented with the port clock at 2.5 times
the rate. Narrowing lpi_capabilities alone would not do it, since it
gates on the media speed a rate matching PHY reports rather than on
the speed the MAC runs at. On MT7988, EN7581 and AN7583 port 6 is
10 Gbps only and shares PHY_INTERFACE_MODE_INTERNAL with the user
ports, so the interface mask alone cannot tell them apart.

LPI stays off until userspace enables it. The EEE advertisement of a
PHY that advertises it out of reset does come back, since phylink
stops force-clearing it. MT7531's internal PHYs keep the
advertisement mt7531_setup() zeroed, and EN7528 keeps both bitmaps
empty, so EEE stays fully off there.

Fixes: 9cf21773f535 ("net: dsa: mt7530: convert to phylink managed EEE")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Two pre-existing things this patch makes live, neither addressed here:

- The unit of LPI_THRESH is still unspecified, as the comment above
  lpi_timer_default says. With EEE reachable again, ethtool reports
  that raw value as microseconds and writes userspace values back
  unconverted, while mtk_eth_soc treats a structurally identical field
  as milliseconds (DIV_ROUND_UP(timer, 1000)). Reading the default back
  reproduces the same raw value whatever the unit is, but a timer set
  from userspace in microseconds would be off by 1000 if the field is
  in milliseconds. On an MT7531 board ethtool now reports 30 for a
  switch port, the raw LPI_THRESH field, against 1000 for the SoC MAC,
  which is a driver constant already in microseconds; whether the
  hardware means 30 microseconds is exactly the open question. Does
  anyone have the datasheet answer?

- mt753x_phylink_mac_enable_tx_lpi() sets the PMCR force-EEE bits
  without checking the resolved speed or interface, relying entirely on
  phylink never calling it above 1 Gbps. A check there would make the
  driver robust independently of lpi_interfaces being right; if that
  check is ever sent, it will warn loudly.

On leaving the higher speeds out: the absence of 2.5 Gbps EEE force
bits in PMCR is not the argument, since the same reasoning applied to
the speed field would say the switch cannot do 2.5 Gbps at all. The
masks say nobody has validated it, not that the hardware refuses.
Doing that here rather than in a separate patch changes nothing
observable: while lpi_interfaces was empty, lpi_capabilities never
reached phy->advertising_eee.

If PMCR_FORCE_EEE1G does work on the overclocked link, a rate matched
EN8811H port is exactly the setup that would benefit, so this is worth
an experiment later.
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

