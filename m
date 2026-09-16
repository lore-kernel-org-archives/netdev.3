Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19817550DA0;
	Wed, 16 Sep 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576220; cv=none; b=KeL4NJp4Ax76zj50Bw7UfiNHBOBFpLOX4vwfu1w/jWeUIOctJ0tD4dpEJ4+WoVEGlni3slVjd2uSkwStQ/1RJV7xIouiWE6Zl5K+A9NBuLfcEAaArdJUSSMz6mY4tXXneLHhckW8La8rck9qOvULeWq7Hkl9AEX1kXmehcGYi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576220; c=relaxed/simple;
	bh=AcY9JKkkaHSCkDkYBPaxWpwqeP+wKot6FOTHzcBq7Sw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uux6X3mNSs1HRrhijSkjstwybqTWTusNvUV4lWXQbAxZXoxTTagJxAbNaX5Iy+qhA9LtRdrQmgo1dIrDqkLit7ai29GfMm0jRkiJ74xR9ajLjx1JWfeazJFsbfX15TM08EExPVBfhZxVM/Z0YHHInc5D3coexDKuVKnRHI5hBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQ0psbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQ0psbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F9D1F00899;
	Wed, 16 Sep 2026 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576216;
	bh=os0/Wgyf6MdE0fy7UCdlOUZG6s2Q2iH7irUfC9Ryd/A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WIQ0psbP2AN7NiY37TUolMtu/qJ8dp3M1YJ+uZrz4Nfx8Ydn17+h898RAYW2pGggF
	 +i/cEVBu8/aEbwdrKik8u2/GZFEGJ0JsRTRRhl7rFolLcRZ6pq1RRP9qtMVL4IiQvK
	 pun9TxmAJi18EN/fgRT3azNGV1LqWjlO8d/kpZf9CKT77xLh0tZS7s65tS74UlkZrM
	 vndJIrNXAMyO2z0P/dqI3f1NQXE03W7mpbnu3MFM6UVa0DTUbzlu33WIUipZCKxfwU
	 H0Cb/7gh4Y+ZTtQuY3zRUM7xZsEF7cYWiPaDTAYUhpkgk9FZyvjDrjoyNbzJWN1AUG
	 KkYwx9xcZU/bw==
Subject: Re: [PATCH net-next v7 5/6] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 16 Sep 2026 16:30:15 +0000
Message-ID: <178957621503.22033.11339961228800379392@kernel.org>
In-Reply-To: <20260914103009.3007019-6-kyle.switch@motor-comm.com>
References: <20260914103009.3007019-6-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 4

- [Low] Claim: the new DSA tag protocol DSA_TAG_PROTO_YT922X /
  CONFIG_NET_DSA_TAG_YT922X has no consumer in the tree (dead code).
- [Low] The YT922x tag layout is effectively undocumented:
  net/dsa/tag_yt922x.c:15-17 contains only the placeholder comment "/*…
- [Low] The RX priority field declared by the new tag format is never
  decoded.
- [Low] The new tagger emits and validates the uAPI constant ETH_P_YT921X
  for a YT922x tag: net/dsa/tag_yt922x.c:40 (`tag[0] =…

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

This adds a new DSA tagging driver for Motorcomm YT922x switches with an
8-byte tag preceded by an EtherType of 0x9988, plus the new
DSA_TAG_PROTO_YT922X protocol value, Kconfig symbol and Makefile entry.

A few questions below.

> diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
> new file mode 100644
> index 0000000000000..1ee9d17735988
> --- /dev/null
> +++ b/net/dsa/tag_yt922x.c
> @@ -0,0 +1,111 @@

[ ... ]

> +#define YT922X_TAG_LEN	8
> +
> +/*
> + * To define the from cpu tag format 8 bytes:
> + */

[Severity: Low]
This isn't a bug, but could the tag layout be documented here?  The
comment above currently describes none of the fields, while the sibling
tagger for the same vendor, net/dsa/tag_yt921x.c, carries a full frame
diagram and a per-bit description of every 16-bit tag word:

net/dsa/tag_yt921x.c:
 * +----+----+-------+-----+----+---------
 * | DA | SA | TagET | Tag | ET | Payload ...
 * +----+----+-------+-----+----+---------
 *   6    6      2      6    2       N
 ...
 *   2:
 *     15b: Tx Port(s) Valid
 *     10b-0b: Tx Port(s) Mask

Without that, the reuse of tag[2] in opposite directions (transmit writes
YT922X_TAG_PORTMASK_0 = BIT(15), receive reads YT922X_TAG_RX_PORT_M =
GENMASK(5, 2)) and the split of the destination port mask across tag[1]
bits 8:0 and tag[2] bit 15 cannot be checked against the hardware by a
reviewer.

> +#define YT922X_TAG_NAME		"yt922x"
> +#define YT922X_TAG_PORTMASK_0	BIT(15)
> +#define YT922X_TAG_PORTMASK_M	GENMASK(8, 0)
> +#define  YT922X_TAG_PORTS(x)		FIELD_PREP(YT922X_TAG_PORTMASK_M, (x))
> +#define YT922X_TAG_FORCE_DST	BIT(9)
> +#define YT922X_TAG_PRIO_M	GENMASK(12, 10)
> +#define YT922X_TAG_PRIO_EN	BIT(13)
> +#define  YT922X_TAG_PRIO(x)		(FIELD_PREP(YT922X_TAG_PRIO_M, (x)) | YT922X_TAG_PRIO_EN)
> +#define YT922X_TAG_RX_PORT_M	GENMASK(5, 2)
> +#define YT922X_TAG_RX_PRIO_M	GENMASK(15, 13)
                                         ^^^^

[Severity: Low]
Is YT922X_TAG_RX_PRIO_M meant to be used?  It is defined here but never
referenced anywhere in the file, and yt922x_tag_rcv() only extracts the
source port from tag[2] and never assigns skb->priority, so the ingress
priority reported by the switch is dropped.

The transmit path does encode skb->priority into the tag:

	ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
	       YT922X_TAG_PORTS(ports >> 1);

and comparable taggers decode it on receive, for example
net/dsa/tag_yt921x.c:yt921x_tag_rcv():

	skb->priority = FIELD_GET(YT921X_TAG_PRIO_M, rx);

Should yt922x_tag_rcv() do the same with YT922X_TAG_RX_PRIO_M?

> +
> +static struct sk_buff *
> +yt922x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{

[ ... ]

> +	tag[0] = htons(ETH_P_YT921X);

[Severity: Low]
This isn't a bug, but the YT922x tagger emits and validates a uAPI
constant named for YT921x, both here and in yt922x_tag_rcv():

	if (unlikely(tag[0] != htons(ETH_P_YT921X))) {

include/uapi/linux/if_ether.h currently scopes that value to one family:

#define ETH_P_YT921X	0x9988		/* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */

Should the header comment be broadened (something like "Motorcomm YT92xx
DSA") or a YT922x alias added, so the uAPI still describes all in-tree
users of 0x9988?  It would also help if the commit message stated that the
two chip families intentionally share the tag EtherType while using
different tag bodies.

> +	ports = dsa_xmit_port_mask(skb, netdev);
> +	/*To fill in the case where the port index is not 0 */

[ ... ]

> +static const struct dsa_device_ops yt922x_netdev_ops = {
> +	.name = YT922X_TAG_NAME,
> +	.proto = DSA_TAG_PROTO_YT922X,

[Severity: Low]
This isn't a bug, but could the commit message mention the companion
patch that consumes this protocol?

At this commit nothing requests DSA_TAG_PROTO_YT922X, and the consumer
only appears in the last patch of the series, "net: dsa: motorcomm: Add
support for Motorcomm YT922x", which adds
yt922x_dsa_get_tag_protocol() returning DSA_TAG_PROTO_YT922X and adds
select NET_DSA_TAG_YT922X to drivers/net/dsa/motorcomm/Kconfig.

So there is no dead code in the merged series, and the ordering is the
usual DSA practice; a note in the commit message pointing at the driver
patch would make that clear on its own.

> +	.xmit = yt922x_tag_xmit,
> +	.rcv = yt922x_tag_rcv,
> +	.needed_headroom = YT922X_TAG_LEN,
> +};

Also, in the commit message, "Add support for Motorcomm YT922x tags with
8bytes. which includes ethertype field (default to 0x9988)." reads a bit
oddly: "8bytes" is missing a space, and the sentence break before "which"
should probably be a comma.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914103009.3007019-1-kyle.switch%40motor-comm.com
