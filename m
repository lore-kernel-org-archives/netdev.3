Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049890;
	b=f7M0lUTXt35ETcLYdDWvjoM7R6LB7QEmuTOCRRT41NPhv2jXd4RTpJTJ2uYpGlFVGoD9
	 ZyyLnzVYMg+4Bq9Y5UsrQAOpB9KJMyOJSjLhS8GE0tPcCK0ZBF89APz07nS5YEmPAbzlH
	 YJ8NyeprkvCFI9m+OhVY3/ejwLgMRDtjzerAPKcgJRRUJk0ujNIv7xF/LNuyA64HEPMTK
	 d/OdwcB/f2ZLcocnyYw+xNPbpemPqARUpudiqzUdbndCinwbzMaUX2iUe3Gkt59LWOrVH
	 CU+G3jbwLjn7DEltvpEaBNBObPd1/bFn136M6+PVIDxPKZQ7XcHnafPe0rwUqyiidGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049890;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QjH6AeElTt4HqVLm1otp9FwHPYVIoaC9nSMLdYjdK4Y=;
	b=Zp6N5KjYCyh1AuwbTr9GmA4E5Iah9FQA2hvbnlz3E97J3sLrtTvn3ASinbHIxbBDe+yG
	 PB2xT7N2S2LYWcrMTuDf0ZIxw5LbSAqVaU/H/NMd91ParwRVGa9DWQy19cYgLk6ytzLJQ
	 ZEiTNMSNS5Q7HcVe64qQiI8g2KonV2kJ4GrRq5ciPXJ/R6aF68O1PUQtWrk9Wb3huZjSE
	 6nQCZDtweT/2aacu2GRnEDBIKSGdxvkaWW7Ve5s/PMwLS4246jjsWD6XA+bsRV7b0DvPx
	 JnAAMu0g5dZuXXWuIAXwg0mlusc5dDbWvlyyRkRHAMSbl9pYqljsxFC07KcvToLgeAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxpZdsBh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE7606A31A;
	Mon, 26 Oct 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxpZdsBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD8D1F01825;
	Mon, 26 Oct 2026 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049890;
	bh=QjH6AeElTt4HqVLm1otp9FwHPYVIoaC9nSMLdYjdK4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bxpZdsBh42mgt9dog7dTDxOZJBHQsgIJQAb23sYvSekI5l5SrkUBMnL1OqCgI7djH
	 lqkT7hzR1+vZsziR+98SId7M2ya14+Iw9PbKPbKmJGHkwkSj91nHPlJ3On8P+SufE5
	 TETFfh3n4azIar1CB6rxgQMUhtPR7UeHuNqYF+Dk2d/E5XUKSwabuZq/m3Vhk6uEDb
	 qZZI5ivvAT/A7lfw7qsXvFgYOgQliPK4v02V+7zgmKd9UA5Di0xTK3Ijqeopvup8Cg
	 jceAJPl26VLfqhf0/Gz+orLwSbAvcj8ZyHtZxfDgq6cyKkcUQfdRF95aZ3JkrZQnB5
	 SSzZKG0ASTxJQ==
Subject: Re: [PATCH net v2 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps
 link speed
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 21:24:48 +0000
Message-ID: <179304988884.3134.8268916280620527688@kernel.org>
In-Reply-To: <20261022211104.2091128-2-florian.fainelli@broadcom.com>
References: <20261022211104.2091128-2-florian.fainelli@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new override in bgmac_adjust_link()
  (drivers/net/ethernet/broadcom/bgmac.c:1421-1427) sets UMAC_CMD to…
- [Medium] On FORCE_SPEED_2500 devices, the patch makes link reporting
  disagree with the hardware, and the commit message does not say so.
- [Low] In bgmac-bcma.c, bgmac_probe() sets BGMAC_FEAT_FORCE_SPEED_2500
  from the chip ID alone (BCM4707/BCM47094/BCM53018, line 282).

--

net: ethernet: bgmac: preserve forced 2.5 Gbps link speed

This patch changes bgmac_adjust_link() to use SPEED_2500 when
BGMAC_FEAT_FORCE_SPEED_2500 is set. Without it, the 1 Gbps speed of the
fixed PHY overwrites the 2.5 Gbps setting from bgmac_miiconfig().
Together with the switch IMP port 2 Gbps change, it is meant to remove
output queue discards on Northstar and Northstar Plus.

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 3e9c57196a397..11487ff48e0d7 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1415,11 +1415,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
>  {
>  	struct bgmac *bgmac = netdev_priv(net_dev);
>  	struct phy_device *phy_dev = net_dev->phydev;
> +	int speed = phy_dev->speed;
>  	bool update = false;
>  
> +	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500)
> +		speed = SPEED_2500;

[Severity: Medium]
This programs CMD_SPEED_2500 on every AMAC that has
BGMAC_FEAT_FORCE_SPEED_2500. Is the switch side always in its 2 Gbps mode
for those AMACs?

The companion b53 change only passes speed = 2000 for MLO_AN_FIXED CPU
ports on is5301x() or BCM58XX_DEVICE_ID, in b53_phylink_mac_link_up():

	if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
	    dsa_is_cpu_port(ds, port)) {
		tx_pause = true;
		rx_pause = true;
		speed = 2000;

On Northstar, gmac0 and gmac1 connect to switch ports 5 and 7
(bcm-ns.dtsi). On many in-tree boards, port 5 is the CPU link and port 8
is disabled. Examples are bcm4708-netgear-r6250, Luxul XAP/XWR/XBR/ABR,
Buffalo WZR, SmartRG SR400AC, Meraki MR26/MR32 and bcm953012er.

If port 5 has no fixed-link, dsa_shared_port_link_register_of() skips
phylink registration, and b53_phylink_mac_link_up() is never called.

If port 5 has a fixed-link (MR26/MR32), b53_force_port_config() writes
B53_GMII_PORT_OVERRIDE_CTRL(5) with PORT_OVERRIDE_SPEED_2000M, which is
BIT(6):

	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;

	switch (speed) {
	case 2000:
		reg |= PORT_OVERRIDE_SPEED_2000M;

In the GMII override register, BIT(6) is the enable bit and the 2G bit is
BIT(7):

#define   GMII_PO_EN			BIT(6) /* Use the register contents */
#define   GMII_PO_SPEED_2000M		BIT(7) /* BCM5301X only, requires setting 1000M */

On these boards, does the MAC now run at 2.5G against a switch port that
the kernel never puts into 2G mode? The port is only in 2G mode if the
bootloader left it that way.

Cygnus looks similar. In bcm911360_entphn.dts, eth0 is brcm,amac with no
phy-handle, so bgmac_probe() in bgmac-platform.c sets
BGMAC_FEAT_FORCE_SPEED_2500.

The switch there is brcm,cygnus-srab, which maps to BCM583XX_DEVICE_ID.
The chip_id == BCM58XX_DEVICE_ID check above does not match that ID, so
b53_force_port_config(dev, 8, 1000, ...) runs. Because is58xx() includes
BCM583XX, it clears PORT_OVERRIDE_SPEED_2000M.

Before this patch, both ends of the Cygnus link were at 1G. After the
series, would the MAC be at 2.5G and the IMP port at 1G? The series names
that kind of mismatch as the cause of the output queue discards.

Also, if this patch is applied alone (a bisect point, or a stable backport
based only on the Fixes: tag), the IMP port boards look mismatched too,
because b6a8a5477fe9 already clears the 2000M bit. The companion b53 patch
covers that case. Should the two patches be kept together for backports?

[Severity: Low]
The override depends only on the feature flag. In bgmac-bcma.c,
bgmac_probe() sets BGMAC_FEAT_FORCE_SPEED_2500 from the chip ID for the
whole 4707 family. bcma_phy_connect() tries a DT phy-handle first:

	phy_dev = of_phy_get_and_connect(bgmac->net_dev, bgmac->dev->of_node,
					 bgmac_adjust_link);

If a phy-handle attached a real autonegotiating PHY, would this ignore the
negotiated 10/100/1000 speed and program CMD_SPEED_2500?

Duplex is still copied from phy_dev->duplex. A half-duplex result would
therefore give CMD_SPEED_2500 | CMD_HD_EN.

No in-tree 4707-family DT does this, and that family registers no MDIO
bus. bgmac-platform.c sets the flag only on the bgmac_phy_connect_direct()
path, so the two glue drivers use the flag differently.

Could the override be limited to the direct fixed PHY case, or could
DUPLEX_FULL be forced together with the speed?

> +
>  	if (phy_dev->link) {
> -		if (phy_dev->speed != bgmac->mac_speed) {
> -			bgmac->mac_speed = phy_dev->speed;
> +		if (speed != bgmac->mac_speed) {
> +			bgmac->mac_speed = speed;
>  			update = true;
>  		}

[Severity: Medium]
Is this branch ever taken on FORCE_SPEED_2500 devices now?

bgmac_open() calls bgmac_chip_reset() before phy_start().
bgmac_chip_reset()->bgmac_miiconfig() has already set:

		bgmac->mac_speed = SPEED_2500;
		bgmac->mac_duplex = DUPLEX_FULL;
		bgmac_mac_speed(bgmac);

When the fixed PHY reports link up at 1000/full, speed is forced to 2500
and both comparisons match, so update stays false. Does that mean
phy_print_status() is never called, and the "Link is Up" message is lost
on every open? Before this patch, the 1000 vs 2500 difference made this
branch run on each link up.

The attached PHY also still reports 1000. That is either the synthetic
fixed PHY in bgmac_phy_connect_direct() (.speed = SPEED_1000) or the DT
fixed-link in bcm-ns.dtsi (speed = <1000>). So ethtool and
/sys/class/net/*/speed show 1 Gbps while UMAC_CMD is set for 2.5 Gbps.

Should the commit message mention this reporting change, or should the
reported speed be made to match?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022211104.2091128-1-florian.fainelli%40broadcom.com
