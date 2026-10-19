Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423223;
	b=yC2S2tHjmXlnAamYAWl/AzRndN8zDo6iwx/9GStMxq16nAGahx/f9z/TzImOq4E6ak4M
	 wfATbuT4mPLNqlbI/CCbI7zHpeps/NZrTJ4TyMECmK9vgdGMZ/xsCFNxwm2J0cYsG2LeD
	 Fb7uakHz8MwQ8GcafgH3j7R/d17usOidLG4RwgmrPWS6EEnMKUJlaAwEE8ArTuEBxZoDl
	 Fu/fCsQ/SMb5IjzNP+Rf/Nz0m+oIzaUG2TGlk0R5M49Agn/VIt9ayPSfKi5GbgYD/3CcX
	 cLMEYZRp3dVxduo+Ywt2RtQWm7gjQZGU+Tb02lcQiPJxl2Z61CIvHApJztfAO3Dgn0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423223;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XhBCp7Nh6s4BiEKxr65ce1IMZRfLAF9oc7NrWukG/aM=;
	b=bRqkI0MjYu5eP0LTF9Xk/7GOgFSXQO0EW1ifJoKCeDsXW/LdWqH17vsVLwCD2rdVDsbQ
	 AJ0XxGumkQzar/8eWukQWtVy5jmSbqoBhs8Mx9FmankjHA9W/ZsKrDue+5aFdt3cGmEA0
	 VLZsROSoBAQ5MW5b+4k9E6npIL+CQV4uHrU8Wlab16EjHl05cR4ThAQiuSYc6YG8Ih77C
	 ZeZN+BuRLWY7TGmOgZX3CKmXJtiyvHWp4kqPxqd1qZqQLZlHywy6T1NweF+aHqxWUXmUf
	 lwIA3V80qh9J4nBpjcVmMuIOTmjC+E6htsbWc/3iOjfrmzcoLaSS9oaoq8MlXN9y7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPVAgI10;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A160A6F59;
	Mon, 19 Oct 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPVAgI10
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B8C1F000C5;
	Mon, 19 Oct 2026 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423222;
	bh=XhBCp7Nh6s4BiEKxr65ce1IMZRfLAF9oc7NrWukG/aM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GPVAgI10CSfpJSpDXpybjj/pLY2f1EVax6aPNGZDJ+KFVXaPHg4CMZBYqSTAJEf8K
	 tjc21bDDsLkBaw7ja/rwTITh59Bmw5+YiNV5HiVQD8RAAGNWUctLnVTTP5/uw8v1V2
	 +nTbz5vogViT8iETdkvfRQhsGgy1QfHAz0Lx0atSVybaGVaYec32UsQG4tQcefqJ3a
	 ycd/3yuyBO8I3AGrlc0VdptVmUN4bjhi4h0JsTnJH5jpQcgGEZDRK/emREttM8LSKs
	 zZUh1t4SIygW/J0+yZN78RfMOnpnVG/lxjBtDoAP72ifOqzIkitNxIW+N49FZezl2L
	 6jLy7X4XfFk2w==
Subject:
 Re: [PATCH net] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
From: netdev-bot+sashiko@kernel.org
To: prashantsengar25031@gmail.com
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, linux-usb@vger.kernel.org, kuba@kernel.org
Date: Mon, 19 Oct 2026 15:20:21 +0000
Message-ID: <179242322195.3135.13620860446079084379@kernel.org>
In-Reply-To: <20261018151830.643511-1-prashantsengar25031@gmail.com>
References: <20261018151830.643511-1-prashantsengar25031@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On a LAN7801 in fixed-link mode with no PHY, lan78xx_set_wol()
  (drivers/net/usb/lan78xx.c) now accepts WAKE_PHY and returns success,…

--

net: usb: lan78xx: avoid NULL PHY dereference in WoL setup

This commit adds a check in lan78xx_set_wol() so that
phy_ethtool_set_wol() is only called when netdev->phydev is non-NULL.
This avoids a NULL pointer dereference on LAN7801 fixed-link setups
that have no PHY attached.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5655941f14783..0c19a84623523 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1804,8 +1804,8 @@ static int lan78xx_set_wol(struct net_device *netdev,
>  	ret = device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
>  	if (ret < 0)
>  		goto exit_pm_put;
> -
> -	ret = phy_ethtool_set_wol(netdev->phydev, wol);
> +	if (netdev->phydev)
> +		ret = phy_ethtool_set_wol(netdev->phydev, wol);

[Severity: Medium]
With no PHY attached, does this now accept WAKE_PHY and return success,
even though nothing can raise a PHY wake event?

In the fixed-link case, lan78xx_phy_init() returns early and leaves
netdev->phydev NULL:

	/* No PHY found, so set up a fixed link and return early.
	 * No need to configure PHY IRQ or attach to phylink.
	 */
	return 0;

In lan78xx_set_wol(), the wol->wolopts & ~WAKE_ALL check lets WAKE_PHY
through. Then pdata->wol = wol->wolopts is stored and
device_set_wakeup_enable() succeeds. With the new guard the PHY call is
skipped, so ret stays 0.

On the next system suspend, lan78xx_suspend() calls
lan78xx_set_suspend(dev, pdata->wol). That arms a PHY wake source that
has no PHY behind it:

lan78xx_set_suspend() {
    ...
	if (wol & WAKE_PHY) {
		temp_pmt_ctl |= PMT_CTL_PHY_WAKE_EN_;

		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
    ...
}

lan78xx_get_wol() also keeps reporting wol->supported = WAKE_ALL, which
includes WAKE_PHY, so userspace is told the mode is supported and
active.

Before e110bc825897, this configuration used a registered fixed PHY
with the generic driver. That driver has no .set_wol, so
phy_ethtool_set_wol() returned -EOPNOTSUPP.

When netdev->phydev is NULL, should lan78xx_set_wol() reject WAKE_PHY,
and should lan78xx_get_wol() drop it from the supported mask?

>  
>  exit_pm_put:
>  	usb_autopm_put_interface(dev->intf);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018151830.643511-1-prashantsengar25031%40gmail.com
