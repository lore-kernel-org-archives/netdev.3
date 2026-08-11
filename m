Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD443BDD8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444408; cv=none; b=B3wt9X2+mk6GzadfjMxWdFZgbM5OKuHxEbfweP9AcoLTOuw7S4nrmVM5y8AVkghUmjUjZwEVEcJCLC+hXNMTJFFfUJoTt9IQzi7SwUHgj3ErnKEjkzz4qNpOyLgpXYAxcW4DeV3Rzl14xuktMbXfZmOzoOopY1MfwYG2lbOar7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444408; c=relaxed/simple;
	bh=r3RjJxRWQM2WAr9dRrDAQFAq+6rUXJNM3bEMb8afY+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7QLt+gnCuKk9fS5Oy4qxU/g8iKkRgugGgW8K2aM0YIDBnjKbAuZvtR8AogO8ZTdrlGuMIO5ElqVZAKm3zMHJ1ovtv7OWuN/XZxFf/5EoqWIGPbuOIgOvWxvsADdnWmiws4O+04k0vN6KGLizd62I4zL/IEoLHhw0X3kTrNPsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJLjALvb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJLjALvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786444406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLt93p4B0p6SXJeUB/8yeC2ZV/wTIjDYMGDHCtxXa4I=;
	b=aJLjALvbzVOa5F1ViuMS8ML+siKljHPKlIPeFGkLUzTLtvUEWsXe5nJZdDlqLoRTG5N7iN
	hhXIBywKZWaewvvvHKmY5Jb09k+ewB+Kwkpl5K7T20Fz6Lp9sISucQUZLlr+VH+Yn9vO2N
	YriiT8QhBaPzMKGC+L46id9/NVgce4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-YveeRXFPMAiVnL9st7XoaQ-1; Tue,
 11 Aug 2026 06:33:20 -0400
X-MC-Unique: YveeRXFPMAiVnL9st7XoaQ-1
X-Mimecast-MFC-AGG-ID: YveeRXFPMAiVnL9st7XoaQ_1786444398
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8425C18005B2;
	Tue, 11 Aug 2026 10:33:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.134])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E64E518005BB;
	Tue, 11 Aug 2026 10:33:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v11 6/9] net: dsa: lan9645x: add vlan support
Date: Tue, 11 Aug 2026 12:32:56 +0200
Message-ID: <20260811103306.150761-1-pabeni@redhat.com>
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-6-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-6-007ebc983a0a@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [6]: [PATCH net-next v11 6/9] net: dsa: lan9645x: add vlan support ---
commit 48ea20348797be1134c296e1f56d305fbc50bbe3
Author: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

net: dsa: lan9645x: add vlan support

This adds a new lan9645x_vlan.c implementing port_vlan_filtering,
port_vlan_add and port_vlan_del, backed by a software shadow of the
hardware VLAN table in lan9645x->vlans[]. VID 4095 is reserved as the
port VLAN of standalone ports and VID 0 is used for VLAN-unaware bridge
ports.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index c145d28ffbb99..3281726284dc2 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -521,6 +524,7 @@ static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
>  
>  	lan9645x->bridge_mask |= BIT(p->chip_port);
>  	__lan9645x_port_set_host_flood(lan9645x);
> +	lan9645x_vlan_clear_hostmode(p);
>  
>  	mutex_unlock(&lan9645x->fwd_domain_lock);
>  

[ ... ]

> @@ -576,11 +580,52 @@ static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port,
> +static int lan9645x_port_vlan_add(struct dsa_switch *ds, int port,
> +				  const struct switchdev_obj_port_vlan *vlan,
> +				  struct netlink_ext_ack *extack)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct lan9645x_port *p;
> +	bool pvid, untagged;
> +
> +	p = lan9645x_to_port(lan9645x, port);
> +	pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
> +	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
> +
> +	return lan9645x_vlan_port_add_vlan(p, vlan->vid, pvid, untagged,
> +					   extack);
> +}

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> index a0cd1707e1149..248c4ab59f1a8 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h

[ ... ]

> @@ -156,6 +157,17 @@ enum lan9645x_vlan_port_tag {
>  	LAN9645X_TAG_ALL = 3,
>  };
>  
> +struct lan9645x_vlan {
> +	u32 portmask: 10, /* ports 0-8 + CPU port module */
> +	    untagged: 9, /* ports 0-8 */
> +	    src_chk: 1,
> +	    mir: 1,
> +	    lrn_dis: 1,
> +	    prv_vlan: 1,
> +	    fld_dis: 1,
> +	    s_fwd_ena: 1;
> +};
> +

[ ... ]

> @@ -180,6 +192,9 @@ struct lan9645x {
>  	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
>  	struct mutex fwd_domain_lock; /* lock forwarding configuration */
>  
> +	/* VLAN entries */
> +	struct lan9645x_vlan vlans[VLAN_N_VID];
> +
>  	int num_port_dis;
>  };

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> index 0642b59419c25..0548904dc4bd2 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> @@ -210,5 +210,8 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
>  		ANA_PORT_CFG_PORTID_VAL,
>  		lan9645x, ANA_PORT_CFG(p->chip_port));
>  
> +	if (p->chip_port != lan9645x->npi)
> +		lan9645x_vlan_set_hostmode(p);
> +
>  	return 0;
>  }

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> new file mode 100644
> index 0000000000000..e2116132b4d48
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c

[ ... ]

> +static int lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
> +{
> +	struct lan9645x_vlan *v = &lan9645x->vlans[vid];
> +	bool cpu_dis = !(v->portmask & BIT(lan9645x->num_phys_ports));
> +	u32 val;
> +	int err;
> +
> +	val = ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
> +	      ANA_VLANTIDX_V_INDEX_SET(vid) |
> +	      ANA_VLANTIDX_VLAN_SEC_FWD_ENA_SET(v->s_fwd_ena) |
> +	      ANA_VLANTIDX_VLAN_FLOOD_DIS_SET(v->fld_dis) |
> +	      ANA_VLANTIDX_VLAN_PRIV_VLAN_SET(v->prv_vlan) |
> +	      ANA_VLANTIDX_VLAN_LEARN_DISABLED_SET(v->lrn_dis) |
> +	      ANA_VLANTIDX_VLAN_MIRROR_SET(v->mir) |
> +	      ANA_VLANTIDX_VLAN_SRC_CHK_SET(v->src_chk);
> +
> +	lan_wr(val, lan9645x, ANA_VLANTIDX);
> +	lan_wr(ANA_VLAN_PORT_MASK_VLAN_PORT_MASK_SET(v->portmask),
> +	       lan9645x, ANA_VLAN_PORT_MASK);
> +	lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_WRITE),
> +	       lan9645x, ANA_VLANACCESS);

[Severity: High]
[Finding: main-5-5]
[Sources: opus-5]
Should this three-register indirect transaction be serialized by a lock?

The MAC table engine in this driver is protected by mact_lock:

	struct mutex mact_lock; /* serialize mac table register access */

but the VLAN table access engine has no equivalent, and there is no
lockdep_assert_held() here.

lan9645x_vlan_set_hostmode() is now called from .port_setup:

lan9645x_port_setup()
    if (p->chip_port != lan9645x->npi)
        lan9645x_vlan_set_hostmode(p)
            lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID)

and .port_setup runs from the DSA probe path without rtnl_lock and
without fwd_domain_lock:

net/dsa/devlink.c:dsa_port_devlink_setup() {
	if (ds->ops->port_setup) {
		err = ds->ops->port_setup(ds, dp->index);
	...
}

dsa_port_devlink_setup() runs at the start of dsa_port_setup(), before
dsa_user_create() registers this port's netdev, while the netdevs of the
ports already processed are live. So while swp1..swpN are still going
through lan9645x_port_setup(), userspace can enslave swp0:

CPU0 (probe, no locks held)          CPU1 (rtnl, bridge join / vlan add)
lan9645x_vlan_set_hostmode()         lan9645x_port_vlan_add()
  lan9645x_vlan_hw_wr(.., 4095)        lan9645x_vlan_port_add_vlan()
                                         lan9645x_vlan_hw_wr(.., 100)

Can the two transactions interleave like this?

CPU1: lan_wr(V_INDEX=100,   ANA_VLANTIDX)
CPU0: lan_wr(V_INDEX=4095,  ANA_VLANTIDX)
CPU0: lan_wr(mask(4095),    ANA_VLAN_PORT_MASK)
CPU0: lan_wr(CMD_WRITE,     ANA_VLANACCESS)
CPU1: lan_wr(mask(100),     ANA_VLAN_PORT_MASK)
CPU1: lan_wr(CMD_WRITE,     ANA_VLANACCESS)

That would commit mask(100) into the HOST_PVID (4095) entry and leave
vid 100 without a member mask, i.e. either standalone ports lose their
isolation domain or the new VLAN blackholes traffic.

There is also the shadow update itself. lan9645x_vlan_set_hostmode() and
lan9645x_vlan_clear_hostmode() both do a non-atomic read-modify-write of
the same u32 bitfield word:

	p->lan9645x->vlans[HOST_PVID].portmask |= BIT(p->chip_port);
	...
	p->lan9645x->vlans[HOST_PVID].portmask &= ~BIT(p->chip_port);

portmask:10 shares the word with untagged:9 and the flag bits, and
lan9645x_port_bridge_join() calls lan9645x_vlan_clear_hostmode() under
fwd_domain_lock while lan9645x_port_setup() calls
lan9645x_vlan_set_hostmode() with no lock at all, so the lock sets do not
intersect. Can one of these updates be lost?

> +
> +	/* The VLAN access engine completes in a fixed ~1us vs the polling
> +	 * timeout of 100_000 us. A timeout here therefore likely means the
> +	 * register bus itself is dead, not that the VLAN op failed. There is no
> +	 * meaningful recovery at runtime, so this function logs via dev_err()
> +	 * and runtime callers discard the return value. Only
> +	 * lan9645x_vlan_init() treats this as fatal so that probe fails early
> +	 * on a broken bus.
> +	 */
> +	err = lan9645x_vlan_wait_for_completion(lan9645x);
> +	if (err)
> +		dev_err(lan9645x->dev, "Vlan set mask failed\n");
> +
> +	return err;
> +}

[ ... ]

> +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
> +				bool untagged, struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	lan9645x_vlan_port_get_info(lan9645x, p->chip_port, &info);
> +
> +	if (info.untagged > 1 && info.tagged) {
> +		*v = old_vlan;
> +		p->pvid = old_pvid;
> +		NL_SET_ERR_MSG_MOD(extack, "Only support 1 untagged port VLAN");
> +		return -EBUSY;
> +	}

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
This isn't a bug, but could the commit message mention this restriction?

The commit message says only "Add VLAN support for VLAN-aware and
VLAN-unaware bridges", while this rejects an otherwise legal bridge
configuration: a second

	bridge vlan add dev swpN vid B untagged

fails with -EBUSY once the port already has one untagged VLAN plus at
least one tagged VLAN.

The changelog also notes an expected selftest failure with respect to
ctag/stag conformance, but that text is below the --- line and is dropped
when the patch is applied, so nothing about either limitation survives in
the tree.

> +
> +	lan9645x_vlan_hw_wr(lan9645x, vid);
> +	lan9645x_vlan_port_apply_ingress(p);
> +	lan9645x_vlan_port_apply_egress(p, &info);
> +
> +	return 0;
> +}

[ ... ]

> +void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
> +{
> +	p->vlan_aware = false;
> +	p->lan9645x->vlans[HOST_PVID].portmask |= BIT(p->chip_port);
> +	lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
> +	lan9645x_vlan_port_apply(p);
> +}
> +
> +void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p)
> +{
> +	p->lan9645x->vlans[HOST_PVID].portmask &= ~BIT(p->chip_port);
> +	lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
> +	lan9645x_vlan_port_apply(p);
> +}

[ ... ]
-- 
This is an AI-generated review.

