Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC2392802
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977594; cv=none; b=O6UA0OqbptFIVIZ7BVMfwAalCbA2G7Rg/OG4khWYDWkdTi75IfziVJhz2eEb89LJw4hpNnFPIWC0+4JAwoKiWknl/q0U51OrzDHcpoVP2cBQjzW/mpXrgvRj1ChNJ7BbmOwCfX0LUMjltDLKDUukGcxRP+2IcMiLkNzJaCmumKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977594; c=relaxed/simple;
	bh=tiCVFvdC0EExQ5FfRKrxtx1cDVZIgXdRxeUeLJ1L8Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3SOoCclnr8RBIRYdol/TelpXfZPqSMasoLe+w2ed45ElCXvHdOJrSs91VmRSk4ZHvFmprBGLbqiNJ80xf6utY1LQfs3oPKUHDHOK+nkES+VeHssjHiPY5CozUyXCxeM1EUnDGmOFciwHjIJPNNGpyaRFEV0ssIfQUBrdy1jRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ4aT7FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ4aT7FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404DF1F000FF;
	Wed,  9 Sep 2026 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977593;
	bh=gG98hRH/rTcCxjl5Qti+2k8hIWunbqLl5JFZepr3aVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SQ4aT7FICxaiybFKZ5H7KdsSZi1riUUd9wviStkp7QUGmO9gvQdnrS+l9Y9G5C6HC
	 VQPONk1OVWh3CJSl9BjQZvkqWMRToAr+7z+Z5lXfCdegUU2ZtasTm9p9mIuN6BodIm
	 WDPx7Rf+OXTojUDh7vWnDbqBCvokU6wyn1dWft1nnO1/34xYU9HHc5ZzFgOCjnu6cA
	 cGPhX3eS5fX/5tm+Xc+IffjwQOS2MJ03bu6m8stqHvwCFz/JaTFcFpnBVntUgNVhpc
	 cmv43Qtt46pmXTkWxkX3/8EcPGIy3wDR96NPKiDtmrVXewLIe/96KcovroKCHL6WoX
	 cPT0yz0tcbfbQ==
Date: Wed, 9 Sep 2026 11:13:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Message-ID: <20260909111312.2e5169de@kernel.org>
In-Reply-To: <willemdebruijn.kernel.123ac363ae937@gmail.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
	<20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
	<20260904160106.08acccb5@kernel.org>
	<willemdebruijn.kernel.173115664f973@gmail.com>
	<20260907161258.2b0b421d@kernel.org>
	<willemdebruijn.kernel.19b10eb6885cf@gmail.com>
	<CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com>
	<20260908144819.16313dd9@kernel.org>
	<CAF=yD-J1puTzDQUaMAsTCuCm4dYYgOzYO7S3WV6rA_pWVLKRUQ@mail.gmail.com>
	<20260908163447.68d64e2d@kernel.org>
	<willemdebruijn.kernel.123ac363ae937@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Sep 2026 11:47:13 -0400 Willem de Bruijn wrote:
> > No different than a loose bit in SETLINK?  
>
> At least then there is no expectation of netdev_features_t behavior.

I'm not sure what "netdev_features_t behavior" is, different "types"
of features behave differently.

> > What I was wondering is - we don't want to implement full handling for
> > high feature bits, agreed, it doesn't seem needed today. But is it
> > better to add such a bit in ethtool regardless, even tho it doesn't get
> > any infra for propagation to uppers etc. Or is it better to start adding
> > one-off bits in rt-link.
> > 
> > Think about it some more, since the max-horizon attr is already in
> > rt-link I guess putting this bit in rt-link does make more sense.  
> 
> Ok, I'll leave this in rt-link then.
> 
> Even then, running out of feature bits will come back to haunt us
> soon enough. A good idea to look into it some more now.
> 
> The main issue here is not wanting to grow netdev_features_t for
> hot cachelines, right? Which besides growing dev->features has a
> cascading effect on all the other fields of that type in net_device
> too.
> 
> Extending struct net_device itself is fine, as long as it happens in
> some cold cacheline at the end.
> 
> Perhaps something like what Paolo did for virtio features in the
> series of 3b17aa13015c ("virtio_net: add supports for extended
> offloads"). With non-contiguous bitmap fields. Everything beyond 64
> is mapped to a new field at the end of the struct. A thin API to
> avoid open-coding that check everywhere. And selective conversion
> only of code/drivers that need to access the extended features.

Trying to code this up may reveal the correct shape of the solution.
My mental model so far has been that features are still a mix of
high touch datapath bits and random config stuff like LOOPBACK or HW_TC
which could as well live in a cold cacheline. So my thinking was that
the first step would be to divorce the internal kernel formats from
uAPI. 
