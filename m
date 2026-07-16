Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6E4248A8
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214443; cv=pass; b=YoBSvlQ03UsnMuu2czlrpt+zov6jwDN725M2gWtS+0mifAlAuEg0KZiSv/crV9gI9I2B0FwlES1KIzDcmyY8bBIrdG6rinbG4UeLKzbe5iRJ81y/8w3xKNsTiIB4mcpjlOV9P2mmRT51vv8QxCyMjkE7VBSGzeobFZAzV6tQnB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214443; c=relaxed/simple;
	bh=LUfaQzJn2bnCsR/uWb1AJU4vhXIfysy8sSohRbkEbgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWMmvRzbbRzlDZ1OmuGjJNFnA1U6Oq5bkaujnvoN1FofeyuhXKIIeH1o2Z79wdgybeXdnXj/e8x6PpvOWud284LPmW1KHI5Pjo0mKRNNyfSpR56w7Qv13gvftr43Erw/2svBH0FdX2uBP3qNd/BOpJoyGYSFbHegJKM+e59JE0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2CE4j8Z; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2CE4j8Z"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b01910b499so656455e87.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784214439; cv=none;
        d=google.com; s=arc-20260327;
        b=rKPUkZyg+Mhv0NuLU1YKrnKbuG0W3hV6mJtpFygI7FJY1e7v+qj9clY+YNZgn/ePgN
         Y9Nyu934VqJAgPBpzfxSdyGZcrSzWqoKdf5QgKjpL1r35xJlCpH+tSQKoymupN85MGiI
         0sOCyPEgQpQiMjAUTd3a3bF4S+2HPdC8jQ+fUuWrXhY6XKwonO0sblqiPjW5A7jMnluP
         Z+VjvY2XGJY7Dp8w0bhdemYIAWq77YqlqVdKZd5PSBjarxVFV0nY20fe1xqeKRCyX+YP
         UK/64BFHKgD7dYwEzTHzQ6Gu4ywmopyIwUtf2ZKIc6Wcate+ZFhn0QpPqJr4qUsL+mla
         GYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7M2ApiM/8dxQZGiLlnNgbMz+W9cwib1Oj2a063GQa0=;
        fh=cKSZeFolDVjodMnzlQG7J6sztudrBHF+9PL3zmh99Ug=;
        b=jhAJV89H95Nj0eW/IMMOXznJ7qoBfNo20FTpSB/sTkUaSp3vo++zitipuW83R3crPG
         2gsaXEgENDVf7XYef3DP9oVwyGGaCC449OcptFqRGn3DTUQSSpJvzkuuDPnlyi8ghPeR
         dpPeqVzVVaHnxJhFNQLYVROJPe1eD7eEwe5x2H5Gnah9twqVio0OLamfRcD33D0Td0rJ
         Jrfws1mhiPdw7baDyBpN9YO1HU2ActYUTFvAr84fG3153V2On22ABvJFwngyMd/sQVWT
         uBm9yOIqQ2OH/jtMdAaJxSIelUnIhIxZTq7HRCNIWxiMqdTitB1fsmZiv5p3aU7h51BG
         cUFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784214439; x=1784819239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k7M2ApiM/8dxQZGiLlnNgbMz+W9cwib1Oj2a063GQa0=;
        b=f2CE4j8Z2HAWNVepdjltH97LkNovDc6TTN1/BbQu18b1HFKPA7B1VAGdE2BIhfYqYo
         woKSEhTynCx0bF9vrARKHs6U8QD1BfWDpireD9BgRLDbcXNt1RhUVtgC1ZbFE4Xdu78Q
         RgD6J50vdQAz7ot6jIxlQH3GXVIXCJ4l8dG75xYH34KTObjVhrqhna0NXt9JXVmNNaNR
         ZXL/9pX3E0Kwko1pSlmIEkM5kPXVsPPF9rRaI9GW57iTN4Iz7vVR5gimpyPQ+WlH9NH0
         KBw0tNK72fabCqv44CND4SD9GbqPY9tj6ckm1RG/F2z89gC1W6jn4qzJJ80Lw/zSRj34
         vkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214439; x=1784819239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7M2ApiM/8dxQZGiLlnNgbMz+W9cwib1Oj2a063GQa0=;
        b=U/TD/7faxli3tfoyGIDMuRnk9YJT3hHAH1AAxVdJsat+cqDKBsFVKfS5iiP/GHPB1J
         096fThL63n71vOkpBbNgNsWO2+4oRiAakwb6GyvkodSEhmOhDn9zMTm5qkCAEKWRY8rQ
         ixedpLY2vA3g9e7boK20gcSYRn6pMwO4cazxs2Zik1gG66WVmFEAMbmqo/QHEb07dZGL
         r8iv+YcR7eUhw7xnO/sMk+qLWmGibJOhKA9JNUJUNcyuvtyPUVctg3c48CUJ582H0vtX
         NbWu4K7FlNGshMeyTulQaZNyAtmDmR7TtofTaCe5P/2k9Y3GXcjIuB6aGk8Kz8IOmXzE
         Qy1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrDpw5827CXt5SiA1/XWS4AgR0JRIFp8Bi38nNuphjMFQcbbIojtF015BakFoMaNvjE2fC/Fsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sQYMetb8voQz55+s7zSGvffgH+qVUbqb8xKw/P+AKKzMdFnU
	qFXek+EbmdOMNQrZXCaW+zpqLpFdtbl1TEckskG7jDTLy0d3tWzjj3WLRXylyv5lbrdgeL8cU/F
	AB8B06jbar9JXN+4YlGfIuyJv9yimB7k=
X-Gm-Gg: AfdE7ck/nheH6igECus/KS0KNVkS8MmbehMp8+ehugM3vPNg78egzAqiagzmPbRpiYU
	/TWJf25T75FzxM+xqrPMS3tsu5ThGytpXOixff/hwlFAQDVn26WQdAp8BsRY4msk2kYoiLul+Q4
	LryNBy6xcgfdo69XZBEPzi5pSz9B/8qKw0CT5XVxWii7aktIT4pauyFVdQPx3Z+YvW/7oFTG1GQ
	tE7gldwwVjfR0lhks4ioPKe9fSH3Lemqkn8dCOYeyd68q43qrMrGFwERKrCXpGm1JJ5BVFSChsG
	srcmOOuSR62f0S51U0iqxc6052cLdSxOGOXi3AsISvbnX5DSOfWfsYnXR3xOp7ikGOa5Cbb9ERc
	A0Q==
X-Received: by 2002:a05:6512:1192:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b28a0f58camr826062e87.0.1784214439114; Thu, 16 Jul 2026
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
 <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com> <87a4rrjdj4.fsf@cloudflare.com>
In-Reply-To: <87a4rrjdj4.fsf@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 17:06:41 +0200
X-Gm-Features: AUfX_mzujQhauOkZ5JSUcux-n5CL7A4vg5pNAEiHfjZwtqvCZWJ7lHML3E_SwaU
Message-ID: <CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:00=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
> > On 07/14, Jakub Sitnicki wrote:
> >> skb_scrub_packet() drops all skb extensions unconditionally via
> >> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
> >> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
> >>
> >> This makes it impossible for a BPF program to pass metadata via
> >> bpf_skb_ext through a tunnel or across a netns boundary. The extension
> >> is always lost at the scrub point.
> >>
> >> Introduce skb_ext_scrub() which consults each active extension before
> >> discarding it. Extensions that request preservation are kept while the
> >> rest are torn down. When the extension slab is shared with clones, COW
> >> ensures isolation. Replace the skb_ext_reset() call in
> >> skb_scrub_packet() with skb_ext_scrub().
> >>
> >> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
> >> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
> >> creating the extension signals that its metadata should survive
> >> scrubbing.
> >>
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> ---
> >>  include/linux/bpf.h      |  1 +
> >>  include/linux/skbuff.h   |  2 ++
> >>  include/uapi/linux/bpf.h |  3 +-
> >>  net/core/filter.c        | 11 +++++--
> >>  net/core/skbuff.c        | 82 +++++++++++++++++++++++++++++++++++++++=
+++------
> >>  net/ipv4/udp.c           |  2 +-
> >>  6 files changed, 86 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 6b918a5b61bf..a46ca53c5b27 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct =
bpf_map *map, u64 flags, u64 all
> >>  #ifdef CONFIG_BPF_SKB_EXT
> >>
> >>  struct bpf_skb_ext {
> >> +    u64 flags;
> >>      u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
> >>  };
> >>
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 584d8440d352..66afa5489007 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum sk=
b_ext_id id,
> >>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
> >>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
> >>  void __skb_ext_put(struct skb_ext *ext);
> >> +void skb_ext_scrub(struct sk_buff *skb);
> >>
> >>  static inline void skb_ext_put(struct sk_buff *skb)
> >>  {
> >> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_=
buff *skb)
> >>  static inline void __skb_ext_put(struct skb_ext *ext) {}
> >>  static inline void skb_ext_put(struct sk_buff *skb) {}
> >>  static inline void skb_ext_reset(struct sk_buff *skb) {}
> >> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
> >>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
> >>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_=
buff *s) {}
> >>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_=
buff *s) {}
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 3eee4467422d..02da170205de 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
> >>
> >>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
> >>  enum {
> >> -    BPF_SKB_EXT_F_CREATE =3D (1ULL << 0),
> >> +    BPF_SKB_EXT_F_CREATE    =3D (1ULL << 0),
> >> +    BPF_SKB_EXT_F_NO_SCRUB  =3D (1ULL << 1),
> >
> > Do I understand correctly that you do prefer the NO_SCRUB mode? Any rea=
son
> > we need to have scrub mode? If it's all produced/consumed by bpf, maybe
> > we can just carry this data unconditionally instead of having a SCRUB/N=
O_SCRUB
> > option?
>
> Yes, that's correct. We definitely need NO_SCRUB but I don't have a use
> case that relies on metadata scrubbing. I believe Kuniyuki also would
> like the no-scrub to be the only/default behavior for Google's egress
> use case.
>
> I've made it an opt-out mostly because that the existing metadata
> (skb->mark, skb->data_meta) gets scrubbed. Although as Jakub K has
> pointed out to me - you can circumvent it by using bpf_redirect into the
> target netns. So I guess we have a precendent?
>
> I could use input from folks operating in K8S-like environments, if

Sorry, I don't quite follow it here. Why don't we need the NO_SCRUB
here? The crucial point here is to allow skb traverse across different
containers, which is also what I expect. We do need to support this
case to make this feature standalone, which means it is independent
and not affected by other components.

And one part of what I'm doing for BPF timestamping v2 is to address
the issue in the container scenario as well, FYI.

Thanks,
Jason

> no-scrub-only mode would be acceptable there? Daniel, John, any opinion?
>
>
