Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0327E1DC;
	Thu,  8 Oct 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459284; cv=none; b=VxoJY/p40giqCSNKY+6ZA0FRolJrvuGI8dYX3qhtizs4ZRKDZKA8Fk3aEOzYaSUTTnPk3UfAlQTiHHtEo0jP8kIxFclYI2zKkgATe8TbEmFoah4pSfDgBKBES5FWX3i5HjTtlb0IEzuSzcOEGi6QQyiBWKiLMXZ3xvH1616lBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459284; c=relaxed/simple;
	bh=UbWRzl5XFH6Q3EkEmD8i3AMbqZ6U77PcasiZGagIt+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+koKHoSyriS6PJWXTzoALAPRFTNg2CAuREca04ETrY/UuoBcGrgPnba+w25Z6HlsRE99KWBkkaNGFVYy0k7/f64Yh68jjQ93JFDqWlVQ9rB9Pq4wKCkKmUjhJ2CKnvWK0iEYKFskDsrC2SvHTAFJin7WVcFfSyLR3cqyZTacw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A65EE463AE;
	Thu, 08 Oct 2026 13:34:40 +0200 (CEST)
Date: Thu, 8 Oct 2026 13:34:38 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hangbin.liu@linux.dev, 
	Stefano Salsano <stefano.salsano@uniroma2.it>
Subject: Re: [PATCH v4] net: ipv6: seg6: report lwtunnel setup errors via
 extack
Message-ID: <asd_pt-If2-nWLgA@luna.proxmox.com>
References: <20261005140637.644840-1-g.goller@proxmox.com>
 <20261006174348.b62a0e824aa8acfbf187e4c5@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006174348.b62a0e824aa8acfbf187e4c5@uniroma2.it>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791459280051

On 06.10.2026 17:43, Andrea Mayer wrote:
> On Mon,  5 Oct 2026 16:06:34 +0200
> Gabriel Goller <g.goller@proxmox.com> wrote:
> 
> Hi Gabriel,
> 
> thanks for the v4. +1 to Jakub on _MISS. I also have two comments on
> the message text.
> 
> > [snip]
> >  	switch (tuninfo->mode) {
> >  	case SEG6_IPTUN_MODE_INLINE:
> > -		if (family != AF_INET6)
> > +		if (family != AF_INET6) {
> > +			NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> > +					    "inline mode requires an IPv6 route");
> >  			return -EINVAL;
> > +		}
> 
> This message is also returned for an IPv4 nexthop object, where there
> is no route, for example:
> 
>   ip -4 nexthop add id 1 encap seg6 mode inline segs fc00::1 dev dummy0
> 
> What about "inline mode requires the IPv6 address family"?
> 
> > [snip]
> >  	/* verify that SRH is consistent */
> > -	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
> > +	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
> > +			       false)) {
> > +		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> > +				    "invalid SRv6 segment routing header");
> >  		return -EINVAL;
> > +	}
> 
> A nit: the same header is "SRv6 segment routing header" here and
> "SRv6 SRH" in the other messages of seg6_build_state(). What about
> using the name from the title of RFC 8754 in the extack messages,
> for example:
> 
>   "invalid SRv6 segment routing header"
>     -> "invalid IPv6 Segment Routing Header"
> 
> Thanks,
> Andrea

Agree with everything
Thanks for the review!

Gabriel

