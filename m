Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E792D7386;
	Mon, 12 Oct 2026 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774117; cv=none; b=V7pAxmZ2ES9+BAeHmzg/cTBL2LGxKGujC3yAvdbgqULDg8eGy1A+i+wpj+LkVfbx3y+NM73HYXOuvtdBTQC5X2OxXZ9bTFKLZHZxKq/cYQ4dApu77DKlWenya11HCinvzI7vJxZYbhRNMR6y7FdoNAx9WqMituB5vnLdhj4zmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774117; c=relaxed/simple;
	bh=UJQtM+/i1LAUppb8Mxkn4r/+A3tf5lYD69oVzmH65SM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EisiRvp1UfsroNpMqOWnVVAEa+wTulfpuzBFeWdrvsXZMWFV0I7K3PdgQpUpBa8//kneo7IKl8pUnj1DAZCrthHvNB3q3kzxzZTAKRCrBxp/P83Yb16bWyIKElzlGgIMRH9kfM52mhDLhpeDfsPHoBMUYImj0ts0njjdyrf9Dx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo7+zLqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo7+zLqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F0C1F0089B;
	Mon, 12 Oct 2026 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791774116;
	bh=tg+1GwNNBZy6dknZYjJF+O5KokYBtZJwelY5TA/Z0g8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fo7+zLqLUOVYfvO82sbiQgVfqcIRYVLyVupNzSWHIDcE/QFVmiwtlkddz8bS1+8He
	 knmANhABqins+dtJkkr0s+BwGbInaOfCqtBZZbT4pGbXXr9A8CS3LJCO4LQx9Q6DC8
	 VPOUbt3m0IEKP5e52/VqJejuadLhm08czHVi23C5VEj1cIh3Hee2GLq66+ZNnoYfFC
	 Hk47bFCjANMClvdSFJID/5RCHQnSoP1jT4ndd6SsEvpFy1hLfvXrMVRI4+79APpRBb
	 cF+J3RoWWp9falEZetfBmrevonLW733zzue8dmd1JgjE1+p+rIE/xJWvRiulhmQyAa
	 IDNJiJ8Q3vUVg==
Subject: Re: [PATCH net-next v13 4/5] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 12 Oct 2026 03:01:54 +0000
Message-ID: <179177411468.434549.15575348445762239111@kernel.org>
In-Reply-To: <20261011025043.1859940-5-kyle.switch@motor-comm.com>
References: <20261011025043.1859940-5-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern: yt922x_tag_rcv() never calls
  dsa_default_offload_fwd_mark(), so frames the hardware already…
- [Low] net: dsa: tag_yt922x: Incomplete TX tag format documentation

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

This adds a new DSA tag driver for Motorcomm YT922x switches. They use the
same EtherType and 8-byte tag length as YT921x, but with a different tag
layout. The patch also adds a co-maintainer for the Motorcomm DSA driver.

> diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
> new file mode 100644
> index 0000000000000..b6146a9af98b3
> --- /dev/null
> +++ b/net/dsa/tag_yt922x.c
> @@ -0,0 +1,122 @@

[ ... ]

> +static struct sk_buff *
> +yt922x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{

[ ... ]

> +	/* Locate which port this is coming from */
> +	rx = ntohs(tag[2]);
> +	port = FIELD_GET(YT922X_TAG_RX_PORT_M, rx);
> +	skb->dev = dsa_conduit_find_user(netdev, 0, port);
> +	if (unlikely(!skb->dev)) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Couldn't decode source port %u\n", port);
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	/* Remove tag and update checksum */
> +	skb_pull_rcsum(skb, YT922X_TAG_LEN);
> +	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
> +
> +	return skb;
> +}

[Severity: Low]
This isn't a bug right now, but yt922x_tag_rcv() never sets
skb->offload_fwd_mark, for example with dsa_default_offload_fwd_mark().

That is fine with the rest of this series. In
drivers/net/dsa/motorcomm/chip.c, yt922x_dsa_switch_ops has no
.port_bridge_join, so YT922x ports are only bridged in software.

yt922x_port_setup() also keeps user ports isolated from each other:

	ctrl = ~priv->cpu_ports_mask;
	res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port), ctrl);

So the hardware never forwards frames between user ports, and leaving
offload_fwd_mark at 0 is correct. Setting it today would make the bridge
drop frames that it should forward in software.

If bridge offload is added for YT922x later, would the tagger then need to
read a forward/trap reason field from the to-CPU tag and mark frames that
the hardware already forwarded? Without that, the software bridge could
forward flooded frames a second time.

[ ... ]

> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Motorcomm YT922x Switch Extended CPU Port Tagging
> + *
> + * Copyright (c) 2026 Kyle switch <kyle.switch@motor-comm.com>
> + *
> + */
> +
> +#include <linux/etherdevice.h>
> +
> +#include "tag.h"
> +
> +#define YT922X_TAG_LEN 8
> +
> +/*
> + * To define the from cpu tag format 8 bytes.
> + *
> + * To-CPU (RX) tag format, 8 bytes:
> + *
> + *   tag[0]: TPID (default: 0x9988)
> + *   tag[1]: VID lookup
> + *   tag[2]: bit 5:2  - RX source port
> + *
> + * From-CPU (TX) tag format, 8 bytes:
> + *
> + *   tag[0]: TPID (default: 0x9988)
> + *   tag[1]: bit 8:0 - Dst port mask
> + *   tag[2]: bit 15  - Dst port 0
> + *
> + */
> +#define YT922X_TAG_NAME		"yt922x"
> +#define YT922X_TAG_PORTMASK_0	BIT(15)
> +#define YT922X_TAG_PORTMASK_M	GENMASK(8, 0)
> +#define  YT922X_TAG_PORTS(x)		FIELD_PREP(YT922X_TAG_PORTMASK_M, (x))
> +#define YT922X_TAG_FORCE_DST	BIT(9)
> +#define YT922X_TAG_PRIO_M	GENMASK(12, 10)
> +#define YT922X_TAG_PRIO_EN	BIT(13)
> +#define  YT922X_TAG_PRIO(x)	(FIELD_PREP(YT922X_TAG_PRIO_M, (x)) | YT922X_TAG_PRIO_EN)
> +#define YT922X_TAG_RX_PORT_M	GENMASK(5, 2)
> +
> +static struct sk_buff *
> +yt922x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	unsigned long ports;
> +	__be16 *tag;
> +	u16 ctrl;
> +
> +	skb_push(skb, YT922X_TAG_LEN);
> +	dsa_alloc_etype_header(skb, YT922X_TAG_LEN);
> +	tag = dsa_etype_header_pos_tx(skb);
> +
> +	tag[0] = htons(ETH_P_YT921X);
> +	ports = dsa_xmit_port_mask(skb, netdev);
> +	/*To fill in the case where the port index is not 0 */
> +	ctrl = YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORCE_DST |
> +	       YT922X_TAG_PORTS(ports >> 1);
> +	tag[1] = htons(ctrl);
> +	if (ports & BIT(0)) {
> +		/* To fill in the case where the port index is 0 */
> +		ctrl = YT922X_TAG_PORTMASK_0;
> +		tag[2] = htons(ctrl);
> +	} else {
> +		tag[2] = 0;
> +	}
> +	tag[3] = 0;
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *
> +yt922x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	unsigned int port;
> +	__be16 *tag;
> +	u16 rx;
> +
> +	if (unlikely(!pskb_may_pull(skb, YT922X_TAG_LEN))) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	tag = dsa_etype_header_pos_rx(skb);
> +
> +	if (unlikely(tag[0] != htons(ETH_P_YT921X))) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Unexpected EtherType 0x%04x\n",
> +				     ntohs(tag[0]));
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	/* Locate which port this is coming from */
> +	rx = ntohs(tag[2]);
> +	port = FIELD_GET(YT922X_TAG_RX_PORT_M, rx);
> +	skb->dev = dsa_conduit_find_user(netdev, 0, port);
> +	if (unlikely(!skb->dev)) {
> +		dev_warn_ratelimited(&netdev->dev,
> +				     "Couldn't decode source port %u\n", port);
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	/* Remove tag and update checksum */
> +	skb_pull_rcsum(skb, YT922X_TAG_LEN);
> +	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops yt922x_netdev_ops = {
> +	.name = YT922X_TAG_NAME,
> +	.proto = DSA_TAG_PROTO_YT922X,
> +	.xmit = yt922x_tag_xmit,
> +	.rcv = yt922x_tag_rcv,
> +	.needed_headroom = YT922X_TAG_LEN,
> +};
> +
> +MODULE_DESCRIPTION("DSA tag driver for Motorcomm YT922x switches");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_YT922X, YT922X_TAG_NAME);
> +
> +module_dsa_tag_driver(yt922x_netdev_ops);

[Severity: Low]
The From-CPU layout comment says tag[1] holds only the destination
port mask in bits 8:0. But yt922x_tag_xmit() puts more than that into
the same ctrl word: YT922X_TAG_FORCE_DST in bit 9, and
YT922X_TAG_PRIO(skb->priority), which is the priority in bits 12:10
plus the enable bit 13. None of those fields are described. tag[3] is
not mentioned either, even though it is always written as zero.

The commit message says the new driver documents both tag layouts, and
this comment is the only description of the YT922x format in the tree.
Could you complete it?

It would also help to say that, as the code is written, bits 8:0 of
tag[1] carry ports 1-9, because the mask is passed as ports >> 1.
Port 0 instead goes into bit 15 of tag[2]. The current wording reads
as if bit n of tag[1] were port n.

There is also a leftover line at the top of the block, "To define the
from cpu tag format 8 bytes.", which looks like a stray draft sentence.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011025043.1859940-1-kyle.switch%40motor-comm.com
