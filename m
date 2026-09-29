Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD03815D5;
	Tue, 29 Sep 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642332; cv=none; b=Z/pgK9w5n1+5Gk9Vz3LW0rmHApqHVxmzTA0Vr6LdUuIIRsyb9mqMs4/c9igrOTO3xNPJsh96CLJb9zAlYrCIvvjkuPRNAC0/ssKberyu6JVim7YoQS07FkqmyzuW5dB0JaUgULO3gQjWCoiaMLhXMo6st9nKdP8YkdmsuZutr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642332; c=relaxed/simple;
	bh=X6DSq9e+yoGJknUUvY9+U79f6pxegxyKVauagk/dvSU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpsDO8eZIVjHXT3JVBdQ3xveNy3y/MUql4z8tfO7PBvTC/zKaRw57En1Q0YFAIKLQbd3+0ZTZtuHUlQLmnFdkYigpRCTrgQPqN+OarejF3Bs3wOfxEthSSNu1fxs+md3iKcskwoQTuNcwXe1gRm91abkqM9Z9RJOjPnnMbm97Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpJNDmC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpJNDmC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41F51F0089A;
	Tue, 29 Sep 2026 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642325;
	bh=WSn/ntiHSfOGNeUUTisBd1DTtj5XOEEpFxWfs3lBCxo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fpJNDmC+nmjA2TV2NjylfvarrPEKH9TvmAOvlSAgzchGCAC9Bl4FJZyrZMrw2nwuJ
	 9mLN17+gZid3ho0BxivS1gkU25D2tAt2kVTo8EwC95Zk8MEIzNa6dPK5wXf7uRqiYk
	 HTakk2IycHrBsgnulW6rpBilSS5/CcXpbZupV/EalO4hdg0Pl+7SCZDdjhCHFVM7Ez
	 7l9CvbO6ZQshuV71jnmAHSRIsF9VfFet7ZYw+BzVamKm/QSGVZ+H7/IocuZi5G0HIz
	 vLUMmbwraMmFkHTmC8SnLtQRW/VYN2bu5m4VRfm5Wv/cq2BRrIjN+wfVGT2tbKbtlO
	 tpO/4UmSu5qEQ==
Subject: Re: [PATCH net-next v18 08/10] netlink: specs: Add ethernet port
 listing with ethtool
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:43 +0000
Message-ID: <179064232348.3145.46294950566052543@kernel.org>
In-Reply-To: <20260927133619.955236-9-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-9-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ETHTOOL_A_PORT_SUPPORTED_INTERFACES is added to the spec
  (Documentation/netlink/specs/ethtool.yaml, attribute-set 'port',…
- [Low] Baseline rejected this as a false positive.

--

netlink: specs: Add ethernet port listing with ethtool

This commit adds the YAML spec, the generated uAPI header entries and the
documentation for a new ETHTOOL_MSG_PORT_GET netlink command. The command
reports the front-facing ports (phy_port) of a network interface, including
their type, supported link modes and supported MII interfaces.

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 5dd4d1b5d94bb..35e028c0be296 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml

[ ... ]

> @@ -1905,6 +1910,32 @@ attribute-sets:
>          name: link
>          type: nest
>          nested-attributes: mse-snapshot
> +  -
> +    name: port
> +    attr-cnt-name: --ethtool-a-port-cnt
> +    attributes:

[ ... ]

> +      -
> +        name: supported-modes
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: supported-interfaces
> +        type: nest
> +        nested-attributes: bitset

[Severity: Medium]
How is userspace expected to decode the bits in this bitset?

Nothing in the uAPI says which bit index maps to which interface. The
implementation added later in the series, port_fill_reply() in
net/ethtool/port.c, emits it as:

	ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
			       reply->interfaces, NULL,
			       PHY_INTERFACE_MODE_MAX,
			       phy_interface_names, compact);

That means the bit positions are the kernel-internal phy_interface_t values
from include/linux/phy.h. The names come from phy_interface_names[] in
net/ethtool/netlink.c, which is not exposed as an ETH_SS_* string set.
enum ethtool_stringset has ETH_SS_LINK_MODES for the sibling
supported-modes bitset, but it has no entry for PHY interface modes.

If the request header sets ETHTOOL_FLAG_COMPACT_BITSETS, ethnl_put_bitset()
sends only the size and value words, without the per-bit names. Would the
client then get raw phy_interface_t indices that it has no uAPI way to map
back to interface names?

It would also make the ordering of phy_interface_t de facto ABI. Adding or
reordering a mode would then change what compact-bitset users see.

Should this bitset get a matching string set? If not, should the spec and
ethtool-netlink.rst say that only the verbose form can be decoded? Right
now the documentation only says "bitset of supported MII interfaces".

[ ... ]

> @@ -2859,6 +2890,30 @@ operations:
>              - worst-channel
>              - link
>        dump: *mse-get-op
> +    -
> +      name: port-get
> +      doc: Get ports attached to an interface
> +
> +      attribute-set: port

[Severity: Low]
This commit adds the port-get operation, the ETHTOOL_MSG_PORT_GET and
ETHTOOL_MSG_PORT_GET_REPLY IDs and the ETHTOOL_A_PORT_* attributes to the
uAPI. There is no kernel handler for them yet at this point in the series.
Would a kernel built at this commit return -EOPNOTSUPP for PORT_GET?

The next patch in the series, "net: ethtool: Introduce ethtool command to
list ports", adds net/ethtool/port.c. It also adds the
ethnl_default_requests[] entry and the ethtool_genl_ops entry for
ETHTOOL_MSG_PORT_GET. By the end of the series the command works, so this
only matters when bisecting to this intermediate commit.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
