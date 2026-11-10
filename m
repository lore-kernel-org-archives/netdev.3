Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322310;
	b=1UocXMnZv3la6BUES2P+pRx9LDES0xSTmrGZU2pb43CfXUyPIPlNJdciNim7xm9CHBh0
	 dhpYkoApjSZ4AUUmNfCdRasYq/R9NyyfTa6A+C6GOsZUhzEif307xO8kqirwn1yJiVPnG
	 b9u49W8oSBQtUNYL45iC9AoMQJFH2vboPL4aQ5T6/k0x9qayXYq2RmYBfWpWRj4SWDNcr
	 YvHYzd1dFosWWTi4/DXQK7UF+1cNMOaPEh/w/OaY6MBW4X5SunJftxQiXx9i34Paz8KyX
	 12nRd5wPKGMehXDbQ16N00Ql794++NqOeVsrj/JuEm621is0neMrkUnsvsGuTTmPtjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322310;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JBLMHOy93b+9Nvr8eqOI15BxH40j8JgNWQdFK0WAYQ4=;
	b=s89KSboKUkL9gx50eiFRA/n4o1rPB4voGwlILeOitYhh0gyMGQWRrrQaiHF/GsVmbNpW
	 1rjcEZdAeY+7m4B+AbqDjxtUutMJlPSP5dVr+54uF/xNVmlLILUVMrQI9U3CtyaN4EOkH
	 lb6cbjctE6OnT7xO5wWgJrjyGpz/5u3E7gJ3FfVABKYMqMFSwaYTGEXdtDPCgXm9VuqMl
	 mCrF+bsW80xyUVU6Fhj+gaTPZoEdoWVbkSldDXhahZ9smHzGazrpNo+K2Atr0IzK/ywNQ
	 wyiRMYhS4n0Kr1cVjV2BkBlGdsypMxXz/hN9UUKJq/7rnhNFOWw/K0az2SbLipImXjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fhx0Gybi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0F60A3815;
	Tue, 10 Nov 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fhx0Gybi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B371F008BD;
	Tue, 10 Nov 2026 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322309;
	bh=JBLMHOy93b+9Nvr8eqOI15BxH40j8JgNWQdFK0WAYQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fhx0Gybivt7x/W9nm80hLA8uOC9enaK2iisytmdqXJQBVZcHZe7Hnh83HCl9T4QBJ
	 KPnWsxdxrHIfXYNSN05m66u6KmHddnwz74MekKkDwlLBjCDtB1NJdl4SOPTRTZncpT
	 By9xOLIWjd9RQnm3zYOLbw5LVw/Y+borgtPcohfPYX/jbu7Q1jv1wzRxczBZbapSz8
	 XdWr8FRXhQ9UnlJw/ydIb1qnkj+fs4KNGQVwO5cpxyecsCyoaDqZ9JOj/8doddlR9z
	 usffncLXNScJx4mW+SR4MmKT92L4TXyP1e/4ttPuFBL61l33GbElK+dLtWckOWsEab
	 SDyEcaJQRCQeA==
Subject: Re: [PATCH v33 net-next 8/8] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:48 +0000
Message-ID: <179432230893.994134.2573901838169497544@kernel.org>
In-Reply-To: <20261106045631.2224-9-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-9-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the control PF, this patch frees the PF's own coherent
  MSI-X map table while Bus Master Enable is still set.
- [Low] The new nbl_probe() error unwind calls nbl_core_remove() and then
  pci_clear_master().
- [Low] The new comment above nbl_core_start()/nbl_core_stop() in
  nbl_core.h says start/stop are not repeatable because 'MSI-X vectors…
- [Low] The commit message justifies the new -EOPNOTSUPP check by saying
  the neither-ctrl-nor-net state is reached by binding to a function…
- [Low] The comment in nbl_dev_init_msix_cnt() says vectors are allocated
  and the handler attached 'when the device is started, after probe,…
- [Low] The err_destroy_map comment in nbl_dev_start() says the map
  entry, the bitmap bits, the kcalloc()ed vector array and 'the coherent…
- [Low] The new nbl_probe() comment says 'nbl_get_func_param() gives any
  func 0 device has_ctrl'.

--

net/nebula-matrix: add common dev start/stop operation

This patch adds nbl_dev_start() and nbl_dev_stop(), which nbl_probe() and
nbl_remove() call through nbl_core_start() and nbl_core_stop().  Start
programs the MSI-X map, fetches the VSI/ETH ids, allocates the MSI-X
vectors and arms the mailbox interrupt; stop undoes these steps.
nbl_probe() also now rejects a function that has neither the ctrl nor the
net capability.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> index c3c4dd685bf6f..655dfb43e3653 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> @@ -40,4 +40,12 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
>  				  struct nbl_init_param *param);
>  void nbl_core_remove(struct nbl_adapter *adapter);
>  
> +/*
> + * Single-shot start/stop pair, called once each from PCI probe/remove.
> + * Not repeatable: MSI-X vectors stay allocated until device detach, so
> + * a second start on a bound device is rejected by the MSI-X core.
> + */

[Severity: Low]
Is this the right reason?  nbl_dev_stop() and the nbl_dev_start() rollback
both call nbl_dev_clear_interrupt_scheme(), which does:

	pci_free_irq_vectors(common->pdev);

That frees the vectors and clears msix_enabled at stop time, not at
detach.  The commit message relies on the same thing when it explains why
the pcim_msi_release devres action is harmless.

After stop, a second pci_alloc_irq_vectors_affinity() would not be
rejected by the MSI-X core.  Should this comment give a different reason
for the pair being single-shot?

> +int nbl_core_start(struct nbl_adapter *adapter);
> +void nbl_core_stop(struct nbl_adapter *adapter);

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 01287c39a9655..c25def18a9e68 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -19,6 +30,243 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
>  	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
>  }

[Severity: Low]
This patch makes the existing comment just above, in
nbl_dev_init_msix_cnt(), out of date:

	/* Reserve one MSI-X vector for the mailbox.  Nothing here
	 * allocates or requests it: vectors are allocated and the handler
	 * attached when the device is started, after probe, from this
	 * count.
	 */

nbl_core_start() is now called at the end of nbl_probe().  That means
pci_alloc_irq_vectors_affinity() and request_irq() run inside probe,
before it returns.  Should "after probe" be updated?

[ ... ]

> @@ -301,3 +557,171 @@ void nbl_dev_remove(struct nbl_adapter *adapter)

[ ... ]

> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{

[ ... ]

> +err_destroy_map:
> +	/*
> +	 * Always ask the peer to drop this function's MSI-X map, even when
> +	 * the cfg RPC above failed: the teardown prepare phase returns 0
> +	 * for a function that is not NBL_INTR_FUNC_CONFIGURED, so it is a
> +	 * no-op when nothing landed, but a -ETIMEDOUT only means the ACK
> +	 * never arrived - the responder runs to completion before it ACKs.
> +	 * In that case the map entry, the intr_net/other_bmap bits, the
> +	 * kcalloc()ed vector array and the coherent map table are all
> +	 * still owned by the control PF, i.e. host resources of its
> +	 * driver, released only when this function is configured again or
> +	 * when nbl_intr_mgt_stop() tears the control PF down.  They are not

[Severity: Low]
Does configuring the function again really release the coherent map
table?  nbl_res_intr_cfg_msix_map() allocates the table only when
!official_tbl->base_addr, and its had_config branch says:

	 * NOTE: NO DMA table free here.
	 */
	if (had_config) {

That path releases the old bitmap bits and kfree()s the old interrupts
array.  It then rewrites the existing table in place.

The coherent table is freed only by
__nbl_res_intr_complete_destroy_msix_map(), which runs on a destroy or
from nbl_intr_mgt_stop().  Could this comment be reworded to match?  The
version in nbl_dev_stop() ("invalidates and rewrites the entry") already
describes this correctly.

> +	 * firmware state, so skipping the destroy would strand them for a
> +	 * PF that has no driver to ever ask for them again.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index a3e599f57137e..0bdc7f9940fcb 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> @@ -277,6 +286,25 @@ static int nbl_probe(struct pci_dev *pdev,
>  	int err;
>  
>  	nbl_get_func_param(pdev, id->driver_data, &param);
> +	/*
> +	 * Reject a function with neither capability before touching any
> +	 * hardware.  nbl_disp_refresh_ctrl_ops() leaves every dispatch op NULL
> +	 * for such a function, while nbl_dev_start() reaches cfg_msix_map,
> +	 * get_vsi_id, get_eth_id and (on unwind) destroy_msix_map through
> +	 * those pointers.  The state is reachable through driver_override:
> +	 * binding this driver to a function that is not in nbl_id_table (a VF,
> +	 * or a non-func-0 PF) makes pci_match_device() pass the dummy ID whose
> +	 * driver_data 0 leaves has_ctrl and has_net both clear.  A foreign

[Severity: Low]
Can a non-func-0 PF of this device reach this state?  All PFs share the
same PCI device ID, and every nbl_id_table entry sets the net bit:

	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110),
	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },

pci_match_device() returns the matching static entry before it falls back
to the dummy ID with driver_data 0.  new_id also rejects driver_data that
matches no table entry.  So sibling PFs always get has_net.  Only foreign
devices, or VFs whose IDs are not in the table, end up with neither
capability.

The commit message makes the same claim:

    driver_override: binding this driver to a function that is absent from
    nbl_id_table (a VF, or a non-func-0 PF of this device) makes

The commit message also says a foreign func 0 device is "unaffected ...
as it did before this check existed".  That is true of the check itself.
However, this same patch now runs nbl_dev_start() on such a device: MSI-X
map programming, vector allocation and mailbox IRQ arming.

Should the comment and the commit message be updated?

> +	 * device at func 0 is unaffected: nbl_get_func_param() gives any
> +	 * func 0 device has_ctrl, so it is not rejected here and still runs

[Severity: Low]
Is this description of nbl_get_func_param() accurate?  It only sets
has_ctrl when the device is not a VF:

	if ((PCI_FUNC(pdev->devfn) == 0) && !pdev->is_virtfn)
		param->caps.has_ctrl = 1;

As nbl_probe_chip_deps() notes, under ARI a VF's devfn can decode to
function 0.  A VF like that, bound through driver_override, gets neither
capability and is rejected by this check.  The code does the right thing;
only the comment is wrong.

> +	 * nbl_core_init() with the local control dispatch ops, as it did
> +	 * before this check existed.
> +	 */
> +	if (!param.caps.has_ctrl && !param.caps.has_net) {
> +		dev_err(dev, "Function has neither ctrl nor net capability\n");
> +		return -EOPNOTSUPP;
> +	}

[ ... ]

> @@ -314,8 +342,12 @@ static int nbl_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  	pci_set_drvdata(pdev, adapter);
> -
> -	return 0;
> +	err = nbl_core_start(adapter);
> +	if (err) {
> +		nbl_core_remove(adapter);
> +		pci_clear_master(pdev);
> +	}

[Severity: Low]
Should this unwind clear bus mastering before nbl_core_remove(), as
nbl_remove() does?  nbl_remove() uses the opposite order:

	pci_clear_master(pdev);

	nbl_core_remove(adapter);

Its comment says bus mastering has to be stopped before nbl_core_remove()
frees the MSI-X map tables.

I could not find a runtime effect in this unwind.  After the
nbl_dev_start() rollback, the control PF's own entry is already idle.
Sibling PFs cannot be configured yet, because nbl_probe_chip_deps() defers
them.  The mailbox rings are devres managed.  So this is mostly a
consistency issue.

The new err_destroy_map comment in nbl_dev_start() also says:

	 * Note: pci_clear_master() runs in nbl_probe() core_start_err path;

There is no core_start_err label.  This pci_clear_master() also only runs
after nbl_dev_start() has freed the table and nbl_core_remove() has
returned.  Could that comment be corrected as well?

> +	return err;
>  }
>  
>  static void nbl_remove(struct pci_dev *pdev)
> @@ -326,6 +358,7 @@ static void nbl_remove(struct pci_dev *pdev)
>  		return;
>  	pci_set_drvdata(pdev, NULL);
>  
> +	nbl_core_stop(adapter);
>  	/*
>  	 * Stop bus mastering before any teardown runs.
>  	 *

[Severity: Medium]
On the control PF, does this free the PF's own coherent MSI-X map table
while Bus Master Enable is still set?

nbl_core_stop() now runs before pci_clear_master().  On the control PF the
call chain is:

nbl_remove()
  nbl_core_stop()
    nbl_dev_stop()
      nbl_dev_destroy_msix_map()
        nbl_disp_destroy_msix_map()             /* local op */
          nbl_res_intr_destroy_msix_map()
            __nbl_res_intr_destroy_msix_map()
              /* clear valid bit, flush */
              nbl_intr_quiesce_wait()           /* usleep_range(1000, 1200) */
              __nbl_res_intr_complete_destroy_msix_map()
                dma_free_coherent(dev, msix_map_table->size, ...)

The map is programmed with the control PF's own BDF, so the pcompleter's
table fetches are bus-master reads from this same PF.

The comment above nbl_intr_quiesce_wait() says the delay "is not a
guarantee".  It relies on this for extra protection:

 * pci_clear_master() is the only other lever, and nbl_remove() pulls it
 * before any teardown runs: that keeps the device from starting a new
 * fetch inside this window.

The "Stop bus mastering before any teardown runs" comment just above no
longer holds for the control PF either.

The err_destroy_map rollback in nbl_dev_start() has the same ordering on
probe failure, because nbl_probe() calls pci_set_master() before
nbl_core_start():

	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);

This can happen, for example, when pci_alloc_irq_vectors_affinity() or
request_irq() fails after cfg_msix_map succeeded.

The commit message only says that pci_clear_master() is no safety net on a
non-control PF.  It does not mention that the control PF loses this
protection.

The control PF's stop path uses local MMIO ops and does not need bus
mastering.  When has_ctrl is set, could bus mastering be cleared before
the own-map destroy?  Alternatively, could the free of this PF's own map
be left to nbl_intr_mgt_stop(), after pci_clear_master()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
