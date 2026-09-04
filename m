Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9C51FCA5;
	Fri,  4 Sep 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560725; cv=none; b=IugNmGqb0zCZ0EKKGwaV28D6iL+IA4rw0tD4csxmf7wkZPq0b5BR4HOAfzC4GG0/mzx1DYAM10U3Q3Lc7p3d6+Hji9McikK2QPT2P1K2vjaGEjx52CqrBCIwswp1NvxxHyMVUI83t94Rm+XmQfOLiuaqxOGjQ2ncVjaR6+XjsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560725; c=relaxed/simple;
	bh=ezWQ0yzRqeGLmloEsAks2XHUl0OR91UaAnmJ4MRwB10=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LXKzNXu6tndYs5EqV3ZNFFjjGcFfpeUbiKj/F5ysnP1LBBOAj/NXxmpd751eDlcV+5YbUqWPzPA5bA3guDHBu2yfbv8oaFPveuB3Vk8KdCN3AzwCAsPYOCD7ry5HiD/bhJ1zwckAyDbTsMZd3Piop4ddnv+NH3jLV6hYqT1z4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw8zB6zw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw8zB6zw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AF01F00A3D;
	Fri,  4 Sep 2026 22:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560716;
	bh=5SnnQCQ7yDdLHAiFM1uq+omxM8NKPbzf/DSxftTkKac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lw8zB6zwW1OfhF9Vj55x6YIxth4LdzxeuLw0ggRIV4PayxMIP/w9xSz4sElNlScfN
	 kaFOUtwNDEsqClnHHedRgAMYcAvFAYW3J1xEDiMNdlyERH1MMS98U5WlnMur4cmMss
	 YQ+O8f50QUKAflbbAi6QbwXlGqOavj/o0+CkfxiehqXMKDMt0Rexzy9oYtv0iAsxc2
	 HwCE1oKOqbt2pYDfykRhfhHS4izmQzJ2eExmCFUSydigLNMN+/s49UVBQp2YUAwF5j
	 ySO5EYodoOEQevAz8FOTgFEvoJiIs81uHiJkWxNkZ7fEIpg9yacpbrdfUqm1BIS0t/
	 Vk99DFwEt/8Jg==
Subject: Re: [PATCH net-next v9 1/7] r8169: add speed in private struct
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Fri, 04 Sep 2026 22:25:15 +0000
Message-ID: <178856071535.219967.13765117065982749067@kernel.org>
In-Reply-To: <20260831053745.1197-2-javen_xu@realsil.com.cn>
References: <20260831053745.1197-2-javen_xu@realsil.com.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Claimed stale-cache regression: the patch converts
  rtl_coalesce_info() (r8169_main.c:2076,2080) and…

--

r8169: add speed in private struct

This adds an int speed field to struct rtl8169_private, initializes it to
SPEED_UNKNOWN in rtl_init_one() and updates it from r8169_phylink_handler().
The consumers rtl_link_chg_patch(), rtl_coalesce_info() and
r8169_get_tx_lpi_timer_us() are switched from tp->phydev->speed to the new
cached value.

No Link: tags in the commit header.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..c60710f9bd21 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -750,6 +750,7 @@ struct rtl8169_private {
>  	u32 irq_mask;
>  	int irq;
>  	struct clk *clk;
> +	int speed;
>  
>  	struct {
>  		DECLARE_BITMAP(flags, RTL_FLAG_MAX);

[ ... ]

> @@ -2074,11 +2073,11 @@ rtl_coalesce_info(struct rtl8169_private *tp)
>  		ci = rtl_coalesce_info_8168_8136;
>  
>  	/* if speed is unknown assume highest one */
> -	if (tp->phydev->speed == SPEED_UNKNOWN)
> +	if (tp->speed == SPEED_UNKNOWN)
>  		return ci;
>  
>  	for (; ci->speed; ci++) {
> -		if (tp->phydev->speed == ci->speed)
> +		if (tp->speed == ci->speed)
>  			return ci;
>  	}
>  
> @@ -2236,7 +2235,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
>  
>  static unsigned int r8169_get_tx_lpi_timer_us(struct rtl8169_private *tp)
>  {
> -	unsigned int speed = tp->phydev->speed;
> +	unsigned int speed = tp->speed;
>  	unsigned int timer = tp->tx_lpi_timer;
>  
>  	if (!timer || speed == SPEED_UNKNOWN)
> @@ -4968,8 +4967,9 @@ static void r8169_phylink_handler(struct net_device *ndev)
>  	struct rtl8169_private *tp = netdev_priv(ndev);
>  	struct device *d = tp_to_dev(tp);
>  
> +	tp->speed = tp->phydev->speed;

[Severity: Low]
This isn't a bug, but the v3 entry in the changelog below the --- line says:

  Changes in v3:
   - update tp->speed in rtl8169_set_link_ksettings()

That hunk does not appear in this diff. After this patch the only runtime
writer of tp->speed is r8169_phylink_handler(), while the SFP branch of
rtl8169_set_link_ksettings() still writes phydev->speed directly and
reprograms the SerDes without touching tp->speed:

	if (!phy_check_valid(speed, duplex, phydev->supported))
		return -EINVAL;

	mutex_lock(&phydev->lock);

	phydev->autoneg = AUTONEG_DISABLE;
	phydev->speed = speed;
	phydev->duplex = duplex;

	rtl_sfp_init(tp);

	mutex_unlock(&phydev->lock);

Should the changelog entry be dropped, or was the intended
rtl8169_set_link_ksettings() update accidentally lost in a rebase?

Following the two converted consumers, the divergence does not look
observable today. tp->sfp_mode is only assigned inside
if (rtl_is_8125(tp)) in rtl_init_one(), and both rtl_get_coalesce() and
rtl_set_coalesce() start with:

	if (rtl_is_8125(tp))
		return -EOPNOTSUPP;

so rtl_coalesce_info() cannot be reached on the chips that take the SFP
write path. The SFP branch is also gated by phy_check_valid() against
phydev->supported, and rtlgen_sfp_get_features() in
drivers/net/phy/realtek/realtek_main.c only sets
ETHTOOL_LINK_MODE_10000baseT_Full_BIT, so no other speed can be forced
there, and r8169_get_tx_lpi_timer_us() keeps seeing the real link rate that
rtlgen_sfp_read_status() decodes from RTL_PHYSR.

The construct is also replaced later in this series by "r8169: add support
for phylink", where rtl8169_set_link_ksettings() only calls
phylink_ethtool_ksettings_set() and tp->speed is written from
rtl_mac_link_up() and rtl_mac_link_down(), so only the changelog/diff
mismatch remains.

>  	if (netif_carrier_ok(ndev)) {
> -		rtl_link_chg_patch(tp);
> +		rtl_link_chg_patch(tp, tp->speed);
>  		rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
>  		pm_request_resume(d);
>  	} else {
> @@ -5667,6 +5667,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  				     ext_xid_str, xid);
>  	tp->mac_version = chip->mac_version;
>  	tp->fw_name = chip->fw_name;
> +	tp->speed = SPEED_UNKNOWN;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831053745.1197-1-javen_xu%40realsil.com.cn
