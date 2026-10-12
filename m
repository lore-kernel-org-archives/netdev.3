Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7543AE71E;
	Mon, 12 Oct 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804280; cv=none; b=HOT89q2fZafHJw9dHdXlkCeyTbUvQx/9O50/VS/ej1zGPLMcL1L9O3tP93mYjGChFFH/lMQ+cRP7YmWVvWF/Fj6g3Bhjjbw1qa+01udBOk+3MN5XzBixR4ZViJ/hK4+tTnzBWbnkYfe9sYtU2xRzb3fQG8As+i1FYrFa3iW0Puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804280; c=relaxed/simple;
	bh=fQknfqD2eh1+4Zwnmtmm7WnfEFmN00kQHDmtqEhm5lk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NeVCTH5Vjwu137a/FfHmjrrMdSDNG0iBYyPlA62sfidgTpWYAbksjhSfJzCZdz+vljHt2FFWqOUwPnMI0l26kjuaYSC/9jZk2zcydl+qExvZybUiBEUBlUEJq9f3enHz6K1HQjBk1Rmy5L/6Uwe2VcfwgR4E1oRWrsYeCHZg2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCAFLWYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCAFLWYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1C41F0089B;
	Mon, 12 Oct 2026 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804278;
	bh=CykgXqTEqc+/3207dxc9jLbv7AL3FJhqFGyO7eq6Hxs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TCAFLWYR+s8Mh1t4k32L9rtMFwFFF19Wwb9MOojtSymI3VEIpZDVe6ZRaD8pLrMpD
	 SgImpwLdrcJj2Mg1rTAKgp3tuhdXyh3MXyLMtu2CghjyAx943izanIBRQSFRL8+Eui
	 OpB5O9+3lSQz+V/HZZUOUC9ILx49eKEnZrAeDLbu8ceuAcWIvCEmxTTvJfqhDHlP1X
	 033uH44GJIHiCEaLYqTZCaE1sDDRK66rUCWEREjmU29rlTmsBbAzBYvx3eeY1PQ9uU
	 CK7tNI8Nd8aJDp0cRdXvai0ZTv0qq0aA7IxsDnvIfFf9Nnfd3DWl1begfAdW/REeDe
	 k3ltO0F7Bl93g==
Subject: Re: [PATCH net-next v14 1/9] net: dsa: add tag driver for LAN9645X
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
Date: Mon, 12 Oct 2026 11:24:37 +0000
Message-ID: <179180427718.434549.18360749106735687436@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-1-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-1-3d2a72661213@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In lan9645x_rcv() (net/dsa/tag_lan9645x.c:459), every tag
  popped by the hardware is restored as an 802.1Q hwaccel tag with…
- [Low] The comment above skb_postpull_rcsum() in lan9645x_rcv()
  (net/dsa/tag_lan9645x.c:416-421) says the bytes to subtract are "what…
- [Low] lan9645x_rcv() (net/dsa/tag_lan9645x.c:450) restores the popped
  VLAN tag only when `dsa_port_is_vlan_filtering(dp) && ifh_gap_len`.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new
  tagger adds another lockless reader of it.

--

net: dsa: add tag driver for LAN9645X

This adds a DSA tag driver for the Microchip LAN9645x switch when a front
port is used as the CPU (NPI) port. Extraction uses a long prefix plus a
28 byte IFH, and injection uses only the IFH. VLAN tags popped by the
hardware are restored on receive as 802.1Q hwaccel tags, and on transmit
the VLAN tag is moved from the payload into the IFH.

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
This isn't a bug introduced by this patch, but this adds one more lockless
reader of dp->bridge in the xmit path.

dsa_port_bridge_dev_get() does this with no READ_ONCE() and no lifetime
protection:

	return dp->bridge ? dp->bridge->dev : NULL;

On bridge leave, dsa_port_bridge_leave()->dsa_port_bridge_destroy() clears
the pointer and frees the last reference right away:

	dp->bridge = NULL;

	if (!refcount_dec_and_test(&bridge->refcount))
		return;
	...
	kfree(bridge);

There is no RCU grace period between the two. Can a transmit on the user
port that races with the bridge leave load the old dp->bridge and then read
->dev from a freed dsa_bridge?

The window is narrow. tag_ocelot.c, tag_sja1105.c and the
dsa_software_vlan_untag() helpers use the same pattern, so the root cause
is in the DSA core and not in this tagger.

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
This isn't a bug, but the comment doesn't list everything the call
subtracts.

The length is LAN9645X_TOTAL_TAG_LEN + ifh_gap_len, which is 44 + gap
bytes. That is 2 bytes of prefix remainder, plus 28 bytes of IFH, plus the
gap, plus the 14 byte real Ethernet header.

The code looks right, because dsa_switch_rcv() does skb_push(ETH_HLEN) and
then eth_type_trans() without adjusting the checksum. Could the comment
also mention the real Ethernet header? Otherwise someone might later
shorten the length to match the comment.

[ ... ]

> +	dp = dsa_user_to_port(skb->dev);
> +
> +	if (dsa_port_is_vlan_filtering(dp) && ifh_gap_len) {

[Severity: Low]
Can frames lose their VLAN tag while vlan_filtering is changing?

dsa_port_vlan_filtering() calls the driver op before it updates the
software flag:

	err = ds->ops->port_vlan_filtering(ds, dp->index, vlan_filtering,
					   extack);
	...
		dp->vlan_filtering = vlan_filtering;

In this series, lan9645x_port_vlan_filtering() programs VLAN_POP_CNT right
away through lan9645x_vlan_port_apply(). Frames that the hardware pops in
that window reach lan9645x_rcv() with ifh_gap_len != 0 while
dsa_port_is_vlan_filtering(dp) is still false. They are delivered with no
tag.

The reverse transition has the same problem, including bridge leave via
lan9645x_vlan_set_hostmode(). Frames popped before the change but handled
after dp->vlan_filtering is cleared also lose their tag.

POP_CNT is 0 on non-filtering ports, so the gap is already 0 there. Would
checking only ifh_gap_len keep the CPU view consistent with what the
hardware did?

> +		/* The tag is restored as a C-tag, not as the TAG_TYPE the IFH
> +		 * reports. The classifier recognizes both TPIDs as VLAN tags,
> +		 * so an S-tag has already been used for classification by the
> +		 * time we get here. Restoring it as 802.1AD would make the
> +		 * bridge push it back into the payload and reclassify the frame
> +		 * to the port pvid, on a different VID than the one the
> +		 * hardware forwarded it on.
> +		 */
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
> +	}

[Severity: Medium]
Is the 802.1Q-only assumption enforced anywhere? The commit message says:

  This assumes a bridge vlan_protocol of 802.1Q, which is the only
  protocol the driver offloads.

The xmit side of this file does handle non-802.1Q bridges, in
lan9645x_xmit_get_vlan_info():

	br_vlan_get_proto(br, &proto);
	...
		if (ntohs(hdr->h_vlan_proto) == proto &&
		    ntohs(hdr->h_vlan_TCI) & VLAN_VID_MASK) {
	...
	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
					     LAN9645X_IFH_TAG_TYPE_C;

DSA doesn't handle SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.
__br_vlan_set_proto() sends that attribute with
SWITCHDEV_F_SKIP_EOPNOTSUPP, so setting "vlan_protocol 802.1ad" on the
bridge seems to succeed while the lan9645x ports stay offloaded. The switch
driver in this series doesn't appear to check the bridge vlan_protocol
either.

On such a bridge, every tag restored here has an 0x8100 TPID, and
__allowed_ingress() in net/bridge/br_vlan.c then does:

	if (skb->vlan_proto != br->vlan_proto) {
		/* Protocol-mismatch, empty out vlan_tci for new tag */
		skb_push(skb, ETH_HLEN);
		skb = vlan_insert_tag_set_proto(skb, skb->vlan_proto,
						skb_vlan_tag_get(skb));

This pushes the tag back into the payload and classifies the frame to the
pvid. Wouldn't frames trapped or copied to the CPU then land on the pvid?
That is the same misclassification the C-tag normalization is meant to
avoid, only in the opposite configuration.

Should rcv follow the bridge vlan_protocol the way xmit does? Or should the
driver refuse 802.1ad bridges?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
