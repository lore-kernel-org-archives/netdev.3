Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B553A8723
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267230; cv=none; b=VEfB758vmkFwNJeo4Dlzt5unFz5OLMURKKaWVucuLTznCstXk9RhuJqzWaV24vuHGdUsEsupd0oW0/+uEVjjeYK3Q07NLFQsaC7MPitBIbAEzfhLoh1w6DHMpd5N2gr8fM+m6xtbl6EN0RRD3yHmMwL2cUCjJB7cbumOHGWjRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267230; c=relaxed/simple;
	bh=Zsk6KxZbHV3X6/WKHrJG51DM0TlT9dXBLS+m8qe9cJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbIPDcE2X3EUoicvy4yQ1c8vA2Wt/Y8K5m4mabbUVe7xXqKPsieoBZ5sat29aRXMqJWLtbMDF5gllRc+eYldLrUlxglizvlab50/w/3EaiXSKIpH7DFihmOqQbbIVSj2t6p1L8wySgHXW7stbDIG2B8fZrDD2Z8zCq59gQPgkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=gdWJNPgx; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="gdWJNPgx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=+NjpIUu5xLL37mmfLFgILjEUcCwsTj4SWUNnT240/Vs=; 
	b=gdWJNPgxcDJHqpSY1w/qTAcr5VS1RknQyCELdVQZNWO1MNxtY7m0BOMSpn+hM1H/AbbGoor4ge/
	cMJzEQy5ePSrQAblKz+AGPIR0ZvSO0oft3efSdbIi7cBeXqJ/Tpp9fCL+soGqnjIJMAI3f8LXYbAy
	dr7ekB1T6hRcOXsxswvNZTJIYKmwyF/i5FUJtGqNDIUnmXFYmxTdndTtGBEqltaNeBFOEaJUU7LqO
	g6UTtP5kepSyOZEZWYJvWHbzJq5pL+sOlMOV1lmrgmGIh8dlxgH+RHcBk1O9LoyBc0c//Hj//zG5/
	UlgiAZHWww9XewFpOVQ+0jlp26CBjj7Gqelg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wY0yS-00000004tbi-2OrV;
	Fri, 12 Jun 2026 20:27:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2026 20:27:00 +0800
Date: Fri, 12 Jun 2026 20:27:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH net] xfrm: annotate data-races around xfrm_policy_count[]
 and xfrm_policy_default[]
Message-ID: <aiv7FHN-GqLtRinV@gondor.apana.org.au>
References: <20260612055634.3560352-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612055634.3560352-1-edumazet@google.com>

On Fri, Jun 12, 2026 at 05:56:34AM +0000, Eric Dumazet wrote:
>
> @@ -2318,7 +2318,7 @@ static void __xfrm_policy_link(struct xfrm_policy *pol, int dir)
>  	}
>  
>  	list_add(&pol->walk.all, &net->xfrm.policy_all);
> -	net->xfrm.policy_count[dir]++;
> +	WRITE_ONCE(net->xfrm.policy_count[dir], net->xfrm.policy_count[dir] + 1);

It's sad that we have to generate crappy code just to placate
a stupid analyser.

It's also ironic that we're doing this after gcc has finally
fixed the volatile inc code generation, exactly 25 years since
I first reported it:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3506

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
