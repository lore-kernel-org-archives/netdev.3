Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836573E9C18;
	Sun,  4 Oct 2026 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791085764; cv=none; b=AbuZBT7tghxMfIqjDki3eZui+9YP1HfLOo4b44J4R4TUOegQaMoKYx0AZfcIScels1qwWMQUrtoAREuzP+b1NeG+O3bioefIfoBsv/DlpeFydUgJWrz+pyz8LwrUaVahn8xH8WD3QufcB+W91OUFZ+gc4DDTUvMa5L5BHIGQlwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791085764; c=relaxed/simple;
	bh=UCTsqYO+Ehy1SIuVQFCwrpgMJFT4MqnJdrTY4LdKHlE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9TsiHjyRY019KWEqclioYQUXHt2+FCXLyObYvDPdgeo4cUYDCiem1/SjVoBWvWni2mY8YdNiZjts0tDcSfUQZ0zzEwDknZqLkYdGCysRmY7VK7MjIHbCxZHyKT1pNXPcbfiAfkaEg8yZkrtkGVlZE0iFVwibWHF99Eq26BQx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWsZTxRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWsZTxRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7524F1F0089B;
	Sun,  4 Oct 2026 03:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791085762;
	bh=UbfkJ6KY8SB3d1NUD1ZUcHps7cq9ey81ri0/lR2jRAw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mWsZTxRn5j2i9+3twDJDbhJmDA4YVEVE2YLdyKl25hbs70wN7iBV0jMRoUzX7VLic
	 lBJXIa0r2wQ7b3tl53OdBL2ooi1t97uV3jWc+BeJy92jtrxGRgHPNTpNizH2vdJ2Bw
	 R8bn2YwqI/pnGw7/H2NwKOvwkeriGLWIsC1R26RykFWuKNCUMxBto2m/MxGkPxPjtG
	 rv51plrO2klPCvWTj547q5f43u8OWSsOkP2IoF66AX+NmwOSNQH/iDL1LTw4xCPvFS
	 wN1Iqc97LNEnjX5olzqt0qRmB1ELHUiQZYx/Gy/RygBDwZhWmxtPRRRa5efBSAe+md
	 rrlXErW83L+Gw==
Subject: Re: [PATCH v2] net: dsa: push hwaccel VLAN tag into payload in
 dsa_user_xmit()
From: netdev-bot+sashiko@kernel.org
To: singh.amitesh@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Date: Sun, 04 Oct 2026 03:49:20 +0000
Message-ID: <179108576097.434549.17028077406245909874@kernel.org>
In-Reply-To: <20260930033239.57093-1-singh.amitesh@gmail.com>
References: <20260930033239.57093-1-singh.amitesh@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch materialises the hwaccel VLAN tag in
  dsa_user_xmit() (net/dsa/user.c:945-949) after…
- [Medium] dsa_user_xmit() now moves the hwaccel VLAN into skb->data
  after dsa_skb_tx_timestamp() has run (user.c:925 then 945-949).
- [Medium] The new free point in dsa_user_xmit() leaks the TX-timestamp
  clone.
- [Medium] The commit message says 'tag_rtl8_4 and tag_sja1105 both
  carried open-coded workarounds' and 'Remove the now-redundant per-…
- [Medium] The commit message and the new comment in dsa_user_xmit()
  (user.c:939-944) misdescribe the bug.
- [Low] The commit fixes a user-visible bug: the message calls the
  resulting on-wire VLAN/tag ordering 'broken' on conduits such as imx-…

--

net: dsa: push hwaccel VLAN tag into payload in dsa_user_xmit()

This commit calls __vlan_hwaccel_push_inside() in dsa_user_xmit(), so
any hwaccel VLAN tag is moved into the payload before the tagger's xmit
function runs. It also removes the per-tagger copy of that logic from
sja1105_pvid_tag_control_pkt() in tag_sja1105.c.

> When a socket buffer has a hardware-accelerated VLAN tag (skb->vlan_tci
> set), the conduit NIC inserts the 802.1Q header after whatever the DSA
> tagger prepends, producing the wrong on-wire ordering:
>
>   [tagger header][802.1Q VID]
>
> instead of the correct:
>
>   [802.1Q VID][tagger header]    (for taggers that follow the VLAN)
>   [tagger header][802.1Q VID]    (for taggers that precede the VLAN — broken)
>
> This affects any platform where tx-vlan-offload is enabled or fixed:on
> and cannot be disabled (e.g. imx-dwmac). tag_rtl8_4 and tag_sja1105
> both carried open-coded workarounds for this; rather than let each new
> tagger rediscover the problem, handle it once in dsa_user_xmit() before
> the skb is handed to any tagger.

[Severity: Medium]
Is this ordering diagram right? The "wrong" ordering and the "broken"
line under "instead of the correct:" are both [tagger header][802.1Q VID].

For etype taggers, the conduit inserts the VLAN at offset 12. That
actually gives DA SA [802.1Q][tagger].

The stated trigger also looks a bit off. Hardware tags reach
dsa_user_xmit() because the user netdev inherits
NETIF_F_HW_VLAN_CTAG_TX from the conduit at setup time, in
dsa_user_setup_tagger():

	user->features = conduit->vlan_features | NETIF_F_HW_TC;

Turning tx-vlan-offload off on the conduit later does not clear it from
the user port. In that case the conduit's validate_xmit_vlan() inserts
the tag in software, still after the tagger, so disabling offload is not
a workaround. The new comment in dsa_user_xmit() repeats this wording.

Is this later claim accurate?

  Note: tag_lan9303.c is unaffected.

lan9303_xmit() inserts its [8100 | port] header after the source MAC:

	/* provide 'LAN9303_TAG_LEN' bytes additional space */
	skb_push(skb, LAN9303_TAG_LEN);

	/* make room between MACs and Ether-Type */
	dsa_alloc_etype_header(skb, LAN9303_TAG_LEN);

Before this patch, the conduit added the user VLAN outside that header,
giving DA SA [8100 VID][8100 port]. With the VLAN pushed into the payload
first, the frame becomes DA SA [8100 port][8100 VID]. Doesn't that change
the on-wire output for LAN9303?

> __vlan_hwaccel_push_inside() frees the skb internally on allocation
> failure, so returning NETDEV_TX_OK on NULL is correct. Remove the
> now-redundant per-tagger copies from tag_rtl8_4.c and tag_sja1105.c.

[Severity: Medium]
The diff only touches net/dsa/tag_sja1105.c and net/dsa/user.c. Was
tag_rtl8_4.c meant to be part of this change?

In the tree this patch applies to, rtl8_4_tag_xmit() has no hwaccel VLAN
handling:

static struct sk_buff *rtl8_4_tag_xmit(struct sk_buff *skb,
				       struct net_device *dev)
{
	skb_push(skb, RTL8_4_TAG_LEN);

	dsa_alloc_etype_header(skb, RTL8_4_TAG_LEN);

	rtl8_4_write_tag(skb, dev, dsa_etype_header_pos_tx(skb));

	return skb;
}

In net/dsa, the only TX-side use of skb_vlan_tag_present() or
__vlan_hwaccel_push_inside() is in tag_sja1105.c. That makes the
statement "tag_rtl8_4 and tag_sja1105 both carried open-coded
workarounds" look wrong too.

Was this written against a different tree, or does it depend on an
rtl8_4 patch that isn't mentioned here?

[ ... ]

> Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>

[Severity: Low]
The commit message says the on-wire ordering is broken on conduits like
imx-dwmac. stmmac sets NETIF_F_HW_VLAN_CTAG_TX, copies it into
vlan_features, and DSA then inherits it for user ports. Since this is a
user-visible fix, should it carry a Fixes: tag, and possibly a stable Cc?

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef0..7c178634228c0 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c

[ ... ]

> @@ -935,6 +936,18 @@ static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (dev->needed_tailroom)
>  		eth_skb_pad(skb);
>  
> +	/* If the conduit NIC has tx-vlan-offload enabled (or it is fixed:on and
> +	 * cannot be turned off, e.g. imx-dwmac), it will insert the 802.1Q
> +	 * header *after* whatever the tagger prepends, producing the wrong
> +	 * on-wire ordering. Materialise any hwaccel VLAN tag into the payload
> +	 * here, once, before handing the skb to the tagger.
> +	 */
> +	if (skb_vlan_tag_present(skb)) {
> +		skb = __vlan_hwaccel_push_inside(skb);

[Severity: Critical]
Does this use up headroom that was reserved for the tagger? Earlier in
dsa_user_xmit(), headroom is sized only for the tagger:

	if (skb_ensure_writable_head_tail(skb, dev)) {
		dev_kfree_skb_any(skb);
		return NETDEV_TX_OK;
	}

skb_ensure_writable_head_tail() grows the head only by the shortfall
against dev->needed_headroom:

	needed_headroom = max_t(int, needed_headroom - skb_headroom(skb), 0);

dev->needed_headroom is tag_ops->needed_headroom plus
conduit->needed_headroom. stmmac sets no needed_headroom, so this is
just the tag length.

__vlan_insert_inner_tag() then checks for VLAN_HLEN of its own headroom
only, and pushes:

	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
		return -ENOMEM;

	skb_push(skb, VLAN_HLEN);

That leaves TAG_LEN - 4 bytes of headroom for the tagger. Taggers such
as rtl8_4_tag_xmit(), brcm_tag_xmit_ll() and lan9303_xmit() call
skb_push() without checking and rely on the DSA headroom guarantee:

	skb_push(skb, RTL8_4_TAG_LEN);

No tagger in net/dsa calls skb_cow_head(), and
Documentation/networking/dsa/dsa.rst says taggers don't need to check
headroom.

Wouldn't that push move skb->data below skb->head and end in
skb_under_panic()?

This can happen when the user port has inherited NETIF_F_HW_VLAN_CTAG_TX
from conduit->vlan_features, as with stmmac with vlins, which is the
setup this patch targets. Any hwaccel-tagged skb that arrives with less
than needed_headroom + VLAN_HLEN of headroom would be affected.

One example: UDP sent from a netns over veth, which leaves about 2 bytes
of headroom before the Ethernet header. A VLAN-aware bridge tags it with
the PVID via __vlan_hwaccel_put_tag(), and br_dev_queue_push_xmit()
forwards it to a DSA user port. Skbs whose headroom is between TAG_LEN
and TAG_LEN + 3 would hit it as well.

The removed sja1105 copy avoided this only because
sja1105_pvid_tag_control_pkt() goes on to call vlan_insert_tag(), which
reallocates as needed.

Could the push be done before skb_ensure_writable_head_tail(), for
example at the top of dsa_user_xmit(), or could an extra VLAN_HLEN be
reserved?

> +		if (!skb)
> +			return NETDEV_TX_OK;

[Severity: Medium]
Can this error path leak the TX timestamp clone? dsa_skb_tx_timestamp()
has already run at this point. Both sja1105_port_txtstamp() and
ksz_port_txtstamp() keep the only pointer to an skb_clone_sk() clone in
the original skb's cb:

	SJA1105_SKB_CB(skb)->clone = clone;

	KSZ_SKB_CB(skb)->clone = clone;

When __vlan_hwaccel_push_inside() fails, the original skb is freed and
NETDEV_TX_OK is returned, but nothing releases the clone. The clone
holds a socket reference that is only dropped through sock_efree, so the
socket would never be freed.

The commit message says "returning NETDEV_TX_OK on NULL is correct", but
that only covers the original skb.

This looks reachable with KSZ, a tail tagger with needed_headroom 0
behind stmmac. A PTP frame from a VLAN upper can arrive with about 2
bytes of headroom. skb_cow_head(skb, 4) then calls
pskb_expand_head(..., GFP_ATOMIC), and that allocation can fail. KSZ had
no such failure point before; sja1105 already had the same leak inside
its tagger.

The skb_ensure_writable_head_tail() error path just above leaks the
clone the same way, but that one predates this patch. Would doing the
VLAN push before dsa_skb_tx_timestamp() avoid adding another instance?

> +	}
> +
>  	/* Transmit function may have to reallocate the original SKB,
>  	 * in which case it must have freed it. Taggers will drop the
>  	 * passed skb on error.

[Severity: Medium]
Does moving the tag into the payload here invalidate the PTP class that
dsa_skb_tx_timestamp() computed earlier in this function?

ksz_port_txtstamp() classifies the frame with ptp_classify_raw(), which
reads skb->data. At that point the tag is still in the skb metadata,
not in the frame, so the class has no PTP_CLASS_VLAN bit. For one-step
P2P Pdelay_Resp the class is saved for the tagger:

	KSZ_SKB_CB(skb)->ptp_type = type;

After the 802.1Q header has been pushed into the payload,
ksz_xmit_timestamp() in net/dsa/tag_ksz.c parses the frame again with
the saved class:

	ptp_hdr = ptp_parse_header(skb, ptp_type);

ptp_parse_header() skips the VLAN header only when the class says to:

	if (type & PTP_CLASS_VLAN)
		ptr += VLAN_HLEN;

For L2 PTP, the parsed header ends up 4 bytes early. For IPv4, the IHL
is read from the TCI byte.

The tagger then reads the wrong correctionField. If that value looks
negative, it computes the wrong tstamp_raw for the tail tag, zeroes the
wrong 8 bytes, and patches the wrong UDP checksum via
ptp_header_update_correction(). Otherwise it sends a tstamp of 0 and
leaves the real negative correction in place.

Before this patch the conduit inserted the VLAN after the KSZ tail
tagger ran, and the resulting frame was consistent. Could
KSZ9477/KSZ8563/LAN937x switches behind an stmmac conduit with vlins now
send bad Pdelay_Resp frames when ptp4l runs one-step P2P on a VLAN upper
of the user port?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930033239.57093-1-singh.amitesh%40gmail.com
