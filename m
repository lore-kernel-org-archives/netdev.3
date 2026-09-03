Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168237DEAA;
	Thu,  3 Sep 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470810; cv=none; b=LqRM/1651BN1PqlpGaIiVlKxj1w+dR8MTte6ExddKIYmIXg6XUHQICY8zi46fX8sBBssMAuLwglA+CwjWnv0qOf2lr4wvDva5oqpv5G0SzUJK8M5nb1nUROiGdDdh8lVeFAzOlCIjrAawVN11e1TWXwa1VjC+hKe35jrRQzuAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470810; c=relaxed/simple;
	bh=E4zdXifS6EabLM823BiURpyWhwByvuK1FT9JjXB8iqo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iF5GaQIf0mztIDXnwEV01UyJXfPWkVMfBTOWWnQZbX8a71KhDt/43l15KQPv/5mduzR74LXt3M+lE+EG5mstLw6qQEeuAANhAirY8emdIcBwxetjr06D54grtDENqF0hIKhsArJ0PT0J9PtGbKfCJ4G2kJHGgU+nCkbX/eUded8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO5v8yG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO5v8yG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2021F000E9;
	Thu,  3 Sep 2026 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788470808;
	bh=TmxsF8YocUAG377pTVG/evM7jZ0vLFh1Ti8Z3d5fFms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iO5v8yG8NQ3lPQeodQ0avBL0C2ByzjBGsJNuX0YlNIsgNAti5aob/JOJu0/u0i4sN
	 i4bkkzl+3nwHtTrJyDCVxb81/aEsoJs6OrSPaxkpF2LGA9MFth5RpK7fGM5dCxR8qT
	 RVvyFa0pDWYtbSEhXLm7bnmSnWCjredc/TIIvLt4PndpauR6fDMNZL2QlIV6RFA4UT
	 yML52aZlfNuNXG0zJV/gwNXH5ZMkb4GZbbYBiHX9IQwcySArxPkHF5tl+OkC7wtpdf
	 PVez815qpvGrQ8wmb7AFe5kDF/9Xjd0eXuwQWGRHQ0lYhJuIZ6+dkAUro0rP61IR9g
	 X+bDxMYef2qPQ==
Subject:
 Re: [net-next] net: dsa: offer a flowtable to the switch before the conduit
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 21:26:47 +0000
Message-ID: <178847080758.3394541.9994313358533592398@kernel.org>
In-Reply-To: <20260901092546.369232-1-julius@bairaktaris.de>
References: <20260901092546.369232-1-julius@bairaktaris.de>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] dsa_user_setup_tc() now selects the TC_SETUP_FT offload target
  (switch vs. conduit) independently on every call, by probing…
- [Low] The new comment at net/dsa/user.c:1743-1746 says '... only a
  conduit-side flow engine needs the block forwarded, and that forward…

--

net: dsa: offer a flowtable to the switch before the conduit

TC_SETUP_FT is now offered to the switch driver via
ds->ops->port_setup_tc() first, and only forwarded to the conduit netdev
via dsa_user_setup_ft_block() when the switch answers -EOPNOTSUPP. This
lets a switch that owns its own flow engine see a flowtable bound to one
of its user ports.

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef0..c5adb557056f7 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1734,11 +1734,22 @@ static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
>  {
>  	struct dsa_port *dp = dsa_user_to_port(dev);
>  	struct dsa_switch *ds = dp->ds;
> +	int err;
>  
>  	switch (type) {
>  	case TC_SETUP_BLOCK:
>  		return dsa_user_setup_tc_block(dev, type_data);
>  	case TC_SETUP_FT:
> +		/* A switch that owns the flow tables answers for itself; only
> +		 * a conduit-side flow engine needs the block forwarded, and
> +		 * that forward is gone by the time the port is torn down.
> +		 */

[Severity: Low]
The comment says "that forward is gone by the time the port is torn
down", but the statement right below it runs that conduit forward on
every TC_SETUP_FT command, teardown unbind included. After -EOPNOTSUPP
from the switch, dsa_user_setup_ft_block() still resolves
dsa_port_to_conduit() and calls conduit->netdev_ops->ndo_setup_tc().
Nothing suppresses the forward during teardown.

The changelog's argument is about the other direction — a conduit-side
handler reaching back through conduit->dsa_ptr, which does not work
because dsa_tree_teardown() in net/dsa/dsa.c orders the teardown as:

	dsa_tree_teardown_conduit(dst);

	dsa_tree_teardown_ports(dst);

That ordering claim checks out, so this looks like just the comment
wording talking about a route the patch does not take. Could the comment
be reworded so it describes the fallback that is actually emitted here?

> +		if (ds->ops->port_setup_tc) {
> +			err = ds->ops->port_setup_tc(ds, dp->index, type,
> +						     type_data);
> +			if (err != -EOPNOTSUPP)
> +				return err;
> +		}
>  		return dsa_user_setup_ft_block(ds, dp->index, type_data);

[Severity: Medium]
TC_SETUP_FT carries a stateful FLOW_BLOCK_BIND / FLOW_BLOCK_UNBIND pair,
but this picks the offload target fresh on every call from the driver's
return code. Nothing records which side accepted the bind.

If a switch driver's TC_SETUP_FT verdict differs between the bind and the
matching unbind — for example its flow engine is unavailable at bind time
and available later, or offload is toggled at runtime — does the unbind
then land on the other target?

The target that did not see the bind has no matching block_cb, so its
flow_block_cb_lookup() fails and it returns -ENOENT. Since -ENOENT is not
-EOPNOTSUPP, dsa_user_setup_tc() propagates it (and the conduit's return
value is propagated unconditionally by dsa_user_setup_ft_block()).

On the netfilter side that error short-circuits the cleanup in
net/netfilter/nf_flow_table_offload.c:

nf_flow_table_offload_cmd() {
	...
	down_write(&flowtable->flow_block_lock);
	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
	up_write(&flowtable->flow_block_lock);
	if (err < 0)
		return err;
	...
}

nf_flow_table_offload_setup() {
	...
	if (err < 0)
		return err;

	return nf_flow_table_block_setup(flowtable, &bo, cmd);
}

nf_flow_table_block_setup() is the only place an unbind does list_del()
plus flow_block_cb_free(), so does a misrouted unbind leak the
flow_block_cb allocated at bind time, leaving it linked on the owner
driver's private block list with cb_priv pointing at flowtable state that
is going away?

Worth noting no in-tree .port_setup_tc handles TC_SETUP_FT today — they
all return -EOPNOTSUPP unconditionally — so this cannot trigger in tree
right now, and the behaviour of the out-of-tree consumer is unknown.
Would it make sense to decide the target only for FLOW_BLOCK_BIND and
remember it on the port, so the unbind always goes back to whoever
accepted the bind?

>  	default:
>  		break;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901092546.369232-1-julius%40bairaktaris.de
