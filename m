Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3A3CD8C5;
	Tue,  8 Sep 2026 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902970; cv=none; b=ZD8OB/BK8HIuYSLZvKvSgfPRYvO23Z9bMFqjaRXG0CVMIi4P7ALDcRCJOZ6e/Nm2ANUrnOcxRqlnZga21qEeTh9MYUmry3arZIwmguujzO+8InK799xGgi3eUFNJ1c/N9ZQ1J8bUemmfSXOiXeUmImmod8YLfSV1GT0tdv9avJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902970; c=relaxed/simple;
	bh=qfbMHYA1rnsnS+wCwHK4hA78rkF64Le4RDDZQqsQO3I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDdv0e+ykN+L8xytJDi1RaWsixkQi9FlHDlKV6Q0S4/xR8tNgy3bZjMsp7ihDy94KVGzvv9d2AU2mLMS/jqJoh4kbFU00vGMbMh3XvIbAOYupgsnzBzFZ9jLF4MKL/ADDPkYPBDrk4dAioneNLnnn/syFcYBbpgYHTxDnzkiit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgMWmSbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgMWmSbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAA81F00A3A;
	Tue,  8 Sep 2026 21:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788902968;
	bh=2NCnbVVA50ISfSgF6TALpBu2EUqliYaoDQ5hYa1n6eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IgMWmSbgRLYcAUThX3rqvn4q8pmFu4XDgloLUmXqx39N92bcdM4HWZQJ60RmzTTjI
	 PtEuhr/RX8hHnEq6LqA1NIzWrsahRMI0H/+iCtwfjiOc7Zn0eeWbNnS932YJXDFhQ2
	 ssw6kSqPOaEwhQ3VP7w3P+o6pVgKdftdXOK/YAop7kD2Sb4rhumC0F7YalDsA3LYyg
	 UEV7xhmJ7hXcodjyexOiyfK+p3zox6sZRXsIetsLx8U90FD9wuE3tmc1lvNfo/N63c
	 FuksSbpLzYqRZYNlZDvbgIfDb7aO8dQGvpJi+C6PB5xQ1TID/X+cFb2ea8BR2BpkoB
	 PfULEZ1DFGWuQ==
Subject: Re: [PATCH net-next v2] net: dsa: offer a flowtable to the switch
 before the conduit
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pablo@netfilter.org
Date: Tue, 08 Sep 2026 21:29:27 +0000
Message-ID: <178890296755.219967.950265760360964191@kernel.org>
In-Reply-To: <20260904092719.534318-1-julius@bairaktaris.de>
References: <20260904092719.534318-1-julius@bairaktaris.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] dsa_user_setup_ft_block() (net/dsa/user.c:1721) records which
  side accepted a flowtable bind in a single per-port boolean,…
- [Medium] In dsa_user_setup_ft_block() (net/dsa/user.c:1734) the
  ownership record is computed as `dp->ft_on_switch = err !=…

--

net: dsa: offer a flowtable to the switch before the conduit

TC_SETUP_FT on a DSA user port is now offered to the switch driver via
ds->ops->port_setup_tc first, and only forwarded to the conduit netdev when
the switch answers -EOPNOTSUPP.  The side that accepted the bind is recorded
in a new per-port boolean, dp->ft_on_switch, so that the matching unbind is
sent to the same side.

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 7507d632e7c6d..dbcb02de06fce 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -297,6 +297,12 @@ struct dsa_port {
>  
>  	u8			setup:1;
>  
> +	/* Flowtable blocks on this user port go to the switch, not the
> +	 * conduit; decided at bind time. Written without rtnl, so not one of
> +	 * the bit fields above.
> +	 */
> +	bool			ft_on_switch;
> +

[Severity: High]
Can a single boolean per dsa_port track something the flow block API keys
per block?

nf_flow_table_block_offload_init() sets bo->block = &flowtable->flow_block,
so each flowtable is a distinct binding.  And more than one flowtable can
bind the same DSA user netdev, because the duplicate device check in
nft_register_flowtable_net_hooks() only looks at flowtables of the same nft
table:

net/netfilter/nf_tables_api.c:nft_register_flowtable_net_hooks() {
	list_for_each_entry(ft, &table->flowtables, list) {
		if (!nft_is_active_next(net, ft))
			continue;
		if (nft_hook_list_find(&ft->hook_list, hook)) {
			err = -EEXIST;
			...
}

Two flowtables in two different nft tables therefore produce two independent
FLOW_BLOCK_BINDs on the same port, and both write the one flag.  Compare
with dsa_user_setup_tc_block(), which keys the block on f->block via
flow_block_cb_lookup().

>  	struct device_node	*dn;
>  	unsigned int		ageing_time;
>  
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef0..f4cd48df2519d 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1718,15 +1718,30 @@ static int dsa_user_setup_tc_block(struct net_device *dev,
>  	}
>  }
>  
> -static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
> -				   void *type_data)
> +static int dsa_user_setup_ft_block(struct dsa_port *dp,
> +				   struct flow_block_offload *bo)
>  {
> -	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
> +	struct net_device *conduit = dsa_port_to_conduit(dp);
> +	struct dsa_switch *ds = dp->ds;
> +	int err;
> +
> +	/* The unbind goes to the side that took the bind. */
> +	if (bo->command == FLOW_BLOCK_BIND) {
> +		err = -EOPNOTSUPP;
> +		if (ds->ops->port_setup_tc)
> +			err = ds->ops->port_setup_tc(ds, dp->index, TC_SETUP_FT,
> +						     bo);
> +		dp->ft_on_switch = err != -EOPNOTSUPP;
> +		if (dp->ft_on_switch)
> +			return err;
> +	} else if (dp->ft_on_switch) {
> +		return ds->ops->port_setup_tc(ds, dp->index, TC_SETUP_FT, bo);
> +	}

[Severity: High]
Following on from the per-block question above: since each
FLOW_BLOCK_BIND overwrites dp->ft_on_switch, and the FLOW_BLOCK_UNBIND
routing decision reads only that flag and never looks at bo->block, can an
unbind reach the side that never took the bind?

	BIND(FT_A)   switch returns 0            -> ft_on_switch = true
	BIND(FT_B)   switch has no room for a
	             second block, -EOPNOTSUPP   -> ft_on_switch = false,
	                                            conduit takes FT_B
	UNBIND(FT_A) reads false                 -> goes to the conduit

The conduit provider looks its block up by bo->block, so it simply fails:

drivers/net/ethernet/mediatek/mtk_ppe_offload.c:mtk_eth_setup_tc_block() {
	...
	block_cb = flow_block_cb_lookup(f->block, cb, dev);
	if (!block_cb)
		return -ENOENT;
	...
}

nft_unregister_flowtable_ops() discards that error, and
nf_flow_table_offload_setup() returns before reaching the freeing loop in
nf_flow_table_block_setup():

net/netfilter/nf_flow_table_offload.c:nf_flow_table_block_setup() {
	...
	case FLOW_BLOCK_UNBIND:
		list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
			list_del(&block_cb->list);
			flow_block_cb_free(block_cb);
	...
}

nf_flow_table_free() has no leftover-cb cleanup either.  Does the switch's
flow_block_cb then stay linked on the driver's block list with ->block
pointing into the freed nf_flowtable, with the hardware offload entries
never torn down, so that a later flow_block_cb_lookup() can match a stale
cb if a new flowtable is allocated at the same address?  The mirrored
ordering (switch answers -EOPNOTSUPP for FT_A, accepts FT_B) sends a
conduit-owned unbind to the switch instead.

Would keying the ownership on bo->block, the way dsa_user_setup_tc_block()
does, avoid this?

[Severity: Medium]
Separately, should ft_on_switch be set for a bind that failed?

	dp->ft_on_switch = err != -EOPNOTSUPP;
	if (dp->ft_on_switch)
		return err;

Any hard error from ds->ops->port_setup_tc() (-ENOMEM, -EBUSY, -ENOSPC)
also satisfies err != -EOPNOTSUPP, so the port is latched as "the switch
owns the flowtable block" although nothing was bound anywhere -- the switch
failed, and the conduit was never offered the bind because of the early
return.  Nothing clears the flag afterwards; it is only recomputed on the
next FLOW_BLOCK_BIND, never on unbind.

An unbind for a different block that the conduit genuinely holds on the
same port then takes the else-if branch and is delivered to the switch:

	BIND(FT_A)   switch -EOPNOTSUPP     -> conduit takes FT_A
	BIND(FT_B)   switch -ENOMEM         -> ft_on_switch = true, err
	                                       returned, nothing bound
	UNBIND(FT_A) reads true             -> goes to the switch

The conduit's flow_block_cb for FT_A is then never removed and keeps a
->block pointer into the freed flowtable.  Should the flag only be set when
the switch actually accepted the bind, that is err == 0?

>  
>  	if (!conduit->netdev_ops->ndo_setup_tc)
>  		return -EOPNOTSUPP;
>  
> -	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
> +	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, bo);
>  }
>  

[ ... ]

For both of the above: no in-tree .port_setup_tc handles TC_SETUP_FT today
(hellcreek, ksz, yt921x, mt753x, felix/vsc9959 and sja1105 all return
-EOPNOTSUPP), so the switch branch is not reachable in mainline yet, but
this patch is what enables such drivers.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904092719.534318-1-julius%40bairaktaris.de
