Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40342D12EE
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999450; cv=none; b=rB3fcTpH7qy86AxB/2+ztnTyHArpkwHq0CGrwt84pT20io4cRP0MPrO5u8P7QDDVosfza7L6SE7zNNSfSOL5bG5k2FCDUWUseY9DuNkhSMBoSGw26wuGnj7GT1H6iADjoO3Z1lSpy0jOrmg8Z6q/DRFNACzCD8osoQWjl3hr8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999450; c=relaxed/simple;
	bh=ahWgPAbfR6loRoe4QcTG25sF5N6LXLbTWp4Hp5gm51I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgldp6IPxRmSRdmoWT0iU3jLFCpy+HhKIHUSwucLRyhL6a8sE9arvfin3koK2Nn25JiF7NgagL+8UlydvNbjT0TbPzO4kent82pjjTBRS56OXLCdqsRjdX5/JmIC0rnmDZrIFAIh8L0pY2W78NdbrLjRy+85oTw4SG/aZHOwz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP6dIUPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP6dIUPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061291F00898;
	Thu, 10 Sep 2026 00:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999447;
	bh=mTDHlYKfvA363rrKWLtB5kCck3F/8tsLkSPLCGETP4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EP6dIUPxHSL8otErQXKNetHZzjxGN8bHtOHJQtFyJHZrtcqz04z0aR8vGedmBfyAI
	 nKT4mmSbxpsEAZQVlTkb82jdk94ynLO8DN6JXaTXENX2X9DFlV4IhzrkqnVzbPs3XM
	 02FfKZDbqVeWFEzGfu99JLySfx+8asi2VNk8YMVdtbBhGPzwPvvWQGBMzUx+PAZW04
	 S3Bt8QeZ1QRMVKCGFh7H4aZfQ/I7ktQO0AiCV8tbTTy7NWCW1LqLVKxWTsfoxHGuy7
	 55SrINtYZn6JmH8Hundk8CZ4HgpY2HvWAKzGKZRdJjE6xExA+PZMGZFm8hcopc4Ezf
	 y1wJTImLq30YA==
Subject: Re: [PATCH net-next v1 3/6] net: dsa: tag: mt7628: add bridge support
From: netdev-bot+sashiko@kernel.org
To: joey@tinyisr.com
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
 andrew@lunn.ch
Date: Thu, 10 Sep 2026 00:17:26 +0000
Message-ID: <178899944660.219967.17661076116703942045@kernel.org>
In-Reply-To: <20260906171625.533915-4-joey@tinyisr.com>
References: <20260906171625.533915-4-joey@tinyisr.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 2

- [High] mt7628_tag_xmit() (net/dsa/tag_mt7628.c:40-53) switches the VLAN
  of an `skb->offload_fwd_mark` frame to the tag_8021q bridge (VBID)…
- [Medium] mt7628_tag_xmit() (net/dsa/tag_mt7628.c:41-43) derives the
  egress VLAN from `dsa_port_bridge_num_get(dp)` solely on the basis of…
- [Low] mt7628_tag_xmit() selects the imprecise tag_8021q bridge VID for
  every skb with offload_fwd_mark set, without checking…
- [Low] Series ordering/bisectability: the preceding commit 'net: dsa:
  mt7628: add port bridge offload support'…

Pre-existing issues:
- [Medium] mt7628_tag_xmit() reads rtnl-protected bridge state
  (dsa_port_bridge_num_get(dp) -> dp->bridge->num) from the lockless TX…

--

net: dsa: tag: mt7628: add bridge support

The tagger now picks the tag_8021q bridge VLAN instead of the port's
standalone VLAN when skb->offload_fwd_mark is set, so that bridged egress
uses the VLAN the port is a member of.

> diff --git a/net/dsa/tag_mt7628.c b/net/dsa/tag_mt7628.c
> index 80b50ff08e53f..fab9d4f04b7a0 100644
> --- a/net/dsa/tag_mt7628.c
> +++ b/net/dsa/tag_mt7628.c

[ ... ]

> @@ -38,7 +38,9 @@ static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
>  	__be16 *tag;
>  
>  	dp = dsa_user_to_port(dev);
> -	xmit_vlan = dsa_tag_8021q_standalone_vid(dp);
> +	xmit_vlan = skb->offload_fwd_mark ?
> +	    dsa_tag_8021q_bridge_vid(dsa_port_bridge_num_get(dp)) :
> +	    dsa_tag_8021q_standalone_vid(dp);

[Severity: High]
The VLAN is switched to the bridge broadcast domain here, but the
destination port field of the tag is still the precise single-port bitmap:

net/dsa/tag_mt7628.c:mt7628_tag_xmit() {
	tag[0] = htons(ETH_P_8021Q |
		       FIELD_PREP(MT7628_TAG_TX_PORT,
				  dsa_xmit_port_mask(skb, dev)));
	tag[1] = htons(xmit_vlan);
}

and dsa_xmit_port_mask() in net/dsa/tag.h starts from a single bit:

	unsigned long mask = BIT(dp->index);

Can the switch replicate a flooded frame with that mask?

The driver uses dsa_tag_8021q_bridge_join() as .port_bridge_join, and that
function sets *tx_fwd_offload = true unconditionally, so the software bridge
stops cloning to the other ports of the same hwdom:

net/bridge/br_switchdev.c:nbp_switchdev_allowed_egress() {
	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);
}

Documentation/networking/dsa/dsa.rst describes the resulting contract:

	Additionally, replication of data plane packets (multicast, flooding)
	is handled in hardware and the bridge driver will transmit a single
	skb for each packet that may or may not need replication.

With the destination bitmap pinned to one port, do host-originated
broadcast, multicast and unknown unicast frames (ARP requests, DHCP, mDNS,
IPv6 NS) reach only a single bridge member port, with no software copies for
the remaining ports of the same switch?

For comparison, sja1105_imprecise_xmit() in net/dsa/tag_sja1105.c uses
dsa_tag_8021q_bridge_vid() without restricting the destination port.

This also looks unchanged at the end of the series: after "net: dsa: tag:
mt7628: add VLAN awareness support" both the VLAN-aware and VLAN-unaware
bridge paths still build xmit_tpid from dsa_xmit_port_mask().

[Severity: Medium]
Is skb->offload_fwd_mark on its own enough to conclude that the egress port
is bridged?

include/net/dsa.h:dsa_port_bridge_num_get() {
	return dp->bridge ? dp->bridge->num : 0;
}

net/dsa/tag_8021q.c:dsa_tag_8021q_bridge_vid() {
	/* The VBID value of 0 is reserved for precise TX, but it is also
	 * reserved/invalid for the bridge_num, so all is well.
	 */
	return DSA_8021Q_RSV | DSA_8021Q_VBID(bridge_num);
}

So a bridge_num of 0 yields 0xC00, which is also the standalone VID of
switch 0 / port 0.

mt7628_tag_rcv() sets the mark for every frame received on a bridged port:

net/dsa/tag.h:dsa_default_offload_fwd_mark() {
	skb->offload_fwd_mark = !!(dp->bridge);
}

and nothing clears it when a tc mirred egress redirect action hands that
same skb to a different user port. If that port is standalone, does the
frame get tagged with VID 0xC00 while the destination bitmap forces egress
on a port that is not a member of that VLAN, so the switch drops it under
PFC1 EN_VLAN? Before this change the egress port's own standalone VID was
used.

Would a fallback such as: if bridge_num is 0, use
dsa_tag_8021q_standalone_vid(dp), be reasonable here?

The same condition is reused at the end of the series, where this path
calls br_vlan_enabled(dsa_port_bridge_dev_get(dp)); with a standalone
egress port that is br_vlan_enabled(NULL), which reaches netdev_priv(NULL)
when CONFIG_BRIDGE_VLAN_FILTERING is enabled.

[Severity: Low]
This isn't a bug in the final tree, but the preceding commit 9369664c988d
("net: dsa: mt7628: add port bridge offload support") already installs
.port_bridge_join = dsa_tag_8021q_bridge_join, and that function drops the
port's standalone VLAN:

net/dsa/tag_8021q.c:dsa_tag_8021q_bridge_join() {
	err = dsa_port_tag_8021q_vlan_add(dp, bridge_vid, true);
	if (err)
		return err;

	dsa_port_tag_8021q_vlan_del(dp, standalone_vid, false);
}

Until the tagger change above, mt7628_tag_xmit() still tags egress frames
with dsa_tag_8021q_standalone_vid(dp), a VLAN the bridged port is no longer
a member of, so bridged transmit is broken at that intermediate commit and a
bisection landing there sees the breakage.

Could the driver and tagger changes be squashed, or the dependency mentioned
in the commit messages?

>  
>  	skb_push(skb, MT7628_TAG_LEN);
>  	dsa_alloc_etype_header(skb, MT7628_TAG_LEN);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906171625.533915-1-joey%40tinyisr.com
