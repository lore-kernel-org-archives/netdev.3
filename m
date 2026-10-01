Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159A40F74B;
	Thu,  1 Oct 2026 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825994; cv=none; b=CUvg8pRcQoksINuqjQjlMQ3U4S5RNacIYSIKXqzskrnXD1JUTW3nBK9q2ciwChiw6hhZMOWYTCa8SZielIVLK8BEpQAc9UzYQi1YdISWlpnmpuyZ/zksgJKsD3QPJKSVeBAbgbz4yn62oCYPAF8gXSzRmN+PyxdOn8MvGQyY8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825994; c=relaxed/simple;
	bh=PXtpxArzyY8DZBn1hAMwq3C0nFBP6i8Nu5Ht54jOAPg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOAhXzzjXUxwktsBH57tWcxqaWNFo4bHc3wdk5qqAk4AM29/5PO2BkGZriXoDDiyvPhaUgn7L4FiTvE47bgU6VwvpQ96vE2U4i7S7vmoxkRyCzO8eN4W2eRkvGU4booo8zRdztRuKaJcYtZZmluMLMs2TJxq39udiBeM/dWo43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebk56fWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebk56fWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D11F000FF;
	Thu,  1 Oct 2026 03:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790825987;
	bh=wzFUULoIC8+Lw//RdPJvnNwi9E7VG6sYWNzjrEnFdz0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ebk56fWYEBaJpAweBnVfhkO+omfJ8zRnvJ/XH/Z6IsIpvzjCWMJF2fvcfnpLCAwse
	 YDvVdUVTQYL9sG0lEEOQhlnRfUYT3Pf2zHhRU/kZOXxXrwzS8vaON8o+YSRG1r8lPB
	 85eevkVwYK3eWZOgv1mfayq1KnZZYo2uVIKAfqmu32/yqjAuDzA/Sm2s23rA7LRqDy
	 yHKy/pKsZM7jKfR3LurexQYtxtpzZTgXEv6N4JTIXkan9XOn3n9Qhlsxvg6iwgnbmy
	 fxRlebrXonsVKEsUSLOA79DLEupylS+x7DLLz+J7W+us0H0uzsnGPAa3P2dtXvguQT
	 0SyedGnRkycEA==
Subject: Re: [PATCH net-next v14 1/5] net: rnpgbe: Add interrupt handling
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 01 Oct 2026 03:39:46 +0000
Message-ID: <179082598618.434549.4975166661631840324@kernel.org>
In-Reply-To: <6DBF52290D020D66+20260928033821.1033325-1-dong100@mucse.com>
References: <6DBF52290D020D66+20260928033821.1033325-1-dong100@mucse.com>
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

- [Low] The patch changes how mucse_obtain_mbx_lock_pf()
  (drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c) waits for the mailbox…
- [Low] Three kernel-doc comments in
  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c promise more than the…

--

net: rnpgbe: Add interrupt handling

This commit adds MSI-X interrupt setup and teardown for the rnpgbe
driver. Vector 0 is reserved for the mailbox and the remaining vectors
drive NAPI for the data path. It also adds mailbox workqueue plumbing
and sends the firmware powerdown notification from both remove and
shutdown.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> new file mode 100644
> index 0000000000000..97f7aef8e3c2d
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -0,0 +1,579 @@

[ ... ]

> +/**
> + * rnpgbe_set_interrupt_capability - Set MSI-X interrupt capability
> + * @mucse: pointer to private structure
> + *
> + * Attempt to configure the interrupts using the best available
> + * capabilities of the hardware.
> + *
> + * Return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
> +{

[ ... ]

> +	/* Vector 0 is reserved for mailbox events and must not share NAPI. */
> +	v_budget = pci_alloc_irq_vectors(mucse->pdev, 2, v_budget,
> +					 PCI_IRQ_MSIX);
> +	if (v_budget < 0)
> +		return v_budget;

[ ... ]

> +/**
> + * rnpgbe_request_irq - Initialize interrupts
> + * @mucse: pointer to private structure
> + *
> + * Attempts to configure interrupts using the best available
> + * capabilities of the hardware and kernel.
> + *
> + * Return: 0 on success, negative value on failure
> + **/

[ ... ]

> +/**
> + * rnpgbe_free_irq - Free interrupts
> + * @mucse: pointer to private structure
> + *
> + * Attempts to free interrupts according initialized type.
> + **/

[Severity: Low]
This isn't a bug, but do these kernel-doc comments match what the code
does?

rnpgbe_set_interrupt_capability() says it uses "the best available
capabilities of the hardware". It only asks for MSI-X with a minimum of
two vectors, and it returns the error if that fails. There is no MSI or
INTx fallback.

rnpgbe_request_irq() makes the same claim. It only calls request_irq()
on MSI-X vectors 1..N, which are already allocated.

rnpgbe_free_irq() refers to the "initialized type", but only one
interrupt type exists.

MSI-X only looks intentional: the Kconfig change adds a PCI_MSI
dependency, and the commit message says "Require at least two MSI-X
vectors". Could these comments be updated to say MSI-X only?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> index c464086982632..2310f01df1f50 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -84,7 +84,7 @@ static u32 mucse_mbx_get_lock_pf(struct mucse_hw *hw)
>   * @hw: pointer to the HW structure
>   *
>   * Pair with mucse_release_mbx_lock_pf()
> - * This function maybe used in an irq handler.
> + * All mailbox access runs in process context.
>   *
>   * Return: 0 on success, negative errno on failure
>   **/
> @@ -93,11 +93,11 @@ static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
>  	struct mucse_mbx_info *mbx = &hw->mbx;
>  	u32 val;
>  
> -	return read_poll_timeout_atomic(mucse_mbx_get_lock_pf,
> -					val, val & MUCSE_MBX_PFU,
> -					mbx->delay_us,
> -					mbx->timeout_us,
> -					false, hw);
> +	return read_poll_timeout(mucse_mbx_get_lock_pf,
> +				 val, val & MUCSE_MBX_PFU,
> +				 mbx->delay_us,
> +				 mbx->timeout_us,
> +				 false, hw);
>  }

[Severity: Low]
This isn't a bug, but should the commit message mention this change?

mucse_obtain_mbx_lock_pf() moves from read_poll_timeout_atomic() to
read_poll_timeout(), which sleeps. Its documented contract also changes
from "maybe used in an irq handler" to process context only.
mucse_read_mbx_pf() and mucse_write_mbx_pf() both use this helper, so
every mailbox transaction is affected.

The callers seem to take mutex_lock(&hw->mbx.lock) first, so sleeping
looks safe. The commit message, though, only covers the interrupt setup,
the vector layout, the mailbox work and the powerdown notification.

Could this be called out in the changelog, or split into a separate
patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0A4D45AD9F6A0F14%2B20260928033701.1033196-1-dong100%40mucse.com
