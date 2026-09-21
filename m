Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3A3C2795;
	Mon, 21 Sep 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986049; cv=none; b=HOkgZ2kjYCguSadHuxd7Aydzpyl5sFg04ggV83G78PpyAaDNwAsIzX/4z283b2XF33ZG2h9QESHpxB0XB1DAh5sGSTbSMifV7SHT1qWsl4NmFeFGxOhR+TOBQT8lwO0lHer/V9S/kNXe9Hh0RafVvsB7Njbl4GiUwhc2CiWl0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986049; c=relaxed/simple;
	bh=6yIW566Sgu9MXGXnZ+ZTjxkX+b3TSZ2o/xBv1MtG+8w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEt9eykH/SjhxrGAhhYZO3odt6A3G1q36q6d8DthcN+yJC0bPrbH9KJCUOlzy0BJGi2SvwESRyeEezp2HGzce9REhdXMkLucqH7QIrGdvA8DsGlomr6DW3hRASL1CQipW2S5RdtwDgiFN2qtL34G7fm+R4ZAsNXn7Rb0OFuNfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jijeXv2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jijeXv2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FBD1F00899;
	Mon, 21 Sep 2026 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986045;
	bh=01NkVmRYs8J6tE1VnuHpWcnup5XWx6GruYB9hHWrpwM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jijeXv2zSTvGMRm4oAcNa37rvQ+xz04IMvAtpWPkpFMEaVELUIfyRyG+YQYv0vlM/
	 aSMsAl1owlcYBaJno6uhN7irQdWE9Xsz9zbZI5yKbyL0+NAq3bb1/zkW4yCCHablLX
	 ud3tXLoxtpKXLH/rRcK0DE6/ftOyOon99gzebxm7FGwKAIQdo4GcZxo2+xFiHlkK/7
	 T9YazMeorY2oofrNaelKO2IPxjCiu/ND6hCSLUT/p2v/ydgcpCkCHgXhwLpUh5Jxke
	 ynmhfRee6HxvHjeQYExJ0aYjgWRqSOVXcavnH9KQgT9o6raV1QjdLBQeiT9muBTzJz
	 lT/BWX6RPhdAw==
Subject: Re: [PATCH net-next v13 1/5] net: rnpgbe: Add interrupt handling
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 21 Sep 2026 10:20:44 +0000
Message-ID: <178998604412.2160803.10022829479646569445@kernel.org>
In-Reply-To: <B30243FF7D98EC69+20260920092611.345462-1-dong100@mucse.com>
References: <B30243FF7D98EC69+20260920092611.345462-1-dong100@mucse.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rnpgbe_dev_shutdown() (the .shutdown callback) now performs
  the same interrupt teardown as rnpgbe_rm_adapter() (the .remove path):…
- [Low] rnpgbe_lib.h declares 'void rnpgbe_irq_disable(struct mucse
  *mucse);' as a cross-file interface, but the only callers are inside…
- [Low] CONFIG_MGBE only 'depends on PCI', so CONFIG_MGBE=y/m is
  selectable with CONFIG_PCI_MSI=n, but after this patch the driver…
- [Low] Reported concern: nothing in the interrupt or NAPI path
  acknowledges a ring's pending interrupt cause.

--

net: rnpgbe: Add interrupt handling

This patch adds MSI-X setup and teardown for the rnpgbe driver, reserving
vector 0 for the mailbox and giving the remaining vectors to the data
path.  It also adds a mailbox work item plus the NAPI skeleton, and wires
the new interrupt scheme into open/close, probe, remove and shutdown.

A few questions below about the new code.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> new file mode 100644
> index 000000000000..9196fa130ca9
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -0,0 +1,571 @@

[ ... ]

> +static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
> +{
> +	struct mucse_ring *ring;
> +
> +	/*
> +	 * TX/RX pairs share interrupt control registers; update them through
> +	 * the TX ring list.
> +	 */
> +	mucse_for_each_ring(ring, q_vector->tx) {
> +		writel(0, ring->irq_mask);
> +
> +		/* Re-trigger hw to re-check events lost while masked. */
> +		writel(INT_VALID | TX_INT_MASK | RX_INT_MASK, ring->trig);
> +	}
> +}
> +
> +/**
> + * rnpgbe_poll - NAPI polling callback
> + * @napi: structure for representing this polling device
> + * @budget: polling budget
> + *
> + * Complete NAPI polling and re-enable queue interrupts. Ring cleaning is
> + * added when TX and RX support is enabled.
> + *
> + * Return: 0
> + **/
> +static int rnpgbe_poll(struct napi_struct *napi, int budget)
> +{
> +	struct mucse_q_vector *q_vector =
> +		container_of(napi, struct mucse_q_vector, napi);
> +	int work_done = 0;
> +
> +	/* Exit if we are called by netpoll */
> +	if (unlikely(!budget))
> +		return 0;
> +
> +	if (likely(napi_complete_done(napi, work_done)))
> +		rnpgbe_irq_enable_queues(q_vector);
> +
> +	return work_done;
> +}

[Severity: Low]
This isn't a bug as far as I can tell, but it is worth confirming the
interrupt cause handling here.

Nothing in the new interrupt path acknowledges a ring's pending cause.
rnpgbe_msix_clean_rings() only masks and schedules NAPI:

	mucse_for_each_ring(ring, q_vector->tx) {
		writel(INT_VALID, ring->trig);
		writel((RX_INT_MASK | TX_INT_MASK), ring->irq_mask);
	}

rnpgbe_poll() then processes no descriptors (work_done stays 0), so
napi_complete_done() always succeeds and rnpgbe_irq_enable_queues()
unmasks and re-writes the lost-interrupt recovery trigger.

If the trigger write asks hardware to re-evaluate a still pending cause,
would that re-assert the vector and loop irq -> NAPI -> unmask -> irq
forever?

Checking the state at this commit suggests it cannot fire: rnpgbe_reset_hw()
leaves RNPGBE_DMA_AXI_EN at 0 and this patch programs no descriptor bases,
lengths or ring starts, so the DMA engines cannot raise a completion for the
trigger to re-check.  The real ring cleaning arrives later with
rnpgbe_clean_tx_irq() in "net: rnpgbe: Add basic TX packet transmission
support" and rnpgbe_clean_rx_irq() in "net: rnpgbe: Add basic RX data path
support", and the same unconditional trigger write survives there without
spinning.

Also, rnpgbe_up_complete() arms per-ring interrupt generation for rings
whose DMA and descriptor state has never been programmed at this point in
the series - is that intentional ordering for the later patches?

[ ... ]

> +static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
> +{
> +	int v_budget;
> +
> +	v_budget = min3(mucse->num_tx_queues, mucse->num_rx_queues,
> +			MAX_Q_VECTORS);
> +	v_budget = min_t(int, v_budget, num_online_cpus());
> +	/* add one vector for mbx */
> +	v_budget += 1;
> +
> +	/* Vector 0 is reserved for mailbox events and must not share NAPI. */
> +	v_budget = pci_alloc_irq_vectors(mucse->pdev, 2, v_budget,
> +					 PCI_IRQ_MSIX);
> +	if (v_budget < 0)
> +		return v_budget;

[Severity: Low]
Should CONFIG_MGBE gain a PCI_MSI dependency now that two MSI-X vectors
are mandatory?

drivers/net/ethernet/mucse/Kconfig still has only:

	config MGBE
		tristate "Mucse(R) 1GbE PCI Express adapters support"
		depends on PCI

With CONFIG_PCI=y and CONFIG_PCI_MSI=n the driver still builds, but the
stub in include/linux/pci.h rejects this request:

	static inline int
	pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
				       unsigned int max_vecs, unsigned int flags,
				       struct irq_affinity *aff_desc)
	{
		if ((flags & PCI_IRQ_INTX) && min_vecs == 1 && dev->irq)
			return 1;
		return -ENOSPC;
	}

min_vecs is 2 and PCI_IRQ_INTX is not set, so every probe fails through
rnpgbe_init_interrupt_scheme() with "init interrupt failed -28".  The
Kconfig entry is unchanged at the end of the series, so would
"depends on PCI && PCI_MSI" match what the code now requires?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> new file mode 100644
> index 000000000000..d38c08df6b7c
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> @@ -0,0 +1,34 @@

[ ... ]

> +int rnpgbe_request_irq(struct mucse *mucse);
> +void rnpgbe_free_irq(struct mucse *mucse);
> +void rnpgbe_irq_disable(struct mucse *mucse);

[Severity: Low]
Can rnpgbe_irq_disable() be static instead?  Its only callers are the two
calls in rnpgbe_down() in the same file:

	void rnpgbe_down(struct mucse *mucse)
	{
		rnpgbe_irq_disable(mucse);
		rnpgbe_napi_disable_all(mucse);
		synchronize_net();
		rnpgbe_irq_disable(mucse);
	}

Grepping drivers/net/ethernet/mucse/ shows no caller outside
rnpgbe_lib.c, at this commit or at the end of the series.

On a related note, the same patch adds mucse_hw_rd32() to rnpgbe.h with no
caller at this commit (the new register reads use the per-ring iomem
pointers, for example readl(q_vector->tx.ring->irq_mask)).  Callers do
appear in the following patches, so that half is just an observation.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 70a2b0082ba8..debed2f3fe64 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -253,9 +298,11 @@ static void rnpgbe_rm_adapter(struct pci_dev *pdev)
>  		return;
>  	netdev = mucse->netdev;
>  	unregister_netdev(netdev);
> +	rnpgbe_free_mbx_irq(mucse);
>  	err = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
>  	if (err)
>  		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
> +	rnpgbe_clear_interrupt_scheme(mucse);
>  	free_netdev(netdev);
>  }
>  
> @@ -287,8 +334,11 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
>  	rtnl_lock();
>  	netif_device_detach(netdev);
>  	if (netif_running(netdev))
> -		rnpgbe_close(netdev);
> +		dev_close(netdev);
>  	rtnl_unlock();
> +
> +	rnpgbe_free_mbx_irq(mucse);
> +	rnpgbe_clear_interrupt_scheme(mucse);
>  	pci_disable_device(pdev);
>  }

[Severity: Medium]
What happens if .shutdown runs and the device is then unbound?  Both
rnpgbe_dev_shutdown() and rnpgbe_rm_adapter() now perform the same
teardown, and nothing records that it already ran:

	rnpgbe_free_mbx_irq(mucse);
	rnpgbe_clear_interrupt_scheme(mucse);

rnpgbe_free_mbx_irq() is unconditional:

	void rnpgbe_free_mbx_irq(struct mucse *mucse)
	{
		struct pci_dev *pdev = mucse->pdev;

		free_irq(pci_irq_vector(pdev, 0), mucse);
		cancel_work_sync(&mucse->mbx_work);
	}

After the first rnpgbe_clear_interrupt_scheme() has called
pci_free_irq_vectors(), MSI-X is disabled, so pci_irq_vector(pdev, 0)
takes the !msi_enabled && !msix_enabled path and returns pdev->irq, the
legacy INTx line.  The second free_irq() is then issued with
dev_id == mucse against a line the driver never requested, which should
produce the "Trying to free already-free IRQ" warning from __free_irq().

mucse->num_q_vectors = 0 covers the q_vector frees and the data-path
free_irq() loop, but there is no equivalent guard for the mailbox vector.

The netdev is also left registered and bound after shutdown while the
q_vectors and NAPI contexts have been destroyed - is that intended?

This looks like a narrow cold path (device_shutdown() blocks probing but
not removal, so a sysfs unbind or PCI hot-unplug racing reboot can reach
it), and the duplicated teardown is unchanged at the end of the series.
Would a flag, or dropping the teardown from the shutdown path, be
preferable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B8AF0FDE24FAFB51%2B20260920092424.345309-1-dong100%40mucse.com
