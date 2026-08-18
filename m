Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178A476CDD;
	Tue, 18 Aug 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058464; cv=none; b=Oo6z1J1/NzjFVoup+DdeHTAcSo2hOIUbkq8cTEAU443nZwVwceQJs/qgjnhfSGo+7YzlHDrYfT9kHehB3hDg6FnmIX+29y0xqfBlGxyQbyvcrGdRoijlISwXPNM980OguDEn/Gr08+TYOSzC7V0eh3m4cBFx196NdB/jzY3uJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058464; c=relaxed/simple;
	bh=EssqeXd5U9J+poKs+NISyUuN95jZjbFGIOEyHO6cpO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox4hq+7pxE3TonTGTmRD1PaD5LSSME1MGKKXcz6md2pZtnWMo4nUp/GFbkg86Ys+3D5DXgrO+3RHFpGr+7O9/gP+7Embb9kckWgUso98ZbSDo8xSmzHz1aXLs/qOXCXsFc0XCBkuZThLDlQrgzRdB4KKCRrkZYK/slDKn04rFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itd6t3Zu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itd6t3Zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9721F000E9;
	Tue, 18 Aug 2026 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058463;
	bh=ymjN3A5TV9tH2vf/q6v+bffQUMuHkQcoIeSyDrLpCK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Itd6t3Zupk5SGVQhH+msEcITlwXzTA+d/1y8Gb5E0QU9qbDj3j/lyRJkL3/eLSWVz
	 lQBMOJnzfXUPqKVOeekeDoAIJTFHkoOEmgo78vxeORQvgEqowibfTydnjFlAHkr7FN
	 udS5VtCcyZDMFKXjbAel2fi1r5D1EePzLOrcMaYoCThrcdYiu5vUAdl9MkTsC2XDd2
	 sLyANdbEHz8rv5qH/27ULU8TKZg+Gq/BBzKRAqj5CwvousDheLjlxiyf/N2wKZDxq/
	 OgUyrnXRHJ06m9kSpcMr2o0mecx7WJBkX6Bor6Xivp+lV00+CIud2+m2S3pKNrDCga
	 zum7IignQZBdQ==
Date: Tue, 18 Aug 2026 14:07:38 +0100
From: Simon Horman <horms@kernel.org>
To: Shivani Gupta <shivani07g@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: Re: [PATCH iwl-net] igb: Reject hwtstamp requests when PTP is
 unavailable
Message-ID: <20260818130738.GF265046@horms.kernel.org>
References: <20260815010815.91898-1-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815010815.91898-1-shivani07g@gmail.com>

On Sat, Aug 15, 2026 at 01:08:15AM +0000, Shivani Gupta wrote:

...

> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c

...

> @@ -1378,6 +1384,25 @@ void igb_ptp_init(struct igb_adapter *adapter)
>  		return;
>  	}
>  
> +	/* Initialize all state used by the PHC and timestamping paths before
> +	 * registering either interface. INIT_WORK() only initializes the work
> +	 * item; no work is queued until timestamping is enabled.
> +	 */
> +	spin_lock_init(&adapter->tmreg_lock);
> +	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> +
> +	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> +		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> +				  igb_ptp_overflow_check);
> +
> +	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
> +	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> +
> +	/* Initialize the hardware clock before ptp_clock_register() makes its
> +	 * callbacks visible. The overflow work is started after registration.
> +	 */
> +	igb_ptp_reset(adapter);
> +
>  	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
>  						&adapter->pdev->dev);
>  	if (IS_ERR(adapter->ptp_clock)) {

Hi Shivani,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/20260815010815.91898-1-shivani07g%40gmail.com

Of that review the following item stands out to me.
I would appreciate it if you could look over it in particular.

  Does this code leave the hardware interrupt unmasked if ptp_clock_register()
  fails?

  The call to igb_ptp_reset() unconditionally unmasks the Time Sync hardware
  interrupt. If ptp_clock_register() fails, adapter->ptp_clock is set to NULL,
  but the hardware state is not reverted.

  If a hardware interrupt occurs, igb_tsync_interrupt() is called:

  igb_tsync_interrupt()
      if (adapter->ptp_caps.pps)
          ptp_clock_event(adapter->ptp_clock, &event);

  Will this result in a NULL pointer dereference when adapter->ptp_clock is
  passed to ptp_clock_event()?

...
