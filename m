Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB8517BDA;
	Tue, 22 Sep 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059987; cv=none; b=R6FNpnKwOMjyUAh+itQhWN+oQMosaFZEYv6Dlie9zyKKcJeQsA6XugMoF/pXB+EhY8ZJ/UHyTEq0UsDmZsSyOZKOsKdbNcOH9L+albuwhYfDnVQbBYqUDWJrxZqBpG7hG+1ZDIxHizeM6J6jckXyi9RZ30/ikM2pGi62U1qjgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059987; c=relaxed/simple;
	bh=qEuda0/y4EDRvcRsTTrjYZDKqDtIljEwKd5xj+Dq2Dw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wq1c7Fpptm7HebDJiRTvzqyBQ5iQ1bbIU16330eqxJCgEFI2Z1XaP+NRMzU2nLwqs+NwihtABkoCARQJF0N0zDZdRKNGL2AR8bjk9Sixy3bAQ/4aDtsFqKGwmgTHOP4xfEjwY8AGmm3iPzvAjYdkd4pRSbf9BakhJ9oLf53n+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0dn6XIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0dn6XIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F01F00898;
	Tue, 22 Sep 2026 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059985;
	bh=viY8T7Pc3XFhZ1FmFf0mrhOBOgeojY7ZJ7N8wYHm5Wg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d0dn6XIRL5Y9NUQsno6A+KlNepwcxtC4E3VKDZm+fD3Ooe18KYacf+8iavQ2n1H02
	 OUqeSNXnPOSpeG272WRxWjmN64kj5N5KFJoikQGedxw09eGfejew7wGGDDKrJOo8hu
	 3nl6OUsmpK+RLgSDnesiqs/z4i7Ae8VLg17HQ6/jjOtjSuDrCl7zrPskFvSSWYzkdr
	 i4nXqhCNDdQ0/qOL0dw7mRtg7HOJdFg+INOhJDmy9JwllOHYGKa4m3Kls4KMqJwfGv
	 y29/qogA8c6cu+y0jzDWY1b3JGSm9xcDem4vmo7jR0fWD53WfIuLPoxYlg5VidUgJi
	 0lzRA2SQsD5XQ==
Subject:
 Re: [PATCH net-next v14 7/7] r8169: add get_channel support for ethtool
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:53:04 +0000
Message-ID: <179005998439.2160803.11001186384100233406@kernel.org>
In-Reply-To: <20260918061923.313-8-javen_xu@realsil.com.cn>
References: <20260918061923.313-8-javen_xu@realsil.com.cn>
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

- [Low] rtl8169_get_channels()
  (drivers/net/ethernet/realtek/r8169_main.c:6716-6729) does not report…

--

r8169: add get_channel support for ethtool

Adds a .get_channels ethtool callback to the r8169 driver. In multi-vector
(MSI-X) mode it reports the RX and TX channel maximums and counts, and in
single-vector mode it reports one combined channel.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3be6f6e708f2..7a61c2ecc7d1 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6713,6 +6713,22 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_get_channels(struct net_device *dev,
> +				 struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +
> +	if (tp->irq_nvecs > 1) {
> +		ch->max_rx = tp->hw_supp_num_rx_queues;
> +		ch->max_tx = 1;
> +		ch->rx_count = tp->num_rx_rings;
> +		ch->tx_count = 1;

[Severity: Low]
Should this branch also report the dedicated link-change vector via
max_other/other_count?

In multi-vector mode rtl8169_request_irq() installs a separate handler on a
vector that is neither an RX nor the TX queue vector:

	if (tp->irq_nvecs > 1) {
		if (i <= R8169_MAX_RX_QUEUES)
			rc = request_irq(irq, rtl8169_interrupt_msix,
					 irqflags, dev->name, napi);
		else if (i == MSIX_ID_VEC_MAP_LINKCHG)
			rc = request_irq(irq, rtl8169_interrupt_other,
					 irqflags, dev->name, tp);

and rtl_set_irq_mask() arms that source in the same mode:

	if (tp->irq_nvecs > 1) {
		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;

Since ch is zero-initialized by the caller and channels_fill_reply() in
net/ethtool/channels.c only emits the OTHER attributes when max_other is
non-zero:

	    (channels->max_other &&
	     (nla_put_u32(skb, ETHTOOL_A_CHANNELS_OTHER_MAX,
			  channels->max_other) ||
	      nla_put_u32(skb, ETHTOOL_A_CHANNELS_OTHER_COUNT,
			  channels->other_count))) ||

ethtool -l reports no "other" channel even though that interrupt is active.
ixgbe_get_channels() reports the equivalent non-queue vector:

	/* report info for other vector */
	if (adapter->flags & IXGBE_FLAG_MSIX_ENABLED) {
		ch->max_other = NON_Q_VECTORS;
		ch->other_count = NON_Q_VECTORS;
	}

Would setting ch->max_other = ch->other_count = 1 in the tp->irq_nvecs > 1
branch be more accurate here? The single-vector branch looks fine as is,
since link-change events share the one combined interrupt.

> +	} else {
> +		ch->max_combined = 1;
> +		ch->combined_count = 1;
> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
