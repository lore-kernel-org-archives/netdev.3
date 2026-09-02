Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C039CCE6;
	Wed,  2 Sep 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342643; cv=none; b=fTsLR5xwKM83/cwENVLRskgVqcddV6udzlSk9FAJ1l998UHhWXLhke1P4k8Lce29u6S07UsPhgqwL0Iumq47+LS2NPopn9sthbMu0knKrwSDRTfjW8HX3/zKq9iCb1rPSqaoomFHdR3DpIyOkRTk1p/MhORT7456yUR5Pdil0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342643; c=relaxed/simple;
	bh=SuvCeIZprlwjj+7yJde3NkfOcm2mw/liJvCYWmbA3LY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdElDfmAIrvFcsoB+YTQviWGgL4NnHZE7MF2GnWvFEmTnEUouy5vo47pp3JzPWB4Txxzj9DMjnlgL/OW97jKKffDcqDhhqn+aMuVok6MtmGsD6CTgkuAzE5sOlSQLMOXTHUXyTX+AzwUstK2RxwUEdepl5fITbkXL07lSCddlks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri2toLlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri2toLlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBB31F00A3E;
	Wed,  2 Sep 2026 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342640;
	bh=jXTvPbb8DJyGXE9F08HMPvxkPy6P3oMr6HFpRnRk0v0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ri2toLlRSUNNKi4gsXRG+663+kuU6n5E3SkP6b+OOlUFPvAAyD+5IJyS0kZUcha1a
	 2PYIv7mrIhoaJjkj+34gdFUYK0gljMRxWgg3ZPfvkq2hT2iwley9dwXvIDc4xQvvim
	 UzNSu4h4bU786v5lufr3d1otBPLddF9s/f45zJlgmrZFE6rbOatErXmvywB+RarQHi
	 pVMSR3GEAEcZQthmNBB6lES2BQBuJgTLmFf/mucrYTTeYbNhLUUv7y4EYdU55p8Dbs
	 OK92QHmDfDL51n4/Kf+FPEm8csuvCfP1Y9ZvWaRFdW5TlQGreAgQUt82ACJzpJVm4d
	 M/sVx8Z0kUQng==
Subject:
 Re: [net-next,v8,3/5] net: dsa: tag_ks8995: Add the KS8995 tag handling
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 09:50:38 +0000
Message-ID: <178834263898.3394541.17006273846888620237@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-3-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-3-fd1dbb2b76e8@kernel.org>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 3

- [High] ks8995_xmit() (net/dsa/tag_ks8995.c:44-59) does not insert a
  switch tag when the frame already carries an in-band 802.1Q tag at…
- [High] ks8995_xmit() mixes two different header base pointers: the
  branch decision at net/dsa/tag_ks8995.c:44-45 reads the EtherType…
- [Low] DISCARDED (resolved later in the series): the new
  DSA_TAG_PROTO_KS8995 tagger has no in-tree consumer and no switch-side…
- [Low] DISCARDED as a functional bug, residual documentation defect
  only: the ks8995_rcv() comment at net/dsa/tag_ks8995.c:105-114 states…
- [Low] ks8995_rcv() calls netdev_err() (net/dsa/tag_ks8995.c:92) on
  every skb_vlan_untag() failure.

--

net: dsa: tag_ks8995: Add the KS8995 tag handling

This adds a new DSA tagger for the Micrel/Microchip KS8995 family. The tag
is a modified 0x8100 EtherType where the low nybble carries the target port
mask, and the tagger pushes any hardware-accelerated VLAN tag inside the
frame first so the special tag stays at offset 12.

A few questions about the transmit and receive paths below.

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 0000000000000..6bd5f1015c265
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,141 @@

[ ... ]

> +static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct vlan_ethhdr *hdr;
> +	u16 portmask;
> +
> +	/* Prepare the special KS8995 tags */
> +	portmask = dsa_xmit_port_mask(skb, dev);
> +
> +	/* The switch expects the special tag at offset 12. Move any hardware
> +	 * accelerated VLAN tag into the payload so the conduit cannot insert
> +	 * it outside the special tag.
> +	 */
> +	if (unlikely(skb_vlan_tag_present(skb))) {
> +		skb = __vlan_hwaccel_push_inside(skb);
> +		if (!skb)
> +			return NULL;
> +	}
> +
> +	hdr = skb_vlan_eth_hdr(skb);
> +	if (hdr->h_vlan_proto != htons(ETH_P_8021Q)) {
> +		skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), 0);
> +		/* vlan_insert_tag() drops the skb on failure */
> +		if (!skb)
> +			return NULL;
> +		hdr = skb_vlan_eth_hdr(skb);
> +		netdev_dbg(dev, "%s: inserted VLAN TAG %04x TCI %04x\n",
> +			   __func__, hdr->h_vlan_proto, hdr->h_vlan_TCI);
> +	} else {
> +		/* VLAN tag already exists in skb head, modify it in place */
> +		hdr = vlan_eth_hdr(skb);
> +		hdr->h_vlan_proto = KS8995M_STPID(portmask);

[Severity: High]
In the else branch of ks8995_xmit(), no switch tag is inserted; only the
TPID of the frame's existing 802.1Q tag is rewritten. Does that mean the
sender's VLAN tag is consumed as the special tag?

For an 8021q upper on a DSA user port the tag ends up in-band before the
tagger runs, either through the core:

  vlan_dev_hard_start_xmit() -> validate_xmit_vlan() ->
  __vlan_hwaccel_push_inside()

or through the __vlan_hwaccel_push_inside() call at the top of
ks8995_xmit() itself. The h_vlan_proto == htons(ETH_P_8021Q) test then
selects the in-place rewrite.

The companion patch in this series configures PORT_INSERT_TAG on the CPU
port and PORT_REMOVE_TAG on the user ports, with the comment in
ksz8_port_setup():

	/* The KSZ8995XA has a special tag format in the front of the frame
	 * that need to be inserted by the CPU and then removed by each
	 * port. PORT_REMOVE_TAG simply means "remove tags coming from the
	 * CPU port" it does not affect ingress packets.
	 */

If the user port removes those four bytes, do VLAN-tagged frames leave the
user port untagged, landing in the peer's native VLAN?

There is a second effect of reusing the existing tag: the special tag's TCI
becomes whatever VID/PCP the local sender chose (an 8021q upper, or a raw
socket writing its own 802.1Q header), whereas the vlan_insert_tag() branch
always produces TCI 0. Is that asymmetry intentional?

The commit message says:

    Push any hardware-accelerated VLAN tag into the packet before adding the
    switch tag.

For frames that already carry an 802.1Q tag no switch tag is added at all,
so could the merging behaviour be spelled out either in the commit message
or in a comment?

[Severity: High]
The branch decision and the write use two different header bases. The test
reads through skb_vlan_eth_hdr(), which is (struct vlan_ethhdr *)skb->data,
while the store goes through vlan_eth_hdr(), which is
(struct vlan_ethhdr *)skb_mac_header(skb). include/linux/if_vlan.h says of
skb_vlan_eth_hdr(): "Prefer this version in TX path".

The two bases coincide only because __dev_queue_xmit() calls
skb_reset_mac_header(). __dev_direct_xmit() does not, and neither does
validate_xmit_skb() on that path. AF_XDP copy mode takes exactly that
route:

  xsk_generic_xmit() -> xsk_build_skb()   /* mac_header left unset */
    -> __dev_direct_xmit() -> netdev_start_xmit()
      -> dsa_user_xmit() -> ks8995_xmit()

xsk_build_skb() allocates with sock_alloc_send_skb() and never sets the MAC
header, so skb->mac_header keeps the unset value (~0U); skb_mac_header()
only has a DEBUG_NET_WARN_ON_ONCE for that case.

For such an skb whose bytes 12-13 happen to be 0x8100 (fully chosen by the
AF_XDP application, which writes raw L2 frames), the test picks the else
branch from the correct offset and then:

		hdr = vlan_eth_hdr(skb);
		hdr->h_vlan_proto = KS8995M_STPID(portmask);

writes two bytes at skb->head + 0xFFFF + 12. Can this scribble outside the
buffer? Would simply reusing the hdr already obtained from
skb_vlan_eth_hdr() above avoid it? Other taggers that rewrite the header on
transmit use the skb->data based accessor, for example
net/dsa/tag_sja1105.c.

> +		netdev_dbg(dev, "%s: modified VLAN TAG %04x\n",
> +			   __func__, hdr->h_vlan_proto);
> +	}
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{

[ ... ]

> +	/* Move the custom DSA+VLAN tag into the hwaccel area and strip
> +	 * it from the skb head
> +	 */
> +	skb = skb_vlan_untag(skb);
> +	if (!skb) {
> +		/* skb_vlan_untag drops the skb on failure */
> +		netdev_err(dev, "%s: unable to untag skb\n", __func__);
> +		return NULL;
> +	}

[Severity: Low]
Could this netdev_err() flood the log? It is an unratelimited KERN_ERR on a
path driven entirely by received frames, and skb_vlan_untag() has two
remote-traffic-dependent failure modes:

net/core/skbuff.c:skb_vlan_untag() {
	...
	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))))
		goto err_free;
	...
	skb = skb_reorder_vlan_header(skb);
	if (unlikely(!skb))
		goto err_free;
	...
}

The first fires on short frames, the second on the skb_cow() ->
pskb_expand_head() GFP_ATOMIC allocation, which is reachable whenever the
RX skb is cloned (a packet socket tapping the conduit) and memory is tight.

The neighbouring drop reason in this same function uses netdev_dbg(), and
net/dsa/tag_lan9303.c uses dev_warn_ratelimited() on its RX drop path.
Would netdev_dbg() or a ratelimited/once variant be preferable here?

[ ... ]

> +	/* Preserve the VLAN tag if it contains a non-zero VID which is not
> +	 * identical to 0x001, or PCP, and restore its TPID to the standard
> +	 * value.
> +	 *
> +	 * If this is just an ordinary inbound package the datasheet claims
> +	 * it will "replace null VID with ingress port VID", which means
> +	 * VID set to 1: 0x8101 0001 for port 0 or 0x8102 0001 for port 1.
> +	 * So in the DSA driver we will set the default port VID to 0 so
> +	 * we can properly detect non-VLAN frames.
> +	 */
> +	if (!skb->vlan_tci) {

[Severity: Low]
This looks like a comment inaccuracy rather than a functional problem. The
comment describes preserving the tag only when the VID is "non-zero ... and
not identical to 0x001", but the code just tests !skb->vlan_tci, so there
is no VID == 1 exemption.

The code appears correct as written: the companion patch programs
ksz8_port_setup() with

	/* Use VID 0 to identify untagged frames in the special tag */
	ksz_pwrite16(dev, port, REG_PORT_CTRL_VID, 0);

so untagged ingress frames arrive with TCI 0 and the test catches them, and
a genuine VLAN 1 frame should not be treated as untagged. Could the comment
be reworded to match what the code does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8%40kernel.org
