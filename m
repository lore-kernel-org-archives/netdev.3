Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612F2F531B;
	Thu,  4 Jun 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591146; cv=none; b=FhPSwxVVnCFZ7Sf7dZOP1ciPUDuknF4t/IqkR9mlpLCm//KzSBFLhOxvCtN1krrtaqgep4z/jRaMktKOTCsEwfOl6KezwtvLFtmo537VQnUan1jByOrUBxQMOKNOZZ5EMCgjceEq90m7y2k9IW4bCSCQ1cubWPaPzxkvs5jmp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591146; c=relaxed/simple;
	bh=7y1X+mc0RP4JERnetQIXLYlQgO98q5svq1wduccnOns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr4Nur5OrW16h07jCI/Mo75Il4J/3PnLvqF+UpeAsZfFvlSPjrfrzhp/A5WyHZ4dKpkq5eOziZyKTTQOxjRtN5D7EJ8GNubNh+hirNlvNKupzrt38Gt2W495PB/Iasl0QliZF4cYoUlHmXDMEvo9nL5GazvJ/LDnJBWfjUW5tII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm0Wf9c5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm0Wf9c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9B71F00893;
	Thu,  4 Jun 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591145;
	bh=C97OinIMHdoGNYwilRL1cyfSqURl26hCe8MlGB8UpuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dm0Wf9c5FAae4OWnJETtorw91Jbgd1QsxZvME4aM3YDOUcrQtZhMboaCdLlHmz3OR
	 cmEaQYetJ1uQHU7ddQkTxJHGRjx83VtThq4Eafg6WDShb8clHN0zKHJj2OMEXrDS/h
	 K/+dHUmuckP8102D/4z8p5TYR3V9VmzG0fPBTBWBEf2sDaLHlruDtJPqvYqHEOE+Gu
	 /LJNKdgKlk05c6PzJLqtvfsGHb9qJ6kFDg3bt+hhTMmWcNNAaYE742GpSrtMaf1t3r
	 cFqRBPfwh8I26LIYThlTWgpPzuLoak+eXDlvVu1+/mNBS8qSoVb0GPwuZcCSwTe9p5
	 /riCyQXM+zvew==
From: Simon Horman <horms@kernel.org>
To: mmyangfl@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: validate switch in .netdev_to_port() conversion
Date: Thu,  4 Jun 2026 17:36:30 +0100
Message-ID: <20260604163629.3976927-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603024234.66603-1-mmyangfl@gmail.com>
References: <20260603024234.66603-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: dsa: felix: validate switch in .netdev_to_port() conversion

This commit changes the .netdev_to_port() callback to take a struct
ocelot pointer and adds a dp->ds mismatch check in felix_netdev_to_port()
so that a netdev belonging to a different switch is rejected before the
port index is consumed by flower rule parsing.

> diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
> index 1b8269320464..d2e96d065dc4 100644
> --- a/drivers/net/ethernet/mscc/ocelot_net.c
> +++ b/drivers/net/ethernet/mscc/ocelot_net.c
> @@ -984,7 +984,7 @@ static bool ocelot_netdevice_dev_check(const struct net_device *dev)
>  	return dev->netdev_ops == &ocelot_port_netdev_ops;
>  }
>  
> -int ocelot_netdev_to_port(struct net_device *dev)
> +int ocelot_netdev_to_port(struct ocelot *ocelot, struct net_device *dev)
>  {
>  	struct ocelot_port_private *priv;

[Medium]
The new ocelot parameter is added here to match the updated
ocelot_ops::netdev_to_port signature, but is it actually used in the
body of ocelot_netdev_to_port()?

The function still does only:

    if (!dev || !ocelot_netdevice_dev_check(dev))
            return -EINVAL;

    priv = netdev_priv(dev);

    return priv->port.index;

ocelot_netdevice_dev_check() compares dev->netdev_ops against the
file-scope ocelot_port_netdev_ops vtable, which is shared across all
ocelot instances, so a netdev belonging to a sibling ocelot switch
passes this check and priv->port.index is returned as a port number
on the local hardware.

Isn't this the same silent wrong-port resolution the commit message
describes for the felix path?

The corresponding switch-ownership check the commit adds for felix:

    if (IS_ERR(dp) || dp->ds != ds)
            return -EINVAL;

has no analogue in the ocelot variant. struct ocelot_port carries a
back-pointer to its owning struct ocelot (used elsewhere in this
file), so a symmetric check such as:

    if (priv->port.ocelot != ocelot)
            return -EINVAL;

after the netdev_ops check would mirror the felix change and consume
the otherwise unused ocelot argument. Without it, the parameter is
dead and the validation promised by the commit message is only
half-applied.

The two call sites in ocelot_flower.c, ocelot_flower_parse_egress_port()
consuming a->dev and ocelot_flower_parse_indev() resolving a netdev
from a user-supplied ifindex via __dev_get_by_index(), both feed
externally-controlled netdevs into ocelot->ops->netdev_to_port(ocelot, dev),
so the standalone ocelot path used by ocelot_vsc7514 still accepts a
foreign switch's netdev when more than one ocelot instance is present.
