Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141349D596;
	Mon, 28 Sep 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591965; cv=none; b=uEEQCdigP2wGbd3UccWDRgiEXHHzWr99fr9xt1ntQDXU9yXH1+G8HsaJNqtn9/icBytRbK8KKBzohu4HtuvzoXSc3EAfrkAAt8meWGaDoKEkreFZWOaRugh8wv8DI0uWYqwJWAk4Dn8Hbw8uvYTycgk1cXPCoJnph5WNEr9FXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591965; c=relaxed/simple;
	bh=4zAfvJ/YEPRCSbZ6W44LP1fnZ2F6wHrFJVL93tZ8G3Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzY3WhU9m0sxhvq99KbT3bnlxciXXED+XMnU9oHd7lZCtEuEeZq2sdhV58lsOFEf6DTNheUV+tBsivGs4Cx7xIitVLxcKgG4zImV72eB3G+OqqZc9GksHeSA9EHpJdqM/WV1N0REd2ieBKNmOLoYXQPQA3/qg5xhcPnsEtV9TRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEY6XD1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEY6XD1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB2F1F00898;
	Mon, 28 Sep 2026 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591963;
	bh=mHrvW++GXvQlasPSk4X7veFYHYtXwoPlGrClgK5OKb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NEY6XD1jjDbcj5+Pina/92K1qxRSDPsgHWQ4uWQBCFQYASnHPjLTdRVdrU8iro03o
	 GaiYxfY3JmF3v8M0uLm+e4b1BTkqOBAIhKM68oMHEQpgqkFb4fHToz2ysdFT9BKKd/
	 umbUnwlukoBXrbUOACDjjRNXeV7PPXwVXbf7Tsqg2Pormv6MlwODRJGFob0zfaO33p
	 XGDAEcgY2CPJBtwamn08/2jpQu0Yg4TYlRwU/5Y+xDW/fzDjNqR5pPLvHnLsd4De6f
	 tQ+qsor4f6Q49VEugrSSYWQbYm5ovYd7ZHyqJ/olLv/Zux2icY5/V3YTBG2CnKiXDk
	 eIGjIbno2Vqjg==
Subject: Re: [PATCH net-next v9 6/7] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 28 Sep 2026 10:39:22 +0000
Message-ID: <179059196242.3145.14201688077833969484@kernel.org>
In-Reply-To: <20260924094146.4128703-7-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-7-kyle.switch@motor-comm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Claimed: yt922x_tag_rcv() never calls
  dsa_default_offload_fwd_mark() or decodes a forward/trap code, so…
- [Low] net/dsa/tag_yt922x.c adds a tag driver whose file is not listed
  in any vendor MAINTAINERS entry.
- [Low] The comment block in net/dsa/tag_yt922x.c says 'To define the
  from cpu tag format 8 bytes:' and then describes nothing; the #defines…

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

This commit adds a DSA tag driver for Motorcomm YT922x switches. The 8
byte tag reuses the ETH_P_YT921X EtherType (0x9988). On transmit it
carries the destination port mask and priority, and on receive it
carries the source port.

> diff --git a/net/dsa/tag_yt922x.c b/net/dsa/tag_yt922x.c
> new file mode 100644
> index 000000000000..006a6bda90eb
> --- /dev/null
> +++ b/net/dsa/tag_yt922x.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Motorcomm YT922x Switch Extended CPU Port Tagging
> + *
> + * Copyright (c) 2026 Kyle switch <kyle.switch@motor-comm.com>
> + *
> + */

[Severity: Low]
Should this new file be added to MAINTAINERS?

The Motorcomm switch entry lists drivers/net/dsa/motorcomm/ and the
YT921x tagger, but not net/dsa/tag_yt922x.c:

MAINTAINERS:
MOTORCOMM YT921X ETHERNET SWITCH DRIVER
...
F:	drivers/net/dsa/motorcomm/
F:	net/dsa/tag_yt921x.c

Right now only the generic net/dsa/ entry covers the file, so
get_maintainer.pl won't send patches for it to the Motorcomm
maintainers. The author of the new file isn't listed in that entry
either.

> +
> +#include <linux/etherdevice.h>
> +
> +#include "tag.h"
> +
> +#define YT922X_TAG_LEN	8
> +
> +/*
> + * To define the from cpu tag format 8 bytes:
> + */
> +#define YT922X_TAG_NAME		"yt922x"
> +#define YT922X_TAG_PORTMASK_0	BIT(15)
> +#define YT922X_TAG_PORTMASK_M	GENMASK(8, 0)
> +#define  YT922X_TAG_PORTS(x)		FIELD_PREP(YT922X_TAG_PORTMASK_M, (x))
> +#define YT922X_TAG_FORCE_DST	BIT(9)
> +#define YT922X_TAG_PRIO_M	GENMASK(12, 10)
> +#define YT922X_TAG_PRIO_EN	BIT(13)
> +#define  YT922X_TAG_PRIO(x)		(FIELD_PREP(YT922X_TAG_PRIO_M, (x)) | YT922X_TAG_PRIO_EN)
> +#define YT922X_TAG_RX_PORT_M	GENMASK(5, 2)

[Severity: Low]
This isn't a bug, but the comment says "To define the from cpu tag
format 8 bytes:" and then no format description follows.

YT922X_TAG_RX_PORT_M is also under the from cpu heading, but only
yt922x_tag_rcv() uses it, to parse the to cpu direction.

Could this get a layout description like the one in tag_yt921x.c (the
DA/SA/TagET/Tag diagram plus a description of each field), covering
both directions?

With that, the TX encoding could be checked against the hardware
format: ports 1..8 in tag[1] bits 8:0, port 0 in tag[2] bit 15, and
the FORCE_DST, PRIO and PRIO_EN bits. The same goes for the RX port
field in tag[2] bits 5:2.

[ ... ]

> +static struct sk_buff *
> +yt922x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{

[ ... ]

> +	/* Remove tag and update checksum */
> +	skb_pull_rcsum(skb, YT922X_TAG_LEN);
> +	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
> +
> +	return skb;
> +}

[Severity: Medium]
yt922x_tag_rcv() never calls dsa_default_offload_fwd_mark(), and it
doesn't decode a forward or trap reason from the tag. The sibling
tagger does this for frames the hardware has already forwarded:

net/dsa/tag_yt921x.c:yt921x_tag_rcv() {
    ...
		case YT921X_TAG_CODE_FORWARD:
		case YT921X_TAG_CODE_PORT_COPY:
		case YT921X_TAG_CODE_FDB_COPY:
			/* Already forwarded by hardware */
			dsa_default_offload_fwd_mark(skb);
    ...
}

With the current series this doesn't seem to be reachable. The
yt922x_dsa_switch_ops added later in the series ("net: dsa: motorcomm:
Add support for Motorcomm YT922x") has no .port_bridge_join. That means
dsa_switch_bridge_join() returns -EOPNOTSUPP and bridging falls back to
software.

yt922x_port_setup() also limits each user port to the CPU port:

drivers/net/dsa/motorcomm/chip.c:yt922x_port_setup() {
    ...
	ctrl = ~priv->cpu_ports_mask;
	res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port), ctrl);
    ...
}

Learning is also disabled, and unknown unicast and multicast are
trapped to the CPU. So leaving offload_fwd_mark at 0 is correct for now.

If bridge offload is added for YT922x later, would the software bridge
forward frames the switch has already forwarded, and send duplicate
flooded frames on bridged ports? If the tag carries a YT922x forward
reason, would it make sense to decode it before bridge offload is
added?

skb->priority is also not set on receive, but that is optional and many
taggers don't set it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924094146.4128703-1-kyle.switch%40motor-comm.com
