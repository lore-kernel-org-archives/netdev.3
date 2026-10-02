Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92657385D61;
	Fri,  2 Oct 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975658; cv=none; b=Yr7YJ1PqJ2M4zCNz/WMU9+hNGWlbEpWsSmrH85a74D+e3Llyk8DufmICGL8g5PkdKQ0Bl8vLLRm7+S1JzYaUYAWAocPf51JTujPVeM4Kkhm4tfd9yV2AZ+WtaZH8Ai0J/aQJ7AUOMYlUtxVoeX2r78fR9/tZobpNYcqRb8bH2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975658; c=relaxed/simple;
	bh=gxOxPe1i1bf2CvZNxQXlXOmrmGNHtLm4zYGZ70H3rK0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwH4qWsgsMPZ5nOtOHnUhXwNrBlGbJjcPkj4MJ/ow5Woksv+2pgPeStaz3ezBxlfQ8MIX7DU72zw6hG4a53rA+TDmCeraVHwI8vpAz6ACu1O7wsoJ2Ifxd2S1rUip6yRwkoj/w1tmCwlUmO7shBCXHz88gRO7wLa9XzTlixOfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTkjFZVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTkjFZVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A9B1F000FF;
	Fri,  2 Oct 2026 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975656;
	bh=3pSEFKHHA11fkddNRPHdVL9Of6KrGfueFlWk5ShnrYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dTkjFZVUhvsy0U3ZUVhcf30ce/SJU0hkuouBJkfoDpjJO7XaNAUk0Loz8r2+TdMma
	 sHn8OMuj/1mDqzZnmdtYBO/Pj9euPwchj38q27qcgcDWRTDE9sa2Fh5oOqDkvvwAJr
	 undkcncvkEWErZDr4+63fYQoceDxs1XQHPfNjWAxy2wOG41beHp7oIf1GdDSVRlb9q
	 /2tb2l9Zviv2TTBSJ74wh2dknCz1uyzwckwTThts1ZJtrJwI7uKdmuB6yGSPTuwBww
	 mASRPm3FEYOx54V/SRpPOaxch4KVxBdlKuxzwYkbZ7Awvi/iaixHQY+EiVTeZdGBdu
	 9cbOG8Of9+nHA==
Subject: Re: [PATCH net-next v13 1/9] net: dsa: add tag driver for LAN9645X
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:14 +0000
Message-ID: <179097565449.434549.6566178471820291955@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-1-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-1-827c2d3617f2@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In lan9645x_xmit_get_vlan_info() (net/dsa/tag_lan9645x.c), any
  frame with no in-band tag matching the bridge protocol gets IFH_TCI…
- [Medium] lan9645x_netdev_ops sets no .flow_dissect, so
  __skb_flow_dissect() (net/core/flow_dissector.c:1083-1098) falls back…
- [Medium] When the IFH-classified VID equals the port pvid,
  lan9645x_rcv() skips restoring the tag (tag_lan9645x.c:451-453).
- [Low] In lan9645x_xmit_get_vlan_info(), the condition `skb_headlen(skb)
  >= VLAN_ETH_HLEN && ntohs(hdr->h_vlan_proto) == proto` treats a VLAN…
- [Low] In lan9645x_xmit_get_vlan_info(), the guard `skb_headlen(skb) >=
  VLAN_ETH_HLEN` in front of vlan_remove_tag() does not cover every byte…
- [Low] lan9645x_rcv() always restores the classified VLAN as
  ETH_P_8021Q.

Pre-existing issues:
- [High] lan9645x_xmit() calls dsa_port_bridge_dev_get(dp)
  (include/net/dsa.h:774-778, `dp->bridge ?

--

net: dsa: add tag driver for LAN9645X

This adds a DSA tag driver for the Microchip LAN9645x switch, which uses a
front port as the NPI CPU port. On extraction, frames carry a 16 byte long
prefix plus a 28 byte IFH. On injection, frames carry only the IFH. On
receive, the classified VLAN is restored as a hwaccel C-tag unless it
equals the port pvid.

> diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> new file mode 100644
> index 0000000000000..f54646d4b3947
> --- /dev/null
> +++ b/net/dsa/tag_lan9645x.c
> @@ -0,0 +1,474 @@

[ ... ]

> +static struct sk_buff *lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
> +						   struct net_device *br,
> +						   u32 *vlan_tci,
> +						   u32 *tag_type)
> +{

[ ... ]

> +	hdr = skb_vlan_eth_hdr(skb);
> +	br_vlan_get_proto(br, &proto);
> +
> +	if (skb_headlen(skb) >= VLAN_ETH_HLEN &&
> +	    ntohs(hdr->h_vlan_proto) == proto) {
> +		vlan_remove_tag(skb, &tci);

[Severity: Low]
What happens when the VLAN header is not fully in the linear area?

Because of the skb_headlen() check, a tagged frame with a short linear head
goes to the else branch. The original 802.1Q tag then stays in the payload,
and IFH_TCI is set to br0's pvid.

dsa_user_xmit() does not linearize the skb here. The user netdev inherits
NETIF_F_SG from conduit->vlan_features in dsa_user_setup_tagger(). The
AF_PACKET PACKET_TX_RING path, tpacket_snd()->tpacket_fill_skb(), copies
only hard_header_len (14) bytes into the linear area.

Could the rewriter then push a second tag, so the frame goes out
double-tagged or in the wrong VLAN? Would a pskb_may_pull() of
VLAN_ETH_HLEN before this check avoid that?

[Severity: Low]
Is the VLAN_ETH_HLEN check enough for vlan_remove_tag()?

When h_vlan_encapsulated_proto is an 802.3 length, vlan_set_encap_proto()
also reads the two bytes after the VLAN header:

include/linux/if_vlan.h:vlan_set_encap_proto() {
	...
	rawp = (unsigned short *)(vhdr + 1);
	if (*rawp == 0xFFFF)
	...
}

lan9645x has no needed_tailroom, so dsa_user_xmit() does not pad the frame.
skb_put_padto() in lan9645x_xmit() only runs after this function returns.

Take an 18 or 19 byte frame such as DA SA 8100 TCI <len>. Can this read
uninitialized tailroom past skb_tail_pointer()? The only effect is whether
skb->protocol becomes ETH_P_802_3 or ETH_P_802_2, but KMSAN would likely
report an uninit-value.

> +		*vlan_tci = tci;
> +	} else {
> +		rcu_read_lock();
> +		br_vlan_get_pvid_rcu(br, &tci);
> +		rcu_read_unlock();

[Severity: High]
Is br_vlan_get_pvid_rcu() being passed the right device here?

br comes from dsa_port_bridge_dev_get(), so it is the bridge master. This
call returns the pvid of br0's own VLAN group. That VID is unrelated to the
egress port and to the VLAN the bridge forwarded the frame in, because
br_handle_vlan() already cleared the tag for an egress-untagged VLAN.

lan9645x_xmit() then writes that VID into IFH_TCI with IFH_BYPASS set, so
the rewriter uses it as the classified VID:

	lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
	...
	lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);

The later "net: dsa: lan9645x: add vlan support" patch changes
lan9645x_vlan_port_apply_egress(). It programs a hybrid port (one untagged
VLAN plus tagged VLANs) as LAN9645X_TAG_NO_PVID_NO_UNAWARE, with PORT_VID
set to the untagged VID. In that mode every frame is tagged unless
VID == PORT_VID or VID == 0.

For example, say br0 has pvid 1 (the default), and swp1 has VLAN 10 as
pvid/untagged plus VLAN 20 tagged. A frame sent by the host in VLAN 10 (from
br0.10, or ARP flooded by the bridge) reaches this code untagged and gets
VID 1. So does a frame forwarded in software in VLAN 10.

Would the switch then send it on the wire tagged with VLAN 1 instead of
untagged in VLAN 10?

> +		*vlan_tci = tci;
> +	}

[ ... ]

> +static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
> +				     struct net_device *ndev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(ndev);
> +	u32 vlan_tci, tag_type;
> +	u32 qos_class;
> +	void *ifh;
> +
> +	skb = lan9645x_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(dp),
> +					  &vlan_tci, &tag_type);

[Severity: High]
This isn't a bug introduced by this patch. The racy pattern is in the DSA
core and is already used by tag_ocelot, tag_sja1105, tag_dsa and others;
this tagger adds another user of it.

dsa_port_bridge_dev_get() reads dp->bridge twice on the TX path. It holds
no lock and uses neither READ_ONCE() nor RCU:

	return dp->bridge ? dp->bridge->dev : NULL;

The following path runs under rtnl:

del_nbp()
  netdev_upper_dev_unlink()
    dsa_port_bridge_leave()
      dsa_port_bridge_destroy()

It clears dp->bridge and, on the last reference, frees the dsa_bridge
without waiting for a grace period:

net/dsa/port.c:dsa_port_bridge_destroy() {
	...
	dp->bridge = NULL;

	if (!refcount_dec_and_test(&bridge->refcount))
		return;
	...
	kfree(bridge);
}

TX on the user port (AF_PACKET or locally generated traffic) is not
quiesced at that point.

Can a concurrent lan9645x_xmit() read ->dev from freed memory, or reload
dp->bridge after it became NULL? The result is then passed to
br_vlan_enabled(), br_vlan_get_proto() and br_vlan_get_pvid_rcu().

[ ... ]

> +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> +				    struct net_device *ndev)
> +{

[ ... ]

> +	dp = dsa_user_to_port(skb->dev);
> +
> +	if (dsa_port_is_vlan_filtering(dp) && vlan_tci) {
> +		u16 port_pvid = 0;
> +
> +		br_vlan_get_pvid_rcu(skb->dev, &port_pvid);
> +
> +		/* The tag is restored as a C-tag, not as the TAG_TYPE the IFH
> +		 * reports. The classifier recognizes both TPIDs as VLAN tags,
> +		 * so an S-tag has already been used for classification by the
> +		 * time we get here. Restoring it as 802.1AD would make the
> +		 * bridge push it back into the payload and reclassify the frame
> +		 * to the port pvid, on a different VID than the one the
> +		 * hardware forwarded it on.
> +		 */
> +		if ((vlan_tci & VLAN_VID_MASK) != port_pvid)
> +			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
> +					       vlan_tci);

[Severity: Medium]
What happens to a double-tagged frame whose outer VID equals the pvid?

The later "net: dsa: lan9645x: add vlan support" patch sets
ANA_VLAN_CFG_VLAN_POP_CNT=1 without VLAN_INNER_TAG_ENA, so VLAN-aware ports
pop exactly one tag.

Take outer VID 100 (the pvid) with an inner C-tag 200. The frame is
extracted with popcnt == 3, the inner tag is still in the payload, and
IFH_TCI reports VID 100.

No tag is restored here in that case. eth_type_trans() in dsa_switch_rcv()
then sets skb->protocol to 0x8100, and __netif_receive_skb_core() turns the
inner tag into hwaccel VID 200 via skb_vlan_untag().

Would the software bridge then classify the frame to VLAN 200, while the
hardware forwarded it in VLAN 100?

[Severity: Low]
The commit message says this assumes an 802.1Q bridge:

    This assumes a bridge vlan_protocol of 802.1Q, which is the only
    protocol the driver offloads.

The later "net: dsa: lan9645x: add vlan support" patch documents the same
limitation. Is anything enforcing it?

DSA does not handle SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL, and
__br_vlan_set_proto() sends it with SWITCHDEV_F_SKIP_EOPNOTSUPP. So an
802.1ad bridge cannot be refused that way.

On such a bridge, __allowed_ingress() sees skb->vlan_proto !=
br->vlan_proto. It pushes the tag back into the payload and classifies the
frame to the pvid. Terminated frames on non-pvid VLANs would then land on
the pvid, or be dropped if the port has no pvid.

lan9645x_xmit_get_vlan_info(), on the other hand, handles 802.1ad
explicitly:

	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
					     LAN9645X_IFH_TAG_TYPE_C;

Should 802.1ad bridges be refused in port_bridge_join? Should xmit and rcv
also handle an 802.1ad bridge the same way?

> +	}
> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops lan9645x_netdev_ops = {
> +	.name			= LAN9645X_NAME,
> +	.proto			= DSA_TAG_PROTO_LAN9645X,
> +	.xmit			= lan9645x_xmit,
> +	.rcv			= lan9645x_rcv,
> +	/* Covers the extraction prefix too, since dsa_tag_protocol_overhead()
> +	 * sizes the conduit MTU from this.
> +	 */
> +	.needed_headroom	= LAN9645X_TOTAL_TAG_LEN,
> +};

[Severity: Medium]
There is no .flow_dissect callback here, so __skb_flow_dissect() falls back
to dsa_tag_generic_flow_dissect(). That helper assumes the tag overhead is
exactly needed_headroom:

include/net/dsa.h:dsa_tag_generic_flow_dissect() {
	...
	*offset = tag_len;
	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
}

Does that hold for this tagger? Whenever the rewriter popped tags,
lan9645x_rcv() skips a 4 or 8 byte ifh_gap_len between the IFH and the
real DMAC.

The later "net: dsa: lan9645x: add vlan support" patch sets
ANA_VLAN_CFG_VLAN_POP_CNT=1 on VLAN-aware ports. So every tagged frame
received on those ports has a 4 byte gap.

For those frames, would the generic dissector take SMAC or gap bytes as the
EtherType and use the wrong network header offset? That would misdirect RPS
and skb_get_hash() on the conduit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
