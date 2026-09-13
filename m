Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226F296BD3
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340894; cv=pass; b=diyfXik8VbABwfmgOvZau/CiwDWe2nmv9cfJxbHtG9vYCbs2nNfAN1PXj3RX5fI5ixD+FuwP3RiFun3VEgFDWNjVIOtHVmBQr/oh3V+xlJKY8iwbjzMTUMgBZayNXx4RZq96LigFboOH9Xnu5LRQ0s9pje8J7NOdXw8QyrNkMfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340894; c=relaxed/simple;
	bh=DXes9xsnyMTyzixU1rmSeIaBDLxOPxqOwPIfYET+/jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE/1ZUrv1IThZsA1/gKOL4rW0S2SV7w7nfuf9XzHs/DEfenfpqGrsgvjKAiShkyroM6UfUFpTsJec0cHgnedRrBi5AkwFU7Smk89Gs4d9shvZ8tiglKU7N2RWlHrepiW0S8PDfHwRYrr/0q1qfRJ8IhRM9zgKpITf/NtBWSynrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn5toEpe; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn5toEpe"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530c602630bso16281491cf.3
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 16:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789340892; cv=none;
        d=google.com; s=arc-20260327;
        b=bhCZVW9VN66OD9qVUAY8QconITP8qovHK0ZZYrX182mJHfr+ShvbW9BCrO9Z1E6Uph
         N65B/k/Ux9/Tto4BqYWO+znv2cCYWoPhQ29UejA4TFbopgV+omupwP/cOktKxO8CE3Z2
         7Ue7TFKquFqGlEpNWBayReztyiyQ17YiWR96yVvHhmq6JKFwXJztX09AA8/l4bjoDcYi
         18JL0KwwIUHPfQSxeSac8iHMYXcFMPHEtrUgW4hn0lQ3QZfCfShhpVWjH5eQEs/tD2VA
         LRDn1iHrsKDr3qQmWpTl4dgPgqhrZAFdQAbb15etKwsPqJGQyU5Sa6UjZxhvuxMRf4pf
         cREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xRbG0DVQ5VHY3qqALlMkPrYtIobPfZTAAIFgs1QLm4A=;
        fh=5tT0lJBhwy12Clq8HwSmHBj+grk73lJwqjU3wWYk1Ss=;
        b=Xg3tYYaUWoGYt1TTVhqoVNT0snBhBNvD+foXEU10zz8LnZxvYjDlV4btX5v+2MQRG0
         LQ2MQHiga/HQX/sZJFdj6EAHwJHofGYwz9Mj40udohL/HlMGdcvPqh0jSSYU8k8QPDGZ
         FwselL8vRdawtSaqrsn8Kqv8x10BnYS2p32E7sZkn7aUtVB4/NmgxP2AuSIXEkljRCdX
         +JMJfnThW3o/MP+l5OJp71vFUfx+ZqIlRai6FKWgGBfxP82ly27xIdegRCxIqV2+Qj37
         ptsBwbg/hSiQGx3iPVUtpnvARB0ihVfkOooE5WII3Pl6XYEGev+PjBVaxZep6lRxMO6/
         zPGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789340892; x=1789945692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xRbG0DVQ5VHY3qqALlMkPrYtIobPfZTAAIFgs1QLm4A=;
        b=Hn5toEpeGOh2oMptvnwj1kHad8duX7cPO3qapr2BUXzDQHXVeQLTmh1ePl60IcNJmI
         HRGPeHzYYIvlM8PxAkyAUROlq88FqZcpdWu+6vs2xojdeAS7dPFArBOwzBRjolze6b7b
         qewT+Ixx4cwK1+4CbT7iWxRBkvIhGlyiJrT/dTck2Qu2ew55i4W6Q7ssYHXXY8JxOjMu
         uIyjzb6RSajpfqpGiWr5Sb8guOcK/bbbOPSMd7FytKru3HHUoXLrBDnPXXytQE40KAl4
         bRoohPtYfPFOKsuSuIBS5gBnI4kyvqBLyNSrOLGITdViYTtE9QLtiq5QK/B4VN4nmgbL
         MlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789340892; x=1789945692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRbG0DVQ5VHY3qqALlMkPrYtIobPfZTAAIFgs1QLm4A=;
        b=O+ygIFYchaEj4LQ4kIIHvk8lORXsHj2ORbOmTN1fhkl1+EmHtJI3sXmwGnLZGuhL2h
         AGZplT5w2y77t2q71u2ue1Sl/owuMpLO94434X8Av8t5WJ33wl4lZ+wdEnwGT3J54j3L
         7UF9pLEY+SRyOdJiDEWA/d8WzQF+DTA1f0kVmJodIifJZ4l93S6nBkXOTyzDXfpBC0kx
         JHZzW1zfZkRH6xyNI5/jSPnWy1yeGKbmKwfHQpZGFwdgYnsNh9+JIiBibsUPWEiesB5E
         fjDqE7vtBcRpvb6rR7bEN2bxkhco/RgKv7KPE+yYfiFTdVlDBmVhoSg/7ZgSVx5KKR0/
         IOiw==
X-Forwarded-Encrypted: i=1; AKwUvBwA7tnlY3aDQK7oRaYjkH8TqT+dTKPJ8k9agp328FPtr56zIfdHZ6TnJy83NJZZr0Zare0i2Pg=@vger.kernel.org
X-Gm-Message-State: AFuF++lipKHpUJb8nMz+JC9zxmBR4qUYKHvMJK7h3X98w/GocpaE+wY2
	pkq9h6qSd0G2ecq1qt0G7xsxu2pPuXfB8Xyj4q9yvKupJc6wvW6LDdgAtOKRrz0CH6cyrS+hKI6
	qqEmdtj0xamqLzrK/EBI4WS4nePiTSQhdzFp+BvCO
X-Gm-Gg: AYBFou29Hu8idQT/9zaQvhfHi4447C2qR6NTVDdHexR8bYeOYr6CGJ6d6UKfLMaOVrM
	6COYRxxQMj1CPdeFUcKwqzf6OiR9GDgEtSVR6Mp0gr3bBZh7bkmK12i61SlLSuPtKt9u2zBr48n
	vH9D1hITEGUPkwnS4h2MOudzNy8fxUwscf23rJsAiJ9HIMKqlXNDKNZPBucKusf0LpOIlLhi0nS
	MQAVU0khnSQrWiHq9XfwdNMHlyMqlBw+qXE1SlY1zijqJBWdsnzJNp2Km2uP89TryeDIIUIVb4z
	fpbXiPKa2Tfp4m9TlG7/7dKFb2lIG5z9byYgCiyXuN9YPM3XiW+sCovdvsb4Qy2umFTL55wRXAt
	OE5kObtG9noztD+6OKS13dlc4NzMoyMjC0MpXLFM4NXpWLnaE5uuCERHh4I0e4Z6s7hQ=
X-Received: by 2002:a05:622a:1904:b0:530:b2e4:d5a1 with SMTP id
 d75a77b69052e-5310d08ebd9mr1666031cf.60.1789340891034; Sun, 13 Sep 2026
 16:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789302084.git.zihanx@nebusec.ai> <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
In-Reply-To: <willemdebruijn.kernel.57ad3a4d0955@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 13 Sep 2026 16:08:00 -0700
X-Gm-Features: AcwNN1XPieBwHmTcaQqSQYQyOFNrmOUAYYi4uLA-4au3SSGhTImp2iLuqjRICx4
Message-ID: <CANn89i+QqU5sw=WPrcki8W=-HoyNLpHGj2C568VHDU1CyZgodQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Zihan Xi <zihanx@nebusec.ai>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, idosch@nvidia.com, willemb@google.com, kuniyu@google.com, 
	kees@kernel.org, richardbgobert@gmail.com, jiayuan.chen@linux.dev, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>, Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 3:46=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Zihan Xi wrote:
> > IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> > inet_gso_segment() or ipv6_gso_segment() for every nested IP header. Th=
e
> > only state that tracks this nesting is encap_level, which records heade=
r
> > bytes and has no recursion bound. A sufficiently deep chain can consume=
 the
> > kernel stack before a transport GSO callback is reached.
> >
> > The unbounded callback nesting was introduced when inet_gso_segment() w=
as
> > made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE G=
SO
> > support predated that change, and IP-in-IP GSO/TSO support later made t=
he
> > affected path reachable.
> >
> > Track the number of IP GSO callbacks in skb_gso_cb and reject the 15th
> > callback entry. Thus 14 callback entries are allowed to complete;
> > GSO_RECURSION_LIMIT is the rejection threshold, not the number of
> > successful callbacks. Initialize the counter for each top-level GSO
> > operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-IP
> > nesting is bounded.
> >
> > Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Co-developed-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Luxing Yin <root@tr0jan.top>
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  include/net/gso.h      | 9 +++++++++
> >  net/core/gso.c         | 1 +
> >  net/ipv4/af_inet.c     | 3 +++
> >  net/ipv6/ip6_offload.c | 3 +++
> >  4 files changed, 16 insertions(+)
> >
> > diff --git a/include/net/gso.h b/include/net/gso.h
> > index 29975440cad5..2665acbb9205 100644
> > --- a/include/net/gso.h
> > +++ b/include/net/gso.h
> > @@ -19,10 +19,19 @@ struct skb_gso_cb {
> >       int     encap_level;
> >       __wsum  csum;
> >       __u16   csum_start;
> > +     /* Number of GSO callbacks this packet already went through. */
> > +     u8      recursion_counter;
> >  };
> >  #define SKB_GSO_CB_OFFSET    32
> >  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_=
OFFSET))
> >
> > +#define GSO_RECURSION_LIMIT  15      /* First callback depth to reject=
. */
> > +static inline int gso_recursion_inc_test(struct sk_buff *skb)
>
> What is 15 based on? Is that where in your test stack overflow occurs?
>
> A realistic practical limit would likely already be smaller.

An alternative would be to limit total header sizes (nhoff) to 256 bytes or=
 so.
