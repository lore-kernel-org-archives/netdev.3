Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605433570AD;
	Tue, 27 Jan 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522019; cv=none; b=c+XCDxZy0mlhF6Qc9JktJ7ajYEMsSlDUglqdIprPLBuqc5Yb58As8jeEFcn/yHfgLtpsiYsj0kU/Ofb9Oo6pQ0vrXWSCztyzDfORyfbiHpFjyg8nLQAWiIEfWG/nRiH8fKjkztAX8a494yTnroJ0ClrKHPug4hgMumTXysgOBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522019; c=relaxed/simple;
	bh=BwreBWKzwCGIXM9xkXw+Gm6OCes550z5oAe2Y3klNlU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FjHOLvIa1DQ2jfOTxfix7nGteurMwyrs6LCyAoiArYwSdspHuV+Fy0d2erKAwevDf90mwQAZN/mlwP40TnO98qcap2W2v0TDNZuYrv2P8AjrUVeH5Vjs6z1xDS/fiOEpgI4VbV1WQgNUqRR09IPXJeAJDooDK1UaTlNDg65qf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N86MAWi5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2T3mrBvN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N86MAWi5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2T3mrBvN"
Date: Tue, 27 Jan 2026 14:53:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769522016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Uws7L94Uj+vJ/pChcGJTKMbNi1IcV4xKl4/ty70FJPo=;
	b=N86MAWi5xhHQNFZQ1wgSaZnp5TIkkDQh3T2sRgHXgP58kqSla+A0Ni4co7st0PiB92fpCA
	7Qon8Qhp0rA78lrrq6NmxMY0lqwrplmQRamBqp33AwUG9eQ9gErFqihUbZXNA7FmkIWB5g
	CQT1G/j2nZxxluTBnBtSu26mX6Tcc9VeOQ2P/B5ra/T49JuAqbB03fFICG3/s8dWZUwX1C
	twTWS4zXIx5MBx1Ms9ZClqjhpb8Sl/6QuCr1O4yvgB/01jf78wXYSuuxKfvFtwaHIABgRz
	gpT/RX5uwuC7HIxx/9AQ3BWegCaZT0CKjuxhestWEY6ahrQ3lhQW7MIgByLehg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769522016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Uws7L94Uj+vJ/pChcGJTKMbNi1IcV4xKl4/ty70FJPo=;
	b=2T3mrBvNcj8DRx7IlKSaHbrTtwGT6UsSY/yeWUS0AEAygACsGcp8khUDc5q+6dF2NJ0GPL
	mEGW7SAa6YOJFpBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, linux-mips@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2] declance: Remove IRQF_ONESHOT
Message-ID: <20260127135334.qUEaYP9G@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this as of commit aef30c8d569c0 ("genirq: Warn
about using IRQF_ONESHOT without a threaded handler").

The IRQF_ONESHOT flag was added in commit 0fabe1021f8bc ("MIPS:
DECstation I/O ASIC DMA interrupt classes"). It moved
clear_ioasic_dma_irq() from the driver into the irq-chip.
For EOI interrupts the clear_ioasic_dma_irq() callback is now invoked as
->irq_eoi() which is invoked after the IRQ was handled while the
interrupt is masked due to IRQF_ONESHOT. Without IRQF_ONESHOT it would
be invoked while interrupt is unmasked (but interrupts are disabled).

If it is *required* to invoke EOI-ack while the interrupt is masked (and
not a misunderstanding) due to irq-chip cascading/ hierarchical reasons
then using handle_fasteoi_mask_irq() as flow-handler would be the right
way to do so.

Remove IRQF_ONESHOT to irqflags.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The mentioned genirq commit is in -next.

 drivers/net/ethernet/amd/declance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/declance.c b/drivers/net/ethernet/amd/declance.c
index 8d05a0c5f2d5d..e6d56fcdc1ddd 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -813,7 +813,7 @@ static int lance_open(struct net_device *dev)
 	if (lp->dma_irq >= 0) {
 		unsigned long flags;
 
-		if (request_irq(lp->dma_irq, lance_dma_merr_int, IRQF_ONESHOT,
+		if (request_irq(lp->dma_irq, lance_dma_merr_int, 0,
 				"lance error", dev)) {
 			free_irq(dev->irq, dev);
 			printk("%s: Can't get DMA IRQ %d\n", dev->name,
-- 
2.51.0

