Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4D514754
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748538; cv=pass; b=o6YtR8tsCdcfJbLvgp+irbmVIxBH5qiGzvRBcVlEpP+yHCjsBi580JuoK/guVi/GOFY1QmRq0fITt7+zX4G+ig/NEXEcPuiSjxa/vpx6VYd0iesG4XSQWXtYV3DLBP1j+x7YD1RbXYDclE9YUrHPwh643I17sbf486Up2bsH7uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748538; c=relaxed/simple;
	bh=+bv28cFDp1hCz4ppO/3tdotk7KxDsNEhJCDiI4kXg1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdoFKnXnxm6B4lv8xfW/MkkLn6KyloQvRxX67Z2rmVIBpk1E4KAHgjFqW2vzsg/LkrFJsby14RMQuUpK2PS8R1d0OI9mreWszd2KJhduQP0A5s4u1Jiu7zbF9K278o+PP49PYI49B7Lt2triSidAQbf7SZVKqnc1ElOAZf952Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBjPH9wG; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBjPH9wG"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so813807a91.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789748532; cv=none;
        d=google.com; s=arc-20260327;
        b=eqUIiuAP7dx4DjaW5FKf1mD365HDFAOybHxa09nyxrlqaXMbHJvTpt9puJubvd7esQ
         jww0GhAydWmBzrB3DQI2DvS4Hr+sP7QrMBrba0RdvNIKIu/S6tlfO42L8/b3xkmtU3Vw
         QtdKIjbhE6p/abPS0qFP9qXYsBgDLzKE4dgn6n9ffRoeSv6FyrSafewVpZE3qtDva2gI
         63vepHmkfz07IKXUdqoMZwD7YKFn8lnTIuabohPNXzyHycY5qh2u4OcVo6QukBzaFnBK
         fThSqpfFfHgRy30PmaDbGZ9hE5sKK5DdkKH0ExtVOu+Zgc7J0BOXndGx6LB7FIaHatTb
         JcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/LYEEUEJCTSCEc5A+NjwjIdHJqSahq7aUmXdkpcbW1s=;
        fh=fMum1S7uX31FUbtjCTk0QGbuIIBSaUeyTCrm1M9dGfI=;
        b=jot9lymQBMnkljB/BAHLMra9KoRWwLgcgyrY7OvBqoFpmO1dt/p+e8kfpwLnS7zM5c
         l9czFh9F38ZQtu8IE1Gi4K1ORxBP2zSzzlmpVrdbUQin3mcXoktTTk5ZUiHtVn0od9eT
         OpDJm6RxOXLt7HkMm+u4LTvZzC8nPV8qEjrAYLuIULxiAsbaFqBgLFkp6+QxXGRX3vq+
         SZ8AKKYAsR8QUqf9Ff92b0hB8ToGhBUjH8NKk+zayAq8NwVDfrMXsBIfiBGaNydIqwjH
         A14oJ/QlidZ3Uc7dLssMoo1b0LvoTSwnl/nNmqkihfa0Jhk/ZPT9p3T0G3TaAmHgi3Sh
         qWpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789748532; x=1790353332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LYEEUEJCTSCEc5A+NjwjIdHJqSahq7aUmXdkpcbW1s=;
        b=mBjPH9wGjONCeViqiT5D2zmXHfmK6speUucqdfRzwSzgwSBX6hlY/W1ixV+lZoh2nr
         NPOPLpkz8YPMT1Q3aXYVsfcU/x5LzsfDvQm/jIRkWqIjnHjT/E7N/c03yfIgAuqpzZLm
         FPB/DtaaF0R9DjZB06AofdNV4gREzNhb2tCXZYfxakHAnlizZIPilc48x6XeJzdRJoJC
         m1VRer+JxOoggOkVzNZfXPwhlCWTtT6Pgi4AsFW6yy1VDf6ZdeoSG0FmQnn+y8OyqhNp
         cTeqC7TDiNsFAv5dMEa3SByc1OqOD46jFL0qKGKCZpyEWp1aaOB89OmfsjUF2HfC8vOt
         L1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748532; x=1790353332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LYEEUEJCTSCEc5A+NjwjIdHJqSahq7aUmXdkpcbW1s=;
        b=GCbbCpTNjlpA8q/m7QZSRfsWXEfK8aIGFGomBTqdAS7JUEluPEJPHs88XRchy9r3OQ
         x5mWcqYGT/gAdK15pl1ph9oq3bxEdK0Tb89QrKu+KU+mCmOc1NSZhkld7307GlPxQSGW
         vP4BbAwSSXdluTGYHw/OnC9QNCdnf8FOgo32J6F/tWRqzHu2f5VaX+1/3UrzqvMIGudn
         zE7K/ctUJBalcAA9OnLtSz7Yif1Z0NJ7hfuJP/EsQBpSHk4impE4SCiZjNx2wgsLDaCH
         tUeWZjHjmNrc869GexF6BHw+a6Umt2aT75LkJ+BHtyKCprnZnFZevY7qvBOIn11Bc6nx
         LQaw==
X-Forwarded-Encrypted: i=1; AKwUvBzg47r3oHovdlwO7sTrCY9R84Rk22NLPHje7IszO2qZFDmo6h28Is2oXrj0e0thMLM4jH77kMU=@vger.kernel.org
X-Gm-Message-State: AFuF++myozUrvUDYsyt45V6fBtvWeUh0h+yUmkdA0TobVwvZJrlrEa51
	8+QfycyPXP9+kTNFNFDm82OHxDY/lfSJ7mBYV5qFBoaIJbb+oRqUb5Tkf38Bs4iEzhE0rg7ZbHb
	8/wVoFr088fySCFV4hrk1K9KMRCG6+tWC6afPK5ar
X-Gm-Gg: AYBFou37Y1gCXvo2KfZZydFlwuGqYdZq9aLbhy3dJaVKHu7SCeIRtO1IyqAw1XgKqg5
	xGKgGXWUD0MV8tA7UohtAfoDXbDWT4jeZEL1uqtvrQFfPv+Rz43sgrLbYBMrdbKQ3EvtaSDJjlI
	sBELlk76YFuvK/felEZDEp45QL0fIVz/nUPVm+LGNlQI/qTnqhEe6KvJIv0WYc+lebA/SoQ2Ffi
	fgrDAVCd4HAsLRE57ZJuztDghxIuUFOapmyQmv2pK/v6VGbl3fGckqTkkYhagG2aC4ru6CgOAdC
	XxbjWIQjCdBomeJ31ZuvJculDEmi6QUtKBKcVFCw7AcOtVHnojzqvs2WeRNQwkTkbAcecPDD5R7
	mFLlPjOvamceOy/sSfLbMATf0JEOQARixELu8GSkabz6yy8TDClfXXgR5sirXca9OEIE5jCFgrt
	zWrjoBDvobx1E5pJDZ4jbz/aRwG+IBObre
X-Received: by 2002:a17:90b:2f50:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-39e54e3c71emr12155781a91.9.1789748531262; Fri, 18 Sep 2026
 09:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918153604.579277-1-mbaragiola@linux.com>
In-Reply-To: <20260918153604.579277-1-mbaragiola@linux.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 18 Sep 2026 09:21:59 -0700
X-Gm-Features: AcwNN1VLKD08fJfVArzYhHKcjg0xdqCCPzeVi9-zbMxkS2fHkhyMYFmnbx_lVPs
Message-ID: <CAAVpQUAmGAACd1rBomaY-B2vRiE-VX9u4JRCteVB-940RhRtbg@mail.gmail.com>
Subject: Re: [PATCH net] udp: resubmit encap packets for secondary mcast sockets
To: Mariano Baragiola <mbaragiola@linux.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Anton Danilov <littlesmilingcloud@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 8:36=E2=80=AFAM Mariano Baragiola <mbaragiola@linux=
.com> wrote:
>
> Multicast delivery clones packets for listeners after the first one.
> Commit 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast
> deliver") fixed encapsulation packet resubmission for the primary
> listener by propagating positive return values from udp_queue_rcv_skb()
> to the outer IP layer. However, it left the loop over secondary matching
> sockets unchanged.

Did you see a real problem or is this triggered by an AI report?

https://lore.kernel.org/netdev/20260415203624.4057135-1-kuniyu@google.com/


>
> When an encapsulation receive handler requests protocol resubmission for
> a clone (ret > 0), the secondary delivery loop currently calls
> consume_skb(nskb), silently dropping the packet.
>
> Resubmit cloned IPv4 and IPv6 packets directly to the returned protocol
> via ip_protocol_deliver_rcu() and ip6_protocol_deliver_rcu(..., true),
> matching the ownership and resubmission conventions used in the
> segmented GSO paths.
>
> Fixes: 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast=
 deliver")
> Signed-off-by: Mariano Baragiola <mbaragiola@linux.com>
> ---
>  net/ipv4/udp.c | 5 +++--
>  net/ipv6/udp.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index bb8cfc62cb00..d79be57854e3 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2522,8 +2522,9 @@ static int __udp4_lib_mcast_deliver(struct net *net=
, struct sk_buff *skb,
>                         __UDP_INC_STATS(net, UDP_MIB_INERRORS);
>                         continue;
>                 }
> -               if (udp_queue_rcv_skb(sk, nskb) > 0)
> -                       consume_skb(nskb);
> +               ret =3D udp_queue_rcv_skb(sk, nskb);
> +               if (ret > 0)
> +                       ip_protocol_deliver_rcu(net, nskb, ret);
>         }
>
>         /* Also lookup *:port if we are using hash2 and haven't done so y=
et. */
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad576..ca8d0a1844d2 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1001,8 +1001,9 @@ static int __udp6_lib_mcast_deliver(struct net *net=
, struct sk_buff *skb,
>                         continue;
>                 }
>
> -               if (udpv6_queue_rcv_skb(sk, nskb) > 0)
> -                       consume_skb(nskb);
> +               ret =3D udpv6_queue_rcv_skb(sk, nskb);
> +               if (ret > 0)
> +                       ip6_protocol_deliver_rcu(net, nskb, ret, true);
>         }
>
>         /* Also lookup *:port if we are using hash2 and haven't done so y=
et. */
> --
> 2.55.0
>
