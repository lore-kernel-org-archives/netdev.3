Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549083;
	b=ob7fOAr5vkDUCK3rZipVVbYgz8iLiXNxTsr2i9D4XQxJbK5tL7YemkHqYubYpovm3jw4
	 jnvgJyu4er5Ta85UfO7Tg5r8A/kkb3Px2tdZ5N80VPycc1sAdD+THCzYerrVa+azFG3BZ
	 Gj2yDiSe6rikAJhJ4nuGu7qV3082N5VRxNFqGGMgTtUGUoHjRllEWnDNyunQ5Svicc4Go
	 Og7Lk8jt+mKG8Ra/BjW3bHUfdhDA6n0SrEK622RRTFt5Lx01OcQLOu55UzF9d9jTOgLJH
	 SvmsHGMhY5QGZMSFOOfk6/2eajxRvzrxgyDh2CUoHPDNcfO70beM0QZAPy5sEG8wPng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549083;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R07tQz7kn6oV2V7MKV8H83hgqF5e3GIkYvn5QQvp8os=;
	b=3MYzzey8FK0egB/EPh/qtKSmFL6htM9diciNWbecF/dv3GTd/QryzFeRaZxnmFwiFQWC
	 QhsB72hcXESXPgbFxy2A+Pk35+TJx1JAVpgmCaeBuceVHzHMf6lYyZ5JJY0ASIuPi8hL8
	 dGpbi4kfzf0yn8uJbgD3Tnucx1/mwvCr3q8qMWKxuflBcLd+WjiSTn9Hkj/ymNZOad4gr
	 pUre7osOQ1aJipQniEi8i4wRqUGT8nAB6y8JYtj2Y4gRKMiB/evczqMnSFS3A0Z4BakDG
	 XHHwKQ1JM4QScr6yXkU9WU3B9u00HRcAoUb0O1/uD9nhq/X2Wf2DV+qf3Fsnt7/baBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gW7R9epk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C9606A889;
	Fri, 13 Nov 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gW7R9epk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AB11F000C6;
	Fri, 13 Nov 2026 05:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549083;
	bh=R07tQz7kn6oV2V7MKV8H83hgqF5e3GIkYvn5QQvp8os=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gW7R9epkuJTQU64jlMgBZTrWqZjhMRaCwCjvfGxts8NZF7ApSLSRqOlBxfi/xiGXT
	 Wg+TDzbYg01Ho9vSXoGu5Kf73zRvyQBTsaxQmLNgfEhWttgYaLyq8iV5B5jWFZjL66
	 unQUyCIpRAVE+Xopqd7ZU7Mwnmmht3Rbk3RaEBS52TZxMSHl8SOT1m1ur8guE5EVS6
	 OrSBnw/NH0WJjmRNQLloF0B2F2Hbi5FKzE3/KLNu2gKwwpEC1S6fBCfqLUsSQVBLi6
	 MXkEd8TKxZCA5gSRgH6PsAvYRCQbCBfdfFU+Mpa8kSgVtYBIXbSzLuUBkegQInkZTo
	 A1aE0FengMSEg==
Subject: Re: [PATCH net-next v3 3/3] net: phy: dp83tg720: report inclusive RX
 packet totals
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Fri, 13 Nov 2026 05:51:21 +0000
Message-ID: <179454908193.2199510.11384974363448482430@kernel.org>
In-Reply-To: <20261109-submit-acx00-phy-stats-v1-v3-3-fbc6327c5be4@gmail.com>
References: <20261109-submit-acx00-phy-stats-v1-v3-3-fbc6327c5be4@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch carries `Fixes: 677d895af1cc ("net: phy: dp83tg720: add
  statistics support")`, which tells AUTOSEL/stable to backport it to…

Pre-existing issues:
- [Medium] After this patch, two TI PHY drivers with the same counter
  layout map it to different uAPI attributes.

--

net: phy: dp83tg720: report inclusive RX packet totals

This commit moves the accumulated PKT_STAT_4/PKT_STAT_5 RX packet count in
dp83tg720_get_phy_stats() from rx_packets to rx_packets_total. The datasheet
says the hardware counter includes errored packets. Userspace now sees it as
RxFramesTotal instead of RxFrames in the ethtool phydev statistics group.

Link: https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf

> diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
> index 391c1d8688083..5824eff92937c 100644
> --- a/drivers/net/phy/dp83tg720.c
> +++ b/drivers/net/phy/dp83tg720.c
> @@ -309,7 +309,7 @@ static void dp83tg720_get_phy_stats(struct phy_device *phydev,
>  
>  	stats->tx_packets = priv->stats.tx_pkt_cnt;
>  	stats->tx_errors = priv->stats.tx_err_pkt_cnt;
> -	stats->rx_packets = priv->stats.rx_pkt_cnt;
> +	stats->rx_packets_total = priv->stats.rx_pkt_cnt;

[Severity: Low]
Can this be backported on its own, given the Fixes: tag?

    Fixes: 677d895af1cc ("net: phy: dp83tg720: add statistics support")

The rx_packets_total member of struct ethtool_phy_stats doesn't exist at
the baseline. It comes from the earlier patch in this series, "ethtool: add
PHY receive frame and byte totals". That patch also adds the kerneldoc, the
ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL uAPI attribute and the "RxFramesTotal"
string.

Stable tooling will pick this up for kernels that contain 677d895af1cc.
There it would either fail to build in dp83tg720_get_phy_stats() or bring
a new uAPI attribute into stable. It would also change which phydev stats
userspace sees for this PHY.

Should the Fixes: tag be dropped? Alternatively, could the commit message
state the dependency on the ethtool patch and say it isn't meant for
stable alone?

[Severity: Medium]
This isn't a bug introduced by this patch, but it creates a difference
between this driver and dp83td510.c, which still does this in
dp83td510_get_phy_stats():

drivers/net/phy/dp83td510.c:dp83td510_get_phy_stats() {
    ...
	stats->rx_packets = priv->stats.rx_pkt_cnt;
	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
    ...
}

Both drivers describe the registers the same way:

 * - DP83TD510E_PKT_STAT_4: Contains RX packet count bits [15:0].
 * - DP83TD510E_PKT_STAT_5: Contains RX packet count bits [31:16].
 * - DP83TD510E_PKT_STAT_6: Contains RX error packet count.

The update_stats code and the rx_pkt_cnt/rx_err_pkt_cnt fields are also
the same. include/linux/ethtool.h documents rx_packets as "Total
successfully received frames".

Does the DP83TD510E datasheet also define PKT_STAT_4/5 as a total that
includes errored packets? If so, dp83td510 would report RxFrames with the
same overcount this patch fixes for dp83tg720. Userspace would then see
different meanings for RxFrames depending on which TI PHY is attached.

Should dp83td510_get_phy_stats() get the same change?

>  	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4%40gmail.com
