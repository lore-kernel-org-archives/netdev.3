Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642804A2A72;
	Wed, 23 Sep 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164609; cv=none; b=t1UGiwW7wGYXZTAU/02CtN0peVScpKfTL18c4KdKvYHVC0utCN+nQxb1KsThBp1wD26fFnjlub2X26VbYTVq4ni6T+jXLgaZugryJ3Z2PfK+B+qen1vipC/as8vkgwJiOESLl6EepBqr3HtCRLAK/gc9MuaTrrZ09JdZyo1ZljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164609; c=relaxed/simple;
	bh=afaBJ6mCYH0zbNHT0R8lQV7VKGosfVD8AH+q+7W0y8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtBYmOzQLT5YGlY2O36dziIHzqWw/fMCbQh+eJb3d2c9deDfZaUjVMpGDNteICyQuMLK5Vv6VWy011yw1aLSLitgvFLV20z01TkhotvdDhBYCI6BHC0MV4BPZV7p+QUl6ZpSdWRRDCuYpbOjK1ktRcxXjLd0to+mub4+k5R1OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2A6D24245E;
	Wed, 23 Sep 2026 13:56:38 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:56:36 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-ID: <arO-aZBEgt5Jtg2d@luna.proxmox.com>
References: <20260922090851.38978-1-g.goller@proxmox.com>
 <arMrh_SqjKz2PqlR@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arMrh_SqjKz2PqlR@fedora>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790164597337

On 23.09.2026 09:29, Hangbin Liu wrote:
> On Tue, Sep 22, 2026 at 11:08:33AM +0200, Gabriel Goller wrote:
> > seg6_build_state() rejected invalid configurations with a generic -EINVAL, so
> > "ip route add ... encap seg6 ..." always reported "Invalid argument".
> > 
> > Attach an extack message to each of them. The checks themselves and their return
> > values are unchanged.
> > 
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> > ---
> > 
> > v2 (https://lore.kernel.org/netdev/20260918153544.1178884-1-g.goller@proxmox.com/):
> >  * dropped tests
> > 
> >  net/ipv6/seg6_iptunnel.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> > index 61c6a27bf202..e7f75970e26e 100644
> > --- a/net/ipv6/seg6_iptunnel.c
> > +++ b/net/ipv6/seg6_iptunnel.c
> > @@ -756,8 +756,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
> >  	struct seg6_lwt *slwt;
> >  	int err;
> >  
> > -	if (family != AF_INET && family != AF_INET6)
> > +	if (family != AF_INET && family != AF_INET6) {
> > +		NL_SET_ERR_MSG(
> > +			extack,
> > +			"unsupported address family for SRv6 encapsulation");
> >  		return -EINVAL;
> > +	}
> >  
> >  	err = nla_parse_nested_deprecated(tb, SEG6_IPTUNNEL_MAX, nla,
> >  					  seg6_iptunnel_policy, extack);
> > @@ -765,8 +769,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
> >  	if (err < 0)
> >  		return err;
> >  
> > -	if (!tb[SEG6_IPTUNNEL_SRH])
> > +	if (!tb[SEG6_IPTUNNEL_SRH]) {
> > +		NL_SET_ERR_MSG(extack, "missing SRv6 SRH attribute");
> 
> I think we can use NL_SET_ERR_MSG_ATTR.

Done, thanks!

Gabriel

> 
> Thanks
> Hangbin
> 
> 

