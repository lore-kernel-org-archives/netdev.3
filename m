Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFA255F2C;
	Mon, 20 Jul 2026 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591524; cv=none; b=tDfHHhDG0TFiHD4gnRftBiCEzsab6P8/8YfBiF5qjr0jT+qwIxf0T1zxW8p+Dmq+U9GieZ5BCEeI2PKLWY+9HYobueI/hxlkPi0Xj4O4Ltg2WLMOB41yoUwBNMNg5XQpodfmWp9U+VUAs6ljosLwvj6x1iAkQYd8NQhJc0O4KN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591524; c=relaxed/simple;
	bh=CkrRlCIrfvheexTh5cz3w4CkRVZ0XtKDJ4/5Eq7/uV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm8lBEJJ552oi9MO1Cfku/a8tqL0C++XkAryl6lUwAkviIW55yhMuwuT7qhuHGO7ma/B8zB2tZU5KdjLI5iZyywHqtk9/1isXaUsRmmqM457IVkB3eyXFk1lVBTvEIih332gkrnTCxzjVpHVDjqgLnM62COcroTe6qxrdjrfNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP7753De; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP7753De"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B721F000E9;
	Mon, 20 Jul 2026 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591523;
	bh=un0HAXYDHaLg43irNjzxBpMC77LeLjvYUBSeZ989yPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WP7753DeRuEIDXgLjEOLnPEizjxGMvhE5CHcfqnsPwdXqWxCmF86VsTRUw3nh/xwt
	 j6NIh3TjZINDoE7YkV3H1l/h4Un1CF6VAIGV2MIg2dGRjRyw6oRSKDSCIEh+YGvF2y
	 gzy1mKikJJpNW9h1hFzWrxdh5QdAgAfFs66o5ARPCvkIBN+8X3g8MmHthBMxmAqXYr
	 tJUOvmDz8NeBq9R/gUz4R5WradvvTOoAuTeEQRky0uq8HMuaNP52QuP1vgb5+NQo4x
	 Oghn9h0tIT0ibG767aTesdSLkqobMb150KINw8OJs5EB52T0L6J+F8mVIle+LyxhNS
	 1pItL7WSABIRA==
From: Jakub Kicinski <kuba@kernel.org>
To: joey@tinyisr.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	andrew@lunn.ch,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next v6 4/4] net: dsa: initial support for MT7628 embedded switch
Date: Mon, 20 Jul 2026 16:52:01 -0700
Message-ID: <20260720235201.466172-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704105659.140970-5-joey@tinyisr.com>
References: <20260704105659.140970-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: initial support for MT7628 embedded switch

This patch adds a DSA driver for the MT7628 embedded switch, which has
five 100Mbps user ports and a 1Gbps CPU port. tag_8021q is used to
isolate ports via the switch's 16-entry VLAN table, with the double tag
feature enabled to simulate VLAN-unaware behaviour.

> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> new file mode 100644
> index 000000000000..eccdb05fce9b
> --- /dev/null
> +++ b/drivers/net/dsa/mt7628.c

[ ... ]

> +static const struct dsa_switch_ops mt7628_switch_ops = {
> +	.get_tag_protocol = mt7628_get_tag_proto,
> +	.setup = mt7628_setup,
> +	.teardown = mt7628_teardown,
> +	.port_enable = mt7628_port_enable,
> +	.port_disable = mt7628_port_disable,
> +	.phylink_get_caps = mt7628_phylink_get_caps,
> +	.tag_8021q_vlan_add = mt7628_dsa_8021q_vlan_add,
> +	.tag_8021q_vlan_del = mt7628_dsa_8021q_vlan_del,
> +};

[Medium]
How is a user expected to place two of the user ports into a Linux bridge?

The ops table does not implement port_bridge_join or port_bridge_leave,
so dsa_switch_bridge_join() in net/dsa/switch.c returns -EOPNOTSUPP:

    if (!ds->ops->port_bridge_join)
        return -EOPNOTSUPP;

That makes ip link set swpN master brX fail for every user port, which
seems to contradict the commit message:

    The switch hardware has a very limited 16 entry VLAN table.
    Configuring VLANs is the only way to control switch forwarding.
    Currently 6 entries are used by tag_8021q to isolate the ports.

Without a port_bridge_join hook, dsa_tag_8021q_bridge_join() is never
invoked, so there is no path to migrate a port's tag_8021q VID from its
standalone VID to a bridge VID.

Would wiring the tag_8021q helpers directly, similar to what
vitesse-vsc73xx-core.c does, be sufficient here:

    .port_bridge_join = dsa_tag_8021q_bridge_join,
    .port_bridge_leave = dsa_tag_8021q_bridge_leave,

Related bridge-lifecycle callbacks such as port_stp_state_set,
port_pre_bridge_flags, port_bridge_flags and port_fast_age also appear
to be absent, is that intentional for this initial submission?
