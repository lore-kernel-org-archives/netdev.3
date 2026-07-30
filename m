Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDEE221FB6;
	Thu, 30 Jul 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370501; cv=none; b=ryoE2+QXTSk0VlZ4c4xo6wwOkEontfHK6Tj3Vg4OMP0iySq5Ki5/mCiiFoTvSnLeI837w0GKCSq7sgtCpVJHHXA0Pd2TBFjyHxPFeSKkCbdpxr5oGBIimFY+FJRNpqzhVIdDnEwONeHSAq8DJ6Qwgzys7wKnGOz6+iqMpJgNHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370501; c=relaxed/simple;
	bh=VJn6Qqx/mOOwh9gN90nBfVEtRdLKb/zYawgyKXMATpM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOUxqxfKcaEMoudg3l4R+AnsBsiCh9UwgnLglMsEOPx5cWXkiwWTJhjLWm4IsiQ/Uo/sjhFhiljrbEbIs4slt/aDXPY/nr7qnjPicsiGp8g+qPjL9olNlZBdsWNSURPYrxHiHVEnF4tM33FOGXtGjlgBh352geNHNmslduKwoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpEPx-000000002eX-3Jjt;
	Thu, 30 Jul 2026 00:14:33 +0000
Date: Thu, 30 Jul 2026 01:14:30 +0100
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 0/5] net: dsa: mt7530: fix swallowed MDIO read errors
Message-ID: <cover.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While working on a register access cleanup for the mt7530 driver, the
Sashiko AI reviewers flagged long-standing error handling gaps in the
driver's read paths [1].

The MDIO regmap backend truncates negative bus->read() errnos into u16
register halves and returns success, handing garbage data to callers
and to read-modify-write cycles which then write it back to the switch.

The ATC/VTCR command polls and the MT7531 indirect PHY polls consume
reads through a helper which returns 0 when the underlying read fails.
A failed bus transaction thus clears the polled busy bit and is
mistaken for command completion, defeats the subsequent
ATC_INVALID/VTCR_INVALID checks the same way, and lets the indirect
PHY access functions return garbage PHY register data.

Fix the backend to propagate bus->read() errors, and convert the
command and PHY access polls to regmap_read_poll_timeout(), which
terminates polling on read errors and propagates them. The driver's
legacy read helpers return plain u32 values and cannot convey errors,
hence the affected reads switch to the plain regmap API the helpers
are built on, while all other accesses are deliberately left
untouched; the cleanup series converts the rest of the driver.

The Sashiko reviewers went over v1 as well [2] and found that the same
unchecked-read pattern recurs in a couple of other places, and that the
read-error propagation above widens a pre-existing gap in a PCS driver
consumer; patches 1-3 grew companion fixes for those. They also found a
separate locking gap between the switch regmap and its IRQ chip, fixed
in the new patch 4 with its own Fixes: tag.

The cleanup series depending on these fixes will be submitted to
net-next separately.

Changes since v1:
 * 1/4: also check the identical unchecked bus->read() in core_rmw(),
   and fix mtk_pcs_lynxi_get_state() (drivers/net/pcs/pcs-mtk-lynxi.c)
   to check regmap_read() now that a failed read can leave its output
   unwritten instead of holding truncated-but-defined garbage
 * 2/4: drop the redundant regmap_read() after
   regmap_read_poll_timeout(), and print ret in the error messages
 * 3/4: also check mt7530_mii_write()'s return for the PHY_IAC command
   word in all four PHY access helpers, and print ret in the poll
   error messages
 * add 4/4, calling mt7530_mutex_lock()/unlock() around the regmap IRQ
   chip's own accesses via handle_pre_irq/handle_post_irq/
   handle_mask_sync, the same driver-provided locking every other user
   of the unlocked switch regmap already goes through, instead of
   adding a second regmap instance

[1] https://lore.kernel.org/netdev/cover.1784481922.git.daniel@makrotopia.org/
[2] https://lore.kernel.org/netdev/cover.1785213071.git.daniel@makrotopia.org/

Daniel Golle (5):
  net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()
  net: dsa: mt7530: check bus->read() errors in the MDIO regmap backend
  net: dsa: mt7530: error out on failed reads in ATC/VTCR command
    polling
  net: dsa: mt7530: error out on failed reads in MT7531 PHY polling
  net: dsa: mt7530: serialize the regmap IRQ chip like every other user

 drivers/net/dsa/mt7530-mdio.c   |  11 ++-
 drivers/net/dsa/mt7530.c        | 170 ++++++++++++++++++--------------
 drivers/net/pcs/pcs-mtk-lynxi.c |   5 +-
 3 files changed, 108 insertions(+), 78 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0
