Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99C4A5C22;
	Thu,  1 Oct 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870811; cv=none; b=UmwRKpDB83iTbl9VTdt9gHCycQaXktnagqklscnAvGFOMfwWYNgzw+TNNO6XZ6N01Co2kqN9/EBR+rBC/eagJr4K7T7NMuislwMvJswh7FRIldAoH8h0Md+C3ndP/kKItL4TPVm/jaflBb/Lnm60SyuLQfs/YfWAY7PiSIVGs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870811; c=relaxed/simple;
	bh=EkHuKE8CA46E9DdpWc1pbdzaw+/tbKDxvzOTHYD3jI0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0eFlqJr1RJK3borWsbtkxSnBTCZ/7621D84wKbXqWVd9UbGFk6EoGLg0Ungw6hmA4XCM6FyH/PeUUjUf01n0UFRn6fO8WVaKs1RYVaoo7adifJiVntta69xURBAjCb7Rl8Q4tvUWz3OjIHAhqcMA3wG5l14GZLd4gfZTzV/TZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISAv+fiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISAv+fiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB2E1F008A4;
	Thu,  1 Oct 2026 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870809;
	bh=XNMi4FCqOUc5Odwi2a+9CZ1nfiJksM2zL8OgZR/vKtM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ISAv+fiJTdqmobPkxp3bQmRlEHt9+rE7e8evCyoXIt5o+n7ltebLmHvLsYOu30yf9
	 UIl9v5XkCIBdDGZO5FftK5StJRvuYmlVMKgWb5f8geKinlTMNBOWSQWoBPKplPU80e
	 GCbRbTcI1r8ConvPyoGqCBKMv7wcNwE4QwAWicfiyYW1dulbMNak1X8HYk/a6d6MgB
	 6SEvThpme4v7g0hzGM6pUBl3i8GTKZ+RsPT4EBOHARhEIxgRcYDBl4uWWhBMd1ZVmv
	 BhkH0hZ4dDX8c5UMCTO9Pulgb2XYQME5z7xj/P/0JSxffWY0tLZj0BaxHx7Ir1qjun
	 qZw/Nb8Jmr67g==
Subject:
 Re: [PATCH net-next v15 7/7] r8169: add get_channel support for ethtool
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 16:06:48 +0000
Message-ID: <179087080860.434549.13883296553537764574@kernel.org>
In-Reply-To: <20260928070423.202-8-javen_xu@realsil.com.cn>
References: <20260928070423.202-8-javen_xu@realsil.com.cn>
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

- [Low] In MSI-X mode (tp->irq_nvecs > 1, RTL_GIGA_MAC_VER_80 with at
  least 30 vectors), link-change interrupts go to their own vector,…
- [Low] The commit message of the preceding patch, "r8169: move struct
  ethtool_ops", says the ops struct was moved so that 'subsequent…

--

r8169: add get_channel support for ethtool

This commit adds an ethtool get_channels callback to r8169. In
multi-vector mode it reports RX and TX channel counts. Otherwise it
reports a single combined channel.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index dad0947bcc9e7..c32f993c1aaab 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6734,6 +6734,22 @@ static void r8169_init_napi(struct rtl8169_private *tp)
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
Should this branch also report the link-change vector as an "other"
channel?

In MSI-X mode the link-change interrupt has its own vector, which
rtl8169_request_irq() requests with a separate handler:

drivers/net/ethernet/realtek/r8169_main.c:rtl8169_request_irq() {
    ...
			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
				rc = request_irq(irq, rtl8169_interrupt_other,
						 irqflags, dev->name, tp);
    ...
}

rtl_set_irq_mask() also enables ISRIMR_LINKCHG in this mode. Since
max_other and other_count are left at zero, "ethtool -l" reports 0
other channels while a dedicated misc vector is in use.

igb, igc and ixgbe (NON_Q_VECTORS) and iavf (NONQ_VECS) report this kind
of vector as max_other = other_count = 1. This patch is the first to
expose the channels UAPI for r8169, so changing these values later would
be visible to userspace.

Would it make sense to set ch->max_other = 1 and ch->other_count = 1
here?

> +	} else {
> +		ch->max_combined = 1;
> +		ch->combined_count = 1;
> +	}
> +}
> +
>  static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> @@ -6752,6 +6768,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.nway_reset		= rtl8169_nway_reset,
>  	.get_eee		= rtl8169_get_eee,
>  	.set_eee		= rtl8169_set_eee,
> +	.get_channels		= rtl8169_get_channels,

[Severity: Low]
This isn't a bug, but the preceding patch in this series, "r8169: move
struct ethtool_ops", says:

    The patch moves the rtl8169_ethtool_ops definition further down in
    r8169_main.c so that subsequent additions of rtl8169_get_channels and
    rtl8169_set_channels can be referenced from the ops struct without
    needing forward declarations.

This is the last patch in the series, and it only adds .get_channels. No
rtl8169_set_channels exists in the driver at the end of the series. The
RX ring count is still fixed once in rtl8169_set_rx_ring_num():

	tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
						    tp->hw_supp_num_rx_queues));

Was set_channels dropped from the series? If so, should the commit
message of "r8169: move struct ethtool_ops" be updated?

>  	.get_link_ksettings	= rtl8169_get_link_ksettings,
>  	.set_link_ksettings	= rtl8169_set_link_ksettings,
>  	.get_ringparam		= rtl8169_get_ringparam,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928070423.202-1-javen_xu%40realsil.com.cn
