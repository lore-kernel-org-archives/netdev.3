Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D336492C
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399015; cv=pass; b=OY+ADO8V/GKMBDD8Z6b3F84QKTsMx5/QqI78eo28kQNUjN/ZUjeSJ1897Kq+3x26wXn+Fw8N+tbnpT8nzr4UgaOSpkXxu6zUrcex/Gk/zp5GQlgT7L7wM5A9Twk4+cubs3IADCjM2KSAGKaOKdafUQdRESIcCBHu2osNww3wqkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399015; c=relaxed/simple;
	bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCxOtyJgpSU+6NLI/AgVMEMGgobopJHPQSOibo7RN7PTj3LDaNb9uRjtU1ECndT6ngi4JJIab9BOlQx+/eoJL4+u/mzdv2MB2UyGWznza1hxLp6Dkdp+L8HSdRyBWSKd1aIf8/ba/4lfxmBWgKhddxxzt8a+mdo+LsUmt5pAVc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drDESDEZ; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drDESDEZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c029505b389so361196366b.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399013; cv=none;
        d=google.com; s=arc-20260327;
        b=YLHJ77gNNLIV96Lc2MkkcjqVkvgdAKoEEfDm2g+czSSrV7KrEoD03oPJZ2OAkLaek+
         rUOxU2tsnRezp+B86w3XVd3/U4GZdJThyMMDK3HyA7xLt2jbhtp+4VPdU5GadvDaqD4q
         sjXeOebpZrXzFvXMjEhlIrFt3ceP09VRANb4SmuQMNugEmLN00C3OvBG8kKnMao8nI4m
         LWOK17dbafgxJCKOh5Dv1xcz8QDywxXGaV8GVsRH5hhCzeIwdkF741zzfVPFj2bR4iq1
         ar9iSsxoQbuDw73NwmjVLyeaW9rxQjf/DlNqAxcROJ6UTd7/QDuHB6cRcz4faOrho4JF
         CtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        fh=o2t8AkqUt1kzI8icXtPcxmiSNnH8iX5pqT1GlwBwkas=;
        b=eGqB8xTbHla+PclI+k1L1y5q7qUJzcsy3nB7nFLuRYODZrUfWLgB6qw4xfxFk5IUz+
         AfP/4WuPCwI2WjzxeMeItxDUtS4jPalzq5UmIaTYAGN9t4tezZrnH6ICbPVDphDNg0n0
         zkfLdWM2x1+JXATnMlp7zM4TINtvOHAEa2RHfRBkID6DXtAn4o93+HWNk75+2upsQJeH
         HIhmSoY4ZVJewH1SSxuGQ5fuop+8LqybCqjl2O3i0fmzbn41dIrbRv+3MbfpyKNP4PG0
         IYKXdSoyVodIAA7b3s1t1KfOgqNxRdt6ulWRTHucq4eIywRIlwcmCaPqR6ROcLd1dvKH
         f2zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782399013; x=1783003813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        b=drDESDEZDGVECP69GsOf/aVzERtoJmC7Tgz+HZodsdcOLiLLIUOr2C81KDvVEXCg2e
         07k8cVx9aCR0ZrZsl6Zky4Tm1zANQxx4OB2jrptqkb+LJxMS5naBrJ4dDaASKAyWnq/S
         NTrsNWFHEntqm1Xlqnb4ea7pkhAOs4/PMklJ1cFWJiKjBGqar4BfoaYgHRg1I/9OtRmB
         D1wtz2+LvGGhg7+iS+cC1CcwHb+ocPVysR4HYG6lEy5MuMYD9AWHFwP8GZyLPnLu2sxK
         rfl/ye4MuxMvLZ6dKhkThQf4ad9ArxqtillOVDtjvPW1FaxlPyYhtQcmhuGZjiL/uTKF
         tXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782399013; x=1783003813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        b=C2YnVpEgqXdX3rIQXTIngf6PCffGHZ4QdJvuyju5f5ykP6JGPXzrtlhej7eF+uAbw/
         I6GA0fbg8ZsDZHY6sDYJknHiiQrJlTJtZ4b7znZhssVXoH4sT2KffxIkh1fSn6ofLKfx
         zVLcIM/U2tYSYFeaC6IyAhHnQaIG2UQfH/Y7Hvbkqg7tX5NWSxV6xHa/8+fgfHTNfyol
         kWzs+NKN/tooN1t2+VAn3o5uQgqlxI6gx0VdwWQltSTHYOQFBwf8e1pkXg6BtnR+BRf3
         Squh40XBxFXTTWlHZNDSSn+5il/1Lt2Bcl1he2vved7xFfKaNQGETT92Y0nR84UqkPHd
         Kn0g==
X-Forwarded-Encrypted: i=1; AHgh+Rr319pElee4Jhysu3JIiU8ZwQtamP2Jr5tLZs7iXYursQOST9l1XBkGoB6G37nJYnKXJRt05iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyJmT4lf3G+BTT/soW41Dv+fH0U9K8W8PREV2SRbliwGt6+Bx
	BJWYsx+AStSMKMKKT9gJeCC5vOx3BYPii7llJfZ6+xZN77PmZoky4vdBborENJ3rJN/Ixwq6xY7
	6ySZ/YT41L2vBEDbfUaBrgXfV90+iU90=
X-Gm-Gg: AfdE7ckYAXC/s8SsNKPejR8gTZd+F9E9UjQaXUaWjdugrYvnEFP7koRhYaRuiVJXOK2
	gTwgDGJXAgZXQD1BwpWWU84zM4zsDZjBlTes1MLKYFCG/Ir3xzViTMxJkjUk+/em497MZMhUk/2
	aI455MdHxkO28s1h768xDn7LAuu72RoX+ddU0ToEro+x4vWwlKcDi65oFF9ycr02UF1/bBjxhiK
	YFnD4D/WrnDJ5O7r/9HPA7JrPMyxdQ1fZE7wUv94Zduu44luJmA7Fx1hd6XwCimike+/Bk=
X-Received: by 2002:a17:907:8b95:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c12008a8cc1mr211733066b.1.1782399012826; Thu, 25 Jun 2026
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org>
In-Reply-To: <20260625054005.0016.bridge-mcast@kernel.org>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 25 Jun 2026 20:20:00 +0530
X-Gm-Features: AVVi8CcTT3l_BpCVPjAw-OuIdN6h756FNAzVYw4MZY-iVizeSs0vzY6v--L1Ouo
Message-ID: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > Please backport the 5-patch bridge multicast exponential field
> > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > e51560f4220a, 529dbe762de0) to the stable kernels.
>
> I tried, but it doesn't apply to 7.1. Could you provide a backport please=
?
>
> --
> Thanks,
> Sasha

I will create patches on top of 7.1. But tell me what about all other
stable releases? I have to create patches to all stables and how to
share the patches to you? Via this email or any other process? I am a
fresh on backporting my changes to all stables.
