Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996433689A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793937; cv=none; b=aQ0OAA1JhhW+U2z8Q7B5As38jMmI5tCtw5DXBotXgVobVuF2RjhgG3dUrD0Oo1YOMc+UTtENOA8iwJUYVarPAyOm21HjTQc4vR7iKaCym1topv8qGBweZHfy1FYjED+uYcuhNBRM1e4owggqiMCVP76k9ptQrDyAULSAw9cjFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793937; c=relaxed/simple;
	bh=6VkASpsX9FVXP27LrtOChle5A5HoWp3YOgZxWtgthbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piHQbCE7zo3oDK17ULLBlPmUper69qlJ7JmQF4L0ObeG+OE8ba9IjALXQ2e9e5eNmBb4hn1FKOF6ZXd0UOfndvUvobijTPbWXBS1EaB7lNZr0gPUBJyYM6UYM80Paz/SLjuECEmZiQ1+VQU2Gjnz20UY9czgx1Gild839QaeShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ftADGncy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ftADGncy"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 64CD42084A;
	Thu, 23 Jul 2026 10:05:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mFmGM_8iHYAj; Thu, 23 Jul 2026 10:05:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 72DE52065A;
	Thu, 23 Jul 2026 10:05:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 72DE52065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1784793932;
	bh=hRsbq7IRg4qf6Ojs0Qx3dWRIk5+feTJszfxcu5sqGKM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ftADGncyRZ2l7x/ghxzxD6ATEsGCQeHNH1/ekPP2CrP1YPc7ktCJ2z/g4+4roZskv
	 3LUxi9VJphTwY5epUh7U9ibjoldxfIqR+AXVAlRzFv+1pXfc8TnIPR4FoEtnQdCu9I
	 US1oRLfx6vKmWBOCbh8uKG6wf8oFgCDXKtRf8OrHyMbFU68H5r7QuawvRZ9MPSSm3Z
	 zoJu9/g8LmH7d4dHSy5Uj0XLucY3DPzoKChZJdxld+NzzYrmRkyVeuts8ReGGqHvWj
	 gIi9Dgxwc003t6e4atfWRjzACkMszZqInt81x6+q52ForfMByKDrKmIG+hSokZpZ8w
	 yEQVLPvzv3KXw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 10:05:32 +0200
Received: (nullmailer pid 1145031 invoked by uid 1000);
	Thu, 23 Jul 2026 08:05:31 -0000
Date: Thu, 23 Jul 2026 10:05:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH ipsec] xfrm: ah6: validate routing header segments_left
Message-ID: <amHLS3bIJ0NVnvKW@secunet.com>
References: <20260721222824.2508529-1-manizada@pm.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721222824.2508529-1-manizada@pm.me>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Jul 21, 2026 at 10:28:52PM +0000, Asim Viladi Oglu Manizada wrote:
> AH6 rearranges routing-header addresses before computing or verifying the
> ICV. ipv6_rearrange_rthdr() assumes that segments_left is not larger than
> the number of addresses described by the routing header's hdrlen field.
> 
> That assumption does not hold for raw IPv6 HDRINCL packets. A packet with
> hdrlen equal to 2 describes one address, but can carry an arbitrary
> segments_left value. With segments_left equal to 255, the function moves
> its address pointer 4,064 bytes backwards and passes a 4,064-byte length to
> memmove(), resulting in an out-of-bounds access.
> 
> Validate the invariant locally before modifying the routing header or
> performing any address-pointer arithmetic, and propagate malformed-header
> errors to the existing AH6 input and output error paths.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---
>  net/ipv6/ah6.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
> index 76f7a2de9108..0f01db802f35 100644
> --- a/net/ipv6/ah6.c
> +++ b/net/ipv6/ah6.c
> @@ -233,25 +233,24 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *des
>   *	so that they appear in the order they will at the final destination.
>   *	See Appendix A2 of RFC 2402 for details.
>   */
> -static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
> +static int ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)

You changed the return of this function from void to int. Please update
the comment on that function to reflect this. See:

https://netdev-ctrl.bots.linux.dev/logs/build/1131973/14702013/kdoc/summary
