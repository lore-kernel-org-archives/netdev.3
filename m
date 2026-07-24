Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F5323416
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914870; cv=pass; b=sc1BNcVE7EdnoVaiykOGCAeyoET78fmG7eMiEgt7z0VQZfdOcAXR3Rpc48pUg4TbUymZ008LXmf+MFKPykBUO4iZDpfCc5kTdRj7L5TFEgpZTohYuc21/mI36IkH4gcw5uaj1vYJmkXLXAFHkeENg8yFSOtwymscnzCoo4J0J6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914870; c=relaxed/simple;
	bh=jFTqZR1qM9dIQ/c9OVhrnZ0wAgis8bvY7JbzG5YM/R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuqfwCmlwtS1FuHlEpXLB4DOq5/JcPfDe2iUeNM4Y1Qa2QTew9K8EoB5Nhlr67EC1uDw/VfRZM1YqI2J6jmhos8+c9S1sqIa4bQjKfZjEUQWqIG06/+MuRqw+sHASSGErZv/Y3LgedMAzdBNG2sBi7grGK+nZwVy3Bnk+h5uQyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPWGaiEI; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPWGaiEI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso8975ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784914869; cv=none;
        d=google.com; s=arc-20260327;
        b=c72CsT0ZNMd0QlGONrBr6XbwKNUQ0vLjiKAV4KMMAuE4lF/foP7aoqKE+fzk9SJnVD
         f4AK9qNAhEunnRK27UITzZR3QKW9x0NqWJElFTLinWHjl/UZY+FBPdWtxVchHDmebkqJ
         j4vu6U3kktm6zZVWoDj0g0XuOVh49cfTxKu7GTyUEpQhAH3JHlHqC4o0woJA9VYMUPzY
         rBTBp8I+i1mTiYvjf4IFVDI4J7I4wXNB36qZ7FhoMR6lydJjPVOy9SRQCVmG9icgXh6k
         wFRhICIhnuEB8ecARMoJ8bms//kPK6G8nOQ86Iit+mIB1NThNh8hVh0IxkTKlamM8HDc
         Sj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sx8VAwImMj2+6oR6j3HVZ/pqtzcC+HybRg1o0CKWPHU=;
        fh=gR+pBQ3D/37WQqqh9EhAygumTkAG7ZQUWntJhNdyc9I=;
        b=NaoVEhXC3sBaPli75SAIW/zqTl9EXbu5+1XXnarSeP35NeN5fJPCxUpA1PN7TXUj4b
         JxkYAQ+ulOjZQUhSDeM54HgIYLmoo4D+9uGDXxTjse8dVgO6GGrYObV5vk7q4QGAncJB
         vlanV+92pGK6WBpKbXc4mO/7Jpma716mUn61UCGO2WTsj653jAvm768LnFE1IAprPcyG
         wPokSIa6XpVvNPv5Lm3YKwP40eWX1QRjgQH36y35U5i00AmXnjthWn7Fb3zh7HSthzwE
         /do8I5Hpb+L43Kn8IfDM1XAUiM1bWNVsCoL6Vi1PleAwjuxv+HU5vzNno8Tzax3XA11c
         GKoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914869; x=1785519669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sx8VAwImMj2+6oR6j3HVZ/pqtzcC+HybRg1o0CKWPHU=;
        b=bPWGaiEIxYsYz4nl2fQfvoMC/vmxEArx+iROOtShoo+LhGzYe7UQf3vW98JobqV9Bn
         0iiEwpb+WVhIXkeqwHHe29hLcw9rQKQ73PNWMzfLJIu4S5byexNwQTTeNrZ8TtY9nfEg
         kzybC8/Shj/Jaj3q3Ve+w6vG7X6bWTi7IQ52vWOk0fe4V8X3v51miVA5/2fCe7xgS8sB
         s2r3uzLOh+B1xonpbFLN6pm8+Fg3qHaRFT4r5wfbOWcnIO89smgHjOivXM9kmXH/ADg5
         xGgDuOuVA4i7HfiHN5z8amuojDzSJS5sX0tjEzqlm8niNExsboD93s+MwQl5LdUgatFg
         3wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914869; x=1785519669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sx8VAwImMj2+6oR6j3HVZ/pqtzcC+HybRg1o0CKWPHU=;
        b=NkFrrRtbrNsmGedLWBklZO7mf7vS4TCxLnboqTsxYshfCqBR+icqLfjv68GNh4BXpb
         cF8DXBsYNBqttW9lP6A3vmzhfriQkL73tS6DwAy4+ROXD5s63Eykjx+hNt9dKneJzZyC
         qNZ5mJ9swKgAs3APLiw0ANUIQwUnayhiW/aLy91hEqWdqJAQvzXiAoYDkepneGZXAsfe
         WS+BaJPfzW8MZ2Vyaq+hApRjkyA2L46l/HiWPA7C1DVD44RxUQ1eHgmOV3tp9h0VyNh0
         F6aHiPIgL4Shk9ISEbubifOXnGtgYAqWtfe0dotWcHloPXKJXQaMZzFzQVQx6djBAHhW
         6e8A==
X-Forwarded-Encrypted: i=1; AHgh+RrGrGGJmfvSmDHbIj+DQ4kUl4WdUG0NwwujdJkm/HHA+fAYA7SQir/mBU2F9BAaK4jjN+aVzEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnfrOfj4clukQYoKrLYmbpWlb1cwbi6SyUS/gpGrU/qq2jOQ3
	9fB63i6S0vvJn7stGDbRBYr4gCUqSbAxZlJDNuXmGOCRGCxq590Us4ZtzSoPmHeNJOm9UtJBFfX
	pvVaYkXgpEKVn8v/7MICkxmROtMHLNDcixcVeGuHS
X-Gm-Gg: AR+sD11S6jIO9v1lZwE1HTF8vn0OogE21btgyHjhnDyWNzlV3mvXc9crwEyJwaaDpcn
	Kucph0RXWjI551dwMr76IckL4GSCtTTjVcn7oU7IhjYs28/In+HO6IaHuIx0LiqcwpJyyxcl+NU
	K3F2Tf/iELflPTWdavXhlGsYHaQ8iadKPr1Q2lXtyIGBNAmI+ID82msHHPRlnQMauTMyjqtfL2l
	TMsmqvdB+Xw/DKEiK6ItidZkesIxlixWrQvvpvg2y8xXA1dZe1bTea1Gj7EnRvt9o0SPcCX83fO
	oHwKylt41c+FiqA=
X-Received: by 2002:a17:903:3d05:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2cfdb739e2bmr403085ad.5.1784914867738; Fri, 24 Jul 2026
 10:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
 <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com> <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
 <CAHS8izOS9C63UMvVN=Z+enWkwFhPr9Aa69UZE4dkUOL_JyGUGQ@mail.gmail.com>
In-Reply-To: <CAHS8izOS9C63UMvVN=Z+enWkwFhPr9Aa69UZE4dkUOL_JyGUGQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jul 2026 10:40:55 -0700
X-Gm-Features: AUfX_myzmisxZ5MuOfwvsMtBruwoF5aVZr3ZUDQlaecv37FDFN86edSALaMCr0c
Message-ID: <CAHS8izM+Os3Q0HjbVCCj5RZzszRcB2EpehbDLCcDL=Z3qv05cQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:25=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Thu, Jul 23, 2026 at 11:35=E2=80=AFAM Mina Almasry <almasrymina@google=
.com> wrote:
> >
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
> >
> > If io_uring is vulnerable to this as well, then fixing this becomes a
> > bit more hairy because this is a TCP fast path. We don't have bits in
> > the skb header telling us exactly what the skb memtype is (only
> > readable vs not), so we'll have to check skb_frag_is_net_iov(frags[0])
> > and netmem_to_net_iov(frags[0]->netmem)->niov_type to check the exact
> > type of the skb memtype, and that may be a lot of cachelines to fetch
> > in the fast path. :(
> >
> >
>
> Responding to my question here:
>
> So AFAICT we can't actually have io_uring net_iovs in this path.
> IO_uring ZC deos not support TX, and (the LLM) thinks that if we
> receive an io_uring zc rx packet and forward it, it's still not going
> to hit the tcp_sendmsg_locked path.
>
> So this seems sufficient to me, Reviewed-by: Mina Almasry
> <almasrymina@google.com>
>

Sorry for the spam but I checked the sashiko feedback after responding:

https://sashiko.dev/#/patchset/06f0d5ce07dd8593a69239cfa56745cb9c7d957c.178=
4717791.git.asml.silence%40gmail.com

I think Sashiko is correct that the EEXIST is not getting propopagated
correctly to the caller by skb_zerocopy_iter_stream(). I think we need
to fix that actually.

The other issue Sashiko is pointing to is the same as what Bobby is
pointing to in the other thread I think.

--=20
Thanks,
Mina
