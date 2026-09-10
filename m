Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A23CF1E4;
	Thu, 10 Sep 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070523; cv=none; b=pNs05S6y7ny79pvwquvNWZq/8E9FYUcVvdkDR4andnLp4gfFXGbU3gp98YXr6LNSgBmflVghCXrf26JDMQcbOd9zkLfqxldn0nUlMt/pRHwd5lAPP34rj1RQs6dtyxThhdKV7FTro9gCdInVm/cR31S4Gr89kwN37UaYO/jaT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070523; c=relaxed/simple;
	bh=8JgRUs40jSQ6fvXUl8i2C7nFHXsBdw6n2quPiRsw02U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1H00hztdRS/n9d6F3L2/r10pQAN/seT8KDpj+XYhBD4RFzcG6Rbgl6BeWfuHXMyOfTQUOvjyeBEZ0pSP/6ue6Vulw3b655OpH/6GvkahGxs7AdxlkWt2Y+koRSgrP/GgE1R2K9lU3opTxjzyerTrnMUEE9AxUnAKqkG2wLQ73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBv5d1zx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBv5d1zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579001F00893;
	Thu, 10 Sep 2026 20:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070521;
	bh=tXprCCZtyGuwacxGJqND9AhV6cp67VM7Oc6tM+JCiRk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MBv5d1zxgnsbQetc/+YEjRQTBTfN1D/mVphlhS3E4hFfZ9ie1YdoRpP9Mf2hFL3Av
	 UYPJR5HKHHz5G75xn20bQIqJOrrR/ZEEcRAieRlNLxkp56YZ4uj7FaSOqwSdgYkhEw
	 fN0kQ672AuXEWA20xyqjQA9fu047kqYpBhu0EjYBBnqkv4thvMLRAiQtKkp/JRh15W
	 SSJtbse/6wy0xAPEcMnToNm9hzi1lF0PA1gdVWSFNAMaaSqTzyt9Lqi5DVUh7xsf2X
	 UsXcO0A8LjoUk7VxtIKxkgvosFJLHj0X+3JV/dHrdqMW8RoGjPV/R/QecQRWYto+n0
	 7S4BVu6vRVqyw==
Subject: Re: [PATCH net-next v11 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 20:01:59 +0000
Message-ID: <178907051987.219967.4473290802411391246@kernel.org>
In-Reply-To: <20260909-ks8995-to-ksz8-v11-2-0e04411a559d@kernel.org>
References: <20260909-ks8995-to-ksz8-v11-2-0e04411a559d@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] ks8995_rcv() in net/dsa/tag_ks8995.c treats any non-NULL
  return from skb_vlan_untag() as proof that the 4-byte KS8995 switch…

--

net: dsa: tag_ks8995: Add the KS8995 tag handling

This adds a new DSA tagger for the Micrel KS8995 / Microchip KSZ8995XA
switch, which carries its per-port tag in a modified 802.1Q header where
the low nybble of the 0x8100 TPID holds the port mask.  The xmit path
pushes any hardware-accelerated VLAN tag inside the frame and then
inserts the special tag at offset 12, and the rcv path parses the port
from the mangled TPID and moves the tag into the hwaccel area.

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 000000000000..f6ef1ef1891f
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,145 @@

[ ... ]

> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int portmask;
> +	int port;
> +	u16 etype;
> +
> +	/* We are expecting all received packets to have a mangled VLAN
> +	 * TPID, so drop anything else. Because of the non-standard TPID,
> +	 * don't even bother looking for a tag in the hwaccel area.
> +	 *
> +	 * We have to inspect the ethertype directly because skb->protocol
> +	 * will contain garbage.
> +	 */
> +	etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
> +	if ((etype & KS8995M_STPID_STD) != ETH_P_8021Q) {
> +		netdev_dbg(dev, "%s: dropped ethertype 0x%04x\n",
> +			   __func__, etype);
> +		kfree_skb(skb);
> +		return NULL;
> +	}

[ ... ]

> +	/* Move the custom DSA+VLAN tag into the hwaccel area and strip
> +	 * it from the skb head
> +	 */
> +	skb = skb_vlan_untag(skb);
> +	if (!skb) {
> +		/* skb_vlan_untag drops the skb on failure */
> +		if (net_ratelimit())
> +			netdev_err(dev, "%s: unable to untag skb\n", __func__);
> +		return NULL;
> +	}

[Severity: Medium]
Is a non-NULL return from skb_vlan_untag() enough to conclude that the
4-byte switch tag was actually removed from the frame head?

net/core/skbuff.c:skb_vlan_untag() starts with:

	if (unlikely(skb_vlan_tag_present(skb))) {
		/* vlan_tci is already set-up so leave this for another time */
		return skb;
	}

On that path the same pointer comes back untouched: no pskb_may_pull(),
no skb_pull_rcsum(skb, VLAN_HLEN), no skb_reorder_vlan_header() and no
mac_header adjustment.

Can ks8995_rcv() be entered with skb_vlan_tag_present(skb) already true?
net/core/dev.c:__netif_receive_skb_core() deliberately keeps the tag for
DSA conduits:

	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {

and net/dsa/tag.c:dsa_switch_rcv() does not clear it either before
calling cpu_dp->rcv().

If that happens, does the frame handed to the user port end up 4 bytes
too long with the STPID still embedded?  After the tagger returns,
dsa_switch_rcv() does:

	skb_push(skb, ETH_HLEN);
	skb->pkt_type = PACKET_HOST;
	skb->protocol = eth_type_trans(skb, skb->dev);

so eth_type_trans() would re-read the still-present 0x810X at offset 12
as the frame ethertype, and the network/transport offsets would point
into the tag.

Would the DSA idiom used elsewhere in the tree work here, i.e. guard the
call and re-test afterwards the way net/dsa/tag.h:dsa_software_vlan_untag()
does?

	if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
		skb = skb_vlan_untag(skb);
		if (!skb)
			return NULL;
	}

	if (!skb_vlan_tag_present(skb))
		return skb;

tag_lan9303.c and tag_8021q.c also handle the "tag is already in the
hwaccel area" case explicitly.

> +	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
> +		   __func__, etype, portmask, port);
> +	skb->dev = dsa_conduit_find_user(dev, 0, port);
> +	if (!skb->dev) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	/* skb_vlan_untag() moved the special tag's TCI into the hardware-
> +	 * accelerated VLAN metadata. The switch preserves the TCI of tagged
> +	 * frames, but inserts the ingress port's default tag for untagged frames.
> +	 * Since the driver programs the default tag to 0, a zero TCI identifies
> +	 * an originally untagged frame. Preserve every non-zero TCI as an
> +	 * 802.1Q tag, including VID 0 frames with PCP or DEI set.
> +	 */
> +	if (!skb->vlan_tci) {
> +		netdev_dbg(dev, "%s: clear VLAN tag from frame\n", __func__);
> +		__vlan_hwaccel_clear_tag(skb);
> +	} else {
> +		skb->vlan_proto = htons(ETH_P_8021Q);
> +		netdev_dbg(dev, "%s: vlan_tci = 0x%04x VLAN frame\n",
> +			   __func__, skb->vlan_tci);
> +	}

On the early-return path described above, does this decision act on the
wrong TCI?  The comment assumes skb->vlan_tci came from the special tag,
but if the tag was already in the hwaccel area on entry the TCI is the
conduit-supplied one.

A zero conduit TCI (for example a priority-tagged VID 0 frame) would be
dropped by __vlan_hwaccel_clear_tag(), and a non-zero one gets
relabelled with skb->vlan_proto = htons(ETH_P_8021Q) even if it arrived
as 802.1ad.

For what it is worth, I could confirm the no-op behaviour of
skb_vlan_untag() and that the core stack keeps hwaccel tags alive for
DSA conduits, but I could not demonstrate a plain single-switch setup
that reaches ks8995_rcv() with both a hwaccel tag present and 0x810X
still at offset 12; a normal CTAG-offload NIC will not match TPIDs
0x8101..0x8108.  Cascaded DSA topologies and software injection into the
conduit receive path look like the candidate paths.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-ks8995-to-ksz8-v11-0-0e04411a559d%40kernel.org
