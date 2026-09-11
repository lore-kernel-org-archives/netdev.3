Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61517DFFA
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094666; cv=none; b=jx/0c4FsUDOPKJyNBc2CwD6zO6ECmic/9PC/14T8VQTgsCBYkr/vzqGUuNFjQTm/TAoNIzepgkGGSk59IC+Nrei3gUN9weF/zwL/GU3lQvXlRhd3Vzw26m7ERl6Ll/JVLxkpYJXz2e4GupEOa/Ke5NljmMgXBhIiQseVG6REa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094666; c=relaxed/simple;
	bh=qWxpejiIlViSb2ZQ+D6PY3OnOBF7BeZT95DuvcfssO8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=scPigysau4zVCntIrh1dGnYmEripr8kp+ZZfZPwC7iL8dYYvGoTGqi7b4TIaGZyD/7B3PvjdwQZVZFFAh3UZBuUzhFJJC+YdLACpbgFxPnaepsC42VTJwsQ1iYwQSpoovb2kvQn1EwCvW7SH6LG1tWcQ+J7zGjhfM420kAIg15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP4a7Q/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP4a7Q/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E5B1F00893;
	Fri, 11 Sep 2026 02:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789094665;
	bh=jpjnrm1v7zMK9LzaNvtC4op941DQZNoksYBFQZrH/ZY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BP4a7Q/J+/W/brkYT6G2N3HhGMYZ63i405fG0O/ftoMueZD/TwOE3a5QVGhKhPZOd
	 jDCLWZkj/ubJQt6yZ2/HeBAESEmyUk9h74ny3o9AEgavtxgf4M58vh02KhjEWQ9D0I
	 Zi2SsgJoMdWCiVheubpClWSiXkGzJ1ll3IstyWosWpt8EfJTKdLdWa5X8DbCIELVOi
	 sGAsIngFYHj3LtM1ppJj8RVHfDpqRbqa/p4N2j0prF5QrQ1T0GfQ1/7Sqfe+ZqkKtn
	 bsThCMDWB8PzKT+cNz3i7XUxef53mt51CCi+BMVvtb049rg6tpPFzC8fLh2By/sS57
	 74bR7WXM8RzPA==
Subject: Re: [PATCH v2 net-next 6/7] ip_tunnel: Protect
 ip_tunnel_net.tunnels[] with mutex.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Fri, 11 Sep 2026 02:44:24 +0000
Message-ID: <178909466433.219967.6650856074530288267@kernel.org>
In-Reply-To: <20260909234422.2416506-7-kuniyu@google.com>
References: <20260909234422.2416506-7-kuniyu@google.com>
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

- [Low] Reported concern (judged a false positive after verification):
  under the new mutex the check-then-act sequences in `ip_tunnel_ctl()`…

--

ip_tunnel: Protect ip_tunnel_net.tunnels[] with mutex.

This adds a per-netns mutex to struct ip_tunnel_net and takes it around the
paths that add, remove, look up or update entries in
ip_tunnel_net.tunnels[], replacing the implicit RTNL protection assumed by
ip_tunnel_find().  A DEBUG_NET_WARN_ON_ONCE(netdev_need_ops_lock(dev)) is
also added to ip_tunnel_ctl() to document that the ops lock must be a no-op
for tunnel devices.

No Link: tags are present in the commit header.

I have no regressions to report against this commit.  Quoting the hunks I
looked at most closely, with a note on the one candidate issue I chased and
why it does not look reachable here.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 3ba03c2b3b900..9ad63f1af37a6 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c

[ ... ]

> @@ -988,7 +1003,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
>  			dev = t->dev;
>  		}
>  
> -		ip_tunnel_dellink(dev, &dev_kill_list);
> +		__ip_tunnel_dellink(dev, &dev_kill_list);
>  		err = 0;
>  		break;

[ ... ]

> @@ -1164,6 +1184,8 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
>  
>  	ASSERT_RTNL_NET(net);
>  
> +	mutex_lock(&itn->tunnels_lock);
> +
>  	WRITE_ONCE(itn->fb_tunnel_dev, NULL);
>  
>  	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
> @@ -1172,8 +1194,10 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
>  		struct ip_tunnel *t;
>  
>  		hlist_for_each_entry_safe(t, n, thead, hash_node)
> -			ip_tunnel_dellink(t->dev, head);
> +			__ip_tunnel_dellink(t->dev, head);
>  	}
> +
> +	mutex_unlock(&itn->tunnels_lock);
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);

The one thing I checked was whether a tunnel already unhashed and queued for
unregistration by ip_tunnel_delete_net() above could come back, either via
ip_tunnel_update() in ip_tunnel_changelink()/ip_tunnel_ctl() (ip_tunnel_del()
becomes a no-op, then ip_tunnel_add() relinks it) or via a second
__ip_tunnel_dellink() queueing it onto another kill list.

That does not look reachable at this commit: rtnl_net_lock() still takes the
global RTNL, and the pernet exit path runs ip_tunnel_delete_net() plus the
queued unregister_netdevice_many*() inside one RTNL section, so the ioctl and
rtnetlink paths cannot interleave with teardown yet.  The later patch in the
series adding ip_tunnel_unregistering() covers those call sites anyway.

> @@ -1276,6 +1306,8 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
>  
>  	ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark);
>  out:
> +	mutex_unlock(&itn->tunnels_lock);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_changelink);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909234422.2416506-1-kuniyu%40google.com
