Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764516;
	b=m3hXWZ50nALe4v5haMtbW10m5wV4IrknmI/7k4KPJZ19Tq1bYhWWhEZYDVv+bLE3fsku
	 +zc+xbdKZWUYDBYBhM4rUC52mdCxQZ6UB/f4SrcbMFybZsvU1gK27TRt8unmh6uFfp2xA
	 Ru29VlwRGlMkH6cW9KxB6rA+0+s3hzinjE2hV3EntjdBEYvySSZBfgovSvOuQkVVoDVMN
	 oPzVIkY951iGXcCEaYq9r/Xa6WoaYWPao3QOqj7O63oXQiiMALvZP9sx+4N0nSbW8wwDV
	 MSC/5kA9v5ukM9FMStv7gojLzyh5s+nuhUhl0n+dV/AzhCGMHS1qxspiJvgtAa/C69Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=S2REWJ/GvPB6717oRRTOl7lftZMNqJJK4+idsMBqa34=;
	b=P56rd6BK43URYJpLKFTSXLVJ+gkozqeMG6Maud6Zx1Rfvrd9KT/H5pB53qR+rdF+rDHs
	 lUhwg0lrt6xkMfJ9bDfN59DX7FDNYjcCDPXVMQ05RgzqhH8QsWNw+P/g3GRj+so8dGH6R
	 NZXU0G447febq0UJ5ARCyCDwDwSkZlTqRtauJ1W8BzhE5OtvVoND0s/gFRSINl5EQV8LP
	 +Tvq55hulD3rLJDTmhzy2FGlB0spNTUTTq8OSlivjVuFU7kKhBVtLr+2u2k/5M2CWXZjI
	 hfOkKgyQDC4qLc4K6DOPR9kaAONjLSjcYTJJ+ao4COamMSTKkm7HWhVNbdn8vwJJ3Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=juxs7H9d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA83606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=juxs7H9d
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-706113e92f9so527482eaf.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764515; cv=none;
        d=google.com; s=arc-20260327;
        b=ApBofHSmzamO5L0rKZpREdEGjz3X3L9nYhEw4O3Uh/WTgqYA75VTmlsZz2UnDO2qNX
         6iPKaTqYvqbeKrO7/uxeEnlGzy3YGPtYrG+vIkIDZ2mRNS7lJhXdmadTE9By8R1e+nT6
         IOfWL5SYCQbvF+zbbK7wNXdrY1QEB+w91qZy9ciBo9gzzYm/1OXrXskaKZwFzBpc7I9l
         YnV73gvyn5nB084EqYhcHc36L+wzHjJMlicGAdmZQsn82zMV4IFdzefzm+5F/Hega2kO
         Y3jhhD5p19OU4mCGWc8jpsKSk4IKnbVHzN1LYI1aYA3td0SMec4CShS7UU+wqw9aj20h
         gwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S2REWJ/GvPB6717oRRTOl7lftZMNqJJK4+idsMBqa34=;
        fh=vaXmCKFcjPPRnNmdIyXQmBRARLJrl2fUDXWFY8PfIPw=;
        b=EAjbSTONU33kzMywdfONRkAcACAt4Xh+AKxMBuE9Mnos8uE4jrVzjPPJXUq3/Fdbgd
         4+e3aXwkiayDs4c68rfKuyzV5HgdAFlQ4ZZNtBBsfFV5ojHEfRD9QvCIy7wZ+QDAkORU
         mV9uFr6NDaYlYPag8ybfwU9uTecPhF/ljR8g2frF38sx1K+7u944J5Lqm13QwGyN+n/+
         h2s9bnHxMV4u41M6TRhFpZItUmzAyj8RZ0syb8K/RlCP0CHgnxfxpTQjjLj/A+b6opFX
         jZw+0dCBUak5q5ZCja430APy7HcrD/FZpWeM4zChH5L1u6zurNPWe3bChqU2stodO2rc
         utQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764515; x=1793369315; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2REWJ/GvPB6717oRRTOl7lftZMNqJJK4+idsMBqa34=;
        b=juxs7H9dLJSa8dQz21+iLajiQ3GOniiUswoPVMJb7ShaVdvVrtZWqQ4plXIt+WfdaS
         xsYFuenmrFSHDHKuQZQNeMWckMNQq6szVAyWbEet/emB8jHw9MNi2iJyBCPvRHT+9OZd
         EOXc+xe/SwI2yjBTDQxpJ1sA66saKLgUR4v1qbTmOcTx7uJKg53VeFjTLcv4w1fk0nU0
         ucoEjPv1GSIvuKYOroFiITvGc1T+qoOguJiKqdJcfrd2VPr3eS7nznbF0+Eg90FJdDV6
         5YVDaeUgyNJfFJkgse4DlJla+7poCHdQD5tnRtsVZhKtomvcPR2V5hkT0C2nUWLAGMl2
         mDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764515; x=1793369315;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2REWJ/GvPB6717oRRTOl7lftZMNqJJK4+idsMBqa34=;
        b=v3atV4mTfm+lNBVxoeCjK64l/IP9keQ8xRGV7S7+zXtCu8Exdq/FjqHZxQhxtKNFKk
         mQjJpO5CG3+Z7bO7JRJzj5F5qAAEoQZrRqREYvETWOwp+0BEBOrr6c7fHXx55vULjPx6
         5hQoCreUnM1tCAuw2T/vRTdfvbS+XkRHnSIdSfxQdmLGNY5VA1CA1OCJnmLE9XD84Hi3
         pPUla7OhKGvUSXGmNxvP8IgPRwmloaL0AywXAnA6mTdXdUWBoAjkBS1SIWrqOcyGXgbP
         NohDOecGk1/y7M1fLTZ/3etqOs7kyGGaQXP8SxuRQR4xi/l7hO7sD9RbiNClk8N8O3WI
         CUwA==
X-Forwarded-Encrypted: i=1; AKwUvByjQ6qkvigXrys+2260d2DZE4ifMB5nD2CddlegSuC+kyLTdR+DvHAPMNkZKWP4Lz04cjeqZ4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBvIhVbA8dvVBkOY96Sm5VJTaz7UyoaUQdYg8KCIADlLLOPVHX
	cZ4y4JY7CFMQpQ2iwQeTs/nUG41lpdX5PgnQTjPslJRJeJ4bBEMjx0ttyq6a1yrFg8dVCsY+X13
	5W5ngqm32zlt6Bdd8vMkuc0CKrGGwJZI=
X-Gm-Gg: AYBFou0Kdi675YyI2B8645KP+Rar+WOp5YnBX2TIP6p1tzE5bsyN6c8oXyZReXysDOd
	21/epdt2pcXzwxYYZdcsKCeyRJLA4+b9/p3bUwgGhs4GN6wVPBEDeIaU/T7fpoD/MWoPBMS+5Gr
	aC9KP6bxl3/g0o7hCQe6pGg1OXj3o8coRrIvepw1Vg5IbesRmB4i3Y8+oeFUUqm9fGHMG5g5pBj
	2ui1D4viU1hQrT2VY2OUaCTSkrOIkjzAokaAmkGn71B1rZE02fV90j9wVml97nBHEzsZ4RZPJiw
	c+Y6hflxPsPg1/+vFXkCRPyE9zeFERAVCiSA3Lf/CdVuYQQ7X7Oy0+WKM5+MbcWUBdCiHLEJn4L
	A1FPLF06Ru35L0RmdRynOXWdF6S94CifFjrhNfFYb8gRZbueqKQY37g/0Y+Z6SGMb/Tds7u6RN0
	WcoCyvkQLxW4cqwcsmZfCZo11quxwmIjM7tyxw1NuVbDwJznhnXMfgEv0l0/sSOA3iFd9GzfiB7
	Tu2kSRasYjTsDOHj3ax+1fKjgDWZ8u2TD2J
X-Received: by 2002:a05:6820:4a90:b0:6df:5b31:f4b7 with SMTP id
 006d021491bc7-70b88ac3f67mr1281880eaf.88.1792764514641; Fri, 23 Oct 2026
 07:08:34 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020164239.3808903-1-pdmorrow@gmail.com> <20261022101915.GD708417@horms.kernel.org>
In-Reply-To: <20261022101915.GD708417@horms.kernel.org>
From: Peter Morrow <pdmorrow@gmail.com>
Date: Fri, 23 Oct 2026 15:08:23 +0100
X-Gm-Features: AclHuK8R07txa0xm0_-np_t35olNW-DUc3QolGlTZDQiIjd3HXrAI5wxtlVE198
Message-ID: <CAFcZKTyrRKS+A1cb4ZrjgbEwJpEHMVNCW=Bx+emzrBdC8H-mug@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx4: always create the eth and ib auxiliary devices
To: Simon Horman <horms@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 11:19, Simon Horman <horms@kernel.org> wrote:
>
> Thanks, this looks good to me.
> And I think the minimal approach taken here is appropriate for net.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> I do, however, wonder if a follow-up is warranted.
> It seems to me that the is_supported callback could
> be removed entirely. Leaving either:
> 1. struct mlx4_adev_device with a single member, .suffix
> 2. mlx4_adev_devices as an array of of strings
>
> To explore this idea a little further I tried coding-up approach 2.
> Which lead to the following (compile tested only):
[...]

Thanks Simon. Agreed, a cleanup here would be nice. I'm happy to test
and send your suggested patch to net-next once/if the reviewed change is
merged, unless you'd like to send it yourself.

Thanks,
Peter
