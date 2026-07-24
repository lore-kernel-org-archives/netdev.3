Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4EC350A35;
	Fri, 24 Jul 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906979; cv=none; b=neZB1qy30A+lVcrdVXK7E2n/pzIAVHluNsNE5VKrr4eaGeQJ4hNvIuMCkr3DIFEwtkMr1Vb2Q6Jxs3IoasmLGaRhsPcKx/P/v8zqYq7AcwlqLUGvH59A9eXsoZia1+FwJWECxB4U1wkD8DC8dE8JNLYRhkTO82pe6EEhJzi7iYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906979; c=relaxed/simple;
	bh=eiRHmkRl75fXbU/nOnJrozLbLyyZJftra+z/20Lr1Lo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TbacMnQ/i25XKl99gw9f7GbcQNbcaFsOwIgXlR3USX4vZJW+uxWCU8DFvIwZG0qlVtoSwtmQ2bWiy4dvrBmJKaqaG6c7TgmPzkpUR7BiJ5qYh8G/rJppEYZ7KNhDJP61lIWt1jeMLMrnspAgK9mvve1Dr7eEGK/t4AVHd+sfjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UU2eSyvN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UU2eSyvN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A3EC4E40F32;
	Fri, 24 Jul 2026 15:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CF6160395;
	Fri, 24 Jul 2026 15:29:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7117611C1276E;
	Fri, 24 Jul 2026 17:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784906972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vhq3l3ddIoT0Ti0UYVXYwIdfzFenobCgOiXI/49LxDc=;
	b=UU2eSyvNFEcGUs+t4i162HjwBXPfbOCTO8OlBlI6Xe98J/sbfOD5QtRlb5xK6zzndZLfp/
	OgEV5u1EtCRGgwjSajI/Q9CmCPsFkx9JQvWJD5hU/z/mEowbaLF/W4KbLbdKkMjIXrIpEu
	idjmSyWbbNPcREYKLS/h9HxEJO58kkjdLwfhr2vITr5Yb7kVC/xkj9C30i5X+C5sggY7kx
	XwxFwdfrbs0R7m7NM92EokuJ/c6WfLyjjKONSpen6bAFqFjUkBfQYM7kbTYoYZ+25/Z+4c
	/2TqbNqVnjOTl7KDGLzR3Rglle/JyEJQdZ7C+CF/mlY2/cI+uw/8eQyCWqx7SQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v5 00/15] net: macb: implement context swapping
Date: Fri, 24 Jul 2026 17:29:23 +0200
Message-Id: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Ny27CMBAF0F9BXtfVjGPjhhX/UbHwY1xcFRvFb
 gRC+fc6YQEFlvM4915YoSFSYZvVhQ00xhJzaoN6WzG3N+mLePRtZgLEGiQgPxhnucup0qly68G
 ZIECi9KyR40Ahnpa4T5ao8tS+2O56Kb/2m1yd0+bffSw1D+elecRFvC4ZkQPvVQ9OGauFFlubc
 /2J6d3lwxI+ijuO8MBF4yZ0fdDoJdj1M+9uXD+1d41DO314ZVHBi3Z5x1E/cDnztiEdEJy3//k
 0TX8AQiK+gwEAAA==
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

During iteration V3, the LLM raised many race conditions because BH
features aren't disabled at close and might do a variety of bad things
(interact with NAPI while disabled or re-arm IRQs). This is NOT fixed
here. Here we focus on swap, not close. The series is way too long
already.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com/
[1]: https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.com/
[2]: https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com/
[3]: https://lore.kernel.org/all/DJXGIM9EGPT8.4UHNYP2Y0GOP@bootlin.com/

---
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
 drivers/net/ethernet/cadence/macb_main.c | 1901 ++++++++++++++++++------------
 drivers/net/ethernet/cadence/macb_pci.c  |   46 +-
 drivers/net/ethernet/cadence/macb_ptp.c  |   26 +-
 4 files changed, 1236 insertions(+), 866 deletions(-)
---
base-commit: 0552ba60f78bb43723c37b57eadaf8208177ce03
change-id: 20260401-macb-context-bd0caf20414d

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

