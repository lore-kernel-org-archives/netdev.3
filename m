Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31B1DE2D3;
	Thu, 30 Apr 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512730; cv=none; b=agvw4btLSELFLyKccMM3aIsMYfCMQ8skT4PO3PM8TxnMCLErc2VEd9+NQGjwDX5zaIXudmAtRclEWCyEJ060nrltfhddqi7PFJKfCqozrgS8A3PyH/49sFRyvh6Sncx3NgOB/xoy+ZyU9PaA+nJJtVbkDCV5YrA5Ki0/DHbTx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512730; c=relaxed/simple;
	bh=GPfPSzp1YJCpnaNQiH/G8TJL9kVKVDTd3wQ5tcMnVn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvOgUdoqiiQ2OI/mq+NIoLIdw5XVgr9wFmifFu8iD1fISRF0qdBMSTV1RLU4bCWxj2p9etYNKTNU9AQ7hSYitpvSSM3Ar6Q3ACEWyPx2RwzydLxtRDSBjcfpDMuU5mgz0VQsdlFtzeQEMmheiwjbZO+4W2Lpv/SmT8PpjfdKi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGh9/0l8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGh9/0l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B8BC19425;
	Thu, 30 Apr 2026 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512730;
	bh=GPfPSzp1YJCpnaNQiH/G8TJL9kVKVDTd3wQ5tcMnVn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGh9/0l87EM/HnNW6kz0veKsHsG0TAEaY0jUX2sepU9JVMHGtdsDww30zHaXwm5LC
	 xy2/u396oUNUY1oPDvGoS9W+S+EibC40TRD6QLxj3TCQCig9ztsAfiea6ecPP8LwFZ
	 1/Aj6izP87bik7ZrRIa7/cLTlZqPSpnGWTnc2lIPvEBFoxSuuosuqCIuWJGkMeOowD
	 bZzCtLNvTdCtfmSk2AG2X55An+X26qN+J8hJGQ7yKqrDVLjCBqTzAsjSNeiMGUlIV3
	 LfsPyyqJsXSZ897WAYZTyt1WysASQKl1fWANEW6CZlExrl3papNfqCw/A+l+6nKFuX
	 ti5C9elTQzOtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: maoyixie.tju@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
Date: Wed, 29 Apr 2026 18:18:48 -0700
Message-ID: <20260430011849.2345207-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
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
ip6_gre: Use cached t->net in ip6erspan_changelink().

This commit fixes an issue where ip6erspan_changelink() uses the device
creation netns instead of the per-netns ip6gre hash. This ensures the tunnel
is inserted into the correct hash, avoiding a stale entry and subsequent
use-after-free during netns destruction.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 63fc8556b475..c5978e0bdfe3 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2262,7 +2262,8 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  				struct nlattr *data[],
>  				struct netlink_ext_ack *extack)
>  {
> -	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
> +	struct ip6_tnl *nt = netdev_priv(dev);
> +	struct ip6gre_net *ign = net_generic(nt->net, ip6gre_net_id);
>  	struct __ip6_tnl_parm p;
>  	struct ip6_tnl *t;

While reviewing this area, I noticed a regression further down in
ip6erspan_changelink() regarding the metadata tunnel unlinking.

If an existing ERSPAN tunnel with metadata collection enabled is modified via
a netlink changelink request to disable metadata collection, does the unlink
sequence clear the correct pointer?

Looking at the rest of ip6erspan_changelink():

    ip6gre_tunnel_unlink_md(ign, t);
    ip6gre_tunnel_unlink(ign, t);
    ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
    ip6erspan_tunnel_link_md(ign, t);

Because ip6gre_tunnel_unlink_md() is called instead of
ip6erspan_tunnel_unlink_md(), it evaluates the old collect_md state but
clears ign->collect_md_tun instead of ign->collect_md_tun_erspan.

This seems to leave ign->collect_md_tun_erspan pointing to the tunnel.

Since ip6erspan_tnl_change() updates the parameters to disable collect_md,
the subsequent call to ip6erspan_tunnel_link_md() will skip updating the
pointer.

When the tunnel is eventually deleted, ip6erspan_tunnel_unlink_md() would
be bypassed entirely because collect_md is now false.

Could this leave ign->collect_md_tun_erspan as a dangling pointer,
causing a use-after-free when an incoming ERSPAN packet triggers
ip6gre_tunnel_lookup() and dereferences it?
