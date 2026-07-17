Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36D2E3B12
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309454; cv=pass; b=rIu2HZRhxIElrbqTCJaQ/h3JQeZB8F8ip5HeYS/OFh4mqnCJOjGK+VA/S226TpUhAt5J6T3DGYrzgIU0p/Ep+S52rdODNxIAoYEbYmJlolUnw0TKQ4T0xF92h/2YESTHoTzj8kVg/ony1SqIST1voVmbojolIy0C2HuAcIsbzFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309454; c=relaxed/simple;
	bh=yiPZUFjluz3ZJnoNLM8T+8cr5Tir9k5LbHW+P69ZnLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np5XuQUZ7VMyzE9SxJG6R7uP88FtHay5pUeSsqWYmtZMxRz3FHNwn2Ra0E0w87KVUwG9ZCJ7vuYvrBRN88yy6aZgHB/Gn9L69bAazhvFbJWvvyHPzV/hQ2NIh0zrndYPghPwJZfK7rlxOcH+tQPS+5354ap2iw7wsyw1Vx55vWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My7CDu48; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7CDu48"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so5426730e87.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784309451; cv=none;
        d=google.com; s=arc-20260327;
        b=fZ7b1UACajwpVZstL0BfV2qIMixNPGuvgbAa8vkqIoU5n8B7YqOCLGDw2wFd3VwrPO
         E9AHELRgixaxjj61SFOg8A+b2g3tBDJPRVXKDx+fsPMI5rSaRMQUl/k1cFxo0/Bhw2bQ
         xwS+pgvdIoY4ozK5OuSq1miHkeW5CoM699Y3Dy21huEj98VjyazlpRYjM3GS3kDL5jxC
         TcP/ZfjieNRyQyuoBFtrt6cUMcclkduAw4fUK/XfEWpfdBteBAbzI78zt2Tqs0+ROrbm
         dVunUnYlrBqSsrUYM+Sy2RoRjSMsJN2Uxlo92yPpj8R239IsJHzIBOealF6g75d8JY1A
         MqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+g0QqbxrxgqSG+NVRARqXqqiU2n/zAAHbtN/DTtmLo=;
        fh=04KmmUwlW8wEhd0tRXeod5fUOav/cGqaTzx1lHFQxe8=;
        b=mRr5ikIXnjvZsJgJaf+01RJzd1oLXk4ySvwSzqIGYUk3Pagop90qPlsZjZaTSFIVam
         kqnq9HEJqbSIjpsn9ljj7uFdW8ZRbiKLF622pwpBP14UMnnwwLB/yaV9oBZU4nIHlDGT
         J8DiaeDsT6O1OpRkzzBMrowLJj/crWMzentLiw7/EEanJKeX8ZLraPYt6n2J5M/woZJl
         FaEcuM3yRNoNe35o80wfSKuwN1+beeaaAPLTERZM4JN10+29F/GKr8KK0BQyc65iGA1t
         gNdr7u51lM0bIJNYbYdXdj0v6+q5uO+qwGp4g+WGQc95d0DXDkBsIzc9VaQhaJ/EBUaG
         lFKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309451; x=1784914251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+g0QqbxrxgqSG+NVRARqXqqiU2n/zAAHbtN/DTtmLo=;
        b=My7CDu48Q+KXWyArUEClzcVOt0hYbYXm5Gbr2ai4jiSuTiS0tjoS5GAxoVddUg7+Nj
         W06fefbLpaGglpXw23+ePU0wvuuU8Mh04cVOc12TmFcDYb0oDS2284hj5nlKr6Kx6imT
         4nVt5SxPjtvT2uVw/66XqwSXkSPltX9YGsTSqHWtfred7Pc68+nB9KQkpP02gs9WEE6W
         snHpGhHf+bn3hzp73Egtynv4ArrBqjzGGDwgnU41igqAzZc4R2t/e5kOc+7N3khqeu++
         0nfzcuf4LlwkhPq/dyMv6pg6/7KO6ASc7yxqpQq0KZrUI54dyRfPueH8d17DXUNrnQSt
         pzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309451; x=1784914251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+g0QqbxrxgqSG+NVRARqXqqiU2n/zAAHbtN/DTtmLo=;
        b=FPbRzg8p0qprk5Y1ykfoL3HjvkEEOd0RPfoJnnRAVwAi4tiP9NfaIcrypV7jIXRzn0
         V9yEA4GpgdjCSlNuVJqj/wPNUTMi/9DZHM+lhp/ba/dLXyIBpg/80jrwGW7u3RQTxyEG
         z4E9pnR6gF2xEo/uPSdM/0+KeSNoVYaD/pofTqpTmygfAoI7RoCyKPVKo+H7tDPx2Aiq
         qbp/712qkn4PbNKF6zDcAelFn+E5d7GbXDZKqQ/m1GCOB6Jq23tbZr/zT2YY3ppS4m+f
         l4p40GJ24ev/YIe9KwUPQp1eD9nDiLLAVmw1yvC68n9EcONtrRb8boPsscfkSeMCp8uA
         pWrg==
X-Forwarded-Encrypted: i=1; AHgh+RoJYM9ZQCNewkw6PLWD89I6orZCNozNNsBL/5s19th1aPrDdXCGiiP33p/MG54Bmj90ViV2Vos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSXk51ghO76nE43ah5Rc/GDocVUUWwftG9xn9Or3mBKOEl32S
	NB0lfTwH65bNCaJqCarmHx9dfzDa0MGLelIQybXrcTlHwEQustifajUlp4t/Rd/HDdT6zjMHA5N
	eXskAaO3AhcOUUXpsyxL2IIZ63qEWBsQ=
X-Gm-Gg: AfdE7cmFvopbrpdMABAe0KbvHhHd7ndGRnC6cj79BRDY+XeZ1FQfGqdM5ygwN6wtWRa
	YiL68cruFGNAq0Mbu+YGkPb0piocn7FS/+CIaHzfWsx+RMzTpj1nYnUs+euYMgrMpf8+CGiGkxu
	QuMc9dXL5x4/phQYWVmXgQENJLmsI3tXxthMRejuqcu3PisgOAaSJ4q7IW/J+2z/Tkc3lslnIya
	19uDa/SvEXHpuksjfuMbVlpSWDixE91nmlgrpvxDZQTd3E4q/A3HfsnK1aQXNPSA2a2IpW+4/15
	2Lqwa9yvJxspIOoFSggrxb387jF7PVLdXCZ0XmNLU2UsycHdCI81MiV70AjyfkHp94ixwkSFsw=
	=
X-Received: by 2002:a05:6512:2349:b0:5b0:1852:934c with SMTP id
 2adb3069b0e04-5b28f873139mr835411e87.9.1784309450650; Fri, 17 Jul 2026
 10:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
 <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com> <87a4rrjdj4.fsf@cloudflare.com>
 <CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
In-Reply-To: <CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 19:30:12 +0200
X-Gm-Features: AUfX_mwmLqyTeuL8QrfW83_HRes5nTH1cciZFeLKrMlpdGOZNmHk26V5s3aD_-Y
Message-ID: <CAL+tcoBPv2_yMZrrvgNT7kkL9tCmAfUZmsr7+0qYukRmYJb6gQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:06=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jul 16, 2026 at 3:00=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
> >
> > On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
> > > On 07/14, Jakub Sitnicki wrote:
> > >> skb_scrub_packet() drops all skb extensions unconditionally via
> > >> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
> > >> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
> > >>
> > >> This makes it impossible for a BPF program to pass metadata via
> > >> bpf_skb_ext through a tunnel or across a netns boundary. The extensi=
on
> > >> is always lost at the scrub point.
> > >>
> > >> Introduce skb_ext_scrub() which consults each active extension befor=
e
> > >> discarding it. Extensions that request preservation are kept while t=
he
> > >> rest are torn down. When the extension slab is shared with clones, C=
OW
> > >> ensures isolation. Replace the skb_ext_reset() call in
> > >> skb_scrub_packet() with skb_ext_scrub().
> > >>
> > >> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB fl=
ag
> > >> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
> > >> creating the extension signals that its metadata should survive
> > >> scrubbing.
> > >>
> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > >> ---
> > >>  include/linux/bpf.h      |  1 +
> > >>  include/linux/skbuff.h   |  2 ++
> > >>  include/uapi/linux/bpf.h |  3 +-
> > >>  net/core/filter.c        | 11 +++++--
> > >>  net/core/skbuff.c        | 82 +++++++++++++++++++++++++++++++++++++=
+++++------
> > >>  net/ipv4/udp.c           |  2 +-
> > >>  6 files changed, 86 insertions(+), 15 deletions(-)
> > >>
> > >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > >> index 6b918a5b61bf..a46ca53c5b27 100644
> > >> --- a/include/linux/bpf.h
> > >> +++ b/include/linux/bpf.h
> > >> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struc=
t bpf_map *map, u64 flags, u64 all
> > >>  #ifdef CONFIG_BPF_SKB_EXT
> > >>
> > >>  struct bpf_skb_ext {
> > >> +    u64 flags;
> > >>      u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
> > >>  };
> > >>
> > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > >> index 584d8440d352..66afa5489007 100644
> > >> --- a/include/linux/skbuff.h
> > >> +++ b/include/linux/skbuff.h
> > >> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum =
skb_ext_id id,
> > >>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
> > >>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
> > >>  void __skb_ext_put(struct skb_ext *ext);
> > >> +void skb_ext_scrub(struct sk_buff *skb);
> > >>
> > >>  static inline void skb_ext_put(struct sk_buff *skb)
> > >>  {
> > >> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct s=
k_buff *skb)
> > >>  static inline void __skb_ext_put(struct skb_ext *ext) {}
> > >>  static inline void skb_ext_put(struct sk_buff *skb) {}
> > >>  static inline void skb_ext_reset(struct sk_buff *skb) {}
> > >> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
> > >>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
> > >>  static inline void __skb_ext_copy(struct sk_buff *d, const struct s=
k_buff *s) {}
> > >>  static inline void skb_ext_copy(struct sk_buff *dst, const struct s=
k_buff *s) {}
> > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >> index 3eee4467422d..02da170205de 100644
> > >> --- a/include/uapi/linux/bpf.h
> > >> +++ b/include/uapi/linux/bpf.h
> > >> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
> > >>
> > >>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
> > >>  enum {
> > >> -    BPF_SKB_EXT_F_CREATE =3D (1ULL << 0),
> > >> +    BPF_SKB_EXT_F_CREATE    =3D (1ULL << 0),
> > >> +    BPF_SKB_EXT_F_NO_SCRUB  =3D (1ULL << 1),
> > >
> > > Do I understand correctly that you do prefer the NO_SCRUB mode? Any r=
eason
> > > we need to have scrub mode? If it's all produced/consumed by bpf, may=
be
> > > we can just carry this data unconditionally instead of having a SCRUB=
/NO_SCRUB
> > > option?

After giving it more thought, I vote for only no_scrub mode because I
don't see any reason why we still use scrub mode. But it's just my
opinion.

My question is if we in the future really need the scrub mode, it's
still possible to add this option, right?

Thanks,
Jason

> >
> > Yes, that's correct. We definitely need NO_SCRUB but I don't have a use
> > case that relies on metadata scrubbing. I believe Kuniyuki also would
> > like the no-scrub to be the only/default behavior for Google's egress
> > use case.
> >
> > I've made it an opt-out mostly because that the existing metadata
> > (skb->mark, skb->data_meta) gets scrubbed. Although as Jakub K has
> > pointed out to me - you can circumvent it by using bpf_redirect into th=
e
> > target netns. So I guess we have a precendent?
> >
> > I could use input from folks operating in K8S-like environments, if
>
> Sorry, I don't quite follow it here. Why don't we need the NO_SCRUB
> here? The crucial point here is to allow skb traverse across different
> containers, which is also what I expect. We do need to support this
> case to make this feature standalone, which means it is independent
> and not affected by other components.
>
> And one part of what I'm doing for BPF timestamping v2 is to address
> the issue in the container scenario as well, FYI.
>
> Thanks,
> Jason
>
> > no-scrub-only mode would be acceptable there? Daniel, John, any opinion=
?
> >
> >
