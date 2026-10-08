Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB424B8278
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485051; cv=none; b=Ml6Xs2TGPOSGCbpc121ylaejpJULeoGdl57oX1/ZCxLGk2IzexES/kdLqp5Ek2HTSp/VC1NXFTJevA6lBGGVeouCzsBvBzlFGK/gJ7Mn+IOE9wRLXGASuDwlPe2pLDDcudJmQDOjXq83QEXh5QSzphE1ikBuy015y6M02gGD09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485051; c=relaxed/simple;
	bh=D3C2+CPSUrDNGiECl4c6iI5MuZeBIOZ/tskDYhWvbyg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvV8YLM3Pj1McCUoCW1Qrk/1jLdbDikSkb2V+GcVzFjqQ+K3+ucGktoUWCEWOB3ZtxfGSsr0hfQUikGa1abht2gC2rDAdrfuCqlIU+JLiPrdsUd5HPQpIcwXF+vEsVc2wXDrDwpseQXoBMfln/Fvp8K4cRKmsXyCKr1bfREa49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmHiYx+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmHiYx+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990101F000FF;
	Thu,  8 Oct 2026 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485050;
	bh=6P25MoiAnQlOa+LGJiLhWjlewCLPZuk/gUuvJTloNLg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kmHiYx+T/SRz8YfvvO7psk2cXPNTTdo4P3SizpeOrOo9kxDwgFNVe22vHFgtZNp28
	 6E+UGGCuQs63iJitRL5VME8ODUN6BtHmQ59TX3+Oo3bSFX2Xq3/CCc/9F81axb8p1F
	 WwLVLyAh0Rjkdpyha6i86d1MZIv0ewrMmNpIjHYdvRtnbvwPQGFT//Wei8gZypYIrJ
	 aoJK4KEGKydAfbpDFiFOSqqOILFYIO9DljVIl6t86IFxDssLDuZlKBvTqPraryoWYa
	 XfHhmaBbveePbe++hOTmrMC11D/U75sSd/R/1m9/NWwYYAEGPJ+PsvHmsKO7z0NZ72
	 SdJQvndQjMnvQ==
Subject: Re: [PATCH v2 net] vlan: do not insert the vlan header in
 vlan_dev_hard_header()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, sairon@users.noreply.github.com,
 hitchin999@users.noreply.github.com, stefan@agner.ch, hkallweit1@gmail.com
Date: Thu, 08 Oct 2026 18:44:09 +0000
Message-ID: <179148504911.434549.10972855424960315495@kernel.org>
In-Reply-To: <20261008123812.554729-1-edumazet@kernel.org>
References: <20261008123812.554729-1-edumazet@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch changes what VLAN_FLAG_REORDER_HDR (reorder_hdr)
  does on TX.

--

vlan: do not insert the vlan header in vlan_dev_hard_header()

This patch removes the in-band 802.1Q insertion from
vlan_dev_hard_header() for reorder_hdr=off VLANs. It also makes
vlan_dev_hard_start_xmit() always set the hwaccel tag, and leaves software
insertion to validate_xmit_vlan(). The goal is to fix r8169 transmit
timeouts seen since 447cbe95ebb9.

Closes: https://github.com/home-assistant/operating-system/issues/5019
Closes: https://lore.kernel.org/netdev/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/

> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index c949c6a829456..bd98c191a66f9 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c

[ ... ]

> @@ -49,47 +53,14 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
>  				unsigned int len)
>  {
>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -	struct vlan_hdr *vhdr;
> -	unsigned int vhdrlen = 0;
> -	u16 vlan_tci = 0;
> -	int rc;
> -
> -	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {

[ ... ]

> -		vhdr = skb_push(skb, VLAN_HLEN);

[ ... ]

> -		skb->protocol = vlan->vlan_proto;
> -		type = ntohs(vlan->vlan_proto);
> -		vhdrlen = VLAN_HLEN;
> -	}
> +	struct net_device *real_dev = vlan->real_dev;

[ ... ]

> @@ -106,22 +77,13 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
>  					    struct net_device *dev)
>  {
>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)(skb->data);
>  	unsigned int len;
> +	u16 vlan_tci;
>  	int ret;
>  
> -	/* Handle non-VLAN frames if they are sent to us, for example by DHCP.
> -	 *
> -	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
> -	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
> -	 */
> -	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
> -	    veth->h_vlan_proto != vlan->vlan_proto) {
> -		u16 vlan_tci;
> -		vlan_tci = vlan->vlan_id;
> -		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
> -		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
> -	}
> +	vlan_tci = vlan->vlan_id;
> +	vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
> +	__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);

[Severity: Medium]
Does this change more of the reorder_hdr=off TX behaviour than the commit
message describes?

The changelog says the (veth->h_vlan_proto != vlan->vlan_proto) test "only
made sense together with the insertion in vlan_dev_hard_header()". Before
447cbe95ebb9, offload-capable real devices used vlan_passthru_header_ops.
That never inserted a tag, yet this test still applied to them.

The test compares only the TPID, not the VID. Without it, take any frame
that reaches vlan_dev_hard_start_xmit() on a reorder_hdr=off VLAN and
already carries an in-band tag with the same TPID (any VID). It now goes
out as ETH|VLAN(ours)|VLAN(theirs). Before this patch it kept only its
original tag.

AF_PACKET SOCK_RAW is not the only source of such frames. Others include
tc mirred or BPF redirect from another reorder_hdr=off VLAN's ingress, OVS
ports, and userspace reflectors.

The RX side, which this patch does not change, still produces that in-band
layout:

net/8021q/vlan_core.c:vlan_do_receive() {
    ...
	if (!(vlan_dev_priv(vlan_dev)->flags & VLAN_FLAG_REORDER_HDR) &&
	    !netif_is_macvlan_port(vlan_dev) &&
	    !netif_is_bridge_port(vlan_dev)) {
		...
		skb = *skbp = vlan_insert_inner_tag(skb, skb->vlan_proto,
						    skb->vlan_tci, skb->mac_len);
    ...
	__vlan_hwaccel_clear_tag(skb);
    ...
}

vlan_parse_protocol() also still expects SOCK_RAW frames to carry an
in-band tag, and skips it:

static __be16 vlan_parse_protocol(const struct sk_buff *skb)
{
	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)(skb->data);

	return __vlan_get_protocol(skb, veth->h_vlan_proto, NULL);
}

So a frame received on a reorder_hdr=off VLAN and sent back out through
one is now double tagged. Before, RX and TX agreed on the layout. Is that
intended?

There is also a change on real devices without HW VLAN TX offload. Those
always used vlan_header_ops. For reorder_hdr=off, vlan_dev_hard_header()
has pushed the 802.1Q header and set skb->protocol = vlan_proto since
2.6.12.

After this patch, anything that sees frames at the VLAN device's egress
gets untagged frames, with skb->protocol set to the L3 protocol. That
includes dev_queue_xmit_nit taps, tc/BPF egress and nft netdev egress.
Egress rules written for the tagged layout would stop matching.

That goes beyond undoing what 447cbe95ebb9 changed on offload-capable
NICs. The commit message does not mention it.

Locally generated traffic still leaves with a single tag, the same as
reorder_hdr=on. But 447cbe95ebb9 is marked for stable back to 3.19, so
this change would be backported widely.

Could the changelog describe these changes? Alternatively, TX could skip
adding a tag when the frame already carries our tag in-band, so that it
matches RX.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008123812.554729-1-edumazet%40kernel.org
