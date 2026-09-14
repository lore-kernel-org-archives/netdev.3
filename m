Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1ED41DE0B
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377915; cv=none; b=mRr8jpN+MhqhSAGlpm6k+32Yq2+ANa+6iPIGa8Okl/r3ZVlKT5Ad46f9K6QCuXCUxq+WjPwfKRQaNv89+Pg3TRmg6SxD9YuwAHZCYlDoaKcBdwUYjj4vZf/5dfsvjpJrMD3r+StDyypdC5QAMggmfxADV28pebG0WyJrfSOKf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377915; c=relaxed/simple;
	bh=EGfkMx2MHC2LIJYqkAeWh0BuOhDzLRR4nnmCfyc7MZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTOm7XjrD1LB4pgC/9QypRcoV2nqBvj38sgtSXPixf8ptvAMV8R3s7bP8G6YlDfg/URLV9APHzDOA+La7bmQ2nZ8cuRWJ6d6uxiD5PHmetSqZrpbTKvBIaO15GJF7x8w60xiRkXvDXAcSP6crpHkad1A/TDgGpAMwae/lDf9abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RZL1rP0T; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RZL1rP0T"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1CC72201CC;
	Mon, 14 Sep 2026 11:25:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hct50Xtkjiq; Mon, 14 Sep 2026 11:25:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8906C20190;
	Mon, 14 Sep 2026 11:25:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8906C20190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789377909;
	bh=TmdOUPYF7G2kVT7b5Rqd6x0sd37rhfvgF2CxWOaoZ6U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RZL1rP0T01G6YLFB0wBNJ6SkJQqBkcIjR3MfEJiSZuo0+FO9v9lQhu4zhjwBtN1Qy
	 nVauXOExGBj/1tCGQRIMZTO2WeRaW80AxJ+Z2rXZL0NhmqVaoJ6UcfaY9ORRz8PsTQ
	 sFUpSNlM9Zc+JNlY/kr8p+BR6hJ30Yt15VweP0nnl3UWUt/A8gG7x+AN6yKH1dXwJi
	 7DiW3lrUNJHBFomKR6ID8BeOI6oLipzpgfp8jQYQJdW/PgHcaITOGha6yWn0CAr7eJ
	 ueGLLOcbPSHdQ8I5p7A5JAkwqNxEHP7egKlY07YbRIv4fIjW9NjvTyz+HCsdQ8DVUa
	 6UDUQaaq+sk9A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 11:25:08 +0200
Received: (nullmailer pid 1858111 invoked by uid 1000);
	Mon, 14 Sep 2026 09:25:07 -0000
Date: Mon, 14 Sep 2026 11:25:07 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Zhiling Zou <zhilinz@nebusec.ai>
Subject: Re: [PATCH 05/12] ipv6: xfrm: use full sockets in local error paths
Message-ID: <aqe9c7yHBpypRX50@secunet.com>
References: <20260907093020.2228346-6-steffen.klassert@secunet.com>
 <20260908224856.1591189-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224856.1591189-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch.

On Tue, Sep 08, 2026 at 03:48:56PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ipv6: xfrm: use full sockets in local error paths
> 
> xfrm6_local_rxpmtu() and xfrm6_local_error() used skb->sk directly and cast
> it to a full inet/IPv6 socket, which is wrong when a SYN-ACK skb is owned by
> a TCP_NEW_SYN_RECV request_sock.  Both callbacks now resolve the owner with
> skb_to_full_sk() and return early when there is no full socket attached.
> 
> > diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
> > index 512bdaf136997..44b221a09a0c8 100644
> > --- a/net/ipv6/xfrm6_output.c
> > +++ b/net/ipv6/xfrm6_output.c
> 
> [ ... ]
> 
> > @@ -31,7 +34,10 @@ void xfrm6_local_error(struct sk_buff *skb, u32 mtu)
> >  {
> >  	struct flowi6 fl6;
> >  	const struct ipv6hdr *hdr;
> > -	struct sock *sk = skb->sk;
> > +	struct sock *sk = skb_to_full_sk(skb);
> > +
> > +	if (!sk)
> > +		return;
> 
> [Severity: High]
> Should the IPv4 sibling of this same afinfo->local_error hook get the same
> treatment?  xfrm4_local_error() in net/ipv4/xfrm4_output.c still hands the
> raw skb->sk to inet_sk():
> 
> net/ipv4/xfrm4_output.c:xfrm4_local_error() {
> 	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
> 	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
> 		       inet_sk(skb->sk)->inet_dport, mtu);
> }

There are still direct references of skb->sk that might need to
be moved to skb_to_full_sk in the codebase. The patch fixed what
described in the commit message and did not introduce a regression.
