Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049891;
	b=bLW9TXJc1gznegsxCs6mXevFYRFaS54x5H8GQhyxz3q3FqJQpbv7c9J3q7uQ/GM1HHxg
	 /pUmeXZq2qWiQnVDlaE6/3U2++TfXEE2fbyFsKRBYnRVdQob6u4PQCMEToUoEx1MWlZwX
	 MAPDQz+tggQwOv2w2cDpJ4rCmRggfo1BP5uzrdrwG6RpwUsKtEQzYCm3u3s26VkzuLTbF
	 hWb6iFpWGqP6ee74PrF1ExoGB80c/SvN0yKfaAhy2oKJx80NYiJFrCXx7+5nM4q03q2G5
	 6wjtKjy5hk6t+KC1xeK3MRPVIDCbE6fSUQfbcEom8j8EDky2XlNmnU5uK2CCKIDuTgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049891;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5hIZKPsRS+8gPS9TCdNpVxEXJl5lz8GjmPGkmljQvFQ=;
	b=iQPdMGACAvWtDPa5my0Ic1wneub6LCw6gkLTrMwNzPs9nVCf+PC1bDH6opUcw3DoXEJg
	 JDQY3o37elM9XC0gqgUyHTzLk1X7DnBrhClX64ZPr9Ad0vk2Ds6NCZMmmG5dZnJkHYEeY
	 5vSzbTgYo4SUoPkuyMFsUxTVtaIL12OOFvYqYzLniZM09W/5JOh0UNk6YHz/kXlrGsMgf
	 ofWxVnk7lRvhI7dxOJGDqHsAtnyf0I5e59lXELdqkVcZLEZ79+oab2k4HbklgjdTiSDOH
	 QJqPnQgyKJZfLIMUEevCbl2bzu+1Wxd/IPV1ETUY38EblJe5bl0X0nNrHVjwnuWtk6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSmYaN3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E9606A31F;
	Mon, 26 Oct 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSmYaN3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AE21F01828;
	Mon, 26 Oct 2026 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049891;
	bh=5hIZKPsRS+8gPS9TCdNpVxEXJl5lz8GjmPGkmljQvFQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jSmYaN3sWiQ5P/zfDWKRPSP+vH9t3/z9ILOmqJwebHNuHod9Gxi+1rZ2T37coHNho
	 IpsAlj7cKEvQEkLAF9hvqfaxDF228KI7yugHFOydGCMCR4DZgGbcBDYiFwmDhmWXd1
	 B1Nyoqyr1qp2mSAiHf1EcA4hNl+l+OMAtk+TFlkeTMvZLf1PYNn6EloAHbvwr8jgD8
	 B3VFG/2ENYPBADvXMTQlKW9JLPG+tAsFOzJoHKyFfUFYARFHKpthI7qwdcCxWkwiYP
	 XTsVSsiXqAkYOf7lmR4TaVRzV3d/vRZInBnLG4emrAdHI0F5uYMxPZnpJUhfT1uuPo
	 nscWFZK0dbxjA==
Subject:
 Re: [PATCH net v2 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 21:24:50 +0000
Message-ID: <179304989018.3134.16623099883424149741@kernel.org>
In-Reply-To: <20261022211104.2091128-3-florian.fainelli@broadcom.com>
References: <20261022211104.2091128-3-florian.fainelli@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch never programs the 2 Gbps mode on BCM5301x CPU ports
  other than the IMP port.
- [Medium] The fix leaves out BCM583XX (Cygnus/Omega), which the Fixes:
  commit broke in the same way.
- [Low] Concern that b53_phylink_get_caps() advertises only
  MAC_10|MAC_100|MAC_1000 (b53_common.c:1563-1573), while…
- [Low] The comment in b53_phylink_mac_link_up() (b53_common.c:1666)
  reads "Force flow control on BCM5301x and NSP CPU ports", but the…
- [Low] b53_regs.h documents PORT_OVERRIDE_SPEED_2000M (line 103) and
  GMII_PO_SPEED_2000M (line 149) as "BCM5301X only, requires setting…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  b53_force_port_config() mishandles non-IMP ports on is5301x()/is58xx()…

--

net: dsa: b53: restore the NSP IMP port 2 Gbps mode

For fixed-link CPU ports on BCM5301x and BCM58XX (Northstar Plus)
switches, this commit makes b53_phylink_mac_link_up() force speed 2000
along with tx and rx pause. The goal is to restore the IMP port 2 Gbps
mode that b6a8a5477fe9 started clearing, because clearing it left the
switch and AMAC ends of the internal link at different speeds.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 0880310c9ce3f..1f4964c28fc57 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1663,9 +1663,13 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
>  	}
>  
>  	if (mode == MLO_AN_FIXED) {
> -		/* Force flow control on BCM5301x's CPU port */
> -		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
> -			tx_pause = rx_pause = true;
> +		/* Force flow control on BCM5301x and NSP CPU ports */

[Severity: Low]
This isn't a bug, but the comment only mentions flow control. The block
below it also forces speed = 2000.

The comment also says CPU ports, but the commit message describes the
2 Gbps mode as a property of the IMP port.

Could the comment mention the speed override and say which port it is
meant for?

> +		if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&

[Severity: Medium]
Should BCM583XX_DEVICE_ID be covered here too?

The clear added by b6a8a5477fe9 applies to every is58xx() chip:

drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
    ...
	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;
    ...
}

is58xx() includes BCM583XX_DEVICE_ID, but the restore here only matches
BCM58XX_DEVICE_ID.

Cygnus appears to have the same topology as NSP. In bcm-cygnus.dtsi, the
brcm,bcm11360-srab switch (BCM583XX_DEVICE_ID) uses IMP port@8 as the CPU
port. That port has a 1000 full-duplex fixed-link to eth0, a brcm,amac
with no phy-handle.

For that AMAC, bgmac-platform.c uses bgmac_phy_connect_direct() and sets
BGMAC_FEAT_FORCE_SPEED_2500, the same as for NSP amac0.

On boards like bcm911360_entphn, won't b53_force_port_config() still
clear the IMP 2 Gbps bit while the AMAC runs in high-speed mode? If
BCM583XX is left out on purpose, could the commit message say why?

> +		    dsa_is_cpu_port(ds, port)) {
> +			tx_pause = true;
> +			rx_pause = true;
> +			speed = 2000;

[Severity: Medium]
Is the 2 Gbps mode actually programmed when the CPU port is not the IMP
port?

The condition checks dsa_is_cpu_port() but not port == dev->imp_port.
For non-IMP ports, b53_force_port_config() uses the GMII override
register:

drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
    ...
	if (port == dev->imp_port) {
		off = B53_PORT_OVERRIDE_CTRL;
		val = PORT_OVERRIDE_EN;
	} else if (is5325(dev)) {
		return;
	} else {
		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
		val = GMII_PO_EN;
	}
    ...
	case 2000:
		reg |= PORT_OVERRIDE_SPEED_2000M;
		fallthrough;
    ...
}

The two registers have the enable and 2000M bits swapped:

drivers/net/dsa/b53/b53_regs.h:
#define   PORT_OVERRIDE_SPEED_2000M	BIT(6) /* BCM5301X only, requires setting 1000M */
#define   PORT_OVERRIDE_EN		BIT(7) /* Use the register contents */
...
#define   GMII_PO_EN			BIT(6) /* Use the register contents */
#define   GMII_PO_SPEED_2000M		BIT(7) /* BCM5301X only, requires setting 1000M */

On port 5 or 7, the case 2000 path only sets GMII_PO_EN again.
GMII_PO_SPEED_2000M is never written.

In-tree boards take this path. bcm53015-meraki-mr26.dts and
bcm53016-meraki-mr32.dts use port@5 (ethernet = <&gmac0>) as the CPU
port, with a 1000 full-duplex fixed-link and port@8 disabled. On the
GMAC side, bgmac-bcma.c sets BGMAC_FEAT_FORCE_SPEED_2500 for these SoCs.

Unless the bootloader already set BIT(7), won't the internal link on
these boards stay mismatched? The commit message says:

    Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.

This isn't a regression, because BIT(7) was not touched before this
patch either.

Should b53_force_port_config() set GMII_PO_SPEED_2000M for non-IMP ports?
If not, the condition and the commit message could be narrowed to the
IMP port.

[Severity: Low]
This isn't a bug, but b53_regs.h still documents the bit set here as
BCM5301X only:

#define   PORT_OVERRIDE_SPEED_2000M	BIT(6) /* BCM5301X only, requires setting 1000M */

Now that speed = 2000 is also used for BCM58XX_DEVICE_ID, the header and
the code disagree on whether NSP has this bit.

Should the comments for PORT_OVERRIDE_SPEED_2000M and
GMII_PO_SPEED_2000M in b53_regs.h be updated to include the 58xx family?

[Severity: Low]
This isn't a bug, but b53_phylink_get_caps() only advertises MAC_10,
MAC_100 and MAC_1000, and this line replaces the DT fixed-link speed
with 2000.

Phylink still validates the DT value of 1000, and CPU ports have no user
netdev. No in-tree CPU port fixed-link uses a speed other than 1000, so
I couldn't find a functional problem.

Would it be worth noting in the comment that the DT speed is ignored
here on purpose?

> +		}
>  
>  		b53_force_port_config(dev, port, speed, duplex,
>  				      tx_pause, rx_pause);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
Doesn't b53_force_port_config() disable the override on non-IMP ports of
is5301x() and is58xx() chips?

drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
    ...
	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
	reg |= val;
    ...
	reg &= ~(0x3 << GMII_PO_SPEED_S);
	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;
    ...
	b53_write8(dev, B53_CTRL_PAGE, off, reg);
}

For non-IMP ports, val is GMII_PO_EN, which is BIT(6). That is the same
bit as PORT_OVERRIDE_SPEED_2000M.

So for any speed other than 2000, the GMII override register is written
with the override disabled. It stays that way until b53_force_link() ORs
GMII_PO_EN back in.

The real 2 Gbps bit for that register, GMII_PO_SPEED_2000M (BIT(7)), is
never cleared either. Suppose the bootloader left a non-IMP port in
2 Gbps mode and DT forces it to 100M or 10M. Wouldn't that produce the
invalid speed and 2000M combination that b6a8a5477fe9 was meant to
prevent?

This patch doesn't make it worse. Non-IMP CPU ports now pass speed 2000,
which sets BIT(6) again.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022211104.2091128-1-florian.fainelli%40broadcom.com
