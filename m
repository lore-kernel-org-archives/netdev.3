Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324063;
	b=JHHlRsvYhiSe2oNdb+7A27GLy8g/0NWJSJxp6RJ4NH4KnVc/RSghrIZfvj0sOK73iBeB
	 k8/xB1T1CUvGN7cxjh6KXnhve79A4bgRfQTFyZvndHzzgTgQOOip40vf61jt+VlIttT+7
	 XqEyLYPOgRNpTRjLosH/aS+WrKmmNtvyJ0U5cDMFMS7Mu56hd+A3/b/GDIYeLe4aXcYir
	 /TysFvA62IdOkyLtGliHMW8Y8f3nVXle+Pd46Ymm0GZrGeCJPFXhiDPQQiGZF98RTgCiV
	 bF4c8bzhE0Zh0ZfyUHSNSp1JhVV57r/l+XGybjP8Jk9nEX7w2W+C012nCd+DV8FB2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324063;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=raHyU/2oWj3MIkc4njVf9d+hSYUDkOCTNzI7Fv9pxhg=;
	b=LcWuX4fNyA1GS6d9kf+d7aerCYfX1WVevlLPTKkaes3tH4+G8eZMKCny2xIhJg5occcQ
	 MjX9sVqYB0voLLqp/Z0tgtq2M6bEJh8zmzMrF6f5I285uPt4tqjGXn45/FKzs2c/1KREY
	 FyYgvviYWBIfIX6i2Ff85+NkUd/w1LKZR1L1RAthfuGq1O/pqkxdVtdXCQ87lcHm8KEDe
	 f5m4nKyn0XhpahRRscuqrQEPyj6M2VTQV7LcrlW8A3U1mJrcBFYmHgTB2koKUdLfPCovQ
	 jPvxg6RixZMLLVbDMKW2XmiMurMNV3nztUVE7Y4y/V1afEf9/IlBIdxmdT3g7+eHMrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSiLlANd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA33606A331;
	Tue, 10 Nov 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSiLlANd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C371F008A1;
	Tue, 10 Nov 2026 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324062;
	bh=raHyU/2oWj3MIkc4njVf9d+hSYUDkOCTNzI7Fv9pxhg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mSiLlANd8ANMpcZPLxiB+c+tcHbLC83C8XuQSm9CLhGY1sJW6BPoq0/QSKNRXA7nU
	 LuOXDrR/ApxVKuWlqlg6ncMTF3d46iKu/MQMVL1ygXguEQ/pvmKUdqvJvKPrAmH8FC
	 sDfBZ5PdyL1+0GTyukoRE0xgn4fxAIJC27i0V2fc1BgzigvJGiowVaRoPs2d9nXMzC
	 74dmgWBvxG1+JT01/wR8tpRxuqwG9pPDgguC9rdXHI0oy/PfdlcHYj4BXePgvV3W4K
	 GGwx0WjqF4VYNP5zGvR5nnj50ixsGVugtFmehzOR1R8e6mmLFYuPVzGV+coScAFo00
	 hyekvcW+VwFNQ==
Subject: Re: [PATCH net v2 2/2] net: dsa: realtek: rtl8365mb: keep the neutral
 PVID in VLAN-unaware bridges
From: netdev-bot+sashiko@kernel.org
To: stijncleynhens@gmail.com
Cc: netdev@vger.kernel.org, linusw@kernel.org, luizluca@gmail.com,
 alvin.sipraga@analog.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 namiltd@yahoo.com, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 15:21:01 +0000
Message-ID: <179432406157.994134.6897059294926012210@kernel.org>
In-Reply-To: <20261106150225.3700205-3-stijncleynhens@gmail.com>
References: <20261106150225.3700205-3-stijncleynhens@gmail.com>
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

- [High] In VLAN-unaware bridges, rtl8365mb_port_commit_pvid() now sets
  pvid = 0 (VLANMC index 0, EVID 0).
- [Low] This patch removes the only callers of
  rtl8365mb_vlan_port_get_pvid() (in rtl8365mb_port_vlan_filtering() and…
- [Low] The patch updates the file-header comment in rtl8365mb_vlan.c to
  say that VLANMC index 0 is the neutral PVID "for standalone ports and…

--

net: dsa: realtek: rtl8365mb: keep the neutral PVID in VLAN-unaware bridges

The patch stores the bridge PVID per port in bridge_pvid and only programs
it while the port filters VLANs. Ports of a VLAN-unaware bridge keep the
neutral PVID (VLANMC index 0, VID 0), so untagged frames match the VID 0
FDB/MDB entries that DSA installs. It also replaces
rtl8365mb_vlan_pvid_port_set() and rtl8365mb_vlan_pvid_port_clear() with
rtl8365mb_vlan_pvid_port_commit(), which programs both the PVID and the
accepted frame types.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index b90e46c165bf8..4f0e0ab7f5023 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -2004,42 +2007,44 @@ rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
>  			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
>  }
>  
> +/* Program the PVID that the port should use for untagged frames: the PVID of
> + * the bridge while the port filters VLANs, and the neutral PVID (VID 0)
> + * otherwise. A VLAN-unaware bridge, like a standalone port, gets its FDB and
> + * MDB entries with VID 0 from DSA. As the switch looks up its forwarding
> + * database by the VLAN that it classifies a frame to, a bridge PVID would make
> + * those entries miss every lookup.
> + */
> +static int rtl8365mb_port_commit_pvid(struct dsa_switch *ds, int port,
> +				      bool vlan_filtering,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct rtl8365mb *mb = priv->chip_data;
> +	u16 pvid;
> +
> +	if (vlan_filtering)
> +		pvid = mb->ports[port].bridge_pvid;
> +	else
> +		pvid = 0;

[Severity: High]
With this change, untagged frames from every VLAN-unaware bridge are
classified to VID 0, which is the VID standalone ports already use. The
previous commit made VID 0 an IVL VLAN. Taken together, do multicast
lookups from all bridges and all standalone ports now land in one shared
{MAC, VID 0} space?

The commit message says:

  "The per-bridge EFID keeps these lookups local to the bridge."

That looks true for unicast only. Hardware multicast entries have no EFID
field, and rtl8365mb_l2_add_mc() says so:

drivers/net/dsa/realtek/rtl8365mb_l2.c:rtl8365mb_l2_add_mc() {
    ...
		 * Entries from different bridges will collide on the same
		 * MAC+VID slot with an OR'ed member mask, but packets will
		 * only exit through ports allowed by the source port's pmask.
    ...
}

Also, rtl83xx_port_mdb_add() accepts both DSA_DB_PORT and DSA_DB_BRIDGE,
and it only uses the EFID in a dev_dbg():

	/* EFID is not used by hardware MDB entries; debugging only */

Before this patch, bridge traffic was classified to the bridge PVID
(VID 1). No VID 0 multicast entry could match it, so unregistered
multicast was flooded within the pmask. Three cases look affected now.

First, DSA installs DSA_DB_PORT host entries at VID 0 for every user
port's mc list, whether the port is bridged or not:

dsa_user_sync_mc()
  -> dsa_user_vlan_for_each()      /* always calls cb(arg, 0) */
  -> dsa_user_standalone_event_work()
    -> dsa_port_standalone_host_mdb_add()

Say an untagged frame arrives on lan1 for 33:33:00:00:00:01, for example
an IPv6 RA or an MLD general query from an upstream router. It now hits a
{CPU}-only entry. Does it still get flooded to the other ports of the
bridge?

rtl8_4_read_tag() calls dsa_default_offload_fwd_mark() for any frame that
was not trapped. That means the software bridge would not re-flood the
frame either. IPv6 33:33:xx groups use DMAC lookup. Whether IPv4 groups
do as well depends on the IPMC lookup mode, which the driver does not
configure.

Second, suppose bridge B snoops a group G and installs {G, VID 0} -> {b1}.
Would that entry now also match traffic for G inside bridge A? The result
would be member & pmask(a1) = {} (dropped) or {CPU}, where bridge A would
otherwise have flooded the unregistered group.

Third, DSA refcounts CPU port MDB entries per database:
dsa_port_do_mdb_del() looks up {addr, vid, db}. However,
rtl8365mb_l2_del_mc() still clears the port bit on the single shared
slot:

	mc.member &= ~BIT(port);

When one bridge or standalone port leaves G, does this remove host
delivery of G for the other databases that still need it?

Does this need per-bridge separation of VID 0 multicast, for example a
distinct classification VID or FID per VLAN-unaware bridge? The other
option would be per-database handling of the shared slot.

> +
> +	return rtl8365mb_vlan_pvid_port_commit(ds, port, pvid, vlan_filtering,
> +					       extack);
> +}
> +
>  static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
>  					 bool vlan_filtering,
>  					 struct netlink_ext_ack *extack)
>  {
> -	enum rtl8365mb_frame_ingress accepted_frame, prev_accepted_frame;
>  	enum rtl8365mb_vlan_egress_mode mode;
>  	struct realtek_priv *priv = ds->priv;
>  	u32 configured_ports = 0;
>  	struct dsa_port *dp;
> -	u16 pvid_vid;
>  	int ret;
>  
>  	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
>  		vlan_filtering ? "enable" : "disable");
>  
> -	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
> -						  &prev_accepted_frame);
> -	if (ret) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "Failed to get current framefilter");
> -		return ret;
> -	}
> -
> -	/* While filtering, only accepts untagged frames if PVID is enabled */
> -	if (vlan_filtering) {
> -		ret = rtl8365mb_vlan_port_get_pvid(priv, port, &pvid_vid);

[Severity: Low]
This hunk and the one in rtl8365mb_port_vlan_add() remove the only
callers of rtl8365mb_vlan_port_get_pvid(). The function is still defined
non-static in rtl8365mb_vlan.c and declared in rtl8365mb_vlan.h, so the
compiler will not warn that it is unused. Can it be dropped?

Similarly, the only remaining users of
rtl8365mb_vlan_port_get_framefilter() and
rtl8365mb_vlan_port_set_framefilter() are in
rtl8365mb_vlan_pvid_port_commit() in rtl8365mb_vlan.c. Could they be made
static and removed from the header?

> -		if (ret)
> -			return ret;

[ ... ]

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 58948e76f122a..64acd762e912f 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -42,7 +42,8 @@
>   *    may be useful for ACL rules which specify alternative forwarding
>   *    decisions.
>   *
> - * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.
> + * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports and
> + * for the ports of a VLAN-unaware bridge.

[Severity: Low]
This isn't a bug, but the matching comment in rtl8365mb_vlan_mc_find()
was not updated. It still says:

	/* By design, VlanMC[0] is reserved as a neutral PVID value for
	 * standalone ports. It always has EVID == 0. That way, we assume that

Should it also mention VLAN-unaware bridge ports?

>   *
>   */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106150225.3700205-1-stijncleynhens%40gmail.com
