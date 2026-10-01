Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE23803F1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816520; cv=none; b=BfjqDewbOXPDr6d+Zj4DXPBCVQuzKKGO9ItX8BTJmXWJFfLYZMS/eaElHsJNpl3Vhbm/cI8CsPhj1oU5GmDu7boQIx0oiMxw8VEXRTvP1x8ZeMtRKlWv7F7a4K+s8tYAPXmuCiumWtl7FMj21CqRqCFaMx9CN4mUoPmnWSRPeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816520; c=relaxed/simple;
	bh=whjCLcOCqqWgUZ+XNLoTHjG9IBeMZJxrU+4Ceck6VjA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9ZejxsKzXE+C2SomvkuzudvVBRobUDh62hsj2beEbitA0G8xa2oIy/AYYrqsp4lKaIIjfd2Be5HxdOezjvnizx2Z6ywkZH/nyMNbK3rlwgvqZ8qpG/2mQtIf/Nexd8atz19dvaR6bCZ2XxbSSr3QPrBCVyis8LfgbdtCwrupUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2dTSHiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2dTSHiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD781F000FF;
	Thu,  1 Oct 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816516;
	bh=hoCUzkaewFIrpdnn36R/oKIW101daRynkUqHEncGXwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R2dTSHiYvd5NAhSTaLppjxdI65R+04T9J6epaMIJ+uylcgQXAg1Abh9A1htghBtXT
	 kP3AWx7Bcn4xWD99tSCF0mKOWzvqMlU8EYJtLMHhRWl4HhDEAPjVd6gg1/NoEHlY/p
	 SA6dy3D+Oz7vqhN0yEreWLZxKFdvqp03uqluyqImn50kybPyJDrSttc6n+Cv7a09LC
	 pHEhs2ozdmv+0X7xm7YsQ6xnQo0yALJNrNR+b6ZpDwMoSPZPtp5X5NQxE24FgpG4JK
	 K2RkVTxP/C75K2CSaWT7G1rZ4NqkZnUWuo7q8ciUGDQbB6Ky9Ir4K7zCqfBk55EODt
	 PTOhhlieJnYCw==
Subject: Re: [PATCH net v2 1/9] bnxt_en: Clear bp->total_irqs in
 bnxt_init_int_mode() during error
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Thu, 01 Oct 2026 01:01:55 +0000
Message-ID: <179081651500.434549.2620264506226250515@kernel.org>
In-Reply-To: <20260928041712.3467803-2-michael.chan@broadcom.com>
References: <20260928041712.3467803-2-michael.chan@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The bnxt_io_resume() hunk (`if (!err && !bp->irq_tbl) err =
  bnxt_init_int_mode(bp);`) fixes a defect introduced by c2d20a3814d1…

--

bnxt_en: Clear bp->total_irqs in bnxt_init_int_mode() during error

This patch clears bp->total_irqs when bnxt_init_int_mode() fails, so that
bnxt_reserve_rings() and bnxt_check_rings() do not call
bnxt_change_msix() with a NULL bp->irq_tbl. It adds bp->irq_tbl_size to
bound dynamic MSI-X growth. It also skips the second bnxt_init_int_mode()
call in bnxt_io_resume() when bnxt_reserve_rings() has already
initialized MSI-X.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d7728d0c5b6e6..51557ee6c9ade 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -17692,7 +17702,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
>  			err = bnxt_open(netdev);
>  		} else {
>  			err = bnxt_reserve_rings(bp, true);
> -			if (!err)
> +			if (!err && !bp->irq_tbl)
>  				err = bnxt_init_int_mode(bp);
>  		}
>  	}

[Severity: Low]
This isn't a bug, but should the patch also carry a Fixes tag for
c2d20a3814d1 ("bnxt_en: delay pci_alloc_irq_vectors() in the AER path")?

The patch only has:

    Fixes: e68256c8a73c ("bnxt_en: Support dynamic MSIX")

Commit c2d20a3814d1 added the unconditional bnxt_init_int_mode() call
after bnxt_reserve_rings() in bnxt_io_resume(), and it is newer than
e68256c8a73c.

The double init can happen without dynamic MSI-X:

bnxt_io_slot_reset()
    bnxt_clear_int_mode()

bnxt_io_resume()
    bnxt_reserve_rings(bp, true)
        /* BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs */
        bnxt_clear_int_mode()
        bnxt_init_int_mode()      <-- MSI-X enabled here
    bnxt_init_int_mode()
        pci_alloc_irq_vectors()
            __pci_enable_msix_range()
                WARN_ON_ONCE(dev->msix_enabled) -> -EINVAL

The second bnxt_init_int_mode() then goes to its error path. It frees
bp->irq_tbl and the vectors and returns -ENODEV, so netif_device_attach()
is never called and the device stays detached after AER recovery.

Because e68256c8a73c is older, stable selection probably already covers
every tree that has c2d20a3814d1. Trees that have e68256c8a73c but not
c2d20a3814d1 would not need this hunk, though.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928041712.3467803-1-michael.chan%40broadcom.com
