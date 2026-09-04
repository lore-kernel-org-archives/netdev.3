Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0A3EAC61;
	Fri,  4 Sep 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560716; cv=none; b=fhBoJ1imW7RymRcGWBppgqBXGC/HwOpc469+PInwBD+hqPK79LeaLqtGPs+ZslWrROYAM92QcgpN9d5gWkSbVoaixdyyDPVWRO93Y/x33WdynhaL/WPqGkpeHc5PvewmNm+Q9hspuJPcVMcNU91aBSAiuXYRo32LW94DoH0Lmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560716; c=relaxed/simple;
	bh=x3gaPD3IjylyNSX8QKDlEHLGeWTbwlWsTi8HOEUA+GU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQgO1RuIW2xEXKOgVZvmnfOeiz3qZpi7uj3maixLvMz3zrW7DjfY8KG5PZaLkM0h/9aLo10KG01q/5qGXLhxGpE3X0sEMYEW4JUNjAI4cbN8tMUj62x04KNSZmOudmJ5p4H3bAdqgKkTsvcS42AoI2TCnerbqGqV/JwwcNb+DRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzqjwGe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzqjwGe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9868A1F00A3E;
	Fri,  4 Sep 2026 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560710;
	bh=oOzMiPOnMDaVVhnATr2bEe1DD3Ex7YWNhDPtG41yTxo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lzqjwGe0FL+OUpUxwKLKRn07UZOXT1r9gF7r+94TNr1PrCxlNOm5ENsv/wHSUdcQj
	 n57tnq/0D1sTpOW/ESfb9lkWAtTVpPSIY9Sv0bGJ6tjYtWFVp4b2ICU0lKqDhvWyTH
	 hDF0ygnyEIr49A3o1BeCqkQYCnsOuf8dU+RGCEg3UNEFUy23OkJPiLFL+2MPGpROqk
	 HtNaUcsBOEzcDoYG7GAySBJiCRx55Ql7RlEPKPttRfgThfsW8cqH76aEQ30zHwHnxU
	 puJ8JJRTrwFMArvpM+kcMt3Gqtqs9bCcu+MnAGXT9PQPrXPOWLzODDrHYGeiubIO7U
	 n7HxN3AETf6hA==
Subject: Re: [PATCH net v3 2/2] net: dsa: b53: offload 8021q uppers on
 standalone ports
From: netdev-bot+sashiko@kernel.org
To: strst.gs@gmail.com
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 22:25:09 +0000
Message-ID: <178856070920.219967.188999912636170238@kernel.org>
In-Reply-To: <20260831085217.391-3-strst.gs@gmail.com>
References: <20260831085217.391-3-strst.gs@gmail.com>
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

Critical: 0 · High: 0 · Medium: 5 · Low: 0

- [Medium] b53_vlan_hw_entry() (drivers/net/dsa/b53/b53_common.c:901)
  classifies every non-CPU member port whose dp->bridge is NULL as a…
- [Medium] b53_standalone_vlan_resync() at the end of b53_br_leave()
  (drivers/net/dsa/b53/b53_common.c:2458) derives the leaving port's…
- [Medium] The new opt-in `dev->ds->needs_standalone_vlan_offload =
  !is5325(dev) && !is5365(dev);` (drivers/net/dsa/b53/b53_common.c:3256)…
- [Medium] When a port that already has a working 8021q upper joins a
  VLAN-unaware offloaded bridge, b53_br_join() ->…
- [Medium] b53 records both a bridge VLAN and an 8021q upper VLAN for the
  same port/VID in the single bit dev->vlans[vid].members & BIT(port),…

--

net: dsa: b53: offload 8021q uppers on standalone ports

The patch takes the new needs_standalone_vlan_offload opt-in in b53 and
programs VLAN table entries for VIDs that carry a standalone port even while
dev->vlan_filtering is false, masking the entry down to the standalone
members plus the CPU port.  Bridge join/leave and b53_configure_vlan() now
rewrite those entries, and the opt-in is skipped for BCM5325/BCM5365.

No Link: tags present in the commit header.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 0880310c9ce3..b57c0bdacb27 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -898,10 +898,52 @@ static bool b53_vlan_port_may_join_untagged(struct dsa_switch *ds, int port)
>  	return dp->bridge == NULL;
>  }
>  
> +static bool b53_vlan_hw_entry(struct dsa_switch *ds, const struct b53_vlan *vl,
> +			      struct b53_vlan *hw)
> +{
> +	struct b53_device *dev = ds->priv;
> +	bool standalone = false;
> +	struct dsa_port *dp;
> +	unsigned int port;
> +
> +	*hw = *vl;
> +
> +	if (dev->vlan_filtering)
> +		return true;
> +
> +	hw->members = 0;
> +	hw->untag = 0;
> +
> +	b53_for_each_port(dev, port) {
> +		if (!(vl->members & BIT(port)))
> +			continue;
> +
> +		dp = dsa_to_port(ds, port);
> +
> +		if (!dsa_port_is_cpu(dp)) {
> +			if (dp->bridge)
> +				continue;
> +
> +			standalone = true;
> +		}

[Severity: Medium]
Should a DSA link port be able to set standalone here?  A port of type
DSA_PORT_TYPE_DSA never has dp->bridge set, so it passes the
!dsa_port_is_cpu(dp) test and sets standalone = true.

The DSA core does issue VLAN objects for those ports, so their bits do end
up in dev->vlans[vid].members:

net/dsa/switch.c:
    /* Port VLANs match on the targeted port and on all DSA ports */
    static bool dsa_port_vlan_match(struct dsa_port *dp,
                                    struct dsa_notifier_vlan_info *info)
    {
            return dsa_port_is_dsa(dp) || dp == info->dp;
    }

On a cascaded b53 tree, does that mean b53_vlan_hw_entry() returns true for
a VID whose only user-port members are bridge ports, and b53_vlan_add() /
b53_vlan_del() / b53_configure_vlan() then write an entry containing only
the DSA links and the CPU port?  Since b53 keeps VC0_VLAN_EN|VC0_VID_CHK_EN
set at all times, the programmed member mask governs egress for that VID,
so the bridged ports would be removed from that VID's forwarding domain
while filtering is off.

There is also no corrective path afterwards: b53_standalone_vlan_resync()
is only reached from b53_br_join()/b53_br_leave(), which a DSA link never
traverses, so the entry stays as written.

Would including DSA link ports as members without letting them set
standalone match the intent stated in the commit message ("Only the
standalone members and the CPU port are written to such an entry")?

> +
> +		hw->members |= BIT(port);
> +		hw->untag |= vl->untag & BIT(port);
> +	}
> +
> +	if (!standalone) {
> +		hw->members = 0;
> +		hw->untag = 0;
> +	}
> +
> +	return standalone;
> +}
> +

[ ... ]

> @@ -1772,7 +1819,9 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
>  {
>  	struct b53_device *dev = ds->priv;
>  	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	struct b53_vlan hw;
>  	struct b53_vlan *vl;
> +	bool needs_hw;
>  	u16 pvid;
>  
>  	if (vlan->vid == 0)
> @@ -1782,6 +1831,8 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
>  
>  	vl = &dev->vlans[vlan->vid];
>  
> +	needs_hw = b53_vlan_hw_entry(ds, vl, &hw);
> +
>  	vl->members &= ~BIT(port);

[Severity: Medium]
Can a bridge VLAN deletion here destroy the record of an 8021q upper on the
same port and VID?  dev->vlans[vid].members has one bit per port with no
per-owner accounting, and the core does not refcount VLANs on user ports:

net/dsa/switch.c:dsa_port_do_vlan_add() {
        /* No need to bother with refcounting for user ports. */
        if (!(dsa_port_is_cpu(dp) || dsa_port_is_dsa(dp))) {
                err = ds->ops->port_vlan_add(ds, port, vlan, extack);

The colliding pair is only rejected while bridge VLAN filtering is on:

net/dsa/user.c:dsa_user_vlan_add() {
        if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
                rcu_read_lock();
                err = dsa_user_vlan_check_for_8021q_uppers(dev, vlan);

so with vlan_filtering 0 the sequence

  ip link add link ethX name ethX.100 type vlan id 100
  ip link set dev ethX master br0        (br0 with vlan_filtering 0)
  bridge vlan add dev ethX vid 100
  bridge vlan del dev ethX vid 100

leaves vl->members without BIT(port) although ethX.100 still exists.  After
that, does anything rewrite the entry again?  b53_standalone_vlan_resync()
skips the VID because of

        if (!(vl->members & BIT(port)))
                continue;

and b53_configure_vlan()'s restore loop keys off v->members as well, so
tagged reception on ethX.100 would stay dead until the upper is re-created.

>  
>  	if (pvid == vlan->vid)
> @@ -1791,14 +1842,18 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
>  	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
>  		vl->untag &= ~(BIT(port));
>  
> -	if (!dev->vlan_filtering)
> +	if (!needs_hw)
>  		return 0;
>  
> -	b53_set_vlan_entry(dev, vlan->vid, vl);
> +	b53_vlan_hw_entry(ds, vl, &hw);
> +	b53_set_vlan_entry(dev, vlan->vid, &hw);
>  	b53_fast_age_vlan(dev, vlan->vid);
>  
> -	b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), pvid);
> -	b53_fast_age_vlan(dev, pvid);
> +	if (dev->vlan_filtering) {
> +		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
> +			    pvid);
> +		b53_fast_age_vlan(dev, pvid);
> +	}
>  
>  	return 0;
>  }

[ ... ]

> @@ -2261,6 +2316,28 @@ int b53_mdb_del(struct dsa_switch *ds, int port,
>  }
>  EXPORT_SYMBOL(b53_mdb_del);
>  
> +static void b53_standalone_vlan_resync(struct dsa_switch *ds, int port)
> +{
> +	struct b53_device *dev = ds->priv;
> +	struct b53_vlan hw;
> +	struct b53_vlan *vl;
> +	u16 vid;
> +
> +	if (dev->vlan_filtering)
> +		return;
> +
> +	for (vid = b53_default_pvid(dev) + 1; vid < dev->num_vlans; vid++) {
> +		vl = &dev->vlans[vid];
> +
> +		if (!(vl->members & BIT(port)))
> +			continue;
> +
> +		b53_vlan_hw_entry(ds, vl, &hw);
> +		b53_set_vlan_entry(dev, vid, &hw);
> +		b53_fast_age_vlan(dev, vid);
> +	}
> +}
> +
>  int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>  		bool *tx_fwd_offload, struct netlink_ext_ack *extack)
>  {
> @@ -2324,6 +2401,8 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
>  	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
>  	dev->ports[port].vlan_ctl_mask = pvlan;
>  
> +	b53_standalone_vlan_resync(ds, port);
> +

[Severity: Medium]
When a port that already has a working 8021q upper joins a VLAN-unaware
bridge, this call recomputes that upper's VID with dp->bridge now set, so
b53_vlan_hw_entry() hits

        if (dp->bridge)
                continue;

standalone stays false, and the entry is written back empty.  On bcm5301x,
where a table miss is only forwarded toward the disabled IMP0 port, does
that silently stop the upper from receiving tagged frames?

Nothing reports the loss either: b53_vlan_add() returns 0 when
b53_vlan_hw_entry() finds no standalone member, so DSA continues to track
the VID as offloaded.

Documentation/networking/switchdev.rst says:

    When there is a VLAN device (e.g: sw0p1.100) configured on top of a
    switchdev network device which is a bridge port member, the behavior of
    the software network stack must be preserved, or the configuration must
    be refused if that is not possible.

and the DSA-side comment added by this series states:

    net/dsa/port.c:
         * ds->needs_standalone_vlan_offload switch keeps its 8021q upper
         * VLANs whether bridged or not.

Should this case be refused with an extack instead of dropping the offload
silently?  The commit message's argument that "bridge VLANs keep having no
effect while filtering is off" covers bridge VLANs, but the VID here comes
from an 8021q upper.

>  	return 0;
>  }
>  EXPORT_SYMBOL(b53_br_join);
> @@ -2376,6 +2455,8 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
>  		vl->members |= BIT(port);
>  		b53_set_vlan_entry(dev, pvid, vl);
>  	}
> +
> +	b53_standalone_vlan_resync(ds, port);
>  }
>  EXPORT_SYMBOL(b53_br_leave);

[Severity: Medium]
Is dp->bridge always already cleared when this runs?  On the normal leave
path dsa_port_bridge_leave() calls dsa_port_bridge_destroy() before
broadcasting DSA_NOTIFIER_BRIDGE_LEAVE, but the join rollback does the
opposite order:

net/dsa/port.c:dsa_port_bridge_join() {
        ...
out_rollback_unbridge:
        dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
out_rollback:
        dsa_port_bridge_destroy(dp, br);
        return err;
}

So when switchdev_bridge_port_offload() or dsa_port_switchdev_sync_attrs()
fails, b53_br_leave() -> b53_standalone_vlan_resync() runs with dp->bridge
still set, b53_vlan_hw_entry() skips the port, and the entry is written
empty even though the port becomes standalone again a moment later.

Does anything restore it afterwards?  b53_vlan_add()/b53_vlan_del() are not
called because the upper still exists, and b53_configure_vlan() only runs
from b53_apply_config() on setup, resume, or a vlan_filtering change, so
tagged reception on the port's uppers would stay off after a failed bridge
join.

>  
> @@ -3172,6 +3253,8 @@ static int b53_switch_init(struct b53_device *dev)
>  	if (!dev->vlans)
>  		return -ENOMEM;
>  
> +	dev->ds->needs_standalone_vlan_offload = !is5325(dev) && !is5365(dev);

[Severity: Medium]
Does this condition exclude BCM5365 on kernels built without
CONFIG_BCM47XX?

drivers/net/dsa/b53/b53_priv.h:
    static inline int is5365(struct b53_device *dev)
    {
    #ifdef CONFIG_BCM47XX
            return dev->chip_id == BCM5365_DEVICE_ID;
    #else
            return 0;
    #endif
    }

while b53_switch_detect() sets the chip id with no config guard:

        } else {
                dev->chip_id = BCM5365_DEVICE_ID;
        }

and both b53_mdio.c and b53_spi.c carry a "brcm,bcm5365" match.  On such a
build the flag would be set for a chip with .vlans = 256, so
NETIF_F_HW_VLAN_CTAG_FILTER gets advertised and every upper VID reaches
b53_vlan_prepare():

        if (vlan->vid >= dev->num_vlans)
                return -ERANGE;

Would ip link add link ethX name ethX.300 type vlan id 300 then fail where
it previously created a working software VLAN?  That is the case the commit
message says is preserved:

    BCM5325 and BCM5365 stay out of the opt-in, ... b53_vlan_prepare() would
    refuse any upper whose VID lies beyond the table, an interface that works
    today.

Would testing dev->chip_id (or dev->num_vlans) directly rather than the
CONFIG_BCM47XX-conditional helper keep that policy in every build?

>  
>  	dev->reset_gpio = b53_switch_get_reset_gpio(dev);
>  
>  	if (PTR_ERR(dev->reset_gpio) == -EPROBE_DEFER)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831085217.391-1-strst.gs%40gmail.com
