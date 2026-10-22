Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700192;
	b=c9DHlD1keGVlMkOab9iZoMTwwkYsugdHbOPOPcVMPaQPN/lD4503M0mSnvkMotYSE4jy
	 FXeRSNxkJBZJHofVKIuI5dErUOjGG/eGhyqIDbbgR50rQhOiObaVasCmrj4xYRuYtLX0M
	 qET2jzRSTaif3WyGeiM7rFTneONTB0y1nLNlM25v93OXH9QQI6Ft9airDEFVI8LFugdua
	 wjeca67is1vOeEpx5yKntZwKeRF5s2DH/OecmofDhtG9UNVWk/AoWm1riaqsgOpJpgFDE
	 0o6P/MVV5QpWb1lbMXQHnmNpI8qicHqnaJ8R2RorU4HN9ZAnEacG+PnHPYYtaBivptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700192;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tnLblktMeZ7lb0jeukkbTTUSpbE1oL5D1vptFoQWo3Q=;
	b=fCriLG/IwgmYV0G05QSsyuRxX+GIqXI3Vy023Hd/GdE3IwcC0HdFL12/Ny2c2mqqGY/o
	 2WS893s1LyKPbWmJ8UT/ZUiOIDCbJSZwXcNoCYf1bh3fMonJ53H8wRKvJzzcgRRfTtHUi
	 ixtCQHW6YZneLZjZUZT2V2M7yXH6O0uyLILQkD5u9/JOhFMVNNv9dBGIS0XIOMqXfsxUQ
	 /H7HBPX9sF+2gmtDaUgnVUjZ2eoh5y91Vn12o7TPRBtWEKggClPiKXw5BxpAgQp1Fx8La
	 laOTA4t+Vyn0/3vBBcI0reDv3HFceAq3Sw7ZbzdLGuyXhRaQJNjzCiQeEf+Zfkjx2Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iZfbqYJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B47606A32C;
	Thu, 22 Oct 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZfbqYJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818521F01825;
	Thu, 22 Oct 2026 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700191;
	bh=tnLblktMeZ7lb0jeukkbTTUSpbE1oL5D1vptFoQWo3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iZfbqYJ/Lig7nZSKDfsw6pIyYPOG282sf3ix7naKp2MBtllE50iknZA4bYC65TWiI
	 EuEJxkvIsjMmws8Y/QA4BvX8nEiTaUuyQcdR9JWNIavG4o2GaQ7MffyaEJqg+duKPt
	 c/2Ki0vDPqBuG9OPZB1mW8QGzaBhnM496jVQmSGXN/+9d5MaMeyqkWhiiTDjK9N/C2
	 d0B/J5ePTQ62SmBfEJhRIAn2rVqgDqcbBX6oU9ornLArw2PhALaSM04FBzia1GsOGh
	 zDLDXhOavqgnPLTjmvo0fYqTGCCOJK7kI8yzjjPiFfhM7PbeTETogk9d4ep+RNgDWo
	 6cOplA/FCWYNg==
Subject:
 Re: [PATCH net v4] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
From: netdev-bot+sashiko@kernel.org
To: prashantsengar25031@gmail.com
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
 linux-usb@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 20:16:31 +0000
Message-ID: <179270019104.1189532.4796247224411917544@kernel.org>
In-Reply-To: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
References: <20261020201537.2465655-1-prashantsengar25031@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch turns off every WoL mode on PHY-less (fixed-link)
  LAN7801 devices.
- [Medium] On a PHY-less LAN7801, ethtool is told WoL is off while system
  suspend still arms magic-packet wake, and the user cannot turn it off…

--

net: usb: lan78xx: avoid NULL PHY dereference in WoL setup

This patch fixes a NULL netdev->phydev dereference in lan78xx_set_wol()
on LAN7801 fixed-link setups that have no attached PHY. When no PHY is
attached, lan78xx_get_wol() now reports no WoL capabilities, and
lan78xx_set_wol() returns -EOPNOTSUPP before it changes the wakeup
configuration.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5655941f14783..4f100bec5b3ae 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1764,6 +1764,12 @@ static void lan78xx_get_wol(struct net_device *netdev,
>  	u32 buf;
>  	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
>  
> +	if (!netdev->phydev) {
> +		wol->supported = 0;
> +		wol->wolopts = 0;
> +		return;
> +	}
> +

[Severity: Medium]
Does this turn off more WoL modes than it needs to on a PHY-less LAN7801?

In lan78xx_set_suspend(), only WAKE_PHY involves the PHY:

drivers/net/usb/lan78xx.c:lan78xx_set_suspend() {
    ...
	if (wol & WAKE_PHY) {
		temp_pmt_ctl |= PMT_CTL_PHY_WAKE_EN_;
    ...
	if (wol & WAKE_MAGIC) {
		temp_wucsr |= WUCSR_MPEN_;
    ...
	if (wol & WAKE_BCAST) {
		temp_wucsr |= WUCSR_BCST_EN_;
    ...
}

WAKE_MAGIC, WAKE_BCAST, WAKE_MCAST, WAKE_UCAST and WAKE_ARP are set up
only through MAC registers (WUCSR, WUF_CFG/WUF_MASK, PMT_CTL).

With supported = 0 here, ethtool_set_wol() rejects any nonzero wolopts
with -EINVAL. lan78xx_set_wol() below also returns -EOPNOTSUPP. So
fixed-link users can no longer set up magic, broadcast, multicast,
unicast or ARP wake.

Before e110bc825897, lan78xx_register_fixed_phy() gave a PHY-less
LAN7801 a fixed PHY, so phydev was never NULL. get_wol reported
WAKE_ALL. set_wol stored pdata->wol and called
device_set_wakeup_enable() before phy_ethtool_set_wol() returned
-EOPNOTSUPP. In that setup the MAC-level setting still reached the
suspend path.

The commit message says:

    With this change, the PHY-less configuration no longer
    advertises unsupported WoL operations, avoiding the crash.

Are the MAC-only modes actually unsupported here?

Would it work to skip only phy_ethtool_set_wol() when phydev is NULL,
and advertise WAKE_ALL & ~WAKE_PHY? That would avoid the NULL
dereference and keep MAC WoL. If dropping MAC WoL is intended, could
the commit message say so?

>  	if (usb_autopm_get_interface(dev->intf) < 0)
>  		return;
>  
> @@ -1795,6 +1801,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
>  	if (wol->wolopts & ~WAKE_ALL)
>  		return -EINVAL;
>  
> +	if (!netdev->phydev)
> +		return -EOPNOTSUPP;
> +

[Severity: Medium]
Can this leave magic-packet wake armed while ethtool reports WoL as
off?

lan78xx_bind() sets this default whether or not a PHY exists:

	pdata->wol = WAKE_MAGIC;

lan78xx_probe() enables USB wakeup unconditionally:

	ret = device_set_wakeup_enable(&udev->dev, true);

On system suspend with the interface up, lan78xx_suspend() still uses
pdata->wol:

	ret = lan78xx_set_suspend(dev, pdata->wol);

For WAKE_MAGIC this sets WUCSR_MPEN_, PMT_CTL_WOL_EN_ and
PMT_CTL_SUS_MODE_3_. These are all MAC registers, so the wake source is
armed even without a PHY.

Meanwhile, lan78xx_get_wol() now reports wolopts = 0 when there is no
PHY. Running "ethtool -s <dev> wol d" sends wolopts = 0. That matches
the reported value, so ethtool_set_wol() returns early:

net/ethtool/ioctl.c:ethtool_set_wol() {
    ...
	if (wol.wolopts == cur_wol.wolopts &&
	    !memcmp(wol.sopass, cur_wol.sopass, sizeof(wol.sopass)))
		return 0;
    ...
}

Even if the driver were called, this early -EOPNOTSUPP returns before
pdata->wol or device_set_wakeup_enable() is updated.

Before the patch, get_wol reported wolopts = pdata->wol with
supported = WAKE_ALL, so ethtool showed what suspend would arm.

Should the PHY-less case also clear pdata->wol and the default udev
wakeup? Or should the MAC-only modes keep working, with only WAKE_PHY
rejected?

>  	ret = usb_autopm_get_interface(dev->intf);
>  	if (ret < 0)
>  		return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020201537.2465655-1-prashantsengar25031%40gmail.com
