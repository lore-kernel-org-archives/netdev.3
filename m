Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3C44C509
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914021; cv=pass; b=U2Iqh7WZev+5QOjO/TCdigIt2aniMaF5RkO72U9yBLOgaw6jFi0TiYESyIODC1hMR4I27o/hvsODx3QuNDh7naO5vffc3hzqMgTC0F5MaZsK+67G43I51/zFyrarcmNOIpvQ7/FJXNq/udYr4xKQ5gsHG6R/E0q6IT71PFyXm9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914021; c=relaxed/simple;
	bh=FIMjv0TgGgy17MQGpRYe2YwxAd2lyHtGyEkX4WfN6CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgy7jQdNkc6/nvnUI/kqvqKC6wUPFX2CjweGiANMhycxFCD7xqf8kM6wedIFWYoTJkJBnFKuj1GVSNafRVR0DFyiR2npcObYqEt1+EsdfChNl8TH52wr2xD4eNAxe2oW8u/BNvEG1a4JDmEeF2yPNOic77EtussRJ0dhRZfaZRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9RHEj5J; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9RHEj5J"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cede6375caso7245ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784914016; cv=none;
        d=google.com; s=arc-20260327;
        b=TJuh7DQl1qD9G2DWF1aKLt0/mHdBhSsKw1W8VelP+SP4BEgrNwIShdy53fae8BcKEq
         SxSOnbyPO1Z3jg2oAI7nUbAymsgaXYXRiYj6n20xjiBAS4KvJR66PIb3bO+7MoJgYZ9L
         kg/K/nxpSNK/WHYIK/iAbHOWpGupamqMUYMZfmFv4+NyPrAugpLCfFZC+hsoUrLtYtNN
         qAfNR/gO6I9fuvRTA+t4KPGkAFZqMUZ7FtLokm3mWk9RUgowt6qhBpTg/UvNOMS5+0vz
         W04CkhsMBj5sp7opHTRT2b9qKJTRea2yKUlm1jI6jYpkGwc5Y+dN8UYKykdhGnD2I6jC
         hhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9iY8wQYt74AJKa6918vJxaFgPnKzhCetwYvbAm8aPVU=;
        fh=RB1JC3Of4aCRtEqPcfOq1GdJ5BXXql55Oj3+ohsWDFA=;
        b=VGoTMku9Y3O9RlSDeJgYi1+TEYF0KjW5Ii1quR6IYo2bbIkuQKgEElPqs3OtoHpwTQ
         YZbQHGiEaKjlbBMkXYZVgffOGjxsdizwvxdhpekSNaPGxVjeBCKjPQE8NpGo3mpZB1Tj
         dLL0JIVC0nNT9Y0UXP7LsTx7v2Dvre04q8ox8HeohM0QCElL01p9KdoM/lhVk8iWmwby
         DZICx7A+6SVkcGEDWbG0v3imBWYYSwa7gfWSqm0JkEf2V/BSzFtIBfTyGwk6DKz53Mgv
         V5NNjOfZx4xDnR+11uS2vuj809un959dUheGxdgJXLlpKfqkIjj7/ZuCNP5q0aAkWA1v
         OX+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914016; x=1785518816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9iY8wQYt74AJKa6918vJxaFgPnKzhCetwYvbAm8aPVU=;
        b=h9RHEj5JnlQu50PfXugeJypAzYUO7UNd9+SJoXR2PXbwK9Q/Elc+7px0i9J3Ernlar
         MLClGFtdqkfiPSADYXu5DXDZpQuBzCJrpb93sSvHEntr0708s09nC9a24aXy/3GAspRM
         lycX4XVTa1dcKx7utRW0zrsgMcICjbNMT0LogNR4GFp5GFQvgC9NTYVpJeJ08D1PII31
         Db/ojUrx59M85AYo53GLuplBJ+QjCSQTJrmE58MhuJLRe0FI+PfejGiD0xN66W+HwkXj
         aFZdYmkI7bkv5gNFQ0ICpMcOCvoZRGoSleg18ZC9lAVCF/wGde/9KF7PlqSaqZW1IHEM
         X1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914016; x=1785518816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iY8wQYt74AJKa6918vJxaFgPnKzhCetwYvbAm8aPVU=;
        b=ki4JBpJrKbK/xLNCfKgKXzj0FPcu0B4SjoA8FM6PeGOo6MLdHuF8duv0uyayRmOKfF
         ZhDtQbP5+oS38U1A89x/FOwEhiJNiIAWo6LnEKdY/Y3hAJDSeZNWt+ww2smoFzYCypM3
         oOVIx2hPcsuRv3ZdDaNqDfRGcpDSZ4kD5jBG1fnpJTHznVtx3ECfdMUvcA4xDvGcxgbV
         nMWJyjlQrJjZUlw+VPEydLt+5T7lDsVsO1/6XltM/OjjkweklJ+quoC+LC6+qLHZBpCt
         tdFK+9KtbIY+E99RVHTz0Yv9xl7BhoH/nHXMfrfv1nxINuct/zVgNWDQ4Lnn6CG7cmuN
         CfYg==
X-Forwarded-Encrypted: i=1; AHgh+RoXW3b44OzHO/zjqaHWcBe0G+AoLr4n4QZou9oOW6JC/IFHHw8kfDo8SvvZ67NZCruwK0Lmo3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuoKp7DBYuy3ruLZAnN/T7um3YSN+gFxL99XfIaZw8FWxsmAG
	pgcSvvPj177b+2FCKcVrOuxitXGI1qAHnUWbJJUWbqgR0igltLKyphLBsBNJ3+B/59wsdpgWo4s
	TdhKHOCN9rVLm2uGmcwNKotWZ5OGeTEG/4FRichJS
X-Gm-Gg: AR+sD13JHd5PmHTURsgrPxFnx72cSemSYNVLMy2P3w4LrnGNqhJbWXEnJfF4XESQVXp
	YRUuAungE2QXb4xKKDDGrcpUbvMQOLOQ4wFqN/JVKYFT8StxqwTCItC0bss3nQMkjZGGmh6kNEA
	u2UDm1BUEIfOJ3/4qsDCpa8jD6R4C7PukhZ0p3S8Lx1K548w/ZwIINqWXvtnI0AQGxkzKbwN5k0
	tEsW1bQpCStqRScJ0RgOajkBi3N4jYrOuOjw4kOzKreLnIpWH9NV5xYYwMZSQc/cJkuHR2qXZLq
	TBLK/WLIreH47FQ=
X-Received: by 2002:a17:903:986:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2cfdb4fe905mr449505ad.2.1784914015020; Fri, 24 Jul 2026
 10:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
 <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com> <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
 <amKfTT8Z28mMg+qQ@devvm29614.prn0.facebook.com>
In-Reply-To: <amKfTT8Z28mMg+qQ@devvm29614.prn0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jul 2026 10:26:42 -0700
X-Gm-Features: AUfX_mxLF5LfrSvI_wWMyVBIxoQ5ZFihDHxVE34eD-1n9qB10po8uNoc4l033wc
Message-ID: <CAHS8izNtr3U2te7rOqYDyjfkFsv3aSGms4YbtuNidPUWcHYzCA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:10=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Thu, Jul 23, 2026 at 11:35:15AM -0700, Mina Almasry wrote:
> > On Thu, Jul 23, 2026 at 10:24=E2=80=AFAM Bobby Eshleman <bobbyeshleman@=
gmail.com> wrote:
> > >
> > > On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
> > > > On Wed, Jul 22, 2026 at 3:59=E2=80=AFAM Pavel Begunkov <asml.silenc=
e@gmail.com> wrote:
> > > > >
> > > > > We should either have net_iov or page backed frags in a single sk=
b,
> > > > > otherwise it blows up down the stack. Don't allow mixing in
> > > > > zerocopy_fill_skb_from_devmem().
> > > > >
> > > > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > >
> > > > It's true that we don't support mixing niov types and doing so woul=
d
> > > > blow up, but this is an unnecessary defensive check imo. The callin=
g
> > > > code should not (and does not, I hope) have an edge case where it
> > > > tries to mix and match niov types.
> > > >
> > > > Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling c=
ode
> > > > may be fine?
> > > >
> > > > Also we don't really support mixing different niov sub-types in an =
skb
> > > > (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> > > > and check that it's all devmem niovs specifically.
> > > >
> > > > And might as well put the check in skb_add_rx_frag_netmem. It's the
> > > > same situation on RX, we don't support mixing there (and I hope no
> > > > code path leads to mixing today).
> > >
> > > Hey Mina and Pavel,
> > >
> > > I was able to confirm this mixing case does exist.
> > >
> > > It looks like in tcp_sendmsg_locked() when new message is non-devmem =
(zc
> > > =3D=3D 0) and tcp_write_queue_tail is devmem, the skb collapsing is a=
llowed
> > > (though same-frag merge is disallowed).
> > >
> > > Adding a mode to ncdevmem that sends mixed devmem and non-devmem
> > > messages, it can be caught hacking this in:
> > >
> > > /* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unrea=
dable)
> > >  * and non-devmem (page, readable) fragments. Such an skb must never =
exist.
> > >  */
> > > static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
> > > {
> > >         bool readable =3D false, unreadable =3D false;
> > >         int i;
> > >
> > >         for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> > >                 if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
> > >                         unreadable =3D true;
> > >                 else
> > >                         readable =3D true;
> > >         }
> > >         return readable && unreadable;
> > > }
> > >
> > > static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, .=
..)
> > > {
> > >         ...
> > >         BUG_ON(!skb || !tcp_skb_pcount(skb));
> > >
> > >         WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
> > >                   "DEBUG: TX skb mixes devmem+non-devmem frags (nr_fr=
ags=3D%u len=3D%u)\n",
> > >                   skb_shinfo(skb)->nr_frags, skb->len);
> > >         ...
> > > }
> > >
> > >
> > > Resulting in:
> > >
> > > [   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=
=3D2 len=3D24)
> > > [   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_=
skb+0x9bb/0x1030, CPU#2: ncdevmem/278
> > > [   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
> > >    ...
> > > [   85.915617]  tcp_write_xmit+0x47b/0x17d0
> > > [   85.915802]  __tcp_push_pending_frames+0x38/0x100
> > > [   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
> > > [   85.916244]  tcp_sendmsg+0x2c/0x50
> > > [   85.916903]  do_syscall_64+0x11c/0x610
> > >
> > >
> > > My feeling is that we should guard against this when
> > > tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In =
the
> > > zc =3D=3D 0 case, I think we need to check if the queue tail is unrea=
dable
> > > and 'goto new_segment' if it is?
> > >
> > > This is a different case than Pavel's patch addresses though, where t=
he
> > > new sendmsg is devmem and write queue tail is readable.
> > >
> >
> > :( Yep looks like we have a couple of bugs in the TX mixing. Sorry
> > about that. We do indeed need to fix this ASAP.
> >
> > I don't think it's enough to check readable vs unreadable, no? Because
> > I think appending io_uring niovs to a devmem skb will still blow up
> > and vise versa, even though both are unreadable, right? Or is io_uring
> > saved from this somehow in both cases?
>
> I think for the above case it is okay because if the current sendmsg()
> is zc=3D=3D0, then we don't care if the tail skb is iou or devmem as
> skb->unreadable tells us enough to avoid appending the non-zc sendmsg.
>
> I'm realizing this a different mixing issue than what Pavel is seeing
> though, probably needs a separate patch.
>

Yes, you're reproducing a different edge case that results in mixing.
Do you plan to send a fix for that or should I take a look?

--=20
Thanks,
Mina
