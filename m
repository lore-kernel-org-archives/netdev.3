Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1C51C342;
	Fri,  4 Sep 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560713; cv=none; b=H9q5ESwuSpzb4FZKKOKylpDLU0XZbi5YssBE5MqLwffIKX6+6FhHPBepomUlyg0JYSp1r8P3zDWHwjw/HWlpEWJcLiMfWok67ESkG+7mTpDk+RbyQOfwbcTYnCvu9nsVapYD7ddMG9m812LPs+oSJayLSr+hTpt67XljbLtzwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560713; c=relaxed/simple;
	bh=n51WMUswqS1dvVnQyqGZVkmWBCqZz4y47yiVAeH2gsI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tytbANaHfju/FVAFIqASMUtoPR1TPu6f8x9t5ztyfQRKrOcqBzntqP7eyN3P2kfNLKMDaZgynA6NnU4ZdJWaMCGyB+Dt+wyQ6mHLGMtB4GIau+FV0Ri6cDfVoRkZc9HLfr1tqbrP9YtrcccM+2z4gX2lSWVmJ2/NsWe6T+VHNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX98fD1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX98fD1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D641F00A3D;
	Fri,  4 Sep 2026 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560709;
	bh=Yco6b9Rwzq2wZPMB8ZaAYLqNPo6ejyfR6tQ2L8KXp0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VX98fD1kfUz1cckp0snEJk2BrC3sWjV+FUy+2VgqPhNawfJep6bnjWR9IDQironhX
	 RNo/cxAyNVGM4XM7U2USPKRZkj2zBXqv8QCrGwEq6EeZH5i/+Qfr6ljLIf53E6UjEn
	 W+mS3vnnowLZmeiiz5vXuWJf6qUjf8uqgGTvNYPNHdL8F1AVkFr/y3vzXyRRpsar5L
	 gU+s1MMRnprp851wpKPC2i15ywisy0E32Scp+OeocZ+CJzceWFg8g2oypHpCtQ4F+s
	 QujhgMnApRo/z4zAP3Wu1RuuuVYC84QL5NTzNAFWw1BVBsWEtK4KUBSGDrgXJ1IU07
	 4eSgR7dZ9A2tA==
Subject: Re: [PATCH net v3 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
From: netdev-bot+sashiko@kernel.org
To: strst.gs@gmail.com
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 22:25:07 +0000
Message-ID: <178856070799.219967.1932535721927933166@kernel.org>
In-Reply-To: <20260831085217.391-2-strst.gs@gmail.com>
References: <20260831085217.391-2-strst.gs@gmail.com>
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

- [Medium] Making NETIF_F_HW_VLAN_CTAG_FILTER permanent
  (net/dsa/user.c:2721-2723) and skipping…
- [Medium] The patch introduces an invariant -
  NETIF_F_HW_VLAN_CTAG_FILTER is a permanent property of user ports on a…
- [Low] DISCARDED (baseline false): claim that the new
  ds->needs_standalone_vlan_offload opt-in is dead code and that b53…
- [Low] Comment vs implementation mismatch about the scope of the new
  flag.
- [Low] Documentation/networking/dsa/dsa.rst lists the optional struct
  dsa_switch flags a driver may set ('their behavior when set is…

--

net: dsa: let drivers offload 8021q uppers on standalone ports

Adds ds->needs_standalone_vlan_offload so a driver can have the VIDs of
8021q uppers delivered to .port_vlan_add on standalone ports without
forcing the vlan_filtering state on. The feature bit
NETIF_F_HW_VLAN_CTAG_FILTER becomes permanent for user ports of such a
switch, and dsa_port_vlan_filtering() therefore skips
dsa_user_manage_vlan_filtering(), while dsa_port_change_conduit() keeps
its explicit teardown and restore.

A few questions below.

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 7507d632e7c6..67a01fc5f81e 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -405,6 +405,9 @@ struct dsa_switch {
>  	/* Keep VLAN filtering enabled on ports not offloading any upper */
>  	u32			needs_standalone_vlan_filtering:1;
>  
> +	/* Offload 8021q uppers of standalone ports even when not filtering */
> +	u32			needs_standalone_vlan_offload:1;
> +

[Severity: Low]
Documentation/networking/dsa/dsa.rst has a list of the optional
dsa_switch flags a driver may set, introduced by "In addition, the
following flags in the dsa_switch structure may optionally be configured
to obtain driver-specific behavior from the DSA core."

That list currently names ds->vlan_filtering_is_global,
ds->needs_standalone_vlan_filtering, ds->configure_vlan_while_not_filtering,
ds->untag_bridge_pvid, ds->assisted_learning_on_cpu_port,
ds->mtu_enforcement_ingress and ds->fdb_isolation.

Should ds->needs_standalone_vlan_offload be added there too, given the
changelog spends several paragraphs on the choice between it and
ds->needs_standalone_vlan_filtering?

>  	/* Pass .port_vlan_add and .port_vlan_del to drivers even for bridges
>  	 * that have vlan_filtering=0. All drivers should ideally set this (and
>  	 * then the option would get removed), but it is unknown whether this
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 1f5536c0dffc..e61abc7c74f7 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -831,6 +831,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>  			if (!user)
>  				continue;
>  
> +			if (ds->needs_standalone_vlan_offload)
> +				continue;
> +
>  			err = dsa_user_manage_vlan_filtering(user,
>  							     vlan_filtering);
>  			if (err)
> @@ -839,10 +842,12 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>  	} else {
>  		dp->vlan_filtering = vlan_filtering;
>  
> -		err = dsa_user_manage_vlan_filtering(dp->user,
> -						     vlan_filtering);
> -		if (err)
> -			goto restore;
> +		if (!ds->needs_standalone_vlan_offload) {
> +			err = dsa_user_manage_vlan_filtering(dp->user,
> +							     vlan_filtering);
> +			if (err)
> +				goto restore;
> +		}
>  	}

[Severity: Medium]
With the feature bit permanent and this skip in place, the 8021q upper
VIDs of such a switch stay offloaded while the port is enslaved to a
VLAN-unaware bridge.  In exactly that state, are both duplicate-VID
guards bypassed?

dsa_user_vlan_add() only checks for colliding uppers when the bridge is
VLAN-aware:

	if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
		rcu_read_lock();
		err = dsa_user_vlan_check_for_8021q_uppers(dev, vlan);
		rcu_read_unlock();

and the symmetric check in dsa_user_check_8021q_upper() bails out early:

	if (!br || !br_vlan_enabled(br))
		return NOTIFY_DONE;

Meanwhile the bridge VLAN is still committed to hardware, because
ds->configure_vlan_while_not_filtering defaults to true so
dsa_port_skip_vlan_configuration() returns false.

dsa_port_vlan_add()/dsa_port_vlan_del() do no refcounting for user
ports, so can this sequence revoke a VID that the upper still owns?

	ip link add link swp0 name swp0.100 type vlan id 100
	bridge vlan add dev swp0 vid 100
	bridge vlan del dev swp0 vid 100

That is two .port_vlan_add calls and one .port_vlan_del.  On b53 at the
end of the series, the delete clears dev->vlans[100].members & BIT(port),
and b53_standalone_vlan_resync() only iterates VIDs with

	if (!(vl->members & BIT(port)))
		continue;

so when the port later leaves the bridge, VID 100 is not restored and
the always-on VID lookup keeps dropping the upper's tagged traffic until
the upper is destroyed and re-created.  Should the collision guards or
the VID accounting be extended for the new flag?

>  
>  	return 0;
> @@ -1445,10 +1450,13 @@ int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
>  
>  	/* The port might still be VLAN filtering even if it's no longer
>  	 * under a bridge, either due to ds->vlan_filtering_is_global or
> -	 * ds->needs_standalone_vlan_filtering. In turn this means VLANs
> -	 * on the CPU port.
> +	 * ds->needs_standalone_vlan_filtering, and every port of a
> +	 * ds->needs_standalone_vlan_offload switch keeps its 8021q upper
> +	 * VLANs whether bridged or not. In turn this means VLANs on the
> +	 * CPU port.
>  	 */
> -	vlan_filtering = dsa_port_is_vlan_filtering(dp);
> +	vlan_filtering = dsa_port_is_vlan_filtering(dp) ||
> +			 ds->needs_standalone_vlan_offload;
>  	if (vlan_filtering) {
>  		err = dsa_user_manage_vlan_filtering(dev, false);
>  		if (err) {

[Severity: Medium]
This patch establishes NETIF_F_HW_VLAN_CTAG_FILTER as a permanent
property of user ports on such a switch, set once in
dsa_user_setup_tagger().  But dsa_port_change_conduit() still tears the
bit down and rebuilds it through dsa_user_manage_vlan_filtering(), and
with the new condition it now does so for every port of such a switch.

Can the error paths leave that invariant broken for good?

The teardown side of dsa_user_manage_vlan_filtering() returns on the
first failure with no rollback of the VIDs it already removed:

	} else {
		err = vlan_for_each(user, dsa_user_clear_vlan, user);
		if (err)
			return err;

		user->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
	}

and dsa_port_change_conduit() then jumps to rewind_old_bridge, which
only rejoins the bridge.

The restore side strips the bit on failure:

		err = vlan_for_each(user, dsa_user_restore_vlan, user);
		if (err) {
			vlan_for_each(user, dsa_user_clear_vlan, user);
			user->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
			return err;
		}

and the retry in the rewind_old_addrs path of dsa_port_change_conduit()
only logs "failed to restore standalone VLANs".

Once the bit is lost, what re-arms it?  dsa_port_vlan_filtering() now
skips dsa_user_manage_vlan_filtering() unconditionally for such a
switch, dsa_port_assign_conduit() does not call
dsa_user_setup_tagger(), and dsa_port_reset_vlan_filtering() does
nothing when leaving a VLAN-unaware bridge with
needs_standalone_vlan_filtering=0.

That looks like the failure mode the changelog describes as "its uppers
then stay dead even after it leaves the bridge, because nothing
re-offloads them once the feature bit is gone".  Would gating the
clearing of the bit on the new flag, so no error path can drop it, be a
better fit for the intended invariant?

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef..fda6ba4fdd13 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1946,6 +1946,7 @@ static int dsa_user_clear_vlan(struct net_device *vdev, int vid, void *arg)
>   *
>   * - If standalone (this includes software bridge, software LAG):
>   *     - if ds->needs_standalone_vlan_filtering = true, OR if
> + *       ds->needs_standalone_vlan_offload = true, OR if
>   *       (ds->vlan_filtering_is_global = true AND there are bridges spanning
>   *       this switch chip which have vlan_filtering=1)
>   *         - the 8021q upper VLANs

[Severity: Low]
Only the "If standalone" bullet of this summary comment is amended, yet
the next bullet still says that a port "under a vlan_filtering=0 bridge
which it offload" offloads only "the bridge VLANs".  The comment on the
new field in include/net/dsa.h says the same thing in shorter form,
"Offload 8021q uppers of standalone ports even when not filtering".

Is the implementation actually standalone-scoped?
dsa_user_setup_tagger() sets NETIF_F_HW_VLAN_CTAG_FILTER for every user
port of such a switch at port setup, and dsa_port_vlan_filtering() never
clears it again, so a port enslaved to a VLAN-unaware bridge keeps
offloading its 8021q upper VLANs.

The new comment in dsa_port_change_conduit() states the opposite of the
two comments above:

	 * ds->needs_standalone_vlan_filtering, and every port of a
	 * ds->needs_standalone_vlan_offload switch keeps its 8021q upper
	 * VLANs whether bridged or not.

Could the vlan_filtering=0 bridge bullet and the include/net/dsa.h field
comment be updated to match?

> @@ -2717,7 +2718,8 @@ void dsa_user_setup_tagger(struct net_device *user)
>  	user->hw_features |= NETIF_F_HW_TC;
>  	if (user->needed_tailroom)
>  		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
> -	if (ds->needs_standalone_vlan_filtering)
> +	if (ds->needs_standalone_vlan_filtering ||
> +	    ds->needs_standalone_vlan_offload)
>  		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  
>  	user->lltx = true;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831085217.391-1-strst.gs%40gmail.com
