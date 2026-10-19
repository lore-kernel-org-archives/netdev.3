Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA714FC8C9;
	Mon, 19 Oct 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416795; cv=none; b=j/iBRhETZcEfYVc8A+J3+K4Di2tnwixbUg7KLBR4xqBJQTCHZ9bmsQ4dsh7l+TkSHxqwNSEDIYRf+QquckLFeyEXrTAimErwz0XiVAtc6e4pQ2d9/q1+ougDLRCwRunUqOvl7fd47rW5OSj5pnx+epGlPAIrUUccnMW0ja6ccus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416795; c=relaxed/simple;
	bh=0r2qwGEOygYORoyljyxOdtNOEaL16SHmz3uLPcF1SJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBXoxP5qvIwwY78f/yePb4wR5dCLmsMGnO7CcVXR9i9wv3Rs8BueGbzZr6jumT8FrsnM7RA6z6+nmTnchAlwCBX1iBQtNCo5BIqxmw5ojFL8QumblL+e5OhKH0MeRjeSSoJMAWNXoLxJ8H+Ff7xCwvGIj8P0hH0Ik5tgd8kj4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxmAEfWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxmAEfWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC81F000C6;
	Mon, 19 Oct 2026 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416793;
	bh=SNsAd5/c99ppsZcKfD1Hz1XH3Yj4pQT6TJtqGPD+VKQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TxmAEfWmFFscyJsPRILotkosXiR9s8A/yyq0PZ6Qe9qZcqntGGEvAn0qLJ0BZSG5U
	 dk7ZEe6LoJ/JUVacLwdroyD6oGU6e0Y7C0RoY0wPQkJaiU5HMASUC7gCvjBiNS33xo
	 1YYiQEoaKyo8r6Oaaa5YesX2dkktmuLhjveYoq0/9BEw78DpbdpXdMClNKshuPUHsg
	 rjfkBoN33IY7cb1Qc2I762ELGc0l3QZxnv+kF9d42fKMy3Ank5lw4K1xUI3vcXc8uu
	 98nla4nOfz/QEC0yfdVzNr2RfF4pFp6A2r2EHyiqWjFa4NOEQf4lDNDXXq+JR1UIlo
	 kx3NvK95IOFKA==
Subject: Re: [PATCH net-next v19 08/10] netlink: specs: Add ethernet port
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
 f@lex.la, chleroy@kernel.org
Date: Mon, 19 Oct 2026 13:33:11 +0000
Message-ID: <179241679196.3135.12518377051542306291@kernel.org>
In-Reply-To: <20261016133107.54054-9-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-9-maxime.chevallier@bootlin.com>
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

- [Low] Series-ordering note only, not a bug in the final series.
- [Low] The new uAPI enum port-type
  (Documentation/netlink/specs/ethtool.yaml line 216, generated as enum…

--

netlink: specs: Add ethernet port listing with ethtool

This adds the YAML spec, the documentation and the generated uAPI header
definitions for a new ETHTOOL_MSG_PORT_GET command. The command reports
the front-facing ports tracked by the phy_port infrastructure. It defines
a new port-type enum (mdi, sfp) and a port attribute set with id,
supported modes, supported interfaces, type and upstream port.

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index a66594ad9e739..a9cb025387830 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -212,6 +212,11 @@ definitions:
>        -
>          name: discard
>          value: 31
> +  -
> +    name: port-type
> +    doc: type of physical connector
> +    type: enum
> +    entries: [mdi, sfp]

[Severity: Low]
Could the meaning of this enum be spelled out more clearly? The doc
string "type of physical connector" is close to what
ETHTOOL_A_LINKINFO_PORT already carries with the legacy PORT_* values
(PORT_TP, PORT_FIBRE, PORT_OTHER, ...).

The existing phy_port_get_type() helper also uses the "port type" name,
but it returns PORT_* values:

drivers/net/phy/phy_port.c:phy_port_get_type() {
	if (port->mediums & BIT(ETHTOOL_LINK_MEDIUM_BASET))
		return PORT_TP;
    ...
}

So ETHTOOL_PORT_TYPE_MDI and PORT_TP are both 0, but they mean different
things. The PORT_GET section in ethtool-netlink.rst describes
ETHTOOL_A_PORT_TYPE only as "the port type". It does not name enum
ethtool_port_type or list the values.

The mdi and sfp entries also have no per-entry doc. Here is
port_fill_reply() in net/ethtool/port.c from the next patch in the
series:

	port_type = ETHTOOL_PORT_TYPE_MDI;
	if (reply->mii || reply->sfp)
		port_type = ETHTOOL_PORT_TYPE_SFP;

With this code an SFP cage reports sfp. The port of an SFP module plugged
into that cage (upstream_port set, is_sfp not set) reports mdi.

These values become fixed uAPI once released. Would it make sense to
document what mdi and sfp mean in each of these cases, and to reference
the enum from the rst?

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
This isn't a bug in the final series. At this commit, though, nothing
under net/ethtool/ handles ETHTOOL_MSG_PORT_GET: there is no policy, no
ethnl_default_requests entry and no genl op. A request therefore fails
with -EOPNOTSUPP. Meanwhile, the new PORT_GET section in
ethtool-netlink.rst already describes working DO and DUMP behaviour.

The next patch, "net: ethtool: Introduce ethtool command to list ports",
adds net/ethtool/port.c with ethnl_port_request_ops, ethnl_port_dumpit()
and ethnl_port_get_policy. It also registers ETHTOOL_MSG_PORT_GET in
net/ethtool/netlink.c, so the gap is closed by the end of the series.

Is this intermediate state intended? Splitting the spec from the
implementation is common netdev practice, so this is only a note.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
