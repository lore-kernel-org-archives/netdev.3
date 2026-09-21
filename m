Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782551477D;
	Mon, 21 Sep 2026 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026343; cv=none; b=PgWBlyVsaZ8jyzK5tB7TaytSNthvN8h9f3h4dlZzWboAgbcyH78gDq93/UUAlDumV2p0gEO3mv8Y2+IKJHPkYMk4sWd/6txBbt5Nfmt6dW49fIOrGMIlTRZ/YW91VURlvjDr0MdUXWMg0976JQKQ1mf7ge+dWwCdBK1RKd6Rjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026343; c=relaxed/simple;
	bh=nj7/loD5kK6wN8ZAxacG6WZUOLGqZeQ1K8/Zypurjv0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JS4HSQbOpQZrZV0iOgL2nLkv+0KweQ7ThkK0K9b48Z6eD5hzRc3m8y4I+cWijoGenh/p0wCCxP3eyahR8DcsRdCwhSfBKtuZkoc53aZJV79Zlj2/kn9EjKDAAqd7D80mC37a2HiWo3Snr2PL6r+J1q7pV4FPRbZERlisiXB8XCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5gEi17J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5gEi17J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3121F000FF;
	Mon, 21 Sep 2026 21:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026341;
	bh=Gv598snNBg2ytzaXtEccRuibUzHZZ7MBdyIQlWn+2uQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G5gEi17JEOgo8O0CmhAm/xVs6ovLnHsjbVL5G4M4zO11OdgrW6wM2b8YAyye4Jpy8
	 DDtjlZnRD9vJ6oP0YJc0ZJm1vwwH5PwlgN74mNjkD8oGy1gGU+MGMS9/yiOeBACnGt
	 3x4ThFpB56c3baHtW7pIMc+WoDuYII/NI2faM9LIdsgNjorOSLKdLamObvt87DxXLB
	 pT3Nl9X8OlVia54rnVfMc+L9TeLI7hKCq7wl/c0vPdY4t3OmzzyXXOlmcab3zPAPGR
	 iv4ngwwSLk0uEI4JyY+zJrctMVSk5V0rJHhEReB1GRk5xpKBVEyzSmx53wwvXYhIgf
	 pHuOt28pZL4Zg==
Subject:
 Re: [PATCH net-next 1/3] i40e: move ATR sample rate from ring to PF level
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mheib@redhat.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 21:32:20 +0000
Message-ID: <179002634029.2160803.4618287131417011270@kernel.org>
In-Reply-To: <20260917204541.3072415-2-anthony.l.nguyen@intel.com>
References: <20260917204541.3072415-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Concern (discarded on baseline verification): removing the per-
  ring atr_sample_rate decoupled the software ATR gate from…
- [Medium] Undisclosed user-visible behaviour change: "i40e: move ATR
  sample rate from ring to PF level" is written as a pure storage…

--

i40e: move ATR sample rate from ring to PF level

This moves atr_sample_rate out of struct i40e_ring and into struct i40e_pf,
initializing it once in i40e_sw_init() instead of in i40e_configure_tx_ring().
i40e_atr() now reads the PF-level value, and ring->atr_count grows from u8 to
u32.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index abbc71e815ae3..0a4272e1ab070 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3458,12 +3458,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>  		ring->xsk_pool = i40e_xsk_pool(ring);
>  
>  	/* some ATR related tx ring init */
> -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> -		ring->atr_count = 0;
> -	} else {
> -		ring->atr_sample_rate = 0;
> -	}
> +	ring->atr_count = 0;

[Severity: Medium]
The commit message describes this as a storage relocation: "Since the sample
rate is a global policy that applies uniformly across all rings, it makes more
sense to store it at the PF level."  Does dropping this conditional also change
when the writable "flow-director-atr" private flag takes effect?

Before this patch, the per-ring rate was latched from I40E_FLAG_FD_ATR_ENA at
the time the Tx ring was configured, and i40e_atr() bailed out on
!tx_ring->atr_sample_rate.  i40e_set_priv_flags() does not add
I40E_FLAG_FD_ATR_ENA to reset_needed and only handles the disable direction:

	/* Flush current ATR settings if ATR was disabled */
	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
	    !test_bit(I40E_FLAG_FD_ATR_ENA, new_flags)) {
		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
	}

So on a live interface whose rings were configured while ATR was off,
"ethtool --set-priv-flags ethX flow-director-atr on" did not resume sampling
until an ifdown/ifup or a PF reset.  With the PF-level rate now always
non-zero, the flag alone re-enables descriptor generation immediately.

Could the commit message mention this user-visible semantic change, and should
it carry a Fixes tag if the old latching behaviour was considered a bug?

[ ... ]

> @@ -12740,6 +12735,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
>  		}
>  	}
>  
> +	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> +
>  	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
>  	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
>  		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);

[Severity: High]
This assignment is unconditional and happens before the Flow Director
capability detection below it.  Can that decouple the software ATR gate from
the Flow Director enable bit programmed into the Tx queue context?

i40e_configure_tx_ring() still snapshots the flags into the HMC context:

	if (test_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags) ||
	    test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
		tx_ctx.fd_ena = 1;

The matching software snapshot (ring->atr_sample_rate) is what this patch
removes, so after toggling "flow-director-atr" on without a reconfiguration,
i40e_atr() would pass the new gate:

	sample_rate = READ_ONCE(pf->atr_sample_rate);
	if (!sample_rate)
		return;

and go on to write an I40E_TX_DESC_DTYPE_FILTER_PROG descriptor and advance
tx_ring->next_to_use on a queue whose context was programmed with fd_ena = 0.
Would that produce an MDD event or bogus FD programming status on that queue?

For completeness, the later patch in this series, "i40e: trigger PF reset when
re-enabling ATR via ethtool", adds a reset on the enable transition in
i40e_set_priv_flags(), which re-programs the queue contexts and addresses this
for the series as a whole.  It does leave a window between
bitmap_copy(pf->flags, new_flags) and i40e_do_reset(), and it means this
intermediate commit alone is not bisect-clean in that respect.  Would it make
sense to fold the reset change into this patch, or to order it first?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 7f68adb5109b0..e045f9c71c944 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2882,7 +2883,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>  		return;
>  
>  	/* if sampling is disabled do nothing */
> -	if (!tx_ring->atr_sample_rate)
> +	sample_rate = READ_ONCE(pf->atr_sample_rate);
> +	if (!sample_rate)
>  		return;
>  
>  	/* Currently only IPv4/IPv6 with TCP is supported */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204541.3072415-1-anthony.l.nguyen%40intel.com
