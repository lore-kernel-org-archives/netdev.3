Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262953;
	b=mLEwkFru20EBiSia03mH+TxcVGYO3bXjYjveMFtE2S6+BCNgFwfqSHA/KKqNFtMI4mqP
	 ArFN7hZUIg36K20Paru32crmr7fS5/vOsj4HC5jGcXjOBu4umhtRUvXMaDD87IcrKE/ku
	 1RpiRsl0d/RJls8JCnCphgiBwXsfIPqeHIQBdnyvAv0pOJPlw+Z4flGDICcwFfDLJPr/H
	 xFcapz2nfuN72IKYX4S16J914acr5S6nQDIwppRNI7EYcRaAI39biW8sIiv6796zb5KuY
	 G6r/ycLEln6DyakbIk+NYJGLtJZlN5AJz7tigciR3YAXFtimK/Pk/uK8hIC0m2cRW8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262953;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rcnua1fTjKgW/vbnbnwuEDHQ2lo55RIgr+o3hOkccNg=;
	b=S8QZy3aALke3tqffeDGvwr18/GJ3FOTp2XCiy39NT2QfVb/ou9brZ7qTOwtlUqYtnHNi
	 imhJ2fPEfKFC/JU08btJMAVsYhbzNSBmbMJDV/jKCtW+TctUbUsm8iESqxVOkFUHmiJ3/
	 88VFDNZEaaN/cymT+laAtMrJyjX4YY0FIUdjI99znUIr3BE3rurMBvmGi2xUEdcufZuKz
	 bHOtnh6Wfc2jZyBVGuj1/nemutwrEBLRLm8R1qfeTy6gI8so35B8qM54jn/IEtvxZyOeC
	 vhuqJnmuEX2P8KDF34JFocgBdDM3cZEtJaz5wO77TARyx18ofaMR/fyoyhRHpu8+tyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hb521sIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED0606A33A;
	Mon,  9 Nov 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hb521sIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5226F1F008A5;
	Mon,  9 Nov 2026 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262952;
	bh=rcnua1fTjKgW/vbnbnwuEDHQ2lo55RIgr+o3hOkccNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hb521sIobQ41d4j7D6KNZSXdiHeGBwRnDGMaiS6WTCFFTeP02SGD9zXwWMVZFoq1i
	 kqWbWks/4Mou0MKmexoGt3Y3i9HNAeUV1eWSJEIQY1UI3v7bzMFM2h+I2fSboanGlc
	 sHdoFCTAF1x19efFRMt5n3CyGIxOsD1sIUfXd7QtXSRj9UAVD8J0BsYgAsvrWErlXo
	 MSxSIALbasDyXxoXdc6/GfcSTUnxQccTJwtr2Ew1M9z85SunhZ4p4xoZVkShlarqMV
	 nvdieUkWDUB4osyD4N4ujRN+0zcCErr8Mwq7L4JzW/tbfVv3P2SNgagqsrnk3/Buxz
	 ZG2HKJBgMw7SA==
Subject: Re: [PATCH net-next v5 7/7] net: dsa: motorcomm: Support BR_FLOOD and
 BR_MCAST_FLOOD offloading
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:22:31 +0000
Message-ID: <179426295186.994134.10205806169323041670@kernel.org>
In-Reply-To: <20261108214450.1662362-8-mmyangfl@gmail.com>
References: <20261108214450.1662362-8-mmyangfl@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] yt921x_bridge_flood_set() (chip.c lines 1281-1308) clears a
  port's FILTER_UNK_MCAST bit when every other bridge port has…
- [Medium] yt921x_bridge_flood_set() (chip.c line 1297) relies on
  pp->hairpin to keep hairpin ports trapped, because the hardware never…
- [Medium] In the type == 1 (multicast) pass, yt921x_bridge_flood_set()
  (chip.c lines 1281-1308) builds flood_mask only from pp->mcast_flood.
- [Low] yt921x_chip_setup_dsa() (drivers/net/dsa/motorcomm/chip.c, lines
  2475-2483) now reprograms all 16 Reserved Multicast Address entries,…
- [Low] yt921x_bridge_leave() (chip.c line 1390) now calls
  yt921x_bridge_flood_set(priv, 0).

--

net: dsa: motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading

This commit lets the hardware flood unknown unicast and multicast for a
bridge port when the switch carries only one bridge, all other bridge
ports have BR_FLOOD / BR_MCAST_FLOOD set, and the port is not in hairpin
mode. It caches BR_FLOOD and BR_MCAST_FLOOD per port and reprograms
FILTER_UNK_UCAST/MCAST on bridge join, bridge leave and flag changes. It
also sets up the reserved multicast address (RMA) entries to trap to
the CPU.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 3d4aa79ac0268..480203ac7c8ea 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -1218,6 +1222,97 @@ static int yt921x_userport_bridge(struct yt921x_priv *priv, int port)
>  	return 0;
>  }
>  
> +/* ports_mask is optional */
> +static int yt921x_bridge_flood_set(struct yt921x_priv *priv, u16 ports_mask)
> +{

[ ... ]

> +	for (int type = 0; type < 2; type++) {
> +		unsigned long targets_mask = ports_mask;
> +		u16 flood_mask;
> +		u32 addr;
> +		int port;
> +
> +		addr = !type ? YT921X_FILTER_UNK_UCAST :
> +		       YT921X_FILTER_UNK_MCAST;
> +
> +		flood_mask = 0;
> +		for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
> +			struct yt921x_port *pp = &priv->ports[port];
> +
> +			if (!type ? pp->flood : pp->mcast_flood)
> +				flood_mask |= BIT(port);
> +		}

[Severity: Medium]
In the multicast pass, is BR_MCAST_FLOOD alone enough to decide that the
hardware may flood unregistered multicast?

When multicast_snooping is enabled (the default) and a querier is present,
the software bridge does not br_flood() unregistered non-link-local IP
multicast. br_multicast_ipv4_rcv()/br_multicast_ipv6_rcv() set
mrouters_only, and br_handle_frame_finish() then calls
br_multicast_flood(), which only reaches MDB ports and router ports.

Once FILTER_UNK_MCAST is cleared here, a frame whose DA is not in the
hardware MDB is flooded to every bridge port that port isolation allows.
The CPU copy comes back with YT921X_TAG_CODE_FORWARD, so yt921x_tag_rcv()
calls dsa_default_offload_fwd_mark() and the bridge can no longer narrow
the flood.

Before this patch these frames were trapped, and software sent them only
to router ports. Should the snooping and router port state be taken into
account before the FILTER_UNK_MCAST bits are cleared?

> +
> +		ctrl = 0;
> +		for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
> +			struct yt921x_port *pp = &priv->ports[port];
> +
> +			/* Hardware never floods back to its own ingress port,
> +			 * keep hairpin port trapped: the software bridge does
> +			 * deliver a flood there.
> +			 */
> +			if (!pp->hairpin && !((flood_mask ^ ports_mask) &
> +					      ~BIT(port)))
> +				continue;

[Severity: Medium]
Can pp->hairpin disagree with the bridge port's actual hairpin flag here?

pp->hairpin is only written in yt921x_bridge_flags() when the bridge sends
an explicit BR_HAIRPIN_MODE change. DSA core does not sync this flag on
join and does not reset it on leave. dsa_port_inherit_brport_flags() and
dsa_port_clear_brport_flags() both use this mask:

net/dsa/port.c:
	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
				   BR_BCAST_FLOOD | BR_PORT_LOCKED;

Take bond0 as an existing bridge port with hairpin on, and enslave a
yt921x port to it afterwards. dsa_port_lag_join()->dsa_port_bridge_join()
inherits the flood flags but not hairpin. pp->hairpin stays false, so the
FILTER_UNK_UCAST/MCAST bits for that port get cleared.

The hardware then floods unknown unicast and multicast from that port with
offload_fwd_mark set. nbp_switchdev_allowed_egress() keeps the software
bridge from doing the hairpin flood back to bond0. Before this patch these
frames were trapped and software delivered the hairpin flood.

The opposite case also looks possible. A port that leaves a hairpin bridge
and joins a non-hairpin one keeps pp->hairpin true, so it stays trapped
and loses the offload for no reason.

> +
> +			ctrl |= BIT(port);
> +		}
> +
> +		/* ACT_UNK is fixed to TRAP for every port, see
> +		 * yt921x_chip_setup_dsa().
> +		 */
> +
> +		res = yt921x_reg_update_bits(priv, addr, ports_mask, ctrl);

[Severity: Medium]
What happens to IGMPv1/v2 and MLDv1 membership reports once
FILTER_UNK_MCAST is cleared?

These reports are sent to the group address. For an unregistered group
they count as unknown multicast, so the hardware floods them to all bridge
ports. The CPU copy carries code FORWARD, so offload_fwd_mark is set.

Before this patch they were trapped with code 0x1a. With snooping on and a
querier present, the bridge set mrouters_only on them, and
br_handle_frame_finish() forwarded them only to multicast router ports.

Now that the reports reach every port, other IGMPv2/MLDv1 hosts in the
same group may suppress their own reports. The bridge would then learn
only the first reporter. MDB entries are offloaded through
yt921x_dsa_port_mdb_add(), so the hardware would forward the group only
to that one port. Could the hosts that suppressed their reports lose the
stream?

The patch adds a trap for the 01:80:C2:00:00:0X range in
yt921x_chip_setup_dsa(), but nothing for IGMP/MLD. The chip appears to
have IGMP-related controls (YT921X_ACT_UNK_MCAST_BYPASS_DROP_IGMP,
YT921X_VLAN_IGR_FILTER_PORTn_BYPASS_IGMP). Should an IGMP/MLD trap be set
up before hardware multicast flooding is enabled? Or does the hardware
already trap these frames by default?

> +		if (res)
> +			ret = res;
> +	}
> +
> +	return ret;
> +}
> +
>  static int yt921x_isolate(struct yt921x_priv *priv, int port)
>  {
>  	u32 mask;
> @@ -1292,6 +1387,10 @@ static int yt921x_bridge_leave(struct yt921x_priv *priv, int port)
>  	if (res)
>  		return res;
>  
> +	res = yt921x_bridge_flood_set(priv, 0);

[Severity: Low]
Does this call assume that dp->bridge is already cleared for the leaving
port?

yt921x_bridge_flood_set() counts bridges from dp->bridge and takes its
fallback mask from dsa_bridge_ports(). That works for
dsa_port_bridge_leave(), which calls dsa_port_bridge_destroy() before it
broadcasts DSA_NOTIFIER_BRIDGE_LEAVE. The join rollback runs in the other
order:

net/dsa/port.c:dsa_port_bridge_join() {
    ...
out_rollback_unbridge:
	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
out_rollback:
	dsa_port_bridge_destroy(dp, br);
	return err;
}

Suppose the failed join created a second bridge, and then
switchdev_bridge_port_offload() or dsa_port_switchdev_sync_attrs() fails.
count is still 2 during the rollback leave, so FILTER_UNK_UCAST/MCAST are
reset to YT921X_FILTER_PORTS_M. Nothing recomputes them after
dsa_port_bridge_destroy(). The one remaining bridge then has no flood
offload until the next flag change or join/leave.

If the failed port joined an existing bridge instead, the bits for the
remaining members are computed with the failed port's stale
pp->flood/pp->mcast_flood still counted.

Separately, the existing comment in yt921x_dsa_port_bridge_join(), "DSA
does not send bridge_leave when join fails", does not seem to match these
rollback paths.

> +	if (res)
> +		return res;
> +
>  	return 0;
>  }

[ ... ]

> @@ -2353,6 +2472,16 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
>  	if (res)
>  		return res;
>  
> +	/* Capture RMA when offloading mcast flood to hardware */
> +	for (int i = 0; i < 0x10; i++) {
> +		/* Reuse unknown mcast code */
> +		ctrl = YT921X_RMA_CTRL_CPU_CODE(0x1a) |
> +		       YT921X_RMA_CTRL_COPY_TO_CPU | YT921X_RMA_CTRL_DROP;
> +		res = yt921x_reg_write(priv, YT921X_RMA_CTRLn(i), ctrl);

[Severity: Low]
This loop programs all 16 RMA entries (01:80:C2:00:00:00 to 0F) on every
setup and for every port. That includes standalone ports and multi-bridge
setups, where flood offload is never enabled. The commit message says:

  This should cover most single-bridge usage. Other data paths remain
  unchanged in terms of behavior.

Link-local control frames (STP, LACP, 802.1X, LLDP and so on) are now
classified by the RMA engine rather than by the unknown multicast trap.
All the bypass bits (BYPASS_STORM, BYPASS_PORT_METER, BYPASS_FLOW_METER,
IGNORE_VLAN, IGNORE_PORT_ISOLATE) are left clear.

Could the commit message mention this change? It would also help to say
whether metering, storm control or VLAN handling of these frames changes.

Also, 0x1a has to match YT921X_TAG_CODE_UNK_MCAST in net/dsa/tag_yt921x.c.
That is what makes yt921x_tag_rcv() treat these frames as trapped and
leave offload_fwd_mark clear. Would a named constant, or at least a
comment pointing to the tagger, be better than the literal?

> +		if (res)
> +			return res;
> +	}
> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108214450.1662362-1-mmyangfl%40gmail.com
