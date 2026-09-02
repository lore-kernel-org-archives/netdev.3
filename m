Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA653D6486
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357817; cv=none; b=fHFxWIzHqs14/kcsj7gkmRTGiXW/cN1FvZUobMlhc6U+UMUzIzhZb2qQD5uQwhgXGt8/Mt6zaWq538xJT0bN27n0mnHpKlUlfeyyjoRiB3OrIGtJnrwUIoPYfcEfj23/kLQLcaYE98oavr+Z43ippUBd4VyCm3q2sjRzpa/yAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357817; c=relaxed/simple;
	bh=8N8tVHdiZpOE1fmV/9ODf0DNf/74uPA6aNJNG92EQqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfz8lfGN0ObecAVZqRONeUZ7Y1DbUveJwT80FiT2x7mQzCYhL8PChwdn6ltj03ynQHzgzWO9buuC8CCv/5f2K0asexD0w/qe2FUEnRB2pk5FAy17KyUQQ7fDcXi/fIHpR7zIXAgWHnZ+a1kSMVPLAlSsAhrCmj1NUc68C+/ptZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4EE7A6032B; Wed, 02 Sep 2026 16:03:30 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:03:29 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 1/2] net: Make skb_ext_put_sp() idempotent
Message-ID: <apgssShsin58AF6k@strlen.de>
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
 <20260831-skb-ext-prep-work-v1-1-ecc2a8542fd9@cloudflare.com>
 <20260901171520.072acdd2@kernel.org>
 <87ld9k2oaq.fsf@cloudflare.com>
 <0d3f33cf-d1db-451b-a4a6-25b22fd9bb5b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3f33cf-d1db-451b-a4a6-25b22fd9bb5b@redhat.com>

Paolo Abeni <pabeni@redhat.com> wrote:
> I'm a little late here, but it looks like sashiko cataloged as 
> pre-existing a couple of issues that on top of this series can new 
> lead to memory corruption:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9%40cloudflare.com
> 
> Could you please have a look?

Very convoluted report.  skb->active_extensions should govern the 'do I
put internal refcounts for ipsec/mctp', not offsets[].
