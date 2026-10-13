Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB74511E9B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897416; cv=none; b=Tp366lPNx+n8Zxy6/FEfaN8MLUKGxsuKZxP5QMzAvXiyTkKCD7arDutPWPoHT75vKoyuB5Yc0HaoPCuN4vxKKgtPIXpEnVCRXKPlduRYTypHB+kMJDyET2mfQg6e7x2aLrYv+D16mqu7De5T+ajoMKX9t8rpWJk9VE+klw4Eyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897416; c=relaxed/simple;
	bh=j9Fb4dv9EPRQ+uZtt1l8oS5O/bUhPPGUwad7uT8R15U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=un7vEVF9bHG8InJLX4TsNdEuPECrmqHak3Qeg4KV/BRmrRI+kfbzlLEAE/M6LAggiTeoueviBvMWXz5Yii3uMGeVCvGGmLXGNctDPUV1AYfchSLw9AtDcVxclfL1Q5SzdhfAKKbHhuau2ih6sACTZifHUhUNRckmNDBqyGmzcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mCllvbpI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mCllvbpI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D1894E411FB;
	Tue, 13 Oct 2026 13:16:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2A5660362;
	Tue, 13 Oct 2026 13:16:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96D0011D713D8;
	Tue, 13 Oct 2026 15:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897410; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JrYz3LPPPvhbVHp+AiRh2M2VC+mKJv87P5uGwUZE8BY=;
	b=mCllvbpIcLZbnisNa7so6sVUpP9aEZB2/8WszKgfxlRIJEf0B7IiUP2zZZVFuZALZITdfD
	IFJFL80zIHkVgwekMjMm0Uu8tONBwZVoHSlAECx/BsVTawRG4vzLrcwwvplTPWHcgafveS
	8AfLDhxxG8TkWDzSKB5uUxI4nvFOOLXnpq7rA8uylIBA6DSjE6ojegzlbzpJqqbZwAi7Ef
	Eg1BatYXRiqCUkOEFXyWG0leoQMnqXkoxZascsztmqbpMJZHsk9rGzxOaMU54myigp+L/6
	0RQJK30Fz98NCtg4SXu0t/DEDVe2/g+qYiuRrA8wFtBcCAE9x1R790ilFlt13g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v11 0/9] net: macb: implement context swapping
Date: Tue, 13 Oct 2026 15:16:38 +0200
Message-Id: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzW7DIAwH8FepOI/JJiaEnvYe0w4xH2umNZmSL
 OpU9d1HMmmNoEeMf/4j4CqmMHZhEsfDVYxh6aZu6NMC8ekg3Knt34PsfCoIBaoGApTn1rF0Qz+
 HyyzZg2ujAkLyIpGvMcTuss17FX2YZZ+6xNvfzvTNH8HN67S199RN8zD+bNELbuJxyIISpNUWn
 G7ZKKNeeBjmz65/dsN5G76oHUfIuEq8jZWNBj0B1yWv7twU6VXikLYarxk1PEinHUeTcVp5qgQ
 TEZznkusdV5RxnbiuLWOjFTsTS17veJUfvk6crNctUmU9NSU3d95AlXGzcm88tRGoIVvyZs91x
 pvE2VWgYvSIhkpudxxVxm3ixnuOOj2dDlByhH+PUP4bWPMDa0JmNj67vNvt9gutI4QbAAMAAA=
 =
X-Change-ID: 20260401-macb-context-bd0caf20414d
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 stable+noautosel@kernel.org, Sashiko <sashiko-bot@kernel.org>
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
I wonder if we can get those changes in before the next merge window?
The idea being that we can restart iterating on XDP [1] & XSK [2]
during the next kernel cycle, bringing those long awaited features into
MACB.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com/
[1]: https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.com/
[2]: https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com/
[3]: https://lore.kernel.org/all/DJXGIM9EGPT8.4UHNYP2Y0GOP@bootlin.com/
[4]: https://lore.kernel.org/netdev/20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com/
[5]: https://lore.kernel.org/netdev/20260918-macb-ncr-rmw-v1-1-30c3494f93cd@bootlin.com/

---
Changes in v11:
- Address race report by Sashiko in a new patch at the start of the
  series; this fix does not deserve to target net/main. Note the commit
  message triggered get_maintainers to Cc PREEMPT_RT people but I
  explicitly left them out.
- Note in patch 2/9 commit message about the `ethtool -g` value changing
  on EMAC/RM9200.
- Update Cc: edumazet@google.com -> edumazet@kernel.org.
- Rebase onto latest net-next/main (d7804253678e); one tiny conflict.
- Link to v10: https://patch.msgid.link/20261001-macb-context-v10-0-beb541bbb7df@bootlin.com

Changes in v10:
- Rebase onto latest net-next/main (47a144672573), dropping first 7
  patches applied by Jakub. It also means we reuse the quiesce work
  introduced by 4fcaed2cb1d8 ("net: macb: quiesce IRQs and drain BH on
  interface close").
- Drop wrong patch "read ISR inside bp->lock critical section".
- Patch "move printk() calls out of bp->lock critical section"
  was sent separately as it is standalone.
  https://lore.kernel.org/netdev/20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com/
- In commit "change caps helpers signatures", in macb_rx_pending(),
  convert missed macb_is_gem() call from bp to bp->info. Restore
  bisectability.
- Writes to bp->ctx are now made with WRITE_ONCE() + wmb().
- macb_tx_restart() now early exits if context swap is ongoing, to avoid
  races. For that, we grow its existing bp->lock critical section.
- Link to v9: https://patch.msgid.link/20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com

Changes in v9:
- Drop unused `netdev` stack variable in macb_interrupt_misc().
- Rebase onto latest net-next/main (ac155a26750a), nothing to report.
- Link to v8: https://patch.msgid.link/20260805-macb-context-v8-0-bc302ffd1174@bootlin.com

Changes in v8:
- Avoid growing existing race condition window inbetween
  macb_tx_error_task() and macb_interrupt() by moving printks.
- On swap end, don't start tx queues if link-down.
- On swap end, wake tx queues instead of only starting them.
- Rebase onto latest net-next/main (a23b36233d41), nothing to report.
- Link to v7: https://patch.msgid.link/20260803-macb-context-v7-0-4d7d4af04849@bootlin.com

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
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Valerio <pvalerio@redhat.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Benoît Monin <benoit.monin@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---
Théo Lebrun (9):
      net: macb: close race between NAPI polls & ndo_stop
      net: macb: introduce macb_context struct for buffer management
      net: macb: avoid macb_init_rx_buffer_size() modifying state
      net: macb: make `struct macb` subset reachable from macb_context struct
      net: macb: change caps helpers signatures
      net: macb: change function signatures to take contexts
      net: macb: introduce macb_context_alloc() helper
      net: macb: use context swapping in .set_ringparam()
      net: macb: use context swapping in .ndo_change_mtu()

 drivers/net/ethernet/cadence/macb.h      |  115 ++-
 drivers/net/ethernet/cadence/macb_main.c | 1142 +++++++++++++++++++-----------
 drivers/net/ethernet/cadence/macb_ptp.c  |    8 +-
 3 files changed, 824 insertions(+), 441 deletions(-)
---
base-commit: 590b33dce9c34404cd6a23dadbdb316d6b61fdf6
change-id: 20260401-macb-context-bd0caf20414d

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

