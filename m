Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAB3F4105;
	Mon, 19 Oct 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404525; cv=none; b=hTiqqArq99db9L9/naUEywfzixW17V2ADkTvU7vNPBlb5PuEH6zbJpxbUOD1/3ZYlWKiRpd65HNqtJPSJ2CdIJjZOF+eIC6rhH5eBHhWahQbHLMdhEyM0sOay4BCcROyXkSHrv3BbIk5CPFT/egR3icuKwKmmM4NTGKrEuJdZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404525; c=relaxed/simple;
	bh=n8Tf/7qqLiw//HQdDvn08tz5aemP+CPcX71vysQ2MLs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxoEPDseJYkqzAuU8tVzO2IYwGz685ns1TWl/u2+BRWan3S/wS+pqSXsbWoTrybQRw5Gj0kJpq+2XqeJBzwWv5671hfcAFCnSdr5xNFaDIUUl3X5nCriOwhy5BRP8nKZZbm3zKzNCQbq+xVN6JQxGZSV57nm0F7ULSIMQEvjyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgsuENI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgsuENI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A651F000C5;
	Mon, 19 Oct 2026 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404523;
	bh=4QJqzVRlOb/4XvD9jkbEf5ioTwlVuvgRlotuSLwkD7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JgsuENI1mXMPg27lBmBGKlhIx8CakmHhQFpSiibBItLlh+Md0NNt1rmAVVfKwnMF8
	 6ksikFnTCWi4qG2kFVWxWXZzduG5uMZNRPrUb2LOf6SZig5xhpNnneiJCNEukYjCdB
	 2qU+zYo8nBiXdMjDziqXtTwGlcmDhtjbS7GWrPqZzBvg6m+z0pUqaJF+OhOPtFq0hh
	 ST2s9QR45Nc+++nABlNcrBs8Jsf8IJQ30yN3KMQPxd8vGbMASZOpaC6Tq/oLI8zB2y
	 LEeSnd62h9PtktQOlAdw1EGJnUqy6zWnJevsn1vwzg+4REO+PL7svlx08ZUez65NKJ
	 Zqedhkk7YT2oA==
Subject: Re: [PATCH net-next v15 1/9] net: dsa: add tag driver for LAN9645X
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 19 Oct 2026 10:08:42 +0000
Message-ID: <179240452203.3135.15637760949369416187@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-1-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-1-562f316f78b9@microchip.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In lan9645x_rcv() (net/dsa/tag_lan9645x.c), the VLAN tag is
  restored only if the software VLAN-filtering flag is set: `if…
- [Low] In lan9645x_rcv() (net/dsa/tag_lan9645x.c), the comment above
  skb_postpull_rcsum() lists what is subtracted from skb->csum as "what…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  lan9645x_xmit() calls dsa_port_bridge_dev_get(dp) (`dp->bridge ?

--

net: dsa: add tag driver for LAN9645X

This adds a DSA tag driver for the Microchip LAN9645x switch. A front port
is used as the NPI (CPU) port. Extraction uses a 16 byte long prefix plus
a 28 byte IFH, and injection uses only the IFH.

On receive, a VLAN tag popped by the hardware is restored from the IFH as
a hwaccel C-tag. On transmit, the VLAN tag of a VLAN-aware port is moved
from the payload into the IFH.

> diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> new file mode 100644
> index 0000000000000..00339daecfcbd
> --- /dev/null
> +++ b/net/dsa/tag_lan9645x.c
> @@ -0,0 +1,514 @@

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

[Severity: Medium]
This isn't a bug introduced by this patch, but is it safe to dereference
dp->bridge here?

lan9645x_xmit() runs without rtnl, and dsa_port_bridge_dev_get() uses
plain loads with no READ_ONCE() or RCU:

include/net/dsa.h:dsa_port_bridge_dev_get() {
	return dp->bridge ? dp->bridge->dev : NULL;
}

At the same time, dsa_port_bridge_leave()->dsa_port_bridge_destroy() runs
under rtnl and frees the dsa_bridge with no grace period:

net/dsa/port.c:dsa_port_bridge_destroy() {
	...
	dp->bridge = NULL;

	if (!refcount_dec_and_test(&bridge->refcount))
		return;
	...
	kfree(bridge);
}

Suppose a transmit loads dp->bridge before the NULL store, and the last
port leaves the bridge before it reads bridge->dev. Could that read be a
use-after-free of the dsa_bridge?

tag_dsa.c, tag_ocelot.c, tag_sja1105.c, tag_vsc73xx_8021q.c and
dsa_software_vlan_untag() in net/dsa/tag.h already use this pattern. The
root cause looks like the way DSA core manages the lifetime of struct
dsa_bridge, not this tagger.

[ ... ]

> +	/* Reset skb->data past the actual ethernet header. */
> +	skb_pull(skb, ETH_HLEN);
> +
> +	/* We must deliver the skb so skb->csum only covers the data beyond the
> +	 * real ethernet header. The fake ethernet header in the prefix is
> +	 * not part of skb->csum already. We must subtract what remains of the
> +	 * prefix, the ifh and the gap. The start is derived from the current
> +	 * skb->data rather than saved on entry, because the pskb_may_pull()
> +	 * calls above may have reallocated skb->head.
> +	 */
> +	skb_postpull_rcsum(skb,
> +			   skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len,
> +			   LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);

[Severity: Low]
This isn't a bug, but the comment in lan9645x_rcv() doesn't match the
length passed here. "what remains of the prefix, the ifh and the gap"
comes to 2 + 28 + gap bytes.

The call subtracts LAN9645X_TOTAL_TAG_LEN + ifh_gap_len, which is
44 + gap bytes. That range also covers the 14 byte real ethernet header.

The code looks correct, because dsa_switch_rcv() later calls
skb_push(ETH_HLEN) and eth_type_trans() without adjusting csum. Could the
comment also list the real ethernet header?

[ ... ]

> +	dp = dsa_user_to_port(skb->dev);
> +
> +	if (dsa_port_is_vlan_filtering(dp) && ifh_gap_len) {

[Severity: Medium]
Can a frame lose its VLAN tag here while VLAN filtering is being turned
on?

lan9645x_rcv() strips the gap whenever the hardware reports a pop, but
it only restores the tag if the software flag is also set. Turning on
vlan_filtering happens in this order:

br_vlan_filter_toggle()
  br_opt_toggle(br, BROPT_VLAN_ENABLED, !!val)  /* bridge VLAN-aware */
  switchdev_port_attr_set()
    dsa_port_vlan_filtering()
      ds->ops->port_vlan_filtering()
        lan9645x_port_vlan_filtering()
          lan9645x_vlan_port_apply()
            lan9645x_vlan_port_apply_ingress()
              ANA_VLAN_CFG_VLAN_POP_CNT_SET(1)  /* hw starts popping */
      dp->vlan_filtering = vlan_filtering;      /* tagger flag set */

Take a frame extracted after the POP_CNT write but handled before the
dp->vlan_filtering store. It arrives with ifh_gap_len == 4.
lan9645x_rcv() strips the gap but skips __vlan_hwaccel_put_tag().

The bridge is already VLAN-aware, so it sees an untagged frame. It
classifies the frame to the port pvid, or drops it if there is no pvid,
and the original VID and PCP are lost.

The same window opens when a port joins a bridge that already filters,
through dsa_port_switchdev_sync_attrs()->dsa_port_vlan_filtering().

The hardware only pops tags on a bridged, VLAN-aware port. Would it be
enough to restore the tag based on ifh_gap_len alone?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
