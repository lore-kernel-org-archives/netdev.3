Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A02497B90;
	Mon, 21 Sep 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983334; cv=none; b=CJ4Qjz4leWCkXeCR95+4NXxjRrJhuPvDcreMV+PsovaeBdnIEhZW5rA20Ib8p1wJJzz3rHl2AGqTmw8ADiUzO1tBFp+alZDkW3zf/sfa7hzD76e9g/BpHqmbqX1tjlz45FFLShHKZwQzTektH6GmiHJaDORRg2/Qu/Se+fvdli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983334; c=relaxed/simple;
	bh=wHlZQCmEvm8eS8bhVj5C0lW70UI2pP0TuTL1uN4UZv4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eduzk9CRf7er5IdW0wv+nUog7R7l7ZTH/B+WPXAaNMxriu6/c36Z+ybpyJ4laVYzt8uheqcitIn6FJhkz+lHhYVMLH2t20p3b7zCf39rtjdgNMkqFDq2PbrN6tMsaFoUXkzw6XcD6T5rZG5X1c66zummOmgGmWCcKmCb/W4nsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWPBWXMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWPBWXMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1E61F00898;
	Mon, 21 Sep 2026 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983332;
	bh=xAJnMKYdT5gO7lEhuBuFTmWvMCuRt1o/1myPvEWIqZI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MWPBWXMZPJjcyOI/tmjl8skM+aUSgyovLslKcCC5CGLi1NEeStpokKrXECbpL4PTr
	 fceE+UvwCFw10bG21CrhFS+vdlBCxKXAmQwaK64c2ixc6f+UpcbkJYLhJSKS3MIapL
	 P+oSaPljQyFy2S7CN6b1cKg8Shx+lZWhA8gRcFu7IjoRJryAiGZFryJOczxr95aAoL
	 icIxMlj+Lbtbgal7UFvs8ukpSqjJxWAEi2drMf9SCrxT0ldOqqFofFIyyh16iqcJRp
	 xcVPD8/yTFxPxKicFSew2/w3UhbqjnUf1B9nr2US1J3j38QSZSNlFVBkOk1r/L4tmr
	 XlAipamma4/XA==
Subject: Re: [PATCH net-next v8 5/6] net: dsa: tag_yt922x: add support for
 Motorcomm YT922x tags
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 21 Sep 2026 09:35:30 +0000
Message-ID: <178998333071.2160803.14768985713826321291@kernel.org>
In-Reply-To: <20260917082236.3427168-6-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-6-kyle.switch@motor-comm.com>
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

- [Low] Claim that the new tagger has no in-tree user (dead code, wasted
  DSA_TAG_PROTO value).
- [Low] yt922x_tag_rcv() (net/dsa/tag_yt922x.c:58-96) never calls
  dsa_default_offload_fwd_mark(), unlike the sibling tagger…
- [Low] net/dsa/tag_yt922x.c declares an ingress-priority field
  `YT922X_TAG_RX_PRIO_M GENMASK(15, 13)` (line 27) that no code…

--

net: dsa: tag_yt922x: add support for Motorcomm YT922x tags

Adds a new DSA tagger for Motorcomm YT922x switches using an 8 byte
EtherType-based tag, allocating DSA_TAG_PROTO_YT922X_VALUE 36, plus the
Kconfig and Makefile entries.  A few questions below, none of them
serious.

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 23b4b74004ed5..0b9f8a632cf22 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -227,4 +227,10 @@ config NET_DSA_TAG_YT921X
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Motorcomm YT921x switches.
>  
> +config NET_DSA_TAG_YT922X
> +	tristate "Tag driver for Motorcomm YT922x switches"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for
> +	  Motorcomm YT922x switches.
> +
>  endif

[Severity: Low]
This isn't a bug, just a note for anyone reading the patch on its own:
as of this commit nothing in the tree selects NET_DSA_TAG_YT922X and
nothing returns DSA_TAG_PROTO_YT922X.

The next patch in the series ("net: dsa: motorcomm: Add support for
Motorcomm YT922x") adds yt922x_dsa_get_tag_protocol() returning
DSA_TAG_PROTO_YT922X and adds select NET_DSA_TAG_YT922X to
drivers/net/dsa/motorcomm/Kconfig, so the tagger does get a user by
the end of the series.

[ ... ]

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

[Severity: Low]
Is YT922X_TAG_RX_PRIO_M meant to be used somewhere?  It is defined here
and never referenced anywhere else in the file, so the hardware ingress
traffic class is dropped.

yt922x_tag_rcv() reads the word that contains it but only extracts the
source port:

	rx = ntohs(tag[2]);
	port = FIELD_GET(YT922X_TAG_RX_PORT_M, rx);

The sibling tagger does propagate it in yt921x_tag_rcv():

	skb->priority = FIELD_GET(YT921X_TAG_PRIO_M, rx);

Should yt922x_tag_rcv() set skb->priority the same way, or should the
unused macro be dropped?

Related to that, the only comment describing the layout says "To define
the from cpu tag format 8 bytes", but the block mixes from-CPU and
to-CPU fields.  In particular tag[2] bit 15 is the port 0 destination
bit on transmit (YT922X_TAG_PORTMASK_0, used in yt922x_tag_xmit()) while
YT922X_TAG_RX_PRIO_M declares bits 15:13 of the same word as receive
priority.  Could the comment be extended to spell out the from-CPU and
to-CPU words separately, so it is clear which fields belong to which
direction?

[ ... ]

> +	/* Remove tag and update checksum */
> +	skb_pull_rcsum(skb, YT922X_TAG_LEN);
> +	dsa_strip_etype_header(skb, YT922X_TAG_LEN);
> +
> +	return skb;
> +}

[Severity: Low]
yt922x_tag_rcv() returns without calling dsa_default_offload_fwd_mark(),
unlike yt921x_tag_rcv() which does:

	/* Already forwarded by hardware */
	dsa_default_offload_fwd_mark(skb);

This has no effect today, since dsa_default_offload_fwd_mark() computes:

	skb->offload_fwd_mark = !!(dp->bridge);

and yt922x_dsa_switch_ops in the following patch provides only
get_tag_protocol, phylink_get_caps, port_setup and setup, so
dsa_switch_bridge_join() returns -EOPNOTSUPP, dp->bridge stays NULL and
DSA falls back to software bridging.

The observation is more about the RX tag decode: it does not extract any
forward/trap ("code") field, so there is currently no way to tell a
hardware-forwarded frame from a CPU-only trap.  Is that field absent from
the YT922x to-CPU tag, or is the decode intentionally left minimal until
bridge offload ops are added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917082236.3427168-1-kyle.switch%40motor-comm.com
