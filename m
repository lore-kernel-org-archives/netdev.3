Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3213DBBD
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999451; cv=none; b=lxclfl4jqnJxOy410nPcO/VMz0ujV/9vS1of0G8gX193ZugW7SWb3EFdtra3CG6dY6qusvbvl58O61V3tIwsa+gwhrTiNg/Egp33lYE/cT9jDKgs6Q/zxgWYCmNcqJNBL4FcWt8veuzVbQa9480Fs0bF0C9kNxgWjguUm5zdaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999451; c=relaxed/simple;
	bh=rCR9teW7EHPMuO+ezjAYxU+HdrAJQ/9FHEMBB7ezbBU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYxRfK8aMZ42E9XG5qOA05kTk8DM/2nvO7Y6hzCxPmUdauFarIFrloUWbFUYlbSR3Bs27kAc604KOp8eZC3ZJfZGU+skb9Bkf8Dprco8Lv6f6yiKVvNkWYn5QIroyuOpgbqEfs5X35ZILamtWpgJ2+5LWVJYJJ3pakmxmQcM8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ockexoap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ockexoap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A0E1F00893;
	Thu, 10 Sep 2026 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999449;
	bh=A3rjJzMbuALbDDeAJDs+K+t+TcfRjP35uXCFyr1T8qk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OckexoapMX6Ke6soTS4zzlRzangdNn2JWPyRcSNAv/OPXspso/ZKNKIeT6hNqfKru
	 zDbCh8/Rg/uA71fRb1BHkL8pNi2guX8QFoJ0L6qdg8n8Jnf8DdShJtvWjMRKBvFezs
	 fbMCiCZOUSAQLoCtP4Hu4VXR1fgvwww7lH3zmIlQCK/8PWLEjbvtiI8FrdrqYbuz71
	 FRgmeyEH/d5Yh2jvgyydYAhuPIElovICztss8at3NNIMTfB712Z6Kk29VKixSLwuyV
	 Za7YqVOws4yf+DOMR2gsn2op4hcn4anuo38QzuPWdp3VojwqNWUpGHA84oX+fMIIKg
	 uR4fRBX76mnPw==
Subject:
 Re: [PATCH net-next v1 5/6] net: dsa: tag: mt7628: add VLAN awareness support
From: netdev-bot+sashiko@kernel.org
To: joey@tinyisr.com
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
 andrew@lunn.ch
Date: Thu, 10 Sep 2026 00:17:28 +0000
Message-ID: <178899944890.219967.14085595993296385536@kernel.org>
In-Reply-To: <20260906171625.533915-6-joey@tinyisr.com>
References: <20260906171625.533915-6-joey@tinyisr.com>
X-sashiko-severity: High
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

Critical: 0 · High: 3 · Medium: 2 · Low: 0

- [High] mt7628_tag_xmit() (net/dsa/tag_mt7628.c:49-58) overwrites the
  two bytes at dsa_etype_header_pos_tx(skb) (skb->data + 2*ETH_ALEN)…
- [High] For a port under a VLAN-aware (filtering) bridge,
  mt7628_tag_xmit() only takes the new "modify TPID in place" path when…
- [High] mt7628_tag_xmit() (net/dsa/tag_mt7628.c:49-50) passes the result
  of dsa_port_bridge_dev_get(dp) straight into br_vlan_enabled(), which…
- [Medium] Both new code paths hardcode ETH_P_8021Q.
- [Medium] mt7628_tag_rcv() (net/dsa/tag_mt7628.c:115-116) re-inserts the
  switch-inserted VLAN tag as a hwaccel tag for every non-tag_8021q VID,…

--

net: dsa: tag: mt7628: add VLAN awareness support

This teaches the MT7628 tagger to support VLAN-aware bridges by rewriting
the TPID of an already present VLAN tag on egress instead of pushing a new
MT7628 tag, and by restoring the stripped VLAN tag as a hardware
accelerated tag on ingress.  The receive path also falls back to a VID
based source port lookup when the switch reports port 0.

A few questions about the new paths below.

> diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
> index fab9d4f04b7a0..7c71e8b086481 100644
> --- a/net/dsa/tag_mt7628.c
> +++ b/net/dsa/tag_mt7628.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/etherdevice.h>
>  #include <linux/dsa/8021q.h>
> +#include <linux/if_vlan.h>
>  #include <net/dsa.h>
>  
>  #include "tag.h"

[ ... ]

> @@ -34,10 +38,25 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
>  				       struct net_device *dev)
>  {
>  	struct dsa_port *dp;
> +	u16 xmit_tpid;
>  	u16 xmit_vlan;
>  	__be16 *tag;
>  
> +	xmit_tpid =
> +	    ETH_P_8021Q | FIELD_PREP(MT7628_TAG_TX_PORT,
> +				     dsa_xmit_port_mask(skb, dev));
>  	dp = dsa_user_to_port(dev);
> +	if (skb->offload_fwd_mark &&
> +	    br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {

[Severity: High]
Can br_vlan_enabled() be reached here with a NULL device?

dsa_port_bridge_dev_get() is documented to return NULL for a port with no
bridge:

include/net/dsa.h:
	static inline struct net_device *
	dsa_port_bridge_dev_get(const struct dsa_port *dp)
	{
		return dp->bridge ? dp->bridge->dev : NULL;
	}

and the real br_vlan_enabled() dereferences its argument without a check:

net/bridge/br_vlan.c:
	bool br_vlan_enabled(const struct net_device *dev)
	{
		struct net_bridge *br = netdev_priv(dev);

		return br_opt_get(br, BROPT_VLAN_ENABLED);
	}

skb->offload_fwd_mark is set on RX for any bridged user port by
dsa_default_offload_fwd_mark(), and it survives a redirect
(tcf_mirred_forward() -> dev_queue_xmit()).  A frame received on a bridged
port and redirected out a standalone port with
"tc ... action mirred egress redirect dev swpN" would therefore enter
mt7628_tag_xmit() with offload_fwd_mark == 1 and dp->bridge == NULL.  The
pre-patch code tolerated that because dsa_port_bridge_num_get() checks
dp->bridge itself.

Is the lockless read of dp->bridge also safe against teardown?
dsa_port_bridge_destroy() frees the bridge with a plain kfree():

net/dsa/port.c:
	struct dsa_bridge *bridge = dp->bridge;

	dp->bridge = NULL;

	if (!refcount_dec_and_test(&bridge->refcount))
		return;
	...
	kfree(bridge);

There is no call_rcu()/kfree_rcu() or synchronize_net() here, while the
tagger reads dp->bridge from softirq TX context, so "ip link set swpX
nomaster" with traffic flowing looks like it can make the reader observe
either NULL or a freed struct dsa_bridge and then dereference bridge->dev.

Note also that dp->bridge is read twice, once here and once via
dsa_port_bridge_num_get() below, so a concurrent join/leave can select this
branch based on one bridge and compute the VBID from another (or from
bridge_num 0, which is reserved).

Would reading the bridge device once into a local and testing it, the way
dsa_xmit_ll() does, address both?

net/dsa/tag_dsa.c:
	if (skb->protocol == htons(ETH_P_8021Q) &&
	    (!br_dev || br_vlan_enabled(br_dev))) {

> +		/*
> +		 * On VLAN aware ports only modify the TPID to contain the
> +		 * MT7628 egress port metadata, instead of adding a new vlan tag
> +		 */
> +		tag = dsa_etype_header_pos_tx(skb);
> +		tag[0] = htons(xmit_tpid);
> +		return skb;
> +	}
> +

[Severity: High]
Is there anything guaranteeing that the two bytes at
dsa_etype_header_pos_tx(skb) really are an 802.1Q TPID here?

skb->offload_fwd_mark only says the frame was/should be hardware forwarded;
it says nothing about the header layout.  A concrete sequence:

  - swp0 and swp1 in a VLAN-unaware bridge.  mt7628_tag_rcv() takes the
    is_dsa_8021q == true path, so no VLAN tag is restored and the frame is
    untagged, but dsa_default_offload_fwd_mark() still sets
    skb->offload_fwd_mark = 1.

  - a tc ingress rule on swp0 redirects to swp2, which belongs to a
    VLAN-aware bridge.

mt7628_tag_xmit() then takes this branch on an untagged frame: the real
EtherType (say 0x0800) is replaced by ETH_P_8021Q | port_mask and the next
two payload bytes are consumed by the switch as the VLAN TCI, so the frame
is forwarded on a VID taken from packet payload.

The sibling taggers gate the same optimisation on the frame actually being
tagged, for example tag_dsa.c:

	if (skb->protocol == htons(ETH_P_8021Q) &&
	    (!br_dev || br_vlan_enabled(br_dev))) {

and tag_sja1105.c uses skb_vlan_tag_present() /
__vlan_hwaccel_push_inside().  Would an eth_type_vlan(skb->protocol) or
skb_vlan_tag_present() test here, falling back to pushing a real MT7628
tag, keep this branch self-consistent?

[Severity: Medium]
Both new paths hardcode ETH_P_8021Q.  What happens with a bridge created as
"vlan_filtering 1 vlan_protocol 802.1ad"?

On egress the existing 0x88A8 TPID is overwritten with ETH_P_8021Q |
port_mask, and on ingress mt7628_tag_rcv() restores the tag with
__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tci), so the bridge sees
vlan_proto 0x8100 while it selected 0x88A8.

DSA has no SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL handler, so neither the
core nor drivers/net/dsa/mt7628.c can reject such a bridge, and the
registers the driver programs contain no configurable TPID.

sja1105 consults the bridge instead of hardcoding the value:

net/dsa/tag_sja1105.c:
		br_vlan_get_proto(br, &proto);

		return proto;

Would br_vlan_get_proto() be usable here as well, or should the driver
refuse 802.1ad bridges?

>  	xmit_vlan = skb->offload_fwd_mark ?
>  	    dsa_tag_8021q_bridge_vid(dsa_port_bridge_num_get(dp)) :
>  	    dsa_tag_8021q_standalone_vid(dp);

[Severity: High]
For a port under a VLAN-filtering bridge, only skb->offload_fwd_mark == 1
traffic takes the new branch above; everything else still falls through here
and gets a tag_8021q VID.

But mt7628_dsa_8021q_vlan_add() registers every tag_8021q VID as
MT7628_VLAN_TYPE_UNAWARE, and mt7628_vlan_sync() removes VLAN-filtering
ports from both the member and the untag mask of those blocks:

drivers/net/dsa/mt7628.c:
		if (vlan->type == MT7628_VLAN_TYPE_AWARE)
			member_mask = esw->vlan_filtering;
		else
			member_mask = ~esw->vlan_filtering;
		member_mask |= MT7628_ESW_PORTS_CPU;
		...
		mt7628_esw_set_vmsc(esw, i, vlan->members & member_mask);
		mt7628_esw_set_vub(esw, i, vlan->untag & member_mask);

There is real traffic to such a port with offload_fwd_mark == 0:

  - locally originated frames sent on the swpX netdev, including STP BPDUs
    via br_send_bpdu() -> dev_queue_xmit(p->dev);

  - bridge-forwarded IGMP/MLD, because tx_fwd_offload is refused for them:

    net/bridge/br_switchdev.c, nbp_switchdev_can_offload_tx_fwd():
	if (br_multicast_igmp_type(skb))
		return false;

In those cases the tagger targets dsa_tag_8021q_standalone_vid(dp) for a
port that is not a member of that VLAN and whose egress untag bit was
cleared.  Does that frame get dropped by the switch, or does it leave the
port still carrying a DSA-reserved VID from the 3072-4095 range?

> @@ -47,9 +66,7 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,

[ ... ]

> @@ -77,6 +111,10 @@ static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
>  	skb_pull_rcsum(skb, MT7628_TAG_LEN);
>  	dsa_strip_etype_header(skb, MT7628_TAG_LEN);
>  	dsa_default_offload_fwd_mark(skb);
> +
> +	if (!is_dsa_8021q)
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tci);
> +

[Severity: Medium]
This restores the tag for every non-tag_8021q VID, including tags the switch
inserted itself from the port PVID for frames that arrived untagged on the
wire, which is the case the new comment above describes ("packets where the
VLAN tag is inserted by the PVID mechanism").

The core already has a mechanism for exactly this hardware behaviour:

include/net/dsa.h:
	/* Pop the default_pvid of VLAN-aware bridge ports from tagged frames.
	 * Useful if the switch cannot preserve the VLAN tag as seen on the
	 * wire for user port ingress, and chooses to send all frames as
	 * VLAN-tagged to the CPU, including those which were originally
	 * untagged.
	 */
	u32			untag_vlan_aware_bridge_pvid:1;

and it is only honoured when the driver opts in:

net/dsa/tag.c, dsa_switch_rcv():
	if (unlikely(cpu_dp->ds->untag_bridge_pvid ||
		     cpu_dp->ds->untag_vlan_aware_bridge_pvid)) {
		/* dsa_software_vlan_untag() drops skb on failure */
		nskb = dsa_software_vlan_untag(skb);

mt7628_setup() registers tag_8021q and max_num_bridges but never sets
untag_vlan_aware_bridge_pvid, so dsa_software_untag_vlan_aware_bridge() is
never reached for this switch.  Should the driver set that flag, so that
packet sockets, tc ingress filters, ebtables/nft VLAN matches and software
protocols running on the plain port do not see a tag that was never on the
wire?

>  	return skb;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906171625.533915-1-joey%40tinyisr.com
