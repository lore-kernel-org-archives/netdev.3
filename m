Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481135;
	b=3ovwPB28fTev8KdCQ/l447wOo//8xeopXCJ/xx+UdK+9Fm5zccfH2S7lvWEOBIZhfK0m
	 GNO3qckhh/vNvfuh6UvjVgDozlQ9/rNHdFrXvnoS/qfwMNiOTbXO7PPV7vYEc0DeV4V86
	 H++o5IDxzejwk2mANOwSQ5i6Vh25hAtP5xLLuyBo2GCFhxU7jeeM0Vv++2PnLJKedcCSP
	 8xfxRlMFYpDmLdIa9to8wIesNfs++o/SAbd/WGub2dez7YGpgYqY22XWiIpsVEtcIwXVQ
	 6toDKoNxZ0Qz2p402NKsjlU4uC0Bf55iucbulosSDyYSSS370z3Ns5UG7yGc1Q+UlOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481135;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ERNOCnBRL522Oa+R9uwtzVQbevy6xtbs3Tmwly40ly0=;
	b=Y8dmdlTfKJo/lg1iVULJx+yJWmT+06cyFO7zMvybl6LbBGLPhAMELMh1TkaCtRNcVu3s
	 TwO13UeBscpbJA63YEbShoPRkCUr5zPqZDNYuQfVOr6FPtBeVQWKRV2yLh2xN3afJ/j+D
	 JnJFRyz1jTPxRB8/grXwll0BP83T2w9iCgCkV9jSSpgkfCqAaXlsDYW6Ed0FQBV5mK/K/
	 YvJrtiHztH1UDnAnX7a42Tgp7IPzB2Ou/tf/oG1CMJTo3a+H87Z/GKHiCu40DBf64T4wg
	 soOlyBPW4KwzlPbxShXfiRkQ9UqkicQeldHReZoNO46SnykdTnVBKLq+qqDdBTzKJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVcVyLho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C17606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVcVyLho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4901D1F000C6;
	Tue, 20 Oct 2026 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792481134;
	bh=ERNOCnBRL522Oa+R9uwtzVQbevy6xtbs3Tmwly40ly0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jVcVyLhoyGrIkAs4qItETs5G9yOma5+uXN8P0YnTYEmuRnNDoZOM/QTsMTChEcasl
	 5ZFRV54gJIYZfQ0mDFLhc9Qczui96FXYITNR+BgoMO0gwmAtijbyTOBgCF+CyNXBKo
	 K/MBCeTb//6JM3aqvNfwVxBNcjzdlCNrictPpJEOkqGdrPLOP5C+0YS6AwD3l9xHtN
	 xegornX1xWdGvdt3cZ4Jr1vh7PMDcfbwydDujBlT3Rp0Zhm0jTGjbFIWeJvkTFYi4u
	 YlkMzLFBe0/TO2szfdgpTbj9vPBHWW4zrEwHRvFldozmqX+UvFOAPsNHzXvF6U+uvX
	 376M+2yiVrgbQ==
Subject:
 Re: [PATCH net-next v4 1/8] bnxt_en: Clear bp->total_irqs when disabling IRQs
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Date: Tue, 20 Oct 2026 07:25:33 +0000
Message-ID: <179248113377.3135.17092310026954460125@kernel.org>
In-Reply-To: <20261016064427.496944-2-michael.chan@broadcom.com>
References: <20261016064427.496944-2-michael.chan@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The NULL bp->irq_tbl dereference is still reachable on AER
  resume through bnxt_ulp_start().
- [Low] The commit message describes the new MSI-X behaviour too
  narrowly, and an in-code comment is now stale.

--

bnxt_en: Clear bp->total_irqs when disabling IRQs

This patch clears bp->total_irqs, and a new bp->irq_tbl_size, every time
bp->irq_tbl is freed. It also makes the dynamic MSI-X paths skip
adjustments when bp->irq_tbl is NULL. The dynamic MSI-X table is now
sized to the FW maximum, and bnxt_io_resume() skips a duplicate
bnxt_init_int_mode() call.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0682060b048ce..6edf998a4ba66 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -11690,6 +11699,8 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
>  
>  	kfree(bp->irq_tbl);
>  	bp->irq_tbl = NULL;
> +	bp->total_irqs = 0;
> +	bp->irq_tbl_size = 0;
>  }
>  
>  int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
> @@ -11716,7 +11727,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  
>  	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
>  		irq_change = true;
> -		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
> +		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
>  			bnxt_ulp_irq_stop(bp);
>  			bnxt_clear_int_mode(bp);
>  			irq_cleared = true;

[Severity: Low]
Is this part of the commit message accurate?

  In the AER path, if MSI-X capabilities change, bnxt_reserve_rings()
  will initialize MSI-X if BNXT_NEW_RM() is true.

bnxt_clear_int_mode() now sets bp->total_irqs to 0, and irqs_required is
never 0. So once the interrupt mode has been cleared, the two values
always differ, and the new !bp->irq_tbl check takes the clear/re-init
branch.

After bnxt_io_slot_reset()->bnxt_clear_int_mode(), the call
bnxt_io_resume()->bnxt_reserve_rings(bp, true) seems to always
re-initialize MSI-X on BNXT_NEW_RM devices. That includes a
bnxt_ulp_irq_stop()/bnxt_ulp_irq_restart() cycle, and it happens whether
or not the capabilities changed.

The same thing happens outside AER. In bnxt_hwrm_if_change(), the
fw_reset/caps_change branch does:

			/* IRQ will be initialized later in bnxt_request_irq()*/
			bnxt_clear_int_mode(bp);
		}
		rc = bnxt_cancel_reservations(bp, fw_reset);

The following __bnxt_open_nic()->bnxt_reserve_rings(bp, true) now always
allocates MSI-X and calls bnxt_ulp_irq_restart(). When IN_FW_RESET is
not set, bnxt_ulp_irq_stop() also runs a second time, after the earlier
call in bnxt_hwrm_if_change().

Could the commit message describe this behaviour? The comment in
bnxt_hwrm_if_change() is also no longer correct for BNXT_NEW_RM devices.
Could it be updated too?

[ ... ]

> @@ -17755,7 +17766,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
>  			err = bnxt_open(netdev);
>  		} else {
>  			err = bnxt_reserve_rings(bp, true);
> -			if (!err)
> +			if (!err && !bp->irq_tbl)
>  				err = bnxt_init_int_mode(bp);
>  		}
>  	}

[Severity: Medium]
Can bp->irq_tbl still be NULL here while err is 0?

bnxt_init_int_mode() returns success without allocating the table when
total_vecs is 0:

	total_vecs = bnxt_get_num_msix(bp);
	max = bnxt_get_max_func_irqs(bp);
	if (total_vecs > max)
		total_vecs = max;

	if (!total_vecs)
		return 0;

bnxt_get_max_func_irqs() is derived from max_irqs and max_nqs or
max_cp_rings. bnxt_hwrm_func_qcaps() re-reads those values from FW at
the start of bnxt_io_resume(), and nothing enforces a lower bound. Both
bnxt_reserve_rings() (the irq_cleared branch) and the bnxt_init_int_mode()
call above can return 0 in this case. The same is true on legacy RM,
where bnxt_reserve_rings() returns early.

With the netdev down, err then stays 0, and bnxt_io_resume() calls
bnxt_ulp_start(). Take a registered RDMA ULP with
BNXT_EN_FLAG_ULP_STOPPED set and a non-zero msix_requested:

bnxt_ulp_start()
    if (edev->ulp_tbl->msix_requested)
        bnxt_fill_msix_vecs(bp, edev->msix_entries);

bnxt_fill_msix_vecs() then reads bp->irq_tbl[i].vector while bp->irq_tbl
is NULL.

This patch adds a "!err && bp->irq_tbl" guard to bnxt_ulp_irq_restart()
for the same state. Should bnxt_ulp_start(), or this check in
bnxt_io_resume(), get a matching bp->irq_tbl check?

The netif_running() branch looks safe, because
bnxt_open()->bnxt_setup_int_mode() returns -ENODEV when bp->irq_tbl is
NULL.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016064427.496944-1-michael.chan%40broadcom.com
