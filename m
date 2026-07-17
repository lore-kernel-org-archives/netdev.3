Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E352C21F0;
	Fri, 17 Jul 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317703; cv=none; b=OqdKwjF6pUgR4SNBMCOIAceU3o0CAYAFXXoplYnZ9UM9tKdWOpiq8/MTFDBtgq0kcJJoKucowgzGn9XpcF3rxxae8ADySr+bFU/vNe+fBj+/xNd0jOZTIKj+5qD5EFMg01JzBIvC7LqpHAD8fhlZm2s4GTH8zn/xRZxlNR4XXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317703; c=relaxed/simple;
	bh=hqYBZo99serwPYUWwFP85DHre1MHErnIw9YwKY3y/CQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JrT+gMfX0CQr8KfxNa+bc6HeCY27As32VRUp+XVcQ+b5xq2c5Gh6WbFesh31BHRTkChPUYurn0MUyOd/TQV+uf5XrOPBR88oqGNqdhdwzXou3BCh4BJ/sif65vZLlSxkPWvb3Bg8DTVEkqCji8oTEhBr0h3qO5sD+0HWcuYWLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fuyG0l7G; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fuyG0l7G"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1DE724E40E24;
	Fri, 17 Jul 2026 19:48:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C799760361;
	Fri, 17 Jul 2026 19:48:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABB5711BD013E;
	Fri, 17 Jul 2026 21:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784317695; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZseV3t/GhmmvOhDpvYIUa5SrzBicu8+PBzQxNCN0PbE=;
	b=fuyG0l7G3K8oKmpUmHYzicA3q0YElRaSagDaxU/Na1nyPGjq+Mz9tIJ76LTuQ33vjfvunh
	EVZtd/vLXVKTxBO0+q0e3qeWeLtd+EpbpKJfTT8BdNYCI4nUPEf15xYQcM8uC9nVFnQaGc
	85At+OeBawfaC11ozxiAEFKAPLmYMvhVNaUTnbQIJv/rWsXMV7Quc7WzhiWstTfHlNYxIx
	0dVV34RGQc1lXQC3lkZ+CHDYaNWVsBAEaYKc88txpI52cc7RJlh8nM23e8erMTFhNibW5H
	wsYhTnqEsvnKUsp5zK9kPmibLhe2c+EvJMj/5Pq30cJ2AG1/TJtZiwZEwQjSxw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v4 00/15] net: macb: implement context swapping
Date: Fri, 17 Jul 2026 21:48:03 +0200
Message-Id: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NTQ6CMBhEr0K6tuZrKSCuvIdx0T+kRlrTVoIh3
 N2CCw24nMy8eSMK2hsd0DEbkde9CcbZFNguQ7Ll9qqxUSkjCrQEBgR3XAosnY16iFgokLyhwAh
 TKCEPrxszLHdnZHXENq3Q5dOEp7hpGee3eduaEJ1/LeaeLMR/SU8w4LqoQRZcVLSiJ+FcvBu7l
 65bznv6gxNY4TThvMnrpiKKgSi3eP7Fq409Tzik6qAKQQpY2adpegNfuNXCRAEAAA==
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

The change is super intrusive so conflicts will be major. Sorry!

--

During the last iteration, LLM raised many race conditions because BH
features aren't disabled at close and might do a variety of bad things
(interact with NAPI while disabled or re-arm IRQs). This is NOT fixed
here. Here we focus on swap, not close. The series is way too long
already.

@Nicolas & @Conor: we discussed in the past the swap sequence ordering
and I'm curious to get your feedback on this new iteration. It has
been (yet again) updated, fixing races. An opinion on it? See first
three bulletpoints of the changelog below for info about the changes.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com/
[1]: https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.com/
[2]: https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com/
[3]: https://lore.kernel.org/all/DJXGIM9EGPT8.4UHNYP2Y0GOP@bootlin.com/

---
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
Théo Lebrun (15):
      net: macb: drop "consistent" from alloc/free function names
      net: macb: unify device pointer naming convention
      net: macb: unify variable naming convention in at91ether functions
      net: macb: unify queue index variable naming convention and types
      net: macb: enforce reverse christmas tree (RCT) convention
      net: macb: allocate tieoff descriptor once across device lifetime
      net: macb: introduce macb_context struct for buffer management
      net: macb: avoid macb_init_rx_buffer_size() modifying state
      net: macb: make `struct macb` subset reachable from macb_context struct
      net: macb: change caps helpers signatures
      net: macb: change function signatures to take contexts
      net: macb: introduce macb_context_alloc() helper
      net: macb: read ISR inside bp->lock critical section
      net: macb: use context swapping in .set_ringparam()
      net: macb: use context swapping in .ndo_change_mtu()

 drivers/net/ethernet/cadence/macb.h      |  129 +-
 drivers/net/ethernet/cadence/macb_main.c | 1898 ++++++++++++++++++------------
 drivers/net/ethernet/cadence/macb_pci.c  |   46 +-
 drivers/net/ethernet/cadence/macb_ptp.c  |   26 +-
 4 files changed, 1233 insertions(+), 866 deletions(-)
---
base-commit: f5f823b42e93c61d1ab5a7ea8de42a88afff4c22
change-id: 20260401-macb-context-bd0caf20414d

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

