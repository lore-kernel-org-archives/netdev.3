Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8D4AA593
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150225; cv=none; b=sjzbfjJ9E1YxpnFdv5z1X0eTMjbOWXqusBIXoQnotw3gI9XRwMj8lrqYRRk5ba6CU3902lMrBtNjSLIyekhe3D+h0R9zuxgmCFLN7/yD+mmbd1YAdFkFVT0btHtT1WL720DM4XqmD6oPFppSAaZYUmSqerZzexHNPzunzoeyFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150225; c=relaxed/simple;
	bh=FqHBH3yUjUwLliGv8euxKjP+FOXAgy510XdF6pA1DJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCohuN96EbxPP+T8OrYGsM+eTxgF1+tliDikAlHh8K6k3ibJEsXiAE3c9tgInsbyECU4E/52B8qDhbaJFpJlw7xXgUo3RRtdhZ2xUqk9hTlbhVSMFCRMf/srGxhgddAnlCbvZydsed6jgPt18LNk+KPRQuXiFlO9CZEnEdt+dFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa6QhGHT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa6QhGHT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e65b1cc29so2513025e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150213; x=1789755013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ffqets+HvH5I0kwPYh49VlE0nCF5YvdKVtOON6cm9Cs=;
        b=Fa6QhGHTGO83JQrpLoGlc4kcGKZeFSUEkYoTvM5X+zgnCv7w8fRxDnPaYJbWtAKRK1
         tEQllAXfi9gf6uc2mdL/EL8Vsj7eXNLAAgHq0LkmGdwV/wDB92h132ySakbkDgwHM4Of
         dO0pum49vsPv454jR7xtYuHSdYCUL47YE0uMlwwDqTTSNn5sEF7NbJXwpWmA/cLKit0d
         DZ/ZbBjDSHBw+0YQ+rfzhsUgLZM29P+TXGauf5UBDAnw7vAOkTrZSAgmLo01a1nECDVW
         gSOlcBkcLb72bZDSOb995SR4+wrE/4TzjYG1REvm/njBLVXFQ3+wsH4sBgfmnbfoTfTG
         cuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150213; x=1789755013;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ffqets+HvH5I0kwPYh49VlE0nCF5YvdKVtOON6cm9Cs=;
        b=hli0oNA2xJoYL3WSf66FQ5+eljsKiB4nqcK9WOsVZNn068ZBK3hPJt5KpqBn+6+rnf
         eR1WkuU6VksSpgQ9EYZ7YKCJ2OL/C8B547z6QIrOGCxCOTC86h46qjCqT9ZlfiO/IYNZ
         /iyU1aI7r+a9sCPFibyqD633nVk+4biizPXgVfAthEArI1Wkdv+OKmanlZ7kw4R2MKUv
         NPFXHMdY1T439dEs/1VAfWB4bcdH2FNlFreFIDwdW6GAeSiG8Z6EUFbaaxWu5xXF70tq
         gjeMY+32FXxNSW0cUjhvZxJ/oNY2NUM4I+7liomsynf8S0Ad590x5zZXXn5+jj6PnJdj
         AGoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsVcciCZUrOMmbFzLCaDo6EM6rVIjFEfejcOLuJ2yLdEtfRmS2RNHJlthYIVISVU68Hthh2G0=@vger.kernel.org
X-Gm-Message-State: AFuF++nSg7E/h50k5lGtQfd6dBJXnZVV0PK5bz+2r+8JmVpdavVjcPl1
	4mFTLIFOZ0f9mkBlOICfnv2ghk6xAkKKovy+51fbD9gl/wIrsEYj2zaXbzdjVC7H
X-Gm-Gg: AYBFou1SP6/lXuxIL73qw4iAtH/Sq5efCe3tJlfQ9Vq8eOa/+sSFSWtsqnMidTAg+uK
	gf60biQV05RyaIk24k36h0VFs4z+OetDpQig1OmGB1noV1xwDsqSOGTpJfE0CwOBHVLeIFc+dxS
	ItH06YmBxEk2dnEa+Nsl1KyJWdxZQcnMCnSuHAsw3sewYl0kb69dN0LGbs3jIhiOOEOBSWdXsyO
	/7bWV8/XFeC+weIstq1i9WjkNeu5NxP1GF4F81C/7u50b30ioULwBhGQj2cJnd7a4V42bLF3BBe
	VFoyG2fwLhR4e923hOBfzIiXsiL5124ij08lOXhzoM6wKHsQUG978s0Jxg8F4hsX5jAc/TO8UzH
	qMDO8s0qayDEE7E/v93hP5iYVHO+inVMT2sqtH27ikrJWgP+fAWvRjfs8BN5qSW9dH7vcWZdxcN
	IoSh6g8guitPvGqNBJsgk0dn7onqzkVlAsjDPda29wUSUv6WEUOSV2VpcYqFqtC9USgb1QOAcl1
	tfxC6lr9A3fSzXQ1P9KvInhuRrLtY/v9mzWJuTYnbbmkBU=
X-Received: by 2002:a05:600c:4693:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49e619bec89mr121022345e9.6.1789150212949;
        Fri, 11 Sep 2026 11:10:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm19905195e9.5.2026.09.11.11.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:10:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 19:10:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] net: add sockopt_expand_out()
Message-ID: <20260911191011.5d218782@pumpkin>
In-Reply-To: <aqQnF9vWKVk3GkTp@gmail.com>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
	<20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
	<aqQkImqiHPorszOY@devvm7509.cco0.facebook.com>
	<aqQnF9vWKVk3GkTp@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 09:09:22 -0700
Breno Leitao <leitao@debian.org> wrote:

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
> 

kernel users might need to specify both lengths.
That is the value of optlen and the length of the buffer.
For 99.9% of the calls they will be the same.

David
