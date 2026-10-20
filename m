Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501808;
	b=En6ALBgk8/VCwF0DjCMWNkB1dUSSQPVWKuKh2tjHrwSnpHWBeqRjlJC0V2aB6qrdTykr
	 NFg1+K8A/7UXacEHdRZhVLZ+kZ7GI5XaFgmdyknwI0vnxT6xuIcMsjv4PG2wAWHywph0X
	 ZHAmKuSXWQesfgV8rMPGJLpX7srTSuGSI53+po71SD2gGicxp518MnP0cZe1xweG2/QOK
	 rq2I7eqcXovQD+ZQW84+sJq64tPahRM2jtskg4hZt4DcaPm97I06co01LcibwxyF14aY3
	 zJ+dzERHqId0QADv0xbhdbDSD2Tum0tPfu4mvu4MxOeyfpIH1tO7GsVm4oMYmcBJmNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501808;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MJnzoeGDJGlYFhnUg3KqAZEf4kJrQ0yTrNTuF4zJyDA=;
	b=0b/BR8QeVzYDDAlopk5Y1eHkLzWjNbRbor1TfmIRS2MTRm+4HNrkVZ5GAiuIELrSH0mB
	 LB4dYJb2ibBfMaeLQiHqoMwZ7GQFU0Y7t7SG+4egNF59Ep16XK1kRGIG4uygRi+DqIdmu
	 3vtSvRT9swSM79Hy77LOpsXTo8fHHVYlTjCkQ2VHC0F/yZAa6pT9po/08VVLZQNfzHwlx
	 BRUValsazXr0Dna1UVS5pG9BXzUzSejaq2XHrIJETtwcon1w+zsVWywm3yvOBzxNW8peW
	 AfJAHr7/w092te6vejcm+9jug+PYZILjBzOqRx1X8P8fIGWbkcXNSiHzhVSb+ZWm8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWKxgIPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB4606A33F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWKxgIPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0391F000C4;
	Tue, 20 Oct 2026 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501808;
	bh=MJnzoeGDJGlYFhnUg3KqAZEf4kJrQ0yTrNTuF4zJyDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TWKxgIPLJ9LqYrCWrojpTigzIZC0QvcpwMnXvOAHRndMDSyMQ6o9YIelmVs1WdZot
	 Menq4HSdUVM8iNAw7piS8paMXEXazB6vFZ/Qsl7OfLLdDBm1J18ucIFBHSQ5daAspW
	 4JnMFNBpYVv0UYtoeUUyOc5oIS4B9AUxdPfBwaWRclis9Y1uS/Rja4i3DaRJa5iAr2
	 7r1ZznJdl+fx9D2xH1oqt7hLbaWaqA49U8/hyoYh4gmgUw0yDTDkCHu4a3ghOBNfPl
	 7sLuPwMLC6tJ3PDl5lGrOHnPngRH4rHcvsxm/9RtU1B2CRdB+J5T5fBproLnCzkeKO
	 ZDhn5puKKnOyg==
Date: Tue, 20 Oct 2026 16:10:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute 2/3] rdma: don't build printf formats out of keys
Message-ID: <20261020131003.GM64621@unreal>
References: <20261019200623.816470-1-stephen@networkplumber.org>
 <20261019200623.816470-3-stephen@networkplumber.org>
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
In-Reply-To: <20261019200623.816470-3-stephen@networkplumber.org>

On Mon, Oct 19, 2026 at 01:03:03PM -0700, Stephen Hemminger wrote:
> print_key(), res_print_u32(), res_print_u64(), print_driver_string() and
> print_ipaddr() passed the attribute key as both the json key and the
> printf format, so a '%' in a kernel-supplied driver or hwcounter key was
> taken as a conversion. Pass the key as a string argument with a literal
> format; output is unchanged.

I'm not aware of any real firmware that sets `%` there. However, why not?

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
