Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468892;
	b=Onii3zYNvxDdZRS5OGHfuhSnCYOWoiiDj4baytp/BgjANgUQrCrEdKOMkuGG9gHO+i7M
	 EeZWql3SAg4I31rxEWHeBi+laVbK8mJYpi+x2DmyerSIqPZAn1vGVRluQHNtsvngMvTiJ
	 xXjENLdfJHP1cyGoCZFqIrt+kf2QNfQyNUiYppXG9j/ILDD0Ry1Eu+oK4cv/oXjUmmHCy
	 F6waj4DTrbBkKSABkqrgD0ApVcIEWQayCt4wzava/eh82mFVPIXdh2M9gigaS1792KGWd
	 G4Z0oCviUTbMH62ZF/w9kGYSXcGs2HJ4wpiaZKj33R3EBkoHw1v6/PJeDl2IEoNqP0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468892;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ijyk755RKB9PH7Ivb9JZ9BkwDVCr81ydGZssI4CFSRs=;
	b=clSmc0RZTcrjmYotIi6anwaCQMJJ6dPgof2yTv5w5VF2+0frUGzfOMAXfoY/InAFxmKL
	 zEkwshgitNXvcS1ajeLcWOno0FPiXKeq4B7Jhzn6gHFn87PZfIJPRtr2IcGpAv+ODju+E
	 DJ1cLsY9IIJ8h3oM+zLULom0dQzG3rYZR+X92jpAdxu33KmaDvSF8MwcrYG/KRg/QKCSk
	 kfpKMHcu/JEyqaK0kmwfp4mZ6xJJLr3+JKraxuuo3PBwnRq5bdOcTZJ2OWz11csi5m6Xv
	 CTyLqzXOr/y0MM6Qg1T4OVWECrku0w/GCd1hdmyGcP4hZNwRF+c/N9hJc8lzAz03HTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la2vvVQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F205606A31C;
	Sat, 31 Oct 2026 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la2vvVQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218611F000C1;
	Sat, 31 Oct 2026 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793468892;
	bh=ijyk755RKB9PH7Ivb9JZ9BkwDVCr81ydGZssI4CFSRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=la2vvVQRE8Z6QHAsCS0fKIzAKtPb+FEGjiQ48EUiVneGviCjka8mkeMQpPKyEU93A
	 S9gEf20u97yU8JnPvLfu9UngWuC0GPVoxEjkabpjbsuOdQdNqkXEBUG92yuqsU+Bdb
	 MGhctkHvgDU6EmGFfWUVtwnUEU4M8qEWW0TpZ8PNI4nr0BBBvKRu3Si1YMJ/Q/MVCW
	 6UgKUNjyFOD48SH+G+NxiqQxPG9lcj1OnuV6irc+qxuF4eN3yrLc8zU5uvVtN81RGi
	 E6W+YZV7BzCzDCebZTN8HzyfhylhtoaUEjMdNqggPJ9iDtRif/7bSYKOZRLyYI40HS
	 mVv7TzrFt4iQg==
Date: Sat, 31 Oct 2026 17:48:07 +0000
From: Simon Horman <horms@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, leitao@debian.org, norbert@doyensec.com,
	hataegu0826@gmail.com, paulus@ozlabs.org, Brice.Goglin@ens-lyon.org,
	akpm@osdl.org, Matt_Domsch@dell.com, linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ppp: remove SC_MUST_COMP
Message-ID: <20261031174807.GS257209@horms.kernel.org>
References: <20261029074935.40509-1-qingfang.deng@linux.dev>
 <179339596607.3131.10030375792154782283@kernel.org>
 <84396bab-166b-435f-9663-0aa2939de3fc@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84396bab-166b-435f-9663-0aa2939de3fc@linux.dev>

On Sat, Oct 31, 2026 at 09:28:10AM +0800, Qingfang Deng wrote:
> On 10/31/2026 5:32 AM, netdev-bot+sashiko@kernel.org wrote:
> > [Severity: Medium]
> > Does the fix need the define to be removed from the UAPI header?
> > 
> > PPPIOCSFLAGS already masks the user value with the kernel-internal
> > SC_FLAG_BITS:
> > 
> > drivers/net/ppp/ppp_generic.c:ppp_ioctl() {
> >      ...
> > 		ppp->flags = val & SC_FLAG_BITS;
> >      ...
> > }
> > 
> > Removing the bit from SC_FLAG_BITS (and SC_MASK), together with the two
> > checks, looks like enough to stop SC_DC_ERROR from being stored as a
> > config flag.
> > 
> > Deleting the define is a separate change at the source level. Userspace
> > that includes <linux/ppp-ioctl.h>, directly or through <linux/if_ppp.h>,
> > and refers to SC_MUST_COMP would no longer build.
> > 
> > The commit message calls the flag unused, but the evidence is that one
> > pppd integration from 2005 never landed upstream. That does not rule out
> > out-of-tree pppd MPPE forks or other daemons that use the name.
> > 
> > With the Fixes: tag pointing at a 2005 commit, this header change will
> > likely be backported to the stable kernel-headers as well.
> > 
> > Would it work to keep the define, with a comment that the kernel ignores
> > it and that it aliases SC_DC_ERROR, while still dropping it from
> > SC_FLAG_BITS and SC_MASK and removing the checks?
> 
> I found no trace of existing users (searched GitHub). Even _if_ there are
> any, _and_ SC_MUST_COMP does not alias SC_DC_ERROR, the logic is still
> flawed - received packets are silently dropped without noticing the
> userspace.
> 
> If the goal is to prevent the removal from backports, I may split out the
> removal part into a net-next patch.

I lean towards your existing approach: it's broken, and that brought
to the attention of any user of it.

Reviewed-by: Simon Horman <horms@kernel.org>


