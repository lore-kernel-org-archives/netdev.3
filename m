Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC471F8723;
	Thu,  8 Oct 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475426; cv=none; b=ckA+tW1JKmpRRp8KvOYkW4hg+pSFhlNRxF20lMtVOABjc5774NvmmTxLqR1GhqUr9IXwxr4zx2kDeXDcxciuuBKoQEtzoon6YKZQ41o8sEUUjZya3aFThFxyK4XrAfyjzKjEBOrHZ/xaKVxTJBUT7cV5OPk8W//suUapVj77Vr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475426; c=relaxed/simple;
	bh=Wn1I9GjMhy6f4AOy5Ym6fpQcvkdRxlVgcQD5pcJIVeQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VV5DPbVg1SzW2hWP9176LTBLbaEMYrVz8bupubQDXhDyp8VlzGSDzZfBGgs/3beNMBFr/jh80zszu0KVgOAvYHE0UcEnaUidZyM7xo3tmr9QgRyqgcB29vQOrIHnoX5K7rOdz56uPvOlmN5cfTr7faly2UHssUsZc4nZYoT2sCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWAlnDEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWAlnDEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AD61F000FF;
	Thu,  8 Oct 2026 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791475425;
	bh=k6VKnsrbhuQ4A5I85kBbrCWv3GqPm0h6E8L5dYc3vEE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UWAlnDEwGlTNgqCRi5fNwRxXqRjhK9X+WuFm5+30a+f0/geQCJBzfO09WNxfMZNtj
	 3QjFCvEyoz6BfMB2ui7KfRwdzKg/Cu5FY37Lx2d/5ZaUZSzFzu3uEYT64gjKEwopMT
	 gNk3/15sl8t7Tfx9IcbI8lyj2ER+CfrJ7kB+ysg2/pAgq2SZ3tIl/VnukTogq5sr6X
	 Y/0wre20pYYsl6ua+0+Q5rOAtk+GxFvyFxoCyRogqjGc/fNyv/Dt9ezQtQ5G1zuuj+
	 0GhiTvmMUIZUpGrnr85VZ58WCLZxHlmhiq+76wh2NLvfzXODmQcOC9XQY6sG/yI1hc
	 samtRJg0edx5A==
Subject:
 Re: [PATCH net v3] net: phy: qca83xx: read resolved QCA8337 link status
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 16:03:44 +0000
Message-ID: <179147542415.434549.1369676326541511457@kernel.org>
In-Reply-To: <20261006160316.1356-1-yongzhao.derek@gmail.com>
References: <20261006160316.1356-1-yongzhao.derek@gmail.com>
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

- [Medium] In qca8337_read_status()
  (drivers/net/phy/qcom/qca83xx.c:111-123), the link-up poll throws away…
- [Medium] qca8337_read_status() now fills phydev->mdix through
  at803x_read_specific_status(), but only in the autoneg-complete, link-…

--

net: phy: qca83xx: read resolved QCA8337 link status

This adds a read_status callback for the QCA8337 internal PHY. The callback
wraps genphy_read_status() and, on an autoneg link transition, replaces
speed and duplex with the values from the PHY-specific status register via
at803x_read_specific_status(). It also resolves pause for the resulting
duplex and reports mdix_ctrl as ETH_TP_MDI_INVALID.

> diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
> index bc70ed8efd86a..e70da092f424f 100644
> --- a/drivers/net/phy/qcom/qca83xx.c
> +++ b/drivers/net/phy/qcom/qca83xx.c
> @@ -92,6 +92,42 @@ static int qca83xx_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int qca8337_read_status(struct phy_device *phydev)
> +{

[ ... ]

> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* genphy_read_status() derives speed and duplex from the
> +	 * advertisements, which is wrong after a SmartSpeed downshift.
> +	 * Whenever it has just done so, use what the PHY resolved instead.
> +	 */
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete &&
> +	    !(old_link && phydev->link)) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		phydev->pause = false;
> +		phydev->asym_pause = false;
> +
> +		ret = at803x_read_specific_status(phydev, ss_mask);
> +		if (ret)
> +			return ret;

[Severity: Medium]
Suppose BMSR shows link up and autoneg complete before
AT803X_SS_SPEED_DUPLEX_RESOLVED is set in AT803X_SPECIFIC_STATUS. What ends
up in phydev->speed and phydev->duplex in that case?

at803x_read_specific_status() only writes speed and duplex inside this
block, and otherwise returns 0:

drivers/net/phy/qcom/qcom-phy-lib.c:at803x_read_specific_status() {
    ...
	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
		...
	}

	return 0;
}

The speed switch also has no case for the reserved field value 3.
QCA808X_SS_SPEED_2500 is 4, and a 2-bit field can never hold 4.

In both cases the genphy result has already been replaced with
SPEED_UNKNOWN (and DUPLEX_UNKNOWN if the resolved bit is clear). The wrapper
then returns 0 with link set, and phy_check_link_status() calls
phy_link_up() without checking speed or duplex.

On the next poll old_link && phydev->link is true, so genphy_read_status()
returns early:

	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
		return 0;

The !(old_link && phydev->link) check here also skips the override. Would
the unknown speed and duplex then stay until the link drops?

With phylink, qca8k_phylink_mac_link_up() would get SPEED_UNKNOWN and fall
into its default case (QCA8K_PORT_STATUS_LINK_AUTO). The duplex bit would
not be set and flow control would stay off.

I couldn't confirm that QCA8337 can actually show link up before the
resolved bit is set, and the changelog says v3 has not been tested on
hardware. However, marvell_read_status_page_an() handles the same register
layout by forcing link down while the resolved bit is clear:

	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
		phydev->link = 0;
		return 0;
	}

Commit 3b72f84f8fb6 added that check because the datasheet does not specify
the timing between link status and the "Speed and Duplex Resolved" bit.

qca808x_read_status() takes a different approach. It does not clear the
genphy result before calling at803x_read_specific_status(), so an
unresolved read keeps a valid fallback.

Would either approach fit here?

> +
> +		phy_resolve_aneg_pause(phydev);
> +	}
> +
> +	/* MDI-X configuration is not implemented */
> +	phydev->mdix_ctrl = ETH_TP_MDI_INVALID;

[Severity: Medium]
at803x_read_specific_status() now fills in phydev->mdix as well. Can that
value go stale?

It is only refreshed inside the autoneg link-transition block above.
genphy_read_status_fixed() never touches mdix. In phylib, mdix is only reset
to ETH_TP_MDI_INVALID in the PHY_HALTED state.

So once an autoneg link has reported MDI or MDI-X, the old value would stay
in two cases:

  - The link drops. autoneg_complete or the resolved bit is then clear, so
    the helper leaves mdix alone.

  - Autoneg is turned off with ethtool. The override block is then skipped
    on every poll.

phy_ethtool_ksettings_get() copies phydev->mdix straight into eth_tp_mdix.
The ethtool uAPI says that field should be ETH_TP_MDI_INVALID when the
status is unknown or not applicable.

Before this patch, the driver never set mdix, so it stayed
ETH_TP_MDI_INVALID.

Should mdix also be reset to ETH_TP_MDI_INVALID when the resolved status is
not read?

> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006160316.1356-1-yongzhao.derek%40gmail.com
