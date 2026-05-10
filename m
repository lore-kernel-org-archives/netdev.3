Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801B3B52E4;
	Sun, 10 May 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434516; cv=none; b=Iehy5JQN39uMR/4w4FnjQBVm6Q4lBbx0ePYzEQQLA5EYdoHeGocoNatSFyvFwmQSFHot/sHl06dGEsxMNPJUXFXIPtMXfRQodPxugngf1XE9tqRrpzJc6l8vANJ1vPHAMN5ntVxH9Qf9+Oq37LLNY3Rr1wg2pD+Xu2ipw9rmuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434516; c=relaxed/simple;
	bh=IA28COWJOmhvZ8+b8nw/zaAyouZ9xMe3VNTBBIKnoSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clRLiDRdq3hzVIZPPbVlzliqmamGwGODMyQVfOcly+onF0o50ssxr+aLgb2XSlxdwOEO/+dC96jFAEzo5Tls8rDVPqdqD+XugMdIejto3LhsjsB1UMZcuKWFZHDhRFCFKOFIewHeVu7Izu+l0o2N0LUz6Ok9RAnbK+RakOCU5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs+S9okN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs+S9okN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E909C2BCB8;
	Sun, 10 May 2026 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434515;
	bh=IA28COWJOmhvZ8+b8nw/zaAyouZ9xMe3VNTBBIKnoSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qs+S9okNHN7zZ6f+2vCijhEsBL0qwBqRArFtufxyNf36n5PG2JJOgC8xAf1Wkp+z9
	 HacjtXuUQR1uVFckh4PdAk7aHnlDrmIx6OoFuEvEZv6IFTheNud+F3KZkPQoLwpagt
	 XGk/nnwAnUanc8qbok4zmp2KZZHHAmtXQnLPZNWj0JjtoM/kLVXijuDjcOwh9aet6c
	 v04ogOBfdqo/7MLu8JOuAgAWWbWwgC5bbhZCjyRGLoEAj7NJAW867vhRJCKwfzpZz5
	 ENygMT6wx0LY6CExvyh07//Y7JMVCFNE7S+tW+0yZZ3fDC9CsmnuWcAFXFscO34BuG
	 4Choyu1rcPfsw==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 6/8] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
Date: Sun, 10 May 2026 10:35:14 -0700
Message-ID: <20260510173514.3920074-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-6-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-6-1d87c5f85a3b@gmail.com>
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
net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}

This commit implements hardware offloading of bridge functionality for the
rtl8365mb switch by configuring per-port isolation registers and Extended
Filtering IDs (EFIDs) for Independent VLAN Learning (IVL).

> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index 2b9bd4462714b..3ab91cd82743a 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
[ ... ]
> @@ -325,6 +325,120 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
>  	gpiod_set_value(priv->reset, false);
>  }
>  
> +/**
> + * rtl83xx_port_bridge_join() - join a port to a bridge
[ ... ]
> +int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
> +			     struct dsa_bridge bridge,
> +			     bool *tx_forward_offload,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct dsa_port *dp;
> +	u32 mask = 0;
> +	int ret;
> +
> +	if (!priv->ops->port_add_isolation)
> +		return -EOPNOTSUPP;
> +
> +	dev_dbg(priv->dev, "bridge %d join port %d\n", bridge.num, port);
> +
> +	/* Add this port to the isolation group of every other port
> +	 * offloading this bridge.
> +	 */
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		/* Handle this port after */
> +		if (dp->index == port)
> +			continue;
> +
> +		/* Skip ports that are not in this bridge */
> +		if (!dsa_port_offloads_bridge(dp, &bridge))
> +			continue;
> +
> +		ret = priv->ops->port_add_isolation(priv, dp->index, BIT(port));
> +		if (ret)
> +			return ret;

What happens if this port_add_isolation() fails midway through the loop,
or if any subsequent operations fail?

It looks like the function returns immediately without rolling back the
isolation masks of the ports that were already successfully modified.

This would leave the hardware partially configured, allowing the modified
bridge ports to forward traffic to the standalone port in hardware, while
the DSA core aborted the join in software, leading to a network isolation
regression.

Should there be an error unwinding path here that reverts the isolation
masks for the previously configured ports using port_remove_isolation()?

> +
> +		mask |= BIT(dp->index);
> +	}
> +
> +	/* Add those ports to the isolation group of this port */
> +	ret = priv->ops->port_add_isolation(priv, port, mask);
> +	if (ret)
> +		return ret;
> +
> +	/* Use the bridge number as the EFID for this port */
> +	if (priv->ops->port_set_efid) {
> +		ret = priv->ops->port_set_efid(priv, port, bridge.num);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
