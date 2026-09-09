Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6A2F9D98
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919124; cv=none; b=KYPQsRtQoMRWGQh2XqhFrsLQhHPPdRVEuNHTx7iosyilHuoDDdEaTUFt8ct4odRD84toAq2P0CrgtpaEWEtIbq8ZfOclyimB51z9cviIdcmA/RLb/1q2tWogwVQ+Qc9HfWX3VYNke1naRlKmlHu0E0ekgqJUFM2W9LuWix3gnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919124; c=relaxed/simple;
	bh=mGwX8S5iAeDTwU64O8LLf12wRG8gi6SKn21tv0fM5R4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJsjSbKMIs6dFfxRYrcv0wZyzIMmpLrW5WTKNegnH6r0qhviE8W3rJ8NGY1zIsxwVmnvtrVz1F58LdzBNdsNYbrqaC+8+m5YKEZEPTGB4yt+h8YLBxL87tsMEFcV/przLfFBNV+qgFY/dXRl8Brb63Wchjn4ay2kHH5JyD7POq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTPB7Q4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTPB7Q4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81471F00A3D;
	Wed,  9 Sep 2026 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919121;
	bh=xJfTaRLhO3qcKl1JGGC4fAv/fylVuaR1XfFE0tjsEus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mTPB7Q4pNBnc9YCo0peh4WKo+Nw4O+Vzed5NHSFwn2qx0E1qknUKYoouQ01ylqRv1
	 kovAZ3miEXwRmsqKK5D4HEpMar3g5vvHLkn8MhG3zkUF/eZq2RXHKYx+nhk7O53fnn
	 8uC4sLh0VbW//CrKHsenxjbJGdm5IPPdJEGzRrYxk1cNjU/6HJlMzh65VMnlIuiF2I
	 R5pPjS2MB/2cId00GSoydUnZWI2xwpbVyTvGTMECYfVAOIAJEfGT9GrGAWxSf+39rb
	 XpM7epvCh9QH8qQ31IlVJSf3HrDSInOKmrlK7IvWHOXNs2OQicte4NwkLA/F6hU7V2
	 DNTexsCrjYsFQ==
Subject: Re: [PATCH v1 net-next 2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL
 in ip_tunnel_delete_net().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Wed, 09 Sep 2026 01:58:40 +0000
Message-ID: <178891912049.219967.11126712848920219064@kernel.org>
In-Reply-To: <20260907225846.3787676-3-kuniyu@google.com>
References: <20260907225846.3787676-3-kuniyu@google.com>
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

- [Low] Claim (INVALIDATED by verification): 'ip_tunnel_delete_net() no
  longer uses its struct rtnl_link_ops *ops argument yet the prototype…

--

ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().

This clears itn->fb_tunnel_dev at the start of ip_tunnel_delete_net() so
that the fallback device is treated like any other tunnel device, drops
the for_each_netdev_safe() scan that matched dev->rtnl_link_ops == ops,
and removes the now redundant fb_tunnel_dev clearing from
ip_tunnel_uninit().

No Link: tags present in the commit header.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..d29e2ba7cdd3a 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -1155,26 +1155,19 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
>  			  struct list_head *head)
>  {
>  	struct ip_tunnel_net *itn = net_generic(net, id);
> -	struct net_device *dev, *aux;
>  	int h;
>  
>  	ASSERT_RTNL_NET(net);
>  
> -	for_each_netdev_safe(net, dev, aux)
> -		if (dev->rtnl_link_ops == ops)
> -			unregister_netdevice_queue(dev, head);
> +	WRITE_ONCE(itn->fb_tunnel_dev, NULL);

[Severity: Low]
With the for_each_netdev_safe() scan gone, is the ops argument of
ip_tunnel_delete_net() still used anywhere in the function?

The prototype in include/net/ip_tunnels.h and all five callers
(ipgre_exit_rtnl_net(), ipgre_tap_exit_rtnl_net(),
erspan_exit_rtnl_net(), vti_exit_rtnl_net(), ipip_exit_rtnl_net()) still
pass their link ops:

	void ip_tunnel_delete_net(struct net *net, unsigned int id,
				  struct rtnl_link_ops *ops,
				  struct list_head *dev_to_kill);

The follow-up patch in this series, "ip_tunnel: Don't pass rtnl_link_ops
to ip_tunnel_delete_net().", removes the argument from the declaration
and from all five call sites, so the unused parameter only exists for one
commit and does not produce a compiler warning. Would it be simpler to
fold that removal into this patch, or to note in the changelog that the
argument becomes unused here?

A second, related observation about coverage: the removed loop was the
only place that picked up devices by netns membership, so after this
change ip_tunnel_delete_net(net) only walks the itn hashes of net. A
device that lives in the dying netns but is hashed in another netns' itn
(created with link-netns, e.g. "ip -n nsB link add gre1 link-netns nsA
type gre ..." followed by "ip netns del nsB") is no longer queued here.

Tracing that case, it still gets destroyed by default_device_exit_batch():

net/core/dev.c:default_device_exit_batch() {
	...
	for_each_netdev_reverse(net, dev) {
		if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
			dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
		else
			unregister_netdevice_queue(dev, &dev_kill_list);
	}
	...
}

which reaches ip_tunnel_dellink() and, since fb_tunnel_dev != dev there,
does ip_tunnel_del() plus unregister. So nothing appears to be stranded.
Could the changelog mention this change in which devices
ip_tunnel_delete_net() queues, since the last patch of the series
("ip_tunnel: Support per-netns device unregistration.") is where that new
behaviour is finally described?

>  
>  	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
> -		struct ip_tunnel *t;
> -		struct hlist_node *n;
>  		struct hlist_head *thead = &itn->tunnels[h];
> +		struct hlist_node *n;
> +		struct ip_tunnel *t;
>  
>  		hlist_for_each_entry_safe(t, n, thead, hash_node)
> -			/* If dev is in the same netns, it has already
> -			 * been added to the list by the previous loop.
> -			 */
> -			if (!net_eq(dev_net(t->dev), net))
> -				unregister_netdevice_queue(t->dev, head);
> +			unregister_netdevice_queue(t->dev, head);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907225846.3787676-1-kuniyu%40google.com
