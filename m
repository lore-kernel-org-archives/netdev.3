Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA933BBA0D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835104; cv=pass; b=iN55TptIzvsBBWzVGu1CFYCcnBoTzt3PuDkK62o7WQoELH97IMyM5hCToqEkLFnchllEUgQ6Khh1XGJZlr4Y0nMakav+a9SlG8SofPC4W+60GjR+ravXczY/KaQD5N2pKDixk/d4vCwX2lfW1nw2n5VILM4YenBjO/8nqyS3ugc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835104; c=relaxed/simple;
	bh=9CqODtrMg3/CWIZedjDFXAmbYBfJDtfkHV0FmFGgZcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGa5TsfdE6ZLNpvEDtTbLYU717shKvVrH8882u3lA48rZUwvhMa7vnBqL7BQdD4OUXe7afEXcgMGtirsX/kLpfTOQxZ128eESSelOeHuvifFbGa0th5sPu9DmayqZ4GmwQxY23+pN9kB8wr1qU6dZZCdyi8EgKIErW6LuJBr9rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLYUJKKr; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLYUJKKr"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so3161842c88.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791835102; cv=none;
        d=google.com; s=arc-20260327;
        b=SfqEbhAq2s56/aesH+tXThNEEZoWdz0jxepHInu2KmVJHUaFkvkNTLnPOXB9zs3SZk
         nWz8ZzrnUO3HG10iICVXA6iFMO7s3W1RAKrUFyPqUfC/HIxTSqStC6PnUHXTaQ+g6NE5
         fGZEb1vtDvFWi0vdzmFIqBzRYrUrso9strAsBeY4E8zthTB2Vi436P6+74nyz9RkA7gu
         G5PD9nj0KG4v4IQCXlHDiKVTvXmRfexwPuDbI3teliLEqym9y2rwW4cDxsv+1nKIkcK2
         7TozsNyY+7XnpJjr8kQ3S6BNCHtD0NW9SsyPSbsdPicDYFa/Cb8Wh25xvizBJXo+zoBp
         Fj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9CqODtrMg3/CWIZedjDFXAmbYBfJDtfkHV0FmFGgZcs=;
        fh=sn2/MVxEyDmQBvKVuXg4Y/RxixRTHCYfwO1lSgWSCG0=;
        b=faUyeZJuQOU2g54TBF4vH/Jx5OQVaFmKlqnIjBtabFngRQBxh+jDUNJ+8Zp7N4CWkS
         rr3kT4rf345k9pTPn9Isnxemxm21b/RB/bGW/raYsKAByTu7Syx8uNyCab3M96dVKSZu
         l7pM3tQYcJHPm6lqvgKiL6kGudPFA4JQpHBucS9Fdk+Vs6KWc3CgWd94IcdxsUPr72c0
         7c6XAuUYn4+6XeVyLrW6wCXM+koyfHdxu+bdI4VPIgnW+UHGQJ9vCRDhVDB48lwBR9SI
         k5OUM09iErc3jXQSSjl8AJ0kKcb2kfXbH8ZwYYGMwN4kJfTtiNaC4OQlfUeyZ3Fp4Oqc
         6VIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791835102; x=1792439902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CqODtrMg3/CWIZedjDFXAmbYBfJDtfkHV0FmFGgZcs=;
        b=nLYUJKKrRc90LpSgylw8vAQXOBWdZpod7ks5uelSm805CGyKvb2ouSbdoJcG42tOth
         03ey2TBV/hMV8HVjbOskG08X+HeitUysERlWPJ7Hxz9JRFmbFesZa4856kU08LWyHavS
         6wzE3P3W7EzKA4TtwpXx3hWBQeUShxXakWgoj3j3XQOm/KTrf6TsErkISI5ofyVVpJ3S
         k7PH2OrQGYAyGGMbSkM5L3oYimxTN5p0gewakKcJheMFyGDMaw2zkCglk0SW5luuM0sr
         yV8P0b3hGSo3nGY2qKeWiEd5+dXlYikuaDtlSNupGA4qvH+/xfhzTs+NBT9ltdH1QY5T
         vWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835102; x=1792439902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CqODtrMg3/CWIZedjDFXAmbYBfJDtfkHV0FmFGgZcs=;
        b=PqXqoTyMTSD45cST/3gDmQ/KP1sGOpykxE0v/ndpduOmcP6wE5U//rSuk7Y6mwdgrw
         j0ZC+xaSeB8GexpZtZEJf+gNXg/eX+ckEkdYpJEDF+xFZ2oMEKHmU5RXc96F8OXDnftD
         M+x2v3GXSY7Vn2PLbKk50Irh5gaoAaee8Gx/ARJWJSD6jJKKwZkS7i8pyWFPm+LF05Fg
         p2Yj4vg6Tmv7r+Wv2q7GbdpcIGmw19b6CAJgItVmKEsLrb0IdqPAJLkEDS1xbHvP9Ck6
         W2F0czdZOboG6e9HcR+inox15NatX6GTAnEoZpbdbklU+sLFhWcua8RrLj/XZrhDiFhl
         /3CQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGYG4mG/NX8xwG2kk4CznpJgUpljVlU8epe9n8edCbdKyOGXn0tuZg8U+UmdKds2vD2B57MKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYICwtkD++HWrZCKR0486xzF2gZbwx1rz2cEGMAhSniyWdaX1rpJ
	AKEuDq+FuW7ZtMZgyBvZ+jOUrB4w2llbAYEy9xQuJMRPC5XtCWWaNJT6X+SCzelCtQ1R05DgCId
	d4Hodxlr+6kM6jawEvc3E8k4jiwMNBveXtjuR5NKW
X-Gm-Gg: AYBFou1i/8s1OZB8j7OeZaZUZ54dh1+PeCL4p+eJq5m0H0+dNoYlA4i8yaDyqSJCrtw
	Pro+JGhyhGtgWcIv2MlUMGAc3EPif7HLddyqOrnNF+JgM6dsxZxORijub9rN1g9DFOPFuz8e5rN
	e3ch+KVnF1msYYau6dlMMQBzPoQoo1VXsDgfiV54NvcJ2qXeD2n7yKo6ia2hdsARqs847IXwaYO
	blLHTM3t9y0nd4GOjd7RUpBEkZI4Vk7mrvuk1JHETKAu9JQIBo6orkWAYA2NSEod4ON6CQJWtM/
	+8PS7cGpIRt4GS/06zD/Dja2ekx6cLls0nHEIY4jVL69IfkVfYd0jtShMawjdJ9U02aunAH8Xd+
	eyXMrA8F4G7fd0vabCQ9aVd0XQz8qnYqe+eHqUszIIZOFSCIQgfUUativxugSPXc57K1OzVmTav
	gmCrO0zW36od4zDTBrf588e+CSZ+yumtJw
X-Received: by 2002:a05:7022:927:b0:150:c9c5:1ce4 with SMTP id
 a92af1059eb24-16a56ab133dmr18137447c88.6.1791835099991; Mon, 12 Oct 2026
 12:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009074405.727999-1-edumazet@kernel.org>
In-Reply-To: <20261009074405.727999-1-edumazet@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 12:58:07 -0700
X-Gm-Features: AclHuK8Ph1QicxKSbFP6g7v6tRyuraJCu_WyYr7x5BkbyhfjX4NwZ3JJFI1RoWI
Message-ID: <CAAVpQUA5FEMWV1R4vy2+uzQc+_iLDaz4m-D6kfKYngGf2sE0Eg@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: use RCU protection in inet_netconf_get_devconf()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Baul Lee <baul.lee@xbow.com>, Cen Zhang <zzzccc427@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:44=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> inet_netconf_get_devconf() runs without RTNL. It uses dev_get_by_index()
> and in_dev_get() to pin the device and its in_device while the reply is
> allocated and filled.
>
> in_dev_get() is not safe for a lockless caller. Since commit 9d40c84cf5bc
> ("net: devinet: Reduce refcount before grace period"), inetdev_destroy()
> drops the final reference before the RCU grace period. A reader can load
> dev->ip_ptr, then call refcount_inc() on a zero refcount after
> in_dev_free_rcu() has been queued, and keep using the in_device once it
> has been freed.
>
> None of these references are needed. An in_device is freed after an RCU
> grace period, ipv4_devconf is embedded in it, and
> inet_netconf_fill_devconf() does not sleep.
>
> Allocate the skb first, then perform the lookup and the fill under
> rcu_read_lock(), using dev_get_by_index_rcu() and __in_dev_get_rcu(),
> like inet_netconf_dump_devconf() already does.
>
> Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()=
")
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Closes: https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xb=
ow.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
