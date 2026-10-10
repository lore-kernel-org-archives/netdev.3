Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04B374E74;
	Sat, 10 Oct 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619122; cv=none; b=tCnEkRi921Q2qbpEv0lgF9p1OpzOmmZEeQRDIt0A1NSqVTh1uQ8s9lub8LGQNksP7JirjMXza3z1Mqz227aQ1xDK2hw76mF1PiSwnZN0t7inxQTCXiW6v75HucMji1wqiz9uTkbJ35L/HcisoFFW7Et1ge6+xbusjKGVeAgrFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619122; c=relaxed/simple;
	bh=TVe8Ax2ctKFt29MUR1wk8o+hx6ijZyjUTfIZTeBsmPY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHlpZZavN6fF9uNxyszqkLY0Uo1c+L97/jpQ8tRJ0zPcrb9287ZzZc1Yjc2EJ5ic6DcNkF075cXGPLb4AkIPfLm6NpPikYDJVPMIK/sTdPxwx1lxsE6LgbCCX+N7JZrH8s2HIqkXWMkrAAjcBRmaoO67z7LUqoCLbiAF6hlkdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNqKpiRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNqKpiRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F191F00898;
	Sat, 10 Oct 2026 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619121;
	bh=n4ebNszWFEgod3zMDWwxW/fcS3P8TdOoKzL9KvGa2VY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jNqKpiRfiHWdsBySPyV/CBG+RD1wFNXaneXhhmtZIs0kaWaM8LGQJUuJiRu95n+YY
	 RVqU4kgULTt+Up4SFOl6OFqFiDTJg0Tm/uyextWQri9i+Ho9RRtj1ShbleFjy64b7k
	 6WQ74qNYjin0t6ef0VGkJK4owRDYMOXr+ELoSgE0G8xPhBE+1Z6VLwFwGcV9rrjEvj
	 AVYFzrWSGde2rk070RQZNfW8ArMKc/QcxlGhsMGAQBqHUuCjHQxFOQ+FSaMPsregSa
	 2GCkSt/tZZjXS+9/gTtWo794vWyl9qK7a5ocPmuVomCnQkk1V8NfIDpci2WxRArzU/
	 m0c9HUyl26hiQ==
Subject:
 Re: [PATCH net-next v2 2/6] net: ftgmac100: Add AST2700 compatible support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 07:58:39 +0000
Message-ID: <179161911983.434549.1428966315396639498@kernel.org>
In-Reply-To: <20261006-support_ast2700-v2-2-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-2-36de51fb8066@aspeedtech.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Dropped: a later patch in the series fixes this.
- [Low] Comments in the driver are now out of date.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity use-after-free that newly matched AST2700 NCSI ports also hit.
- [Medium] This problem wasn't introduced by this patch, but it now also
  affects AST2700.

--

net: ftgmac100: Add AST2700 compatible support

This commit adds match data for the Aspeed AST2700 FTGMAC100 controller
and adds "aspeed,ast2700-mac" to the OF match table. ftgmac100_probe()
now treats AST2700 as an Aspeed MAC. It gets the BIT(30) EDORR/EDOTR
masks and is_aspeed set.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 6d2fe5c2f3903..67b1fa464a421 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -2017,7 +2018,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  
>  	if (priv->mac_id == FTGMAC100_AST2400 ||
>  	    priv->mac_id == FTGMAC100_AST2500 ||
> -	    priv->mac_id == FTGMAC100_AST2600) {
> +	    priv->mac_id == FTGMAC100_AST2600 ||
> +	    priv->mac_id == FTGMAC100_AST2700) {
>  		priv->rxdes0_edorr_mask = BIT(30);
>  		priv->txdes0_edotr_mask = BIT(30);
>  		priv->is_aspeed = true;

[Severity: Medium]
This isn't a bug introduced by this patch, but setting is_aspeed for
AST2700 also exposes it to an existing NULL phydev dereference.

Suppose the MAC node has an "mdio" child but no use-ncsi, fixed-link or
phy-handle. Then ftgmac100_probe_dt() returns 0 without connecting a PHY:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_probe_dt() {
    ...
	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;
}

register_netdev() then succeeds with netdev->phydev == NULL. On ifup,
ftgmac100_open()->ftgmac100_reset_and_config_mac() does:

	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {

Can this dereference a NULL phydev here?

The binding allows an mdio child for every compatible. It does not
require phy-handle, fixed-link or use-ncsi, so a node like this would
pass dt_binding_check.

The unguarded dereference came from commit af350ee72e9dda and affects all
Aspeed variants.

[Severity: Low]
This isn't a bug, but some comments are now out of date because AST2700
is handled as an Aspeed MAC.

struct ftgmac100 still says:

	/* AST2500/AST2600 RMII ref clock gate */
	struct clk *rclk;

However, ftgmac100_setup_clk() now gets the optional RCLK for AST2700 as
well. The binding already describes it as "RMII RCLK gate for
AST2500/2600/2700".

In the same way, ftgmac100_setup_mdio() ("The AST2600 has a separate MDIO
controller") and ftgmac100_probe_dt() ("2600 has an independent MDIO
controller") only mention the AST2600. AST2700 also skips the embedded
MDIO setup. The rest of the series doesn't update these comments either.

Should these comments mention AST2700 too?

> @@ -2131,6 +2133,10 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
>  	.mac_id = FTGMAC100_AST2600
>  };
>  
> +static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
> +	.mac_id = FTGMAC100_AST2700
> +};
> +

[Severity: Low]
At this commit, can the driver do DMA on AST2700 at all?

AST2700 DRAM starts at 0x4_0000_0000. The ast2700-evb.dts file has
memory@400000000 with reg = <0x4 0x00000000 0x0 0x40000000>. The match
data here only carries mac_id, and the driver at this point:

  - sets no wider DMA mask
  - writes the ring bases with iowrite32() only in ftgmac100_init_hw()
  - keeps only the low 32 bits in rxdes3/txdes3 in
    ftgmac100_alloc_rx_buf() and ftgmac100_hard_start_xmit()

If the driver were built for arm64 here, dma_alloc_coherent() in
ftgmac100_alloc_rings() would fail under the default 32-bit mask, and
ifup would return an error.

Normal configs can't reach this at this commit, because Kconfig still
has:

	depends on ARM || COMPILE_TEST
	depends on !64BIT || BROKEN

Later patches in the series appear to fix this:

  - "net: ftgmac100: Add AST2700 upper DMA address support" adds
    FTGMAC100_QUIRK_DMA_35BIT to ftgmac100_match_data_ast2700, calls
    dma_set_mask_and_coherent() with DMA_BIT_MASK(35), and programs the
    upper address bits in the ring base registers and descriptors.
  - "net: ftgmac100: Allow building on ARM64" then enables the build.

> @@ -2142,6 +2148,8 @@ static const struct of_device_id ftgmac100_of_match[] = {
>  	  .data = &ftgmac100_match_data_ast2500 },
>  	{ .compatible = "aspeed,ast2600-mac",
>  	  .data = &ftgmac100_match_data_ast2600 },
> +	{ .compatible = "aspeed,ast2700-mac",
> +	  .data = &ftgmac100_match_data_ast2700 },
>  	{ .compatible = "faraday,ftgmac100",
>  	  .data = &ftgmac100_match_data_faraday },
>  	{ }

[Severity: High]
This is a pre-existing issue, but AST2700 NCSI ports matched by this new
compatible will hit it too. ftgmac100_remove() frees the NCSI device
before it unregisters the netdev:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_remove() {
    ...
	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);
    ...
}

ncsi_unregister_dev() ends with kfree(ndp), and that allocation contains
the struct ncsi_dev. Neither priv->ndev nor priv->use_ncsi is cleared.

If the interface is still up when the driver is removed (rmmod or a
sysfs unbind), unregister_netdev() closes it:

unregister_netdev()
  ...
  ftgmac100_stop()
    ncsi_stop_dev(priv->ndev)      <- priv->ndev already freed
      NCSI_FOR_EACH_PACKAGE(ndp, np) ...
      ncsi_report_link(ndp, true)
        nd->state = ncsi_dev_state_functional;
        nd->link_up = 0;
        nd->handler(nd);

Does this write to freed memory? It also calls nd->handler through a
pointer read from that freed memory.

This ordering dates from commit 3d5179458d22. Would calling
unregister_netdev() before ncsi_unregister_dev() in ftgmac100_remove()
avoid this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-support_ast2700-v2-0-36de51fb8066%40aspeedtech.com
