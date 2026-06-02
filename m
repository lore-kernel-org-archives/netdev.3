Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814D395ADF
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425390; cv=pass; b=sSCcpA2rG8Phuzu+cuRa+IIK2i650shZsjRZb0w+j+oz0auXhU7IP0oEAYw8YqW4NhVhnP7vJQXhvZkiiFGJ6GZ0obI0pMurb26RQbhnIuKykRw2K5VpGGB9Oefx4dsoY5NQwR6tlWxLY8g1aKg1o9WYM9Z/zLjLxaJw5fJGTIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425390; c=relaxed/simple;
	bh=xDUCIMpvhddHwfMnOPClmiXwxleY7rrTP1RbCyW5FRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeLYnU8EDS47NqWtvNFjEUPs0x4nqyfu9aqrxBBiFOKAnsIqKrS6SXoo9BCnIIqwMQkuDo2oDPB9eqvJFlXnblLU/JwBcWTCzc8gjQkE3cI1j5vrc36IcylgeekRfxH94ZdSXUAWFbyds7JNqqsytsHTn2aL8hV35je1RHneLB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waLUawZh; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waLUawZh"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91578122305so202971985a.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780425388; cv=none;
        d=google.com; s=arc-20240605;
        b=DDWhZjhMKe225kLW+K+dQYvjfRhF4Xuh0c1Q6qNSzBkPQG65XebbGCy/BxeDgEAFGs
         upiDHh5HD9DZ+Nq3/JQm3VY/O065YpHWsqKiv6bb3Y9ihCG8kohykSzrx3migu/KP8Ek
         xeaEHUEALAT7yt7gfYMrXI/SPjdVzDjJJPJ3p0FydPnaDyH1ToByHT7CiPCZ4vSJYPnN
         rdd2YTfL/yysTCH7bYg10qu1hIFEp3yQku24ol3retOiKefvN/loONN7tGSh4U7WmUbv
         bExVnQTXyxSClRmiC3WWRtiPLljCAvCN2158ELjH9WH5IOTQ+45IzzekNkV4ebnFSpxd
         Bjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2RNa5ke5Oao4DAul4E35rx5jt+KNQ5zrUMK+gHK3eGU=;
        fh=rhoW/tymbaMVEmC7gxa21x574My1zEMl3L0AfDLRJhE=;
        b=koqpxLU0ScUmwagy4dqGnHV9Wm+6AzQ77LGrqbQiFMKjgGq8YRUxk6Qt+ghTlEPWKp
         4QzovUlPoroqZct1qWkhqbM/0gVs/jlAIHJratSqSvS27oZuxr7I1lfUgwNxc5+QhFhA
         NDGcl27QS8LjRuLzhKIsz9b3XkTVWNlpyxNEESGfu6NQyjZ3C7A7OrJQoMv9YvrZfVIw
         eb+D5wT+zUI2cQAew7MGy1zlzcYsjdZDFy4CRa76oP4O23fZHN9azFYT7Dhodr5rN0aI
         +h6JUbFMmpDhCxrDgl68Y2shUi2v+Zu/wemnsZGN/mYojIq3A+7TnjPJmni+uG27H1k6
         XXIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780425388; x=1781030188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RNa5ke5Oao4DAul4E35rx5jt+KNQ5zrUMK+gHK3eGU=;
        b=waLUawZhmKS2yYyAbe8gD2YWjNLr4Z2ct7uYD84XHM7SDcTl+xzA9YA6n8RqYDkXCT
         iPPr5sysR6ZZ88v9vEE6WXAHty+rwrRxSg96Va0Zb7Gcx4wW1BEs+Z7GpsI/PVxxgV12
         nqarp5Xf3itQmbkOmB9OFz59dW3fF4huAcRNvuIoIQ1wZ48Mvci9T+bYA3PxkoeGehhh
         iPxphQPzXfwSXy3aPexpZkjxoZX54Eb4YpQZTUgitTVyknDKLmK2pqDjE3VKkl5QZa1M
         KAZtVabBl09U/B7KoO7yJaHR+vNexXqA87ndqtDawdlpaqjTtb+YUdbg5DzY67PsOJHM
         kqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425388; x=1781030188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2RNa5ke5Oao4DAul4E35rx5jt+KNQ5zrUMK+gHK3eGU=;
        b=KZyAHB4EZqBkndzHMeun903jpqncljn62WqCGaW0wAKtqaSSSRoCK1Gfd1vspFBCLe
         YE8Xk56IrjLtHeED6+G2J+l37qBzfMp1fe1aOsTAgUOQ7yPPonyNfIRzBE/0RJvLykJD
         rmQZbEvQTrpi2e0RKzazdrfrwKIVh216oC4V4WIq4may+/FDsMGAtlZZzCxBvceNN5jE
         0S0HfsOxp8bZkQ9y0CbK4IEMe3HqXj+gYXYrePCIsvuTyOW3f0i9P7KMBFhWIN5O+oDK
         JTAiwQH8HOv30PumBSA1wpvCyEPlgsJCtdQFEhRCJaYDUBrBy9xWXoMCIJ/ztdr3Osxz
         Wz+w==
X-Forwarded-Encrypted: i=1; AFNElJ8ORcFAY30oBJSFRakAK2xseezK4mz7D9f33O8Rznu4CpAY+A9LxHVHpQm/BeTIjZHrzhKWUr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBY5R3N5Jwt96kMBDXJ5vsLqOsA91yWVybUGAEX9SexoQ04yH
	guh2JQ1iciz9VKKVvqm6LNPeerriOgl5PZ+xioudNLCKS+MmwkA1ZOvwhUwPmDUT9qB75HGOCib
	jKHhXmst2BJ/p+kxdrP0065zWoJUw6GyPvJRPMLgb
X-Gm-Gg: Acq92OHnR3SrpLZ1s1tu01MC0mSpdcsotRJ8tYVvOCwtWP4JdGQAwTsD9oceMe4hgq7
	oYA2O3zlwyrfxmncnDu6qkMEu6QVwHgjblcu6v80iVgB8hRlB20bXhy3zJpSAdszTJLPzEWq0rf
	Fz7NuQVs7QHozs9lfbWVhW7m9hQ4NCHtLMVnBGYYLQyeywA+ZrEfNX3zdNFc9NyZpQTqTmgU2Yx
	7VQZZf5+H/fofKNUprEYudY+bIx+/sYOIjXaKHKon5L9QGQ7M2HRqHFEBGDkXbb6fH+DZ2KRG88
	gbtWnGrlPtQk0/Ar3jOW6qSmstX3AjPiilg2f4MvKGQdu8nYo53IB1L3RaRLX9Gk5GeL0NgVDaN
	IuqK2EvLGJ9BILf09nEIN6hucgzdM
X-Received: by 2002:a05:620a:c4e:b0:913:e19b:2f56 with SMTP id
 af79cd13be357-9158a659566mr47441285a.10.1780425387913; Tue, 02 Jun 2026
 11:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602091319.1753654-1-edumazet@google.com> <20260602105726.0f7f0d8b@kernel.org>
In-Reply-To: <20260602105726.0f7f0d8b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 11:36:16 -0700
X-Gm-Features: AVHnY4LO7YD_B6en4nldcX52_svGDk7RFTw4EQIK-YMBMWCQPtDTdgV8zhG8Nys
Message-ID: <CANn89iKPWNAh8wFWRVbwJyM4gO0sTjKBTobMo_f+0jjXuP=k1w@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 10:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  2 Jun 2026 09:13:19 +0000 Eric Dumazet wrote:
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 74507c006490f180d2fac6594f6dcf2c86d53919..bfc847bc47fd957b58174dc=
4d2b82e2e8b461405 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -5660,6 +5660,12 @@ static inline const char *netdev_name(const stru=
ct net_device *dev)
> >       return dev->name;
> >  }
> >
> > +/* Caller holds RTNL, netdev->lock or RCU */
> > +static inline bool dev_isalive(const struct net_device *dev)
> > +{
> > +     return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
> > +}
>
> nit: could you put it in net/core/dev.h ?
>

Sure thing.

> Or alternatively rename to netif_isalive(). We should try to avoid using
> the dev_ prefix on APIs we export via include/linux/
