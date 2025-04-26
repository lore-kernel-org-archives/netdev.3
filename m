Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C81DED7C
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632429; cv=none; b=B27dXXKguFXdyTMv7Nz5Fh+zHnBTH+jEAjolcPTakm+UG2+LGf5A68I1giIR6nfPsFlQHObeHX9QCXH26xzhLvAooDhGAe4dy+n4855kXNX7ABW+ze63kuJLQ0lQfZ4oEuBCqoIiQHvoAk0DWEw/JUYv0KSvacPWWKt6iCOg44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632429; c=relaxed/simple;
	bh=itus3HSgeaZKnzLs7A+PzZwyHfYvLZV6v7RSspLGn6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGQM4rwOVfRPhwRGZUsYIgeZYvb64scq2Gu3hJfYu2M1MzFYXQaoxReSR35AnpXk5poL7Zymh2zPnO4wWcABI0VRgadpkRGyHMRMQjQgCQVnGQMraXt3yTCL+sUjEmAOVUp5tJoqjxzdOkcoEFYVvs1rvJrv6IO+6vLXSaj8DFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Mum0JnWk; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Mum0JnWk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mZ92s0mFC6iER0dQtVSEMXa85A2tE+alJQjbTpVolss=; b=Mum0JnWk+L/eJ8oFNtdB77dzsf
	1Ks9cYGvcuVTYmL4xU7FamAj4pZb44H/0p0AumZJsTk9m/PLGAJYYwmOv7Rl11G0DBsJia4ea0vzu
	Z/dHIyGZgShIMOHmVKpQ8VeoZPmzEXJiOyALuVs7FiquCwG8z+FHOG0nYmI+iE7EC5el+CL6e1JCH
	9tenncRCLK76Sl2UkYTWsBPHghBlOHT2hAzsmKIvxKC+ya8kTYcmavrbFttqMQVPNsSLT5T0Es/lW
	KabdanYomeZYfj3zpD/K9P++fXXlP4jd1qwwVL2od7AEZnNuOuvjhR0iU9kAh9XwlAq4zWUwhUU0r
	3ygdrdgQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8Ujb-0018bi-0k;
	Sat, 26 Apr 2025 09:53:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 26 Apr 2025 09:53:39 +0800
Date: Sat, 26 Apr 2025 09:53:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec] xfrm: ipcomp: fix truesize computation on receive
Message-ID: <aAw8o89W6F9uLuDo@gondor.apana.org.au>
References: <f507d25958589ed4e6f62cdc4b8df64865865818.1745591479.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f507d25958589ed4e6f62cdc4b8df64865865818.1745591479.git.sd@queasysnail.net>

On Fri, Apr 25, 2025 at 04:32:55PM +0200, Sabrina Dubroca wrote:
> ipcomp_post_acomp currently drops all frags (via pskb_trim_unique(skb,
> 0)), and then subtracts the old skb->data_len from truesize. This
> adjustment has already be done during trimming (in skb_condense), so
> we don't need to do it again.
> 
> This shows up for example when running fragmented traffic over ipcomp,
> we end up hitting the WARN_ON_ONCE in skb_try_coalesce.
> 
> Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_ipcomp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
