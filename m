Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE7502D4F;
	Tue, 22 Sep 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059985; cv=none; b=NSjbjQe4WI9bKs8qIcD94n05vkyrOYZIADX52FUQ+txxoQdk11znPOQPS0fqlf4WBpMNF7KcqItMe8xrW14lJ5IGORbU2q2N1T2SgrVcJfx/e/9XG9lhEJ41fxTLGrR3UKTEqHeb150NfNUBseGFSmDoih853uJxoqBFNZtUqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059985; c=relaxed/simple;
	bh=FCoDRkaRNc8fwYb0inwOS/lzIpr89kESXVOObjVAB9c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETK1+RgmeuMGRD/Y9DB1ntOmvMMasayjkdOAG19g2daiVypAUKVj10VP/6pku/te/TkaEM/uwHQet97DkgtXHKP0NNK1gOKxeswKljexYzhS8ogLxLWKPc1nfE+/M87FUT+EvmDux3XcLxqPUJA7dEiaU4rvdpoh25WzjBpLMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av6MDJs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av6MDJs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1301F000FF;
	Tue, 22 Sep 2026 06:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059984;
	bh=Voha5NuEI8plCmkReoZ3IvN9vx05nk1i/YGaHAYCobs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Av6MDJs0CXN9qGBHXkPnRMzndSFeTVLi40Wf0e9D1NEwgkB5dtm1DTcRJHtm/R4x0
	 QNE0Zp0nLjf5rkx0SoJSdHSQZkTKsSqvslkc92yPYZU1wJzl8ZYSeTU1yiVtBicyVE
	 r5I0HMHTbcU4IqyUge0TmLtZ9rz6tfR3kQhogiClEqawZ9TU5iKsQw6wCiSCmKveBd
	 SguCspovYCl5P4a2oWleBhThZ9AxrJICZaDLBJdnra0OIgyGJsMiiyewk8uS7291wR
	 16Ug6Qhi4DWLcP5v1e7aG0qs2jh1J2Dy1s+krAfeiCE+Fc2ZWSkXCxCOnrsdp2F7OP
	 4xMVGLXAIMsNA==
Subject: Re: [PATCH net-next v14 6/7] r8169: move struct ethtool_ops
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:53:03 +0000
Message-ID: <179005998308.2160803.7861967449739792413@kernel.org>
In-Reply-To: <20260918061923.313-7-javen_xu@realsil.com.cn>
References: <20260918061923.313-7-javen_xu@realsil.com.cn>
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

- [Low] drivers/net/ethernet/realtek/r8169_main.c: this patch is pure
  code motion that relocates the `rtl8169_ethtool_ops` table ~4080…

--

r8169: move struct ethtool_ops

This is pure code motion: the rtl8169_ethtool_ops table is removed from
its place right after the ethtool callback block and re-added further
down the file, between r8169_init_napi() and rtl_init_one(). The stated
reason is to allow later additions of rtl8169_get_channels and
rtl8169_set_channels to be referenced without forward declarations.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ad360f145076..3be6f6e708f2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2637,34 +2637,6 @@ static int rtl8169_nway_reset(struct net_device *dev)
>  	return phylink_ethtool_nway_reset(tp->phylink);
>  }
>  
> -static const struct ethtool_ops rtl8169_ethtool_ops = {
> -	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> -				     ETHTOOL_COALESCE_MAX_FRAMES,
> -	.get_drvinfo		= rtl8169_get_drvinfo,

[Severity: Low]
This isn't a bug, but does the commit message rationale match the rest of
the series?

The message says the move is needed "so that subsequent additions of
rtl8169_get_channels and rtl8169_set_channels can be referenced from the
ops struct without needing forward declarations".

The follow-up patch "r8169: add get_channel support for ethtool" adds only
rtl8169_get_channels(), and its body touches nothing defined after
rtl8169_nway_reset():

	static void rtl8169_get_channels(struct net_device *dev,
					 struct ethtool_channels *ch)
	{
		struct rtl8169_private *tp = netdev_priv(dev);

		if (tp->irq_nvecs > 1) {
			ch->max_rx = tp->hw_supp_num_rx_queues;
			ch->max_tx = 1;
			ch->rx_count = tp->num_rx_rings;
			ch->tx_count = 1;
		} else {
			ch->max_combined = 1;
			ch->combined_count = 1;
		}
	}

It only uses netdev_priv() and the tp->irq_nvecs, tp->hw_supp_num_rx_queues
and tp->num_rx_rings members of struct rtl8169_private, all of which are
declared far earlier in the file. Could rtl8169_get_channels() simply be
defined just above the original location of rtl8169_ethtool_ops, making this
move unnecessary and avoiding any forward declaration?

Also, rtl8169_set_channels is named as a reason for the move but is never
added anywhere in the series. Should that part of the message be dropped?

>  [ ... ]
> -	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
> -	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
> -};
> -
>  static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool gmii)
>  {
>  	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
> @@ -6741,6 +6713,34 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static const struct ethtool_ops rtl8169_ethtool_ops = {
> +	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> +				     ETHTOOL_COALESCE_MAX_FRAMES,
> +	.get_drvinfo		= rtl8169_get_drvinfo,

[Severity: Low]
The new position places the table roughly four thousand lines away from
every callback it references, between r8169_init_napi() and the PCI probe
function rtl_init_one(). Any future ethtool callback added next to the
existing callback block (rtl8169_get_drvinfo() .. rtl8169_nway_reset())
would then be the one separated from the table. Is keeping the table
adjacent to the callbacks preferable here, given the churn to git blame in
a driver that regularly takes stable backports?

> +	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
> +	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
> +};
> +
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_chip_info *chip;

Since the diff is byte-identical motion with no behaviour change, would it
help to add the customary "No functional change intended." line to the
commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
