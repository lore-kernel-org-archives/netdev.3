Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860A40097A;
	Tue, 18 Aug 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050796; cv=none; b=moiYYFkdCcUbo0fEU3dXhotalgoj323T/24zwvdUKsnQf1NQJ8mzN3zkJWWqB3whUlJ0w3OfJLAxY8Z+OaoUGQx41JIUCFAQsyR+6CVMR0PFIglE6E5aGgsERyjvggo/eJEVbmi7zd9C4PC3CGDNJ8KSd5CfGqEdYr0AkMjcgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050796; c=relaxed/simple;
	bh=nk3Q0/4CbUmM3VaZsL5pnknhegbIcgvxtPXbCdRpGK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0y96FcLX+R7OHdA5FiyDEX1ldPzsp3QjQMd9U9XM+mJDE27q4bgGrDkIlLkwbage5Yv1n0oiiPR2jjP4iCJlX4vojHBSpmlfm3fOOU44QxE/cmNZH6zAW2Dmf04qmFojh/Hjac3IpeSWZQMerFCINe43IvT45530CFqSd3KYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eONzrHbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eONzrHbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA091F00A3A;
	Tue, 18 Aug 2026 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787050794;
	bh=BxoYDzwJ5PszCzpQ80p1n1BhXuZ9PR6H+uazntD1ZQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eONzrHbvBKMm1O+esgGgaxoHw4AtJnrw6WQohnxofeDpIOU/GwfbFAEPVhjxqxNRL
	 SFzH+OvgB5/YHC0pDYvSIZtHnN7yGj0iDqNT93GrC5FkSPwJ2QFlZB82/9YhVSDhfe
	 5tNECQoV10ExTo+aa+WORwlW6Qm5nygWIlONIp3Fcj6Ls0PSZnefwWNdYONryMsKJA
	 w7lpawq8bxpvgPMdVpn4oHADRnFo5Q7RQqXKPj0kBWl6KWZGugUmkU3vQEm8QAvE+j
	 83jT48e5xXGVraf8NFmOcym5dNeUjs7FoRDMaOCFH6tkpObKy4hW3tKi/XWZjZ/WMp
	 qZrdV0TEgJ8PQ==
From: Simon Horman <horms@kernel.org>
To: dong100@mucse.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v9 1/4] net: rnpgbe: Add interrupt handling
Date: Tue, 18 Aug 2026 11:59:43 +0100
Message-ID: <20260818105943.596059-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814111317.1741087-2-dong100@mucse.com>
References: <20260814111317.1741087-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814111317.1741087-2-dong100@mucse.com?part=1
---
--- Patch [1]: [PATCH net-next v9 1/4] net: rnpgbe: Add interrupt handling ---
commit 77ae10f5dc17ffe22f37ef80f20221f43aaa66ab
Author: Dong Yibo <dong100@mucse.com>

net: rnpgbe: Add interrupt handling

This adds the MSI-X/MSI vector and NAPI setup and teardown for the rnpgbe
driver, plus a vector 0 mailbox handler that defers work to a work item on
system_percpu_wq.  rnpgbe_open()/rnpgbe_close() are wired up to request and
release the per-queue interrupts and to bring the q-vectors up and down.

A few questions below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> new file mode 100644
> index 0000000000000..c661290d561bd
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -0,0 +1,660 @@
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
[Finding: gpt-5-6-sol-7-16]
[Sources: gpt-5-6-sol, opus-5]

Should this handler mask the fw->pf mailbox source, or otherwise retire the
request, before returning IRQ_HANDLED?

The request half of the mailbox mask is enabled once in mucse_mbx_reset():

	mbx_ctrl_wr32(mbx, MUCSE_MBX_FWPF_MASK(mbx), GENMASK_U32(31, 16));

and nothing else in the driver masks it again.  The only code that clears
the request condition is mucse_read_mbx_pf():

	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
	mucse_mbx_inc_pf_ack(hw);

At this commit the deferred work reaches only the empty
mucse_fw_irq_handler(), so fw_req != pf_ack when the hard IRQ returns and
the source is still unmasked.

If the fw->pf doorbell assertion is level-held until the ack, as is usual
for a req/ack counter doorbell, does this vector keep being re-asserted
until the core disables it as spurious?

The ack side is added later in the series by "net: rnpgbe: Add link status
handling support", where mucse_fw_irq_handler() drains events via
mucse_check_and_read_mbx().  The un-acked window in the hard IRQ handler
still covers the workqueue latency plus hw->mbx.lock contention plus
mbx->timeout_us of mailbox polling after that patch.

> +
> +static void rnpgbe_irq_disable_queues(struct mucse_q_vector *q_vector)

[ ... ]

> +/**
> + * rnpgbe_int_single - MSI-X single-vector/MSI interrupt handler
> + * @irq: interrupt number
> + * @data: private data
> + *
> + * Return: IRQ_HANDLED
> + **/
> +static irqreturn_t rnpgbe_int_single(int irq, void *data)
> +{
> +	struct mucse *mucse = (struct mucse *)data;
> +	struct mucse_q_vector *q_vector;
> +
> +	queue_work(system_percpu_wq, &mucse->mbx_work);
> +
> +	if (test_bit(__MUCSE_DOWN, &mucse->state))
> +		return IRQ_HANDLED;
> +
> +	q_vector = mucse->q_vector[0];
> +	rnpgbe_irq_disable_queues(q_vector);
> +	napi_schedule_irqoff(&q_vector->napi);
> +
> +	return IRQ_HANDLED;
> +}

[ ... ]

> +/**
> + * rnpgbe_poll - NAPI Rx polling callback
> + * @napi: structure for representing this polling device
> + * @budget: how many packets driver is allowed to clean
> + *
> + * This function is the NAPI poll callback for all interrupt modes.
> + *
> + * Return: work done in this call
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
[Finding: gpt-5-6-sol-2-8]
[Sources: gpt-5-6-sol, opus-5]

This isn't a bug, but the kernel-doc here describes @budget as "how many
packets driver is allowed to clean" and "Return: work done in this call",
while the body touches no ring and work_done is hard-coded to 0.

The actual cleaning is added later in the series by the TX and RX patches,
where rnpgbe_poll() calls rnpgbe_clean_tx_irq() and rnpgbe_clean_rx_irq().
Could the kernel-doc match the code at this step?

> +
> +/**
> + * rnpgbe_request_mbx_irq - Register mbx routine
> + * @mucse: pointer to private structure
> + *
> + * In MSIX mode, register a dedicated handler for vector 0 (mailbox)
> + * In MSI/MSI-X_SINGLE mode, mailbox is multiplexed through
> + * data tx/rx handler.
> + *
> + * Return: 0 on success, negative on failure
> + **/
> +int rnpgbe_request_mbx_irq(struct mucse *mucse)
> +{
> +	struct pci_dev *pdev = mucse->pdev;
> +	int err = 0;
> +
> +	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
> +		 "rnpgbe-mbx:%s", pci_name(pdev));
> +	INIT_WORK(&mucse->mbx_work, rnpgbe_mbx_work);
> +
> +	if (mucse->flags & M_FLAG_MSIX_EN) {
> +		err = request_irq(pci_irq_vector(pdev, 0),
> +				  rnpgbe_msix_other, 0, mucse->mbx_name,
> +				  mucse);
> +	} else {
> +		err = request_irq(pci_irq_vector(pdev, 0),
> +				  rnpgbe_int_single, 0, mucse->mbx_name,
> +				  mucse);
> +	}
> +
> +	return err;
> +}
> +
> +/**
> + * rnpgbe_free_mbx_irq - Remove mbx routine
> + * @mucse: pointer to private structure
> + **/
> +void rnpgbe_free_mbx_irq(struct mucse *mucse)
> +{
> +	struct pci_dev *pdev = mucse->pdev;
> +
> +	free_irq(pci_irq_vector(pdev, 0), mucse);
> +	cancel_work_sync(&mucse->mbx_work);
> +}

[ ... ]

> +static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
> +{

[ ... ]

> +	v_budget = pci_alloc_irq_vectors(mucse->pdev, 1, v_budget,
> +					 PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (v_budget < 0)
> +		return v_budget;

[ ... ]

> +/**
> + * rnpgbe_init_interrupt_scheme - Determine proper interrupt scheme
> + * @mucse: pointer to private structure
> + *
> + * We determine which interrupt scheme to use based on...
> + * - Hardware queue count
> + * - cpu count
> + * - interrupt mode (MSI and legacy modes use one vector)

[Severity: Low]
[Finding: main-2-6]
[Sources: opus-5]

Is there a legacy INTx mode in this driver for this comment to refer to?

rnpgbe_set_interrupt_capability() requests only PCI_IRQ_MSI | PCI_IRQ_MSIX,
and both request_irq() calls in rnpgbe_request_mbx_irq() pass flags 0 rather
than IRQF_SHARED, which would not work on a shared legacy line.  If neither
MSI nor MSI-X is available, probe simply fails.

This wording is still present at the end of the series.

> + *
> + * Return: 0 on success, negative on failure
> + **/

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 70a2b0082ba86..c3296a3dde0bb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -50,6 +68,13 @@ static int rnpgbe_open(struct net_device *netdev)
>   **/
>  static int rnpgbe_close(struct net_device *netdev)
>  {
> +	struct mucse *mucse = netdev_priv(netdev);
> +
> +	if (!rnpgbe_down(mucse))
> +		return 0;
> +
> +	rnpgbe_free_irq(mucse);
> +
>  	return 0;
>  }

[Severity: Medium]
[Finding: main-4-10]
[Sources: opus-5]

rnpgbe_close() -> rnpgbe_down() + rnpgbe_free_irq() masks and frees only the
per-queue MSI-X vectors, and the shutdown path relies on it:

rnpgbe_shutdown()
  rnpgbe_dev_shutdown()
    netif_device_detach(netdev);
    if (netif_running(netdev))
        rnpgbe_close(netdev);
    pci_disable_device(pdev);

So the vector 0 handler registered by rnpgbe_request_mbx_irq()
(rnpgbe_msix_other(), or rnpgbe_int_single() in MSI / MSI-X-single mode) is
never freed and mucse->mbx_work is never cancel_work_sync()'d on shutdown -
rnpgbe_free_mbx_irq() is reached only from rnpgbe_rm_adapter() and the probe
error path.

pci_disable_device() clears PCI_COMMAND_MASTER but does not disable MSI/MSI-X
or MMIO decoding.  Can the device still raise the mailbox interrupt after
.shutdown returns, with the handler queueing mbx_work that then performs
mailbox MMIO on a device the driver has declared dead?  This is visible
across kexec, where the machine keeps running until machine_kexec().

Should rnpgbe_dev_shutdown() call rnpgbe_free_mbx_irq() and
rnpgbe_clear_interrupt_scheme() so the shutdown path is symmetric with
rnpgbe_rm_adapter()?  The same asymmetry is still present at the end of the
series.

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index 5ba74997beacf..754016f6b4f00 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> @@ -197,3 +197,11 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
>  
>  	return 0;
>  }
> +
> +/**
> + * mucse_fw_irq_handler - Try to handle a req from hw
> + * @hw: pointer to the HW structure
> + **/
> +void mucse_fw_irq_handler(struct mucse_hw *hw)
> +{
> +}

[Severity: Low]
[Finding: gpt-5-6-sol-1-2]
[Sources: gpt-5-6-sol, opus-5]

The commit message says the patch "process[es] mailbox events from a
workqueue" and this kernel-doc says the function will "Try to handle a req
from hw", but the body is empty.

The full path

rnpgbe_msix_other()/rnpgbe_int_single()
  queue_work(system_percpu_wq, &mucse->mbx_work)
    rnpgbe_mbx_work()
      mucse_fw_irq_handler()

reads no mailbox register, decodes no event, and never performs the retire
sequence that mucse_read_mbx_pf() defines:

	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
	mucse_mbx_inc_pf_ack(hw);

At this commit a firmware request that arrives stays pending, so a later
driver-initiated transaction (mucse_fw_send_cmd_wait_resp() ->
mucse_poll_and_read_mbx()) can consume it as a bogus reply and spend one of
its three retries on the opcode mismatch.

Could the commit message and this kernel-doc say that this patch adds only
the interrupt and workqueue plumbing?  The handler body is filled in later
in the series by "net: rnpgbe: Add link status handling support".
