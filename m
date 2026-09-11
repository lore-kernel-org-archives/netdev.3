Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA93F58EA;
	Fri, 11 Sep 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152738; cv=none; b=cmLu3bNlN5P7zJ46gSEcX070CLxXjHWsFJ5/t62+K4DMVRnC02/ZiCsCgAh+GKx1KEnjMjrkf7UXwnwNjgGJYt/PDW3Q689pg4iufLna/BGCtwJrHe/EOKgR24ouvEJKhWiuz0eoyVyNCNoSYVXGsHeyVVbK3oJX75w6sk7CuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152738; c=relaxed/simple;
	bh=DqdBD7p3B6SVEqiqY7eulsKoeoIOcWn/fVixtWmJKW0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJ9YWkVfDPU+VU/4r+p6Y86QkDMeKxgfb0VuW2+XIjbPgu56ismbyGjLygMyFUHEBTGoQcWveltUc8RpQBW8ghCmnOcPm+Vj4NVu7e84jk+HP7aK89IwgHEicFlPFBPlYRt11RW3u2My8BzpDM+LvOhX3r7TXCgxUTJJz4gkxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D61xlOYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D61xlOYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2189E1F00899;
	Fri, 11 Sep 2026 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152733;
	bh=ibt3RO8Zr1GyzIu7keLLuBW+ijr/NgawKOOHzrPX1lU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D61xlOYHQ3xVxBHrlrtZ/Q0DuuwLhkT8Yp927qiBF01HHwlhYBar8wXPvpneZKTDl
	 C0hVfn4Fh3T0s8p5MYbvc4OxDDQ/K83s3kV08qcbs7wPg2wpcQLx2V9l16bjaWxbhx
	 39JuCtxmT7oq5//slzoYF6TBcmRbbqc8iIJm4HSP0kFjcev8AXEBxq0xp2/+5S/uIF
	 R1ua4rDIsHgK/LofHB/p/aUK3QvFj6LPq27InRTOWFz8JPahACkXqtNufIf24xziMJ
	 /oMKFLFz+gBC4aO0JXRGCCzTUf0O7oSZIcIyuaQ/A9cdxrvyNhtn22VGDhFU0CSE/J
	 Q66UCX4r63GBg==
Subject: Re: [PATCH RESEND net-next v17 08/10] netlink: specs: Add ethernet
 port listing with ethtool
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
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it
Date: Fri, 11 Sep 2026 18:52:11 +0000
Message-ID: <178915273167.219967.10582070775250029888@kernel.org>
In-Reply-To: <20260910170103.1029108-9-maxime.chevallier@bootlin.com>
References: <20260910170103.1029108-9-maxime.chevallier@bootlin.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] ETHTOOL_A_PORT_SUPPORTED_INTERFACES is a bitset whose bit
  indices are the kernel-internal phy_interface_t enum values (struct…
- [Low] ETHTOOL_MSG_PORT_GET / ETHTOOL_MSG_PORT_GET_REPLY, the
  ETHTOOL_A_PORT_* attribute set, the YAML port-get operation and the…
- [Low] Documentation/networking/ethtool-netlink.rst gains a PORT_GET
  section and a request-translation entry, but the document's two…

--

netlink: specs: Add ethernet port listing with ethtool

This adds a new ethtool netlink operation, port-get, to the ethtool YAML
spec, along with the generated uAPI enums for the ETHTOOL_A_PORT_*
attribute set and the ETHTOOL_MSG_PORT_GET / ETHTOOL_MSG_PORT_GET_REPLY
messages. A PORT_GET section is also added to the ethtool-netlink
documentation.

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
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: id
> +        type: u32
> +      -
> +        name: supported-modes
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: supported-interfaces
> +        type: nest
> +        nested-attributes: bitset

[Severity: Medium]
How is userspace expected to interpret the bit positions of
supported-interfaces?  The spec declares it as a plain bitset with no enum
attached, and the implementation in the following patch fills it from the
internal phy_interface_t namespace:

net/ethtool/port.c:port_fill_reply() {
	...
		ret = ethnl_put_bitset(skb, ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
				       reply->interfaces, NULL,
				       PHY_INTERFACE_MODE_MAX,
				       phy_interface_names, compact);
	...
}

PHY_INTERFACE_MODE_* lives in include/linux/phy.h and has no counterpart in
include/uapi/, and there is no ETH_SS_* string set for interface names in
net/ethtool/strset.c info_template[] the way ETH_SS_LINK_MODES exists for
link modes.

A client that sets ETHTOOL_FLAG_COMPACT_BITSETS therefore receives raw bit
indices with no names and no way to resolve them.  Would it also mean that a
future insertion or renumbering inside phy_interface_t silently changes the
meaning of bits that have already been released as ABI?

Would adding a uAPI enum (and referencing it from the attribute in the spec)
be preferable here, as is done for port-type?

> +      -
> +        name: type
> +        type: u32
> +        enum: port-type
> +      -
> +        name: upstream-port
> +        type: u32
>  
>  operations:
>    enum-model: directional

[ ... ]

> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index e92abf45faf50..b4326c89b0751 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2537,6 +2537,39 @@ Within each channel nest, only the metrics supported by the PHY will be present.
>  See ``struct phy_mse_snapshot`` kernel documentation in
>  ``include/linux/phy.h``.
>  
> +PORT_GET
> +========

[Severity: Low]
Should the two message index tables near the top of this document be updated
as well?  The userspace to kernel table still ends with:

  ``ETHTOOL_MSG_MSE_GET``               get MSE diagnostic data
  ===================================== =================================

and the kernel to userspace table still ends with:

  ``ETHTOOL_MSG_MSE_GET_REPLY``            MSE diagnostic data
  ======================================== =================================

so neither ETHTOOL_MSG_PORT_GET nor ETHTOOL_MSG_PORT_GET_REPLY appears in
the lists that enumerate all valid messages, even though both are now
defined in include/uapi/linux/ethtool_netlink_generated.h.  Every other
message, including the recently added MSE_GET pair, is listed there.

> +
> +Retrieve information about the physical connection points of a network device,
> +referred to as "ports". User needs to specify a PORT_ID for the DO operation,
> +in which case the DO request returns information about that specific port.
> +
> +As there can be more than one port, the DUMP operation can be used to list the
> +ports present on a given interface, by passing an interface index or name in
> +the dump request.
> +

[ ... ]

> +  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
> +                                                  interfaces

Related to the bitset question above: could this row name the namespace the
bits belong to, so that a reader can map a bit index to an interface mode?

[ ... ]

> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
> index 8134baf7860f3..660e0c08a766a 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h

[ ... ]

> @@ -893,6 +913,7 @@ enum {
>  	ETHTOOL_MSG_RSS_CREATE_ACT,
>  	ETHTOOL_MSG_RSS_DELETE_ACT,
>  	ETHTOOL_MSG_MSE_GET,
> +	ETHTOOL_MSG_PORT_GET,
>  
>  	__ETHTOOL_MSG_USER_CNT,
>  	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)

[Severity: Low]
At this commit the message ID and the documented operation exist but nothing
in net/ethtool dispatches them: there is no ethnl_port_request_ops, no
ethnl_default_requests[] entry, no ethtool_genl_ops entry and no policy, so
a port-get request built from the spec is rejected.

This is closed by the next patch in the series, "net: ethtool: Introduce
ethtool command to list ports", which adds:

net/ethtool/netlink.c:
	[ETHTOOL_MSG_PORT_GET]		= &ethnl_port_request_ops,
	...
		.cmd	= ETHTOOL_MSG_PORT_GET,
		.doit	= ethnl_default_doit,
		.start	= ethnl_port_dump_start,
		.dumpit	= ethnl_port_dumpit,

so the only residual effect is a one-commit window where the documented
command is not handled.  Is that split intentional, or would folding the
spec, uAPI header and documentation into the implementation patch be
preferred?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910170103.1029108-1-maxime.chevallier%40bootlin.com
