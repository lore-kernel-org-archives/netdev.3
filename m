Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20B41F5ED
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341937; cv=pass; b=tJVCgsOcdAfbKoJt5s418EfNHxHRBnsGtgxqH4idcz9afDD3meH1qmwMjlfFkn8kmo7XZfTrCQg7KXr8ZQve5+roXlmg7rOhaNqkpZx8+sDozZiekyOMGPm1/nAKcepBK4ng5Gwqw5bqd4GUvvTmtx84/KXPEktckmexTmulNXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341937; c=relaxed/simple;
	bh=KGH/j8IR4LBnZI52L6lciZz+6WT9h03oqzbxl+Qp7MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/RlQMovo7WzM1GV/fGq7vHYBehx5IQ5OjbImVSBsOrA1tW0N10Dj/K3TQv0zyc6nRbFfRtCDr4iffYJlNE/1H2iBOv5tpfTiW9Dju/tM1vZhB8SPLw7C+vui2Wlq/7H0iOHRbFObdruYXmjVUdQjxQ+WiKB8AHFO0oHWsmctaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCYn129B; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCYn129B"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-529a1ee0e62so8870641cf.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788341934; cv=none;
        d=google.com; s=arc-20260327;
        b=jjgBS+14gw+PWTVCfs0tq8TJS//em3PSjfZ1w6UP0flEFvDQa7MdPSKZSXRsQ5gU+I
         xaaYPze16V8vhulPjLaSW8gKSR9TNWrM+eTMzsx7QCxtxJ1yWQy77P5qhxlMGwyRP1LV
         uOKg4K5xS+i3WoOIxV9gS1oJl8AKJ9sWpAqzw1tCzeuluy/VbWEJzrrYv73HiTXwO68N
         ipbIpbQWbOZKq6lwBLg6DmA4yo8ibzMkdUEY5VepIiBItbufR7YI/B7aZm8kGKkQPShx
         pjHAzRtHCk72VNygW7vDTB490rEd4pCY1g+GZVqy9gAWu/qBoZtjeuCZcjyxEMNJXdzM
         eLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=83BlhtXDt19TIcv2JR3BpA8R+21kQFftGnm97deT8Uw=;
        fh=Jg0pmroJQNcjzMMSOZmiSGJYUlLvUobBwtIqMyg+B7k=;
        b=qnNXh2mlEN7qMuGX3i7QZjEznYJEF0AYxg87cFxF87jv7lJpUe/XA4A2rXCu/8y5qt
         SFQds8QgUfUWx0jid3ajMJ+S3tHe30Cj87b9sve58rIDegjKW0y1FKvUrWQPxoqVmFPp
         cPYdscXghLNDR8GAVUHRjj6NwAxfVBMB5BpgwL3B8B10afxh7p3F8yhX+DZ8CLbiGl+N
         j2Gc3YTm8rgVFikjrGrB7j/ttngz6qDZuP4O6kuxRqanvwIwmBCw5LVwqFHVJhvt/wFK
         qAZhQHRBZKWP4f1l21Eq9HZ+sa+vxLeA2312LtLB+3HTSlqqTZR0qSSkxesevhuxm6E0
         Jp2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788341934; x=1788946734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=83BlhtXDt19TIcv2JR3BpA8R+21kQFftGnm97deT8Uw=;
        b=LCYn129BEL5ppM7p5+M6IDbPiEgV7yv2lHNZPdnzxodY3IHkOb5ZDTKFREeWEQM4AQ
         Y3t3mQH23VOGawdWU7VwMStnX+F8uXD74qf9q5J4ZA72Vq9XKD1uOMbeA5HIOEpEcjbF
         Rcx49KU4H4OY7XixycamnYRF3OeMP3s+RiJ2mZayiSRt9kN5+/jXqzqUMcCUV1EUNtlN
         j7mJAyZVs/fcPT68pyc/Wxnv0kYo26mx5fYOvy5DcuiBgVlhqj3aS/N/daTp5wtz5DzS
         xlGi1/RuBYdRohWa4mFLuB/2N1amSF9dcqZZU75jnKmVrPYnefxUdHi/IrmmAcrjYyGu
         cfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341934; x=1788946734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83BlhtXDt19TIcv2JR3BpA8R+21kQFftGnm97deT8Uw=;
        b=keY7hky9O/o7yDHMHqawcfeA4j9O5gqj7Ac+vzGBEtkhGqlMJ2qZhAoViAK5sFqw7f
         eXRAn0JFQaCpFbfiFJE4qAsJ71GbJGjqvRNd489bTym0oewSKAiZjOOZApnE7O0ME6kI
         sYZ4lvg4LpLBPQd7NsSzMF7Xf4Tr7yCqFQfLhyK6o85/rA4/hQ+zUUYlH7MhEwP+gY2W
         +ybqWHVGWrWnieCrUuhhF1TLE5h+D1EcVpBBTV3W1iGDljpEjKAay1Gh0Vh/TU3FAQ9W
         MJyvYR5FHM20u0jcrSNBGOYRw/bj91o3OPU6V+xZqauNN5TIWOO6dE5tfcdDSCrWpi7I
         WeHQ==
X-Forwarded-Encrypted: i=1; AHgh+RroLUXOzUbmSh59MKYsO41VtH8eNkiKx9iis1/wCP8dp7B9bwTNh3/1gLwDX6fpN7o7m2w/AtY=@vger.kernel.org
X-Gm-Message-State: AFuF++mJj430NqGZ+79TY7TgMDf/C9vhtsbUWo0KQxxTOCahjtveJmMj
	MGtAu6uCle8oL8uVMT8lQzBQb8sbXYhS9rPJJ0KXw4eycC7fMWjaXxv5w3HiBtOQMfYKLsuztme
	WtxAq5dQw0hOFiA7eXotsrMFSxEXw8RGx1RuOK7GqxmrTIB97WTvdwRrVViM=
X-Gm-Gg: AR+sD12ABZmAvA3n8J+4I+8lxKi51rxFsoHunXLSnFaL2OOo62j+GTRlPN+sgl+zXnH
	3ntFOKxygv2aKbVmjmA3exFQPrnZCNfiJFWyTJ9x8ABIyOoEJ4dQSAjhg2Fldr/DYcxVIfgA2n+
	DNcOgQBfmPUoFardZ+VaFz9vii+/+9j3PPjIWWffayqIXYmvC1Bwhk90lqydBE0KKEBQ0/7pYPu
	edFSj/B6qGckvxcFjJaQmrmd5SysASRuQHuczlsZ6GmTkNBJLGKdzV+mGLTRTZf8y+8SiHOfhUT
	OWoILYlbuYOeMpZ9vTRYfFjteqczLK07tHhrmnc6YjZmRJk9GvpiorS+PkfSvnBHrdag/lvwVIo
	9VLhIlcze9LpAU2wY/POZNVr7k84und8IRgOWk3mDxlAIJJSl0Lrgs7QpGw==
X-Received: by 2002:ac8:7f0d:0:b0:52d:97cb:b678 with SMTP id
 d75a77b69052e-53036c6b4a4mr31865881cf.18.1788341933947; Wed, 02 Sep 2026
 02:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831095952.3385596-1-edumazet@google.com> <55aad0c8-6409-4c4a-846a-141ba12add4d@redhat.com>
 <CANn89iK+RvAVvARfJChV-AgKtF2KVTd-MRGBfRCy24N3GBCAzw@mail.gmail.com> <41c4b8b6-30ad-4ce9-916e-ad348d7850c7@redhat.com>
In-Reply-To: <41c4b8b6-30ad-4ce9-916e-ad348d7850c7@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 11:38:42 +0200
X-Gm-Features: AcwNN1WnqYN7OdXKnq6KZcDC8PbEtalwI05OLkU1fZ0s7ANC56vqwXTPyIEQtAo
Message-ID: <CANn89iKszKFkY9J+iqJSHwbs9+PfPDwQ1uZoEyQya6Q=73=zqQ@mail.gmail.com>
Subject: Re: [PATCH net] net: fix use-after-free in pskb_expand_head()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com, 
	syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/1/26 7:00 PM, Eric Dumazet wrote:
> > On Tue, Sep 1, 2026 at 3:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >>
> >> On 8/31/26 11:59 AM, Eric Dumazet wrote:
> >>> pskb_expand_head() and pskb_carve_inside_header() decide whether to d=
rop
> >>> the old head gracefully via skb_release_data() or directly free it vi=
a
> >>> skb_free_head().
> >>>
> >>> Blamed commit replaced the check against dataref =3D=3D delta with sk=
b_cloned(skb).
> >>>
> >>> However, skb_cloned(skb) masks out the upper 16 bits (SKB_DATAREF_SHI=
FT)
> >>> of dataref using SKB_DATAREF_MASK. For an skb with nohdr =3D=3D 1 or =
a clone
> >>> referencing a shared buffer where only one regular reference exists,
> >>> skb_cloned(skb) evaluates to false even when dataref is shared with o=
ther
> >>> skbs.
> >>>
> >>> When pskb_expand_head() is called on such a buffer (e.g. during bridg=
e
> >>> flooding, generic XDP, or VLAN tag insertion), it falsely assumes the=
 head
> >>> is unshared and calls skb_free_head(skb) directly. This drops the und=
erlying
> >>> head/frag reference immediately, while other clones or references sti=
ll
> >>> point to it, causing a use-after-free in subsequent packet processing=
.
> >>>
> >>> Introduce skb_dataref_bias() and skb_data_is_shared() to accurately t=
est
> >>> if dataref is shared by checking atomic_read(&skb_shinfo(skb)->datare=
f) !=3D bias.
> >>>
> >>> Use skb_dataref_bias() in skb_data_unref() and skb_data_is_shared() i=
n
> >>> pskb_expand_head() and pskb_carve_inside_header().
> >>>
> >>> Fixes: 3e24591a19bb ("skb: Drop "fastpath" variable for skb_cloned ch=
eck in pskb_expand_head")
> >>> Reported-by: syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com
> >>> Closes: https://lore.kernel.org/netdev/6a954e27.4d659fcc.734b4.0046.G=
AE@google.com/
> >>> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
> >>> Closes: https://syzkaller.appspot.com/bug?extid=3D128e9f5a0f85a51215b=
1
> >>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >>> ---
> >>>  include/linux/skbuff.h | 13 ++++++++++++-
> >>>  net/core/skbuff.c      |  4 ++--
> >>>  2 files changed, 14 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >>> index 421f6fc454511ea6c7b83d5227481840a7c4bcc0..efeef148e1ba50cbb0d48=
0975dc6c3c59acb98c7 100644
> >>> --- a/include/linux/skbuff.h
> >>> +++ b/include/linux/skbuff.h
> >>> @@ -1295,6 +1295,11 @@ static inline bool skb_unref(struct sk_buff *s=
kb)
> >>>       return true;
> >>>  }
> >>>
> >>> +static inline int skb_dataref_bias(const struct sk_buff *skb)
> >>> +{
> >>> +     return skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
> >>> +}
> >>> +
> >>>  static inline bool skb_data_unref(const struct sk_buff *skb,
> >>>                                 struct skb_shared_info *shinfo)
> >>>  {
> >>> @@ -1303,7 +1308,7 @@ static inline bool skb_data_unref(const struct =
sk_buff *skb,
> >>>       if (!skb->cloned)
> >>>               return true;
> >>>
> >>> -     bias =3D skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
> >>> +     bias =3D skb_dataref_bias(skb);
> >>>
> >>>       if (atomic_read(&shinfo->dataref) =3D=3D bias)
> >>>               smp_rmb();
> >>> @@ -2019,6 +2024,12 @@ static inline struct sk_buff *skb_get(struct s=
k_buff *skb)
> >>>   * If users =3D=3D 1, we are the only owner and can avoid redundant =
atomic changes.
> >>>   */
> >>>
> >>> +static inline bool skb_data_is_shared(const struct sk_buff *skb)
> >>> +{
> >>> +     return skb->cloned &&
> >>> +            atomic_read(&skb_shinfo(skb)->dataref) !=3D skb_dataref_=
bias(skb);
> >>> +}
> >>> +
> >>>  /**
> >>>   *   skb_cloned - is the buffer a clone
> >>>   *   @skb: buffer to check
> >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>> index 966af3beed94d0a9f0387cec70b5297eccfcf19f..f4c0645f98d3f2f0c8765=
403e0184769e928d7b0 100644
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -2331,7 +2331,7 @@ int pskb_expand_head(struct sk_buff *skb, int n=
head, int ntail,
> >>>        * is not we can just drop the old head and let the existing re=
fcount
> >>>        * be since all we did is relocate the values
> >>>        */
> >>> -     if (skb_cloned(skb)) {
> >>> +     if (skb_data_is_shared(skb)) {
> >>
> >> I'm sorry, I can't wrap my head around the above change; I have simila=
r doubt WRT
> >> the sashiko reported one:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831095952.338=
5596-1-edumazet%40google.com
> >>
> >> that is: I can't see when the new condition yield different results fr=
om the
> >> old one. Could you please describe exactly the bad layout and were/how=
 it is
> >> obtained?
> >
> > Hi Paolo,
> >
> > Here is the exact state layout and sequence where the old and new
> > conditions differ:
> >
> > 1. The Layout and Values
> >
> > Suppose an sk_buff is marked with __skb_header_release(skb) (e.g. in TC=
P
> > or skb_gro_receive()):
> > - skb->nohdr =3D 1
> > - dataref is set to 1 + (1 << 16) =3D 0x00010001
> >
> > Now a clone is created (e.g. in br_flood() via deliver_clone(), packet
> > socket tap, or veth):
> > - __skb_clone(clone, skb) sets:
> >   - clone->nohdr =3D 0 (clones always have nohdr =3D 0)
> >   - clone->cloned =3D 1
> >   - skb->cloned =3D 1
> >   - dataref becomes 0x00010002 (or remains 0x00010001 if
> >     __skb_header_release() was called during GRO on an already-referenc=
ed
> >     buffer).
> >
> > If a clone or sibling drops a reference via skb_data_unref() (subtracti=
ng
> > bias =3D 1), dataref returns to 0x00010001.
>
> This is the part that I can't follow: skb_data_unref() subtracts 1 if
> and only if nohdr =3D=3D 0. dataref should stay 0x00010001 only on the
> "original" skb with nohdr =3D=3D 1.
>
> I feel the issue could be caused by __skb_header_release() being called
> on a cloned skb, which is AFAIK illegal. I *think* veth in bridge with
> GRO enabled could do that.
>
> Perhaps adding a DEBUG_NET warning in __skb_header_release() would make
> sense?

Arg... I missed that GRO can be fed with nohdr clones (from veth only I thi=
nk)

We keep slowing down GRO to the point it is barely an optimization.

Adding back skb_header_release() and use it instead of __skb_header_release=
()
in GRO will not fix the fact that GRO messes with frags.

pw-bot: cr
