Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A1370AC1
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357409; cv=pass; b=b7HpQ2WdFhqtbFrdh2fZt77buhmdQtT5CfKFaeEt4nqYFMSLZ18EUqT+q00UweFrZL3LCNZQucs2OYvPiZM6JSIUOsaJcFkLU++kBkC1IJy53CXSwAz6YsGbR8iOif1xhvqk3vpP69OrT5jZpsKBcd4KDAGu/CR2vmVQnNQexuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357409; c=relaxed/simple;
	bh=NzSme+R0yXt6U9+wDpheCojyCfR6mbpdED9/ML2VO6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx1tf7Edi8Xa9LPVRvZ82ahNGpd+LDSbVvPKKfC8L+XCLEQuYOylWC1/38qNCYt8PSeVCeIaka3npPYEm04V7ZEQZcELz6CcwZBYxsK5Xkdwv9uENr4THgrDh/Qmnth2MKz8qf7Qp5tLkh8DRpsLLTnqPRKPLeEFwnyPB7hhyRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=K+/ekxUU; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="K+/ekxUU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so31118441fa.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789357406; cv=none;
        d=google.com; s=arc-20260327;
        b=KG65s5ye2ODSIT3mQ1eD2uknyE6koMH3eRD+GJjxDArsNUGj4qa8eOGlAvKScRxlPB
         qximsFOBSBZEfveSYLu0h+Pg4WmvTwllG/fxUvmmj0dxJ4FLiQfwEaeyOSvyNZ0ImAdp
         lKnaRPaSOd5ObKRnKEmsxw9iK9XqXD39qmbWyiBnPgtQlT/IzIk1FVYgHq8cMw8P63r/
         XOJWUEeTm6slD7p0Qw8lJowcKEPBL1K4AtVsE1I/4b/bgPqoWloPfz5pAaZyQu1wB55+
         IHjC8lYUhGJKlCUNFFGNvfvgrqm6kM5h4v/5G1IHuBj8ejxqvVHpIgECzFZEjV60/Apm
         SuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MbVBeRgR/r9NT4m1jsSZaQ9G2ade0FNigfquN4F7Tl4=;
        fh=Q60Ekjv1A4Wdmo+R1EdbX29NkbfzA8bK4e5nsos9V8c=;
        b=Oi+mQRGB9SFjWvyoYrpa2aDk2zKYS6UCVGNOs8SzVdkbHkOWEhogjxoMf56PkawLZJ
         pZzky5bTPFRdLZStwQYjoTG7379Kstr89pw+v/loUrrnqZBOMSG19vHYrlKkHx1f9g0r
         SwlkkX/lxUIOStCme7C157V79ke7ms0Xwx/Kr3zkXw5cxKUNvWVfo2fm1AYvF6tnPbvB
         fM5ONchjo6oP0NGS0sDdD1jSYWXHDAvjTV9lskyujOMkDTFkFp/CAJ7BpR+naXpEd2zk
         7UyHXQgyRbPbXhieLLGD3c0rl/gWIRirUv1ccujA/wLvpZR/M3mA/g365I0H3SItkpUo
         st3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789357406; x=1789962206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MbVBeRgR/r9NT4m1jsSZaQ9G2ade0FNigfquN4F7Tl4=;
        b=K+/ekxUUM4NaJkHP2HQb0ysQPlHiCW/Og4gnuiujo51Qc4VNuXIkV+rzZ4tVy548mG
         VsmJy05INWOk6FFM4T04Z7Cdpidl8g7h0Bk0yB8WBIO7Ut5YhXc1L0R+ifIIUaAxDUAP
         vvtPy5Kfx/mHF1Gs9fFqENMl4/aASwBH0OqduIGjM8FzlybBEoc73JUMHu5KKSkmzGNZ
         xpt5LrdQQsU8g5KmjgcP64AVc1WawXnIMn4YUP7wxZBbpehqymWsnQ9BnAmMKqzTkauZ
         sIivi5T+3ZIdbkcdIfiBKnM01sKGRtkJ1uRGz+wDWArR3+LrRV0psxVWrYF7nnezC5SY
         V5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357406; x=1789962206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbVBeRgR/r9NT4m1jsSZaQ9G2ade0FNigfquN4F7Tl4=;
        b=CiknV1+87dpz77lt7jX747lLKyGl525oAcg6Vuvgwf5wMgY+ji3mqjcyK2H7hSznjF
         4OIw8HnfaD2mQUci8iAgv92Tm1T98oruiOPrnfaaLzZNRt9kL/2aMd+Dab3skrFqVEts
         cA7gwup60sqD/cCgDijge1pm55grtpFn8F1v4xNt3gMi9kJXtz4GC2ylpIqJV99Ob9aP
         Z0NmDFhGN08q198iz7b/YbhK3LeH+TVOw/tgHlm+tcINN88i3k++OFQmovtj7wBJdQ/Q
         RPi7DtOHcn7ufxtzHe7RsR7JmiRLGCFpNkmgJvtlcJ6s6NfVs9mNUXG8ClssBWVQKdNL
         +TfQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/yKv2MZZYlVXtRpk3PV17UEoAYK1+6kqGklYCnzd9i+ToEAAHKxEhLhLWNXwjR8hb7mGCsMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nu+Dv3zX4q26WuIvY6OuLwckgXqQYCyiBbv3HVRdq7Muo+7Uvc
	oOx/HlU3huDEsGfGJQ6DdYfmDDfjHhEtRTJxcxJ38r3xWJj2xQSfnsDIo/mA96Hpi9l0ukJeE9o
	eaIc/CC/EidMvAPudEZa4tQ7FPFWDlnMOrjdilXPhEhw=
X-Gm-Gg: AYBFou2xf0wkdaGTXz3E1EoVq/iMO6PsGW6pW4z2mtFcUsxFD0IYQv+w/NUyvhc8tq+
	SE081Fk0cZyf+HV8U+/1vPabj0Yvg+1Gkb8PFVL22nBwvBUty2H+uW70PyKPzNVIy1g2pfRgmJ+
	uYAvzyyg9cIGjx28LIraj6XgjTopHWkegoM8CImAMm28qvtUYN6IxW5nMqNWYHRU0odlD/foM2d
	ucS4xEGa+H61JzCncUVWB4I2UPraCk1HvJK7Ue5uQwXvBSJwh2Jr/Ubj7Fl7CJ1107/ISAfcDrG
	Us2j+Sd84uGWAWwThxhuCYjjdl5glMDbMr1sLiXuwmd0QI6M3uPjMf7tTp+/mWy4jfYnDLlZ6i3
	rU5mb/DiQcyU7Q321K5S6
X-Received: by 2002:a05:651c:15c1:10b0:3a3:7681:6d5b with SMTP id
 38308e7fff4ca-3a5c896638bmr440071fa.19.1789357405821; Sun, 13 Sep 2026
 20:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789302084.git.zihanx@nebusec.ai> <a4f108b00c7d3c0997bfcee84a9e7e481c07ad5b.1789302084.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.57ad3a4d0955@gmail.com> <CANn89i+QqU5sw=WPrcki8W=-HoyNLpHGj2C568VHDU1CyZgodQ@mail.gmail.com>
In-Reply-To: <CANn89i+QqU5sw=WPrcki8W=-HoyNLpHGj2C568VHDU1CyZgodQ@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 14 Sep 2026 11:43:12 +0800
X-Gm-Features: AcwNN1Vzegn2UprCAGHFpd-fO9Lbw1c64hwiit7IoJ9FqdyY9q9AMmeI6XAJD9Q
Message-ID: <CAANe3eR+zoRupQ0nZREKyqABCV_VwRotK+OLHa_TMzgOOvQQPA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: gso: limit recursive IP-in-IP segmentation
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	willemb@google.com, kuniyu@google.com, kees@kernel.org, 
	richardbgobert@gmail.com, jiayuan.chen@linux.dev, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>, Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Sep 13, 2026 at 3:46=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Zihan Xi wrote:
> > > IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> > > inet_gso_segment() or ipv6_gso_segment() for every nested IP header. =
The
> > > only state that tracks this nesting is encap_level, which records hea=
der
> > > bytes and has no recursion bound. A sufficiently deep chain can consu=
me the
> > > kernel stack before a transport GSO callback is reached.
> > >
> > > The unbounded callback nesting was introduced when inet_gso_segment()=
 was
> > > made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE=
 GSO
> > > support predated that change, and IP-in-IP GSO/TSO support later made=
 the
> > > affected path reachable.
> > >
> > > Track the number of IP GSO callbacks in skb_gso_cb and reject the 15t=
h
> > > callback entry. Thus 14 callback entries are allowed to complete;
> > > GSO_RECURSION_LIMIT is the rejection threshold, not the number of
> > > successful callbacks. Initialize the counter for each top-level GSO
> > > operation and check it in both IPv4 and IPv6 handlers so mixed IP-in-=
IP
> > > nesting is bounded.
> > >
> > > Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Assisted-by: LLM
> > > Co-developed-by: Luxing Yin <root@tr0jan.top>
> > > Signed-off-by: Luxing Yin <root@tr0jan.top>
> > > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > > ---
> > >  include/net/gso.h      | 9 +++++++++
> > >  net/core/gso.c         | 1 +
> > >  net/ipv4/af_inet.c     | 3 +++
> > >  net/ipv6/ip6_offload.c | 3 +++
> > >  4 files changed, 16 insertions(+)
> > >
> > > diff --git a/include/net/gso.h b/include/net/gso.h
> > > index 29975440cad5..2665acbb9205 100644
> > > --- a/include/net/gso.h
> > > +++ b/include/net/gso.h
> > > @@ -19,10 +19,19 @@ struct skb_gso_cb {
> > >       int     encap_level;
> > >       __wsum  csum;
> > >       __u16   csum_start;
> > > +     /* Number of GSO callbacks this packet already went through. */
> > > +     u8      recursion_counter;
> > >  };
> > >  #define SKB_GSO_CB_OFFSET    32
> > >  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_C=
B_OFFSET))
> > >
> > > +#define GSO_RECURSION_LIMIT  15      /* First callback depth to reje=
ct. */
> > > +static inline int gso_recursion_inc_test(struct sk_buff *skb)
> >
> > What is 15 based on? Is that where in your test stack overflow occurs?
> >
> > A realistic practical limit would likely already be smaller.
>
> An alternative would be to limit total header sizes (nhoff) to 256 bytes =
or so.

Thanks for the feedback.

> What is 15 based on? Is that where in your test stack overflow occurs?

No. The reproducer uses a much deeper header chain, and the test did not
establish 15 as a meaningful boundary. It was an arbitrary callback-depth
limit in the initial version, so I have removed that approach.

> An alternative would be to limit total header sizes (nhoff) to 256 bytes =
or so.

Following this suggestion, I changed the fix to bound the cumulative nhoff
in both inet_gso_segment() and ipv6_gso_segment(). If nhoff exceeds 256
bytes, the existing -EINVAL path is used.

This bounds recursive IP GSO by cumulative header size rather than by an
assumed callback count, without adding state to skb_gso_cb. The 256-byte
value is a practical upper bound on the cumulative header offset, not a
measured stack-budget threshold.

I am rebuilding this revision and will rerun the reproducer against both
the fixed and unpatched kernels before sending the next version.

Thanks,
Zihan
