Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE437AA9C
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071088; cv=pass; b=TscGXS/wxhr121C7ILtsVXIY9DOAFdqVQMksNy34S2dWnHslZjidjJLJHMa1/nrJThp1aqJVJKeZSylnY0TTKnrpBbFVbXsotO9pzHY7XKZZT1eYYU+coEkPBN6AXDUx9irH/Q7jw9VAvvEnOmKyFTQSnxRoCmBQxEzqwcaj8tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071088; c=relaxed/simple;
	bh=Sh9h9dQ3B41wdeKBbZVy3TISpoHyLpEieCveSHS9njw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o08qWnleG4hd6fwqssu54PxL7VfZs+pQpmWEAza0oWxXWmAd9vzzjbHZX7xdxHeIdHnLWRfsp6atlosJCg+i9WdVx97hGES3RAIC+crncn6SQVo+PfKqscvOq8Aq2g1jtowrb9DXfK+GMGEvfQHQBXE0Kax23gtYaoRYpohNhrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh8eLURO; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh8eLURO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfa429aa6so8039991cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787071086; cv=none;
        d=google.com; s=arc-20260327;
        b=V7750cl+m3q56gcZs/ixNbwcw1tYgxTQNRhnU8ReggoUWyD9X96ZA2NUZP8jHx4xrI
         fO9V73orR2ARgxIAKXLEFGhdIYOZhWrAD32SNvcw08APdQvyJ1TmoM4kk8FfEBkvfnHs
         TYMfm98PzZcuDAZ2r3xRBESa6rOYN1l7CEFP4pyLLyhDrvrFDyzd4oCUD4ZcZnisy1uw
         vGdWYIsWad3AGh2m8/g71dx9OrLciY0Zd+qe+sM2sTgt5lB+7AMrpwj0UBHELsks9HVn
         twRgQXE/EAehMBapMemmlUgH8qzWm29cyLtJQEaHTifE75Ccrg6xuvRkZ7tYPJlcJd9N
         V2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oY4KZv/LPpDCbj+BY5rZZjX9HD2PjF++yBgjpk94Zvk=;
        fh=DmTsvJM5tx6LqSYCVh2B+LY7xZ1LJzTKgmKlz3+QQKc=;
        b=ko8LriV9VPszYTnVCjCR+kXjFGkjFVsjAUiKkK5U4LDDPewbh2+bmvIFn1GqUJOCnT
         q2VC470BcrybB10d1hof4uqHVKM/j7IGNcoNejVDMZYTYhjTCYRZzUEbHkWb8gCFQATZ
         DsiXR43WnmLXAJk1I/f3LM6Uoo4Qv2MTejN0tM5cvPsuHiC+qpmzTSGLroPeRVuF9AGv
         Sk+hqtpA42gYItpmpcVwg5upmqHpjg+uo0JlFkwUcuDM7CP7xmoxZn/mLgrthTyMR718
         zRTT+5CK8FlTOIuIYw+aJyqC+XpBud1vHDERRlvtcoZYdhMvAcTUKA8r3sFwntNNfrLT
         J41Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787071086; x=1787675886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oY4KZv/LPpDCbj+BY5rZZjX9HD2PjF++yBgjpk94Zvk=;
        b=sh8eLUROXPafRfB8JanLBXOki00XdzUCGEyi/Zq2iV8Y3qafpjr+21obipDFV9ZbSW
         Q9YmD2155Kk/eVGeMaj7NUPDWlcbt43a+iboTJQKTUWrlbr5rdKFFoeHchAtGFPJDzPe
         Cfw68h9q03kWUC79r+HYQ3ciUKjM5TalI7N+xomvuRzJ646eRr4bX/JrkHXUWbre9fcD
         xLxWnFztwpaykcCHE4XMlg8gyzzVKdv1sxqHHuW/YYb3QYz6cpvznOtPf1ug0hYfkXKv
         jXe1DC3cpUDsYRgyUd1ZqalzLowJ4iebZm+ZFXee2ElAAo6S/zt4a+wEVS7HIUEApSK0
         x8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071086; x=1787675886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oY4KZv/LPpDCbj+BY5rZZjX9HD2PjF++yBgjpk94Zvk=;
        b=rAIeBWvDovnMhtB79sAaYXFn90vbRunUYTq8DXpGu/EufGnRtAGuVxLlPyZSSKtPOv
         Qd0kcHHvwWFyy+PNJZ78iifrBGlEEFFj81QtsegZlhQevulA/0IgimUWAUzNK8suGmHK
         UKuZeJv8gNf3DS/LidlAEDxBoE4XdL4/ZrChPcVbrTvCTUpH7VCxpHeQBC+nEam1shKn
         lFKALp4Y4So96Lzy6PkSpGgqERv40oAWf0HBsGrwFx05GBnV4wWe247v8/BRnLc4MUti
         5HjvehSgDc4eq7o5Aw1NSbwZGulm5JZQqJrGbOylfzBYF8UqLvl/7E1wAGqkiNskOCY+
         5bZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+vFT4kywQzER62d8P4x3P1T8RPvDnvpDZ5eSaOaiEdevZb2Ws/8RLFjsuhE/OE2Yjr92ooFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxmz4P+NisD5NjRUqmWKNy+4QBVyqFQstEJYi6cb8qy6QgeFta
	wA4+6hxGBbTG56famsh0uRYJ6XMGgOfn0YXEeTM7FKW6sG0oM2103k2L2dV8/KsmeAJjapvMWQq
	72WI+IpM9LTjGB84tugheNv8mm9Kb+iFeP030KWzY
X-Gm-Gg: AR+sD12FRyebNPI3QshJQCw9fZpQvQFsIno6MYllcBoIrqPWNe4lWvY/YbxI8re6Y35
	QzL4BS/Ho7e0Q71fYhU/pKJQjRBzZ62W4s2Ycul5AcmoCcdPl3zrdyT8edww16p9XNeFhqeUYM4
	ndDCtMxKpADiArcw5dOroDiBUYy5USxlwuq0y+jR0vUzsJsDf5SC5vJI1gCLTiYfVWYCVrvTqsB
	NwwLgUZPnRRbszutAXemLPJkEKq52IewfZ8mPWdOKFGpFZs/2TDzTATmNu4llcPLOIPLh+yONln
	/c4hYftpcE+d7PIIdWDiJbW/TuosqSzfJdpwqShWSpXVHpa5zTuOOfPHX8/PdLdfIlzC6xU0RWe
	0BBGBYyWS9KBuPtr5GiG+jFDSM99SNNOVSkKTACNHGffmJ7yntsP/uw08gROnQmaye8tBV8QMHu
	2MLy7/nvv+RFnHJlY=
X-Received: by 2002:a05:622a:2c1:b0:50f:c403:7ffb with SMTP id
 d75a77b69052e-52dbee29221mr75074751cf.18.1787071084785; Tue, 18 Aug 2026
 09:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818162108.11456-1-a0yami@mailbox.org>
In-Reply-To: <20260818162108.11456-1-a0yami@mailbox.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 18:37:53 +0200
X-Gm-Features: AcwNN1U1om7v4QT9QgPTTnQjR7bEOsR3MTisCxiHdQ6oxIld1g0M2CmqzreeQEg
Message-ID: <CANn89iLBDiwaLZ-1cp50HQahgrDD8ZDw8mix6C+Ukf3v-4xXxQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix AO info use-after-free in tcp_ao_connect_init()
To: Qing Ming <a0yami@mailbox.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:21=E2=80=AFPM Qing Ming <a0yami@mailbox.org> wrot=
e:
>
> tcp_v4_connect() adds a SYN-SENT socket to the ehash before calling
> tcp_connect().  If TCP-AO is configured, tcp_connect() first verifies tha=
t
> a key matches the peer and the bound device's current L3 master.
> tcp_ao_connect_init() later resolves the L3 master again and removes keys
> which do not match it.
>
> The socket lock does not stabilize the bound device's VRF membership.
> Detaching the device from its VRF between the initial validation and the
> L3-master calculation in tcp_ao_connect_init() can therefore make the
> validation succeed while initialization observes the default L3 domain an=
d
> removes the only key.  The subsequent AO lookup then fails, so the no-key
> path clears tp->ao_info and frees it directly.
>
> The receive path can find the socket in the ehash and load tp->ao_info
> under RCU before acquiring the socket lock.  A reader which loaded the ol=
d
> pointer can thus continue into tcp_inbound_ao_hash() after the direct fre=
e.
>
> The issue was found during a static audit of TCP-AO object lifetime.  An
> unprivileged reproducer in self-created user and network namespaces raced
> connect() with detaching a veth from its VRF while sending TCP-AO segment=
s.
> It triggered the same KASAN report on two fresh boots:
>
>   BUG: KASAN: slab-use-after-free in tcp_inbound_ao_hash+0x585/0x19f0
>   Write of size 8 at addr ffff88800bf88128 by task tcp_ao_vrf_race/232
>
>   Call Trace:
>    tcp_inbound_ao_hash+0x585/0x19f0
>    tcp_inbound_hash+0x677/0xa80
>    tcp_v4_rcv+0x1c3e/0x3ab0
>
>   Allocated by task 235:
>    tcp_ao_alloc_info+0x43/0xf0
>    tcp_ao_add_cmd+0xdf7/0x13b0
>    do_tcp_setsockopt+0x168c/0x2640
>
>   Freed by task 235:
>    kfree+0x1b8/0x550
>    tcp_connect+0x252/0x4f00
>    tcp_v4_connect+0x1114/0x1720
>
> The bad address is 40 bytes inside the freed 128-byte object, matching th=
e
> tcp_ao_info counters.key_not_found field.  The two runs used 1000 attempt=
s
> each, reached the no-key path 366 and 411 times, and produced one and two
> KASAN reports respectively.  With this change, the same reproducer reache=
d
> the no-key path 366 times in 1000 attempts without a KASAN report or oops=
.
>
> Use tcp_ao_destroy_sock() for the no-key path.  It unpublishes the AO inf=
o,
> updates the socket memory and static-key accounting, and defers the free
> until after an RCU grace period.
>
> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> ---
>  net/ipv4/tcp_ao.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index e4ec60a33496..4dc5910da076 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1191,8 +1191,7 @@ void tcp_ao_connect_init(struct sock *sk)
>                  * at least one tcp-ao key that matches the remote peer.
>                  */
>                 WARN_ON_ONCE(1);
> -               rcu_assign_pointer(tp->ao_info, NULL);
> -               kfree(ao_info);
> +               tcp_ao_destroy_sock(sk, false);
>         }

Why keeping WARN_ON_ONCE(1) then?
This will crash with panic_on_warn=3D1.

pw-bot: cr

Please wait ~24 hours before sending a new version.
