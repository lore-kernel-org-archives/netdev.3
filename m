Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A203E5581
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462600; cv=none; b=ErLvAyZT3BvJFwK09ITlagrFZTxva4Tg0YlpXbYEcBOZeKGWiLzhLF5hYxkECs21CW29Tw4hmVPa17VrHpIbXwojYc/mPX8Hg5bpLPDTGrzF7jWZU/0vq2em1ORrsTJoP8q4wedZDjeZSo6TzCjw0ZEVivPJlGGcc0BGWETqBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462600; c=relaxed/simple;
	bh=HyZ/X+XkjYMqup66IEVA1KUZDRvk694MUw+2hwZ/CIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqPdbjVzPw9mxPQFwaFRzCCmHZRS4xlDTNpUm0amxMHfUHpCIng+UP9usodwYww9xAEusXoYdXY0Ce6njkn2ftl5gfmUUOzB+Cv6mGnaPxwM98hpZ3OeWV5eSAj3Wt7u+ceYPUmlU4xCCMlFnweuZuyyi1EU0EcwBHYFYnhmI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNUQdBxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNUQdBxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFBEC19423;
	Mon,  2 Mar 2026 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772462599;
	bh=HyZ/X+XkjYMqup66IEVA1KUZDRvk694MUw+2hwZ/CIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNUQdBxF+L+WpkeliCDi37gjxI2Xxcb+C6qKxF8j6gFPpm1oYuWAP9DJyjhj9xXdd
	 JIwwAa8dAle6+q6/zxaonsxTd5IyqJfR7cIBbvWO/yJEQBcKaCr3Td/g9c0lJAh6Ve
	 S47m3S3kkhJhy+LcRM+l4JbetZObLJ08U+SDadjMzZ7ZD2uEVA228LtFpI/PXk0/vL
	 lUF97JrH6q7OZK73yQwXwB49PcTt+gFUmNMoLgw488wWjM19qrMYFV8C8WCpBItGHm
	 wC4iJxYqvDt0dNPJtoNjpgj5kaH+kfQH1tAlMkQsdt8Fevl9nRIDWRmKi0NZnGNBXt
	 SGJox18ymFoVA==
Date: Mon, 2 Mar 2026 06:43:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net] ipv6: fix NULL pointer deref in
 ip6_rt_get_dev_rcu()
Message-ID: <20260302064318.6d55533d@kernel.org>
In-Reply-To: <859d39ff-cb1e-4f3f-b154-d8bf2c7997c9@kernel.org>
References: <20260301194548.927324-1-kuba@kernel.org>
	<859d39ff-cb1e-4f3f-b154-d8bf2c7997c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Mar 2026 18:38:53 -0700 David Ahern wrote:
> > @@ -1063,7 +1063,8 @@ static struct net_device *ip6_rt_get_dev_rcu(const struct fib6_result *res)
> >  		 */
> >  		if (netif_is_l3_slave(dev) &&
> >  		    !rt6_need_strict(&res->f6i->fib6_dst.addr))
> > -			dev = l3mdev_master_dev_rcu(dev);
> > +			dev = l3mdev_master_dev_rcu(dev) ? :
> > +			      dev_net(dev)->loopback_dev;  
> 
> how can the flag on the netdev say there is L3 master, yet the device
> not be there within an rcu window?

1) We call netif_is_l3_slave() twice, once here and then again in 
l3mdev_master_dev_rcu(), the flag may get cleared in between the two.

2)

static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
{
        netdev_upper_dev_unlink(port_dev, dev);
	// No sync RCU here, also I'd say the order is inverted?
        port_dev->priv_flags &= ~IFF_L3MDEV_SLAVE;
