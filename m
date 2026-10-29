Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306393;
	b=KW39G2RGN644YXAciVAi4TjsA6AtIC487sxyQmQJ+vf4BeNpgRtkSlBIM3xcb5EcfqEK
	 YkDcSV1qxvbneEV+osF9kB50gL1GZH3rcWUWmGevj5vNjX7BHBLziUeqZtpQ2ndXVOq67
	 8K4G8qikMTeZ9bfjg4Lz1vI7eY38crD2JlQMDYvvsxv3W4LzdWIpBI5Y/ykmQLdUgwV8H
	 JIYnIA5g/oqV4WXipSX4DwnejRYh4QSXlD/xqTj0e83CpfOMJEb8r239YP5FRvtxIJCEK
	 0uYpC2EVT0h5d8C+uUu5gHxiEM+LEF3N/zJHD80LmWHtk9p/f3jKNY9LadPmVlVRENQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306393;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Km0yqTQxYGForZ+cy0urvWCzslLgA0FkwENmG253UiU=;
	b=FywwJW8dikRwgwe95E9/aM4J+9Ymm7vl7uq+9NFfaQVJhyWM1lJIsl6ldOYKiJVd/XHA
	 sIE2cZVWIOthtxVLIlkKr9B+kJo41zEs16XltPT9tg+q6s3X3JbShn36FpKkenCHYn+pQ
	 QG1CAjWd79yF/6G0Zerwe5EXmgKOnnzF1Y+ZtEGsGP483ZzKw5H9qYkO6zAVFvYfooZZm
	 wQk+IAxUZFe2FyevZ7BEhMVWDsEOx+K8oNvy5S21XoG6nveVnn98XHcZb7UtS3U0wtIxe
	 kra2u925xSNff/pImpunn7VK2Z2wBSKV3sx12IQUIJsL4YEUCWC6mu2EVCXlHUzK76g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z47TJXE0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB4606A326;
	Thu, 29 Oct 2026 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z47TJXE0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF371F01816;
	Thu, 29 Oct 2026 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306392;
	bh=Km0yqTQxYGForZ+cy0urvWCzslLgA0FkwENmG253UiU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z47TJXE0l6fe1vovOHQ3FpK1iOCvEzErSXBZCqfYcFmCe1OR4tizVqjNtq8YptI8F
	 E1FxARPrarpNaQs8d2re/6lqZYh7B9tob9kySkkPSimf5/t8u6+/O+Q6tm7+5dVymq
	 Z4jRfOfaB6GeRWvjszdBBgH8+2LRQZvumLdv4sfVFU++tNEy+dmdk6pyCWkznrI2xr
	 pI9kSd+7lc44NFOdscpI6wxLRg67IXR0ZzzfBxhHeeXzGJL6+005JluRIpA5FTCSaW
	 WwB7fba2nbeIL794lJiM16afnh9A5EhYshChrvMKsf107deOSjhJX9joXxfSP9N8f+
	 aKLCjZWW9IIdg==
Subject: Re: [PATCH net v3 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps
 link speed
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 jon.mason@broadcom.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 20:39:51 +0000
Message-ID: <179330639152.3134.1743045089447832212@kernel.org>
In-Reply-To: <20261026203742.3198673-2-florian.fainelli@broadcom.com>
References: <20261026203742.3198673-2-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The steady-state 2.5G override also hits non-Northstar
  platform AMACs.
- [Low] On forced-2500 devices, the programmed MAC speed and the reported
  link speed now disagree.

--

net: ethernet: bgmac: preserve forced 2.5 Gbps link speed

This commit makes bgmac_adjust_link() use SPEED_2500 instead of the fixed
PHY's reported speed when BGMAC_FEAT_FORCE_SPEED_2500 is set. The goal is
to keep the AMAC at 2.5 Gbps on Northstar and Northstar Plus. Without it,
the first link change reprograms the MAC to 1 Gbps.

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index b3a92ae95de30..ec879c203bc59 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1417,11 +1417,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
>  {
>  	struct bgmac *bgmac = netdev_priv(net_dev);
>  	struct phy_device *phy_dev = net_dev->phydev;
> +	int speed = phy_dev->speed;
>  	bool update = false;
>  
> +	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500)
> +		speed = SPEED_2500;

[Severity: Medium]
Does this reach more than Northstar and Northstar Plus? bgmac_probe() in
bgmac-platform.c sets the flag for any platform AMAC that has no
phy-handle, whatever the SoC family:

drivers/net/ethernet/broadcom/bgmac-platform.c:bgmac_probe() {
    ...
	} else {
		bgmac->phy_connect = bgmac_phy_connect_direct;
		bgmac->feature_flags |= BGMAC_FEAT_FORCE_SPEED_2500;
	}
    ...
}

Before this patch, the 2.5G setting from bgmac_miiconfig() only lasted
until the first bgmac_adjust_link(). That call reprogrammed the MAC to the
fixed PHY's 1000. With this change, 2.5G becomes the permanent MAC speed.

The in-tree Cygnus board bcm911360_entphn.dts enables eth0 ("brcm,amac"
in bcm-cygnus.dtsi) without a phy-handle, so it gets the flag. Its switch
peer is "brcm,bcm11360-srab" (BCM583XX_DEVICE_ID), and CPU port@8 there is
a fixed-link with speed = <1000>.

The companion change "net: dsa: b53: restore the NSP IMP port 2 Gbps mode"
only forces the IMP port to 2000 for is5301x() or BCM58XX_DEVICE_ID:

drivers/net/dsa/b53/b53_common.c:b53_phylink_mac_link_up() {
    ...
		if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
		    dsa_is_cpu_port(ds, port)) {
    ...
}

Would that leave the Cygnus AMAC at 2.5G and its IMP port at 1G? That is
the same mismatch the series describes as the cause of the output queue
discards.

Hurricane2 ("brcm,nsp-amac") and Stingray ("brcm,amac") would be treated
the same way if their DT had no phy-handle. In-tree Stingray boards do set
phy-handle, and no in-tree HR2 board enables amac0.

On parts without idm_base, bgmac_miiconfig() skips the 2.5G IOCTL clock
select. The MAC speed field would still stay at CMD_SPEED_2500:

drivers/net/ethernet/broadcom/bgmac.c:bgmac_miiconfig() {
	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500) {
		if (!(bgmac->feature_flags & BGMAC_FEAT_IDM_MASK)) {
			bgmac_idm_write(bgmac, BCMA_IOCTL,
					bgmac_idm_read(bgmac, BCMA_IOCTL) |
					0x40 | BGMAC_BCMA_IOCTL_SW_CLKEN);
		}
    ...
}

Should the override be limited to the SoCs that really run this link at
2.5G?

>  	if (phy_dev->link) {
> -		if (phy_dev->speed != bgmac->mac_speed) {
> -			bgmac->mac_speed = phy_dev->speed;
> +		if (speed != bgmac->mac_speed) {
> +			bgmac->mac_speed = speed;
>  			update = true;
>  		}

[Severity: Low]
After this change, can update ever become true on forced 2.5G devices?

bgmac_chip_reset()->bgmac_miiconfig() caches these values before the PHY
state machine runs:

		bgmac->mac_speed = SPEED_2500;
		bgmac->mac_duplex = DUPLEX_FULL;
		bgmac_mac_speed(bgmac);

The fixed PHY reports DUPLEX_FULL, so both comparisons in
bgmac_adjust_link() come out false and this block is skipped:

	if (update) {
		bgmac_mac_speed(bgmac);
		phy_print_status(phy_dev);
	}

Before the patch, the first link-up saw 1000 != 2500, reprogrammed the MAC
and printed the "Link is Up" message. That message seems to be gone on
these boards now.

Also, phy_dev->speed stays at 1000. bgmac_phy_connect_direct() registers
the synthetic fixed PHY with .speed = SPEED_1000, the DT fixed-link uses
speed = <1000>, and swphy can't represent 2500 either way.

bgmac_ethtool_ops uses phy_ethtool_get_link_ksettings(). Would ethtool and
/sys/class/net/<if>/speed then report 1000 Mb/s while the MAC is
programmed for 2.5G?

Should the commit message mention these user-visible changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026203742.3198673-1-florian.fainelli%40broadcom.com
