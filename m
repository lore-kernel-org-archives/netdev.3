Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141574;
	b=3j69UWwG6fTw77/RDl9CxDEmpx4vrNtIcTyQHQB3YQ7xI/ivqqOo8fIPlXAomCiAKGGi
	 IFafbvVcQ1jSN9NTGAxkCGdrJsb5fFnftDRaQsLE2D+rdv5UJedBuKpt3pmGItMIAptJ+
	 oqUOjV3/aUVcYsyA1I9DL/Q+weKW0p/lj67E/5FEW1PW7NKutroS3oa9jLFfkPchPiJH7
	 N/6KHE0qHtOv0tvrquNMWyqpkkzcyB3GlDhLtqW7gRu+2AB5XuElj7lZH6QtXB4jPSogB
	 y5dgza4DIF9uz1ccqVjgKe991WFiILuiVGeBkwF6YJf0Ihg/r4tFDo9I8/PqrZ/c3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141574;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2CtE1xbQJnYr2V8UN6I3X9KLuyotoxUeIkthClIT48g=;
	b=YhaAz+9CUoKPNmvXtPoTUl2cta7NsSORiktpWyo8U4nBpUCmK5pnkwxBKqADndFIYM0B
	 EqHB35Pr9OAtaoyaPw/4eAlFnbA+z2DOMnlLH0tL87RICZ8fWvfjO8HpnTSFmFZ6F9pLI
	 AyWYyPAp5GpsexbvKdnLeblvDejG5PSYXInpb7QxmSdjcs6pnVH4bmSAhnZT6jYaIZM++
	 gESLCVHjnMD+saFp/ttyJbKOBuC6fL/brQ/yEiQkUjVJ0EWEPlo8VWvuCpAMqHVyGQ2+f
	 0lQD0p4YrybwtyKsPX9t6mxSFOcX9ufGh8gnHdfrUj7Pb1wF6AmeJlt0nt2TGON20CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYKTYjq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A3606A336;
	Sun,  8 Nov 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYKTYjq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00431F008A3;
	Sun,  8 Nov 2026 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141574;
	bh=2CtE1xbQJnYr2V8UN6I3X9KLuyotoxUeIkthClIT48g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYKTYjq62Sgrqc4SHsDp1Bt4gv5bDqBfEJTkNKWdJCg5oI06rN18+d7WCfGSS5U53
	 PgOLsX+Fkx/PlV+VofsYO2tBd8t7zcj6XnHx+hpo7HZlOQ1gkcJd8y1fFvJf6DxxSD
	 0R9CY2jAUHY2gorHkBWdWqyT+8dCo76pBj1szF0vpvtueM+BbF5ps+yllE4q5u2Xg6
	 4KCuueylm6vPZVA587SJNIi5Mm8SRmxt5xYNSSVDh/XjDGEeRRn+Nwm0dLsKgWchfW
	 dzf9FPdj1TijrgFg14XZgsZnPZW540BqzBf7tZg/ePmPeDFL0qnIdavEbSnAmAe9im
	 zx8ZCeCYq/9jw==
Subject: Re: [PATCH net-next v4 3/8] net: dsa: motorcomm: Reset port flags on
 bridge leaving
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:33 +0000
Message-ID: <179414157335.994134.3474239739070494244@kernel.org>
In-Reply-To: <20261107121631.1040612-4-mmyangfl@gmail.com>
References: <20261107121631.1040612-4-mmyangfl@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch resets pp->isolated and pp->hairpin in
  yt921x_userport_standalone() when a port leaves a bridge, but nothing…
- [Low] The patch fixes a user-visible forwarding bug: a port that
  rejoins a bridge is programmed with stale hairpin/isolation state in…
- [Low] The new comment in the shared helper yt921x_userport_standalone()
  says "The return value got ignored by DSA core".

--

net: dsa: motorcomm: Reset port flags on bridge leaving

This patch clears the cached pp->hairpin and pp->isolated flags in
yt921x_userport_standalone() when a port leaves a bridge. The goal is to
keep stale BR_HAIRPIN_MODE and BR_ISOLATED state from being programmed
on the next bridge join.

> DSA does not clear BR_HAIRPIN_MODE and BR_ISOLATED when a port leaves
> a bridge, so the cached flags survive into the next bridge join and
> program stale hairpin and port isolation state.
>
> Reset them when leaving the bridge.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>

[Severity: Low]
Should this have a Fixes: tag? The caching of pp->hairpin and
pp->isolated in yt921x_bridge_flags(), with no reset on leave, comes
from the original driver commit:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 47f06945b8c4e..c51491ef4dae5 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -1158,10 +1158,17 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
>
>  static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
>  {
> +	struct yt921x_port *pp = &priv->ports[port];
>  	u32 mask;
>  	u32 ctrl;
>  	int res;
>
> +	/* The return value got ignored by DSA core, reset flags before touching
> +	 * the hardware.
> +	 */

[Severity: Low]
This isn't a bug, but is this comment accurate for both callers of
yt921x_userport_standalone()?

It holds for yt921x_bridge_leave(), which is reached from the void
.port_bridge_leave op. yt921x_port_setup() also calls this helper and
returns its error:

yt921x_port_setup() {
    ...
	res = yt921x_userport_standalone(priv, port);
	if (res)
		return res;
    ...
}

That error goes back through .port_setup, and dsa_port_devlink_setup()
in net/dsa/devlink.c propagates it:

	if (ds->ops->port_setup) {
		err = ds->ops->port_setup(ds, dp->index);
		if (err)
			return err;

Could the reset and this comment go into yt921x_bridge_leave() instead?

> +	pp->hairpin = false;
> +	pp->isolated = false;

[Severity: High]
Now that the cached flags are cleared on leave, does anything restore
them on the next join?

dsa_port_inherit_brport_flags() in net/dsa/port.c only replays this
set:

	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
				   BR_BCAST_FLOOD | BR_PORT_LOCKED;

So BR_ISOLATED and BR_HAIRPIN_MODE on the bridge port never reach the
driver on join. The bridge doesn't replay brport flags either.
nbp_switchdev_sync_objs() only replays VLAN, MDB and FDB objects.

This driver implements .port_lag_join. Take a bond that is a bridge
port and already has "bridge link set dev bond0 isolated on" (or
"hairpin on") applied, so yt921x_bridge_flags() has cached the flag on
each yt921x member.

Then a member leaves the bond and rejoins, or a new member is added:

dsa_port_lag_leave()
  dsa_port_bridge_leave()
    yt921x_dsa_port_bridge_leave()
      yt921x_bridge_leave()
        yt921x_userport_standalone()
          pp->hairpin = false;
          pp->isolated = false;

dsa_port_lag_join()
  dsa_port_bridge_join()
    yt921x_dsa_port_bridge_join()
      yt921x_bridge_join()
        yt921x_bridge()

yt921x_bridge() builds YT921X_PORTn_ISOLATION(port) only from the
cache:

		ctrl = ~ports_mask;
		if (pp->isolated)
			ctrl |= isolated_mask;
		if (!pp->hairpin)
			ctrl |= BIT(port);

Wouldn't this leave the port without isolation and hairpin in hardware?
It would also be dropped from isolated_mask for the other isolated
ports. Meanwhile "bridge link show" still reports bond0 as isolated, and
the hardware stays wrong until the user toggles the flag again.

Before this patch, the stale cache happened to keep a rejoining member
correct, so the rejoin case looks like a regression. The commit message
says the aim is correct hairpin and isolation state on the next bridge
join, and this LAG path still doesn't get there.

Would it be better to sync these flags on join? One way is to add
BR_HAIRPIN_MODE | BR_ISOLATED to the inherit and clear masks in
net/dsa/port.c, which would make the driver-local reset unnecessary.
Another is to read br_port_flag_is_set() on the bridge port in the
driver's bridge join path.

> +
>  	ctrl = ~priv->cpu_ports_mask;
>  	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
>  	if (res)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
