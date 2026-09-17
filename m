Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A64E1C8E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651357; cv=none; b=qEeYIubR4kNYOXmEW+JQxk6WOr56TLyPvtiUCRoaOi2usBWFpAPdRrigGsIddFLr80zCZmBN6JAF13W1QR+SSyCSUc1OnZFRgCzYcq07U8HyxBxFjFzgNU/5jIWrrZAn+brje4BcDFcngB7QgEHHSUl+Roi3XJypGHb/Eu5sVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651357; c=relaxed/simple;
	bh=SE672sBs92D/ngGZHr/iNgpEeXI79lOc751hebMJGSM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQ71if/jJ05KmsTrwC1bU5OL1Wx0R65t1C4mKj/ECWJNwO3MREM3t6BBncQbIPrEkJevKc/ThJGM/MkSWO6p/bEh74uS1zeIRneqrUSi3i6+VyxrGHjy2wKqXIqXo99ITENQDcciJN6PoUuWUjuqBShw0TNAE8lVT3DG1IKn2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkvF0p3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkvF0p3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E55D1F000FF;
	Thu, 17 Sep 2026 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651355;
	bh=rWHX7mZLxV+fD57hEcEFA2K+yp2Ms242Ke5u6BvSpDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bkvF0p3wbnEZqWEApP3qmTxKlbC4wOqv6Edm2bJvZEqLd3sSPR5q0mFxr+Pvx8H2A
	 rsfAkflnfk/d6yE7G2BQ1L4FNgWAT1ocLli4iA+D99VvTUiep7qKYoYDZ6LikdUVlu
	 WCzTj0S/EV19e9UVzn37i5OidfIZ0J8EWZvwevkEH1zdFWowkvMaM9rl0pJmIzOBcq
	 2H2HGnxMuH7VyyY4pHsu41g9bQ9H3hz5e3kE0vXE/3cNqNk7q45KHrgfNQEicgGLsk
	 fRZ3KTgDACmD8jZABIdBnUmO1JaFJDI2TwA1v4NYt/f6sC8sGoH297myvxg8HUvIVR
	 mEsZxoae/MFUw==
Subject:
 Re: [PATCH net-next 2/3] net: rmnet: annotate data-races around mux_id
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com
Date: Thu, 17 Sep 2026 13:22:33 +0000
Message-ID: <178965135397.22033.7805558701631671967@kernel.org>
In-Reply-To: <20260916132231.1780091-3-edumazet@google.com>
References: <20260916132231.1780091-3-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The patch "net: rmnet: annotate data-races around mux_id"
  contains, besides the READ_ONCE()/WRITE_ONCE() annotations, a real…

--

net: rmnet: annotate data-races around mux_id

This adds READ_ONCE()/WRITE_ONCE() annotations around priv->mux_id and
ep->mux_id, which are written under RTNL but read from the transmit and
receive paths.  It also reorders rmnet_changelink() so that ep->mux_id is
published before the endpoint is inserted into its new hash bucket.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 59ef8b4ce5321..248a9d822409b 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -331,11 +331,11 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
>  			}
>  
>  			hlist_del_init_rcu(&ep->hlnode);
> +			WRITE_ONCE(ep->mux_id, mux_id);
>  			hlist_add_head_rcu(&ep->hlnode,
>  					   &port->muxed_ep[mux_id]);
>  
> -			ep->mux_id = mux_id;
> -			priv->mux_id = mux_id;
> +			WRITE_ONCE(priv->mux_id, mux_id);

[Severity: Low]
Beyond the annotations, the reordering here looks like a functional fix
rather than a pure cleanup.  Should it carry a Fixes: tag?

With the old ordering the endpoint was visible in the new bucket while
still carrying its old mux_id, so a concurrent reader in
rmnet_get_endpoint() would reject it:

	hlist_for_each_entry_rcu(ep, &port->muxed_ep[mux_id], hlnode,
				 lockdep_rtnl_is_held()) {
		if (READ_ONCE(ep->mux_id) == mux_id)
			return ep;
	}

	return NULL;

and the RX path then frees the skb in __rmnet_map_ingress_handler():

	ep = rmnet_get_endpoint(port, mux_id);
	if (!ep)
		goto free_skb;

The reader is driven by inbound traffic in
rmnet_rx_handler() -> rmnet_map_ingress_handler() ->
__rmnet_map_ingress_handler(), while the writer side runs from
ip link set <rmnet dev> type rmnet mux_id N, so the observable effect is
occasional packet loss during a mux_id change.

git blame points at commit 2abb5792387e ("net: qualcomm: rmnet: Allow
configuration updates to existing devices") for the previous ordering, so
would the following trailer be appropriate to help stable pick this up?

	Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916132231.1780091-1-edumazet%40google.com
