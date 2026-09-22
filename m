Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B14F4D1D;
	Tue, 22 Sep 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059982; cv=none; b=B2CWTHk7WCzVAqutpYDU7qpXnpG7l1JoxSl0+V12Y1jLaoemgt6MMLXtcQkhRfloM633lcskvlZK2MZq16wochWxgiW0cGPNC68IuHptTxNVT60fAfFYznb0Za7zYtYCowHu/UnjDILl+vHIBk627tSzKMJlxVzjI/EkMU5pBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059982; c=relaxed/simple;
	bh=cKcJsjCMZYwTVYi9NN977tHgRO+V7LPKmGCW0RV3f5s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sk69GbYqHcIIQOeACGrP73jysZ6MpWqLgWELEb3/uDmtJ7yJXU8EfZkAHr16cu4hpQjE5xDreU0p1LO4akKVXvR7H+aCPthJbC25AnvnGulQrJrU2zcjIri513A50AD60Jj/HGd2zIaILOajkpDqXdQYrhv1CQLpbej2qWNwJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWqvLXxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWqvLXxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB91F000FF;
	Tue, 22 Sep 2026 06:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059980;
	bh=xAw7GpdTk7aYivDNc645hSngXBeaqcqa3YNIfGKwCfc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KWqvLXxXyXP2LF2t9HXfFoBcHf7nhp4u/n3qml+IeSvxST/UkB8Yk0wAwZjggm2fm
	 d+4C9IlSI4MpwUrhVew1C5XPKLPJHwNXFeJt2hB7GWZbJ+uhMDvWiPymiCAQLvPBtp
	 U+Dxx6Kx+VFvm2Cp4s6iDsgWxL6C5supYbRqePZAdYAYnH2vDrtvW+NpFa60TogS2w
	 SQ2LumE66eDVMzQUczJGQseiE7YO68sG0IMvm67FP5Tn/3SYfZH3LvABQogH4c08hW
	 obHVBR/3VHt8omRBO2nTwcvpzU4JBK6oOpbAEX4lzbP/af4EtrG/rNkZ9o0FPWcAm+
	 L8HDYU9sSjKpw==
Subject:
 Re: [PATCH net-next v14 3/7] r8169: add support for new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:52:59 +0000
Message-ID: <179005997956.2160803.4635103527378782153@kernel.org>
In-Reply-To: <20260918061923.313-4-javen_xu@realsil.com.cn>
References: <20260918061923.313-4-javen_xu@realsil.com.cn>
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

- [Low] DISCARDED (series-resolved): dead code — every new `tp->irq_nvecs
  > 1` branch added by this patch is unreachable at this commit because…
- [Low] DISCARDED (series-resolved): claim that a partial MSI-X grant
  with 2 <= irq_nvecs <= 29 arms hardware sources (TOK bit 8, LINKCHG…
- [Low] rtl8169_poll_msix_tx() calls napi_complete_done()
  unconditionally, including when the core invokes the poll callback…
- [Low] The new Tx-only NAPI instance (index R8169_MAX_RX_QUEUES, poll
  routine rtl8169_poll_msix_tx()) is registered with netif_napi_add()…
- [Low] In multi-vector mode rtl8169_netpoll() invokes
  rtl8169_interrupt_msix() for every data-path NAPI slot…

--

r8169: add support for new interrupt mapping

This patch adds the new per-vector interrupt mapping registers
(IMR_CLEAR_VEC_MAP_REG, ISR_VEC_MAP_REG, IMR_SET_VEC_MAP_REG) and new
MSI-X handlers plus per-vector Rx/Tx NAPI poll routines. The old
single-vector paths are kept for the tp->irq_nvecs <= 1 case. A few
questions below about the new poll and netpoll paths.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 7a2e7ce56e48..c647b4327ff7 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5396,9 +5491,16 @@ static int rtl8169_close(struct net_device *dev)
>  static void rtl8169_netpoll(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
> +	int napi_num;
> +
> +	napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
>  
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> -		rtl8169_interrupt(0, &tp->rtl8169_napi[i]);
> +	for (int i = 0; i < napi_num; i++) {
> +		if (tp->irq_nvecs > 1)
> +			rtl8169_interrupt_msix(0, &tp->rtl8169_napi[i]);
> +		else
> +			rtl8169_interrupt(0, &tp->rtl8169_napi[i]);
> +	}
>  }

[Severity: Low]
Should this loop be bounded by tp->num_rx_rings rather than by
R8169_MAX_RX_QUEUES + 1?

In multi-vector mode this walks all nine data-path slots regardless of how
many Rx rings are actually configured. For a slot whose index is >=
tp->num_rx_rings, rtl8169_poll_msix_rx() skips rtl_rx() entirely and then
still re-arms the vector:

	if (message_id < tp->num_rx_rings)
		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
				    budget, napi);

	if (work_done < budget && napi_complete_done(napi, work_done))
		rtl8169_enable_hw_interrupt_msix(tp, message_id);

rtl_set_irq_mask() deliberately only sets the ROK bits for the active rings:

	for (int i = 0; i < tp->num_rx_rings; i++)
		tp->irq_mask |= ISRIMR_ROK_Q0 << i;

so after one netpoll pass, does the hardware mask in IMR_SET_VEC_MAP_REG end
up containing ROK bits that tp->irq_mask excludes? tp->num_rx_rings is
normally smaller than 8 (it is derived from
netif_get_num_default_rss_queues() rounded down to a power of two), while
nine NAPI instances are always created in multi-vector mode, so slots 1..8
can be inactive on a typical machine.

> @@ -5654,10 +5758,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->irq_nvecs > 1) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>  }

[ ... ]

> @@ -6203,10 +6313,63 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  	return 0;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{

[ ... ]

> +static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	/* Currently r8169 only supports a single Tx ring.
> +	 * Therefore, we don't need a per-ring Tx processing loop here.
> +	 */
> +	rtl_tx(dev, tp, budget);
> +
> +	if (napi_complete_done(napi, 0))
> +		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));
> +
> +	return 0;
> +}

[Severity: Low]
Should this call to napi_complete_done() be skipped when budget is 0?

Documentation/networking/napi.rst states:

   If the ``budget`` is 0 napi_complete_done() should never be called.

and netpoll does invoke the poll callback with a zero budget:

net/core/netpoll.c:poll_one_napi() {
	/* We explicitly pass the polling call a budget of 0 to
	 * indicate that we are clearing the Tx path only.
	 */
	work = napi->poll(napi, 0);
}

Today the effect appears to be absorbed by napi_complete_done() itself,
which returns early when NAPI_STATE_NPSVC is set (the flag poll_one_napi()
sets before the zero-budget call), so the Tx vector is not re-armed behind
the core's back. Would the documented form be preferable here:

	if (budget && napi_complete_done(napi, 0))
		rtl8169_enable_hw_interrupt_msix(tp, ...);

> +/* RTL8127 MSI-X vector layout:
> + * Vectors 0 .. (MAX_RXQ - 1)			: Rx Queues
> + * Vectors MAX_RXQ .. (MAX_RXQ + MAX_TXQ - 1)	: Tx Queues
> + * NAPI is only allocated for data path
> + */
>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> -	for (int i = 0; i < tp->irq_nvecs; i++) {
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
> +
> +	for (int i = 0; i < napi_num; i++) {
> +		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
> +
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8169_MAX_RX_QUEUES)
> +				poll_fn = rtl8169_poll_msix_rx;
> +			else
> +				poll_fn = rtl8169_poll_msix_tx;
> +		}
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);

[Severity: Low]
Would netif_napi_add_tx() be the right registration helper for the slot at
index R8169_MAX_RX_QUEUES, since rtl8169_poll_msix_tx() only calls rtl_tx()
and never touches an Rx ring?

The kernel-doc for netif_napi_add_tx() in include/linux/netdevice.h says it
"should be used from drivers using NAPI to exclusively poll a TX queue", and
netif_napi_add_tx_weight() additionally does:

	set_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state);

With plain netif_napi_add(), does this Tx-only instance end up in napi_hash[]
and advertised as busy-poll capable?

>  		netif_napi_set_irq(&tp->rtl8169_napi[i],
>  				   pci_irq_vector(tp->pci_dev, i));
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
