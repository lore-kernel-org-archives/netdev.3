Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058444;
	b=SG22UqWHc5GJOpngUVSqKZ2bQYT8LnBwmfqVg4shVbmAZ1/Flpa4ZoLWXyokUQ1/JG44
	 QK4BtKcsRAmWihmYXmYgiZlL788rn7NQq29PBV2hiB25alx5IkZIuAMTt7tA6DGAByGO3
	 kksq4VyWhO/fxbOKUvXUrrUkoj+8YMnXbRGsAPCPiip83pVqY66jTYM+57TPggjZAQg7W
	 8IPJiZ1mQ/xogvAEJonK3TFiMvogrLf4cVwlVDzeoZlOBCyWGG9D6qJ0UU1C8KB153Ocm
	 usPiXF4TAAhhGI6f2HcCauLW9ALhgcU7qdvWqcQMRm/vnt4crd4VVV8mANoAtBbF0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058444;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YgNrirynYf70PhP7GXMhfNu0U6GL6YXuNd+LnMZe+fU=;
	b=q70mvNKUVflInqHdw4IERfUVO6B8lWH1tdeIKBak91DEMTRmLcRYcY8XHu7I6KWNvB8B
	 a0TaFGXDuWAV5GwcptwT6BGPq6rGxSefT0OQWoT8DYgkufQRozkCUQohtC/DquhnpIPg1
	 wBo0fbzx8kycNiKgIB5QHa7M1i8KFtJcHfUOuW0PjwVcoiScxFg9IMGToyvJTHCxE2Dw4
	 Cibo6k/Db7Ggh8Gt/dVnHwFGC+3XZHgneNuEIHggYNxXhUuTY3zmya3iN+iGSH+6Qhk2d
	 ICn2xMX9LqAffAtewXVKi3H72G+nRjP9mwKrWreZFqjfME5wek8fyJVZURF3x4waaVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvY7UD2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4D606A32D;
	Mon, 26 Oct 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvY7UD2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0360C1F01829;
	Mon, 26 Oct 2026 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058443;
	bh=YgNrirynYf70PhP7GXMhfNu0U6GL6YXuNd+LnMZe+fU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fvY7UD2kEnF42/izBjsEu+Rf9IqyUH3/lEouuwKneG0IDLZgTuL5K2kGOO9i7SKO9
	 YgXUeNz7kZOx2cW/pCyER+QDrwUf99OBo8E99+tp3H1v2cWz4TCjhn1LdLTx6HCRPV
	 cdraSE9JCx0Px3wh1/ieZRaTBUWST5A3tkqgN6B8lCTOY3QfXqm/PhsfUlFcDEb8oX
	 YpfPH6O/Y5YJREkpMkc1DNex8NiyxPqUzdDTt4hdIrTyJ7J3uTAS0V+z09iDAwD+b2
	 CBpp6sdipn4akXHzaidi3ya1KB+MMscWUFC3+95XpWXMyybWopUFgXcesZ2dX2LZII
	 ApLMq57PBpjIw==
Subject: Re: [PATCH net 6/6 RESEND] net: dsa: b53: apply resolved link
 settings to serial port MACs
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:47:22 +0000
Message-ID: <179305844256.3134.18146519874106302835@kernel.org>
In-Reply-To: <20261022225656.1387306-7-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-7-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 2 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] b53_force_port_config() uses the IMP-register bit layout when
  it writes the per-port GMII override register.
- [Medium] net: dsa: b53: b53_force_port_config() clears GMII_PO_EN on
  non-IMP ports

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  b53_srab_request_grant() in drivers/net/dsa/b53/b53_srab.c checks the…
- [Medium] This problem wasn't introduced by this patch, but
  b53_force_link() and b53_force_port_config() ignore the return value…

--

net: dsa: b53: apply resolved link settings to serial port MACs

With this commit, the b53 phylink link_up/link_down callbacks use the MAC
override registers for SGMII and 1000BASE-X ports in every negotiation
mode, not only for fixed-link. At link-up the MAC gets the speed, duplex
and pause that phylink resolved, and at link-down the MAC link is forced
down.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index b04f9d5f05256..172ada124cbf1 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1600,6 +1600,17 @@ static void b53_phylink_mac_config(struct phylink_config *config,
>  	}
>  }
>  
> +static bool b53_phylink_mac_needs_override(struct b53_device *dev, int port,
> +					   unsigned int mode,
> +					   phy_interface_t interface)
> +{
> +	return mode == MLO_AN_FIXED ||
> +	       interface == PHY_INTERFACE_MODE_SGMII ||
> +	       interface == PHY_INTERFACE_MODE_1000BASEX ||
> +	       (mode == MLO_AN_PHY && is63xx(dev) &&
> +		in_range(port, B53_63XX_RGMII0, 4));
> +}
> +

[ ... ]

> @@ -1633,29 +1636,22 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,

[ ... ]

> +	/* Force flow control on BCM5301x's CPU port */
> +	if (mode == MLO_AN_FIXED && is5301x(dev) && dsa_is_cpu_port(ds, port)) {
> +		tx_pause = true;
> +		rx_pause = true;
>  	}
> +
> +	/* PCS negotiation supplies state; the MAC applies phylink's policy. */
> +	b53_force_port_config(dev, port, speed, duplex, tx_pause, rx_pause);
> +	b53_force_link(dev, port, true);

[Severity: Medium]
b53_phylink_mac_needs_override() now returns true for SGMII and
1000BASE-X in every mode. That means the BCM58xx SerDes ports (ports 4
and 5, see b53_srab_serdes_map_lane()) reach b53_force_port_config()
on every link-up. Those ports are never dev->imp_port, so the helper
programs B53_GMII_PORT_OVERRIDE_CTRL(port) with val = GMII_PO_EN.

Does the 2G handling in b53_force_port_config() use the right bit for
that register? In b53_regs.h, bits 6 and 7 are swapped between the IMP
override register and the GMII override register:

	PORT_OVERRIDE_SPEED_2000M	BIT(6)
	PORT_OVERRIDE_EN		BIT(7)

	GMII_PO_EN			BIT(6)
	GMII_PO_SPEED_2000M		BIT(7)

After reg |= GMII_PO_EN, the is5301x(dev) || is58xx(dev) branch does
reg &= ~PORT_OVERRIDE_SPEED_2000M. That clears BIT(6), which is the
override enable bit that was just set. GMII_PO_SPEED_2000M is never
cleared, and the case 2000 path sets BIT(6) rather than BIT(7).

As a result, the b53_write8() at the end of b53_force_port_config()
goes out with GMII_PO_EN clear. The MAC briefly returns to autonomous
hardware control until b53_force_link() sets the enable bit again in a
second write. If the bootloader left BIT(7) set, the MAC also stays
forced to 2G even though phylink resolved 1000. That contradicts the
commit message's claim that the settings passed by phylink are applied
at link-up.

The mask itself predates this patch and already affected non-IMP
fixed-link ports on 5301x/58xx. However, this patch is what routes the
SerDes ports through it in in-band and PHY modes, and it relies on the
helper to apply phylink's resolved state. Should the non-IMP path use
GMII_PO_SPEED_2000M here, for example by picking the 2G bit alongside
off and val?

[Severity: Medium]
b53_phylink_mac_needs_override() now returns true for SGMII and 1000BASE-X
in any mode. That means the BCM58xx SerDes ports (ports 5 and 4, mapped to
lanes 0 and 1 by b53_srab_serdes_map_lane()) now reach
b53_force_port_config() in in-band and PHY modes too.

These ports are not dev->imp_port, so they use the GMII override register.
Does b53_force_port_config() use the right bit layout for that register?

drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
    ...
	} else {
		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
		val = GMII_PO_EN;
	}

	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
	reg |= val;
    ...
	reg &= ~(0x3 << GMII_PO_SPEED_S);
	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;
    ...
}

In b53_regs.h the two registers have the enable bit and the 2G bit in
swapped positions:

#define   PORT_OVERRIDE_SPEED_2000M	BIT(6)
#define   PORT_OVERRIDE_EN		BIT(7)
...
#define   GMII_PO_EN			BIT(6)
#define   GMII_PO_SPEED_2000M		BIT(7)

So on the GMII register, clearing PORT_OVERRIDE_SPEED_2000M also clears
the GMII_PO_EN bit that was just set. GMII_PO_SPEED_2000M is never
cleared.

This seems to have three effects:

First, the write from b53_force_port_config() goes out with the override
disabled. The MAC briefly goes back to autonomous control until
b53_force_link() sets GMII_PO_EN again.

Second, if firmware or the bootloader left BIT(7) set, the MAC stays forced
to 2G while phylink resolved 1000. The driver never clears that bit, and
its case 2000 sets BIT(6) on this register. Would that contradict the
commit message's "Apply the settings passed by phylink at link-up"?

Third, for an unknown speed, b53_force_port_config() calls dev_err() and
returns without writing anything. b53_phylink_mac_link_up() still calls
b53_force_link(dev, port, true), which forces the link up with the old
speed, duplex and pause bits. For SGMII and 1000BASE-X this may not be
reachable in practice.

The wrong mask in b53_force_port_config() is older code and already
affected non-IMP fixed-link ports on 5301x/58xx. This patch is what sends
the SerDes ports through it and relies on it to apply phylink's settings.

[Severity: Medium]
This isn't a bug introduced by this patch, but b53_force_port_config() and
b53_force_link() both ignore the return value of b53_read8() before they
modify reg and write it back:

	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
	reg |= val;

b53_srab_read8() returns without setting *val when
b53_srab_request_grant() or b53_srab_op() fails.

Can reg then hold uninitialized stack data that gets written to
B53_GMII_PORT_OVERRIDE_CTRL(port) with the enable and link bits set?

Neither helper reports a failure. If the write in b53_force_port_config()
fails but the next b53_force_link(dev, port, true) succeeds, the MAC is
forced up with its previous settings. Likewise, a failed write at link-down
can leave the MAC forced up.

This patch adds the SerDes ports in in-band and PHY modes to the users of
these helpers.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. On SRAB
switches these override accesses go through b53_srab_read8() and
b53_srab_write8(), and both call b53_srab_request_grant() first. Is the
timeout check in that function using the right limit?

drivers/net/dsa/b53/b53_srab.c:b53_srab_request_grant() {
    ...
	for (i = 0; i < 20; i++) {
		ctrls = readl(regs + B53_SRAB_CTRLS);
		if (ctrls & B53_SRAB_CTRLS_RCAGNT)
			break;
		usleep_range(10, 100);
	}
	if (WARN_ON(i == 5))
		return -EIO;
    ...
}

If the grant never arrives, the loop exits with i == 20 and the function
returns 0. The register access then goes ahead without the grant.

If the grant arrives on the sixth poll, i == 5. A WARN fires and -EIO is
returned even though the grant is held, so the access is skipped.

Should this check be against 20 instead?

>  }
>  
>  int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022225656.1387306-1-florian.fainelli%40broadcom.com
