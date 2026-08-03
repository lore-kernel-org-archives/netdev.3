Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33830D3F8;
	Mon,  3 Aug 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787708; cv=none; b=ZDlmCHaFQpcIWrlKnKY2SSMYAgr+/zgQpyX2AB0qoTBNwHsYzWUmEtP+LwmQo4+TTJ5otLQ10s1c8up0hmHR9iZk+ermcTfKDyw3mVhdgmsGHIY7pSdCzT3kNbapac9lQuIl9Ytu2gYJGdFv0K8LHGVDaKNm6gWW0UKNUydOqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787708; c=relaxed/simple;
	bh=V3FX25mUedJDFOfEpxcPCv1SRIsVydWE731FEkVjNws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o7sZLkhlseeHkKQumVnH7pg6tvLISOkAYYShZoTymsVRwzgTyLJJsFG/SKEqZV6rP3U1wxUg3mdFesPQLQ/+57w4b7iEgv2TaNihU4tHkQksKi6S7a4iQ1TMuMZ2TliS0IohXnYjQUFeyGHwb3FnUHs9gktJWl1LtdWhYammA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y8lIALx6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y8lIALx6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 982B84E410AE;
	Mon,  3 Aug 2026 20:08:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5ED2F6029B;
	Mon,  3 Aug 2026 20:08:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 192C211C3184F;
	Mon,  3 Aug 2026 22:08:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785787698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kib++c82yflL2WgsJpvFwtjNFUuR23efCNtygr2UrzY=;
	b=y8lIALx6FVEZUcmiIaFbRAqDAdPGsyYlooeQLUMrqQ4q3Zk/CD4mO6/pjP0G1/REGZRh49
	wjr5Mesgg7XOr/UbvNeLgjkV0LNQ3NzMIFqakM9pYfe/HazGM31sRSUToR9RK3pEwX+Rvx
	U9GdzigHUq8QXvsnD4cGoGcXGD+SKasgMpKV04AbKGs0Sy7E5PQccZPJdOLh9u4p6l7Qs1
	UNoksSJNgJcOAnf06jwMgjLQFMittHCoqBBAYE16PHNAf0Vm3K40qafSz68bYVVR69blX6
	56aJP/DESEcuQ8ve9lYGYAkw4hlEZquEzmHcylgl08RSilH6x+MoG/3pgXtVCA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v7 00/17] net: macb: implement context swapping
Date: Mon, 03 Aug 2026 22:08:07 +0200
Message-Id: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oy07DMBAF0F+pvMZoxvEjZsV/IBZ+UiNqo8RER
 VX+HScsCEmX45lzr29kDEMKI3k63cgQpjSmktugHk7EnU1+CzT5NhMGTAIHpBfjLHUl13Ct1Hp
 wJjLgyD1p5HMIMV3XuBeSQ6W5XZHX3834Zd+Dq0vacntOYy3D99o84Srul0xIgWqhwQljFVPs2
 ZZSP1J+dOWyhk9swxF2nDVuYqejQs/ByiPv/rg6tHeNQ1v1XlgUcKedbziqHecLby9BRQTn7ZG
 LDWd8x0XjQmqLvWDWqXjkcsO7/edl41x7YZB32vP+P5/n+QckuL2GAQIAAA==
X-Change-ID: 20260401-macb-context-bd0caf20414d
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

MACB has a pretty primitive approach to buffer management. They are all
stored in `struct macb *bp`. On operations that require buffer realloc
(set_ringparam & change_mtu at the moment), the only option is to close
the interface, change our global state and re-open the interface.

Two issues:
- It doesn't fly on memory pressured systems; we free our precious
  buffers and don't manage to reallocate fully, meaning our machine
  just lost its network access.
- Anecdotally, it is pretty slow because it implies a full PHY reinit.

Instead, we shall:
 - allocate a new context (including buffers) first
 - if it fails, early return without any impact to the interface
 - stop interface
 - update global state (bp, netdev, etc)
 - pass newly allocated buffer pointers to the hardware
 - start interface
 - free old context

This is what we implement here. Both .set_ringparam() and
.ndo_change_mtu() are covered by this series. In the future,
at least .set_channels() [0], XDP [1] and XSK [2] would benefit.

---
What your state of mind on this series? Past two iterations were about
fixing Sashiko edge-cases.

The most important fix was netconsole related and only lightly related
to this series. For the rest, it is nice that they are fixed but
overall I couldn't find a way to reproduce any of them, seeing how
unlikely they all are.

Can we get this in net-next? Goal being to work on XDP [1] & XSK [2]
during the next kernel cycle, bringing those long awaited features
into MACB.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com/
[1]: https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.com/
[2]: https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com/
[3]: https://lore.kernel.org/all/DJXGIM9EGPT8.4UHNYP2Y0GOP@bootlin.com/

---
Changes in v7:
- queue->tx_{head,tail} got renamed: fixup queue->tx_ptr_lock field
  comment and netdev_dbg() call in macb_start_xmit().
- Ensure bp->configured_{rx,tx}_ring_size have correct values in the
  EMAC case so that get_ringparam doesn't lie.
- Refuse set_ringparam on EMAC, which is invalid (sizes are hardcoded).
- Fix whitespace issue in "change function signatures to take contexts".
- Fix rebase mistake: macb_tx_unmap() signature change moved from
  patch "change function signatures to take contexts" to "change caps
  helpers signatures".
- Patch "move printk() calls out of bp->lock critical section":
  - Undrop netdev_vdbg() in macb_tx_error_task(); let's ignore the race
    for debug printk calls.
  - Move netdev_err() from macb_interrupt_misc() into macb_interrupt()
    so it can live outside the bp->lock critical section.
  - Add details to commit message.
- Patch "use context swapping in .set_ringparam()":
  - Re-schedule LPI after swap with delay=1s. Pick 1s so that if
    link-up -> swap instantly, we still respect the IEEE spec.
  - Add bp->link_up set under bp->mac_cfg_lock. netif_carrier_ok() bit
    is unsafe because not set inside a critical section we can enter.
  - Drop mac_cfg_lock from macb_hresp_error_task(); made useless by
    above.
  - Move macb_halt_tx() out of bp->lock to avoid 14ms latency spike
    possibility. Safe to do so.
- Patch "use context swapping in .ndo_change_mtu()":
  - Clarify commit message about EMAC.
- Rebase onto latest net-next/main (69963a0678a3), nothing to report.
- Link to v6: https://patch.msgid.link/20260731-macb-context-v6-0-49d5a1439d48@bootlin.com

Changes in v6:
- Non Sashiko based:
  - Take 3x Reviewed-By: Nicolai.
  - Silence checkpatch warnings in [02/15] about printk(..., __func__).
  - Rebase to latest net-next/main (a5c6ae8de11e), nothing to report.
- Fix netconsole/netpoll deadlock coming from macb_tx_error_task()
  calling printk() inside the bp->lock critical section.
- Move at91ether synchronize_irq() on close to protect more kfree().
- Clarify commit message for [11/15]: functions operating on the
  interface have no risk of using the wrong interface.
- On swap end, only re-enable the interface if !netif_carrier_ok().
- macb_hresp_error_task() grabs bp->mac_cfg_lock as it toggles the
  carrier state, to avoid race with context swap.
- On swap end, move netif_tx_start_all_queues() into bp->mac_cfg_lock.
- Link to v5: https://patch.msgid.link/20260724-macb-context-v5-0-569b1852bc7f@bootlin.com

Changes in v5:
- Fix build on [PATCH 02/15]; `bp->dev` got renamed to `bp->netdev`.
- Fix one word in commit message of [PATCH 07/15].
- Move bp->ctx->info assignment in at91ether_open() from [PATCH 12/15]
  to [PATCH 09/15].
- In [PATCH 14/15], reset DQL (dynamic queue limits) after tx disable,
  not before.
- Take 7 Reviewed-by: Nicolai (weirdly not all detected by b4).
- Rebase on latest net-next/main (89d8006259b8), nothing to report.
- Link to v4: https://patch.msgid.link/20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com

Changes in v4:
- Disable tx_error_task then disable NAPI because error task does a
  napi_disable() which deadlocks if NAPI is already disabled.
- Disable NAPI then disable tx_lpi_work, because NAPI might re-arm the
  latter.
- Last iteration did mask-irqs then disable-and-wait-for-bh then
  disable-hw. This is flawed because BH rearm IRQs once done. We don't
  have a good way to signal to them they shouldn't do so (we don't want
  to lock from NAPI context). So instead we add a bp->ctx_swap flag,
  shielded by bp->lock, to indicate to our IRQ handler to ignore IRQs
  and self-disarm.
- at91ether_close(): synchronize_irq() before freeing context.
- macb_interrupt(): drop double ISR read (outside & inside bp->lock).
- Rebase on latest net-next/main (f6f3b36c15ed). macb_free() since
  commit 27f575836cfe ("net: macb: drop in-flight Tx SKBs on close")
  needs access to queue stats => add them to macb_info.
- Take trailers.
- I did NOT init ctx->rx_ring_size/tx_ring_size/rx_buffer_size from
  at91ether_open(), as recommended by the netdev LLM. They are not the
  first fields in MACB that are present in both instances and that are
  uninitialised in one case. AT91 is almost a different driver. [3]
- Link to v3: https://patch.msgid.link/20260701-macb-context-v3-0-00268d5b1502@bootlin.com

Changes in v3:
- Use `const struct macb_info *info` instead of bare `u32 caps` as
  helper arguments, for type safety.
- macb_interrupt(): the pre-lock readl(ISR) to detect spurious
  interrupts is only done if CLEAR_ON_WRITE.
- Don't forget allocating context in at91ether_open().
- swap:
  - Refuse swap for EMAC HW; it would crash because codepaths are so
    different.
  - Grab new bp->mac_cfg_lock to serialise with phylink MAC callbacks.
    We cannot rely on phydev->lock because it isn't present in the SFP
    or fixed-link cases. We also want to avoid phylink_stop() which
    triggers a slow PHY retrain.
- swap start:
  - We used to do disable-irqs-and-hw then drain-all-bh-features, but
    then HW might be raced against. Instead we disable-irqs then
    drain-all-bh then disable-hw which means at disable-hw step no BH
    context can be active.
  - Use macb_halt_tx() helper to properly stop HW.
  - Disable BH features before netif_tx_disable() call to avoid queue
    wakeup races.
  - Use macb_queue_isr_clear() helper instead of manual if-then-writel.
- swap end:
  - Grab bp->lock for the hardware reinit sequence composed of DMACFG
    and NCR writes.
  - Drop now useless EMAC check (we refuse EMAC HW before swapping).
- nits:
  - New patch to rename macb_{alloc,free}_consistent() which don't only
    allocate consistent buffers since a long time ago.
  - Fix the start_xmit verbose netdev_vdbg() format string from %hu to %u
    because the queue index type changed.
  - Strong commit reword from "unify `struct macb *` naming convention"
    to "unify variable naming convention in at91ether functions" which
    was underselling the changes.
- Rebase upon latest net-next/main (1c664ec4b9ea).
- Link to v2: https://patch.msgid.link/20260410-macb-context-v2-0-af39f71d40b6@bootlin.com

Changes in v2:
- Patch "add subset of `struct macb` to `struct macb_context`" was
  messed up. It contained much more than what the name implied. Split
  into three commits (I caused trouble by rebase reordering).
- Fix tieoff; V1 allocated it without initialisation.
- Fix NULL pointer dereference on context in mab_get_regs() and
  macb_get_ringparam() when interface is offline.
- Patch "unify device pointer naming convention":
  - Fix build issue when CONFIG_NETCONSOLE=y.
  - Rename `struct net_device *dev` to `netdev` in macb.h.
  - Rename `struct phy_device *phy` to `phydev` in macb_main.c.
- On swap, call netdev_tx_reset_queue() to reset all DQL counters.
- At end of swap, add missing kfree(old_ctx).
- During HW disabling in swap, grab bp->lock to protect against IRQ
  handler.
- On swap, cancel the three BH features MACB has:
  bp->hresp_err_bh_work, bp->tx_lpi_work and queue->tx_error_task.
- On swap, call macb_configure_dma() which writes buffer size to
  hardware registers. This is important because the change_mtu codepath
  changes the buffer size.
- Rebase onto latest net-next/main (58dd34dbd5b0) & resolve conflicts.
- Link to v1: https://patch.msgid.link/20260401-macb-context-v1-0-9590c5ab7272@bootlin.com

To: Théo Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Paolo Valerio <pvalerio@redhat.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Benoît Monin <benoit.monin@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---
Théo Lebrun (17):
      net: macb: drop "consistent" from alloc/free function names
      net: macb: unify device pointer naming convention
      net: macb: unify variable naming convention in at91ether functions
      net: macb: unify queue index variable naming convention and types
      net: macb: enforce reverse christmas tree (RCT) convention
      net: macb: allocate tieoff descriptor once across device lifetime
      net: macb: refuse set_ringparam on EMAC
      net: macb: introduce macb_context struct for buffer management
      net: macb: avoid macb_init_rx_buffer_size() modifying state
      net: macb: make `struct macb` subset reachable from macb_context struct
      net: macb: change caps helpers signatures
      net: macb: change function signatures to take contexts
      net: macb: introduce macb_context_alloc() helper
      net: macb: move printk() calls out of bp->lock critical section
      net: macb: read ISR inside bp->lock critical section
      net: macb: use context swapping in .set_ringparam()
      net: macb: use context swapping in .ndo_change_mtu()

 drivers/net/ethernet/cadence/macb.h      |  134 +-
 drivers/net/ethernet/cadence/macb_main.c | 1962 ++++++++++++++++++------------
 drivers/net/ethernet/cadence/macb_pci.c  |   46 +-
 drivers/net/ethernet/cadence/macb_ptp.c  |   26 +-
 4 files changed, 1292 insertions(+), 876 deletions(-)
---
base-commit: 492568fab54e8eb8ab0aa7928e6ea44505729854
change-id: 20260401-macb-context-bd0caf20414d

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

