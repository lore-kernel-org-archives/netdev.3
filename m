Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1337EFE1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650371; cv=none; b=HhUEHmz7BQC06PT8heG1VqwG7tzbBTVJg8VZ0WA1lNiX9b59PBcMmDkFcKyiZpROdccgUo7YzjQkheVa+aY31qK5oUS25/6RyP1WM7sEagcIHU5Hy7AKXsvjnvB7TcXTJqNNY1LPyYbJk+ZxQ3gER8Fi9/evPhI+l/1J/KymMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650371; c=relaxed/simple;
	bh=jfZ9SPI8y5EvWDZMkRNIS5X1X8C04jIQvj5cE3XV3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5O0c8ZEoCqnnT6WoGpo105H6Pde+L0wrca8gbacN4V3C55QOERMfsHEDnnKPUAi9cgEJu6nd/ZxNm5qPG2TXFoJ4rHerAGQcRxxmkEFaHsYied4skL5/tEviZsn6znF0mrdaR4+2MQ9NIt2FkFHNRWkpVXfKdjc2EN94IIi5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKz6NbW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKz6NbW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E043C4CEF7;
	Wed,  4 Mar 2026 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650370;
	bh=jfZ9SPI8y5EvWDZMkRNIS5X1X8C04jIQvj5cE3XV3dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKz6NbW5H8x2F8MziSvX7uqQ26rNtcggBTMCeYXN0ngj3nyS6wwy4ykSSTqo4a4Zt
	 b9Y3c/oyMmnFfuY//9xG0hBfkm37WrsJpF5JW1l9Neo3MoxcBuxjlsGgznCcxe2jxq
	 ZPKZNxwkTVGyW3IALWiVHYiQnJDgjQjfdHmFnRHJ4v+lAWuIZo6c95gJ4FAGEDWbwC
	 hgzCxh+iX+Dwhmz0Kk013MY9l7ERN/XpUANXuyw98caY7d7S4b6z2K7EGG9Lw/Btdr
	 yKXR205qfkcBuAu3/kHAedQ4zBjEkqh+QmQaEZfaOPACmBb1Tmg7kwChhWaJDhRa72
	 pIhXO/daR24Qw==
Date: Wed, 4 Mar 2026 10:52:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH net v3] ipv4: bump rt_genid when a relevant devconf
 value changes through netlink
Message-ID: <20260304105249.5752be3c@kernel.org>
In-Reply-To: <e773e5dc-b08c-4bc4-bfd6-95b6134e344a@suse.de>
References: <20260302130858.5197-1-fmancera@suse.de>
	<20260303183843.5b29d5b0@kernel.org>
	<e773e5dc-b08c-4bc4-bfd6-95b6134e344a@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 10:03:37 +0100 Fernando Fernandez Mancera wrote:
> On 3/4/26 3:38 AM, Jakub Kicinski wrote:
> > On Mon,  2 Mar 2026 14:08:57 +0100 Fernando Fernandez Mancera wrote:  
> >> +			switch (nla_type(a)) {
> >> +			case IPV4_DEVCONF_FORWARDING:
> >> +				if (nla_get_u32(a))
> >> +					netif_disable_lro(dev);  
> > 
> > why not dev_disable_lro()??  
> 
> dev_disable_lro() takes netdev_lock_ops() but when handling IFLA_AF_SPEC 
> at net/core/rtnetlink.c:3320 we are already holding netdev lock ops. So 
> we need to call netif_disable_lro() instead.

Makes sense

> >> +				fallthrough;
> >> +			case IPV4_DEVCONF_NOXFRM:
> >> +			case IPV4_DEVCONF_NOPOLICY:
> >> +			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
> >> +			case IPV4_DEVCONF_ROUTE_LOCALNET:
> >> +			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
> >> +				flush_cache = true;
> >> +				break;
> >> +			default:
> >> +				break;
> >> +			}
> >> +		}
> >> +		if (flush_cache)
> >> +			rt_cache_flush(net);
> >>   	}  
> > 
> > Looking closer at this I'm struggling to connect this to
> > devinet_conf_proc(). The attrs you're snooping here are completely different!?
> > Logic for when rt_cache_flush() happens is different.
> 
> So I was planning to to handle inet_netconf_notify_devconf() calls in a 
> follow-up patch to net-next because it might require some more changes 
> and also the missing notification shouldn't be net tree material IMHO.

Fair, let's call it out in the commit message, tho

> This is handling ipv4_doint_and_flush() which is used by 
> DEVINET_SYSCTL_FLUSHING_ENTRY() macro. But now that you mention it, 
> BC_FORWARDING and ACCEPT_LOCAL are part of devinet_conf_proc() while 
> they probably could go to ipv4_doint_and_flush().
> 
> In addition, I guess we should flush the cache only if the value 
> changed. I will add that bit too.

Thanks!

