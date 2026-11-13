Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542804;
	b=GMD1UWwYJ9OFBnUvR5SOepF01r8wRcpKd4XkkIieTTCI8lPEDCKMcZVUEeWD8uA8j5Jk
	 Kq2U/P2XUDv390nRBuXN0dhmddQ8cg1TMc0N4hHDMIJppv0ldcnEfd1QgQffEIOZ2owtH
	 m4zpuTDkZO6QDm6JZn50RTrzTVpGlEB5/BXFgFFIlGyZqskNfGrlAAo12aJjQHoJzgzZY
	 oPMxVGCtPOt6+hiOLhtIwo0zqxZrodu5WWbtKw7LNWmJXu/GwDPuSU2h1Qn5HuUzZ0UWE
	 Bt5q9+Oh2Fs6ToTM6MPETRT0jVcies7/oudfFKzLG4dxA6qeLl72XcT6knd7+S4ffOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542804;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tuA60olfOPNvdkAZ/j00xlMiIOiP361+dfqsaehGjQU=;
	b=pmZs5fo0G0VLW9RsroaI0MO5rwTPGP72EaR0OCnqCrx53gnCQ/NpLecP3Ie1Cz/FS/js
	 I0G9sTLrlb810EXgn6q64bILw1iMRsjNCF4zd2Ycj5am286NcKZFeRLsvSoiMGv6AAW7T
	 YkheB8pETnK3ltOAq2xkImbDb/gqW6efY6Q8NkHv3haB31Mp1lTo5VxfphZ+B8yd+k5HC
	 5fRwrlvf5+JILk1VxjKpuuhrvErazZFKZj3HMBa2oydaRepWWz6g9INYs3DREjgwqUQWd
	 IQTOajt8oXhSA0Co6ipA2bMHMxif3DDBqt9MrpvONtXzNWLl1Jdu7uN4h8CaZ3CXfBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQtFcJ4B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9D3606A31C;
	Fri, 13 Nov 2026 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQtFcJ4B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3101F000C4;
	Fri, 13 Nov 2026 04:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794542804;
	bh=tuA60olfOPNvdkAZ/j00xlMiIOiP361+dfqsaehGjQU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EQtFcJ4BNe2SbOwbVspWNP8nzBg2I1LK4KPzLE86/Oo4ST9cUm/rh6Y2WwU2MJ8mw
	 A5PwkmP7v97L6m1rp0BydeG0TZ5cOafUO2FtcfxiIvQfPGhMmzWSWcugjhrOJSXaJ/
	 6Zn9EUa/QujxJ21B0Dh8AP0j/CeqzXZpBPgXk7nNoE1ZbLQvcec8TEpmVRt1TV+v5y
	 nSn68Z3ZBvlWdMKx3EoQdlxs1FLP3reZApzdK1VeZa9fhv9tX+qycxP1P3LHERxafI
	 JMwAFK+Tp63qIHALdE8Uv4cxLK3h2EynuZRLEsOZd2nSJv1ljEv+UN+icl7tqO9gk7
	 6N+6w615OoOww==
Subject: Re: [PATCH net-next v4 2/2] net: pcs: xpcs: make supported_interfaces
 authoritative
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, pabeni@redhat.com, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 heiko@sntech.de, aleksandr.loktionov@intel.com, fabio.baltieri@gmail.com,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 04:06:42 +0000
Message-ID: <179454280276.2199510.48600645261637152@kernel.org>
In-Reply-To: <20261110160554.918652-3-coiaprant@gmail.com>
References: <20261110160554.918652-3-coiaprant@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message overstates what the core hunk fixes.
- [Low] The commit message leaves out the behaviour change that actually
  matters.
- [Low] xpcs_rk_create() puts PHY_INTERFACE_MODE_QSGMII into the platform
  mask, and its comment says "The RK3568 XPCS supports 1000BASE-X, SGMII…

--

net: pcs: xpcs: make supported_interfaces authoritative

This commit makes xpcs_find_compat() return NULL for any interface that
is not set in pcs.supported_interfaces. It also narrows the Rockchip
XPCS mask in xpcs_rk_create(). It does this by intersecting the mask
with a platform mask of 1000BASE-X, SGMII and QSGMII.

> However, xpcs_find_compat() only walks desc->compat[] and does not look
> at pcs.supported_interfaces. If a caller ever passes an interface
> outside the mask, the core would still find and configure a compat
> entry for it, contradicting the mask the glue already set. This was a
> known gap: the mask was written but never consulted by the core.

[Severity: Medium]
Does this describe the code as it was before this patch?

In the core, only xpcs_create() writes pcs.supported_interfaces. It does
so through xpcs_get_interfaces(), which builds the mask from the same
table that xpcs_find_compat() walks:

drivers/net/pcs/pcs-xpcs.c:xpcs_get_interfaces() {
	for (compat = xpcs->desc->compat; compat->supported; compat++)
		__set_bit(compat->interface, interfaces);
}

For every existing user, a set bit and a compat entry mean the same
thing. The new test_bit() in xpcs_find_compat() therefore can't reject
anything.

Before this patch, xpcs_rk_create() didn't touch pcs.supported_interfaces
either. So no mask had been "already set" by the glue. This same patch
adds the narrowing.

phylink also already checks the mask before it uses the PCS:

drivers/net/phy/phylink.c:phylink_validate_mac_and_pcs() {
    ...
		if (!phy_interface_empty(pcs->supported_interfaces) &&
		    !test_bit(state->interface, pcs->supported_interfaces)) {
			phylink_err(pl, "MAC returned PCS which does not support %s\n",
				    phy_modes(state->interface));
			return -EINVAL;
		}
    ...
}

The only path that skips phylink seems to be the exported
xpcs_get_an_mode(). It is called from stmmac_init_phy() with
plat->phy_interface. On RK that is always SGMII, which stays in the
mask.

Could the commit message say that the xpcs_find_compat() change is
defensive, and that the behaviour change comes from the glue narrowing
the mask?

> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> index 6f0a110e32d24..b14b55dbd26cc 100644
> --- a/drivers/net/pcs/pcs-xpcs-rk.c
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c

[ ... ]

> @@ -536,6 +537,15 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
>  		return xpcs;
>  	}
>  
> +	/*
> +	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
> +	 */
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX, supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII, supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_QSGMII, supported_interfaces);

[Severity: Low]
Should QSGMII be in this mask?

synopsys_xpcs_compat[] has no QSGMII entry. phy_interface_and() always
clears this bit, so it is dead code today.

The commit message says the glue "will automatically pick it up" once
the core supports QSGMII. However, nothing in the RK integration seems
to handle QSGMII:

- pcs-xpcs-rk.c only calls phy_init() and phy_power_on() on the SerDes.
  It never sets a SerDes mode for each interface.
- rk_gmac_probe() only installs rk_pcs_init() and rk_select_pcs() when
  plat_dat->phy_interface is PHY_INTERFACE_MODE_SGMII.
- rk_gmac_check_ops() and rk_gmac_powerup() only accept RGMII*, RMII
  and SGMII.

Another integration might later need a QSGMII entry in
synopsys_xpcs_compat[]. In that case the bit would survive here, and
stmmac_phylink_setup() would OR it into phylink's supported_interfaces
for dwmac-rk.

Would phylink then be able to select QSGMII, even though neither the
SerDes nor the MAC glue is set up for it?

> +	phy_interface_and(xpcs->pcs.supported_interfaces, xpcs->pcs.supported_interfaces,
> +			  supported_interfaces);

[Severity: Low]
Should the commit message mention that this narrowing changes the
phylink configuration of dwmac-rk?

rk_pcs_init() stores this XPCS in priv->hw->xpcs. stmmac_phylink_setup()
then ORs its mask into phylink's interface masks:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_phylink_setup() {
    ...
	if (pcs)
		phy_interface_or(config->supported_interfaces,
				 config->supported_interfaces,
				 pcs->supported_interfaces);
    ...
		if (pcs)
			phy_interface_or(config->lpi_interfaces,
					 config->lpi_interfaces,
					 pcs->supported_interfaces);
    ...
}

The lpi_interfaces update only happens when priv->dma_cap.eee is set
and STMMAC_FLAG_EEE_DISABLE is not.

Before this patch, the full synopsys_xpcs_compat[] set was advertised to
phylink for dwmac-rk as both supported and LPI-capable. That set is
USXGMII, 10GKR, 25GBASER, XLGMII, 50GBASER, LAUI, 100GBASEP, 10GBASER,
SGMII, 1000BASEX and 2500BASEX. After this patch, both masks shrink to
SGMII and 1000BASEX.

rk_select_pcs() returns the XPCS for any interface. That makes this
narrowing the part of the patch that actually changes behaviour.

The commit message only describes the xpcs_find_compat() change, and
says:

  the MAC side forces the phy mode, so phylink does not normally pass an
  interface outside the mask.

Could the message also describe the change to the dwmac-rk phylink
supported_interfaces and lpi_interfaces?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110160554.918652-1-coiaprant%40gmail.com
