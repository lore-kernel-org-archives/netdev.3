Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F535FF58;
	Tue,  4 Aug 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813040; cv=none; b=Qq3P+R/pe5vSo0v/ibbWIakDaObuyNWKebzpJgm4adjBHHLqgwCo+QK1HWVdkYLBgZ+cokGskKLAink43ggcON0UNVEotzOz7CLU0TwAR7KWEvnr8O6v+G2TAwyPrE5jUMiVdT2/S8jU2l56FzAvvQfh2am7Z1c4OSun3RC5+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813040; c=relaxed/simple;
	bh=aSP6imc7YOdrPoCux37Xpo19OC1U+YENbMYsKsostgY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WmX0cyX1ngq2QG4SijOVstQGQcT+RLGYsrdDhJ94rhmzOX4ngMuv0w5sxusw69vFGXnz1/1z2ZwnmX54wti+ZDwAS3aelA3rKKPXR4/ooGkwSwNb8DiKo8ZZeSxxk4oi4jwota60umTUBHW6yxVBJrfdI5v8cUtsfv6HuSTWeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wr5Xp-00000000448-3OQV;
	Tue, 04 Aug 2026 03:10:21 +0000
Date: Tue, 4 Aug 2026 04:10:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 0/6] net: dsa: mt7530: fix remaining swallowed MDIO
 access errors
Message-ID: <cover.1785811140.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The original series, "net: dsa: mt7530: fix swallowed MDIO read
errors", landed on net as its v1 [1] just before its v2 [2] was sent.
This series started from the fixes in that original v2 which its v1
had not already carried: the two standalone patches that original v2
grew from the Sashiko AI review of its v1 (the mtk-lynxi read check
and the regmap IRQ serialization), plus, split into patches of their
own, the companion fixes original v2 had folded into the
already-applied patches -- the unchecked bus->read() in core_rmw() and
the unchecked PHY_IAC command writes in the MT7531 indirect PHY access
functions.

The Sashiko AI review of this series' own v1 [3] then flagged two more
swallowed MDIO errors of the same kind, added here as patches of their
own: the unchecked CORE_PLL_GROUP4 read-modify-write in mt7531_setup(),
and the unchecked ATC/VTCR command-register writes in mt7530_fdb_cmd()
and mt7530_vlan_cmd().

The remaining non-fix changes from the original v2, dropping a
redundant read-back and improving the poll failure messages, will
follow via net-next.

Changes in this series (v2), relative to its v1 [3]:
 * patch 1: also report the link as down (state->link = false) on the
   failed-read path; phylink presets state->link, so the previous bare
   return reported a failed read as link-up (Sashiko AI review). Kept
   Andrew's Reviewed-by given the small, in-spirit change -- please
   re-confirm.
 * new patch 4: check the CORE_PLL_GROUP4 read-modify-write in
   mt7531_setup(), the call site exposed once patch 3 makes the MT7531
   indirect c45 access propagate command-write failures.
 * new patch 5: propagate MT7530_ATC / MT7530_VTCR command-register
   write errors in mt7530_fdb_cmd() and mt7530_vlan_cmd() instead of
   polling a BUSY bit that a failed write never set.
 * collected Reviewed-by: Andrew Lunn on patches 1-3 and 6.

[1] https://lore.kernel.org/netdev/cover.1785213071.git.daniel@makrotopia.org/
[2] https://lore.kernel.org/netdev/cover.1785368701.git.daniel@makrotopia.org/
[3] https://lore.kernel.org/netdev/cover.1785427248.git.daniel@makrotopia.org/

Daniel Golle (6):
  net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()
  net: dsa: mt7530: check bus->read() error in core_rmw()
  net: dsa: mt7530: error out on failed PHY_IAC command writes
  net: dsa: mt7530: check CORE_PLL_GROUP4 access in mt7531_setup()
  net: dsa: mt7530: check command register writes in fdb and vlan cmd
  net: dsa: mt7530: serialize the regmap IRQ chip like every other user

 drivers/net/dsa/mt7530.c        | 86 +++++++++++++++++++++++++++------
 drivers/net/pcs/pcs-mtk-lynxi.c |  7 ++-
 2 files changed, 75 insertions(+), 18 deletions(-)


base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
