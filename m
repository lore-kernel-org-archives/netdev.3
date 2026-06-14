Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7A2135B8
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395856; cv=none; b=qOSOwQTsHwqmFQBx7uQJvcem513AXxg/mqvheGTkDbbglmkKZf4g8qqCXhXzdXWUjyAZKzLLBSQsDuLR8dFm7TSWcbKt8zrxERKqAgx0kqzOofiylEM49VHfk1juTgFHeGGD+a7hMiUc1A8zgTEatYeI/WpFm7qqXqoeHLvjz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395856; c=relaxed/simple;
	bh=z3JPufBLKyPEG56l3ed0X93NQz8KsewzFS36we9xZbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXduaZkcuWqpnX9PcEWuo5dwu+8FlJ2T2mqMmyEqK1vq+UHJc/c5jQfKx9Aoc+SMxj8UaJmNC10CJafM6+/6bBJxw/BlMz92Rv64UD54i+TQ+zRcCM01GNIcEqer+NACd1IveOhh/Sfi7vrUtm8PBwcJbjJYG/Tf+zpOnuA0J60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/YSI3Mf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/YSI3Mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B605E1F000E9;
	Sun, 14 Jun 2026 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395854;
	bh=iVGWX8CTJMTSnQUUg8I8G4xd1w723/IV0/c/rDWcb4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m/YSI3MfUtuAFpISmhJxLo65XTHfWMA5E7z6oSE56efHUWRSfn9ov74DUSKYyjgOU
	 ZiQ/tk0jehzIMqmVpUW8Gpmp6ZHw7ViIianP6mYMuyjUe/Z1W2OErnDbROA05FbeIV
	 liKOl53qLu5a+Uyx06ZfaEWcL8N/uPbXJVYEOhBNC75XtODrkgrzsrZo+m6wBe9B7F
	 cdzIbDI6ENoUGsSGqkoHRqr8N+0AKdRIk4Q8IjPl/N5H29xG1Rr5JDzEmPtuS4RJ3j
	 RGjnTlwQJd5ruGt6FY0vQLcw8M4s5OFrMMtn7pj2kfFw1KqOXSnemSUmDOazj9ZYgt
	 vyzS/Cm/R63bA==
Date: Sat, 13 Jun 2026 17:10:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <20260613171052.0dbdfea4@kernel.org>
In-Reply-To: <CAPpSM+RuCaNoYFN7JKGDeUScK2-xLjSULA4i8bnChmG05hBaNA@mail.gmail.com>
References: <20260607031640.2743713-1-xmei5@asu.edu>
	<20260609183018.1764046d@kernel.org>
	<ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
	<20260613164820.491226a7@kernel.org>
	<CAPpSM+RuCaNoYFN7JKGDeUScK2-xLjSULA4i8bnChmG05hBaNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 17:02:39 -0700 Xiang Mei wrote:
> > >       if (data_len) {
> > > -             int nla_len = nla_total_size(data_len);
> > >               struct nlattr *nla;
> > >
> > > -             nla = skb_put(nl_skb, nla_len);
> > > -             nla->nla_type = PSAMPLE_ATTR_DATA;
> > > -             nla->nla_len = nla_attr_size(data_len);
> > > +             nla = nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
> > > +             if (!nla)
> > > +                     goto error;
> > >
> > >               if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
> > >                       goto error;
> > >
> > > Let me know if the new patch makes sense.  
> >
> > I assumed the author intentionally was avoiding the memset for
> > the memory we will override with data. Otherwise the whole dance
> > could be avoided and nla_put() would have been the answer.  
> 
> The reason nla_put() isn't used here is that the payload source is the
> sampled skb, which can be nonlinear, so the data has to be gathered with
> skb_copy_bits() rather than a flat memcpy().

That too.

> There is no nla_put() variant that takes an skb source, hence the
> reserve-then-copy.
> 
> But that doesn't require open-coding the attribute: nla_reserve() only
> memsets the alignment padding (nla_padlen), never the data region, so
> nla_reserve() + skb_copy_bits() writes every byte exactly once with no
> redundant memset over the payload. The bug was that the open-coded
> version dropped that padding-zero step.

I find it hard to believe that nla_reserve() was not considered.
It's a widely used function in the networking stack.
Please move on.
