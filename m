Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCA1A275
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637876; cv=none; b=uDDvnnOm2+SmbUR/1EXs0spfW0Brln1m3W2HpUv46PfKywmeOzTb4ZopP1Q+tSRVRDjMsoPYABMFp7BgEjm3FqzeLD3CFr3ZgELi2Rwrfa7DDfSklD3XS6IhGqIS+g+5e4UFG764RaQRsP+dtW/yTe5sHYFrQ1683wXXHztJLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637876; c=relaxed/simple;
	bh=orN910AXS87VtGG+hvzKJaXZ0AryvAyaYRPgTVqc6JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgy5TfFxroFAqiIAHmAZ5oxpcRGSFOBYN9nq6EyHoaAuJONMPjZwDNwTA/AcWMhn1083SjAM6bFXEbiufaUST4MeYtBnvnIQvRxIt98k0SVh3Baa6NLmVkraOH94lvKLjL8IIKP3M20nD+OtAgqdF2ZOOQRrlWFs3Jr6yDUXn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWoCV59/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWoCV59/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B1D1F000E9;
	Tue, 21 Jul 2026 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637875;
	bh=pwA3UFYZor+N1ArmTxmdikFz22XbtbK7MIR4NPacbYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aWoCV59/86PAXOUlrpyzpQj6+gjLZ/bSFXrM0ox2pB9RVnUDrUyR0wV2FZCU6Xqni
	 UPxo/+RPRehqpmwYUUs8JLd+72GfctUg6GfVK1NWuxIBQKZEtcixJiDmdK6QAQP0gv
	 bBd+KgeWuFsMCtaL9TW6NWlVwOq9lSx7HRXLXl9YqW9PD4cC79Z4RgcQtZQ3cgAj4H
	 8ZCvV55biZNGOLpLAcXKjXnnlu7ZmxRzm1IdWPV6F2jJOz7/vFDwB7P54tWiWFZeds
	 OkiDLSspJCJ1w8KzJCq54bIhIVXxApC0MtL2IzP1MeWfoRz96xLY/bx/p3efrsQiZ0
	 je+gTjfGIVmww==
Date: Tue, 21 Jul 2026 13:44:30 +0100
From: Simon Horman <horms@kernel.org>
To: mohammad heib <mheib@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH iwl-next v2 1/2] i40e: move ATR sample rate from ring to
 PF level
Message-ID: <20260721124430.GH19108@horms.kernel.org>
References: <20260701093830.948756-1-mheib@redhat.com>
 <20260708143601.1491656-1-horms@kernel.org>
 <acb60edf-0be5-4719-8f13-00cdbd1bb491@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acb60edf-0be5-4719-8f13-00cdbd1bb491@redhat.com>

Hi Mohammad,

Likewise, thanks for your response.

On Mon, Jul 20, 2026 at 02:36:52PM +0300, mohammad heib wrote:
> Hi Simon
> Thank you for the review.
> 
> On 7/8/26 5:36 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > i40e: move ATR sample rate from ring to PF level
> > 
> > This commit moves the ATR sample rate configuration from the per-ring level
> > to the PF level. It initializes the sample rate globally during software init
> > and updates the fast path to reference the PF structure.
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > index a04683004a567..4d4d4b07a0f3a 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > [ ... ]
> > > @@ -3454,12 +3454,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
> > >   		ring->xsk_pool = i40e_xsk_pool(ring);
> > >   	/* some ATR related tx ring init */
> > > -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> > > -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
> > > -		ring->atr_count = 0;
> > > -	} else {
> > > -		ring->atr_sample_rate = 0;
> > > -	}
> > > +	ring->atr_count = 0;
> > 
> > [Severity: High]
> > Does removing this per-ring initialization remove the protection against
> > dynamic ethtool flag toggles?
> > 
> > Previously, if the ring was configured while Flow Director ATR was disabled,
> > the ring's sample rate was cached to 0 in i40e_configure_tx_ring(). This
> > prevented descriptor injection even if the PF flag was later toggled on
> > without a ring reset.
> > 
> 
> The per-ring zeroing of atr_sample_rate was redundant. i40e_atr() already
> checks I40E_FLAG_FD_ATR_ENA before it ever looks at atr_sample_rate:
> 
>  /* make sure ATR is enabled */
>   if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
>       return;
> 
>   if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
>       return;
> 
>   /* if sampling is disabled do nothing */
>   if (!pf->atr_sample_rate)
>       return;
> 
> 
> When ATR is disabled via ethtool private flags, the function bails out at
> the I40E_FLAG_FD_ATR_ENA check regardless of what atr_sample_rate is set to.
> The flag check is the real protection the per-ring sample rate cache was
> never the thing providing protection against dynamic toggling.

Thanks for the response and sorry for the false-positive.
I agree we can discard this concern.

> > [ ... ]
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > index 894f2d06d39d0..b36e0fc9b31d2 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > [ ... ]
> > > @@ -2879,7 +2879,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
> > >   		return;
> > >   	/* if sampling is disabled do nothing */
> > > -	if (!tx_ring->atr_sample_rate)
> > > +	if (!pf->atr_sample_rate)
> > >   		return;
> > 
> > [Severity: High]
> > Can this global check lead to a hardware Malicious Driver Detection (MDD)
> > event if ethtool flags are modified dynamically?
> > 
> > If an administrator performs the following sequence:
> > 
> > 1. Disables flow-director-atr via ethtool.
> > 2. Disables ntuple (which resets the ring and sets tx_ctx.fd_ena = 0).
> > 3. Re-enables flow-director-atr.
> > 
> > The final step does not trigger a ring reset, so fd_ena remains 0 in the
> > hardware queue context.
> > 
> > However, I40E_FLAG_FD_ATR_ENA is now true, and pf->atr_sample_rate is
> > globally set to a non-zero value.
> > 
> > Will i40e_atr() now proceed and inject FDIR descriptors into a TX queue
> > that is not configured for FDIR?
> > 
> > If so, does this cause the hardware to trigger an MDD event and hang the
> > TX queue?
> > 
> The scenario you described was already broken before this patch, walking
> through the old code with the same sequence:
> 
>   1. Disable ATR — flag cleared, __I40E_FD_ATR_AUTO_DISABLED set
>   2. Disable ntuple — ring reset happens, i40e_configure_tx_ring() runs with
> ATR off, so ring->atr_sample_rate = 0 and fd_ena = 0
>   3. Re-enable ATR — flag set, no ring reset
> 
> In the old code, ring->atr_sample_rate is stuck at 0 from step 2, so
> i40e_atr() bails out at the sample rate check. That avoids the fd_ena
> problem, but ATR is also silently non-functional
>   — the user re-enabled it but it doesn't actually work until something
> triggers a ring reset.
> 
> This patch changes how that failure looks, instead of silently doing
> nothing, pf->atr_sample_rate is non-zero so i40e_atr() would proceed but the
> root cause is the same:
> toggling ATR via ethtool private flags doesn't trigger a ring reset, so
> fd_ena can be stale.
> 
> Properly fixing this would mean triggering a reset when ATR is re-enabled.
> The reset calls i40e_configure_tx_ring(), which re-evaluates fd_ena based on
> the current flag state so fd_ena would be set to 1 since
> I40E_FLAG_FD_ATR_ENA is now on.
> 
> What do you think about addressing this as a follow-up patch on top of this
> series? Since it's a pre-existing issue, it feels like it belongs as a
> separate fix rather than being mixed into this refactor.

Thanks for the detailed analysis, much appreciated.
I agree we can leave this to be addressed by a follow-up.

