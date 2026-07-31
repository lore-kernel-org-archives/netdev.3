Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ABB331ECF
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542051; cv=pass; b=TmuvtCvIMMgFmDjDDtkG+C6QqT20GidJUbOGs3AN5eomuyOjljv0AWYEHu0X7YfukFp0nV92RvHN5LoW+pIm53aVYPBXombCgkwQKBB5GF0HxgN/NesJdeIbPV+BAYJuj31+NUCk9ji7+9eZEzkYbk668zXk4LCGJ6VjRw0SyFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542051; c=relaxed/simple;
	bh=z/QbDZxnwC+/tnRxJxXRoQCvXeIFpTjZ0hFagL/Xcu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGvq0wVTvn/dKb49Z5r8XphTW6fkmuIOLorOfvHhqQ63F69oWdPofO55DZMywqu5xUe+zLUzZzF+/pR8/mxq3xjYOYb1iDRyyHA2jvBa0KUNOQfmj+NgfZOBMM1cFXg7WJpWdMWWPbbJntqLQyz4pyJxJ0pHYXreQJ89+Ki60w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZV0BgHy/; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZV0BgHy/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1435776a91.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785542049; cv=none;
        d=google.com; s=arc-20260327;
        b=HKohlMa3fACpXpXBZghyYu9eDcY8vgsnZU7aGfwFTES5OxJHQqShr96KUFQEy9mBEz
         A4477DQlP6SOj1EiysQDtEMh6TleItU0/pmz7cZ2/j8Uql1Rq092MJwz24r06szXFx4x
         /p/fero83RQujnfDxFc9c/xitDTw22gnBqExrqmBYN9S6yZjUjGpOz3QyjMHYV44OBl9
         khfXx2EVkNXJ8ztq52iFu7iV4mHDvwBCiEY1WJ2aHcVfQp6mW4WN59Nr2B8iUyp0h7m9
         gaw5SVpVQczZOsLoURJHWHRVeWRgV1e+MjdhNq7Xiysz6NOTxMHazBSp/pmMJeyxn2k2
         IBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQKsEaYPuZ8wUMoAt2HfbFs2BUMXF1f6C68Ep6tQFIU=;
        fh=NK1lo31J1uPUgozFrD/adz5khr2wm5P0VrSMtOOTb7c=;
        b=ocO+T9JP9fzqDQZ2TEZV+pbCLbB4M7XQIfnQQZZQ8OvA/BpL/uVuAv1V2qawWU1BbQ
         JVnfbLJ7/4N+B35cRiBWMSNF4Iif0NlQdFvNWPFaGSAoh/+hgH0crklFD8igWM8PNnu0
         DNifrCXaGjq2xk2uNaZA05dNGMfHatnidZR/2U6ifQYZsa16PlVkKJi1H4kSE2YIfavh
         9gJyPN+zRCxXsj/CU5V6Zh6VSQ/N6/S3w/AQEB6V5wX1cqk8vdOsjYapsRcShhEMp9lD
         7mWV5cs4xc45kAy2BNgnJR4BjRPJzuNUVcr1Cso5XP3o7z0S0i1p0Rds8nCkzDb/JH1Z
         Aa+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785542049; x=1786146849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dQKsEaYPuZ8wUMoAt2HfbFs2BUMXF1f6C68Ep6tQFIU=;
        b=ZV0BgHy/uAnN9EOzIAQYVUbFIXWO3vw34W+ka1DXfjZgjShGF5bIB2XW2TCwB/mSKT
         plj63u3MT5FK4f87z+oC+7VyoAHqYV/olVWm0Ej36vGfOfH7KTvDSMjcJbdboN8IkZqe
         aB1NkXJRumonCAnU95F+Wnx6V1IZtKIGAFkfzRZCIM0geMN4llQFsZAn17V5C3YZ5V/w
         WyZL82/1kyeXvP/4qL6O6xCpnYt0+rgyZH4ILXcHk14teDfwOBwpQP/oea6oP3ogMvoL
         jHuKRARqsVMMUTc4zfbC+0SCFn4wiDzbAUzPPo+dwq3hPrXU0622fFOXznS6u7Qoa5L/
         /lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542049; x=1786146849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQKsEaYPuZ8wUMoAt2HfbFs2BUMXF1f6C68Ep6tQFIU=;
        b=muIk7KvINjWzapNv1/+k8ZLxMpyM9ac+FL8dbflLg2fAVOUI3f6Qd7oiSDv/XKa3k2
         yTqEZNexY25wtCSi/SMwIUsJqolcgafQgiDID2I5fD4NUpVjDvjpNC5g4cpKjFzqY6zl
         K+uQTwxBCbFePTbDszRoFvVEtXsK5E3rBpMOKU68e9D+H2OTqNArsQbvNwwp478zPOEl
         IYs1N/ikq9R60kIYtFSZp2We+vQgfpy9r2prtwYJrj1rkg7G81l/44mcsc+InGCDjESJ
         tCcmQXWSHczo86QiWkDBJPUO9Fzx+Zei5CRfiEra4uav0E9197BFub04WH9zmDCr+ARG
         rRdw==
X-Forwarded-Encrypted: i=1; AHgh+RrJAN8jppbtgucnWbF/FpcxVaQV//ZNUQ5M3ioTwlLAJ/mnGnRkvQr+m00V4ysTiT1iioNQJ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCdHCenKiKE59HKdYTzRLd8Hck5dpPI+p7huWaEs2PvygHYFz
	GKhnKhQUIWKeajI2Xk+I3gQEM1CSK6dbZ3+KjGx9jUlXDhOm+oVDB4WAQuq49OWB2gUjKuhA2Sj
	QbLr/fPOVabMirvorUDBgZ3rN8C55mUR4OK152vy2
X-Gm-Gg: AR+sD13PoY9AHkJKzdiyqq0qgSJkqPR7yQO8rUNuXEzYJlzkInRtHyf51UxbDCJeOv1
	ArAX1PObffVSLhl4gCC/8Eq/yRUEAPsalcWj099zQObmQC1mw5+IVTXJ1ViaSNuq8ARHBs9lN0Z
	rni5UqeXPR7VhH153+r3uU1gJRn5A1doga9fvX8x4pDzsBDbgFiywyszlDPnX+2DrMq76cncf82
	NpRtRkyMMs7ZMdjt8GqQUJNsq3gpE77PyQqLqYeLOg8ZSXnYwdiS/oz0RMi+fqm9i5CjmfOh07E
	pJZDCkdCxZVHb68WFk4wGqEMSYn9P+gCThghkn1QeOMoRCtx9UzqejUNc889mAeKmtqMqMZ16Dc
	Zl3RPpW4z24tJD7lAy4xHWIwt1gxs9CQmXI/CRav1jZ41gR0qy7dfliUIvThyh/dowb+ZdOW35s
	UvJhFUEokRhy62eg==
X-Received: by 2002:a17:90b:2f45:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-38fbc408bdfmr1443765a91.7.1785542048763; Fri, 31 Jul 2026
 16:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175141.284757-1-shivajikant@google.com>
In-Reply-To: <20260731175141.284757-1-shivajikant@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 1 Aug 2026 01:53:57 +0200
X-Gm-Features: AUfX_mzJ0TpvTJcTLfxZAL-iQCcooiKSqprQ2g9C8MzHeYNFd9pziA-74s2jJgY
Message-ID: <CAAVpQUBB2ZBGt9u_TiBhjB==gvDZ-4gpuzqDTA2amhO1v132Lg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] bpf: Allow IP_TRANSPARENT and
 IPV6_TRANSPARENT in bpf_{set,get}sockopt()
To: Shivaji Kant <shivajikant@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, anubhavsinggh@google.com, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:51=E2=80=AFAM Shivaji Kant <shivajikant@google.c=
om> wrote:
>
> Currently, bpf_setsockopt() and bpf_getsockopt() for SOL_IP and SOL_IPV6
> only allow a small subset of socket options (such as IP_TOS,
> IPV6_TCLASS, and IPV6_AUTOFLOWLABEL). Calling bpf_setsockopt() with
> IP_TRANSPARENT or IPV6_TRANSPARENT fails with -EINVAL.
>
> Transparent proxying (TPROXY) and related networking components often
> rely on IP_TRANSPARENT and IPV6_TRANSPARENT to enable binding sockets
> to non-local IP addresses.
>
> Allow IP_TRANSPARENT for SOL_IP in sol_ip_sockopt() and
> IPV6_TRANSPARENT for SOL_IPV6 in sol_ipv6_sockopt().
>
> Tested-by: Anubhav Singh <anubhavsinggh@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Change itself looks good, but please rebase on bpf-next.git and
respin with the correct branch tag to trigger CI (and maybe Sashiko?).

  Subject: [PATCH bpf-next v2 1/2] bpf: ...
