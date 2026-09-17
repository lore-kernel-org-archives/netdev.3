Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5463CB;
	Thu, 17 Sep 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608754; cv=none; b=NKmciQxqq7XvLd0xOzViRkdpSHlhjWwSa5stWMWlFx2RIrAvkmHUnU8KtiY2VQ+KU3OuI2ij6L6zV/YsX/bY0xZv/pZWEq64n6927inirxazuU4SGBKehrPTDB/JGjvtEYQaQ5/nvLA4x4Ac59GgwMrzRNhVPSK1+NTm91W4ZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608754; c=relaxed/simple;
	bh=G+qBXCvQL+c5sRP2HJLqto2cXsxHOLuSQbbrSHEhCsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1Qza9tp6SHuJGP3ojs3szeUH5ZSYXcWyrP0TaS3mNWltNSw6HiePxsprfEB/BwgktiyPjRMv8HDUBpNabSwGw6iXhfZLkNElSb+iQbkvbehTcjihrGZ+rbW6dAyOPii9gDDEe9Z4CFgMknDC5dz1raVvNRLP07TKRfw5vPYM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc4gmFOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc4gmFOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8741F000FF;
	Thu, 17 Sep 2026 01:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608750;
	bh=k3mmFRDttR8CDNL89kTHChCsPCL77J3Nxv8V/z7ywrE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oc4gmFOdfR/oBPWwVQLREG474lR6KaTUXXB4IwdtGvlJ1dl1Efi3P1yTOoSoAT0MY
	 PquxMjKMdyR/R4g4YB9ZE9nu1AVt7Gtv+Jr99BEyxOh7ab71ChadcLEY8R2f4qiVdN
	 Wba5Mc8geH8qCYqBoT1LaUkBoCIUhyIkK/FOEfDYPLrogBmIkKmrCuhO+RJa6IuEpA
	 TXGNNpxjfBKgNU3MYkYVTCtm3tlsKXRWpdf3crYSawlUeKAF7MsmsfpH92BqDzHEVW
	 Icd2JH4IzdysuCUmMmP61Zs6LZZT3z2CTCBYOeY+PYETRnfY1oVtf1D4HDDP1k4mWw
	 bfBc0pyO3Vhag==
Subject: Re: [PATCH net-next v12 1/5] net: rnpgbe: Add interrupt handling
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 17 Sep 2026 01:32:28 +0000
Message-ID: <178960874888.22033.2901381818679585179@kernel.org>
In-Reply-To: <37173FE7EA2160B1+20260914013201.2262568-1-dong100@mucse.com>
References: <37173FE7EA2160B1+20260914013201.2262568-1-dong100@mucse.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] In this patch rnpgbe_poll() re-enables the per-queue interrupt
  registers after napi_complete_done() has already cleared…
- [Medium] In this patch the mailbox MSI-X vector 0 is enabled and
  requested (rnpgbe_request_mbx_irq()), but nothing consumes or…
- [Low] Two new kernel-doc blocks in
  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c describe behaviour the…

--

net: rnpgbe: Add interrupt handling

This adds MSI-X setup and teardown for rnpgbe, reserving vector 0 for the
mailbox and using the remaining vectors for the data path.  Mailbox
interrupts are deferred to a workqueue and data-path interrupts schedule
NAPI.  A few questions about the new code below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> new file mode 100644
> index 0000000000000..d4a27b2ad5c12
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +
> +#include "rnpgbe_lib.h"
> +#include "rnpgbe.h"
> +#include "rnpgbe_mbx_fw.h"
> +
> +static void rnpgbe_mbx_work(struct work_struct *work)
> +{
> +	struct mucse *mucse = container_of(work, struct mucse, mbx_work);
> +
> +	mucse_fw_irq_handler(&mucse->hw);
> +}
> +
> +/**
> + * rnpgbe_msix_other - Other irq handler
> + * @irq: interrupt number
> + * @data: private data
> + *
> + * Return: IRQ_HANDLED
> + **/
> +static irqreturn_t rnpgbe_msix_other(int irq, void *data)
> +{
> +	struct mucse *mucse = (struct mucse *)data;
> +
> +	queue_work(system_percpu_wq, &mucse->mbx_work);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Where does the mailbox cause get acknowledged in this patch?

rnpgbe_msix_other() does no MMIO at all, returns IRQ_HANDLED, and only
queues mbx_work.  rnpgbe_mbx_work() then calls mucse_fw_irq_handler(),
which this same patch adds as an empty function in rnpgbe_mbx_fw.c.

mucse_mbx_reset() programs the FW->PF mask register with
GENMASK_U32(31, 16), so the FW request bits stay unmasked:

	mbx_ctrl_wr32(mbx, MUCSE_MBX_FWPF_MASK(mbx), GENMASK_U32(31, 16));

If firmware does raise an FW->PF request, nothing reads the SHM window and
nothing increments the PF ack counter, so hw->mbx.fw_req can drift out of
sync with hardware, and since the handler always claims the interrupt
without masking or clearing the cause, the spurious interrupt detector
would never be able to shut it down.

For the record, the later patch "net: rnpgbe: Add link status handling
support" fills mucse_fw_irq_handler() in with mucse_fw_handle_event() ->
mucse_check_and_read_mbx() -> mucse_read_mbx_pf(), which does update
hw->mbx.fw_req and acks via mucse_mbx_inc_pf_ack(), so on the final series
state there is no unacknowledged cause.  Within this patch the stub is
documented scaffolding, and command replies during probe are drained by the
process-context mucse_poll_and_read_mbx() path.

Given that, could the changelog sentence "Mailbox interrupts defer firmware
processing to a workqueue" be reworded, since the deferred handler added
here does nothing yet?

[ ... ]

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
> +	if (likely(napi_complete_done(napi, work_done))) {
> +		if (!test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
> +			rnpgbe_irq_enable_queues(q_vector);
> +	}
> +
> +	return work_done;
> +}

[Severity: High]
Can rnpgbe_irq_enable_queues() here run after the device has been taken
down?

napi_complete_done() already clears NAPI_STATE_SCHED before the register
writes happen, and napi_disable() only waits for that bit, so the poll body
can still be running after rnpgbe_down() returns:

CPU0 (rnpgbe_poll)			CPU1 (rnpgbe_down)
napi_complete_done()			  /* SCHED cleared */
test_bit(__MUCSE_DOWN) == 0
					test_and_set_bit(__MUCSE_DOWN)
					rnpgbe_napi_disable_all()
					rnpgbe_irq_disable()
					/* returns, ndo_stop frees irqs */
rnpgbe_irq_enable_queues(q_vector)
  writel(0, ring->irq_mask);
  writel(INT_VALID | TX_INT_MASK | RX_INT_MASK, ring->trig);

That leaves the ring interrupts unmasked after rnpgbe_free_irq().  In
rnpgbe_dev_shutdown() there is no synchronize_net() between rnpgbe_close()
and rnpgbe_clear_interrupt_scheme(), which does netif_napi_del() and
kfree(q_vector), so the same in-flight poll body can dereference
q_vector->mucse->state and q_vector->tx.ring after the q_vector was freed.

This does get closed later in the series: from "net: rnpgbe: Add RX packet
reception support" onwards rnpgbe_down() becomes rnpgbe_irq_disable();
rnpgbe_napi_disable_all(); synchronize_net(); rnpgbe_irq_disable();, which
masks before napi_disable() and fences the in-flight poll body.  Would it
make sense to have that ordering already in this patch?

[ ... ]

> +/**
> + * rnpgbe_set_num_queues - Allocate queues for device, feature dependent
> + * @mucse: pointer to private structure
> + *
> + * Determine tx/rx queue counts
> + **/
> +static void rnpgbe_set_num_queues(struct mucse *mucse)
> +{
> +	/* start from 1 queue */
> +	mucse->num_tx_queues = 1;
> +	mucse->num_rx_queues = 1;
> +}

[Severity: Low]
This isn't a bug, but the kernel-doc for rnpgbe_set_num_queues() says
"Allocate queues for device, feature dependent" while the body allocates
nothing and unconditionally assigns 1 to both counters.

The same applies to rnpgbe_init_interrupt_scheme(), whose kernel-doc says
the scheme is determined from "Hardware queue count" and "cpu count":

 * We determine which interrupt scheme to use based on...
 * - Hardware queue count
 * - cpu count

With the fixed 1/1 counts, the min3()/min_t() in
rnpgbe_set_interrupt_capability() always clamps to a single data vector, so
neither input has any effect.  Could these comments be trimmed to describe
what the code currently does?

[ ... ]

> +/**
> + * rnpgbe_irq_disable - Mask off interrupt generation on the NIC
> + * @mucse: board private structure
> + **/
> +void rnpgbe_irq_disable(struct mucse *mucse)
> +{
> +	struct pci_dev *pdev = mucse->pdev;
> +
> +	for (int i = 0; i < mucse->num_q_vectors; i++) {
> +		rnpgbe_irq_disable_queues(mucse->q_vector[i]);
> +		synchronize_irq(pci_irq_vector(pdev, i + 1));
> +	}
> +}

[Severity: Low]
This isn't a bug either, but the kernel-doc claims this masks interrupt
generation on the NIC, while the loop only covers the data-path vectors
pci_irq_vector(pdev, i + 1).  Vector 0, the mailbox interrupt registered by
rnpgbe_request_mbx_irq() in this same patch, is neither masked nor
synchronized here, and rnpgbe_down() is the path ndo_stop relies on to
declare the device quiesced.  Would something like "Mask off queue
interrupt generation" match the code better?

> +
> +static void rnpgbe_napi_enable_all(struct mucse *mucse)
> +{
> +	for (int i = 0; i < mucse->num_q_vectors; i++)
> +		napi_enable(&mucse->q_vector[i]->napi);
> +}
> +
> +static void rnpgbe_napi_disable_all(struct mucse *mucse)
> +{
> +	for (int i = 0; i < mucse->num_q_vectors; i++)
> +		napi_disable(&mucse->q_vector[i]->napi);
> +}
> +
> +bool rnpgbe_down(struct mucse *mucse)
> +{
> +	if (test_and_set_bit(__MUCSE_DOWN, &mucse->state))
> +		return false;
> +
> +	rnpgbe_napi_disable_all(mucse);
> +	rnpgbe_irq_disable(mucse);
> +
> +	return true;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index 5ba74997beacf..e28f3193aa854 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> @@ -197,3 +197,14 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
>  
>  	return 0;
>  }
> +
> +/**
> + * mucse_fw_irq_handler - Deferred firmware mailbox notification hook
> + * @hw: pointer to the HW structure
> + *
> + * No asynchronous firmware events are enabled until link status support is
> + * added.
> + **/
> +void mucse_fw_irq_handler(struct mucse_hw *hw)
> +{
> +}

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 70a2b0082ba86..22280d4ca8a08 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -289,6 +339,9 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
>  	if (netif_running(netdev))
>  		rnpgbe_close(netdev);
>  	rtnl_unlock();
> +
> +	rnpgbe_free_mbx_irq(mucse);
> +	rnpgbe_clear_interrupt_scheme(mucse);
>  	pci_disable_device(pdev);
>  }

[Severity: High]
This is the free path referenced above: rnpgbe_clear_interrupt_scheme()
calls rnpgbe_free_q_vectors() -> netif_napi_del() + kfree(q_vector) right
after rnpgbe_close(), with no grace period in between, so a poll body that
is still past napi_complete_done() would touch freed memory.

Thanks for considering these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/64BE41C2D2C0836A%2B20260914013019.2262317-1-dong100%40mucse.com
