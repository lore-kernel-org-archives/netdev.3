Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB263E4C61
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161468; cv=none; b=RYsae23i5WaFK/d7FHHRDzBDWFI6ZpWAb6BHAsso1iZU6X3BLQV4NfdEEXAJO3+ikpwVJfW+3NDN8AQ4r8oYOtBLDf+alykNOQHHr46witPQ2H8Dc8J6hBcG7O+nOKpGboQZMn756y79tmeCBtJ9PwopaO60tXe8k3gnpEbH56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161468; c=relaxed/simple;
	bh=pRD2Q0MOiyrSPSkiYE4fxvcMyAVQbuFTvSwJ+4B57jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFJqajYaV1NyMewCUOTAOx45gGj8+hC9nc2Z3ZVUtPKYjhjqKsfBCj3fcgi0ZCCPiUC/Nm7mp/7jQ1kJBVUMSKpfImev5pxsrZYpvnmHNXWADOf9VpQVCNTQJlGSWXchkNy+OV25r/6S++bciPkndLE/sHR70uJcxwWcLGQ7Swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs74dA3K; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs74dA3K"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso609349a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161466; x=1789766266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LWlsthWmOa/1IA1PfJb6FIh38eowBq8VdzTMOAowcpM=;
        b=bs74dA3K3naqIrJtlIPH5LwqdU7oVnuiXIBlv61335vTrF1dQWKu4kaGoiI+QenrvW
         UR/jqimohk8MbAe090XP4nFmdPNLzFgbiLOJmYjUnbWhIyFxuEtPiu+Fg2CXy8OWknCb
         n4v2odrgCkVHisgzihf9A7Guz0gXw/4VGu/wwBlQcTV54xLVtnAuy3V2vVI0obZl+OOw
         TKS2jFOrrY6bwFjJry1eBVrZN5sduYVPYZ9Sc4OsC4cDAw18CyAsNPEBc9sgIatj8JaO
         aD5Xn78vCw4a7J7v6WIP7IWCnbyENhLbh5L5WnvyQE2tDcDo5JTU8Ne5yYWmt78GovKR
         b0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161466; x=1789766266;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWlsthWmOa/1IA1PfJb6FIh38eowBq8VdzTMOAowcpM=;
        b=Di58d+YqA4gr42gupFDm07M+PRoZ8CDaxPTXn8ZdBgPcGxOj2teckOhJ0lzbyWJjon
         TUbodvBCvt+ZjrvogZINIo12f560vfm5MRmM2+DY6TmBBKq/IAHuXQsu93/0HNHWmrFg
         qPYpWQHGGIlnorAhzIrwZKBVfLOznMoacNHSlaTecJH7HVDD7B4mcry00FVhvHBRbxEA
         pNY2XOGSjBOw49uxYVh20E6AgczXZ+/WPcYLy4MsP/S+nFG93xHGfTmQgmEaN+ZzSuOj
         XJOiLBdiIz1dbX1yQmB5xDi0sfjS5n2y8GdStWw+KhX0r5tdKVoqCeeLXu+PxUMyrwuu
         UCNg==
X-Forwarded-Encrypted: i=1; AKwUvBwcTUqz3auiXcW3yDoDiUYpVkYatJOKgH8A4vUvC3MyXrjuKzQR/kMUJSLTBQG5E75Dh/yWsWI=@vger.kernel.org
X-Gm-Message-State: AFuF++k7s6JJiJ69fgblAAt+EYUCAURV4X++48lfyxCqRQyjLumc9WwB
	SueyORoMHLdRBkbCHtkOmBXJyMhMXJQRoIjmAW+6YjZI0NVIgNMKmQyl
X-Gm-Gg: AYBFou1e/renoBW897ptC4kptVIlqH4QTzVTec3bPTKGz90p8F+IfaEWt5NouRgXTI8
	WA3HSyaA6C4osluDKN0dtPgY4BLOKjy5q7FB6Imkcq4kGSXfxXGC8H37NvzLHdRTrMEuSroP5uA
	5HGbMUSyAL+SlFiAx66zcmqMQGtbt94TKnFsCCLuchhbvONRcJ4qZBZtWnj/cx95incRiMgEptp
	vscwBKkH5MXnL5ZUCMp1SrmyJO3C0hAWxqi6iiDiSnt8Zg66eeApyStQpQbSKLz1Pyp2/zx2mIG
	K3h12aS7M5SAK/hFHY2njUmXufBPIAMgJCgrIf0wRmGJJK/lXjLfXsLXWgY2PM435axPuDVuUzx
	zRIlo3C+CZlA9xWiis+1Y9xAMAj4iOmL3/yRKI6k3IZ6DcIS0o7L2SG9WLWhAW9BkHwvqhXTCSa
	KeBX6LkR+1rSa1yMLqZfF+g9kpCA1xOpmcfsW1DwcoYgkbeTx73eRVfx2AtNLxZ++G
X-Received: by 2002:a05:6a00:8d4:b0:869:4d90:a0cd with SMTP id d2e1a72fcca58-86b31200babmr9143371b3a.16.1789161465559;
        Fri, 11 Sep 2026 14:17:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a1b827esm1613687b3a.51.2026.09.11.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:17:45 -0700 (PDT)
Date: Fri, 11 Sep 2026 14:17:41 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] net: add sockopt_expand_out()
Message-ID: <aqRvwUJ-ksUxrG-c@devvm7509.cco0.facebook.com>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
 <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
 <aqQkImqiHPorszOY@devvm7509.cco0.facebook.com>
 <aqQnF9vWKVk3GkTp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqQnF9vWKVk3GkTp@gmail.com>

On 09/11, Breno Leitao wrote:
> On Fri, Sep 11, 2026 at 08:56:23AM -0700, Stanislav Fomichev wrote:
> > On 09/10, Breno Leitao wrote:
> > >
> > > +	if (size <= iov_iter_count(&opt->iter_out))
> > > +		return 0;
> > > +
> > > +	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
> > > +		return -EINVAL;
> > 
> > nit: if you end up re-spinning for some reason, maybe swap these two?
> 
> I am not sure we want to swap these two. This is the reason:
> 
> 1) The first check (size <= iov_iter_count(&opt->iter_out)), check if we
>    need the "hack" or not.
> 
>    a) If we don't need the tack, then we are fine and this could be called
>       from user or kernel.
>    
>    b) for the hack (which happens in the next line -- iov_iter_ubuf()), it
>       needs to be ubuf.
> 
> So, this force kernel callers to use the right optlen, avoiding hitting
> the same issue as userspace.

Hmm, that feels a bit too magical :-/ Who are the kernel callers? Do we
have any? Is it reachable via bpf or something else?
