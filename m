Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCF42F709;
	Mon, 21 Sep 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988996; cv=none; b=h1aW7CGiGhForExt/hRIFeqJ/17dGt8Gy6WAz/EThL+9QyF6u1kLqQDjY2Wy+ayiH2aRGQua7MZeVOkWGlHmQNhwL0D/CVJCz58ggtUs/xwJNChvWmIB89MUnfJwYgwli66U5W7IjNeX1oh15sPylOYUBqSeqwBnxGE/M35vcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988996; c=relaxed/simple;
	bh=Q8gJqCIgi+pxa0KnX6JaLruSoUbY0JF7Il1toHFsN54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+6LTYKXWL2lFD/z0itxo7HNck2pEAr1DW8u6xwx3qEaLJ+kdSE3RcY3MArB65nTCPiA9iV/RGWqdDPespURtAQ4b5s0BiHaUZoK46fbG9WmivRUepE/t06ME1O4HvU/tW66DGRDOACY68XCR90TklAsGu4uJeurZ4C4lEcJ2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E264E40C61;
	Mon, 21 Sep 2026 13:09:45 +0200 (CEST)
Date: Mon, 21 Sep 2026 13:09:44 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: fib: treat an unbuildable encapsulation as a
 nexthop mismatch
Message-ID: <arEQHeBlqKWCu3l5@luna.proxmox.com>
References: <20260918152836.1173368-1-g.goller@proxmox.com>
 <20260920090818.GA1846216@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920090818.GA1846216@shredder>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1789988985117

On 20.09.2026 12:08, Ido Schimmel wrote:
> On Fri, Sep 18, 2026 at 05:28:33PM +0200, Gabriel Goller wrote:
> > fib_encap_match() builds the requested lwtunnel state and compares it
> > against the nexthop of a candidate route. When lwtunnel_build_state()
> > failed it left result at 0, which is interpreted as "the nexthop
> > matches", so fib_nh_match() continues to compare only oif and gateway.
> > 
> > So if there comes along a RTM_DELROUTE which carries an encapsulation
> > the kernel rejects, it could delete a different route with a different
> > encapsulation.
> 
> Did you hit this in practice? Can you share details?

Nope, found this in the code while writing
https://lore.kernel.org/netdev/arD-5t6LiBiPXAAa@luna.proxmox.com/

> Note that the modern alternative is to install nexthop objects with
> encapsulation and then associate these objects with routes.

Yep.

> > Fixes: 571e722676fe ("ipv4: support for fib route lwtunnel encap attributes")
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> > ---
> >  net/ipv4/fib_semantics.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> > index 50e96f86ca59..951e48ae87da 100644
> > --- a/net/ipv4/fib_semantics.c
> > +++ b/net/ipv4/fib_semantics.c
> > @@ -911,17 +911,17 @@ static int fib_encap_match(struct net *net, u16 encap_type,
> >  			   struct netlink_ext_ack *extack)
> >  {
> >  	struct lwtunnel_state *lwtstate;
> > -	int ret, result = 0;
> > +	int result;
> >  
> >  	if (encap_type == LWTUNNEL_ENCAP_NONE)
> >  		return 0;
> 
> This is also "unbuildable", but will match.
> 
> lwtunnel_build_state() returns an error in this case, so you can just
> remove this check.

Makes sense, will send a v2 soon.

Thanks for the review!
Gabriel


> > -	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
> > -				   cfg, &lwtstate, extack);
> > -	if (!ret) {
> > -		result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> > -		lwtstate_free(lwtstate);
> > -	}
> > +	if (lwtunnel_build_state(net, encap_type, encap, AF_INET, cfg,
> > +				 &lwtstate, extack))
> > +		return 1;
> > +
> > +	result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> > +	lwtstate_free(lwtstate);
> >  
> >  	return result;
> >  }

