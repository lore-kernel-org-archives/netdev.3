Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F345C701;
	Thu, 24 Sep 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266037; cv=none; b=l/LzyQBwerWNkjipwssUr714mF+UIQVNBFshJTr7KsL/dE8vpv7Um/wZuHUr6WdAo5R56MtVHqykKDLrhCulgZs/jxPUyfraDNs0NByRDcwL1ApNhWOBfo8fxNsYcFmMEWdU/RzWKiobCZti8sH4B3MtnB18nByTxmpj1qzwkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266037; c=relaxed/simple;
	bh=2WsYwVcHFCjHY2sb0hGXPnMy+CyyfC8wOAqnXNtGhxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1fA/8OiqlkKexJz1aqGylIt545bplA1FE5+I/IX57LSTL5n+QvoQKzvvZoBihxjR+9kpAadC6Ho9VQbmcH3trMxCHB+O1dM6FrwnHzQ7mTPAZsVOSFJj7VXD3nPLwDGfYumsmS8qfhVJIA7sFnG2CS5W+qDAKeDYX3Emc48AjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijLSFv7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijLSFv7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46211F00893;
	Thu, 24 Sep 2026 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266036;
	bh=P/LQL8vJBd6lxTx4gltrEGEIbrleWxLuxoVbeStT2Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ijLSFv7yLVXYWVIhKtsHeCuLQ1uUsdvaVvdZtNtSUG+69sfjKXN3arkIa+Rf6TF99
	 Jt7uG7PClejRsn3DJdki+koBcIx3EpNJ2g02Wu+lVbOko20wnFkxHE0lgDRJfC57dD
	 bee1PL1HxzjyOCgu5OBunU8mwHVx0E5k+FTXRIgLmFqwYzUwx4kGKIlW1NvAFdb+W2
	 CLociAO9jeNAIfToGgdnxXtXmU8zAnSr+jridjN4fBbeGZF3XCOtG1SbBBm8qLrlWU
	 GClnp+XhO9XyVLq6jqSMUBTHEmwpkwsGbCugoJjTKaXaljj9D5Qdfax1vm0Rd75hvP
	 iAugqB+EFSLfA==
Date: Thu, 24 Sep 2026 09:07:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kory
 Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool: tsinfo: release net_device reference in
 ethnl_tsinfo_start()
Message-ID: <20260924090715.029f1550@kernel.org>
In-Reply-To: <20260919204803.2811673-1-benquike@gmail.com>
References: <20260919204803.2811673-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 20:48:03 +0000 Hui Peng wrote:
> -	if (ctx->req_info->base.dev) {
> -		struct net_device *dev = ctx->req_info->base.dev;
> +	if (ctx->single_dev) {
> +		struct net_device *dev = dev_get_by_index(net, ctx->pos_ifindex);
>  
> +		if (!dev)
> +			return -ENODEV;
>  		netdev_lock_ops_compat(dev);
>  		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
>  		netdev_unlock_ops_compat(dev);
> +		dev_put(dev);
>  		return ret;

This issue gotta be theoretical, can you build a repro that actually
triggers multi-skb dump for a single netdev? We don't have that much
info, it's gonna fit.

If you can trigger pls update the commit msg, if you can't let's instead
make this "official" by adding:

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index c9b680a9cc3f..cbb5d6b7f3e3 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -482,6 +482,7 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
                netdev_lock_ops_compat(dev);
                ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
                netdev_unlock_ops_compat(dev);
+               /* We don't want to hold the device ref across messages */
+               WARN_ON_ONCE(ret == -EMSGSIZE);
                return ret;
        }
 
