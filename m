Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3D3F1660
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009566; cv=none; b=OgZEzzBVMY1vh/+D6s47vG+1ERP1SrMIHK32rke3Qc5QnH/tLsydo3ixigRGKNlhhBQRU5XnqQ43mVnV8Qc8ec2vh3o+ZF2v6mqCt1UQyALFfD79EkwmtGYtOomI42SVcJogkN8egMX8hU+VpXEKdZqTWvkU9gGUHZ39lhAEQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009566; c=relaxed/simple;
	bh=Rk9VQorUAq019gqa1IJlREK6LcuCp93xX4GuGZIODQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFQCCZ+a55qhU5XZljFIsXnE9DV67DdNrSoLEzMJN4aRLSsT1hpXsk1RTSdXDkQQBMqqpzf0R6agQgpRyCC1xE0xamVc2fGEY73KyH5955MQ9Gt0dmPJMe/26rY83JyTHBJs1mNIGlIKZg6K4TzaWebJ/YSmxzq0zUXW8U/0CSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPb1CScS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPb1CScS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23011F000E9;
	Mon, 17 Aug 2026 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009565;
	bh=0TqzAzG02t/l4mw5JeJALuv18GaqEqOSdBIC9D4dv1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPb1CScSjC64H87u8zYogHUo/Xny63Y7EtCi2bF2XkX/9draCACWzNrnyCtosetng
	 1Uvp930xvJOyOlN8PVpBH5Plhs6upCf3si+d5CLOuATqhyQwW1tjAdygq5WTT3OBXS
	 oKlRMJgOLVUVgnUQoMIGbvoNLCvAjf5ZMG8MNXP2XyOIUYMOOG0/k5X4eHZSqWkvgi
	 ifAg+9cxCAl/f4FAzsbXkF5vWT5DyJ3/vVwp9Bl12JYw+0fzsC39jjy9LP6R5ciial
	 HauKFWb4pTDgS9UpMBf4pIXTDtXnQwEgzG3I43sX8JYhtwZalXyXqyr0H8uGcj6nTB
	 9ftfdz5PscsHw==
From: Jakub Kicinski <kuba@kernel.org>
To: aslan.jnn@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Date: Mon, 17 Aug 2026 16:32:43 -0700
Message-ID: <20260817233243.3733000-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812091616.35811-1-aslan.jnn@gmail.com>
References: <20260812091616.35811-1-aslan.jnn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "If AI is right about other error frame types it may be
better to program them all in one commit to avoid a behavior change
if someone needs the other bad frames later"
---
net: amd-xgbe: support receiving packets with bad FCS

The driver unconditionally set MAC_RCR.DCRCC when enabling RX, so frames
with a bad FCS were always accepted without any user control.  This patch
advertises NETIF_F_RXALL, leaves it off by default, and programs DCRCC
from the feature state in xgbe_set_features() and xgbe_enable_rx().

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 2de974213090c..cbae3d7ef9836 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -3400,7 +3400,8 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
>  	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
>  
>  	/* Enable MAC Rx */
> -	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
> +	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC,
> +			   !!(pdata->netdev->features & NETIF_F_RXALL));
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);

[Severity: Medium]
Can the DCRCC state programmed here disagree with the one programmed by
xgbe_set_features()?  Two different state sources are now used for the
same bit: xgbe_enable_rx() reads pdata->netdev->features, while
xgbe_set_features() uses its own features argument and records the result
in pdata->netdev_features.

The core only commits the new feature word after ndo_set_features()
returns:

net/core/dev.c:__netdev_update_features() {
	...
	if (dev->netdev_ops->ndo_set_features)
		err = dev->netdev_ops->ndo_set_features(dev, features);
	...
	dev->features = features;
	...
}

and xgbe_enable_rx()/xgbe_disable_rx() are also reached without RTNL from
the service work:

xgbe_service()
  phy_if.phy_status()
    xgbe_phy_link_status()
      xgbe_phy_start_data_path()
        hw_if->enable_rx()   /* xgbe_enable_rx() */

So if a link transition is processed while ethtool -K ethX rx-all on is
running, xgbe_enable_rx() reads the old netdev->features and writes DCRCC
back to the previous value.  Since the next request is compared against
pdata->netdev_features:

	if ((features & NETIF_F_RXALL) != rxall)

wouldn't the mismatch persist, with ethtool reporting one state and the
MAC doing the other?  Would keeping the requested DCRCC state in
pdata (updated under the same serialization as the register write) avoid
the two sources of truth?

Also, both paths perform unlocked read-modify-write cycles on MAC_RCR
through XGMAC_IOWRITE_BITS().  Can the write-back from xgbe_set_features()
clear the RE/CST/ACS bits that the service work just set in
xgbe_enable_rx(), leaving reception off until the next link event?

> @@ -3411,7 +3412,6 @@ static void xgbe_disable_rx(struct xgbe_prv_data *pdata)
>  	unsigned int i;
>  
>  	/* Disable MAC Rx */
> -	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 0);
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 2d6d00e3689ba..cea49a1153ac5 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1980,13 +1980,14 @@ static int xgbe_set_features(struct net_device *netdev,
>  {
>  	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>  	struct xgbe_hw_if *hw_if = &pdata->hw_if;
> -	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter;
> +	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter, rxall;
>  	int ret = 0;
>  
>  	rxhash = pdata->netdev_features & NETIF_F_RXHASH;

[ ... ]

> +	rxall = pdata->netdev_features & NETIF_F_RXALL;

[ ... ]

> @@ -2017,6 +2018,10 @@ static int xgbe_set_features(struct net_device *netdev,
>  	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) && rxvlan_filter)
>  		hw_if->disable_rx_vlan_filtering(pdata);
>  
> +	if ((features & NETIF_F_RXALL) != rxall)
> +		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC,
> +				   !!(features & NETIF_F_RXALL));
> +
>  	pdata->netdev_features = features;
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
> index 7d45ea22a02e2..6e30ef84239f9 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
> @@ -241,7 +241,8 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
>  			      NETIF_F_GRO |
>  			      NETIF_F_HW_VLAN_CTAG_RX |
>  			      NETIF_F_HW_VLAN_CTAG_TX |
> -			      NETIF_F_HW_VLAN_CTAG_FILTER;
> +			      NETIF_F_HW_VLAN_CTAG_FILTER |
> +			      NETIF_F_RXALL;

[Severity: Medium]
Does advertising NETIF_F_RXALL here promise more than the DCRCC-only
implementation delivers?

Documentation/networking/netdev-features.rst describes rx-all as:

	This requests that the NIC receive all possible frames, including
	errored frames (such as bad FCS, etc).

With only MAC_RCR.DCRCC wired up, bad-FCS frames get through, but other
errored frames still look unreachable.  MTL_Q_RQOMR.FEP/FUP are never
programmed, and xgbe_init() still carries the original note:

drivers/net/ethernet/amd/xgbe/xgbe-dev.c:xgbe_init() {
	...
	/*TODO: Error Packet and undersized good Packet forwarding enable
		(FEP and FUP)
	 */
	...
}

On top of that, xgbe_dev_read() turns any descriptor error summary into
RX_PACKET_ERRORS.FRAME, and xgbe_rx_poll() then drops the frame with no
NETIF_F_RXALL exemption:

drivers/net/ethernet/amd/xgbe/xgbe-drv.c:xgbe_rx_poll() {
	...
		if (error || packet->errors) {
			dev_kfree_skb(skb);
			goto next_packet;
		}
	...
}

Over-MTU frames are dropped unconditionally in the same function.
igb and ixgbe gate exactly these drops on

	!(netdev->features & NETIF_F_RXALL)

Would it make sense to gate the error and length drops on NETIF_F_RXALL
too, or to state the limitation explicitly?  The commit message says:

	Advertise NETIF_F_RXALL and disable it by default.

which reads as full rx-all support, while runt, giant, alignment/dribble
and receive-error frames still appear to be discarded.
-- 
pw-bot: cr
