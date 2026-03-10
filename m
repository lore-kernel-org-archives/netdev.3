Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C832E729
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170671; cv=none; b=fX+1o1EJ7/dRWhpPhQ6x51n5J7+3gCq4nxa0Li+Pc9lmiZ9e3GsqOh3h91ZSPqLicVebqSYE+lwzhX7Sk0XT8ASBemIV7c1MSThhcCMAT9+Tmw/wmvZerbCBE2tWRV5Imqmhr29wOSgvNapVXR73BvsAHF+ACCuvPEiUtAHLpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170671; c=relaxed/simple;
	bh=xJnlvt5OdQAmBlLJsE0BiVtPWT1lYBDx8Xr9RWtikaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV8XyUHj4DynKgE8MT7NynJp/zMrB07yn2sD/zpd0K43O27A4bLcL9gTv8VxX96MlQGzQUMeb5ZJtLcKjeA2JkPKmHSScZ2iDHTqK3v+fGKyC6tiATCcURQKwjSU+cHvZtKWxeha94IpcMhWeosd60ZMUjmODoRaKV2PnmjJGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0EB9B60516; Tue, 10 Mar 2026 20:24:27 +0100 (CET)
Date: Tue, 10 Mar 2026 20:24:27 +0100
From: Florian Westphal <fw@strlen.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <abBv6zR4Qq_lrzuC@strlen.de>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310182012.GF12611@unreal>

Leon Romanovsky <leon@kernel.org> wrote:
> > > This change makes me wonder why we need both xfrm_state_hold_rcu() and
> > > xfrm_state_hold().
> > 
> > Commit 02efdff7e209 ("xfrm: state: use atomic_inc_not_zero to
> > increment refcount") and the series around it [0] introduced the
> > possibility of that refcount increment failing.
> > 
> > I can't tell you why a 10-years-old commit made some choice, but
> > keeping both variants has the benefit of documenting that one
> > increment is expected to never fail (because we already hold a ref on
> > the object on that path) and we can skip the error handling. We don't
> > want to add error handling that will never get reached, it always goes
> > wrong (because it's untested) and it adds uneeded complexity to the
> > code.
> > 
> > So I wouldn't get rid of xfrm_state_hold.
> 
> So let's add some comment when this function should be used.

Before rcu-ification, everything was serialized via state lock.
Entries still in the state table thus always had > 0 refcounts.

You can only use xfrm_state_hold() if the refcount is already > 0.
xfrm_state_hold uses refcount_inc(), so you get a UaF warn splat
if this assuption doesn't hold true.
