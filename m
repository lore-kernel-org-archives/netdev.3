Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370457D215
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969452; cv=pass; b=fShYkVPAuh1zF5hkcS7ZF6FWVG4SptjqXsKPPhn9TRHlkMXY7BZ0wnl83Y1JsxBb19HXJxF9CDB6CC6xlh6UzkhPlHovKAfPV4TjPdvONVGnsespQej+7hcsVPRWUBxTxBJvkb8xPk5nP9SxLqAnpBuMCGGgV3sPG20gTn4PUGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969452; c=relaxed/simple;
	bh=HiL4SmBf+me2Wu//rQjNRmrZGQahjvnJLJy+PFfBXv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhHJqRqg/mwnLKqkeBM47PXD7Go9qd4yhdJtuXd6gYNofAu6PqsRFsriXEc1ULD1IEzccRWSJxH4Mac0ZdTcX/mqQJGOaa20V5bhRPnY0jjjHxU9W6lEA+7Wt0lbxsPp+M7a3SUEwdddXA7L6DhFTCJbP+jSnZBZ9ahRT2yDyOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLZcIQkT; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLZcIQkT"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so11984a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788969448; cv=none;
        d=google.com; s=arc-20260327;
        b=U8xzdNLCDRBRL7ncRgSqpDiJb7m4tLQTd4rgM1E7o+fAaSlw+jQvBSou8hmzD9j7PN
         3PFclFUQwqv9qb/UMK0Oq3rWvhtaW4Wb2H0BifZ0AizAIp1BC+qMDCYrEf2j3PltTUTR
         vHgd1EUBq6nlBmF3FScXBCN3sTfprPvI0qJXA/9fjDiI5mUEXsxGMCfOOZLi8V41LkHD
         lY6tqaZJ3f1MrcZGgKOUrKLLValaEsLlUBTeeutaXHsmvapJN9n8wSkRiKGidtOpamC0
         35II+WOydG3Xkwqwvpiaqe1YaLkgvxJD7/EXi9iRE9HocEctlngBUgTycc4nL7S1hJBQ
         pHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPenUjNr90vCpvqtVscoYErxAzuNB7Z9rok5+EIBTAk=;
        fh=2BKXseMacpCfb6eDGL45n0tOS5qqFwtpbp/INoGAEzc=;
        b=qI5NKHEfQGcKeNj6LQ7e35oVI7mz0LQm0PjydNhDB7IPYe9H4tBp3q0MT3Y3he8wbu
         CihEg6NJ6e2crzjEu/WnLCxZ/Z/G7d/LnGHrH9G7bWDlkbBZBdhNUOBH84pHIgzppyzq
         tmE5mIspufUqwOSaNraepUm3Lr+1ZMhkEYwRg3eFDfNecCgMTt5+rKHeZnD8ERH8oxUh
         Er8vdOnFDBY6K2W2O4mAqWT2vV//RFTepU8o64z20RlBJStFcHK6bVvgYIiM7sq1rTYb
         NGfLyCw8O+Ny4Izep9fCeQTufUQ7DUaEm3euBVlbCRrE8dJH2hACnfIgxhnVYvqv10m9
         3TcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788969448; x=1789574248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPenUjNr90vCpvqtVscoYErxAzuNB7Z9rok5+EIBTAk=;
        b=iLZcIQkTqezzbFE5LfdpXp5nLUWooriogd0b0FN7d5fA4cRxberYU3obdAJRhSlrVm
         gJhQ7k4dKvYv+Q1unXY6ibbUjhvJsB3/nF4nXdscw7XdoDQTqhlHodegg/ZEgX3jrfDT
         z0X6oUPFVYU9UQHBGGplTShVazQ3FXUGpY2WmvVigizlMe4C9vof5FzOrdoGEo31U2DA
         TcGp+v04uBSAFWWLM1UcEe7vWu6fhaLYWQgDufsM7iVGuclCjc1Fh//ZdSl9CtyrwhUQ
         HMaaMOgLeFI48svlE8+1Iv//l993Ph4mZRA8pARRjM6V7bbHTiOIoZILapGIPlID9DVQ
         CMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969448; x=1789574248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPenUjNr90vCpvqtVscoYErxAzuNB7Z9rok5+EIBTAk=;
        b=sMXkMPupW4wE92kHRu9yk98dYn3OcgTKCZkY+Zx19/IQcgg+8z7D8F1a7QQS72saln
         e4C5b+3JJ0HGfikk6/mQHT8F5VYFSq0fFeBMkTDDepDjvUQv3oVYpf9lRkPcfSqj+chJ
         PFZRBYvQWLBxWVgZVts+fkFZhM0VTG546JODPYzjtljiv6OQLJBnohhaEGc1s2mNlVF0
         oInQN2cGJlf5fktoOPXskIX7VatUe/mG6iNtAppreP9+sgNCKkwVGrso2011i3qIxdgI
         UvfgeU6VuBLUNve/xL9UWB3hs4uSv3jMTf90o58NzAEomc3fjF7SXYKv4gY6ABkV7Za/
         8M+w==
X-Forwarded-Encrypted: i=1; AKwUvBwPGmq1R40zM48xlJc1ueT0M3IoNAGiXL8vUhhCe1StW8mCllTu8Y6CBC9pc/TcZjF96vBtRec=@vger.kernel.org
X-Gm-Message-State: AFuF++nlqfci2p3l7BK1Hhc0lLRWLAbJixN7H7nmAo6UvSpItk8d4dgG
	K7Z8I1N5HGEOz1+SyLmdhikmI2EmDGl+1LasSrYrin4C9I2jvNCwC5puKfCzgPCohmtGTlHu7pU
	sdp4WHWLACbw5worC23xJS02riDiwhx1MVsjuZoCD
X-Gm-Gg: AYBFou0lf26WYKZR8xiUbbG5Y2m22y7akIuF6CSRH6bx/worei0vxjBI9iW+PdUS4by
	OoC/tFoc4MJCAnhW+hynD2xO8Zg/3B4twPLhRmAD200NHa6payJFmtEIZrDNxSyA+eY79MwSDIY
	VKdcmSf5aS7NOLKQxKFu+nyrMb2orxLR6kAQXrhoFtBEZxi9BjW2Dqnt0I/wUhRstEBQQad4D4U
	LtX15dXZTvhwthQlbICM+VpMwhgwGGE64Z43f4LICE7TABT2ievet9pKX6z4hon8088UqnHaPHA
	leGdcmuJeC2fRdX9Hx3jqKbzOp5qxW2Ukk2tDN5yk3EXzek3RHRfko5eD3l0wD4=
X-Received: by 2002:aa7:c1c6:0:b0:6a6:32f6:2841 with SMTP id
 4fb4d7f45d1cf-6a98e9ff984mr49301a12.14.1788969447656; Wed, 09 Sep 2026
 08:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence@gmail.com>
 <178896152268.219967.2387243409101048587@kernel.org>
In-Reply-To: <178896152268.219967.2387243409101048587@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Sep 2026 08:57:15 -0700
X-Gm-Features: AcwNN1UCQHB1TC-CbEYKtysaW3SqDUIjSQzs8F_d2RQ4jPNqBTOnZib3p0OR8DY
Message-ID: <CAHS8izMF+G38GorV01mxnvjMPGjPCDKJ1fFPiRNeK-thW0eB5w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] tcp: reject non zerocopy devmem tx
To: netdev-bot+sashiko@kernel.org
Cc: asml.silence@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:45=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [High] Incomplete enforcement: devmem TX can still reach a byte-copy
>   path that misinterprets dma-buf offsets as user virtual addresses.
>


Sorry, this slipped my inbox the first time around, but now I see the
Sashiko review.

> --
>
> tcp: reject non zerocopy devmem tx
>
> The patch replaces the MSG_ZEROCOPY/SOCK_ZEROCOPY test that guards devmem
> TX in tcp_sendmsg_locked() with a stricter check that requires the
> zero-copy path to actually be in use and the dmabuf binding to have been
> obtained.
>
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 1c867a3024446..562752352afe4 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1169,8 +1169,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
> >                       zc =3D MSG_SPLICE_PAGES;
> >       }
> >
> > -     if (!sockc_err && sockc.dmabuf_id &&
> > -         (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
> > +     if (!sockc_err && sockc.dmabuf_id && (zc !=3D MSG_ZEROCOPY || !bi=
nding)) {
> >               err =3D -EINVAL;
> >               goto out_err;
> >       }
>
> [Severity: High]
> Does this check still leave a devmem copy path reachable via TCP Fast
> Open?  Right after it, tcp_sendmsg_locked() does:
>
>         if (unlikely(flags & MSG_FASTOPEN ||
>                      inet_test_bit(DEFER_CONNECT, sk)) &&
>             !tp->repair) {
>                 err =3D tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, =
uarg);
>
> Neither tcp_sendmsg_fastopen() nor tcp_connect()->tcp_send_syn_data()
> gets the binding, and tcp_send_syn_data() copies straight out of the
> same iterator:
>
> net/ipv4/tcp_output.c:tcp_send_syn_data() {
>         ...
>         space =3D copy_page_from_iter(pfrag->page, pfrag->offset,
>                                     space, &fo->data->msg_iter);
>         ...
>         skb_fill_page_desc(syn_data, 0, pfrag->page,
>                            pfrag->offset, space);
>         ...
>         skb_zcopy_set(syn_data, fo->uarg, NULL);
> }
>
> For a devmem send the iovec entries are dma-buf offsets, not addresses:
>
> net/core/datagram.c:zerocopy_fill_skb_from_devmem() {
>         /* Devmem filling works by taking an IOVEC from the user where th=
e
>          * iov_addrs are interpreted as an offset in bytes into the dma-b=
uf to
>          * send from. We do not support other iter types.
>          */
> }
>
> So does copy_page_from_iter() here read whatever the caller happens to
> have mapped at the numeric value of those offsets, put it into a regular
> page frag, advance the iterator past the corresponding dma-buf range,
> and then report those bytes back through fo->copied -> copied_syn ->
> copied as if they had been sent?
>
> Is the path reachable without MSG_FASTOPEN as well?  tcp_v4_connect()
> runs sk_setup_caps(sk, &rt->dst) before tcp_fastopen_defer_connect(), so
> with TCP_FASTOPEN_CONNECT the socket has a dst and NETIF_F_SG in
> sk_route_caps while DEFER_CONNECT is still set.  A subsequent
> sendmsg(MSG_ZEROCOPY) carrying SCM_DEVMEM_DMABUF would then get
> zc =3D=3D MSG_ZEROCOPY and a valid binding from net_devmem_get_binding(),
> pass the new check, and land in tcp_send_syn_data().
>
> There also looks to be a second residual route through repair mode.  The
> tp->repair branch below reaches tcp_send_rcvq(), which copies from the
> same iterator with no binding awareness:
>
> net/ipv4/tcp_input.c:tcp_send_rcvq() {
>         ...
>         err =3D skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size)=
;
>         ...
> }
>
> That one needs CAP_NET_ADMIN, so it is less interesting, but it is still
> a devmem iterator being byte-copied.
>
> One more detail on the Fast Open case: msg_zerocopy_alloc() skips
> accounting for devmem uargs:
>
> net/core/skbuff.c:msg_zerocopy_alloc() {
>         ...
>         if (likely(!devmem) && mm_account_pinned_pages(&uarg->mmp, size))=
 {
>         ...
> }
>
> so attaching that uarg to a copied page frag in tcp_send_syn_data()
> would leave the frag unaccounted too.
>
> Would it make sense to also reject dmabuf_id together with
> MSG_FASTOPEN/DEFER_CONNECT and with repair-queue sends, or to teach
> those paths about the binding?  The commit message mentions neither, so
> it is hard to tell from the changelog whether these were considered,
> which also matters for backporting given the two Fixes: tags.
>

Yes, I think we'd need to exclude MSG_FASTOPEN and DEFER_CONNECT.
Those are set by the userspace right? So it doesn't matter much if we
don't support them with devmem. Not sure how to correctly exclude
repair-queue sends.

I guess it's pointing to more pre-existing issues :( But this patch on
its own is fine.

Reviewed-by: Mina Almasry <almasrymina@google.com>

I can try to follow up on the other prexisting issues.

--=20
Thanks,
Mina
