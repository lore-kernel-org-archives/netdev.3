Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17C530DE1;
	Fri,  4 Sep 2026 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560737; cv=none; b=hh16Lv4FKcNEh9s5lGjbH3s5krbtVqY2lcxSten9Gc4xyGaq0x6ftt0Lnnf9XRe5E5p4yX0NLxKAn4gdoEZa5OLcOpxcvUPRbYPyG74DPalKSEHscgk77UIaz/Zg4h2IDqEpTf29NrcPEN6HPnQ66PzKl/foLKUZS+c5b9k/1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560737; c=relaxed/simple;
	bh=SxB9VeKcoxw7Lm/hGnN//urV/kwRb8d+pXZE9f7KCcw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJoV12tzPZhuYhGfnsbebPDtNodNiwnSYbicHTnfJI0TU5Mb1cPaC7BpV7haigH4IFr/MOTWplPyiW2mEMXzPXNsJRCmxDQ71HUmw25HUrvlWf1bEvQ1kzoHMMwBhD+tHczTk2ODnDWIVFulgI8iG+brnsbPhhBNg1I6Vpi7gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iswR2FC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iswR2FC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8441F00A3F;
	Fri,  4 Sep 2026 22:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560732;
	bh=sc+8JIF2uQ0t3P9vvf91E4KG3CzwGXIrY4q/cBCcwIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iswR2FC0hCUpIYWWwDwcYOfpyi032xIYfkYX+ULX9/tvMv+pJ3yjz08v3PSruSavH
	 kACFsWbdYX6qJ+lvZDvqNbTvNwyOnqMTOxq3b07xdJ2Vqu/9uqhCjxF4KuOmV5qeqv
	 4ZnIk8hE5Lno+ZcH0iNSz1UhVlKk9EUDVNPXGSCupLjT+5ZfZya3trfZ9SegPziEs3
	 9rPRkpgu/dV5j2cMsAOgsCY46JMSH6h6dOWiiJ1zYKSOJlp5zhBSDqOHd1y1VPG16m
	 XaQW61WK9V5BkBc+XcYSV6eu3NjiE9nhPwWRePyzAup6lGgpJ+sWIIZ3eVjtKGmIsD
	 59m8znRbxEadg==
Subject: Re: [PATCH v3 net-next 5/8] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 04 Sep 2026 22:25:30 +0000
Message-ID: <178856073082.219967.16628382371770285710@kernel.org>
In-Reply-To: <20260831082335.1184605-6-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-6-wei.fang@oss.nxp.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 3

- [Medium] Commit message does not match the code in three ways.
- [Medium] netc_port_remove_host_flood()
  (drivers/net/dsa/netc/netc_main.c:1773-1792) now treats every error…
- [Low] This user-visible bug fix carries no `Fixes:` tag (and no stable
  Cc).
- [Low] Format-specifier/argument signedness mismatch in the three newly
  added dev_err() calls: they print the DSA port index with `%u` while…
- [Low] netc_port_set_host_flood() is changed from make-before-break (add
  new entry, then delete old) to break-before-make…

--

net: dsa: netc: check return value of ntmp_ipft_delete_entry()

This converts netc_port_remove_host_flood() to return int, propagates the
error from ntmp_ipft_delete_entry() to its callers, and reorders
netc_port_set_host_flood() to delete the old IPFT host flood entry before
adding the new one, with rollback paths in netc_port_set_host_flood() and
netc_port_bridge_join().

A few questions below, both about the changelog and the new error paths.

[Severity: Medium]
The changelog says:

  "In netc_port_add_host_flood_rule(), delete the old
   entry before adding the new one, and guard against adding a new entry
   when the old one still exists."

Is the first half of that sentence accurate?  The post-patch
netc_port_add_host_flood_rule() has no call to ntmp_ipft_delete_entry() at
all; the only delete call site in the driver is
netc_port_remove_host_flood().  The helper only gains the early bail-out
that returns 0 when an entry already exists with the same uc/mc and -EINVAL
otherwise.  The delete-before-add reordering actually lives in
netc_port_set_host_flood() and netc_port_bridge_join().

Could the changelog also mention that the helper loses its "disable" side
effect?  Before the patch, netc_port_add_host_flood_rule(np, false, false)
wrote NETC_PIPFCR = 0 and cleared np->uc/np->mc; now it just returns 0
without touching hardware.  netc_port_bridge_leave() still calls
netc_port_add_host_flood_rule(np, uc, mc) with a possible (false, false) and
now relies on PIPFCR already being 0.

Lastly:

  "such failures only occur under resource exhaustion conditions that are
   already abnormal"

Does that hold?  netc_xmit_ntmp_cmd() in
drivers/net/ethernet/freescale/enetc/ntmp.c also returns -EBUSY when no
control ring BD is free, -ETIMEDOUT from read_poll_timeout() (NETC_CBDR_TIMEOUT
is 1000 us), and -EIO on a command BD system bus error or a non-zero writeback
error status.  A failed rollback can therefore reflect a persistent device or
control ring problem rather than transient memory pressure.

[Severity: Low]
Should this carry a Fixes: tag (and possibly a stable Cc)?  The bug being
fixed, netc_port_remove_host_flood() ignoring the return value of
ntmp_ipft_delete_entry() and then dropping np->ipft_hf_eid so a live
hardware IPFT entry becomes untracked, was added by commit 46d6407692c8
("net: dsa: netc: add FDB, STP, MTU, port setup and host flooding
support"), which is already upstream, so released kernels are affected.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index d326a00104e1d..2171c83f36407 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
> @@ -1707,15 +1707,23 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
>  	u32 cfg;
>  	int err;
>  
> -	if (!uc && !mc) {
> -		/* Disable ingress port filter table lookup */
> -		netc_port_wr(np, NETC_PIPFCR, 0);
> -		np->uc = false;
> -		np->mc = false;
> +	if (np->ipft_hf_eid != NTMP_NULL_ENTRY_ID) {
> +		/* The old rule is the same as the new rule, return directly.
> +		 * But if the existing rule differs from the requested one,
> +		 * return an error.
> +		 */
> +		if (np->uc == uc && np->mc == mc)
> +			return 0;
>  
> -		return 0;
> +		dev_err(priv->dev,
> +			"The old host flood rule has not been removed from port %u\n",
> +			np->dp->index);
> +		return -EINVAL;
>  	}
>  
> +	if (!uc && !mc)
> +		return 0;
> +
>  	host_flood = kzalloc_obj(*host_flood);
>  	if (!host_flood)
>  		return -ENOMEM;

[Severity: Medium]
Can this new -EINVAL guard make a divergent np->ipft_hf_eid permanently
sticky?  See the question on netc_port_remove_host_flood() below: once
np->ipft_hf_eid is left set after a delete that the hardware may in fact
have executed, every later netc_port_add_host_flood_rule() with different
uc/mc returns -EINVAL, including the restore done by
netc_port_bridge_leave().

> @@ -1762,32 +1770,33 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
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

[Severity: Medium]
Is every error from ntmp_ipft_delete_entry() safe to interpret as "the
entry is still programmed in hardware"?  The NTMP command path does not
look transactional:

drivers/net/ethernet/freescale/enetc/ntmp.c:netc_xmit_ntmp_cmd() {
	...
	cbdr->next_to_use = i;
	netc_write(cbdr->regs.pir, i);

	err = read_poll_timeout(netc_read, val, (val & NETC_CBDRCIR_INDEX) == i,
				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT, true,
				cbdr->regs.cir);
	if (unlikely(err))
		return err;
	...
}

The DELETE BD and the producer index are published to hardware before the
1 ms completion poll, so -ETIMEDOUT means "completion not observed", not
"command not executed"; -EIO from the writeback error status is similarly
indeterminate.  In those cases np->ipft_hf_eid keeps an entry ID the
hardware may no longer own, and there is no other release path:
ntmp_ipft_delete_entry() has this single caller and nothing else clears
np->ipft_hf_eid (this is still the case at the end of the series).

Two follow-on effects:

netc_port_bridge_join() now returns the delete error, so if the retry keeps
failing (for example the hardware reports an error status for a DELETE of a
non-existent entry ID) the port can never be enslaved again from an ordinary
sequence such as "ip link set swpX promisc on" followed by "ip link set swpX
master br0".  Before this patch the error was ignored and the software state
was resynchronised, so the port stayed usable.

IPFT entry IDs are hardware assigned from a table shared by all ports (later
patches in this series add per-port PTP entries in np->ptp_ipft_eid[]), so a
retry on a stale ID could delete an unrelated rule.

Whether the retry ends up as a permanent dead end or a wrong-entry deletion
depends on how the hardware answers a DELETE for a freed or reallocated
entry ID, which can't be determined from the tree, so this part is a
question rather than a claim.

>  
> -	if (disable_host_flood) {
> -		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
> -		np->uc = false;
> -		np->mc = false;
> -		netc_port_wr(np, NETC_PIPFCR, 0);
> -	}
> +	return 0;
>  }
>  
>  static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  				     bool uc, bool mc)
>  {
>  	struct netc_port *np = NETC_PORT(ds, port);
> -	u32 old_entry_id;
> +	bool old_uc = np->uc;
> +	bool old_mc = np->mc;
>  
>  	/* Do not add host flood rule to ingress port filter table when
>  	 * the port has joined a bridge. Otherwise, the ingress frames
> @@ -1795,7 +1804,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  	 * will be redirected directly to the CPU port.
>  	 */
>  	if (dsa_port_bridge_dev_get(np->dp)) {
> -		netc_port_remove_host_flood(np, np->ipft_hf_eid);
> +		if (!netc_port_remove_host_flood(np))
> +			return;
> +
> +		dev_err(ds->dev,
> +			"Failed to delete host flood rule on bridge port %u\n",
> +			port);

[Severity: Low]
Should this be %d?  port is declared int in netc_port_set_host_flood(struct
dsa_switch *ds, int port, ...), matching the .port_set_host_flood prototype
in include/net/dsa.h.  The pre-existing messages in the same function print
the same variable with %d, so the file now uses both conventions for the
same value.  The new dev_err() in netc_port_add_host_flood_rule() correctly
uses %u because it prints np->dp->index, which is unsigned.  The mismatch
is only diagnosed with -Wformat-signedness.

>  
>  		return;
>  	}
> @@ -1804,19 +1818,29 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  		return;
>  
>  	/* IPFT does not support in-place updates to the KEYE element,
> -	 * we need to add a new entry and then delete the old one. So
> -	 * save the old entry ID first.
> +	 * we need to delete the old one and then add the new rule. If
> +	 * the deletion fails, return immediately.
>  	 */
> -	old_entry_id = np->ipft_hf_eid;
> +	if (netc_port_remove_host_flood(np)) {
> +		dev_err(ds->dev,
> +			"Failed to delete old host flood rule on port %u\n",
> +			port);

[Severity: Low]
Same %u versus int port question here.

[Severity: Low]
This turns the update from make-before-break into break-before-make.  At
this commit netc_port_remove_host_flood() also writes NETC_PIPFCR = 0, so
between the delete and the following add the port's ingress filter lookup
is disarmed and the host flood redirect to the CPU port is inactive.

If the following add fails (kzalloc_obj() returning -ENOMEM,
dma_alloc_coherent() inside ntmp_ipft_add_entry(), -EBUSY on the control
ring, IPFT full), the function returns before np->ipft_hf_eid is set and
before netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN), and the rollback add
re-enters the identical allocation path, so it is likely to fail for the
same reason.  Since .port_set_host_flood returns void, the netdev/bridge
layer still believes promisc/allmulti host flooding is in effect.

The PIPFCR half of this is removed later in the same series by "net: dsa:
netc: enable ingress port filtering lookup by default", which drops both
PIPFCR writes from these helpers and enables PIPFCR_EN in
netc_port_fixed_config(), so at the end of the series only the narrower
window on the IPFT entry itself remains, which is the limitation documented
in the comment below.

> +
> +		return;
> +	}
>  
>  	if (netc_port_add_host_flood_rule(np, uc, mc)) {
>  		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
>  			port);
> -		return;
> -	}
>  
> -	/* Remove the old host flood entry */
> -	netc_port_remove_host_flood(np, old_entry_id);
> +		/* Try to restore the old flood rule, if the recovery fails,
> +		 * there is nothing else we can do; this is a limitation.
> +		 */
> +		if (netc_port_add_host_flood_rule(np, old_uc, old_mc))
> +			dev_err(ds->dev,
> +				"Failed to restore host flood rule on port %d\n",
> +				port);
> +}
>  
>  static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,

[ ... ]

> @@ -1992,6 +2018,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
>  	if (err)
>  		return err;
>  
> +	err = netc_port_remove_host_flood(np);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
> +		return err;
> +	}
> +

[Severity: Medium]
This is the path that makes the stale np->ipft_hf_eid question above
user visible: if the deletion keeps failing, bridge enslavement of that
port fails every time, and nothing in the driver resets np->ipft_hf_eid.
Would it be reasonable to distinguish "hardware confirmed the entry is
still there" from "completion unknown" before deciding to keep the entry
ID?

>  	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
>  
>  	if (br_vlan_enabled(bridge.dev))

[ ... ]

> @@ -2016,6 +2046,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
>  disable_mlo:
>  	netc_port_set_mlo(np, MLO_DISABLE);
>  
> +	if (netc_port_add_host_flood_rule(np, uc, mc))
> +		dev_err(ds->dev,
> +			"Failed to restore host flood rule on port %u\n",
> +			port);
> +

[Severity: Low]
%u again for the int port argument of netc_port_bridge_join();
netc_port_bridge_leave() prints the same value with %d.

>  	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831082335.1184605-1-wei.fang%40oss.nxp.com
