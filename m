Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244880;
	b=eN4MSVbh2YkStcRFWzx1TKS1114SbKN+R9Ij/QlUqp4DCkdXEfQs7xCG/x5aJAfWPfA6
	 4HeQCjqMJaBdflQQt9sB53UQ0diLHaArZrEj7iUOk3nfaMP388K91IAt0sbQ7s/mmitOZ
	 ombK3DfcvUbR8e7PBSPRo8wEd2w/k8CdL4ZIGLmYLkbNr7Qex+tsBeP64IBerTU1mnlYF
	 U0l584LIxw6vcnVeDZMRAUDKlRBy8uWzaFOwV+6TsgdHIrc1rB0x3YcQwX1v+I8kWUB/j
	 LqUmnBlT27XdrdCQE5lzWCmHeOgitqoWtTA4ad/LP5GQfll/rmIoxCzQWPAYpqCuvMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Lya5VOYipCBA3m/jA7lCTGHVEoCh2C48za/J5i6OB14=;
	b=pe/s7qaoy4LVcTuyT9XmIoWXSosDd62qlkWSFcpuK1KwxJttVORU+hTYzogu0q1moAVV
	 jYxmbEUqM0OmFgtVsvjpwIPZAZDVRQMAjqoFKMKdrhSlEJnIkVGWzA8Dxn7VKznvAMCB/
	 eGpMzPg2yEhj3l9a58tqHRtUnyxYd8Rpu4KLF5dlpkC3d9RqpSWTfnzZqsYDAdlF1t+KZ
	 0OcMH1HrTssBu7h6mX8kSwUItdXiHZgyE1BqAV1zFdunpPIvTDc97qpny6Iu6AZ4A3O/r
	 RBk37t2a9DS0ps8yCXpT5GTFb18C1f5wHfr8AAJ9uk81hT/Yj0wTyfJi4Iww8BbeADw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N42WBtPw;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997C606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3997C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N42WBtPw
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so461577eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244879; x=1794849679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lya5VOYipCBA3m/jA7lCTGHVEoCh2C48za/J5i6OB14=;
        b=N42WBtPwfgmD+BCEgS2a0LNEND5FwOLphMbydWHo16YodSBir7Vub1vLXMCm/Ivd4U
         qg5LmPrOIyA0mrPw4++UM4hY0eBjpee6fNoOQYEHPpRFakTyADiuKjCJie9Ru4EAqUwR
         nw5ioq5ZipiYslJtxUMMYZGU7zj5+3jP/FkhmGvkXlbYLygXQO92TtOq2oQnH6MF4PlB
         B85CODk4yitL4Cg0dYjip32Un4PdmjLUu5xCTvU9QwaAwVla1Yv6efJSelNZle7y8etH
         q+EUFZbvWsrg2+wy7L1Pz97ytHf8/PYD8LUzh3EUxKoeRLog3RQWb1I3y/7AztzQHbHv
         XsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244879; x=1794849679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lya5VOYipCBA3m/jA7lCTGHVEoCh2C48za/J5i6OB14=;
        b=XezYe3aMGdCufVtw8gM0UGuIl/PXCV6if+6vb2Na6HgyM9DNkKsS8raEShBEApvodw
         V4oF22QD9vfeHhgkuxDIR8JdgNajUTfQyrxmoXKw1OR1fKedkSjvPQFZ3I610sfsmpH9
         mPhbM6j/TELSzIo+Hita6yAr6lHKlk5FwPmKy/aksW30/f+8t8lsnmfBqMTf7OdSwfe/
         WpNW13ziqqRoJM73lnfwwRbe9SDY2V5mmag6TvEi7zIAYTc92cMV182vFWaOlcOGnVDv
         Y4e1c/kfPrI+8gYJI4r7K70loXCSMd312SKqKYv4J5cLiVqD2QA0qChGd+A6PoSG0a8K
         NBBg==
X-Forwarded-Encrypted: i=1; AL+hErHd/Yu5kep7vhum0pQ6IcYNIVOVqX5C9vdpuY70ekyJ+5VrTbJ4QQmmwvujTO2bF3CGSQ8MM3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+o8kmrWnKkSzmyXIIzqL6EiJ105aObRRzy9v4/+qRaomF+/jel
	/woNV6XAFlB0rUpO1YLJUweThznhpZSyZKoEVm9Wanh8XS4FebaPvLJs
X-Gm-Gg: AYBFou0uWqQuhmnfPlw2kQahd3q3EaFc1dqiNZCoqVPQAvdr7cpHCx4V5p7BaynKrfs
	mIJzqUjWQehppKjH3orxRPaPv8vmDSvorYYPJjuK9dzfLlsk73tES7k4PRnLTM4YCGuRq4ohuHR
	V+GkC8ZaVt+C96IjJ1sSqCuXTd6QXnfAvSMfOZfpkMTug6OiRaWOQ1n6oZK/qVU7ap+KS9K1xtq
	RIe5NESqNnpTigazMX/gQG9rjPPIWX+rHMB0rDVEZWA+JnsWsOWXfk94HFqXopEtOeqcQT7nDQE
	gc9e4IFPL3GKR9lE+SwA8fEhDujp6TfxQPi56//7B1SsqYyniBsN5wwvinP7CW1SLGm0xmJcrWW
	dQhjRv5UK53qGWMeb4Zhb+mNpdcUbCtndCZQLzi450JYeD7fXOMdSHZVlIS/8oWIKf+5aFJB2oT
	x0BTR40f/Hi01f24xN5yWYsp/H5UwP6d2+KzukSR6o/pdpdqEYlZN6Db+GTN21YxNlywbfRVCbL
	0I1U6GIGjUUOT3SfGXThXQwU0I3GTT7d4HFjWDer3oroz+MEd/y2xXCDGQTIVU3loOF+WAJ5mox
	pSVKEqwWoM6cI2u8vOI4XQ==
X-Received: by 2002:a05:693c:62dc:b0:36f:5746:3369 with SMTP id 5a478bee46e88-3725807c859mr7945389eec.24.1794244879122;
        Mon, 09 Nov 2026 09:21:19 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372666d2fcbsm14268734eec.24.2026.11.09.09.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:21:18 -0800 (PST)
Date: Mon, 9 Nov 2026 09:21:14 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v3 2/2] net: prevent mixing frags from different
 memory providers or bindings
Message-ID: <avIAOgCLksqW-ZNP@devvm16445.scu0.facebook.com>
References: <20261104042521.3979880-1-almasrymina@google.com>
 <20261104042521.3979880-3-almasrymina@google.com>
 <auy0aaY0-g32aYi9@devvm16445.scu0.facebook.com>
 <CAHS8izNrM+iaT6OOJVoZdVp00TkNRhFe9ucCVrwaUWL0oQS7Ow@mail.gmail.com>
 <au5SPWdVCuso8Esq@devvm16445.scu0.facebook.com>
 <CAHS8izNXwhTybUHk3Zkh-cmp9CXz2m9kXt-NoB2huu5co1rGAg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNXwhTybUHk3Zkh-cmp9CXz2m9kXt-NoB2huu5co1rGAg@mail.gmail.com>

On 11/07, Mina Almasry wrote:
> On Fri, Nov 6, 2026 at 2:22 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 11/06, Mina Almasry wrote:
> > > On Thu, Nov 5, 2026 at 8:59 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > > > +static inline void *skb_net_iov_provider(const struct sk_buff *skb)
> > > > > +{
> > > > > +     struct net_iov *niov;
> > > > > +
> > > >
> > > > [..]
> > > >
> > > > > +     if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> > > > > +             return NULL;
> > > >
> > > > (a few nits/questions)
> > > >
> > > > Why !skb_has_net_iovs is not enough? (and if !nr_frags is required,
> > > > maybe fold it into skb_has_net_iovs?)
> > > >
> > >
> > > Well skb_has_net_iovs only checks skb->unreadable, which is not
> > > actually enough. The skb doesn't necessarily have net_iovs if it's
> > > unreadable, it technically could be that it has no frags, right?
> > >
> > > Technically we should never have the edge case where
> > > skb->unreadable==true && skb_shinfo->nr_frags==0, but I don't think
> > > the code is careful about that today, and I don't know that I want to
> > > do a global refactor everywhere we remove frags, which skb-> flags
> > > need to be updated.
> > >
> > > but you're right that it can be folded.
> >
> > Not sure I'm buying that, but happy to look again if you disagree. I think
> > the only way to make an skb unreadable right now is to add at least
> > one niov frag? Don't think this is (ever?) gonna change? What does
> > and unreadable skb without frags even means?
> 
> I have no doubt that we set skb->unreadable correctly when we add an
> unreadable frag. I have doubt that we unset it correctly when we
> remove the last unreadable frag (or we do it correctly for other skb
> flags like pfmemalloc). If you can trust it, my LLM confirmed my
> suspicion:
> 
> ```
>   1. skb->pfmemalloc is NEVER cleared (or recomputed) when nr_frags
> becomes 0 on an sk_buff—and isn't even propagated in skb_split() /
> skb_shift():
>       • None of ___pskb_trim(), __pskb_pull_tail(), skb_split(),
> skb_shift(), skb_condense(), gro_pull_from_frag0(), or
> __pskb_trim_head() touch skb->pfmemalloc.
>       • Why it's fundamentally broken to just clear skb->pfmemalloc =
> 0 on nr_frags == 0: Unlike struct xdp_buff (which has a separate
> XDP_FLAGS_FRAGS_PF_MEMALLOC flag that BPF helpers clear via
>       xdp_buff_clear_frag_pfmemalloc() in filter.c:4441-4444 and
> filter.c:12740-12743 when !sinfo->nr_frags), struct sk_buff has a
> single sticky skb->pfmemalloc:1 bit shared by both linear skb->head
>       (skbuff.c:515-885) and frags[] (skbuff.h:2631-2632). Clearing
> skb->pfmemalloc when nr_frags == 0 would wrongly clear pfmemalloc when
> skb->head itself was allocated from PFMEMALLOC reserves.
>   2. skb->unreadable is cleared in some nr_frags -> 0 paths, but still
> missed in a few others:
>       • Unlike pfmemalloc, skb->unreadable only applies to frags[] /
> frag_list (linear skb->head is always CPU-readable).
>       • Where we DO clear skb->unreadable when nr_frags == 0:
>           • ___pskb_trim() (skbuff.c:2810-2811): if
> (!skb_shinfo(skb)->nr_frags && !skb_has_frag_list(skb))
> skb->unreadable = 0;
>           • skb_split_inside_header(), skb_split_no_header(), and
> skb_shift() (skbuff.c:4228-4454): cleared by Patch 1/2 in this series.
>       • Where nr_frags can drop to 0 and skb->unreadable is NOT cleared:
>           • pskb_carve_inside_nonlinear() (skbuff.c:7139-7167): if
> pskb_extract() carves past all frags[] (k == 0, e.g., into frag_list),
> shinfo->nr_frags = 0 on the clone without clearing skb->unreadable (if
>           !skb_has_frag_list(skb) or if the remaining frag_list is readable).
>           • __pskb_trim_head() (tcp_output.c:2020): sets
> shinfo->nr_frags = k without checking !k (in practice tcp_trim_head()
> is only called when len < skb->len and skb_headlen(skb) == 0, so k > 0
> unless a
>           frag_list is present).
>           • skb_try_coalesce() (skbuff.c:6365) and skb_gro_receive()
> (gro.c:131): zero from_shinfo->nr_frags = 0 when stealing frags
> without clearing from->unreadable (benign because from is immediately
> freed
>           via stolen-head free).
>           • __pskb_pull_tail() (skbuff.c:2894) and
> gro_pull_from_frag0() (gro.c:416): cannot be entered with
> skb->unreadable == 1 (__pskb_pull_tail() bails on
> !skb_frags_readable(skb), and
>           skb_gro_reset_offset() requires skb_frag_page(frag0) != NULL).
> ```
> 
> I already have 1 ambitious refactor on list to try to remove
> pp_recycle. I think maybe I want to do the nr_frags checks in this
> patch rather than do a global cleanup of setting skb flags correctly
> so that skb->unread is 100% accurate. WDTY?

Hard to say how real the above are and when they happen. But if they
are, let's fix them separately instead of defensively sprinkling nr_frags
checks everywhere?
