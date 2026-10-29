Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290512;
	b=I5TC5iOtaaHR4qWaBrJadNLh80eLsQfMzjdBPK+MKU+OvhnCABQhoEkJnzjzCT1UiriR
	 R+QZM/ypD+TL+Hz8Pjd1WdcaAf5d/yliZ+WDKH32ewWGLMbMMuRLOKiTsjLoYTdntxr+v
	 Boun3JCm+l0o5tsy39WTU3dYxMEN4h5768x7HOUMaX241c/yNkVBW+dWF5uPVi+bzrDwi
	 pG0qnUogerMm8K+DZ+0dryaYFkIAPdD/53m0SNZbU35Pm7I1D8zMrQvkgBz+RfyIUG+T9
	 9MeB7bXWYGmLdKpk70+lgE8bI1I0fw7UoGFglrcPxUHuezt21Gfm5wqCe1wn6oH+QJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290512;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H3Ht48U7r5upqNLR9c6At5eHo2k/mTK3e8pFH5RlT8o=;
	b=JZBIHbxpsZczYb3Kj5go9Zp8vi4RxjQcJn+tOrqHdSUuVTnF5PfXAMtmevJ2CnPkwypW
	 hUCTesVR9383OrRXH9eBR1Y4J87djBExSGJPAoS7FrgYSD6iYCs6e/0bX6FYyr7ezCLvO
	 ym2PWgbPq2Z+saWchPSmzRIqpAZ5ybUtYe5GTgaiGSLiAYQGrrnmkjpoYQFp/KSZ90qtH
	 wS/OVRwS7VsUay0YZk6yf+siKFksvRpc89t5YrVTUtd1Nlw8TpXRLevcs4GApr9MpENpL
	 Mx6NKYEwguU6TDu2FDVW6an7eWJHuKJLl5D3HJsLZWie3wsaLxZnLXrnyRBE4J4otyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adxsOyO8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB2606A325;
	Thu, 29 Oct 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adxsOyO8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147D31F01816;
	Thu, 29 Oct 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290512;
	bh=H3Ht48U7r5upqNLR9c6At5eHo2k/mTK3e8pFH5RlT8o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=adxsOyO86OAkINTzhxfFlFBBBQ4M9e/dH6MU3SG7Qa1X33af/IW2yspONkB6k3ISe
	 lowUsBDgTxKVO50eE1yP9AbucBJNdESf2af6K2QRYujrdqNCl1kORgtuOpxIGOTIAs
	 7pxv/SSAELY54Ndgxl0lDSOJWh55m8TYX27v6x7phgNwThnLZaUMneTYxG7vpI+qnW
	 GIC6q22C8FJQiurjiim9wZjGXe8kmY6pKngRyLjLfXAa+nf155P7sGztZsICuZfoi/
	 LwrUyCjOtztboOgC6IrFIdJSXg3Mochy4SV65qvBlC+0B8fu26TG93Qyoe7lzmdGCs
	 mJYwusveZveUw==
Subject: Re: [PATCH net 03/11] net: au1000: disconnect the PHY before freeing
 the MDIO bus
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:10 +0000
Message-ID: <179329051062.3134.8683202411485629333@kernel.org>
In-Reply-To: <20261027223140.3774570-4-f.fainelli@gmail.com>
References: <20261027223140.3774570-4-f.fainelli@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/ethernet/amd/au1000_eth.c, au1000_remove() now
  calls phy_disconnect() after unregister_netdev().

Pre-existing issues:
- [Low] The two new phy_disconnect() calls (au1000_remove() after
  unregister_netdev(), and the au1000_probe() err_out path) run without…

--

net: au1000: disconnect the PHY before freeing the MDIO bus

This patch adds phy_disconnect() calls to the au1000_probe() error path
and to au1000_remove(). This balances the phy_connect() done in
au1000_mii_probe(). In both paths the disconnect runs before the MDIO bus
is unregistered.

> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index 58bc8e1b539d5..70319b432182f 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> @@ -1287,6 +1287,8 @@ static int au1000_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_out:
> +	if (dev->phydev)
> +		phy_disconnect(dev->phydev);
>  	if (aup->mii_bus)
>  		mdiobus_unregister(aup->mii_bus);
>  

[ ... ]

> @@ -1334,6 +1336,8 @@ static void au1000_remove(struct platform_device *pdev)
>  	struct resource *base, *macen;
>  
>  	unregister_netdev(dev);
> +	if (dev->phydev)
> +		phy_disconnect(dev->phydev);

[Severity: Medium]
Can this leave the MAC clocked and out of reset after the driver unbinds?

By the time au1000_remove() reaches this point, the MAC is already in
reset with its clock gated, and aup->mac_enabled is 0. If the interface
was never opened, au1000_probe() did this by calling au1000_reset_mac()
just before register_netdev(). If the interface was opened,
au1000_close() did it.

If the interface was never opened, phydev->suspended is still false,
because phy_attach_direct() resumed the PHY. In that case phy_disconnect()
does MDIO accesses:

phy_disconnect()
  phy_detach()
    phy_detach_internal()
      phy_suspend()
        genphy_suspend()
          phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN)

Each of these accesses goes through au1000_mdiobus_read() or
au1000_mdiobus_write(). Both call au1000_enable_mac(dev, 0) first:

	if (force_reset || (!aup->mac_enabled)) {
		writel(MAC_EN_CLOCK_ENABLE, aup->enable);
		...
		writel((MAC_EN_RESET0 | MAC_EN_RESET1 | MAC_EN_RESET2
				| MAC_EN_CLOCK_ENABLE), aup->enable);
		...
		aup->mac_enabled = 1;
	}

Nothing later in au1000_remove() calls au1000_reset_mac() again before
the registers are unmapped and the netdev is freed. Before this patch,
remove left the MAC in reset with its clock gated.

The err_out path in au1000_probe() does call au1000_reset_mac(dev) after
phy_disconnect() and mdiobus_unregister(). Should au1000_remove() also
call au1000_reset_mac(dev) after phy_disconnect(), to match it?

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch, but both
new phy_disconnect() calls run without RTNL held. In au1000_remove(),
unregister_netdev() has already dropped RTNL. au1000_probe() never takes
it.

phy_disconnect()->phy_detach()->phy_detach_internal() does:

		hwprov = rtnl_dereference(dev->hwprov);

With CONFIG_PROVE_RCU enabled, could this emit a one-time "suspicious
rcu_dereference_protected() usage" warning? The read itself looks
harmless, since au1000 never installs a hwtstamp provider.

Other drivers already call phy_disconnect() after unregister_netdev()
without RTNL, for example r6040_remove_one(), et131x_pci_remove(),
bgmac_enet_remove(), mlxbf_gige_remove(), hisi_femac_drv_remove() and
ixp4xx_eth_remove(). So this looks like a problem with the phylib
annotation, not with this driver.

>  	mdiobus_unregister(aup->mii_bus);
>  	mdiobus_free(aup->mii_bus);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
