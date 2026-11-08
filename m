Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143819;
	b=EqQRvNwBSRdawhceN2NI9VSlQ6E7IVsPslVdvMSu53pb5BvfME4PBWCat8W8ZkDT4VNZ
	 FsCJkf+qILsJcp6QaEFS21MB69I1AxHHm1OpmOjMJkY+vPlCS6xf1TD3Pvprt2PYpfhCs
	 Xzaum4hN7J5ns0O9LyWfnsoVc7cBfkfTP1x+xoNxCDeBxvORQqrfMtMTTT3wUNoWnc9ij
	 BXS1YEsgfakzW8H5VATjHlOLrOuakD3//PhBT52fjDNEMhq3aYfkXOXnhciXrHe7wnaeq
	 vZEKeEz2IYm97YFepQg3GUFst/F/6KcQEhzcS7eD7APfPOoNhgpVGCfjtQFuCqYz6Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143819;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JJxNTB9eCOe/pFt54aN+l5cQw4iYZx9PorRckcs6gdQ=;
	b=KeY+GDID8Y7M47V4e5LljjfXAbTiPQUIS9K+k3IgwPTBGjSREB8YGdZeed1xPhotN+oW
	 uE2hSp0ES2Czg/6Uw1/3IeTCn01sv98vXve/2IYOoufuKXj8Xgah6g+bHKpLY0n+ujBl6
	 5UsSjJ8vzO8BIZuLF5J/A6NVQqHgbg2EpufprXR6gfT0q2k/P0XAL2I8RLNiYnOZuMfaE
	 36tVFcQ7HBXNYknFCvyDaUmNYC3OqrNskRpMoXxAd393r9g6LI2/cdB4llD2tbuY8aYx2
	 LuqKufLHxDztL5PgHKts4cUTkPMxsUFJZZqhrdeBgZQ3+H1oGZFPhlinKl8UBxIwb4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwWxL12V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A399606A31C;
	Sun,  8 Nov 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwWxL12V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610821F0089F;
	Sun,  8 Nov 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143818;
	bh=JJxNTB9eCOe/pFt54aN+l5cQw4iYZx9PorRckcs6gdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwWxL12VW8wXib5rkzi0bjImamFqNFpn1HCyZW61SWsB9qe6eDK10uNY2tOmWjEtj
	 60kIctPb8gPxRoYpfr0uyqEXGrK8aMNIxvj7P4nwZe7GDDMjmMRZmdFMUI5R0syDwS
	 I0ifTKmsEHrA2BEbAOlBgREQqIEtYrc89gLBlrweMGfdwCb157E4G3h6A2Au3tAZSO
	 T8UFAUcAofKNKNvxIR8MNSyZrvA2yr0N5DSLmINT63Puv10YWq9M+dzV0XrL3IBllp
	 n7fKcF9XrPcMuUTQGx3yAdl2VzriXIShX2XMC59myMVjp2kykAJHjvYWoyVsPXTauP
	 tD6OaHvaoQEaA==
Subject:
 Re: [PATCH net v1 1/1] net: phylink: keep initial advertising settings
From: netdev-bot+sashiko@kernel.org
To: thi.zirnstein@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 13:16:57 +0000
Message-ID: <179414381793.994134.3838415671926603542@kernel.org>
In-Reply-To: <20261104125509.3221743-1-thi.zirnstein@gmail.com>
References: <20261104125509.3221743-1-thi.zirnstein@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In phylink_bringup_phy() (drivers/net/phy/phylink.c:2323), the
  new linkmode_and() limits the PHY's validated advertisement to…
- [High] phylink_bringup_phy() now reads pl->link_config.advertising as
  the user's requested advertisement.
- [High] For a PHY on an SFP module, phylink_sfp_config_phy() calls
  phylink_bringup_phy() (line 3891) before phylink_sfp_set_config()…
- [Medium] The fix carries over only part of a pre-open link
  configuration.
- [Medium] phylink_bringup_phy() can now give phylib an autoneg
  advertisement with no link modes in it.

--

net: phylink: keep initial advertising settings

This patch keeps an advertisement that was set through ethtool before the
MAC driver connects the PHY in ndo_open. phylink_bringup_phy() now ANDs
the PHY's validated advertisement with pl->link_config.advertising. The
result is stored back into both pl->link_config.advertising and
phy->advertising.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index e885da1c28311..145f181bc9d37 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2320,6 +2320,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>  	pl->phy_state.duplex = DUPLEX_UNKNOWN;
>  	pl->phy_state.rate_matching = RATE_MATCH_NONE;
>  	linkmode_copy(pl->supported, supported);
> +	linkmode_and(config.advertising, config.advertising, pl->link_config.advertising);

[Severity: High]
Can this narrow the PHY advertisement on the first ndo_open, before the
user has configured anything?

If nothing has been set through ethtool, pl->link_config.advertising
still holds the default from phylink_create(), or from
phylink_parse_mode() for in-band:

    linkmode_fill(pl->supported);
    linkmode_copy(pl->link_config.advertising, pl->supported);
    phylink_validate(pl, pl->supported, &pl->link_config);

That mask is validated only for the DT phy-mode, with rate_matching left
at RATE_MATCH_NONE.

phylink_validate_phy() deliberately validates more widely. It uses
phy->possible_interfaces or the PHY's rate matching mode, and for C45
PHYs it does this:

    if (phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
        ...)
        state->interface = PHY_INTERFACE_MODE_NA;

The AND here undoes that widening, and the narrowed result is then
copied into phy->advertising.

Two examples:

- phy-mode = "10gbase-r" with an 88X3310 or AQR class PHY: the default
  only has MAC_10000FD modes.
- phy-mode = "2500base-x" with an RTL8221B class PHY: only MAC_2500FD
  survives.

Wouldn't the PHY then advertise only 10GBASE-T (or 2500BASE-T)? Before
this patch it could link with lower speed partners; after it, those
links would fail.

The AND can't tell a user setting apart from phylink's own
interface-limited default. Would user intent need to be tracked
separately?

[Severity: Medium]
Can the intersection end up with no link modes here?

The AND runs after phylink_validate_phy(). Nothing checks for an empty
result or re-validates it before it is copied into phy->advertising.

While no PHY is attached, pl->supported holds every MAC mode for the
interface. For MAC_1000FD that includes 1000baseX_Full and
1000baseKX_Full. So "ethtool -s ethX advertise 1000baseX/Full" is
accepted while the interface is down.

At ndo_open, ANDing the copper PHY's baseT modes with that mask leaves
only Autoneg and Pause. phydev->autoneg stays enabled.

The other two configuration paths reject this state.
phylink_ethtool_ksettings_set() has:

    /* If autonegotiation is enabled, we must have an advertisement */
    if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
                          config.advertising) &&
        phylink_is_empty_linkmode(config.advertising))
        return -EINVAL;

phy_ethtool_ksettings_set() also returns -EINVAL for an empty
advertisement with autoneg enabled.

phylink_bringup_phy() returns 0 here, and the link silently never comes
up. Should the result be checked, or fall back to the PHY's validated
advertisement?

The missing check also turns the stale link_config and SFP cases below
into a total link loss.

>  	linkmode_copy(pl->link_config.advertising, config.advertising);

[Severity: High]
Does pl->link_config.advertising still reflect what the user asked for
once a PHY has been attached?

With a PHY present, phylink_ethtool_ksettings_set() passes the request
to phylib and returns without touching link_config:

    /* We can rely on phylib for this update; we also do not need
     * to update the pl->link_config settings:
     ...
     */
    return phy_ethtool_ksettings_set(pl->phydev, &phy_kset);

This line writes the intersection back into pl->link_config.advertising,
and phylink_disconnect_phy() never resets it. Non-genphy PHY drivers
also keep phy->advertising across phy_detach() and phy_attach(). On
macb, stmmac, r8169 and tn40xx, the mask can therefore only lose bits
across ndo_stop and ndo_open.

Two sequences show this:

(a) "ethtool -s advertise 100baseT/Full" while up, then ifdown/ifup,
leaves link_config at {100M}. A later ethtool -s with the full set
while up is reverted to {100M} at the next ifdown/ifup.

(b) "ethtool -s advertise 100baseT/Full", ifdown/ifup, then
"ethtool -s advertise 1000baseT/Full", ifdown/ifup, gives {1G} AND
{100M}.

In case (b) only the Autoneg and Pause bits are left. Wouldn't the PHY
then advertise no speed modes, so the link never comes up until the
driver is rebound?

[Severity: High]
How does this behave for PHYs on SFP modules?

phylink_sfp_config_phy() calls phylink_bringup_phy() before it updates
link_config for the new module:

    ret = phylink_bringup_phy(pl, phy, config.interface);
    ...
    phylink_sfp_set_config(pl, support, &config, true);

So the AND uses whatever pl->link_config.advertising was left by the
cage default or by a previously inserted module. Neither module removal
nor PHY disconnect resets it.

Some examples:

(1) A 1000BASE-SX module leaves {1000baseX_Full, Autoneg, Pause, FIBRE}.
If a copper SGMII module (e.g. 88E1111) is inserted next, its baseT
modes are ANDed with that mask, which has no speed bits.

(2) If an optical module's only interface has no in-band AN,
phylink_sfp_config_optical() calls linkmode_zero(config.advertising).
That leaves link_config.advertising entirely zero for the next copper
SFP PHY.

(3) A cage with managed = "in-band-status" and phy-mode 1000base-x only
gets MAC_1000FD modes from phylink_parse_mode(). Even the first copper
module inserted would lose its 10/100 modes.

Right after bringup, phylink_sfp_set_config() overwrites
link_config.advertising with the module's full mask. Doesn't that leave
phylink's recorded advertisement out of sync with what the PHY was
actually programmed with?

>  
>  	/* Restrict the phy advertisement according to the MAC support. */

[Severity: Medium]
Is only half of a forced link configuration set before open carried
over here?

Without a PHY, phylink_ethtool_ksettings_set() handles
"ethtool -s ethX autoneg off speed 100 duplex full" in two steps. It
stores the speed and duplex in link_config.speed and
link_config.duplex, and it clears the Autoneg bit:

    linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising,
                     kset->base.autoneg == AUTONEG_ENABLE);

At bringup only the bitmap is applied, through the new AND and the
following linkmode_copy(phy->advertising, config.advertising).
phydev->autoneg, phydev->speed and phydev->duplex are never updated.

So the PHY keeps autonegotiating and ignores the forced mode, as it did
before the patch. The difference is that phy->advertising now lacks the
Autoneg bit while phydev->autoneg is still AUTONEG_ENABLE.

phy_ethtool_ksettings_set() always keeps these two consistent. Is this
a state phylib expects? ethtool would now report autoneg on while
Autoneg is not advertised.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104125509.3221743-1-thi.zirnstein%40gmail.com
