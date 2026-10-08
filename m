Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5738377563;
	Thu,  8 Oct 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475560; cv=none; b=ll0Ih3N9dTqYlXO8P03FFuBSQyJ53DxvNk5NFZHOlkcd8xqAxe2Oe71TszAVz1XJhFt2cf5Upx/FuETAF2lAwvh9q6+7EWsVPP+PDFQq2mR87gX38NJLJQ1YS1/pAy3HVS1AP/hs/T/codjEq0B0VgbrIfithcl1o/TejU9jKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475560; c=relaxed/simple;
	bh=IPuCAz6KAM2ikrswxsGTLj+U4HpMKQ6Y6Aig/+IwiOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlSKkntMEZ/FjOQ4EA29qaDiPetgd8N7xMw9KN3939tWf8Cj59GJObBb5I4a9o40EFNOBDueImRJofNf4KIbaB2zxglZBxy2XvMmuynSqTclWzXNYPD4THRHKhIrjXxEuNj5+maR+7JxCuYCIjO1cbFzCdTpELYcOauLlQLC7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVU8OMkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVU8OMkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF1E1F000FF;
	Thu,  8 Oct 2026 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791475559;
	bh=BE1d6aX3DzFKOl8O8OkGEdiztekA68sOvPI7AtaYUJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVU8OMktDOX1ONiI4xC+y2YN4aiCar1UvYAwMwo0vghHXNp9a5nq/tsB3rJ/KKSEH
	 6MoABtmO3Zepe25Fe0U1dxprq/nlyjLubvoXvPcceMDHUW5yc16MPJ1SmPDHoZ+dkO
	 lWeejQQ6Wy3vDEjKYEVWDfQdJrmMSLtsCRtqWxeBIUAy9CZQJLUd1jEothBoSlMvJQ
	 OAme1fwsquxtIME9H7MbgV01E9iU/2T1y553XX1OPJOA1mu4ieISA0CimB9aDLixga
	 N1GZcmEIA2by3rFWHKT2oeXa9Zjh+RXE/CM1qd30gw9MIq9XpsDF1zEUQMizW/TH85
	 lfhCyf366H5ow==
From: Jakub Kicinski <kuba@kernel.org>
To: yongzhao.derek@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: qca83xx: read resolved QCA8337 link status
Date: Thu,  8 Oct 2026 09:05:58 -0700
Message-ID: <20261008160558.3966456-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006160316.1356-1-yongzhao.derek@gmail.com>
References: <20261006160316.1356-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
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
