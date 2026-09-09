Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C855D86C;
	Wed,  9 Sep 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957561; cv=none; b=Item2pmKBm6hQSnuT7ymJGcP6ifjGN7QmLuaTv8jos7ZdZRKfrisVPKUo5pSj+RXbMbFrLmCXxYnbP+NIDbf6RhaxTcPP5GU1Xg5/A511YzZ+Tjm1KeFPgOt/KrNIvN7Wugh7qpKazXnixye7idfXX4oQaJacTz6ZuUsriZssAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957561; c=relaxed/simple;
	bh=F+0c4DfWkSMca3SSGGKGBVpU03nblL4EE3WZrQECnfQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkSOgkff9qz6uAJdCZM4Zs/cXkK8PvnOF9C7eRhynECoQ4cvcJOkxWeiLEWVFFi/W5ukrdm7LEwIy1Lp13Yhbv2BZ1AmYxfrBBQSltFrXUQAT8l4yzayNvCFPpqqvXf7JuM8ggIoFaK4is3iX0iW4S1Jl/pGmK43VIovBExCPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ZSnUTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ZSnUTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFB1F00A3A;
	Wed,  9 Sep 2026 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957559;
	bh=iwUbfjJxrDVzRtoMz/Y6TF+Zu4oaizDAA4xU0mOsINk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b8ZSnUTnw5aeVSLNELNv1Yo63Q0tc4WUvl+14kQVU+0e/WS8TwClmnYe1mmQPstQ+
	 0woI3qZld/BanzJIrc0mOexC6UacKrgIXptWNN9M0vabkc2sXYOZkq8ffedCjPuMW7
	 OuIUyCELTPmjfXUBlLtIWwzOtQp3zpCEtISqUQx+Rco+xZkQM12FACzuJ8fkR2rqpM
	 O+mz0iLL0QO4RPvs5/8AjBYxCa8NUOUg+ZnDZl7zdF3i+WG9oj8ISDx6YGDwIgUkWH
	 Z0zKkpqTiezvoto0g0JuLsMwFcfXX9E/JR8lcf2ID6/WLAXQ9v+A2qBozsZEBKggoB
	 VRY6K0XaGYkLA==
Subject: Re: [PATCH net-next v10 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 12:39:18 +0000
Message-ID: <178895755845.219967.12211092726566483619@kernel.org>
In-Reply-To: <20260908-ks8995-to-ksz8-v10-2-7379239eb65f@kernel.org>
References: <20260908-ks8995-to-ksz8-v10-2-7379239eb65f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] ks8995_rcv() (net/dsa/tag_ks8995.c:109) decides that an ingress
  frame was originally untagged purely from the special tag's TCI being…
- [Low] ks8995_rcv() validates only the upper 12 bits of the received
  STPID ((etype & GENMASK(15,4)) != ETH_P_8021Q,…

--

net: dsa: tag_ks8995: Add the KS8995 tag handling

Adds a DSA tagger for the Micrel/Microchip KS8995 family, where the
switch tag is a modified 0x8100 ethertype carrying a per-port bitmask in
the low nybble. On transmit any hwaccel VLAN tag is pushed inside and a
distinct outer tag is inserted; on receive the tag is moved into the
hwaccel area and the user port is derived from the port mask.

Two questions about the receive path below.

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 0000000000000..9f6fdc1a9a076
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,135 @@

[ ... ]

> +#define KS8995_NAME "ks8995"
> +
> +#define KS8995M_STPID_STD	GENMASK(15, 4)
> +#define KS8995M_STPID_PORTMASK	GENMASK(3, 0)
> +#define KS8995M_STPID(portmask)	htons(ETH_P_8021Q | FIELD_PREP(KS8995M_STPID_PORTMASK, portmask))

[ ... snipped ks8995_xmit(), unrelated to the comments below ... ]

> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int portmask;
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

[ ... ]

> +	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, etype);
> +	netdev_dbg(dev, "%s: etype %04x portmask %04x (%d)\n",
> +		   __func__, etype, portmask, ilog2(portmask));
> +	skb->dev = dsa_conduit_find_user(dev, 0, ilog2(portmask));
> +	if (!skb->dev) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}

[Severity: Low]
The guard in ks8995_rcv() only checks the upper twelve bits, so every
STPID from 0x8100 to 0x810F is accepted, including a zero mask and masks
with more than one bit set.

Would it be worth rejecting those explicitly rather than relying on
ilog2() behaviour?  For etype 0x8100 the mask is 0 and ilog2(0) expands
to __ilog2_u32(0), i.e. fls(0) - 1 == -1, which then reaches
dsa_conduit_find_user():

net/dsa/tag.h:dsa_conduit_find_user() {
	list_for_each_entry(dp, &dst->ports, list)
		if (dp->ds->index == device && dp->index == port &&
		    dp->type == DSA_PORT_TYPE_USER)
			return dp->user;

	return NULL;
}

dp->index is unsigned int, so the int -1 promotes and never matches, and
the frame is freed via the kfree_skb() above.  That looks safe, but a
mask with several bits set is silently attributed to the highest set bit,
i.e. the wrong user port.

The documented encoding is one-hot ("The tag is: 0x8100 |= BIT(port),
ports 0,1,2,3") and the low nybble is generated by the switch rather than
by a peer, so no untrusted path to those values was found.  Should an
explicit hweight()/zero-mask rejection plus the existing rate-limited log
be added anyway, so a misprogrammed switch is diagnosed instead of
delivering frames to an arbitrary port?

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

[Severity: Low]
Is the "zero TCI means the frame arrived untagged" rule fully accurate
for a frame that really was tagged with TCI 0x0000?

A priority-tagged frame with VID 0, PCP 0 and DEI 0 produces the same
metadata as an untagged frame, so this branch strips it.

The precondition in the comment does hold for the rest of the series:
ksz8_port_setup() in drivers/net/dsa/microchip/ksz8.c writes

	/* Use VID 0 to identify untagged frames in the special tag */
	ksz_pwrite16(dev, port, REG_PORT_CTRL_VID, 0);

and ksz8995xa_switch_ops implements neither .port_vlan_filtering nor
.port_vlan_add, so dsa_port_vlan_filtering() returns -EOPNOTSUPP and
ksz8_port_vlan_add() (the only writer of a non-zero REG_PORT_CTRL_VID)
is never reached.  The default tag therefore stays 0 for the lifetime of
the device.

That leaves only the hardware-inherent case above, where the tag carries
no information beyond an untagged frame and the switch offers no other
signal.  Would it be useful to note that limitation in the comment so the
next reader does not have to re-derive it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ks8995-to-ksz8-v10-0-7379239eb65f%40kernel.org
