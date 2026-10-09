Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B9248F57
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511187; cv=pass; b=W/nZAg3pVQWPA63pccxHSZrHzGZEAe6VkZ3uXybsHd+y+8t/KMzNeKulHWiwMPcSv6ym7QD/1kV1nhwGDvvVm8Xt2c8uxzp3ePTFcSy+M2eLLCn1BVYwZz+5DTHXdnAOGRAQQHHIRdF/2m3BMgcdcvVGxBgj/mgXA/NYxKt0v6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511187; c=relaxed/simple;
	bh=yqtnp6B6FTM3QTJaiUbEanQouvPTHeGKm4iP1qF+XcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jANu2+k5ovSCial+4D011SzjX5lSGAzLgoIDx8T/s0v53Ad5Y1mniFhGfyG4XHYGeAh9wOFOC6sAW4Z8RGjfVWUTjORUs9oog5Ngte9iFypRYIWJz4O7aTeejR45zu81XzAVpmX7xpGheWzqZQREDiWr5Rz2ut5c6KzIsPtkxA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfl4ZipQ; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfl4ZipQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e635220b9so263186485a.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 18:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791511185; cv=none;
        d=google.com; s=arc-20260327;
        b=B9ioGRjj8mBpKLGgLGVMHFBh3gLOB4G1uwROvaVr61fw2SDEW856kBzjqZ0pVTALLe
         JHwTzoJhM57EdVEdj+ErpasivD+3/rOwLxM+iWNmIvBfTSi361yXJwaN3dMEOFTrYJIN
         6Ahz/Pr5IaShQELKp/1CctpVPC4kHmI2RhtXBPTViluhod/t1vyOx8E6EVKW4ku0HLjh
         dH4TJiabPI8iL9m2CzT/CPTfjdPiaxvp3hjGae5dIQloe4bJdO09ZPNWjI0qdbeQ+RcX
         NRh5g2sNYNJ96mKhDzL32Ra9vtRl8BEFeypdbLVYpcoLLP8kt0iXVcjrqc+eNmy+4PNc
         8vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        fh=hMaMX5v11yoj5AzpmQBkRo46mRhB22ht5EBuX4iq9DM=;
        b=ez83HLEMX1I6RLI9GPpw87KCsZJ6MugIj6v84MkbU4ED7v4DmiV8gEhdCE0E+RNcpF
         HQmOWrwBG9KcADsjaiYzd2FEU6VDgc0TfDIJZH9OFZzC89sogCUSKf3vPcOPMSdOBjM9
         UpiMLTVEi3xolyXL0xlBsRsmFE4XwC84SDd0seeEqwiRiZKbKfsFz2EKKX6eR+nI8zZD
         etgw/NWo/d46dJOzHlQIj9+rHOS+EfJ+os09xhA0GUWDd6VRMz2VfVleRQVamPMSn+9C
         FOHsHPVpCNgpAYH4wj+TzlkKhoW4lfLInB25rXBn0RQBz9XdevS7drkIPkzcLc7dWzrC
         w41A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511185; x=1792115985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        b=Bfl4ZipQQX5njrGUplZu54Wh0Ghaf0C4zwgzKQuKmrJPSy5jtkZOOIOjom8+Zr8xSl
         PZqzHYdsUFNqE370oULwPulWTvfuYra4iVc/u0OxKt5PI6giOMb+udXSxYEkNAXwjRLJ
         ZzU3y6jRLPMJZtied/ixlJocYm6tdyIBfuo6dnrKMJzaG543eLVF0FtWssEIYfODRcjA
         h6/rzbMc6iRBVEQlz+XMHbC5P330Pv+Edabl/ip2guiP0VQ4GqZP1w839PVmORA6bWkM
         n2zDySFgC6icDp3vqzGZ5G4v0dqShql7erdpkBWE289zoBcZ8LQmum5IVMkRQoVkEhF3
         TusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511185; x=1792115985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        b=vd4+9qDwu39Qa2ybYhCaBLTZmd9sSiUNr0siEZ65Tw4FatLftoFQB8DFTFVeHL+mvK
         qh5LW2nueFJ3YHZD2AsRZZSYXJcxRzOvOuteeZ5cDK3taEdHnXoRadkNF+mlriFwLI9W
         XmxjPHWqGBbYeX6DkgL9dzS0OaORAE2OwT88i59TTEdrqZmJI9JU3iTX00t6tBo1aeuf
         e11339GIGfel3dx1oKyFkrgvVzw2EKzOZjJCqX0cdTm6CI2sLHs6oIM2dwm1tkxgQoSW
         GQQwhOuSRhhS8F5oIXAanR5FTqmpPfSIFaisLGFuv9ei5C2InuMsfbRcZ5RkEfaUDK73
         R2Jw==
X-Forwarded-Encrypted: i=1; AKwUvBweYvIaxNSx//3WTMxJzVoLl2cnvAiA3ztxkQYhstOLgMaWzlRpsyd5Zp4w3AppTeOvIbZ2iLY=@vger.kernel.org
X-Gm-Message-State: AFuF++nu9jUm/BaSc4vxJdd6c5Sz4mbw7ufJ07//frykQ1UfNpwe2hJ7
	dpyGtmXlcKPV3aWaDKbLXKjXrz2GQZftEQCbhU0neqSygErcD55N32W6+MoowNEA9MpilMaw3W5
	9Fqp70EvubKPf4yAOha3I9VRMXR3lVRs9I37p
X-Gm-Gg: AYBFou0s+7s55T/B/edZ734PCIP+Hz3tfDb4Fqb5zqGD99T51sKCvNPExkF3uzAzV/U
	xfrG8OrdGg7fGn1P50Mtr4b2xhXL7RpyNWgIlDb6VF8XgxZDfU6gUEbMxCEECFxnvRkPdpz4cTi
	erHWhM8KMBZ3heJuk7Dd1HD25pgOyozBdxThY/0LV9LvZwxXv1+GI08/8kNRLkNLaD8MORe4CaG
	7qSYDlCPhltMJrFcTeugpppjUHPkhH/hSaME4iy3n3aihnA46hU6+fGtJsAOGhzzCT9DmmzlEXD
	3S77eGGS8Wl2UaDPmRaKWSGIRy92ETBzNQcYUOPEBO7XLkvT7VetlUE=
X-Received: by 2002:a05:620a:2796:b0:939:6c31:2318 with SMTP id
 af79cd13be357-93ebd25082amr66385785a.34.1791511184421; Thu, 08 Oct 2026
 18:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002074551.318789-2-physicalmtea@gmail.com>
 <20261008100352.706042b7@kernel.org> <20261008100424.4c65ed9c@kernel.org>
In-Reply-To: <20261008100424.4c65ed9c@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 9 Oct 2026 09:59:08 +0800
X-Gm-Features: AclHuK-M9H-4p3UtOJsHP4i-PkRC8HxqoHrUrMNCxQPZMxSFCUBi2fgLcuQpjSc
Message-ID: <CAJwVaMJihVPQmQNXNojB3KSMCyZkK=1tBTZoxffLmkW9LoZHJw@mail.gmail.com>
Subject: Re: [PATCH 1/5] vsock: split socket lookup from locked RX processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, 8 Oct 2026 10:03:52 -0700 Jakub Kicinski wrote:
> > On Fri,  2 Oct 2026 07:45:47 +0000 physicalmtea@gmail.com wrote:
> > > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > > receive state machine that runs under the socket lock.
> >
> > Please add a cover letter to the series and repost correctly threaded.
>
> Ugh, I see the cover letter now, just thread things correctly when you
> repost, please.


Thanks for the note. I will thread v2 correctly.

I am still debugging a conflict with eBPF sockmap and rerunning the
performance tests. I will send v2 after that.
