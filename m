Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2B23394A
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679043; cv=pass; b=jG/CaI1jk/oeDvexN7O9Xf01dnHzEvV7iZSjY8Jodz3J8/ffVvVtc9sforpsh8R917tFYi0Y+CbMM7DkJX2uEPWMRCVjs8LH9EELOcX7NN4eiE/L/+x5uEwSxNVSfcV7Ph8DpHf603NTjOWD3MOUBefBm/N4e4dIvyNFRFQD1uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679043; c=relaxed/simple;
	bh=KHQOJXBqqLj3KO2reyhXh3CqJlah5G2nps5U3bD7YOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Usw3XUs6oszz95ssTGZgw3poUxlHsmknS4YP3Mh5IfYJ90I/lT8ICzqfGPxd5M45pEXISVLoMALEe6W6QZ946d38baO4RVhW5dZV4lN2O8V0I0AIUYoYrZzZQcdobVGv8dlDpABINObNqjGJh/T53oAwCkuuUNW6InfVz+ngWjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdPvRw+w; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdPvRw+w"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c149c5722so69229691cf.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784679041; cv=none;
        d=google.com; s=arc-20260327;
        b=dPgxCUwTlN+CdawG0wy3cx/8rTNmnapwNoju3VBS8IJecAPFmtuB/jYuVGJoiagt54
         K/OMYL6Yj9jGanZMEf4do4hedbCPwiMpaH9pkd5oEa6zk5+eW2NZoPXro9CMM5dgqnYZ
         lstBv5PeJtfTq2OSI3GCE8Lltux8xe//yIzPBCun9JKQ8puGhQiTI0Beh2RFMmBFLJyP
         lLhzUfpAgXXjaL+H+lZtKhtFy7atIuqQVr/RPFIBsRAclR5I7i9ziaUU8NFAUpCZM+Iv
         I4opLDa3CWXax+PITIWe5j+w4OXhqFnVXpqEHXTNS+SDIFlUh3BUMaequk0eto4t0vG2
         U8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ej8e7MQGA6JTLUveXIABd/DZvHnUiwJ/rDdcOB/ziE=;
        fh=QvdfSMmZEI99J1nGAc44bs9krVQgLphv+os1TJh/C4o=;
        b=N7KnT+HTZyl8TehsRCejTde56qzDSZYAPqHHSHhbe2gFkv/cKwsInGI0P3l2mgeL23
         h4sJNe7ARfBJeo7BVdBLLu0zsM/joq+08xufZlHYegxXhUbIdeAA/z5wFGChVMx6VJ+K
         vEww+94kp7oDCRtFLlmB7PIcqfN+XvIXohpQNKKKIpO0E3IV9yEkvfXLrywQhuHsE5//
         E8HnYt+K02hyhjJZEHfl9/4IWBc9p/kaWYDsGGvFZD/KePxDRV3MTJimKoWbc096X3zn
         VhHd6nEvTvkbfzvUsPb9JOBsT9HaVmzFbRcIgldZuPK2LNJWMzfJh/UqGi/VXEoQNDf7
         eFRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679041; x=1785283841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ej8e7MQGA6JTLUveXIABd/DZvHnUiwJ/rDdcOB/ziE=;
        b=NdPvRw+wUDWiXxYopFvAva2gKZYvjqMjXSCAoHiWYgANCmoh8x9CvZS/kL32X8wJ23
         hQxxwrX2qAOIAbISoCysdIEW6h1M/g7mIejD2GSbeURThmdxea+244XgebhT7kL75MrH
         OyxaoYu1HRc5orZCG/AT6VCb3dBxj8G+4TkEf/AFB2lGdKSqrjXhg5+I1um2/ASCFh/f
         0iXkBq/KZjSMIiR9pMKaSU1FKX3Qrpom918rRUBm3UqGomaIwHGXD33ZN9/XAeY/CBz4
         cpLmOivFUkpI/nWBCvTPref+Q7J2mwRa1wf4s2c8/6QkBAdM0I717yZUOBarnLW+m0/S
         jQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679041; x=1785283841;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ej8e7MQGA6JTLUveXIABd/DZvHnUiwJ/rDdcOB/ziE=;
        b=Drf01ms81DTRRlHB2gn2AkncQ0tBRe9WO3JRNyRsYpaE+hcSXdgN3ilFlKfZIdYxND
         3i5n+Q2aSOXJJLlGdzUdbUtAWG+qOelFHmoWFZOLxAHl4ysFSdH/uzeJ8LZfkWX8Kis/
         M2Yj2PZs7ZOGhwK47x0VxVj3Y12kyw99nfdFLDOTXP82oan1hXxRjZfg7rRR14F7wYbh
         sY6+jEjmLr0HBC4XdoLuaMKygjP20x7iHPWiimr0c/U7fLc3O+nWfnkuCEKsr08V4X8m
         1dtOt+HbNHbC3QTF0ecWVUXrKtmKi/hi3OFssEl1euDlg/EGvjm8eBTwrozch53xlzib
         zxJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5FbDY2e7etWn/KRw1w2xubDIZMcDcdayQAtgylUSppUCCtL5YzmLXEKdWOZF+ZswNYXdccAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1QfE2PlXVlHfh3meFINcWxPt75/oEYkFuD9LDTNHfzbD4Xvr
	NFwg2uVTWBj2RcHruFWXVWBE39rkN55NCaSCATLfsapjkDdYx6Sy9cxX1FLQz75iX1e33IxctfE
	yXpHgwEkJwX9Ei0PtMeG2IPzghWBcIj7UFkW4qXhz
X-Gm-Gg: AR+sD12gMr1Q4VBpIF9HxBbajUgLozcg2MHGcuyXxouddgQneldfoYKkr/2azLpqeLt
	0osQztg7tvwXqRSFoCT4ZBe7ruQiSYQRtAJ4YL9VYELdgkw0kgUmhe32psN4BCwHhQGGQRZfAoI
	IeVv+pctlwaQStB57av1ajzyIm12GeIKuWqiHS8iW9LVx652HYQfkeUcEQro0X7tkolI09H+5ZZ
	3cGTLMdGuvXTV802IyCfsQE1uCAriVlOZjXcV5C9F7kDbt1idYaO1nVtKoI3CyvGFYCMiSPrEEq
	wUuxo9c/f8AfFOIM4ZxWP2uBmjt3/zFwWGKmZzt+BaVgZZx3+bBHRuHvNa62e0ocSkDEHbfQjGC
	EGsRcJhU=
X-Received: by 2002:ac8:5d87:0:b0:51a:8c86:bd2e with SMTP id
 d75a77b69052e-527a8a4d14dmr20604031cf.35.1784679040700; Tue, 21 Jul 2026
 17:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721232805.2451198-1-xmei5@asu.edu>
In-Reply-To: <20260721232805.2451198-1-xmei5@asu.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 02:10:28 +0200
X-Gm-Features: AUfX_mxJ5SSWLxTv8epTNEj2INC9oy9rYX5tI9L0TW43erRbdqNDYQo4pg9Jysc
Message-ID: <CANn89iJkaPSMay3o6ibejpZh0p7MzKOjDps=6wVpSeAaCRRL=w@mail.gmail.com>
Subject: Re: [PATCH net] amt: linearize skb in amt_rcv() to fix use-after-free
 of cached headers
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:28=E2=80=AFAM Xiang Mei (Microsoft) <xmei5@asu.ed=
u> wrote:
>
> The AMT message handlers cache pointers into the skb linear area (grec,
> iph, ip6h, eth) and keep using them across ip_mc_may_pull() /
> pskb_may_pull(). On a non-linear skb (e.g. a reassembled fragmented AMT
> membership update) such a pull can reallocate skb->head via
> pskb_expand_head(), leaving those pointers dangling into freed memory.
>
> Linearize the skb on entry to amt_rcv() so no later pull reallocates the
> head. This is a no-op for the common linear skb, and covers all handlers
> at once. Drop the packet if linearization fails.
>
>   BUG: KASAN: slab-use-after-free in amt_igmpv3_report_handler (drivers/n=
et/amt.c:2023)
>   Read of size 4 at addr ffff888013fdd71c by task exploit
>   Call Trace:
>    <IRQ>
>    amt_igmpv3_report_handler (drivers/net/amt.c:2023)
>    amt_update_handler (drivers/net/amt.c:2503)
>    amt_rcv (drivers/net/amt.c:2846)
>    udp_queue_rcv_one_skb (net/ipv4/udp.c:2389)
>    udp_unicast_rcv_skb (net/ipv4/udp.c:2580)
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
>    ip_local_deliver_finish (net/ipv4/ip_input.c:242)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    ip_rcv (net/ipv4/ip_input.c:612)
>    __netif_receive_skb_one_core (net/core/dev.c:6212)
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  drivers/net/amt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 951dd10e192b..2bce99d45d2c 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -2785,6 +2785,10 @@ static int amt_rcv(struct sock *sk, struct sk_buff=
 *skb)
>         }
>
>         skb->dev =3D amt->dev;
> +       if (skb_linearize(skb)) {
> +               err =3D true;
> +               goto drop;
> +       }
>         iph =3D ip_hdr(skb);
>         type =3D amt_parse_type(skb);
>         if (type =3D=3D -1) {
> --
> 2.43.0
>

You are essentially killing the performance and usability of this module.

pw-bot: cr
