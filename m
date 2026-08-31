Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD914B0C9C;
	Mon, 31 Aug 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191108; cv=none; b=l295mROhEUk1YTVV9S7LlNLv0dqKWY8jiUWdBgErzqDLBZBEoatosh942/OEPTVylR715j5vbg2R0m+XgrnM4+fddV7z4lUDcxXBEjYgXBAY50oGhZ8zTUIRxqBKbtdTVhPyTY1tJ/WGkmle/Iro4P4V6iwYUwKk4Fy4yYEkDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191108; c=relaxed/simple;
	bh=uDD1Qf9E2k39uOikV5ad339e+tIacNu4p9DOvxTuqL8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XQxB4qTSuEuy4oMt/iH2G4oBXzJkr0A9ek/Sk2XCKglQZvE7HRQyGNKEUHzfeBfEP5ajKNfJByA9fAJfBOb7WGEjOjHeZ30VhSoMUvZ1fWRhTiE8SpIVp2jjpZxF61Q4uU/C5D0TO4k+dYiQiIPmY4BiR+GCyJgcwY2GTddGPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x144x-0000000078f-0rPf;
	Mon, 31 Aug 2026 15:37:47 +0000
Date: Mon, 31 Aug 2026 16:37:43 +0100
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
Subject: [PATCH net-next v5 0/9] net: dsa: mt7530: modernise register access
 and add two DSA ops
Message-ID: <cover.1788190568.git.daniel@makrotopia.org>
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
The two remaining reset polls are converted to
regmap_read_poll_timeout() and the then-unused dummy poll machinery is
dropped. Open-coded register fields are converted to
FIELD_GET/FIELD_PREP. None of this is intended to change behaviour.

The last two patches implement .port_fast_age, which flushes dynamically
learned MAC entries on topology changes, and .port_change_conduit, which
moves a user port's CPU-port affinity at runtime.

The swallowed MDIO errors Sashiko flagged on v4 5/8 have meanwhile been
fixed in tree by "fix swallowed MDIO read errors" and "fix remaining
swallowed MDIO access errors", both merged into net-next. This respin is
rebased on top of them: regmap_* return values are no longer ignored,
which is what most of the semantic patches had to be reworked for.
---
v5:
 * rebase onto current net-next, on top of the two MDIO error handling
   fix series merged since v4
 * new patch 6/9 dropping the mt7530_dummy_poll machinery
 * 1/9: also revert commit dd52b3df25ed ("net: dsa: mt7530: serialize
   the regmap IRQ chip like every other user"), whose workaround the
   regmap's own locking makes redundant
 * 7/9: list STAG_VPID among the repaired macros, document the
   VTCR_VID() masking
 * 8/9: check the ATC command write and poll via
   regmap_read_poll_timeout()
 * 9/9: list EN7528 among the single-CPU-port switches
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

Daniel Golle (9):
  net: dsa: mt7530: move MDIO bus locking into regmap
  net: dsa: mt7530: fold mt7530_mii_write/read into mt7530_write/read
  net: dsa: mt7530: replace mt7530_write with regmap_write
  net: dsa: mt7530: replace mt7530_rmw/set/clear with regmap API
  net: dsa: mt7530: replace mt7530_read with regmap_read
  net: dsa: mt7530: drop the dummy poll machinery
  net: dsa: mt7530: convert to use field accessor macros
  net: dsa: mt7530: implement port_fast_age
  net: dsa: mt7530: implement port_change_conduit op

 drivers/net/dsa/mt7530-mdio.c |  12 +-
 drivers/net/dsa/mt7530.c      | 834 ++++++++++++++++------------------
 drivers/net/dsa/mt7530.h      | 221 ++++-----
 3 files changed, 530 insertions(+), 537 deletions(-)


base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0
