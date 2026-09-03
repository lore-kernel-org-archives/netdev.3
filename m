Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22250C28F;
	Thu,  3 Sep 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468155; cv=none; b=uULXNYboH5b10RLW4qcBmiJViaK09U4hkU/Lb6UO21oBhEZ0XvUbobxEWswCsnd00gTz2Qi2VnTfNB2iVoxghC2v50q2Wa7B+5r+8+MRl1q+7cLNlBLmsgziTwQXotZjZoSXveFB09wMBD6oppC2dligdtJFufPltr7QWyYTUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468155; c=relaxed/simple;
	bh=GVd8Iy/H18JBf/7HKyrxgWxglNOxkHMbCo0lgYNyMbk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMSXY+iFLzUl/IaDlRWV2iP/id6LfusRJchCsXIMM2X/M4NkwmkHAckRMfpEcW7n/+/UXOqrGJKXNYO/OgPD6c9MqTgWob9/x5AsUjPdaaNbfvTVaYCpZU5lzVr5Wob7TR9tDNrHne/rd7muUMdyIg5S0GoMvYhGGcGQhDxeHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTx9C/VK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTx9C/VK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3681F00ACA;
	Thu,  3 Sep 2026 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468128;
	bh=R/ICcvEgsR7nCa4HQJQeOOquuFPufd/ZR1tavR5ybiw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gTx9C/VKgRoE5cVu6Nt+1vCiBAYsod+msYlM1ZeWkThijrtfh+j9FcKYIGUvi2i/Y
	 OhOA8vtZ0f+l0856FmJjTyp9pmzebyn1Hmwc+coEQ9/PY/fo2dCX+SShtVo0W4ZxoQ
	 BhJm57WXRfazdi3/sjV7E8qYIHAlC1Qvo1JBCcoLEEqpC5ebfQfBQWcUUVQH5VScdk
	 U9gpG4uVnrm3sryMFHpYMt097h1ZrjYdsCavWS5Hjr5ndIoascb3nTjkmO10w8Xnwn
	 Jw2kaydv26QBuAd9KeIaKvNpTqIp3jyCVlIsxlW0lJAN8RwMdPwQPNJeJZgeIULvSR
	 aW4jv8beRBffw==
Subject: Re: [net-next,v12,7/7] r8169: add get_channel support for ethtool
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 20:42:07 +0000
Message-ID: <178846812735.3394541.11906532448427871629@kernel.org>
In-Reply-To: <20260831053940.620-8-javen_xu@realsil.com.cn>
References: <20260831053940.620-8-javen_xu@realsil.com.cn>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] rtl8169_get_channels()
  (drivers/net/ethernet/realtek/r8169_main.c:6305-6315) unconditionally…
- [Low] rtl8169_get_channels() sets ch->max_rx =
  tp->hw_supp_num_rx_queues…
- [Low] rtl8169_get_channels() hardcodes ch->max_tx = 1 and ch->tx_count
  = 1 (drivers/net/ethernet/realtek/r8169_main.c:6311 and 6314) instead…

--

r8169: add get_channel support for ethtool

This adds a rtl8169_get_channels() callback to rtl8169_ethtool_ops so that
ethtool -l reports the RX/TX channel layout of the device. The reported
values come from tp->hw_supp_num_rx_queues and tp->num_rx_rings for RX, and
from literal 1 for TX. No .set_channels callback is added.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 11fb31223f492..a76fbf1e50d11 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6302,6 +6302,18 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_get_channels(struct net_device *dev,
> +				 struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +
> +	ch->max_rx = tp->hw_supp_num_rx_queues;

[Severity: Low]
Is hw_supp_num_rx_queues the right value to advertise as the maximum here?

rtl_setup_rx_params() sets it purely from mac_version, before any interrupt
vectors are allocated:

	case RTL_GIGA_MAC_VER_80:
		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;

The number of RX rings the driver will actually arm is decided later, in
rtl8169_set_rx_ring_num():

	if (tp->irq_nvecs >= get_min_irq_nvecs(tp)) {
		unsigned int rss_queue_num = netif_get_num_default_rss_queues();

		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
							    tp->hw_supp_num_rx_queues));

and rtl_alloc_irq() can fall back to a single vector:

	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp),
				      get_max_irq_nvecs(tp), flags);

	if (nvecs < 0)
		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

In that fallback case num_rx_rings stays 1 for the lifetime of the device,
yet ethtool -l reports a maximum of 8. Counts that are not a power of two
are also not usable in principle, since rtl_set_rss_config() and
rtl8125_set_rx_q_num() both use ilog2(tp->num_rx_rings).

Would it be better to bound the advertised maximum by what the driver can
actually arm, for example rounddown_pow_of_two(min(hw_supp_num_rx_queues,
RX vectors derivable from tp->irq_nvecs))? This matters more once a
.set_channels callback is layered on top, because the ethtool core validates
requested counts against max_rx and would accept counts the hardware paths
cannot use.

> +	ch->max_tx = 1;
> +
> +	ch->rx_count = tp->num_rx_rings;
> +	ch->tx_count = 1;

[Severity: Low]
This isn't a bug, but could max_tx and tx_count use R8169_MAX_TX_QUEUES (and
dev->real_num_tx_queues) instead of the literal 1?

The netdev itself is sized from the constant in rtl_init_one():

	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
				      R8169_MAX_TX_QUEUES,
				      R8169_MAX_RX_QUEUES);

The values agree today, so nothing is wrong now. If R8169_MAX_TX_QUEUES is
bumped when multi-TX-queue support lands, would this report keep claiming a
single TX channel while the netdev has more?

> +}

[Severity: Medium]
Should the single-interrupt configuration be reported as one combined
channel rather than as one dedicated RX plus one dedicated TX channel?

max_combined and combined_count are left at 0 here, while max_rx/rx_count
and max_tx/tx_count are always populated. For every chip other than
RTL_GIGA_MAC_VER_80 (and for VER_80 whenever rtl_alloc_irq() falls back to
pci_alloc_irq_vectors(pdev, 1, 1, flags)) there is exactly one IRQ and one
NAPI instance, and it services both directions:

rtl_set_irq_mask()
	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;

r8169_init_napi() installs rtl8169_poll() in that case, which does:

	rtl_tx(dev, tp, budget);

	/* rtl8169_poll() is used only when there is a single RX ring. */
	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);

The uAPI kernel-doc describes max_combined as a "Set of queues RX, TX or
other", and ethtool(8) defines a channel as an IRQ plus the set of queues
that can trigger it. By that definition the single-vector case looks like
one combined channel, so does ethtool -l tell userspace that two
independently steerable channels exist where only one shared channel does?

The split rx/tx model appears accurate only for the RTL8127 MSI-X case,
where vectors below R8169_MAX_RX_QUEUES run rtl8169_poll_msix_rx() and the
rest run rtl8169_poll_msix_tx(). Since this is a newly exposed read-only
ABI value, changing the classification later, when .set_channels is added,
would change what userspace already sees. Could the commit message explain
the reasoning behind the chosen model?

> +
>  static const struct ethtool_ops rtl8169_ethtool_ops = {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053940.620-1-javen_xu%40realsil.com.cn
