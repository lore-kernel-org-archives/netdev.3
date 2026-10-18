Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27D49690C;
	Sun, 18 Oct 2026 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328461; cv=none; b=DPd4DlA861FT7yJphOSEoCrEL98B6QTjMr0tY9w7v9FseZ72WaJ6+f8NPqCl7+kKiZr8HEECHENmohQH1yy+b+UTdLW7PNf50fixwzPVpEIsA/ra5MdVXqXqTxBOqc5SgSj5ucjUhywBZTq+q3QVtSE0t8vVYezvtqN2h2I1tHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328461; c=relaxed/simple;
	bh=ToA5ZtK4cgNGSsDtAEncdf0du+2sZLUsiNz70+GIomI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tv1k2a5IoFuhZAOYhdKewIi2bg1gx+6/D47eYyKG/BEtSmNhZQmITe/c1uoStP2oOSSHuPsEu7MA1wpeVquCKUbxFoQiBj3+Licxw5w/lxgoO1wy6OHdDnceVNK3PdIof6fdf+A6MbU/GPRMPO0v77DrjgR2nPlO7dy8T3Hmds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaZf0WuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaZf0WuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E903D1F000C7;
	Sun, 18 Oct 2026 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328456;
	bh=IIKOQF9LS5h5U0CRuEN/5TQw7l+9xTTtmSTq3NLRyPc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CaZf0WuL+hosWWPyqyO0yr0KB2FVfGZNOWvczDGukqPpsM6159wxZfebTkRR1fNa4
	 /d/4xA6XFJakQJ84vEnQWirzOhg6IUuoCt9BV2wxP/CrAfpqeYT6W3yvqowcrYnaRf
	 fm0BPayG1TjfiFaH6Rx72DDG0Its0E+pHFjoxkwsmvAD0zyhVHbbqMMIS+V6STM+ks
	 zC63jv3OeKZsxUzav1cjYyyzJ+EB3h/2X4oQu9KLIuwsVeSlfNCZ5GozURhQ0rxuhW
	 X42Q9IsChiZ82ZVsOU7RdVy1Wydy5lr3CYnB/wiFC3SK77vU5f8wmpVM1w6AymwONf
	 6Tyh/nUrck38Q==
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
From: netdev-bot+sashiko@kernel.org
To: elder@riscstar.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 daniel@riscstar.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 13:00:55 +0000
Message-ID: <179232845549.3135.17087204849702140774@kernel.org>
In-Reply-To: <20261014223100.304486-3-elder@riscstar.com>
References: <20261014223100.304486-3-elder@riscstar.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new 10GBASE-R check in xpcs_switch_interface_mode()
  (drivers/net/pcs/pcs-xpcs.c:714-724) reads PCS MMD 3 register 3.8…
- [Medium] When MDIO_STAT2 bit 0 is set, the default branch of
  xpcs_switch_interface_mode() (pcs-xpcs.c:740-743) writes…

--

net: pcs: xpcs: select operating mode for 10G-baseR capable PCS

This patch makes xpcs_switch_interface_mode() read the PCS MDIO_STAT2
register. When the 10GBASE-R capability bit is set, it programs
SR_XS_PCS_CTRL2:PCS_TYPE_SEL: SGMII, 1000BASE-X and 2500BASE-X get a
reserved value, and every other interface gets the 10GBASE-R type. The
aim is to make the TC9564 XPCS work with a QCA8081 PHY without adding
another quirk.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 49abf5ea6f5cc..5316cf9c31f19 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -705,10 +705,47 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
>  static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
>  				      phy_interface_t interface)
>  {
> +	int mdio_stat2, ret;
> +
>  	/* Wangxun provides a full alternative implementation to handle quirks */
>  	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
>  		return txgbe_xpcs_switch_mode(xpcs, interface);
>  
> +	mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
> +	if (mdio_stat2 < 0)
> +		return mdio_stat2;
> +
> +	/*
> +	 * If this XPCS supports 10Gbase-R then that will be the default
> +	 * operating mode. There are several interface modes where this default
> +	 * is unhelpful. Change the operating mode for interfaces were we know
> +	 * the default is wrong, and restore the default otherwise.
> +	 */
> +	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {

[Severity: Medium]
Can a missing PCS MMD be treated as 10GBASE-R capable here? The code tests
bit 0 of MDIO_STAT2 but does not check the device-present field in bits
15:14. An absent MMD 3 that reads back as 0xffff would pass the test.

The driver already expects MMD 3 to be absent on some parts.
xpcs_read_ids() falls back to MMD 31 when the IDs read as all zeros or all
ones:

    if (!id || id == 0xffffffff) {

On SJA1105R/S, the read side returns 0xffff for any MMD other than
VEND1/VEND2:

drivers/net/dsa/sja1105/sja1105_mdio.c:sja1105_pcs_mdio_read_c45() {
    ...
	if (mmd != MDIO_MMD_VEND1 && mmd != MDIO_MMD_VEND2)
		return 0xffff;
    ...
}

The write side rejects the new CTRL2 write:

drivers/net/dsa/sja1105/sja1105_mdio.c:sja1105_pcs_mdio_write_c45() {
    ...
	if (mdio != MDIO_MMD_VEND1 && mmd != MDIO_MMD_VEND2)
		return -EINVAL;
    ...
}

So for an SGMII port on SJA1105R/S:

xpcs_pre_config()
  xpcs_switch_interface_mode()
    xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2)       -> 0xffff
    xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2, 4)   -> -EINVAL

xpcs_switch_interface_mode() then returns without setting
xpcs->interface. xpcs_pre_config() would then log "switch interface
failed: -EINVAL" on every major config.

On SJA1110, sja1110_pcs_mdio_read_c45() and sja1110_pcs_mdio_write_c45()
don't filter by MMD, so MMD 3 accesses go to bank 0x300 of the PCS
window. If that location reads with bit 0 set, would 0x0004 be written
into undocumented switch register space?

Would it make sense to also require that
(mdio_stat2 & MDIO_STAT2_DEVPRST) == MDIO_STAT2_DEVPRST_VAL? Another
option is to run this only for descs whose compat tables include 10G
modes.

> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_SGMII:
> +		case PHY_INTERFACE_MODE_1000BASEX:
> +		case PHY_INTERFACE_MODE_2500BASEX:

[ ... ]

> +			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
> +					 MDIO_PCS_CTRL2_TYPE + 1);
> +			break;
> +		default:
> +			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
> +					 MDIO_PCS_CTRL2_10GBR);
> +			break;

[Severity: Medium]
Is 10GBASE-R the right PCS type for every interface that reaches this
default branch? The comment says "restore the default otherwise".
However, synopsys_xpcs_compat[] also lists 25GBASER, XLGMII, 50GBASER,
LAUI and 100GBASEP for DW_XPCS_ID. All of those would end up here with
PCS_TYPE_SEL set to 0 (10GBASE-R).

Before this patch, the generic path never wrote PCS CTRL2. The only CTRL2
writes were in the Wangxun code.

Meta fbnic is an in-tree user that reaches this branch:

- It doesn't use the Wangxun PMA ID.
- fbnic_phylink.c only enables 100GBASEP, 50GBASER, LAUI and 25GBASER.
- fbnic_mdio_read_pcs() doesn't intercept MDIO_STAT2, so the gating bit
  comes from the real PCS register.

fbnic_mdio_write_pcs() passes the CTRL2 write straight to hardware:

drivers/net/ethernet/meta/fbnic/fbnic_mdio.c:fbnic_mdio_write_pcs() {
    ...
	fbnic_wr32(fbd, FBNIC_PCS_PAGE(addr) + regnum, val);
}

If the fbnic PCS reports the 10GBR bit in STAT2, would every major config
force the PCS type to 10GBASE-R while the link runs at 25G, 50G or 100G?
I couldn't confirm from the tree whether that bit reads as 1 on fbnic.

> +		}
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	xpcs->interface = interface;
>  
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014223100.304486-1-elder%40riscstar.com
