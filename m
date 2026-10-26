Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056025;
	b=BkOhwIML2gtr+jVXOXlw2EBQbweCOCcro29k+g37TkCimP8BUWu1x4qYsw88Wr+c4z+h
	 /PGhpLwt6ylUPOUAkb2dGWLNEnZsezYivFy1qXzijP/xwx/f1VVfOZt9Kz7unKRNu01vi
	 gD4N2uAgt2HUgc3//PShcciHScUwj6bAMNHU9CftmN4K/oBPBnseQQTLl05NuLYizWAOL
	 L3CK3/a86nrskj7ClKNzMwJAEjNb8P06zPQtjDwLFoTDS8p1Yz9Hm4KCWLVQ2jTzJh2RI
	 GpOIwmMrxL9TV+7HzvsTFOPKdt+tNyxgqwobr0Cb9XEWr+B5oUYDEM3S+RshNGXe2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056025;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oPD5SqKlTZOC0NnEMGcHJVShraHtb9hDhDLXr3wErmU=;
	b=NXX9K45gaCahflBMIQXrGXSVx4UG2IW0YZsdnsnEveYK6p7YxjeWvWedWVmaM3qkJPWy
	 2cQ4lC/G7Cqa5KaNhS7wdbIq4rWXZibr7qdmdskEPgIU4Q51gT7Y/K1KELkEHD1Gm9TeZ
	 +ahkjBqTjkq5oNhpXR3SN67htT+8GXxuQ7e53yuIX0uAozGb0eQj7zYQfSlKUapP2CVca
	 sgQQjjyy7uE0brDguj8F4PFTFwCU8iE2yyeAvG0viy+hbmuNqo4rmyQlsCLrA2ExuBX6F
	 mnZeGg8c4BabWa+mO9mtN707vogmcF7ki3bKM166uZcAqPzmsztCVntrjc7kt97j4Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mz/ypiZT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E43606A322;
	Mon, 26 Oct 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mz/ypiZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787EB1F031E1;
	Mon, 26 Oct 2026 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056025;
	bh=oPD5SqKlTZOC0NnEMGcHJVShraHtb9hDhDLXr3wErmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mz/ypiZTINTy1u8SRMIn/2UCfkCCeTs6Ki6fA97t4Vz0KTe9Z1aEIG84Ad2KXwE5f
	 E3wQ3P4IhKoNZzN1ZMgEZvLboEHEvDJ07CS2JsRv+DYQfcUwNB9vEEbA7lPu8eqiD+
	 XRXVLLKO6v80TFKmIOYGhh6yziDTJrHi/AKVlrjUca8e/i9VcL7pObgzeT3O0nCKGs
	 aCBSSH/hPhtAluQvlFpqTowdQTD00w6FKu9UJsAlgLD1TWF3nR1eSn6MhF6rifc6oo
	 4Z6kPmcKrVcI/fB16MsNfVcyzCp3Z1Ecs4jFylLR60cd+X5sNwmophUjGufEe1nXEZ
	 O9U/pQlmAm51g==
Subject: Re: [PATCH net v2 1/4] net: phy: as21xxx: handle corner case with
 link and autoneg complete
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:07:04 +0000
Message-ID: <179305602406.3134.12536030010913078225@kernel.org>
In-Reply-To: <20261022222955.698722-1-ansuelsmth@gmail.com>
References: <20261022222955.698722-1-ansuelsmth@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: phy: as21xxx: handle corner case
  with link and autoneg complete" describes the wrong condition.

--

net: phy: as21xxx: handle corner case with link and autoneg complete

This commit makes as21xxx_read_link() store the autoneg complete bit
from MDIO_STAT1 in phydev->autoneg_complete. When autoneg is enabled
but has not completed, it reports the link as down. This is the same
approach genphy_update_link() takes.

> Add missing case in custom read_link, when autoneg is started, autoneg
> complete bit is reset but link is still not up.

[Severity: Low]
Is this the condition the new code actually handles?

If the link is not up, MDIO_STAT1_LSTATUS is already clear. That means
phydev->link is already 0 before the new check runs:

	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
	phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);
	...
	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
		phydev->link = 0;

The check only changes anything when MDIO_STAT1_LSTATUS is still set
and MDIO_AN_STAT1_COMPLETE has already been cleared. The in-code
comment, copied from genphy_update_link(), describes it that way:

	/* Consider the case that autoneg was started and "aneg complete"
	 * bit has been reset, but "link up" bit not yet.
	 */

Could the commit message be reworded to match? The case being handled
is that the link up bit has not been reset yet, not that the link is
not up.

It could also help stable backporters to state the user-visible effect.
Without this check, as21xxx_read_status() can move from link down to
link up while genphy_c45_read_lpa() is taking its
!MDIO_AN_STAT1_COMPLETE branch:

	if (!(val & MDIO_AN_STAT1_COMPLETE)) {
		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
				   phydev->lp_advertising);
		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
		mii_adv_mod_linkmode_adv_t(phydev->lp_advertising, 0);
		...
		return 0;
	}

In that case phy_resolve_aneg_linkmode() resolves speed and duplex
after the base page and 10G link partner bits have been cleared. The
link can then be reported up with an unknown or stale speed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022222955.698722-1-ansuelsmth%40gmail.com
