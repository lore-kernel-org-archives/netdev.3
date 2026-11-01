Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569621;
	b=OJkn7z2Un5T7Qs8kxRC5TnpNVhqF6ZzLLIAljMzii1mgeS+bSYOzJmlm9Kf3JztVej7d
	 lyptnA2Vq38vwf7ANxld9Y/2qcDTfOUVXqbDwCSYBW/iUyZhyQawlNmiHMgiWG+3aK/ZS
	 1DYgLMc9iQTqM4sRLDThk1bTpwhdDGdluQiYRTr3+QRmeHdwZkJ2lsXCVkiYAitkkBhXp
	 ojzDVS7D7HtO+Z1jnZgfmJsLetDfyckI4vW3DMznY2yry9DNkxURvpiFfxI6wBXOyuuZq
	 1GxaGCta46pAs4Up1KLqGm9EMaJXE/+up4TXmkDik2KU/47GqV2GWL0cn4OpiILqEqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569621;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OnEbti8Lyvb6OrP0RkQ8UVvs1b0OjU43bHIMsskyVEc=;
	b=c1LOeYarRj7vW3o+m8Wje6roAw32oGeVxCXeQ2T/VaPh/RWL85ve3hdKgbzPZflo4BZg
	 LpJSke6AsDxb/dfYHWqrcGNo1m5VbQ/1vCzR89GWR/v64iowJXyTUs80lroBSZ9wBSATx
	 McX8JNL1LgZJuZWfs4c16Pz2S0Hlr8rFQPZI35HUD0p2txxKkvdkJl635hwNNFCSZleU1
	 osQ1lGcKbS1GBiFWkvKuibBnGdBxzztUuByndPFTXt2fxrbD22nMpWx46uZPzQ0FNvEMu
	 piaxdKbvSx7pu/3NLCWDQ7jMZHfhlG60f+R/hXyZftPjJ70nqb8Mw3vABUyXlR4R63A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqjCJMsL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0D606A331;
	Sun,  1 Nov 2026 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqjCJMsL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBB31F00A02;
	Sun,  1 Nov 2026 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793569621;
	bh=OnEbti8Lyvb6OrP0RkQ8UVvs1b0OjU43bHIMsskyVEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nqjCJMsLWAhAH7wXjwg/t8uf0w7aGTxFzvMjWNanzqUIcA8XJaqJrrbIe4eVh3xy4
	 IDvaSCeUJOndEZuvGN/LPaHiNkfjo3oRzt9KWft1MLIhN45bL4+YHtvc9YnvnnkYUy
	 vMPZxN7LaNHadNsOea5J98YOtMEmVz3yxFAfsE5t6O3IfjsNhQhLz7ZKBxDdIWCIWK
	 qGWFQOELUYyRQAjN/UJmzlmno7dXbuoPPHsC2ZWixy5Hsb4WQVeE0Pmm+Bm651pWoj
	 w0hnlJDzckpphAwHd4BXkJn0sMTMZlctGmYdrvuwzRF/nWGj+tII29uckuWHIuqhGB
	 UUIpMQV8Fi7JQ==
Subject:
 Re: [PATCH net v2 4/5] net: dsa: b53: reject conflicting mirror destinations
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 21:46:59 +0000
Message-ID: <179356961978.3131.2192890787102914987@kernel.org>
In-Reply-To: <20261028212310.3847553-5-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-5-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] b53_mirror_add() now treats the live B53_MIR_CAP_CTL contents
  (MIRROR_EN plus CAP_PORT_MASK) as a record of rules this driver…

Pre-existing issues:
- [Medium] Only the first B53_MIR_CAP_CTL read in b53_mirror_add() is
  checked.
- [Medium] Mirror register writes are still unchecked, so a failed write
  can leave the source masks and the shared capture control out of sync.
- [Medium] b53_mdio_read16() (drivers/net/dsa/b53/b53_mdio.c:95-106)
  assigns the int result of mdiobus_read_nested(bus,…

--

net: dsa: b53: reject conflicting mirror destinations

b53_mirror_add() now reads B53_MIR_CAP_CTL first. If mirroring is
already enabled with a different capture port, it rejects the new rule
with an extack, and it returns an error if that read fails.
b53_mirror_del() now clears the whole CAP_PORT_MASK field when the last
mirror source is removed.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index c38e8c5838bd8..378f47e7250cd 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2543,7 +2543,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  		   struct netlink_ext_ack *extack)
>  {
>  	struct b53_device *dev = ds->priv;
> -	u16 reg, loc;
> +	u16 reg, loc, cap_ctl;
> +	int ret;
> +
> +	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
> +	if (ret)
> +		return ret;

[Severity: Medium]
This isn't a bug introduced by this patch, but on switches attached over
MDIO, can cap_ctl still hold a bogus value even when this returns 0?

drivers/net/dsa/b53/b53_mdio.c:b53_mdio_read16() {
	...
	ret = b53_mdio_op(dev, page, reg, REG_MII_ADDR_READ);
	if (ret)
		return ret;

	*val = mdiobus_read_nested(bus, BRCM_PSEUDO_PHY_ADDR, REG_MII_DATA0);

	return 0;
}

Suppose b53_mdio_op() succeeds and then the REG_MII_DATA0 read fails. The
negative errno is truncated into the u16 and reported as success. For
example, -ETIMEDOUT becomes 0xff92, which has MIRROR_EN set and
CAP_PORT_MASK equal to 2.

The new check below would then compare against a capture port of 2. It
could accept a conflicting rule or reject a valid one.

b53_mdio_read8/32/48/64 have the same pattern, so this probably needs a
separate fix in b53_mdio.c: check the signed result before assigning
*val.

> +
> +	if ((cap_ctl & MIRROR_EN) &&
> +	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only one mirroring destination is supported");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
Can this check reject valid rules because of mirror state left in the
hardware from before probe?

As far as I can see, b53 probe, setup and reset never put
B53_MIR_CAP_CTL, B53_IG_MIR_CTL or B53_EG_MIR_CTL into a known state.
Only b53_mirror_add() and b53_mirror_del() touch them.

b53_switch_reset() soft-resets only is539x() and BCM58XX/BCM583XX chips:

	if (is539x(dev)) {
		b53_write8(dev, B53_CTRL_PAGE, B53_SOFTRESET, 0x83);
	...

Other chips (5325, 5365, 531x5, 63xx) without a reset GPIO keep their
earlier register contents.

kexec is one way to get there. device_shutdown()->dsa_switch_shutdown()
only detaches and unlinks the user ports and never calls
port_mirror_del. MIRROR_EN and the capture port therefore survive into
the next kernel.

The new DSA instance starts with an empty mall_tc_list, so userspace has
no rule it can delete to clear that state. After that, every tc matchall
mirred rule to a port other than the leftover capture port fails with
-EOPNOTSUPP and "Only one mirroring destination is supported". Before
this patch, the next add simply overwrote the leftover capture port.

Would it make sense to clear B53_MIR_CAP_CTL and the IG/EG mirror masks
during setup? Another option is to base the check on state tracked in
software, as mt7530 does with priv->mirror_rx/mirror_tx.

[ ... ]

> @@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  	reg |= BIT(port);
>  	b53_write16(dev, B53_MGMT_PAGE, loc, reg);

[Severity: Medium]
This is a pre-existing issue, but only the first B53_MIR_CAP_CTL read is
checked. Can the other unchecked accesses in the mirror paths still
write uninitialized or stale values to the hardware?

In b53_mirror_add(), the read just before this is unchecked:

	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
	reg |= BIT(port);
	b53_write16(dev, B53_MGMT_PAGE, loc, reg);

reg is an uninitialized u16, and the SPI and MDIO backends leave *val
untouched on error (b53_spi_read16() only assigns when !ret). A failed
read therefore writes garbage | BIT(port) into the IG/EG mirror mask.
The writes are not checked either, and the function returns 0 either
way.

In b53_mirror_del(), none of the three b53_read16() calls are checked:

- If the first read fails, the uninitialized reg & ~BIT(port) is written
  back to the IG/EG mask.
- If the read of the other direction fails, other_loc_disable is
  computed from stale data. With this patch, that decision now also
  clears CAP_PORT_MASK.
- If the CAP_CTL read fails, reg still holds the other direction's
  source mask, and that value is written into B53_MIR_CAP_CTL:

	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
	/* Both no longer have ports, let's disable mirroring */
	if (loc_disable && other_loc_disable)
		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);

Ignoring register access errors is common in b53_common.c, where only a
handful of the roughly 180 accesses are checked. The commit message only
claims to propagate the capture-control read used for the conflict
decision, and the patch does that.

>  
> -	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
> -	reg &= ~CAP_PORT_MASK;
> -	reg |= mirror->to_local_port;
> -	reg |= MIRROR_EN;
> -	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
> +	cap_ctl &= ~CAP_PORT_MASK;
> +	cap_ctl |= mirror->to_local_port;
> +	cap_ctl |= MIRROR_EN;
> +	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
>  
>  	return 0;

[Severity: Medium]
This isn't a bug introduced by this patch, but the write results are
still ignored. Can a failed write leave the source masks and
B53_MIR_CAP_CTL out of sync in a way that gets past the new check?

Suppose the loc write succeeds and this CAP_CTL write fails.
b53_mirror_add() still returns 0, dsa_user_add_cls_matchall_mirred()
records the rule, and MIRROR_EN stays clear. A later rule to a
different destination then passes the MIRROR_EN check, and both sources
end up mirrored to the new port.

The opposite case can happen in b53_mirror_del():

	if (loc_disable && other_loc_disable)
		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);

If this write fails after the source masks were cleared, MIRROR_EN stays
set with the old port. The new check then rejects other destinations
even though no sources remain.

Writes can fail before the register is touched. For example,
b53_spi_write16() returns early when b53_prepare_reg_access() fails.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028212310.3847553-1-florian.fainelli%40broadcom.com
