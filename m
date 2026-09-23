Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402DE48551E;
	Wed, 23 Sep 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164603; cv=none; b=iBs/wch59rvOpWAvYu1qBJoQZ1oNhfzmAQSzyHdunQlE60Hlrmx4+ZG1xs+dWtma/Afl9YumSTIFVFnrtPG+PTjRkSMfWZUT2f293WbCSa0j1TUjgywHhKLaB1uOnXD1Ap8yu4rxIIo3ait8cVXCD0oiatkkLDmN+iDJUQMI/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164603; c=relaxed/simple;
	bh=We7NgzQwtsNbCxfyRaUPGGqyimzQkwvuqflDwRnelaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Ap0m2CsnvqXNP5f9JyJ4muznS7PfzGlhgp2dxRy1yyKAJZ8lEtG397wZTwPWeVfw3Zzd3kOLvDxDoKxVhL1dQk1uQ/36kiZHs6fnRLgXivjrO44i4FlqqScT5g6MV44dQxiE4QHxsnbH/u/hEk4kYVlfXz5rXeOcsu2VNF97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5841742E97;
	Wed, 23 Sep 2026 13:56:23 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:56:21 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-ID: <arO-Py5YwB9jSfwG@luna.proxmox.com>
References: <20260922090851.38978-1-g.goller@proxmox.com>
 <20260922234958.9ccce91258707b88fbca9728@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922234958.9ccce91258707b88fbca9728@uniroma2.it>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790164582558

On 22.09.2026 23:49, Andrea Mayer wrote:
> On Tue, 22 Sep 2026 11:08:33 +0200
> Gabriel Goller <g.goller@proxmox.com> wrote:
> 
> Hi Gabriel,
> 
> > seg6_build_state() rejected invalid configurations with a generic -EINVAL, so
> > "ip route add ... encap seg6 ..." always reported "Invalid argument".
> > 
> > Attach an extack message to each of them. The checks themselves and their return
> > values are unchanged.
> > 
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> 
> The commit message stays in the changelog, so wrapping the body at 75
> columns would be better.

Done, thanks.

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
> 
> checkpatch flags this line ("Lines should not end with a '('"). The
> two-line form used in the rest of the file would be better:
> 
> 	NL_SET_ERR_MSG(extack,
> 		       "unsupported address family for SRv6 encapsulation");
> 
> The string goes a bit over 80 columns but should stay on one line for grep.

Fixed this.

Thanks for the review!
Gabriel

> A side note: the source_inline bot failure looks like a false positive,
> the script matches "inline" inside the string literal.
> 
> Thanks,
> Andrea
> 
> 

