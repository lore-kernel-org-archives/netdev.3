Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6754B1CA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082847; cv=pass; b=cTND/DBZB7iQZ0nErfMmjhOT0pbt1H8/XdzcSlwul2b2SLYcUJy6NHi/bpaM58nsKQA5bo7IMMpM8dd7/bcY1jZkrTRvQkAMxCPEbyrCNCFV8VVynofaAOZ5rCXZwa5Ipn86N4/UXU13kw2x4V2YoVMg0SFBDpa7pZlMurF5JOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082847; c=relaxed/simple;
	bh=H8mYDxezL3zeNOcyBRY8j7tO17JD8uUtMkU+mIQ++QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsednojY7YmD8RUt8mHD0BjxMJgNKwvIjO7ZTG421PpiVBuLKi3KaBaHiTjsoA4m+CVyMYpmsq3eiPQChLmiGOrLG4Stv8YFNOqkNbFsp8Yo0EFVYyU0OFYHGvE6g3gqf2XGbwq34TYcBsj/YY6ctAJa/xo3tUGgIlQ8SAjg5ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgQM+aig; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+j73cdm; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgQM+aig";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+j73cdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790082843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
	b=bgQM+aigeLYdXtATCxXZ66NKZtzZyLQff7UhW3N8q9+aDjP/yXjW/ED/v5uPj5yM+5TCF2
	pqTmwrXc0tt3/wt9kS/u3CINzaLBHvn7JdghTvRSAC8R0T06rAPfFJGZtlhqQp3E0Cv5+i
	CuYjeY8ilI4Bg/Ng5HCdbExTAXITjtU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Hm3o13StP_CjHFME8ZGEKw-1; Tue, 22 Sep 2026 09:14:02 -0400
X-MC-Unique: Hm3o13StP_CjHFME8ZGEKw-1
X-Mimecast-MFC-AGG-ID: Hm3o13StP_CjHFME8ZGEKw_1790082841
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39d93d95a21so32908901fa.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790082841; cv=none;
        d=google.com; s=arc-20260327;
        b=H9eLA35HUI/SXvDc/uQ377dUzhEm3HDDRDhpG3E3UnBIji59diXsBcNtoY5O26MksT
         ycGEBSYjjbZTHRP+uUZOa20B3UxruaAe7Vxer+xx1Z345zDbRYXoSly4fmpnlogbW6n1
         rZY8NekqtF7AkjWVnHrPYBC94i7IVxq6f8F2v7DmTvFM8ijsod1+XDzXA+BAonhQgnig
         C2MVTgPX6IoGnwcFjtjlWWHiLoAaIlvSyhEeOvKkUF4IMr/A25nwFuHB/JF7QFpsFD26
         Iv7Yk9ZSzuH7LclUU73nJUKErFF2RlBAnjCH3UZR4ilsv5Rh3HlkJ5nylvF8zsuscR0S
         RP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        fh=2QXDWVgUCtUjkZ5A/zHcECWcjb+Qm0mHPBHSKXfFWQw=;
        b=KMwCUXq21AcuBswYeFbItPwq5zfzijPFLTPUolcRWw7V4jwZGSeLzvn+JZA9eho3FD
         +GGbO/7Smsdn1B5hCw6HzMalxYiaydu1uLyaoRBkARSEje4u5n8maPgtZHxfFz9DusQg
         idWVjmkD9uXFKR5YTyewbGor7Fk4Kp7rYCKpMsw1ykgkTUF5SB3IVtrBX6k8WmNvd9Ul
         QVDh0VTkMXV4Uo21+AJIwAugOPT92EG7kiVHjQRCtoaIGP9k1FsrUFpMG4TYSTDUgUA0
         lwrwJ7K0dMgXtSLMddrEUF51kUCDTRnCX/cNxTPMBvThp4ry1DMSImoKNLiJWuk4sLcO
         CK2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790082841; x=1790687641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        b=P+j73cdmbz8jEAkEjFJ2iSf5ORsf0Io+x9Vjl+WICjME11rcXdETXdlkwM3wS4bFyw
         MPlP2nKCF5DOsys1h7XSlSp38ttbB31hTSpHIhMBWs8b94kkqIzLTTf8xtoaHXOH0b6S
         K21vswoOvbEyMkViWtNVveHFB4LZFMUE31kNqAw+poNKiPJx4pQmQWXAiy0rOAt80nE7
         Io6zk0ivNhDPo80oqBsikt4P6UoZtDKT99VQbdl7vUyHMeW4tBGueAEEyFdtrGRuEQf6
         c/dU1wjfBYe4UnNTH/dNA/J4LWZOY8+fZO801D1G7+SRHgpy0lsW8CKS57dNFbxUthBW
         HqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082841; x=1790687641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwTfpD/qGiXwMKgdLNdLdxigBjWDGioNSbd9xxXMy9o=;
        b=yHIAAg9vIclzpUyZWgpcdIfBdwcNgMONPb9fxaPapTTdcvPzitWDgL/MBU5AkwtkQ0
         gPekW+IPg4ujBcKjGAJ2MzMwumwQFJohBswHiknyuE1Xj2j3dRlZ166pv/oyBz9ywAob
         NrxLs7WNQFEocc2pPCUGvEU71f03wADJhGU9UcpreS86MYGblQ+RR8OfBghi+nY2BCel
         dpZ+8bgrc4zSiCQIQi4BXLz66HPU11HnOISEbL3LNkuE+Ak6IDbT3xTH+JMuJZ9gI0b6
         /9PERcBHorZdcnjHlEC9Qi9k0r03/wCBSl+9DJpFRvLKHjsD9BVtupgvUPYX8MZXkGLl
         pX+A==
X-Forwarded-Encrypted: i=1; AKwUvBxTk7Jse4nk1gwtpzbBIM3U1d5MQNHzkP5CJd0YdwWQzXm/+jrwUo4DkIf6sNgLNzo/c/wqMRk=@vger.kernel.org
X-Gm-Message-State: AFuF++kXHLCxuPH+phk7tvGwjxFP/xlnzYBPp3iuExng8yp9xSfWIGqZ
	qcslzbHPdSKE579eM0zkx5ZFYzvIo56ZTiZilP8A/UKxBWw0cVhhuzhgAiqihHaZ4AuBWmayRjM
	hE2FRTas1N9VFOVsyH5+BzKCzSkStkOO4k7jstGX1NPcUOPTKzkbnmEM5GIHZdV2AMKTSClBxg5
	ZE6JCF5A4X+xZCEzj8whtXw01+iXVyVmQX
X-Gm-Gg: AYBFou37K1/2G19XYrOrJ7tY5vG/oMEt4qPyvCi/VnUwLqhjKSNu0NKwHwuEiaiHcVH
	Absx5fZ0VD95HB5IhbU1Zlv9gn4gkHwVCV3Ba+Gl9QCFlpXHrwzxJ8CTvxMAapuZ0p//GppDKMW
	3YKuCMViT+Qii2eRngpS/4o7YSIIbeqkVXkgSU6Lsz9eZmsA8IRZYxIWwR
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id 38308e7fff4ca-3a5fc0a8e42mr30269661fa.22.1790082841032;
        Tue, 22 Sep 2026 06:14:01 -0700 (PDT)
X-Received: by 2002:a05:651c:199f:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a5fc0a8e42mr30269581fa.22.1790082840630; Tue, 22 Sep 2026
 06:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914164400.2738350-1-edumazet@google.com> <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
In-Reply-To: <CANn89i+HYuqNO_ifR7XgpZO89r9ZRWk8MOVzezmDff5KfLMp7g@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 22 Sep 2026 09:13:49 -0400
X-Gm-Features: AcwNN1UAobSneypZDRm5AEaXEmdxsqqxBxlScBCWnvk4mCfcbmcf4C0NVj22bjQ
Message-ID: <CAK-6q+hc2+7x1+WuqZtj7e8C9Vx3aL0DOyA7RA1G3ADqpoBJJQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	gfs2@lists.linux.dev, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 21, 2026 at 9:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 14, 2026 at 6:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> > but this bit has not been stored there for ten years.
> >
> > Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> > SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> > commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> > the bit from socket->flags to the RCU protected socket_wq->flags, where
> > it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> > only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> > sockets, which never have SOCK_FASYNC set, and never sets the bit
> > itself, so the test in send_to_sock() has been false ever since.
> >
> > The consequence is that when sock_sendmsg() returns -EAGAIN because the
> > socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> > increment sk_write_pending, and does not return DLM_IO_END to wait for
> > lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> > process_send_sockets() immediately requeues the send work.  A connectio=
n
> > to a peer that is slow to drain thus keeps cycling through
> > sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> > reports that space is available again.
> >
> > Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags=
,
> > that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffe=
r
> > space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> > lowcomms_write_space() already clears.  This restores the semantics dlm
> > had before the bit moved.
> >
> > Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> > lowcomms_write_space(), for the same reason.
> >
> > SCTP connections are deliberately left as they are.  SCTP does not set
> > SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() end=
s
> > up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> > lowcomms_write_space() is thus never invoked for an SCTP connection, an=
d
> > the test added here stays false, so send_to_sock() keeps returning
> > DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> > returning DLM_IO_END would wait for a callback that never comes.
> >
> > Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  fs/dlm/lowcomms.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 2aff1c7c17de..abe9ae4c643f 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -522,10 +522,8 @@ static void lowcomms_write_space(struct sock *sk)
> >         clear_bit(SOCK_NOSPACE, &con->sock->flags);
> >
> >         spin_lock_bh(&con->writequeue_lock);
> > -       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
> > +       if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
> >                 con->sock->sk->sk_write_pending--;
> > -               clear_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags);
> > -       }
> >
> >         lowcomms_queue_swork(con);
> >         spin_unlock_bh(&con->writequeue_lock);
> > @@ -1391,7 +1389,7 @@ static int send_to_sock(struct connection *con)
> >         if (ret =3D=3D -EAGAIN || ret =3D=3D 0) {
> >                 lock_sock(con->sock->sk);
> >                 spin_lock_bh(&con->writequeue_lock);
> > -               if (test_bit(SOCKWQ_ASYNC_NOSPACE, &con->sock->flags) &=
&
> > +               if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
> >                     !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
> >                         /* Notify TCP that we're limited by the
> >                          * application window size.
> > --
> > 2.55.0.1007.g17ff1f9808-goog
> >
>
> Gentle ping ?
>
> I have an ongoing series for net-next removing one cache line miss in
> TCP sendmsg() and ACK processing,
> blocked by this patch.
>
> If you prefer, I can insert this patch into my net-next series.

I acked the patch in your patch series.

Again thanks for looking into that!

- Alex

