Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096941;
	b=PnBvxhFDgKDXeUbFcb735ejohJGO4wqqgvnv4GGZd02QIK7S8hhCydqILQLPHBtSzxv6
	 dOI8eMkl7gTnd/bZNPu9mq0/6aE3yAK8MsdxByHXTSjLL11nh9HM1muoklYfhERSj22Gd
	 PXrIitN9guP2iQOQ6AaE/DPptynzKXvcnFBeuevB1/+vBG81a/2qICJi54QzJEfOXE0Fq
	 jqcu/FA4+7E/8y4VLCrM98CJCDcR9Ss6xrkGIVre0Ip66TbLPcNBaI4ftS4Tv8ij/EX6H
	 x1tQdAqyhNcDIoqsQD4z0vFrEuDAFJ3iMR5U5tUhPWjzBKn7ukvOLRMRk/daCP9tWsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096941;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SE+KzW/T94I18zgPcOykLbpz2IWGtapWaIYEhxmOj50=;
	b=ghYZob9C6m1uPDEJWyvDSLXxhxQ9ijkN64j1Ox86kpkdg/i+jZ3bv8yju3kfd9M5rF7y
	 FgFJpQk7FtmV/fxovbyLqbEo9knfl3nl0MNpAgiNLkaCkeBTGZ7ELzfgTx3GFoeoYBsTv
	 kCdsrlarXwiZ/VqSdzPoiLxp2NBZHbL1cKTD5P66+hg3ZCP/1FKIko2jtKDUjRFi89Fa5
	 AbRSFXyQaUM3i7Q41fSK3fbKSvMXsphlfl+CU5beZSk4xAVJx5boRimVh+0/TlU7IByh5
	 LDWop3dJUiLTvcfjF9sX6h0RIxWH077MVPSmbEVGjLllN02vIDQqNQ3LRnyBhsLYuBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVYTk1qG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC8606A339;
	Sun,  8 Nov 2026 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVYTk1qG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A1D1F008A1;
	Sun,  8 Nov 2026 00:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096941;
	bh=SE+KzW/T94I18zgPcOykLbpz2IWGtapWaIYEhxmOj50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HVYTk1qGrIYtT251fFnqk/iqGP2HCFroWeE451eYwV3wfunTRpoUByJpZ6uOY90ZX
	 Yfw8L1BEs8EXtixz64i476+gzAVksSUoXelbZp7foSsbuapIyOMEQqmDXQkz8rfZj7
	 4CZs6F2tXd6rkAgRIz1UCygvjWpGKw1lDfSWqHetaE3M/AupAK1MQOqcwCjJ0p0jhs
	 fHVzWL2VVfMEDuIDlujayUFZw9fIQHGz0eH/tDtliLz40UNmxxjsAvcJzGrf0SnMBw
	 t7VfUytz+PVpRPHxM20s8d0A4tBpyIl36xghLIsGruNiLXTqgeTutBx+0enwv2A8y8
	 6ic8BCtuFX5yg==
Subject: Re: [PATCH net-next v10 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sun, 08 Nov 2026 00:15:39 +0000
Message-ID: <179409693924.994134.1633626847542095748@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-6-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-6-31b5a69b85b7@onsemi.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] NULL pointer dereference on an error path in oa_tc6_init()
  (drivers/net/ethernet/oa_tc6/oa_tc6_main.c).
- [Medium] net: oa_tc6: oa_tc6_set_vend1_mms() called after PHY init in
  oa_tc6_init()
- [Medium] net: oa_tc6: NULL deref in oa_tc6_phy_exit() on capability
  read failure

--

net: ethernet: oa_tc6: Support for vendor specific MMS

This adds oa_tc6_set_vend1_mms(), which lets a vendor driver map
MDIO_MMD_VEND1 to one of the vendor specific MMS values (10 to 15)
allowed by the OPEN Alliance TC6 specification. The C45 MMS lookup now
takes the tc6 context. The new vend1_mms field defaults to -EOPNOTSUPP
in oa_tc6_init().

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
> index e793d7fb0635f..5b2454b759740 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c

[ ... ]

> @@ -1658,6 +1672,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  	SET_NETDEV_DEV(netdev, &spi->dev);
>  	mutex_init(&tc6->spi_ctrl_lock);
>  	spin_lock_init(&tc6->tx_skb_lock);
> +	tc6->vend1_mms = -EOPNOTSUPP;
>  	tc6->ttsc_current_id = OA_TC6_TTSCA_REG_ID;
>  	INIT_LIST_HEAD(&tc6->tx_ts_skb_q);
>  

[Severity: Medium]
This patch doesn't touch it, but oa_tc6_init() still has a broken
unwind path. It was introduced earlier in the series by "net:
ethernet: oa_tc6: Support for hardware timestamp".

Can a failed capability read oops on a NULL phydev? In oa_tc6_init(),
oa_tc6_update_standard_capability() is called before oa_tc6_phy_init(),
and on failure it does goto phy_exit.

At that point tc6->phydev and tc6->mdiobus are still NULL from
devm_kzalloc(). oa_tc6_phy_exit() only bails out early when
OA_TC6_BROKEN_PHY is set.

For lan865x and S2500 it goes on to call phy_disconnect(tc6->phydev).
That dereferences the NULL phydev in phy_is_started() straight away.
After that, oa_tc6_mdiobus_unregister() hands a NULL tc6->mdiobus to
mdiobus_unregister() and mdiobus_free().

Any failure of the OA_TC6_REG_STDCAP read during probe gets there,
such as an SPI transfer error or a bad control reply:

lan865x_probe()/s2500_probe()
  oa_tc6_init()
    oa_tc6_update_standard_capability()
      oa_tc6_read_register() fails
    goto phy_exit
      oa_tc6_phy_exit()
        phy_disconnect(NULL)

The neighbouring failures before oa_tc6_phy_init() simply return
ERR_PTR(ret), including oa_tc6_unmask_macphy_error_interrupts().
Should this branch do the same?

[Severity: Medium]
Does this setter run too late to affect PHY probing and
initialization?

struct oa_tc6 is allocated inside oa_tc6_init(), and the caller only
gets the pointer back once oa_tc6_init() returns. By then
oa_tc6_init() has already run oa_tc6_phy_init(), which does:

oa_tc6_phy_init()
  oa_tc6_mdiobus_register()
    mdiobus_register()
      PHY driver .probe() / .get_features()
  phy_connect_direct()
    phy_attach_direct()
      phy_init_hw()
        .soft_reset(), fixups, .config_init(), .config_intr()
      phy_resume()

All of that goes through oa_tc6_mdiobus_read_c45() and
oa_tc6_mdiobus_write_c45(). At that point tc6->vend1_mms is still
the -EOPNOTSUPP default set a few lines earlier in oa_tc6_init().

So any MDIO_MMD_VEND1 access the PHY driver makes during probe, reset
or config_init fails with -EOPNOTSUPP. The mapping only takes effect
for accesses made after the MAC driver calls oa_tc6_set_vend1_mms(),
as s2500_probe() does later in this series.

The late store into tc6->vend1_mms is also done with no lock held,
while the MDIO bus is already registered and the PHY attached.

Would it be better to pass the VEND1 MMS into oa_tc6_init(), or into
some config structure handed to it? Then it would be in place before
oa_tc6_phy_init() runs.

If the S2500 PHY driver is known never to touch VEND1 before the MAC
driver gets control back, could the commit message say so?

[Severity: High]
This patch doesn't touch it, but there is a problem further down in
oa_tc6_init(). The earlier patch in this series, "net: ethernet: oa_tc6:
Support for hardware timestamp", added it, and it is still there at the
tip of the series.

Can the capability read failure path oops with a NULL phydev? In
oa_tc6_init():

	ret = oa_tc6_update_standard_capability(tc6);
	if (ret) {
		dev_err(&tc6->spi->dev, "Failed to read capability\n");
		goto phy_exit;
	}

This runs before oa_tc6_phy_init(), so tc6->phydev and tc6->mdiobus are
still NULL from devm_kzalloc(). The phy_exit label then calls:

oa_tc6_phy_exit() {
	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
		return;

	phy_disconnect(tc6->phydev);
	oa_tc6_mdiobus_unregister(tc6);
}

Only adin1140 sets OA_TC6_BROKEN_PHY, so lan865x and S2500 both reach
phy_disconnect(NULL). phy_disconnect() calls phy_is_started(phydev) right
away, which dereferences phydev->state. After that,
oa_tc6_mdiobus_unregister() would also pass a NULL mdiobus to
mdiobus_unregister().

This can trigger whenever the OA_TC6_REG_STDCAP read fails during probe,
for example on an SPI transfer error or when the control read reply
check fails:

lan865x_probe()/s2500_probe()
  oa_tc6_init()
    oa_tc6_update_standard_capability()
      oa_tc6_read_register() fails
    goto phy_exit
      oa_tc6_phy_exit()
        phy_disconnect(NULL)

The nearby failures before oa_tc6_phy_init() (sw reset, unmask error
interrupts, phy init) all use return ERR_PTR(ret). Should this branch do
the same?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
