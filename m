Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864EE517BAE;
	Fri,  2 Oct 2026 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972704; cv=none; b=S0Ty8Zt52jpWmvxE7z1wARqB0Vz8Jfwcmu0D83aLAiqXgeJaK1IWW8KIP/TNcEaaITnAwpdZhxhSJt+6nqeHdV3Xt0mjEh+mBI150nYjcLWviNfUF3ElGJvSP0oepVU6m2QAsi2+Ulz16abjVZdcNKSsd4azxBWcfeZYhJrncRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972704; c=relaxed/simple;
	bh=uaZ5ZUpxnAJZSq0y7WbXPyHu8ZspWDAP/NwiHSAWu7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1RrH9yINlH73+bU8OCDQ5d1y6GS8txALv0lz6+v0otkqPsLGmoeMJUo24SeE8htTeP1fraQtTz0DTIAgaIabWHfGQeYWrXQZ4idGdJc8pHcPk7tyWXEwIfYKRBFkoCXFaHugBFCeBJUehbQ1ZF8FE7N4V5R5IBHUbl9uhzFPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkJmwzKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkJmwzKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110FE1F000FF;
	Fri,  2 Oct 2026 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790972701;
	bh=kn+bD+5n0SAyF2Hhug0xwF3x4YLIO8j2A2QJrUJy27w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UkJmwzKX8bs4tztewSsT1dX7+nuLMUaC1Pp49gjvJ+kJS6+opKLWlvXohmk2kd8Dw
	 qy/bGBS2u8W3T5y/N1AblOIkviKM+Y42mYdddFTRRKzQom57j/MQAMitTEFNJScK97
	 1DWOWledPPsmUOOFyqdaHgA3lq+y0Ty+8GspRg/W+7TgXAAiILbq/IkVCGwrYx3bdZ
	 YRajHZMgEkFQorhunc7DJ7sy6HxrM+wyVJdF2PHDlrjACyQnyGWV5ezgLnEYKEgOS4
	 xRFlkJ9L/ZOFsqf/rRH1ljMlYWukf94PFsJyK9qRkOVm1I1+wfCoStrjTIrQ1X9vnu
	 1pxLLHJD8+IaA==
Date: Fri, 2 Oct 2026 13:25:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>, "David S. Miller" 
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni 
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter 
 <donald.hunter@gmail.com>, "open list:NETWORKING [GENERAL]" 
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] wifi: nl80211: document sta-info nested
 attribute
Message-ID: <20261002132500.0b71889b@kernel.org>
In-Reply-To: <7fc3e2730ebea674abf750a39c53d6ee307a907e.camel@sipsolutions.net>
References: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
	<20260817084713.7a7694d6@kernel.org>
	<6ae7fd5e4d24bdeb0f0df057f767107e08567640.camel@sipsolutions.net>
	<7fc3e2730ebea674abf750a39c53d6ee307a907e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Oct 2026 19:34:19 +0200 Johannes Berg wrote:
> On Sat, 2026-09-05 at 09:46 +0200, Johannes Berg wrote:
> > On Mon, 2026-08-17 at 08:47 -0700, Jakub Kicinski wrote:  
>  [...]  
> > > 
> > > Hi Johannes! Should we add this file to wireless in MAINTAINERS?
> > > Or do you prefer for us to handle the YAML stuff directly?  
> > 
> > Not sure, we don't really seem to be using it for all I know, and so
> > it's just been getting some random updates like this, I guess.
> > 
> > I think I tend to prefer the status quo, but I guess I could also just
> > apply patches to it if you prefer.  
> 
> So that's what I said a month ago, but because Jouni prodded me about
> our inconsistent documentation today, I actually looked at converting
> *all* of nl80211.h and our hand-rolled policies to be generated.
> 
> It ... takes some work, and ends up being 12k (!) lines of yaml, vs.
> today's 7.2k of nl80211.h and ~1k policy in nl80211.c.
> 
> It also requires a bunch of changes to the tooling:
> 
>  - kdoc comments for attribute-set enums
>  - exact-len-warn check
>  - validate-fn check support and creating their prototypes
>  - combining min-len/max-len for binary attributes
>  - strict-start-type support
>  - flag to generate the whole attrs without linking them from ops
>    (otherwise we get even many many more lines of yaml)
>  - NLA_NESTED/indexed arrays support
>  - allow nesting the global policy into itself (yeah ... I want some of
>    what we were smoking ;-) )
>  - allowing inheriting different members for kernel policy side
>  - drop nesting when subset overrides type ... not even sure how to
>    explain this right now
>  - option to define only policy, not ops
>  - allow taking ops IDs from an enum, because our ops don't match the
>    ynl ops too well
>  - enum-max-name for definitions to adjust naming
> 
> There's a license issue - we have ISC license on nl80211.h now, but
> Donald and Hilal picked GPL/syscall/BSD-3 for the yaml and of course

That license is required for all netlink specs, FWIW
It's totally my fault if it's wrong, I just didn't want it to be
_just_ GPL since that would propagate to use space code which
we want to be permissive about. The spec is effectively a uAPI
description it should be public domain in my non-layer mind.

> that carries over to the generated .h file, not sure if that's an issue
> for downstream projects but might be with advertising clause? Could we
> change it if I'm adding >10k new lines from nl80211.h? :)
> 
> I can post it but ... is it worth it? Not even sure it would
> significantly simplify our lives, although the generated header file
> with documentation is much more regular in that it always has the type,
> etc. (which is what Jouni was asking about)

Well, I certainly don't care so my choice would be not to have to review
the code gen changes (:
