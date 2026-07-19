Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0272D8796;
	Sun, 19 Jul 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784482452; cv=none; b=axcDMF/SYkJi7UNZ8krwu9sCmmLjSZZBRXoan6L2RTkKNFalAMF00ouKWqG/yrmvc+9eg2eiVYjvse/xp0IrenxUj8nmeBcE/685L+ygolMcWjJm5V9H2nmP2rK1M9tdzDmG3IwJZh9wDatbgx45Aj5YjU3Tor9Nbvfnu56nWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784482452; c=relaxed/simple;
	bh=YMFMuM9HIDCoSHcsSkQpgGgT4/Uy6vNrU2DTS250gQY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B/4NdXVMPuPiNvQsAEeHwIKBdckjGHB5jr9eTSu+5gTEIGsIVs0n++4at/2EI8C4OwRddOLNBh2kwDVIb1A7f8+G+pBtOuvU7GFRQtFX/qsiE0M7GE4ds0AD60lEI2H1PKRjMRgDM1jqakB7aUMjeJd//oV3PEiJkez+V0GZo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wlVOi-000000004iM-0VQi;
	Sun, 19 Jul 2026 17:33:52 +0000
Date: Sun, 19 Jul 2026 18:33:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 0/8] net: dsa: mt7530: modernise register access
 and add two DSA ops
Message-ID: <cover.1784481922.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The mt7530 driver carries its own register accessors that predate the
regmap conversion and now largely duplicate what regmap already
provides, including locking. Most of this series removes that layer.

It first moves the MDIO bus locking into the switch regmap via
.lock/.unlock callbacks, matching the PCS regmaps, so any path reaching
the regmap is serialised automatically. With the wrappers no longer
adding locking, the thin mt7530_mii_* indirection is folded away and the
remaining accessors are replaced mechanically with the plain regmap API,
using the coccinelle semantic patches included in the commit messages.
Open-coded register fields are then converted to FIELD_GET/FIELD_PREP.
None of this is intended to change behaviour.

The last two patches implement .port_fast_age, which flushes dynamically
learned MAC entries on topology changes, and .port_change_conduit, which
moves a user port's CPU-port affinity at runtime.

v3 of this series arrived too close to the end of the last development
cycle and was deferred, hence this respin on top of current net-next.
---
v4:
 * rebase onto current net-next
 * 5/8: zero the read-back buffer in mt7530_regmap_read() instead of
   initialising the result variables at every call site, as suggested
   by Jakub
 * 6/8: keep MT753X_CTRL_PHY_ADDR() as plain address arithmetic rather
   than converting it to FIELD_PREP() as suggested in review: the macro
   computes the MDIO bus address of the switch PHYs, used as the addr
   argument of bus->read/write and as an iterator base in
   mt7530_setup_mdio(), not a hardware register field
v3:
 * 5/8: initialise register read-back variables to 0 so a failed
   regmap_read keeps the previous read-as-zero behaviour, and use u32
   for the value in mt7530_setup_port5
 * 6/8: name the age timer field AGE_TIMER_MASK and document the
   corrected ATC_HASH/VTCR_VID field macros
 * 7/8: serialise the port_fast_age ATC flush under reg_mutex and log
   on timeout, align a define, and correct the commit message which
   wrongly claimed per-port parity with b53/realtek
 * 8/8: populate the netlink extack on rejection and refuse a conduit
   that lives on a different switch
v2:
 * fix stray 'static void' left-over in 4/8 which had a fix accidentally
   folded into 5/8 (byte-identical state at 8/8, but bisectability is
   restored)
 * extend port_change_conduit op commit message

Daniel Golle (8):
  net: dsa: mt7530: move MDIO bus locking into regmap
  net: dsa: mt7530: fold mt7530_mii_write/read into mt7530_write/read
  net: dsa: mt7530: replace mt7530_write with regmap_write
  net: dsa: mt7530: replace mt7530_rmw/set/clear with regmap API
  net: dsa: mt7530: replace mt7530_read with regmap_read
  net: dsa: mt7530: convert to use field accessor macros
  net: dsa: mt7530: implement port_fast_age
  net: dsa: mt7530: implement port_change_conduit op

 drivers/net/dsa/mt7530-mdio.c |  12 +-
 drivers/net/dsa/mt7530.c      | 809 +++++++++++++++++-----------------
 drivers/net/dsa/mt7530.h      | 209 +++++----
 3 files changed, 537 insertions(+), 493 deletions(-)


base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
-- 
2.55.0
