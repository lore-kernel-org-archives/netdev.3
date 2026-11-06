Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926203;
	b=Xi9oMTeiN7DBAvevNOSZAUo0HorXT0xLmJm3gDSXd0wkox23lZeQtdX2biGngaFg74iK
	 WNR/ApfsSm8xcmq99XA7qyLrdbQv+bX84fzaaAxb70L1gxWlZnFLgNCl41oSqIl6Dhv4u
	 NKdE5hdYgaR+jumJ6y/yXWC0DVoirRdZBhEZnlJ4Ln1wEnx5fdGCIy4NUWWVaGRi47v46
	 //m3XT/cqowsJFSwIxOEDEoV+2WdcHDwKGtUuypWjfGgenxVC7rv/xzfexdIOGriEwo7I
	 KjIce6BDNhzgfI+GS47YqbVx3y2JnVK3AQnyjLCq6e/aNIHnMMNQg+Qraz0bK9xWrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926203;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=li0w6gdCJPAXfcZnkZrCMDKNOMXUju5VRPPg+VyiW3Y=;
	b=IrHKrwgSq7nwOAcnVP/Abeq9H0D4erhbuw890h0h48FngZyeHSX82c26AXRWlvvJJ1sH
	 ORIeoW0nA9q0LanEP3swLNzJT/WgJ9vnb1aZyFrbMJJzTIqbagbMgcRPhvZ27QayGNsxW
	 u8S9R3k95sxxWij8U3bwHWFkOjPRXZPCQUesng+MyBUp42NZPrPoXn/6yI5muyNOtt5cR
	 CN6gPCgyY0KJJD3f9pDMjCwMrOq5/DBjY9qnShE3mEA5iyZQPzyTRor04x06BlBM1nWPJ
	 epO/tyEmso2KNxwLOKQQKyG3mree29VYSKMMeVbkRkVm/FOv50TCgjMygukznjXENKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBwX3tiS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E4606A31B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBwX3tiS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9CC1F008A1
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926202;
	bh=li0w6gdCJPAXfcZnkZrCMDKNOMXUju5VRPPg+VyiW3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JBwX3tiSFVz/SCekdDd1xZteE2je6TCPRWCwHiiSLjEN7Y0A/1bkMbssSXyVdf0iz
	 zHQgL1+4ps43I4bZ3xp23SQXtbxQ6HXtCCnWjmmTceyTb9LqpBu391iElcG24drXTV
	 Pum4uP+9FgqYbVxobLO4Y8bQb2DzXJY0OsYQVe8l9E13wPg1FCI3TKxWbaS3MhHRdj
	 Og2zGGwq3GUPk5MP6SwLjRLjPJxvzExuqJ6v+j9fet6x3Y8HiA6EHzLWcMgnHTmMEF
	 HGKuVupyGbtYpEOPjFoQJxHHrB/0L216vjQPzn/tD7f1F5W9x/5VRTvdajorBhn9PX
	 aJ6Y3u3yHAyjQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-7143451981fso106297eaf.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:50:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwimnPYLHxWAKBSYiudNr1D7Y+0hwIdpTUH3JHK7UYM9z9Mpe0Kx6rCgBnurs2cJYnVm+JNWU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YeBhx8IjQWQv9wkqEG47pa3g1/ZenYLa31BTM0M0nb3+OjZlI
	HS/ve/TR5WYYEsnMbDvhgaCRgY3sJJiM7FXTcRFr3JDgqWxpGf+qJOEc52oSodI03nPkoluyGtQ
	Bk8gs7K3iyWkDPlxRHVHPddcYisBQ+8M=
X-Received: by 2002:a05:6820:f015:b0:715:2954:68e4 with SMTP id
 006d021491bc7-716e7942d56mr812677eaf.76.1793926201626; Thu, 05 Nov 2026
 16:50:01 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104150318.1156620-1-edumazet@kernel.org> <CAHC9VhTSCSV-Lic03yzqU=z6OgVZGKUfdUBfYAHnezkTLqOETg@mail.gmail.com>
In-Reply-To: <CAHC9VhTSCSV-Lic03yzqU=z6OgVZGKUfdUBfYAHnezkTLqOETg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 01:49:50 +0100
X-Gmail-Original-Message-ID: <CAL4WiirhHK5=CC9=c=XLR5dFgU_EAH6W5tZfcvgBsXdrzRjhgg@mail.gmail.com>
X-Gm-Features: AclHuK-cUj6ktjY8HuBn4RvzP7D70TC4okO5iksryY4sTrtwiKEXTCYutGdCBV0
Message-ID: <CAL4WiirhHK5=CC9=c=XLR5dFgU_EAH6W5tZfcvgBsXdrzRjhgg@mail.gmail.com>
Subject: Re: [PATCH net] calipso: do not charge request socket options to the listener
To: Paul Moore <paul@paul-moore.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 01:10, Paul Moore <paul@paul-moore.com> a =C3=A9=
crit :
>
> On Wed, Nov 4, 2026 at 10:03=E2=80=AFAM Eric Dumazet <edumazet@kernel.org=
> wrote:
> >
> > calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
> > with ipv6_renew_options(), which charges the listener sk_omem_alloc
> > through sock_kmalloc().
> >
> > tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
> > so each request socket leaks its options size from the listener
> > budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
> > calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
> > all subsequent SYN packets. __sk_destruct() also reports an optmem
> > leakage when the listener is destroyed.
> >
> > Uncharging in tcp_v6_reqsk_destructor() would not be correct: after a
> > migration, req->rsk_listener is no longer the socket that was charged.
> >
> > These options belong to the request socket, there is no reason to
> > charge them to the listener. Change ipv6_renew_options() to use
> > kmalloc() when its sk argument is NULL, and use this from
> > calipso_req_setattr() and calipso_req_delattr(),
> > like cipso_v4_req_setattr() which uses kzalloc().
> >
> > Note:
> >
> > After this patch, calipso_req_setattr() and calipso_req_delattr()
> > no longer need the listener. Commit 10876da918fa ("calipso: Fix
> > null-ptr-deref in calipso_req_{set,del}attr().") could be reverted
> > in net-next (also removing the then unused sk variables), so that
> > CALIPSO works with SYN cookies.
>
> That would be great, are you planning to submit a follow-up patch for
> that once this lands?  Or is that left for others?  Either answer is
> fine, just trying to get ahead of any duplicated effort.
>

I will provide the follow-up patch, thanks !

> Otherwise, this looks good to me, thanks Eric.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
