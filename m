Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693104;
	b=UO9G1DuiOnhJ1kdQ6eptxElS3Y9p73NjPA4zlAR8uYe5ye0iMiYN17PCRce8JPC//28v
	 cWHLavge1O5xnPvqT4jmWwGBgyhejbcodyc5Vuyn7CYqfRQTy4IwMrkGQA+vw4FJFC0Mg
	 7i+QBxatGZIr8guOuTVEy8GuLdeHYG5vD0TE4rbhAIL86+pbU5KwGXgN0dw1NbKqu6vJD
	 yYFm8ss3jOfl3XCNuKh22jfjiP7eJpt+Y1sA4ftOieIx+jHttn4FmW3EDanW1w5PaKtaq
	 g5i/AkekIHHBhv5sZ9QglMvS5EFCDr38Mflyk0Y+ljvsV4oAQfGZf4R07BOJ2HUbHcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693104;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eoUAk8jZ+f4PVd5iINrJo6NiECQiwJOfgkR9e/TenUI=;
	b=WUAsDT2KgIvzP4fuF5Sa985sTMpp7ungro7mM7RPw3OIzrbvwVfYs9h4lSO07GhmGRhL
	 Y0Nx4eebT/EjrezDyvBTj5pyC+OlS3ctaOiC4kEDaTbFDWRU3B0C8nOZBh78EuHnSr3Aa
	 vozanA25fM8ITEAy0pb3vJqSWGX64pOz4Jf7n2snwSvximccnEPO76f8bT7SMNDF5l3MD
	 NeRjJjaMtIFcDS4oU/U0xpTbZF4kGTYnwJUdoTyMjoYC53f6HzL+LzoqFrqk31IbBBegO
	 9uescF9zlIDNJBWaUJddjUh+gNOLMZnN8A2nc57V9P2T/kP/HU2y+AMjsfBt8gl4MOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNWqiabU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F6606D803
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNWqiabU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FB01F00919;
	Tue,  3 Nov 2026 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693103;
	bh=eoUAk8jZ+f4PVd5iINrJo6NiECQiwJOfgkR9e/TenUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cNWqiabUOTPbiPmkXBnfJMO3evIPyOvV3L0CWLtH3cgt12Evjju2b8zWTTY9mNFZU
	 5Ai8kb/tvEnWUF1gDc7avceeZIlKcFVCinELcbl5dwcZPkI58xLScFMDlIMGulChw9
	 G11OcUazv8of0xR1VKG+YZFW5NmumREGHUaDibl15n5gnsRZHfxAPKAD2UjV2i748N
	 hEtEncXbjs3iwlAECmZfevaE7gWR58R3Lw4SRk5W2ssvLAEib4zEdPTcDD5g4q3ktS
	 4qNXEGWTBC8JAUO/+VmJZz9pdDoFR+FAHQVmpwXeXl83wWjQZFti+C8YDT7r6zAUAz
	 AvWO23MWmsbEg==
Subject: Re: [PATCH 06/14] xfrm: state: reject mark with bits outside its mask
 on ALLOCSPI
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:03 +0000
Message-ID: <179369310311.488856.13560556297977536226@kernel.org>
In-Reply-To: <20261102100451.2505200-7-steffen.klassert@secunet.com>
References: <20261102100451.2505200-7-steffen.klassert@secunet.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] XFRM_MSG_ACQUIRE (xfrm_add_acquire in net/xfrm/xfrm_user.c) still
  reads XFRMA_MARK with xfrm_mark_get(attrs, &mark) and never calls…

--

xfrm: state: reject mark with bits outside its mask on ALLOCSPI

This patch adds a verify_mark() call to xfrm_alloc_userspi(), so that
XFRM_MSG_ALLOCSPI rejects an XFRMA_MARK whose value has bits outside
its mask. This matches the state add and policy add checks added
earlier in the series.

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 0723d791b8b70..6b53373168b02 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1916,6 +1916,9 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  	x = NULL;
>  
> +	err = verify_mark(attrs, extack);
> +	if (err)
> +		goto out_noput;

[Severity: Low]
Should XFRM_MSG_ACQUIRE get the same check?

xfrm_add_acquire() in net/xfrm/xfrm_user.c still reads XFRMA_MARK
without verify_mark(), and this is still the case at the end of the
series:

net/xfrm/xfrm_user.c:xfrm_add_acquire() {
    ...
	xfrm_mark_get(attrs, &mark);
    ...
	xp->mark.m = x->mark.m = mark.m;
	xp->mark.v = x->mark.v = mark.v;
    ...
		err = km_query(x, t, xp);
    ...
}

The raw value/mask is then put into the ACQUIRE multicast unchanged by
build_acquire():

	if (!err)
		err = xfrm_mark_put(skb, &xp->mark);

Here is a possible sequence. A CAP_NET_ADMIN caller sends
XFRM_MSG_ACQUIRE with a mark such as 0x101/0xff. A key manager gets
the ACQUIRE and replies with XFRM_MSG_ALLOCSPI, echoing the same mark.
With this patch, that ALLOCSPI now fails:

xfrm_add_acquire()->km_query()->xfrm_send_acquire()->build_acquire()
  -> daemon sends XFRM_MSG_ALLOCSPI with 0x101/0xff
  -> xfrm_alloc_userspi()->verify_mark() returns -EINVAL

Before this patch, ALLOCSPI accepted that mark.

So the kernel would send a mark in one message that it then refuses in
the follow-up command. NEWSA/UPDSA, ALLOCSPI, NEWPOLICY/UPDPOLICY and
MIGRATE_STATE all reject such marks after this series. ACQUIRE seems to
be the only XFRMA_MARK consumer left without the check.

ACQUIREs that the kernel generates itself from xfrm_state_find() use
policy marks, and those are validated by the end of the series. Only
the privileged injection path through xfrm_add_acquire() is affected.

Would adding verify_mark(attrs, extack) to xfrm_add_acquire() keep this
consistent?

>  	mark = xfrm_mark_get(attrs, &m);
>  
>  	if (attrs[XFRMA_IF_ID])

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
