Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B235493622;
	Mon,  5 Oct 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209261; cv=none; b=CWWaGiXHBP5PnL7KLgBzS4+TwQ1an872DGta07Bj96jZKK6sv09/Q9eA6cwaODe7mc3dJPQ4wZ9w+5JbIzIL6qLuN5ZoHSb/U/ca3anyC8QUeaz2hO0Fok01vHomWSiHs+uelr+2JSMujm+u9YrMtIGzxQRA0VVhKyuDuUXOYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209261; c=relaxed/simple;
	bh=cK5qrDph1P/G1BEJo/ML/xly0Oz0FIzZEATx0N+8QPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYlhnIqfgGKPuMVYv7MeBGvTOMRbYGrG/GpEx3YCnS6nmG8jabAqEbDDHeAsdiCHAfahAYE6pfwizFPwltpmetJkHDHJMpKdLYwcPScz6llhKiqWNs5qH04r50lPg1C4s7bJz0VxFp/pdfNeubMgI4O/EMlyrqt566A1CmdlSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E9082439B8;
	Mon, 05 Oct 2026 16:07:36 +0200 (CEST)
Date: Mon, 5 Oct 2026 16:07:35 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-ID: <asOu-Baq8F3DxqqC@luna.proxmox.com>
References: <20260923120228.172643-1-g.goller@proxmox.com>
 <arR9WwUQv5NReOyS@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arR9WwUQv5NReOyS@fedora>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791209256097

On 24.09.2026 09:31, Hangbin Liu wrote:
> Hi Gabriel,
> On Wed, Sep 23, 2026 at 02:02:04PM +0200, Gabriel Goller wrote:
> > seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> > so "ip route add ... encap seg6 ..." always reported "Invalid argument".
> > 
> > Attach an extack message to each of them. The checks themselves and their
> > return values are unchanged.
> > 
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> > ---
> > 
> > v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
> >  * format fix
> >  * use NL_SET_ERR_MSG_ATTR
> > 
> > v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
> >  * dropped tests
> > 
> >  net/ipv6/seg6_iptunnel.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> > index 61c6a27bf202..9f1aecc4f215 100644
> > --- a/net/ipv6/seg6_iptunnel.c
> > +++ b/net/ipv6/seg6_iptunnel.c
> > @@ -756,8 +756,11 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
> >  	struct seg6_lwt *slwt;
> >  	int err;
> >  
> > -	if (family != AF_INET && family != AF_INET6)
> > +	if (family != AF_INET && family != AF_INET6) {
> > +		NL_SET_ERR_MSG(extack,
> > +			       "unsupported address family for SRv6 encapsulation");
> >  		return -EINVAL;
> > +	}
> >  
> >  	err = nla_parse_nested_deprecated(tb, SEG6_IPTUNNEL_MAX, nla,
> >  					  seg6_iptunnel_policy, extack);
> > @@ -765,8 +768,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
> >  	if (err < 0)
> >  		return err;
> >  
> > -	if (!tb[SEG6_IPTUNNEL_SRH])
> > +	if (!tb[SEG6_IPTUNNEL_SRH]) {
> > +		NL_SET_ERR_MSG_ATTR(extack, nla, "missing SRv6 SRH attribute");
> >  		return -EINVAL;
> 
> My bad. NL_SET_ERR_MSG_ATTR expects the specific attr. In this error path,
> there is no tb[SEG6_IPTUNNEL_SRH]. So we can keep using NL_SET_ERR_MSG().

Agree.

> > +	}
> >  
> >  	tuninfo = nla_data(tb[SEG6_IPTUNNEL_SRH]);
> >  	tuninfo_len = nla_len(tb[SEG6_IPTUNNEL_SRH]);
> > @@ -776,13 +781,18 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
> >  	 */
> >  	min_size = sizeof(*tuninfo) + sizeof(struct ipv6_sr_hdr) +
> >  		   sizeof(struct in6_addr);
> > -	if (tuninfo_len < min_size)
> > +	if (tuninfo_len < min_size) {
> > +		NL_SET_ERR_MSG(extack, "truncated SRv6 SRH attribute");
> 
> And here I think we can use like
> 
> 	NL_SET_ERR_MSG_ATTR(extact, tb[SEG6_IPTUNNEL_SRH], "truncated ...")
> 
> >  		return -EINVAL;
> > +	}
> >  
> >  	switch (tuninfo->mode) {
> >  	case SEG6_IPTUN_MODE_INLINE:
> > -		if (family != AF_INET6)
> > +		if (family != AF_INET6) {
> > +			NL_SET_ERR_MSG(extack,
> > +				       "inline mode requires an IPv6 route");
> 
> Same here
> 
> 	NL_SET_ERR_MSG_ATTR(extact, tb[SEG6_IPTUNNEL_SRH], "inline ...")
> 
> >  			return -EINVAL;
> > +		}
> >  
> >  		if (tb[SEG6_IPTUNNEL_SRC]) {
> >  			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
> > @@ -798,12 +808,16 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
> >  	case SEG6_IPTUN_MODE_L2ENCAP_RED:
> >  		break;
> >  	default:
> > +		NL_SET_ERR_MSG(extack, "invalid SRv6 encapsulation mode");
> 
> And here.
> 
> >  		return -EINVAL;
> >  	}
> >  
> >  	/* verify that SRH is consistent */
> > -	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
> > +	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
> > +			       false)) {
> > +		NL_SET_ERR_MSG(extack, "invalid SRv6 segment routing header");
> >  		return -EINVAL;
> > +	}
> 
> Here.
> 
> Thanks
> Hangbin

Sent a new version, thanks for the review!
Gabriel

