Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2E356773
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220932; cv=pass; b=Sg44RxNUwPIRT6JspaRmFfAwVqwvvpce4gco655DFfgpXTsunCBzspA9J7JoZelcWDaIyDrUEJHmgMi0TZCdOJ4X+j152fZXwENJFA1Xtz7/0dF8dASOHg9LrdqgCT/1DvgHhWQlqcWqD92HpBsseDCLf12aI9kk/g7nzAu7S8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220932; c=relaxed/simple;
	bh=Dm3QyVkgDubMoTiOQARsGxSnlOjpM04mOF4UOIkGwAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhNZ2tgOmIrRVce0vpUiPEoVpqEISJVEhk9mvD7F79NfnCxJsfyaApIAHG1flAg4CO1pe3YfysSQjLaYogX0YxzPV8GhzjV81T9byWuXQPJIry9aSvHwJ3rHbmZUze+39AyP7hOEJeQBHgqMH548iVLnfZLUN48gV1NXuqg6yrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lqs.me; spf=pass smtp.mailfrom=lqs.me; dkim=pass (1024-bit key) header.d=lqs.me header.i=@lqs.me header.b=PVL+vj0s; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lqs.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lqs.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lqs.me header.i=@lqs.me header.b="PVL+vj0s"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7b325so10642291cf.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790220930; cv=none;
        d=google.com; s=arc-20260327;
        b=nBtk1Z24n3qzOuVHqs7N1nLfpxGELHThVFT4IK27KbLTQRpiqS6lxF6dDZILfDUFyy
         rBBFrY43Rwzz9DFBFKSD2PkM1+mQT/1M1QwiPKBUgNS9DFGW1M+xodyXPBGQb+K8Srof
         vq9jOJ5Ls+B3ETCTXPFN7HhHsl70ZoJmzTedWidWAGbxdbCcb31WnNfOxGLs6IgpYgGu
         kNpxQn3Jv7ZpGrW1HFrXjbsW+G5ROvxsM5YqSEXIr//xPenIG/KNi1ezZuJfR+DwMqH6
         Ze8FaNAVrua6urJwuqDyutkpGsGlXlcTnZMhRe328ElyCKZhgs6GzcVkJNVopmGGfsyB
         xJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dm3QyVkgDubMoTiOQARsGxSnlOjpM04mOF4UOIkGwAg=;
        fh=1EdrDIi2BYVRpAfb68DG58fv3vsf5vVug4asvB4kSBM=;
        b=BdEpjsVQFmHlbmilp9JfgWt35pQjRIqTbcv+XNMlYaRhjnh0o1DDr4J+IAcFb+ZxrA
         bpUAFLLbU/G6FLMfJ3pIoT67rfuGBZlI7JvvcHgmArV93FN7GI6hmmMGpynZoLNu4WbO
         K2APguKi8dzUX967qb/EifnqwMjcwHmLoDLjMVh2AWfX6AdVZRIWaDWYgDQIoPV/lrcz
         sL9uoPACrRVtR2JpJxjLP8bShe0xDE8oD16yoi6H+HiXw60wmlJibwW+cZ2cFy8lp93w
         qzMPCNfYC263r9C4Rb4M8QeDLvw67Db0nwvA2DqfI2RxDZPEK8gT+/D2fpoPEH6Bt+s2
         6lnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lqs.me; s=google; t=1790220930; x=1790825730; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dm3QyVkgDubMoTiOQARsGxSnlOjpM04mOF4UOIkGwAg=;
        b=PVL+vj0smL+u7HhDd4slEKcfASGVKXzZGVEWXj8+0m4iJNEe0qYwRXSzDpQHa4OHgX
         XQxcbVY+PObhMp/zyJq9J3E4ZmFGMDicy7VbumsFcFAl9FjDHsGK8YbYgJ0oPeMLBhnO
         4mkEX3sTjwxEwyD8IvoLYpbjwi7qWivABPCYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790220930; x=1790825730;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dm3QyVkgDubMoTiOQARsGxSnlOjpM04mOF4UOIkGwAg=;
        b=thiqAVeILTovbQzVHY0xdN8iZMPDCWbFw9bdnGA4DNGPQW0RmeO6Dp6mtdwb2hByb2
         U9Yc5HW6INlp2vCUKQawyH2mT1hMyn3ytcX8Tul4nD28N5WphAaPXISrIiZGTdWW3jnH
         PVVULGwMYAnCpVwU3c89qckk7VgQIWlQHJWCpMNSkbrORSjtS/AiDPzLG3923NpTc1Xd
         hM+ZjeEjLwb6LF16jSc+p8YJSDghjHGRMiu1tq6bV8gk/OBYR4Y4zl0fCa0E5WT7chIV
         tJutHLg4dyap/OuqtKwOqDd97KFxn4Nzj0S7/RI7r5vyII67q4q8WDswRGn7N5+f168m
         YkLw==
X-Gm-Message-State: AFuF++ly1d9Cesvg+VgkfLaIne3q7geMDAN0UeFzttotp2QPZoJ0VhK9
	L70rVNjeogfx8o3azJWdHaMrYIpo6NbEpSOtTjEZ+gmlesiycVngT6nQnBA2Pth/rQeDhL+sL+2
	d/8IazfqqDluPKYE/eW0XiuoHvBVZzcRyleuaJaAcww==
X-Gm-Gg: AYBFou012WqMkL62PZYyloR+y0OJHawrfuOYOffQO2CXhL7ElkMwLpaujbXszL2jKm3
	qdWfrwgyCEywuj4gljWn8Lyr6kDeUAG/FCQg8ycTF03WfUYMbXQ8AT0Bp+Jwuq3AiqmsF0bfqj+
	5oOkVd/7y0wFmX0gpFRLwZMtYWPoHS18tG2q34eJwSGBI8hcdV2PAEKOkSfFOPe8d/x9F9BH210
	caW6KkLWuY3Cyb+IAMo0jjaSzs3Q8h1DRyXvgfEu7kbtBpjW/PRMNmKZXlLORBIoYcGt3uo6rfu
	BCPrYvanZhAEk8DCpqUl6wy5So0NApB3UIv3tNIMEugzJzB9BVhRep1jPntcgPCb6uLHhxK2pUi
	yRsL6X40xm9n2cOAokDSRhNdegPf7nwmDTYrXIICfOHJJ
X-Received: by 2002:ac8:5d56:0:b0:532:effa:2c09 with SMTP id
 d75a77b69052e-532feafa23bmr5244311cf.42.1790220929944; Wed, 23 Sep 2026
 20:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923132048.3272878-1-lqs@lqs.me> <arR6KOhDYJrK0lqB@fedora>
In-Reply-To: <arR6KOhDYJrK0lqB@fedora>
From: Qishuai Liu <lqs@lqs.me>
Date: Thu, 24 Sep 2026 12:35:18 +0900
X-Gm-Features: AclHuK-u7ZWs5YCZHarhNQR6uy_MBbFvpCvCpfsOuu3gU7yxMZlU6sPWxb6vjzo
Message-ID: <CACtPduyfC3QMKsFTLjwvVRYfa28T-mNWLeA0CPLtRM5=s2ZnDQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: fix prefix route expiry in modify_prefix_route()
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:18 AM Hangbin Liu <hangbin.liu@linux.dev> wrote:
>
> On Wed, Sep 23, 2026 at 01:20:48PM +0000, Qishuai Liu wrote:
> > modify_prefix_route() is given the lifetime in clock_t relative to now,
> > but fib6_set_expires() wants an absolute jiffies value. So when a
> > permanent address is changed to a finite valid_lft, the prefix route
> > ends up already expired and GC removes it.
>
> nit: Does GC really removes it? I see the expires is negative, but the time
> seems overflow and GC won't remove it.

Yes, it is removed once the fib6 GC runs, i.e. within gc_interval if
the GC timer is already armed by another expiring route, or right away
with "sysctl -w net.ipv6.route.flush=1".
