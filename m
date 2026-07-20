Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AE42DA4E;
	Mon, 20 Jul 2026 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590645; cv=none; b=ok86vGS7k1gprb+mzzksRMgR+5bjcRyo9/NoOSQv6Fj9MwCZtUQt6AfQf5oNRlaFpmIj5lNDOs1K/0ork2RZqnWwAG/6XMIUUYGjXq55voR2Toc54MXFHuZxaeNkR7+nZXhtQcWDOqb6vdV+bUEGv6aIfwne1Yz8NsD7QtgZE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590645; c=relaxed/simple;
	bh=GJRF2mmBwdo0U3u3pzVuExP4P/AKfXhC3ELjf7vqZN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdecc7AfWQ2cS0xpdPIbMRH1UbrxzUed27bO5VKlWC4NJJtxfKAd/SfOxUJB1X1VoGRVdr5UWZ2UDNFouTFQm/AWIPbYD5jV0YHJ5fk5LVv8WCcZfDj/G/DAdwPyLFbEIXH+TuUgplhquGMLhe2BCUxFBtW9jRjTy/U70Hlx4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjDqOTIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjDqOTIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BFE1F000E9;
	Mon, 20 Jul 2026 23:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590644;
	bh=pxhwRH3nN9dkYlZu+UEvAQ52anWMkDExFjppUiugAIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjDqOTIXP/5WH1srAyZJDPS6KJSibF6J8n/G0SBTLUj1YsWG30BGe+RA5KS46IxG5
	 L9wjVV4lND6vVAUylIJ/bG/GPRsrytIqXfSZS1AoAjOju1XL55/r7F6GyZhQVHrA4/
	 DuHvqwgqznkPA2Ouid6MX/pxVRnYRefo/s4Ipw3ncEIOAjaLt7BKpO+gIM7pPgE9bx
	 qu/0epFrBGunRDv0Rzn3+R6HATVlfQSTlXHXQlosEUuZv+glRrBdPYpmY6GGROc3Uh
	 We6UfN7d2Q+NDC4I2FcYPTLjJlvYyId1b5Ly/ZV+7WMQfPbmlfxhxlPZH+pigzWb90
	 reT2vvQb9lLEw==
From: Jakub Kicinski <kuba@kernel.org>
To: lukeh@padl.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	gregory.clement@bootlin.com,
	andrew@lunn.ch,
	horms@kernel.org,
	f.fainelli@gmail.com,
	tobias@waldekranz.com,
	cedric.jehasse@gmail.com,
	kieran@sienda.com,
	mh@rme-audio.de,
	max@huntershome.org,
	christoph.mellauner@joyned.at,
	simon.gapp@gapp-audio.com,
	Ryan.Wilkins@telosalliance.com,
	mattias.forsblad@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] net: dsa: qca8k: Drop replies with wrong sequence numbers
Date: Mon, 20 Jul 2026 16:37:22 -0700
Message-ID: <20260720233722.444585-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703-net-next-dsa-rmu-v1-4-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-4-a03febf20bb4@padl.com>
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
Subject: net: dsa: qca8k: Drop replies with wrong sequence numbers

The change makes qca8k_rw_reg_ack_handler() return early when the reply
sequence number does not match, rather than only setting ack on match.
The intent is to avoid signalling completion for a late reply that could
be mistaken for the next genuine reply.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index b0cbe72c15b4..3b3fe9601617 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -185,9 +185,9 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
>  	/* We can ignore odd value, we always round up them in the alloc function. */
>  	len *= sizeof(u16);
>  
> -	/* Make sure the seq match the requested packet */
> -	if (get_unaligned_le32(&mgmt_ethhdr->seq) == mgmt_eth_data->seq)
> -		mgmt_eth_data->ack = true;
> +	/* Make sure the seq match the requested packet. If not, drop. */
> +	if (get_unaligned_le32(&mgmt_ethhdr->seq) != mgmt_eth_data->seq)
> +		return;

[High]
After this change, is mgmt_eth_data->ack ever assigned true anywhere in
the driver?  A grep across drivers/net/dsa/qca/ shows five sites that
initialise it to false before dsa_inband_request(), five sites that read
it afterwards, and no remaining site that ever writes true.

The callers still do, for example in qca8k_read_eth():

	mgmt_eth_data->ack = false;

	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
				 QCA8K_ETHERNET_TIMEOUT);
	...
	ack = mgmt_eth_data->ack;

	mutex_unlock(&mgmt_eth_data->mutex);

	if (ret)
		return ret;

	if (!ack)
		return -EINVAL;

With the assignment gone, does every successful reply now leave ack ==
false and cause qca8k_read_eth(), qca8k_write_eth() and the read/write/
clear paths in qca8k_phy_eth_command() to return -EINVAL on their fast
path?

The higher-level callers (qca8k_bulk_read(), qca8k_bulk_write(),
qca8k_regmap_update_bits(), qca8k_internal_mdio_read() and
qca8k_internal_mdio_write()) fall back to the slow MII path on error, so
the device keeps functioning, but is the Ethernet management fast path
effectively disabled between this patch and its follow-up cleanup?

Would it be cleaner to fold the removal of the ack field (and the
matching if (!ack) return -EINVAL checks in every caller) into this same
commit, so that each commit in the series is self-contained and bisects
cleanly?
