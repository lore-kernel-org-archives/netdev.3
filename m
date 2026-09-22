Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05041A575;
	Tue, 22 Sep 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065560; cv=none; b=qgbOfKO3zKfBnUNev4K46Ur4ZWolPwgZN+v2q6n58AYmd2MA4vskVmxh/4FNxGV0si4NqItZtAsuePu/Se+sPhFWrDfZ2Y0d2ZZS9F7LLr7QoUs8LGcb+/ziFKkXbF0BAzJhgVzE/L0SWBITZtFCWwk1EunSMoNWMJXVzeeZ2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065560; c=relaxed/simple;
	bh=mMEIIoOdYTJUQW2p0/f947uSfSjO6rcPNj+7HsYpzHA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bu3zHZyt+cNu/teGn9yco31UELHwTp+JFdww3Q6JGDV9Z5YbdWdybQF8GKEa5pZh82qUaD5DF3P/QTpxtUDgMzvyWTGdjjyAqZgOMy8OsxxD+FmxKP3ap7O8PgS4FQBemzOpgbWDa8Y9qPeWhT3buGismDe/fQbgpWjT5mN6TZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE0qgTqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE0qgTqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9F01F00893;
	Tue, 22 Sep 2026 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065557;
	bh=gKsgMsyGsgmwQGIE3dT63RWCcKcd+/cTZcSWx6sctCQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AE0qgTqCVFFr+fbZEEbOvw3z27IvW0ejZN4TmA8QO5KM2ZWw7kd2SeChBWTEBg05s
	 pyqxHjZY5HqCrK8zeH29WSx/X7EW4g5yGQ8r5BvGw/JptVlCou7H/anpCzroEdXL4Z
	 nONUQ+aHQAdcVE0FLMyFos2PhNPjcPvKMOrqpMvcgz//k1hBHilKdPZS/z3rBvl2uU
	 gota2LCC4LEFqLDRgUI/XNyzunvjXLfb1OwfGGdy1ZAScxOai2jyaJBU9jUVxt7RY+
	 1c18QHAfI/bW4lOlP8QUlEjQmVHE33+LYzCWBEx8mSB2LMLIS/LaiV40gySVFcRFvD
	 lOIg8EDeKd0mw==
Subject: Re: [PATCH v4 net-next 5/8] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, linux@armlinux.org.uk,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 22 Sep 2026 08:25:56 +0000
Message-ID: <179006555627.2160803.12045711758819504557@kernel.org>
In-Reply-To: <20260918072852.501420-6-wei.fang@oss.nxp.com>
References: <20260918072852.501420-6-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's impact assessment is factually wrong for
  the very path this patch reorders.
- [Medium] netc_port_set_host_flood()
  (drivers/net/dsa/netc/netc_main.c:1807-1821) now destroys the working…
- [Low] The patch fixes a real, user-visible defect (a failed
  ntmp_ipft_delete_entry() during host-flood rule replacement left an…
- [Low] The new error message added in netc_port_bridge_join() prints the
  port index with %u although `port` is declared `int` by the…
- [Low] netc_port_set_host_flood() now deletes the existing host-flood
  IPFT entry before installing the replacement (netc_main.c:1807-1821),…

--

net: dsa: netc: check return value of ntmp_ipft_delete_entry()

This makes netc_port_remove_host_flood() propagate the error from
ntmp_ipft_delete_entry() and only clear np->ipft_hf_eid, np->uc, np->mc
and NETC_PIPFCR once the entry has actually been removed.  As a result
netc_port_set_host_flood() now deletes the old IPFT host flood entry
before adding the new one, and netc_port_bridge_join() removes the rule
early and restores it on the error path.

A few questions below about the changelog and about the new ordering.

> net: dsa: netc: check return value of ntmp_ipft_delete_entry()
>
> ntmp_ipft_delete_entry() may fail, but the driver ignored its return
> value, so a failed deletion left the IPFT entry untracked and
> impossible to clean up later. This is harmless today because the port
> also disables its ingress port filter table lookup, so the leftover
> entry is never matched.

[Severity: Medium]
Is the "harmless today" statement accurate for the replacement path that
this patch reorders?

In the pre-patch netc_port_set_host_flood(), the new rule was added
first, which sets np->ipft_hf_eid to the new entry ID and writes
NETC_PIPFCR = PIPFCR_EN, and only afterwards was the old ID deleted:

	old_entry_id = np->ipft_hf_eid;

	if (netc_port_add_host_flood_rule(np, uc, mc)) {
	...
	/* Remove the old host flood entry */
	netc_port_remove_host_flood(np, old_entry_id);

The old helper only disabled the lookup when the deleted ID matched the
tracked one:

	if (np->ipft_hf_eid == entry_id)
		disable_host_flood = true;

Since np->ipft_hf_eid had already been updated to the new entry, that
condition was false here, so NETC_PIPFCR = 0 was never written.  Doesn't
that mean a failed delete left an active, untracked IPFT redirect entry
with the lookup still enabled, rather than an entry that "is never
matched"?

For the promisc to allmulti-only transition (uc=1,mc=1 to uc=0,mc=1) the
stale entry has an empty DMAC mask, so it matches every frame from that
source port and redirects it to the host.  Would the port then stay
effectively promiscuous after userspace disabled promiscuous mode, with
the ternary IPFT entry leaked permanently because its ID is no longer
recorded anywhere?

The delete can fail in practice: ntmp_ipft_delete_entry() ->
ntmp_delete_entry_by_id() -> ntmp_alloc_data_mem() can return -ENOMEM
from dma_alloc_coherent(GFP_KERNEL), and netc_xmit_ntmp_cmd() can return
-EBUSY, -ETIMEDOUT (read_poll_timeout() on cbdr->regs.cir) or -EIO.

Could the changelog be updated to describe the actual impact?

> Signed-off-by: Wei Fang <wei.fang@nxp.com>

[Severity: Low]
Should this carry a Fixes: tag?  The ignored return value together with
the add-before-delete ordering came in with commit 46d6407692c80b258ecba3af831130a6f6e2feea ("net: dsa: netc: add FDB,
STP, MTU, port setup and host flooding support"), which is already in
the tree, and the effect described above (a port keeping a redirect the
current RX flags no longer request, plus a leaked TCAM entry) is user
visible.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index c590931a4e1b..082ed9405868 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> @@ -1761,32 +1755,31 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
>  	return err;
>  }
>  
> -static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
> +static int netc_port_remove_host_flood(struct netc_port *np)
>  {
>  	struct netc_switch *priv = np->switch_priv;
> -	bool disable_host_flood = false;
> +	u32 entry_id = np->ipft_hf_eid;
> +	int err;
>  
>  	if (entry_id == NTMP_NULL_ENTRY_ID)
> -		return;
> +		return 0;
>  
> -	if (np->ipft_hf_eid == entry_id)
> -		disable_host_flood = true;
> +	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> +	if (err)
> +		return err;
>  
> -	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> +	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
> +	np->uc = false;
> +	np->mc = false;
> +	netc_port_wr(np, NETC_PIPFCR, 0);

[ ... ]

> @@ -1803,19 +1801,24 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  		return;
>  
>  	/* IPFT does not support in-place updates to the KEYE element,
> -	 * we need to add a new entry and then delete the old one. So
> -	 * save the old entry ID first.
> +	 * we need to delete the old one and then add the new rule. If
> +	 * the deletion fails, return immediately.
>  	 */
> -	old_entry_id = np->ipft_hf_eid;
> -
> -	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> -		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
> +	if (netc_port_remove_host_flood(np)) {
> +		dev_err(ds->dev,
> +			"Failed to delete old host flood rule on port %d\n",
>  			port);
> +
>  		return;
>  	}
>  
> -	/* Remove the old host flood entry */
> -	netc_port_remove_host_flood(np, old_entry_id);
> +	/* Restoring the previous configuration is pointless because
> +	 * .port_set_host_flood() returns void, so the upper layer cannot
> +	 * detect the error and the RX flags have changed.
> +	 */
> +	if (netc_port_add_host_flood_rule(np, uc, mc))
> +		dev_err(ds->dev,
> +			"Failed to add host flood rule on port %d\n", port);

[Severity: Medium]
With the new ordering, what happens to host flooding when the add fails?

netc_port_remove_host_flood() has already deleted the entry and cleared
the tracked state:

	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
	np->uc = false;
	np->mc = false;
	netc_port_wr(np, NETC_PIPFCR, 0);

netc_port_add_host_flood_rule() can then fail on kzalloc_obj() returning
NULL, or on ntmp_ipft_add_entry() returning -ENOMEM/-EBUSY/-ETIMEDOUT/
-EIO from the command BD transaction.  In that case the port ends up
with no host flood entry at all while the netdev still has IFF_PROMISC
or IFF_ALLMULTI set, and only a dev_err() is emitted.

Before this change the add ran first, so an add failure left the
previous working rule installed and np->uc/np->mc untouched.

Since .port_set_host_flood() is void and is only reached from
dsa_user_change_rx_flags() -> dsa_user_manage_host_flood(), nothing
reports or retries the failure.  Does host unicast/multicast flooding
for that port then stay silently off until userspace toggles the RX
flags again?

The comment says restoring the previous configuration is pointless.  For
the common promisc to allmulti transition the old rule is a superset of
what is now requested, so wouldn't keeping it still satisfy the new
request and be better than delivering nothing?

[Severity: Low]
Separately, is the window with no rule installed a concern even when
both operations succeed?  Between the delete and the add the port has no
host flood redirect, and the gap covers a full synchronous NTMP command
BD transaction for the delete (dma_alloc_coherent(GFP_KERNEL) plus
netc_xmit_ntmp_cmd() polling through read_poll_timeout()), a
kzalloc_obj() that may enter direct reclaim, and a second command BD
transaction for the add, which only re-arms the redirect at the end:

	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
	if (err)
		goto free_host_flood;
	...
	/* Enable ingress port filter table lookup */
	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);

During that interval, frames that only reach the CPU through the host
flood redirect (multicast under IFF_ALLMULTI when going from
(uc=0,mc=1) to (uc=1,mc=1), or unknown-DA unicast under IFF_PROMISC)
are dropped.  The old add-then-delete ordering kept a matching entry
armed at every instant.

[ ... ]

> @@ -2015,6 +2024,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
>  disable_mlo:
>  	netc_port_set_mlo(np, MLO_DISABLE);
>  
> +	if (netc_port_add_host_flood_rule(np, uc, mc))
> +		dev_err(ds->dev,
> +			"Failed to restore host flood rule on port %u\n",
> +			port);

[Severity: Low]
This isn't a bug, but port is declared int by the .port_bridge_join
prototype, and the two other messages added by this patch use %d for
the same value ("Failed to delete old host flood rule on port %d" and
"Failed to add host flood rule on port %d").  Should this one use %d as
well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918072852.501420-1-wei.fang%40oss.nxp.com
