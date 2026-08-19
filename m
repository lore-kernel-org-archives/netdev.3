Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FF31B114
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145087; cv=pass; b=JvnYuujoF9gdEvDRq/6Hi5QwB0Bnl+pSiyvPIpd8+zVOJUYLjMYCWudDCzMYujhPONdBMzVH0IPWq/7y8RO1F9I3L2He6oXS7QuxbYkN5mHjwvwBzFfoe6bb+m7gaPKOszxXGyNLyd2P1rfLOL429my+toAiMEW3N36lY+IpGu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145087; c=relaxed/simple;
	bh=jZA7PfmaHwVlgmpuxRi0/nvXo5xy/5VleZLudxxD3uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzMEqb7DPMI/k70v+sDYsLic4gYWokFAj7FnwXZKnePO4XHawDmc/vNvs3u9suJAV0+8sEODeM4H0TmpVVWZbgRcV1wQ1X1TXrl1XRjEmyWKSNM/3RwWQzcw9GsQmAznRAAszykbDjCFC+VLyLGfHszB0B+XrC31k1kroG85OJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSPSEJ0z; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSPSEJ0z"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-527e352a167so5977821cf.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145085; cv=none;
        d=google.com; s=arc-20260327;
        b=QSIPgCiu7EB5s4gZZduzlGqLscix2ZLCFF/aSDPl9kHswH8VMa13ByT0Bw3P+e9Qih
         WOfHVW1Onby05nSrwrrfpUcKxDrbq3aXq3HW1GGDK44jowm8GDMEWYsWW0BBPciwvRUv
         F8cCWVXb2tSqYEeQKKz9LylGpgGOdeS7BrPS1r6x8NW+EpWoj0GxxPfcswqhuU/tg22A
         nn301HEFqGGRnGgFRsYIM2RRjk56mhah3ZahkqVyDSvoTHfKOZS3/Tgw3Fo56aC7lFn7
         NoWYFv3idzbx0VCtHVXGZ/A1GW0sZAdEzDWL7jMMnHPWQaS72w0DSwnFi6kSocfI6iSR
         3bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXOVCIGJalaSc2ZC+AY298+lQiGMbwLhDsw79HHVzFA=;
        fh=NLF5nafIvqM/zmpqWkw5X4Yp+OoanLewg96ou0+7umE=;
        b=VFyQb2YWjUyp3FZIIEixq1tI5qq1dSyox2z2UevuVVHMrFbRTuv4dawxcK/jXrNbIb
         7xZCPDXrH2iwqxEa4CqWZcJC8QaJ3YrS13KDbgcQ7mhM33w3+Z5VVWAJJXRDpGlRBY/6
         uJEhBZuLQILqDUSrkzp5uu/b0BR98x4yUNHxZn20N5Nde9c3Meqj/z+Atzmu2zwQzfAs
         drDlyC4hIzSH0Tbb+wP32+Aoiw4p+5t0tWLIiAMp/hxSCg/BOiJDvpND8DSIiyVR0eP9
         3HUru45Tb0VhjafumLZkgRD7BqbGTZL361EPthMD6kckndmbcMcYtF+RKNXhVPY6u9H+
         wm1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787145085; x=1787749885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fXOVCIGJalaSc2ZC+AY298+lQiGMbwLhDsw79HHVzFA=;
        b=BSPSEJ0zBFfi5ilSoHahB2OHXXEXkEeLQ7nz0T72KkNHa5coyDw0oKJCGC9We9MzY5
         t/dbU9/6zTwMP5gdjRwIljJMm75UYZ7uynwpDueNEbOZmbzycjXz4YWLhM2otPGu6NAg
         xAzuvwGpAwsjGNx/i2QXK93QcADkvoPYi1PZsdt+e+vX6m0JCnEzVTEEULHEJlMTKfOG
         KZDCuRjl96pkII8bmD0IcQJyyUKiYyyyZsk9gWAsG9R+yx5DekytN3ChhRiZErgdDiFB
         CzQnh44z1WvpV9j4+U3MjXfG5G/IIqYI/q0nSGo2mEqEX8bHd93sCSjC2Iessp183akK
         ZvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145085; x=1787749885;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXOVCIGJalaSc2ZC+AY298+lQiGMbwLhDsw79HHVzFA=;
        b=ocgJc/rSbeCSNb3AjoHiq7NFzaBOBZMtdPIBZGNGE0EEkXnURBaG/88BbX1uKkfoYX
         6cTfsmm4USkZ58xS+llCFZg13r7TaQT48MUugEPIZcCO5/MXdkVr+S8D+L24/BcbhZuv
         iRE3Rnvi7CKxB7KlWkACaJdNJ68bixfKz0dy+HKTPmQ4k8Qoqa/cCGsHFlBj3lE3e9CW
         C007PjlojmgZDlxwRQRG8WtohIks1C9Sh2dHNXHr6CIHYfKL6El8f9sjI3pt6Pmdpfxe
         lWRSs2vOxyU9R7f8BNhPrQBnctIJ4rVjnMQXTmc0Tb2KyJ9DdmZ5Oe49L/u4Ps7IYL2s
         S3ww==
X-Forwarded-Encrypted: i=1; AHgh+Rr/0uAU9WMkhC5lFUQLKG4zGQNL6sg+Ghmr8nPerG5l+9QMWA2v7rB1nFsF2SrlM49FFuBgYmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOSWtT2ybmcYyxbYUMvCAcK8oiP6axPl+C3x4VvWv19dXwJTo
	SJPItpXGBUZX/2TojX8Z2lOlm40gSvOfbKc+GOvm4BW7eWtuTTLVXjL9gfIuoMsmYqpVud+Ng70
	SH0+jFNBRHY/NrnDA6L+W4mM8wWFenoxrQPW2d0i7
X-Gm-Gg: AR+sD135sDx5Htdf90md4Faqer1i3Xho6xGdWGxbfd/DgbFxHdgEjuu/iINd/A5m6lU
	tKA6XBb37qpdN9USmlK/K0TWXLHxRrCcQSlODagl8mLy2GCt8Hx+qZUrhUNLz8X5JtUILw41FGe
	IRKEDgZo0REGNbjDQJgMRsvuLM+AohZWDtgKLjIUwCKq/6tFILnjmf7Bz+fo/dFrioaEZxZqTFz
	d1QUgJR0i3kCEfYcmLcfmpoN9v/05wzY8mguKT9sTGd8hf/uoDAVIo25TpPNTQA5hmh2oh04sT4
	lXrSM2d3iJ0GWh0duhonixjEy4DLyx6MkkXLOlTZ/e3t85iS6cbq/cb+CcdmHUFN/YxkuYVOd13
	NLdcKgTJleBhktmJtejh3L7aJkMAzAtNiZ/H7J3WzpXKTDeZezcK2ztrmCnPxkTxXQ8ZAxK4xU/
	hAYKOEYCWRvDOB/4o=
X-Received: by 2002:a05:622a:230b:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-52dd57ae120mr44284371cf.19.1787145084309; Wed, 19 Aug 2026
 06:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813033855.3372172-1-dongchenchen2@huawei.com> <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
In-Reply-To: <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 15:11:12 +0200
X-Gm-Features: AcwNN1UZfggmIhDQCQMpDuHpbB3kvC1RaYxq75aWZVqUNkzfAptYBk4Al2GV0Vo
Message-ID: <CANn89i+nK6aM7PQ9VBp8jfxhiJNsibx3pCoQhHvFNtUHfQomjQ@mail.gmail.com>
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, kuniyu@google.com, idosch@nvidia.com, 
	andrew+netdev@lunn.ch, ap420073@gmail.com, steffen.klassert@secunet.com, 
	laforge@gnumonks.org, jiayuan.chen@linux.dev, jhs@mojatatu.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 6:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Aug 13, 2026 at 5:30=E2=80=AFAM Dong Chenchen <dongchenchen2@huaw=
ei.com> wrote:
> >
> > Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
> > transport_header offset after tunnel decapsulation.
> >
> > BUG: unable to handle page fault for address: ffffed102091a42e
> > Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> > CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-0006=
1-g248951ddc14d #256 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
> > RIP: 0010:__asan_load2
> > <IRQ>
> > qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> > __dev_queue_xmit (net/core/dev.c:4787)
> > br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> > br_handle_frame_finish (net/bridge/br_input.c:229)
> > br_handle_frame (net/bridge/br_input.c:315)
> > __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> > __netif_receive_skb_list_core (net/core/dev.c:6287)
> > netif_receive_skb_list_internal (net/core/dev.c:6445)
> > napi_complete_done (net/core/dev.c:6813)
> > gro_cell_poll (net/core/gro_cells.c:74)
> > __napi_poll (net/core/dev.c:7735)
> > net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> > handle_softirqs (kernel/softirq.c:622)
> > do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> > __local_bh_enable_ip (kernel/softirq.c:450)
> > tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> > tun_chr_write_iter (drivers/net/tun.c:2032)
> >
> > The crash requires four conditions to line up:
> >
> > 1. The incoming packet is encapsulated and carries GSO metadata.  The o=
uter
> >    transport header offset is stored in skb->transport_header while the
> >    packet is still in the outer tunnel context.
> > 2. The tunnel receiver strips the outer headers.  skb->data is advanced=
 to
> >    the inner frame, but skb->transport_header is left pointing to the
> >    now-removed outer L4 header, so it becomes a negative offset relativ=
e to
> >    the new data.
> > 3. The inner frame is not delivered to the local IP stack.  Instead, it
> >    is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs a=
nd
> >    the transport header is not reset to the inner L4 offset.
> > 4. The forwarding path calls __dev_queue_xmit(), which enters
> >    qdisc_pkt_len_segs_init().  That function computes the GSO header le=
ngth
> >    from skb_transport_offset(skb).  Because the offset is negative, the
> >    unsigned cast overflows and pskb_may_pull(skb, hdr_len +
> >    sizeof(struct tcphdr)) reads past the end of the skb, triggering a
> >    KASAN fault or page fault.
> >
> > Fix this by clearing skb->transport_header to the ~0U sentinel at the
> > tunnel decapsulation boundary, after each tunnel receive function has
> > finished all processing that needs the outer L4 header and before the s=
kb
> > is handed to GRO or the stack. The IP/GRO receive paths then set the
> > transport header correctly when they parse the inner packet.
> >
> > Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
>
> This Fixes: tag seems pretty random to me. Issue was present long
> before that commit.
> Next time, please be precise with the `Fixes:` tag; it's not decoration.
>
> Also, calling skb_unset_transport_header(skb) directly from
> gro_cells_receive() would make more sense and
> your patch would be less intrusive.

Do you plan sending a V2 ?

This would merely be a one-liner.

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e8490c3b64a733cc93a30aaa84a54..626bbb9bae1ad4ea6657f5e0f58=
1cca0f49f16ed
100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3082,6 +3082,11 @@ static inline bool
skb_transport_header_was_set(const struct sk_buff *skb)
        return skb->transport_header !=3D (typeof(skb->transport_header))~0=
U;
 }

+static inline void skb_unset_transport_header(struct sk_buff *skb)
+{
+       skb->transport_header =3D (typeof(skb->transport_header))~0U;
+}
+
 static inline unsigned char *skb_transport_header(const struct sk_buff *sk=
b)
 {
        DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index 1b84385c04bd9c4539cbcc6140867dd98e229f61..d8c0a2867120199cec152503477=
3650f1ff24542
100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -22,6 +22,8 @@ int gro_cells_receive(struct gro_cells *gcells,
struct sk_buff *skb)
        if (unlikely(!(dev->flags & IFF_UP)))
                goto drop;

+       skb_unset_transport_header(skb);
+
        if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
                res =3D netif_rx(skb);
                goto unlock;
