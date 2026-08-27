Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075030EF8F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815160; cv=pass; b=e2MwI7UyIMPA5wPTmbpc9S+9MDPezY8SgAbt93IU00jGyEgNDIp24iMctPWLAcYaMuKQZifPdMpYBHG5F6RISCxMgh5GMCCFlaN7G5N0AweT86QLeZmAKulf0U7AcJEEsWVY2BtaEcYwqbYSpn2J8dLowHnNYM0thKA0WsR0g7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815160; c=relaxed/simple;
	bh=VUasteM/1eK2m7/PtquDXotFQqnoyDt+RcdvdR9rizo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABoKBeb+ktGgnBNxELVKtZ2ON/gHCWwi19c9+LuHC9cn+UZjIHNT9Akdthr8+kgpzCMbar8ZGG1ZFLfqeK5L2Xnxoc7bebOJOwfnpEuXQ0HD6+1Jhcg+BnodcB/r5wBSrz/uw8zlX+0xLdRUEOgKfUdrwHk/38bm3g/9TOz34Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jI475kYd; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jI475kYd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c8bde2dcso25905037b3.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787815158; cv=none;
        d=google.com; s=arc-20260327;
        b=fzpF6OqHfmCv6rUKUhNTF4eKWB0RzOqI6GWfJjTQZwqqlyRTugcqWU/mpi+gEOQgka
         dFE2TLsl7oNfVe4hNIyV5me7SkVUCwFMhat8bUrKFJG1CviL+fJwIKHmGz7Wy3U7Byq+
         MJtUAN469ZUH9bi2jZAEmqt/lqVk5s/C19BEaYm+SNmB7I1V7cqXPdLvupGN3c7yhXfs
         7sWxzqhA6LeSnBpfiB96vQTDAqiAblC/T3zNgksrGIDFnNOZCbdqQPu6bHbXsjiYjmnc
         o5zUFLylpV5XCdOb72Hm7CDWXKcATyfFigrZaWkCzTdUKk/oPFAFtbX74RLaqvjzwnqJ
         CV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhU91M+LW4kUF2uW8BgolP2/H8Gx1gryC+2FQXRk+lc=;
        fh=6/uIM/oxSw6k+K4Pn7E/3JhLie3n6l2yVsXjOTq0g8A=;
        b=Hs2o5t5RiPjONZqEVLu+8+36xY7gBLR2w87559GaKW2n6BAoDbZc0/HgcgOOPPrN9h
         VVUGM4/mdqobYEvsi0M2NVwOuSbVQu3lcwR7Ve13HoKcx9gesXvw4TgO25O58lba0qKE
         CaSA1l7kU4SsmUtxjWJlBlzHeSZVfpe8LRawnHjvHq3XIBzKvG/dTZquvKYhL0kZvvXC
         esUcXIIDuwzKgM1ExEzttH552eOLV0i7V6y6/1OTolkOFOAWoFejyMVUQjT4sOWZoDaI
         gzIy2f0oWlRLJ/6KMA1jXYEe0SuOuyUGIb88aEJ6XZkIXbftg+YDT17tI3WEIgGJj5z/
         FuPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787815158; x=1788419958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhU91M+LW4kUF2uW8BgolP2/H8Gx1gryC+2FQXRk+lc=;
        b=jI475kYdX31cKP0vtiMAQApHRuobVbkrqqRLgaD7kuHTNDSonYCy2k1MT12obb2JN4
         5i+Gi1YfCG0KzuhxlO+TbZ6DpBfQ6SfC7SDprM+hsRILcyByZduRrwVAWX86hXkPmP2q
         3QVShANjTkqo34pXKIML/cSq7gUgTUAX3kN0ZgsZubinBFIF9IxaxFbmRr0NgeXlt6KP
         RJwqbTXuOQXHUoCJDrFfXshOuIYN+56GnDRlqu5R1idwXLHvI+nbJ4dVAbIhlmuXwBkk
         U/HO6XPlFvgqiidNBaV23jaeQh5BDBcCjVPPoEK13XNLWdcrPUH7tEWgffk/hE3yiS5G
         3FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787815158; x=1788419958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhU91M+LW4kUF2uW8BgolP2/H8Gx1gryC+2FQXRk+lc=;
        b=I29Zbk8F2TFQGIuRN+CMvXasxDPEwRw3nF0bwNxOVjZukD5KIipTZwjRUxFHHbBIcD
         pHGXLwcXr4LlxKnp4gKBUaG8JlkwGp47ZVCCKShHIJnoT4spVPGuJ+ezdhH0UAsIBQSK
         VtAD7HgovZV4X9mU2/36UgWWctGPTVT+NUIE4rZsP6eEJWmcJnc3TzDK4uWw7g4A9pnz
         Yi5bfoaB4q+cujlY4x6RcVLbGUwB0HWOiAyoDRM8R+tnbc7J5EAU1ubwdAIUrVBbr41S
         ld2zsjMhnn5ic6FvGi7KQID1F+cG+BNc2fDnPSxPa0SgI3i8ztr0a9EJWj584EhYYAnV
         b72w==
X-Gm-Message-State: AFuF++lqOnoZq98b5Aeim6zC8VRx108H6hSbYtoeWTKI/M1JYnoxFF+F
	HHin1YsE/p2cJaV/6ngkC3TwVsR1ToiqtJ633uPepWLGX63BWg2bDBM/LKZoHL8apaLXf9nrd2c
	JEgBrEVHHDbFIIY10q5l6WvRq1kq9twxZiTyC/p/D
X-Gm-Gg: AR+sD12p/lkugK0V6CzouAXpzXW79jHoQGm1T+eKS7BWj59hegJqprf2k4stRti1zYk
	zQSgB7qnPXBIjjY55fumviS1q8/vG5DWa2ZZFzYM/DXneBaEFsGBAgpO4abVBCDVVEOyqIx/Eqk
	12OZzyl/eVPpX2cvK2F/mmZazeZoNz7xqMVnCTgNlN8Ol0iUPHaWOE+DODi1u9VYBlX2OluwAv3
	qGstjmSR9MZIATb7BUajNpkcm1qoatjKefk9oyDqmFhCdBxYI9/JP065Mb3dhM1Oxk4QDATNrxN
	5VCkTdZoHCmGEHRrwskhw1wGLZ6+0JePOeOAExtENScZA1XaHQCAdNyfH9KaEy2uefMLcweEmwA
	T2uDHH1ov4OTVWpSKxfAHv0hjr6fNszXxAOV6IfxNZs1iH4DnkCGRnCYMqNj1
X-Received: by 2002:a05:690c:e288:20b0:855:f387:98c0 with SMTP id
 00721157ae682-85740497376mr45849787b3.29.1787815155156; Thu, 27 Aug 2026
 00:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823142620.126424-1-shlomojune6@gmail.com> <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com>
In-Reply-To: <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 09:19:03 +0200
X-Gm-Features: AcwNN1Uv5avHkko0YacIDMfyYRxac66XxxBIaWUGZOqnwIzkejhBZ_2TAAKhfiE
Message-ID: <CANn89iKck9W0KB8Sp7OFDQ+OTFJnBpy=jsmQbZ+VYhrm8yOUgw@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: reject invalid pull bounds
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 4:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Aug 23, 2026 at 4:26=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.c=
om> wrote:
> >
> > skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
> > argument and passes the result to __pskb_pull_tail() as a signed int.  =
The
> > function does not ensure that max is at least skb_headlen(skb).
> >
> > This can happen while parsing IPv6 extension headers when an skb alread=
y
> > has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs =
data
> > beyond the linear area, max - skb_headlen(skb) wraps and is converted t=
o a
> > negative delta.  __pskb_pull_tail() then passes that negative length to
> > skb_copy_bits(), where it can become a very large copy length.
> >
> > Reject this inconsistent bound before doing the subtraction.  In this c=
ase
> > pulling up to max cannot satisfy len because the initial check establis=
hed
> > that skb_headlen(skb) is smaller than len.
> >
> > Fixes: 1431fb31ecba ("xen-netback: fix fragment detection in checksum s=
etup")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
>
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  net/core/skbuff.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index c82a147..33022f7 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5838,6 +5838,9 @@ static int skb_maybe_pull_tail(struct sk_buff *sk=
b, unsigned int len,
> >         if (max > skb->len)
> >                 max =3D skb->len;
> >
> > +       if (max < skb_headlen(skb))
> > +               return -EPROTO;
> > +
>
> pw-bot: rejected
>
> Please ask your LLM not to slow down the fast path, and find a better
> fix in skb_checksum_setup_ipv6().
>
> Note how skb_checksum_setup_ip() is fine.
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d4382b68d56e0b3b247868b4d29ab383cfcf7440..f77d7480594ca6a1dcce2fea7=
37e421d5ea2d38d
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5974,7 +5974,8 @@ static int skb_checksum_setup_ipv6(struct
> sk_buff *skb, bool recalculate)
>                         err =3D skb_maybe_pull_tail(skb,
>                                                   off +
>                                                   sizeof(struct ipv6_opt_=
hdr),
> -                                                 MAX_IPV6_HDR_LEN);
> +                                                 off +
> +                                                 sizeof(struct ipv6_opt_=
hdr));
>                         if (err < 0)
>                                 goto out;
>
> @@ -5989,7 +5990,8 @@ static int skb_checksum_setup_ipv6(struct
> sk_buff *skb, bool recalculate)
>                         err =3D skb_maybe_pull_tail(skb,
>                                                   off +
>                                                   sizeof(struct ip_auth_h=
dr),
> -                                                 MAX_IPV6_HDR_LEN);
> +                                                 off +
> +                                                 sizeof(struct ip_auth_h=
dr));
>                         if (err < 0)
>                                 goto out;
>
> @@ -6004,7 +6006,8 @@ static int skb_checksum_setup_ipv6(struct
> sk_buff *skb, bool recalculate)
>                         err =3D skb_maybe_pull_tail(skb,
>                                                   off +
>                                                   sizeof(struct frag_hdr)=
,
> -                                                 MAX_IPV6_HDR_LEN);
> +                                                 off +
> +                                                 sizeof(struct frag_hdr)=
);
>                         if (err < 0)
>                                 goto out;


Following up on this, are you planning to send a V2?

Thanks.
