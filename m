Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7A3D47DA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225644; cv=none; b=bgndwIOdpxOYaiEupQ2njghluDcf/kMaR6cerosE/jL8YbvQvt6/7Opbt3RLRsfIJCtaad1fiHe0X5YDu+NapTPSpB2z0hUgFWnSY1bOFkThPdBAnmXbXr5IfQ7CiEgxhROT4CTlexmwUgdQ6nyap90LRa65Jx2qTZ2Mlhob0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225644; c=relaxed/simple;
	bh=vk43d80H9ArtM7fiRMfd2ZynyMA7WDBnj4Iwg2rsUPU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeBWOBxaeIiVZompoHYTgc0Ww/x/Cl+wJi0vqHUoCRAWNe/PFkChqwziOY8/iziXALJLDSNaZakTeAZtVYq0RmtDkGsvOyzgqNOzTtPpvzL4Pwh6fb/LlFOc1+QAWMICaUsTQdUZEA1k1BnfK0o0PQAkdVTHv4MZxw5AaoD/sUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jJNAR0F4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jJNAR0F4"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D2D1720764;
	Tue, 28 Jul 2026 10:00:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qvEVcu2r1ZOG; Tue, 28 Jul 2026 10:00:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 430C620508;
	Tue, 28 Jul 2026 10:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 430C620508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785225632;
	bh=GuLsKWrIlYjyCwl0uzTlhIPwWKtOo/N9B7rGgjLNPMc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=jJNAR0F4b54yq9bh9xMQZWTqnEZCjYthvgebBaWyNoj2lRUV5jRQaDl5uSKS0b5uF
	 tDRjnsWrNr+sl34FdgBGp34oP8vHGge9SIsTGIo76VTjcl8BqlBwvDoTovvnU2cWRx
	 K+3Hntwv8lwPJj7f1lp11ZNSSUhOqj7fx7r2tu5jBLkrcRmsm7q0+4TpadLwsow60c
	 fGmG9GV9LVEUhTn/LsMJ3mB8Pjy7UuD5diTtvIIbNu3ijmCK2JqvT4tPjfzd1iBwDI
	 mg61LkBinhfjaj9FBqWRmKYqLJUAaxZ44L/yAEbCbiUGUKU4HYwtfZzX8W4lRSfjOl
	 yCJzZg4YwiaVg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 10:00:31 +0200
Received: (nullmailer pid 661739 invoked by uid 1000);
	Tue, 28 Jul 2026 08:00:31 -0000
Date: Tue, 28 Jul 2026 10:00:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH ipsec v2] xfrm: ah6: validate routing header segments_left
Message-ID: <amhhn-8uYWoBH4E7@secunet.com>
References: <20260723093524.3672512-1-manizada@pm.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723093524.3672512-1-manizada@pm.me>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jul 23, 2026 at 09:35:48AM +0000, Asim Viladi Oglu Manizada wrote:
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

Applied, thanks a lot!
