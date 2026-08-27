Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7B448BA4
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837030; cv=none; b=uYpBScbAX3F7WMAtifrnc7GBcuf0ifJxJ28O/u7Twm4Hwt7SEbFvD5Clh7SaE1A7BH3fZKLUQvN5AGnYYWYFrcpJBJypwEw5UllF9RQwRpDP6RauPI+YXpKb2VNC4LXcGpMLEip5QpwCan7GjsoXhEomlOjyea+n3agpKUCX7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837030; c=relaxed/simple;
	bh=lFuP0YWh1r+w7r6g8Vw7y9JWTkVPZDJAy867PC78g6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T34ShdqeuKSxBaBX2kMmn77PhaRHhRawk4hJDRGnmmlTrz6oxW7xmS0O5vsGVw5GqL5bPPCwCZLb6QcgXTd4luoznEFXAzDadyZz21Pk1MpQyh5JBakxXf/LfpLPlCS8x3OD51hM9RltYjbE/OFDV8dQkko8KZpLomDBf5+5Myg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D8955602F5; Thu, 27 Aug 2026 15:23:35 +0200 (CEST)
Date: Thu, 27 Aug 2026 15:23:33 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
Message-ID: <apA6Vaei3-GEXEWz@strlen.de>
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
 <ao9UV9S7rUkyQ8jv@strlen.de>
 <73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com>

Paolo Abeni <pabeni@redhat.com> wrote:
> > Yes, initially this was krealloc()'d area.  But the other assumption
> > was that most skbs will carry no extension at all, or, in some configs
> > one maybe two (IPsec gateway for instance).
> > 
> > Thats why the first added extension is also at the beginning of the
> > memory blob (that needs to be accessed anyway), regardless of the ID.
> > 
> > I don't insist on keeping offsets[], if you feel like microbenchmarking
> > different use-cases to see if it makes a difference to have a fixed
> > memory layout feel free to explore that.
> 
> Both options for different skb ext layouts save a few bytes from the
> final `struct skb_ext` size. This is IMHO quite relevant as the total
> size is approaching the memory partition size (IIRC it's almost 256
> bytes), and the bpf ext could make skb_ext require the next one (512).

We're close to the 8-extensions limit (u8 id), the total blob size can
be 2k, as offset is in '>> 8' units.

> Still WRT optimizing skb_ext size, I think that it should be feasible to
> optimize the layout proposed by Florian by taking in account that some
> exts are 'mutually exclusive' i.e. on top of my head mptcp and bridge
> should never be attached to the same skb, and I *guess* can_skb_ext is
> mutually exclusive with most of the others.

Yes, there are extensions that are expected to be mutually exclusive,

> The layout could be adapted to such constraints, and there could be
> run-time checks (under DEBUG_NET) to verify such constrains at skb_add
> time leveraging `present_extensions` and a static matrix describing the
> mutual exclusive status for all extensions.

Yes, simple union this, union that, is too fragile, skb_ext_add will
have to check and reject as you say.

OTOH, I think this is orthogonal to what Jakub S. needs for the BPF
extension.
