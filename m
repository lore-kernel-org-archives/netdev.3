Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8823217723;
	Tue,  6 Oct 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294210; cv=none; b=mJq9xnLgL/DSn0Cs+TopsWCkHvu3ZeLB3XY4v3sTh2puBhNTPTh3KBk3SR55oLRnajQIovGHw633+ywY/6GP22u+c5sUHMNLv8xffJsY2b639Aoq2pCqKCXuOWPFbHTSan5u/oZItgU6WFP5P5l7ZI+81Tea9e4hm/iOCvEz0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294210; c=relaxed/simple;
	bh=8U9GnErbDsf2kHH1JPDd3UUobu3eyAZA7A3AOa+RH8w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gql8mrghFKOSI+TTkqDaAQGXYAbld48OR2YJ3pisad8uk/ac9iztxd3fD/lZZMFXQhoYLvwGvOysJ5xY8tWaYaxVhayx9p42DP4jGlgZg6sMAu9vuDRKg2nT8n7KExJkshrBXp16M8JUvYaerBujZUHVc5ld5bc/KTHhU57w/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1Tpzb91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1Tpzb91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89791F00893;
	Tue,  6 Oct 2026 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791294208;
	bh=gsT88yf6ktOV9eBXZ33Whoz3ZQvlrYk4G0P/0W0bjuM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W1Tpzb91zOsoFY72ciwlfFgKRsoOGqnhIWoy6d3x+SCDFTZ+qd012bxdl4jKI+1VG
	 jwCECh8e5OokBl/1HQ8gYnYvlKecRJI4vqjCbkzdR1IZY5bCzX5vAycNNrIq/FlLpy
	 WOzYasQ8eQexsHsdgRnFVvqANW382n9K4qZDfEU8u5MGNqVXit1Kg6QX1usndrtCfn
	 KJbjYYHGhI69O0VJAfniiMImZz4Nb6eAa1QjfYam3sm/ij+ArdbkcEK3V/3DOUGaGS
	 CrDJa1ZQnEAR/PQfftsP9QWkAG/BRVMPf3DkORgh5NKNTMvlP49eeoIrLxitxJ43YC
	 ytWhVpIBLPTSQ==
Subject: Re: [PATCH net-next v1 8/8] net: dsa: realtek: rtl8365mb: offload DCB
 DSCP-to-priority
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, alvin.sipraga@analog.com,
 netdev@vger.kernel.org, horms@kernel.org
Date: Tue, 06 Oct 2026 13:43:27 +0000
Message-ID: <179129420724.434549.17466133665783916588@kernel.org>
In-Reply-To: <20261002115850.962676-9-o.rempel@pengutronix.de>
References: <20261002115850.962676-9-o.rempel@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rtl8365mb_port_del_dscp_prio()
  (drivers/net/dsa/realtek/rtl8365mb_dcb.c:410-434) decides whether to…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but setting
  ds->dscp_prio_mapping_is_global in rtl8365mb_setup() makes it…

--

net: dsa: realtek: rtl8365mb: offload DCB DSCP-to-priority

This patch wires up the port_get_dscp_prio, port_add_dscp_prio and
port_del_dscp_prio DSA callbacks, so dcbnl can program the switch-wide
DSCP-to-priority table. It also sets ds->dscp_prio_mapping_is_global. The
table starts with the IETF default mapping, and del reverts an entry to
that default only when the hardware still holds the priority being removed.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_dcb.c b/drivers/net/dsa/realtek/rtl8365mb_dcb.c
> index 4afcae6e85a1e..091dc8189e738 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_dcb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_dcb.c

[ ... ]

> @@ -324,6 +364,75 @@ int rtl8365mb_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)

[ ... ]

> +int rtl8365mb_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
> +				 u8 prio)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	int tt, ret;
> +
> +	if (dscp >= RTL8365MB_DSCP_MAX)
> +		return -EINVAL;
> +
> +	/* dcbnl replaces an entry by adding the new one before deleting the
> +	 * old, so only revert if the table still holds the removed priority.
> +	 */
> +	ret = rtl8365mb_port_get_dscp_prio(ds, port, dscp);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != prio)
> +		return 0;
> +
> +	/* Revert to the standard IETF default mapping for this DSCP. */
> +	tt = ietf_dscp_to_ieee8021q_tt(dscp);
> +	if (tt < 0)
> +		return tt;
> +
> +	return rtl8365mb_qos_set_dscp_prio(priv, dscp, tt);
> +}

[Severity: Medium]
Can the hardware DSCP table get out of sync with dcbnl when the same DSCP
has more than one APP entry?

The DSA core removes the APP entry first. It then calls the driver and
passes only the removed priority:

net/dsa/user.c:dsa_user_dcbnl_del_dscp_prio() {
    ...
	err = dcb_ieee_delapp(dev, app);
	if (err)
		return err;

	err = ds->ops->port_del_dscp_prio(ds, port, dscp, app->priority);
    ...
}

dcb_app_add() inserts at the head of the list, and dcb_ieee_getapp_mask()
reports only the first match. After a delete, the effective software
mapping is the newest entry that is left. Nothing writes that entry to the
hardware.

For example, dsa_user_dcbnl_init() first sets DSCP 0 to PCP 0. Then:

  dcb app add dev swpX dscp-prio 0:3    APP {3,0}, HW 3
  dcb app add dev swpX dscp-prio 0:5    APP {5,3,0}, HW 5
  dcb app del dev swpX dscp-prio 0:5    APP {3,0}, HW reverted to 0

Every step returns success, and the global setdel copies the APP state to
all user ports. Those ports then report DSCP 0 -> 3, while the shared
table classifies DSCP-trusting traffic as priority 0.

The rollback in dsa_user_dcbnl_add_dscp_prio() seems to have the same
problem:

	err = dsa_user_dcbnl_ieee_global_dscp_setdel(dev, app, false);
	if (err) {
		if (ds->ops->port_del_dscp_prio)
			ds->ops->port_del_dscp_prio(ds, port, dscp, new_prio);
		dcb_ieee_delapp(dev, app);
		return err;
	}

If copying to a peer port fails, the hardware gets the IETF default
instead of the previous user mapping, which stays in the APP table.

A plain dcb app replace (add the new entry, then delete the old one) does
work, because the delete takes the ret != prio early return.

Could the delete path instead program whatever dcb_ieee_getapp_mask()
reports for dsa_to_port(ds, port)->user? The core has already updated that
table. It would then fall back to ietf_dscp_to_ieee8021q_tt() only when no
entry remains, similar to dsa_user_dcbnl_del_default_prio(). ocelot, KSZ
and yt921x use the same heuristic as this patch.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 77f971abf783f..9fe87c2957959 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -3283,6 +3283,7 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  	/* Establish a defined QoS baseline: program the priority-to-queue map
>  	 * for the chip's queue count and trust only the port default priority.
>  	 */
> +	ds->dscp_prio_mapping_is_global = true;
>  	ret = rtl8365mb_dcb_init(ds);
>  	if (ret)
>  		goto out_teardown_irq;

[Severity: High]
This isn't a bug introduced by this patch, but setting this flag makes an
existing race in the DSA core reachable on rtl8365mb.

dsa_user_dcbnl_ieee_global_dscp_setdel() calls dcb_ieee_setapp() or
dcb_ieee_delapp() on any peer netdev that is not NULL. It does not check
whether the peer is registered, and it holds no reference:

	dsa_switch_for_each_user_port(other_dp, ds) {
		struct net_device *user = other_dp->user;

		if (!user || user == dev)
			continue;

		err = setdel(user, app);

dsa_user_create() sets port->user before it takes RTNL. If PHY setup
fails, it frees the netdev without holding RTNL:

net/dsa/user.c:dsa_user_create() {
    ...
	port->user = user_dev;
	dsa_user_setup_tagger(user_dev);

	netif_carrier_off(user_dev);

	ret = dsa_user_phy_setup(user_dev);
	if (ret) {
		...
		goto out_gcells;
	}

	rtnl_lock();
    ...
out_gcells:
	gro_cells_destroy(&p->gcells);
out_free:
	free_netdev(user_dev);
	port->user = NULL;
    ...
}

User ports are created one at a time, and RTNL is released after each port
is registered. So this sequence looks possible:

CPU1 (RTM_SETDCB on registered port N, under RTNL)
dsa_user_dcbnl_add_dscp_prio()
  dsa_user_dcbnl_ieee_global_dscp_setdel()
    user = other_dp->user;          /* port N+1, not yet registered */
                                    CPU2
                                    dsa_user_create() for port N+1
                                      dsa_user_phy_setup() fails
                                      free_netdev(user_dev);
    dcb_ieee_setapp(user, app)      /* user is freed */

free_netdev() frees a NETREG_UNINITIALIZED device right away. Could this
be a use-after-free of the peer net_device?

Even when PHY setup succeeds, wouldn't the global setdel add APP entries
keyed on the unregistered device's ifindex 0? Those entries would be left
orphaned in dcb_app_list.

KSZ (ksz8, ksz9477, lan937x) and yt921x set the same flag, so they are
already exposed to this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002115850.962676-1-o.rempel%40pengutronix.de
