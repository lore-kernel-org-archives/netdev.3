Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9C472F92;
	Sun,  4 Oct 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136069; cv=none; b=JvGi1IS7umNW6dbM6CVkK0/cyAlq6/jZFPNQpVULUimTrRqG2q9ZQ3Kfm4KCD4esjZ3C/mt/rNpxuOldf/BRs19fHai3xulgZxyf3hWE88AaGdwzDbYVDpR+ngWYtxlYMqDiIry7BA7HUkOCVLTanSELKNUwj/mUpW6aLwPsUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136069; c=relaxed/simple;
	bh=R/zv4g5fH5nY9wvv65xYUbl+m1MNGUjkDoOPnjFmf80=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJuZTdtrVQrBbRx7+IdGpBrNUjAGxJJ9s+M9dOWZaKBmcaL+Y7o9CMi2v/n5aWvplaiqtOh7YAxybXaIezx2pPM73xuGEcJX59Z5ZUc9KsB++wB3r/YGp5eUrFNdoR31kw2n+h2t8UUmlkDVu3ZBRgW8dV/Jidh42EzMbXo2JV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCC/P9Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCC/P9Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C466C1F000FF;
	Sun,  4 Oct 2026 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791136066;
	bh=cL2nUv6d3V35V6hLfVlNTivQu62IcERcio+gnjOqYdk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iCC/P9RdTbv++6f7KHUTnbTgupCvW3HuYZaSccCbQkSoPhtbaNPG9uA+iUePEW003
	 mzjwlx1uPmne60hzYwRveGPiFan9ND0ZKv36c1uLqjRgoM2pU6cCDdHrovxJKoj6dr
	 y5N9JLsYbCaDvjXD0fhhnp/K9mAFM9L5WDAw4vnB5P110B/sW5HSDXeN3Z22qaTvnv
	 ZtJ9M2WtcvPZ0Qym5oDqMLjZMzu4f96kWfbEEYNZWzeLlub+Z6u0/hZ2Wp1CZxX+GH
	 kIhh9zMoQCJ4h7/3lJJWNF4R1qFPhxiFr0SZQ4Sw45PEAe7DnksOZG7/uFIDfdsASM
	 vdn04ooaEI8bw==
Subject:
 Re: [PATCH net v2] net: phy: qca83xx: read resolved QCA8337 link status
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 17:47:45 +0000
Message-ID: <179113606534.434549.7144959528343737840@kernel.org>
In-Reply-To: <20261003173210.1235-1-yongzhao.derek@gmail.com>
References: <20261003173210.1235-1-yongzhao.derek@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] qca8337_read_status() (drivers/net/phy/qcom/qca83xx.c:95-104)
  calls genphy_read_master_slave() on every PHY poll.
- [Medium] qca8337_read_status() reverses the order of the two
  MII_STAT1000 reads compared with genphy_read_status().
- [Medium] On QCA8337, at803x_read_specific_status() now fills
  phydev->mdix_ctrl (ETH_TP_MDI / ETH_TP_MDI_X / ETH_TP_MDI_AUTO) from…

--

net: phy: qca83xx: read resolved QCA8337 link status

This adds a qca8337_read_status() wrapper for the QCA8337 internal PHY. The
wrapper calls at803x_read_status() so that speed and duplex come from the
PHY-Specific Status register after a SmartSpeed downshift. It then calls
genphy_read_master_slave() to keep reporting master/slave status.

> diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
> index bc70ed8efd86a..b8da6a41788a1 100644
> --- a/drivers/net/phy/qcom/qca83xx.c
> +++ b/drivers/net/phy/qcom/qca83xx.c
> @@ -92,6 +92,17 @@ static int qca83xx_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int qca8337_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = at803x_read_status(phydev);
> +	if (ret)
> +		return ret;

[Severity: Medium]
The two MII_STAT1000 reads here happen in the opposite order from
genphy_read_status(). Could that change how a latched master/slave
configuration fault is handled?

genphy_read_status() calls genphy_read_master_slave() before
genphy_read_lpa(). That first read consumes the latched-high, self-clearing
LPA_1000MSFAIL bit, records MASTER_SLAVE_STATE_ERR and clears the latch.

In this wrapper, at803x_read_status()->genphy_read_lpa() reads
MII_STAT1000 first. If the fault is latched and autoneg_complete is set:

drivers/net/phy/phy_device.c:genphy_read_lpa() {
    ...
			if (lpagb & LPA_1000MSFAIL) {
				...
				return -ENOLINK;
			}
    ...
}

The early return above then skips genphy_read_master_slave(), so
master_slave_state is never set to MASTER_SLAVE_STATE_ERR.

The -ENOLINK goes up through phy_check_link_status() to
_phy_state_machine(). That calls phy_error_precise(), which warns and
moves the PHY to PHY_ERROR. The PHY is then powered down through
qca8337_suspend()->genphy_suspend() until an administrative down/up.

While the link is down, the master/slave read in this wrapper clears a
latched fault on every poll. So the difference only shows up when a fault
latches and autoneg completes within the same poll interval. It is not
documented whether QCA8337 can report ANEGCOMPLETE while MSFAIL is still
latched. A persistent fault ends in -ENOLINK with both the old and the
new code.

The commit message says the wrapper keeps "the master/slave status that
genphy_read_status() provides". Does that hold on this path, given that
the error state is never recorded?

> +
> +	return genphy_read_master_slave(phydev);

[Severity: Medium]
Does this clear the phy_idle_errors counter on every poll?

genphy_read_master_slave() always reads MII_STAT1000 (register 0x0a). This
call runs on every poll, including polls where at803x_read_status()
returned early because the link stayed up.

Bits 7:0 of that register hold the 1000BASE-T idle error count. IEEE
802.3 Table 40-3 defines it as clear-on-read. This driver exposes that
field as a private ethtool stat:

static struct at803x_hw_stat qca83xx_hw_stats[] = {
	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
	...
};

qca83xx_get_stat() adds up the values it reads:

		val = val & stat.mask;
		priv->stats[i] += val;

That total is only correct if qca83xx_get_stat() is the only reader of
register 0x0a. qca8k does not set up PHY interrupts, so phylib polls
about once a second. Each poll now reads the count and throws it away.

Before this patch, genphy_read_status() read MII_STAT1000 only when the
link state changed. With this change, won't ethtool -S phy_idle_errors
miss nearly all idle errors?

[ ... ]

> @@ -220,6 +231,7 @@ static struct phy_driver qca83xx_driver[] = {
>  	.flags			= PHY_IS_INTERNAL,
>  	.config_init		= qca83xx_config_init,
>  	.soft_reset		= genphy_soft_reset,
> +	.read_status		= qca8337_read_status,

[Severity: Medium]
Through at803x_read_status(), at803x_read_specific_status() now fills
phydev->mdix_ctrl from the Specific Function Control register:

drivers/net/phy/qcom/qcom-phy-lib.c:at803x_read_specific_status() {
    ...
		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
		case AT803X_SFC_MANUAL_MDI:
			phydev->mdix_ctrl = ETH_TP_MDI;
    ...
}

The QCA8337 entry has no .config_aneg, so genphy_config_aneg() is used.
Nothing writes mdix_ctrl back to the crossover bits. Does userspace now
see MDI-X control as available even though it is not implemented?

Before this patch, mdix_ctrl stayed at ETH_TP_MDI_INVALID, so
phy_ethtool_ksettings_get() reported MDI-X control as unsupported. Now it
reports a valid value.

phy_ethtool_ksettings_set() then accepts "ethtool -s <dev> mdix on|off",
stores the value and restarts aneg, but the hardware does not change. On
the next link transition, at803x_read_status() overwrites mdix_ctrl from
the SFC register, and the user's setting is dropped without an error.

The eth_tp_mdix_ctrl description in include/uapi/linux/ethtool.h says
that if MDI(-X) control is not implemented, reads yield
ETH_TP_MDI_INVALID.

The at803x.c entries that use at803x_read_status() (AR8035, AR9331,
QCA9561) pair it with at803x_config_aneg(), which applies mdix_ctrl
through at803x_config_mdix(). Should QCA8337 get a similar .config_aneg,
or should mdix_ctrl not be reported for this PHY?

IPQ5018 already has the same gap, but this patch adds QCA8337 to it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003173210.1235-1-yongzhao.derek%40gmail.com
