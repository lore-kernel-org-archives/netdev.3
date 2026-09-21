Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C4498927;
	Mon, 21 Sep 2026 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026344; cv=none; b=ZzXO7guRiaHD8fxHqNCAjCBnXOKSCy62qeCXdQfGOqIcPGNSt7qr8PJsEtZcFhk610t42M+QWSjRo0YFd9N7Q9Cw0iyeqy/yfOEIJbxauviISHgcAQd2PzC69H9dv7Hwda2DCMb415n4MBt++scASZzRn4aVf6C7wilaTffwtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026344; c=relaxed/simple;
	bh=Dq+ZiV8yC6XPvU4laMxjMLT5KJsAKgGLuybKf5PfAIE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BR2fDF6mMulosRQJzFgKDOQuaTt5yyVLRtWcOv8cVeiMDBTDFM8KdJW8pp7L8ZRcd4ATtvcqbsG8K/Gb2Z/PnQ8be2VMPQ+H/GE6vC0rghwZM6BaPx5eDeYy/e1BU1r0HEtr1ZEIvNjW4qrPmyV9J5HOTRDykwqNbbvlxZg6K+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlYF3quP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlYF3quP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6401F00893;
	Mon, 21 Sep 2026 21:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026343;
	bh=9Kykn/vdLSNFnNt06nhOkQ3J63m7cDWbgC1S520Okfw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VlYF3quPlznDzvtEWLYhufk/bS9qCQN/Upx6DVf7jtaClABkyLo14zeOQ7iQ3Vhwf
	 VE4qrZt1CafwOMiaeqgSGIG5s7Hh4Hg/n2FzczY5qzMS1/620icLBaBa0uoZ2GYqbN
	 YPO35LdU8WxVmo/I67G42wWfo87vSW8apbxdTNc8UxLAkz7ugyyZ0Z3+ZPQdq75ICW
	 vegYMnWDaRf3YLLvH6xt5Ew3Y6GeAyAkfVpXaxVdpD/OVb/Os1I5LSdN7lZcLT6ZWs
	 7TubhALAttpwTeTpwB5JktnSczVvvBsOjc+dZfEDugbK4dzn7VeuHj1u3+mAYxI8Pd
	 KUDzVqSaQ1nrQ==
Subject: Re: [PATCH net-next 2/3] i40e: add devlink parameter for Flow
 Director ATR sample rate
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mheib@redhat.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 21:32:21 +0000
Message-ID: <179002634197.2160803.3910890717187021181@kernel.org>
In-Reply-To: <20260917204541.3072415-3-anthony.l.nguyen@intel.com>
References: <20260917204541.3072415-3-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new devlink `atr_sample_rate` setter
  (drivers/net/ethernet/intel/i40e/i40e_devlink.c:36-46) makes the value…
- [Medium] The new documentation
  (Documentation/networking/devlink/i40e.rst, lines 54-59) states that…
- [Low] In the new documentation entry the lines 'Setting to ``0``
  disables ATR sampling (no filters will be programmed)' and 'The…

--

i40e: add devlink parameter for Flow Director ATR sample rate

This adds a runtime devlink parameter, atr_sample_rate, that lets the
Flow Director ATR sampling interval be changed without rebuilding the
driver.  The value is stored in pf->atr_sample_rate and read by the Tx
path, and a new entry documents it in the i40e devlink documentation.

> diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
> index 51c887f0dc833..2cea98b631baa 100644
> --- a/Documentation/networking/devlink/i40e.rst
> +++ b/Documentation/networking/devlink/i40e.rst
> @@ -40,6 +40,26 @@ Parameters
>  
>          The default value is ``0`` (internal calculation is used).
>  
> +.. list-table:: Driver specific parameters implemented
> +    :widths: 5 5 90
> +
> +    * - Name
> +      - Mode
> +      - Description

[Severity: Low]
This isn't a bug, but the third column here is labelled Description while
the generic parameter table above it in the same file uses Notes.  Was the
difference intended?

> +    * - ``atr_sample_rate``
> +      - runtime
> +      - Controls how frequently Flow Director ATR updates flow steering
> +        information for active TCP flows.
> +
> +        ATR programs Flow Director entries based on sampled transmitted
> +        packets. The sampling interval is specified as the number of
> +        transmitted packets between ATR updates.
> +
> +        Lower values increase Flow Director programming activity, while
> +        higher values reduce the update frequency.

[Severity: Medium]
Is "the number of transmitted packets between ATR updates" the unit the
code actually implements?  Three details in i40e_atr() seem to differ.

The counter compared against the configured value is per Tx ring, not
per device:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
	...
	tx_ring->atr_count++;

	/* sample on all syn/fin/rst packets or once every atr sample rate */
	if (!th->fin &&
	    !th->syn &&
	    !th->rst &&
	    (tx_ring->atr_count < sample_rate))
		return;
	...
}

atr_count lives in struct i40e_ring, so on an N-queue device the
aggregate programming rate is up to N times what a device-wide packet
interval would suggest.  Given the commit message mentions "systems with
a large number of queues", should the documentation say the interval is
per Tx queue?

The increment is also only reached for TCP after the IP version and
protocol checks:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
	...
	if (l4_proto != IPPROTO_TCP)
		return;
	...
}

so non-TCP transmitted packets never advance the interval.

Finally, the threshold is bypassed for SYN, FIN and RST, so raising the
value does not reduce programming activity for connection-churn
workloads.  Should the text mention that exception?

> +
> +        Setting to ``0`` disables ATR sampling (no filters will be programmed)
> +        The default value is ``20``.

[Severity: Low]
These two lines have no blank line between them and the first one has no
terminating period, so reStructuredText joins them into a single
paragraph and renders as "... (no filters will be programmed) The default
value is 20.".  The max_mac_per_vf entry just above puts a blank line
before its "The default value is ..." sentence.

>  
>  Info versions
>  =============
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index 229179ccc1319..6df7eb217073d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>  	return 0;
>  }
>  
> +static int i40e_atr_sample_rate_set(struct devlink *devlink,
> +				    u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf = devlink_priv(devlink);
> +	u32 sample_rate = ctx->val.vu32;
> +
> +	WRITE_ONCE(pf->atr_sample_rate, sample_rate);
> +	return 0;
> +}

[Severity: Medium]
Setting the value to 0 is now reachable at runtime while
I40E_FLAG_FD_ATR_ENA stays set.  Does this leave already programmed ATR
entries resident in the Flow Director table with no way to remove them?

In i40e_atr() the zero-rate return happens before the FIN/RST handling
and before the descriptor build that emits the remove command:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
	...
	/* if sampling is disabled do nothing */
	sample_rate = READ_ONCE(pf->atr_sample_rate);
	if (!sample_rate)
		return;
	...
	dtype_cmd |= (th->fin || th->rst) ?
		     (I40E_FILTER_PROGRAM_DESC_PCMD_REMOVE <<
		      I40E_TXD_FLTR_QW1_PCMD_SHIFT) :
	...
}

That PCMD_REMOVE descriptor is the only software removal path, and it is
only redundant when hardware eviction is available:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
	...
	if (test_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags)) {
		/* HW ATR eviction will take care of removing filters on FIN
		 * and RST packets.
		 */
	...
}

I40E_FLAG_HW_ATR_EVICT_ENA is only set in i40e_sw_init() when
pf->hw.caps has I40E_HW_CAP_ATR_EVICT, and it can also be cleared by the
hw-atr-eviction ethtool private flag.  On such a device, after any TCP
traffic has programmed ATR filters, a

  devlink dev param set pci/<bdf> name atr_sample_rate value 0 cmode runtime

appears to leave those entries steering received packets for flows that
have since closed, while fd_atr_cnt and i40e_get_current_atr_cnt() still
report ATR as active.

The existing way to turn ATR off via the flow-director-atr private flag
does the teardown explicitly:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:i40e_set_priv_flags() {
	...
	/* Flush current ATR settings if ATR was disabled */
	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
	    !test_bit(I40E_FLAG_FD_ATR_ENA, new_flags)) {
		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
	}
	...
}

Should the devlink setter do the same when the new rate is 0, or should
0 be rejected by a validate callback instead?  Note the later patch in
the series that triggers a PF reset when re-enabling ATR via ethtool only
touches i40e_set_priv_flags(), so it does not add this flush.

> +
> +static int i40e_atr_sample_rate_get(struct devlink *devlink,

[ ... ]

>  static const struct devlink_param i40e_dl_params[] = {

[ ... ]

> +	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
> +			     "atr_sample_rate",
> +			     DEVLINK_PARAM_TYPE_U32,
> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> +			     i40e_atr_sample_rate_get,
> +			     i40e_atr_sample_rate_set,
> +			     NULL),
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204541.3072415-1-anthony.l.nguyen%40intel.com
