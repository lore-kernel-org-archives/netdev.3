Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29206284883;
	Thu, 21 May 2026 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387692; cv=none; b=TT/M9fPuY8O1vTFfnqOAXBRQJK+4gWJ6VDHaC6RHPsg3Oe4HOMz7UPcp0NN0lA31OyfLtyKnnUe8YU+MPFhlteqvnFh9uJ6ImK9LUUCEhiozzNdrelrhD1aB/f8ie3U7kttgx2CLD9Y7sDa2a7m8WuBJ0/nAXp2OOgjJsQjAW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387692; c=relaxed/simple;
	bh=Fc4XkOkC2fsDeUNBZj2hrWOfkqoHNR8tJ/rnr3cg6RU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ti70urnYdtiDAUwL/tW8qsqeOAsQC29nAa7DZM8gJ7WNoiv1GRzpRFZOOH/5gCmWGZnnBXmo13Oe+h2xrkDN1XgQb4LYuYTEZvt/RiWAAH/ghg1a7qx2QbyD0Ut67JXcoF0mqwFmSqpVN6dGrwv3wN+znAWl/3QAfdxMyNrNAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=1O0IsQDo; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ivQQvNyQ; arc=none smtp.client-ip=160.80.4.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="1O0IsQDo";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ivQQvNyQ"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 64LI94ZD007631;
	Thu, 21 May 2026 20:09:09 +0200
Received: from lubuntu-18.04 (host-95-246-236-184.retail.telecomitalia.it [95.246.236.184])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 935E8122966;
	Thu, 21 May 2026 20:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1779386940; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v06rNKHtTTqzGVOju0eVLf+KwCO60KxfyXnQ3HX/rMs=;
	b=1O0IsQDoyRhMM7y8Z6vW4ggZLMDM+Po9W7d4iwBf/5XDu8R00X7Ruv4bwvkIJEHv6rgqeC
	STSp1gFOhfd8GpCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1779386940; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v06rNKHtTTqzGVOju0eVLf+KwCO60KxfyXnQ3HX/rMs=;
	b=ivQQvNyQ0da8dycES18w6SfY8J9bGsN2Dq87/U+MFYw4KGppU1oxZA8voYzfwXWjN8k4Xx
	mCzvvl3dMMAs6gy+qvaln7uLYKJim7Ids7XYjl80Rik70lBYLiK/DSen7vkI2CjO9VbLi1
	5XB5Y3jKo5+HdERYpK7YMbW48BnaG3p2erGTutqxddrjOdeNBZUcPVpPDHz5ELixJiJyAi
	k/MNqnDWB3fIuANlp6NSyj4Hr0tazDCvsaeAQhmnfT+Ig3GsIeDYtqIdKQKkTpk/uv+cwa
	04zU7AYSqhv80D+2fhdI2lHhha8EBaxQ8m1PTGfGdUfvUzt24/7iWRWB9b+m+w==
Date: Thu, 21 May 2026 20:08:59 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, idosch@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
        justin.iurman@gmail.com, bestswngs@gmail.com,
        stefano.salsano@uniroma2.it, stable@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in
 ipv6_rpl_srh_rcv()
Message-Id: <20260521200859.816b8923b5f27bba6124461e@uniroma2.it>
In-Reply-To: <ddefecf4-0a2f-4382-99a9-26012f9e943a@kernel.org>
References: <20260518140630.24280-1-andrea.mayer@uniroma2.it>
	<ddefecf4-0a2f-4382-99a9-26012f9e943a@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Mon, 18 May 2026 08:18:56 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 5/18/26 8:06 AM, Andrea Mayer wrote:
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index 03cbce842c1a..a4af6e63349c 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> >  	u32 r;
> >  
> >  	idev = __in6_dev_get(skb->dev);
> > +	if (!idev) {
> > +		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
> > +		return -1;
> > +	}
> >  
> >  	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
> >  			     READ_ONCE(idev->cnf.rpl_seg_enabled));
> 
> ipv6_rpl_srh_rcv and ipv6_srh_rcv are both called by ipv6_rthdr_rcv and
> both of these functions check idev. Moving the check to ipv6_rthdr_rcv
> which already has an idev lookup would simplifying both paths -- and set
> the drop code reason the same.

Hi David,

thanks for the review. I went through the code to plan v3, and I'd like to
share a couple of points before sending it, in case I'm missing something.

ipv6_rthdr_rcv() seems to already tolerate idev == NULL. The per-device
accept_source_route read is wrapped in "if (idev)", and all
__IP6_INC_STATS() calls go through _DEVINC(), which is NULL safe.
The code after the switch:

  [...]
  switch (hdr->type) {
  case IPV6_SRCRT_TYPE_4:
      return ipv6_srh_rcv(skb);
  case IPV6_SRCRT_TYPE_3:
      return ipv6_rpl_srh_rcv(skb);
  default:
      break;
  }
  [...]

falls back to the "default: break;" path, which only uses idev through
those macros. For this reason, I think an "if (!idev) drop" at the top
would change the behavior of the default path. So if we want to put the
check on idev in this function, the check would need to go inside the two
switch cases.

Both the callees in the switch need idev to read the per-device sysctl
(idev->cnf.seg6_enabled, idev->cnf.rpl_seg_enabled). To remove their own
__in6_dev_get() they would have to receive idev from the caller.

Two possible shapes for v3, both pass idev to the callees and remove their
own __in6_dev_get() and NULL check:

(a) Check inside the two switch cases with goto to a "disabled:" label at
    the end of the function (same style as the existing "unknown_rh:"):

      switch (hdr->type) {
      case IPV6_SRCRT_TYPE_4:
          if (!idev)
              goto disabled;
          return ipv6_srh_rcv(skb, idev);
      case IPV6_SRCRT_TYPE_3:
          if (!idev)
              goto disabled;
          return ipv6_rpl_srh_rcv(skb, idev);
      default:
          break;
      }
      [...]
      disabled:
          kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
          return -1;

(b) Single check before the switch, only for the two types that need
    idev:

      if (!idev && (hdr->type == IPV6_SRCRT_TYPE_4 ||
                    hdr->type == IPV6_SRCRT_TYPE_3)) {
          kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
          return -1;
      }
      /* switch unchanged, idev passed to the callees */

Both change the signatures of ipv6_srh_rcv() and ipv6_rpl_srh_rcv().

Any preference, or a different approach in mind?

Thanks,
Andrea
