Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77633B4417
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680855; cv=pass; b=eVGUNfyaxhwtwDjKW8ppJTiebLua+IV+/CndQLtkWcByAU8s5nQO9Xxp1lrWtxIzVRucoiNM7RWF7FiFvAhlST83qvjd5R1s2Uiq3QvORZGrlEoTJjX9QV1VKn9LovvtX+XAjT33cbB0EZFhXG6whMeGIAC10+9BqcR96eU5I+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680855; c=relaxed/simple;
	bh=r8VLMTRbI75pl2dKd4Prmr6IGnRh0fQYjOhotmE+jEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiaJewvjQdGsEjdmEWsD46dqNncdBSTkmXoDOiEIjh9qIMge3mDVDdYtl3/aEx4zTmBnmpi2LSa85Af4YUiBEdi31IqTIFkTRiFOm2zU6oOto87kAvQZ4wevm1inicZXD8iNGJX6btKmkCbFfg5YYKF82KmKaJ0QxWlY4FzmV8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt/lMBrZ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt/lMBrZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1f758014b8so232227666b.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 07:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785680852; cv=none;
        d=google.com; s=arc-20260327;
        b=fRvrPDokH0tYZM6ObDBgjIfjcD/zFmOcR3JcS11T1pguATwRPOc7sBNPOHqi2PwiIv
         hIpTRHZYCiwEPXzxqBlIjHG3bRGXUR4MkoSdEHxq3Gd2Drb1YwkiG6fypOyvZHdrTXZ3
         Gi4xj3KCLztSrUdbW9+0SlmCoTr93PpoqyTIZSgzDTCO0NCgiO8vrc2sx/fHzyJg7GnQ
         m8OrqUsdTA3f1zUUcjhq3U4rntY6NlA52r5VYH0+Z71JpPaT2gtfI4+eDiTkOuzyFteJ
         wZ8lkb1554A4ltdeBABuK2xFZZfOseB+zu2hexCshvKf6l64L2n18MzLtEVmYj0sSP+B
         jbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lSq2UDfj6vsSz5eAwRE75vP/zu/pnQux1Om+ypqGzY=;
        fh=IkcAftLwNnwUf2snbEKf9DeEBaQ1k3CKbG5M4JxUVYg=;
        b=MtJ43Tx16DYM3ynEtAACNJeIQ7lGVj58vuKaTCS6Yjz65aZUtyUHCUEIRCkiGU8l+3
         /4sy8px+GU9NFnjgzdS7fkhanxOPSGAD38zMMkzX0/TuLDZ7BACkJAX7Dz7UxH4soI6C
         NTzY9pTrk6RfbHS+OSRA3vv7HZYAEIDZggnSKkEqrWlFCCveYPg4YPWmG4hOgeCs9o0q
         PQjg47PPjNb84ziw8nLy9mEdlWKSf7axEOpI0lQgLBHg4x2B1SoRNxXrc2OMfr6mDxHj
         i7d+5rKfWVoyQCihSMbKDG5MbXSCZBEBJ/S0QXMtbN8RUY74tpyqCSeqCH11D1zQ1mD3
         +i0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785680852; x=1786285652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/lSq2UDfj6vsSz5eAwRE75vP/zu/pnQux1Om+ypqGzY=;
        b=Kt/lMBrZENd/ExtPYifmPJxeex2Q/AKNm7y5RhkAKNlaU7SFH8Jg+5UOZGFH9PxPo5
         7HPOLhS/58o11JjfKaPCkNw+HvAVzGrbABmyw570tbFuOi6896Yb/wCuM+6BYJiBn1oW
         TiET5vsegmEw7KrBN4LygKADLRDICB5xCN4KX1I9KAPgL/pTaZ6gRCLBNBnfPyOhwEWD
         nI0V28iMH9B1jePPqNo+E3475638h5nyCX59Qt/O5u3ip05nsSmOKCEaSkTusZCxz1/W
         9R6OUUSk8QxjZ+pNkGwIpzuHGGlCmJ69mnrU8jggNtuUWqTUcrF5hf2hJNg6yaDPLI1L
         2EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785680852; x=1786285652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lSq2UDfj6vsSz5eAwRE75vP/zu/pnQux1Om+ypqGzY=;
        b=oFpg65DSAfKy1o9WWJZlai53yGMSL76R/KyZp7xJK93lYU/5FCAmeYFCsRzoosibVI
         QAcu5V3QSdCRRZmIrbpZOhyneFDs3ma4tC5rYSD1MDZ35qMcH5D+Y9JcRLS/CbqnHlc1
         hNTitcAdBCEoTPpuIMQPdYM7r4y2LhwYK2vGqb+A3GHxIGUSxFbGPJsJWfDTY7qZ5Fx/
         ZQdX022uo3BMaLXS7WHiCHEa4aOS7j70HPG4PWWI8KtmpXk0fLwW1LguvoyV1vmIkVqc
         XDVu7ohyqrTlGynRusxnIelP09z6kpxp542Du2ptoyOsi23oqcQrU8yYWxOoTYO2Mxk/
         ikwA==
X-Gm-Message-State: AOJu0Yz2WSlAxbO9rw/jmUMFc8Ri8v0KtV+p7j+RBE2PCxnJHLsYUtWx
	DXwDmmyoAOpQd+9JwWOzunLgXHQFtK81y9du376oaxNeC4RnpbCTut340lfX7Kf+hjv/ttOONga
	GqBK8v4tvYTYtZjCMab96qKxBOR3mon3LYRyjJUY=
X-Gm-Gg: AR+sD12pYSML4XHcUjwnD1LdoS2JKpjosBTyM2bcjgwelHIB4voy9vxwIyrhtCLcG0p
	jIapwhQH+OgFnuPYrxNeEYfOfMUSMaDdB64QJZIWX+Yxb9HrB51TULsFyEtzo6gNtmALRUU8jq7
	z2mwJn4FurrVWFr/LDKXkCLW5pQTqTmpWzl9riUPivCYqMQE5bTvCWgCHqYObtWWqcEY5GMxqOY
	Y/1Op3ysw+k7gMXcIFDLavTjudyAd/6z/Rt5+OduvLqGohJArRdtOkqke8ZAj15QLkeQIIuaulo
	ly/5d8oBYrKRVMLc+w5x9FrgOE/04gsUEGZnvryBFZfGMQO+Otz2QUr2G+aTZiK7r2DxVZJFkrQ
	8uKKH+K34bkUnf6illecyy8LcHe6z
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id
 a640c23a62f3a-c1fe7eebb0amr555251666b.2.1785680851561; Sun, 02 Aug 2026
 07:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADqcGBkVewfYCirbeusDW1xbs+mFs9ditaBX7KzG6NcM=xpm9w@mail.gmail.com>
 <CAAVpQUD84dLmEdXuZf0fNvskHGH=Wb+6f0nRmBY58xnB2xWWMg@mail.gmail.com>
In-Reply-To: <CAAVpQUD84dLmEdXuZf0fNvskHGH=Wb+6f0nRmBY58xnB2xWWMg@mail.gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Sun, 2 Aug 2026 19:27:18 +0500
X-Gm-Features: AUfX_mxOSGq8XHS9RZdD0UV6fwffJYtsJv8hw6tsqpWZy7gkZLBbVQ-8hcZC-Y4
Message-ID: <CADqcGBmN63TEqOC05dXgcve9+PXE-XQCLtdiNsVDOb3zEyY=cg@mail.gmail.com>
Subject: Re: [PATCH v1] af_unix: fix use-after-free in unix_stream_recv_urg()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2026 Kuniyuki Iwashima <kuniyu@google.com> wrote:
> How can close() be called for struct file while recv() is still being
> called for it ?
>
> Did you trigger the real UAF or is this AI hallucination ?
>
> If former, please provide the repro and the KASAN splat.

You're right, no splat. I didn't verify the interleaving was
actually reachable before sending this.

recv_urg(), manage_oob(), and read_skb() all take u->iolock, so they
can't race each other. The only unlocked writer is
unix_release_sock(), which only runs on the file's final release,
and a thread inside recvmsg() holds an active reference via
fdget()/fdput() for the whole syscall, so that can't happen
concurrently with a recv in flight on the same file.

Also ran an oversubscribed stress test against this exact scenario
on 7.2.0-rc5+ with generic KASAN enabled, closing the real fd against
a thread blocked in recv(MSG_OOB). No hit across two runs.

Withdrawing this patch. Sorry for the noise.

Muhammad Bilal

On Thu, Jul 30, 2026 at 11:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Tue, Jul 28, 2026 at 6:21=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.=
com> wrote:
> >
> > unix_stream_recv_urg() reads out-of-band (MSG_OOB) data from
> > unix_sk(sk)->oob_skb.
> > It saves a pointer to oob_skb under sk_receive_queue.lock and state_loc=
k,
> > and then drops both locks before invoking state->recv_actor(oob_skb, ..=
.)
> > and incrementing UNIXCB(oob_skb).consumed.
> >
> > Prior to commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB sk=
b."),
> > the OOB sk_buff held an additional reference count. When that extra ref=
count
> > was removed, oob_skb became a bare pointer into the socket's receive qu=
eue
> > without any lifetime protection once the receive queue lock is released=
.
> >
> > Because unix_release_sock() does not acquire u->iolock during socket cl=
ose,
> > a concurrent close() on the socket races with unix_stream_recv_urg() as=
 follows:
>
> How can close() be called for struct file while recv() is still being
> called for it ?
>
> Did you trigger the real UAF or is this AI hallucination ?
>
> If former, please provide the repro and the KASAN splat.
>
>
> >
> >   Thread A (recvmsg MSG_OOB)            Thread B (close)
> >   --------------------------            ----------------
> >   Acquires iolock & queue lock
> >   Saves oob_skb =3D u->oob_skb
> >   Drops queue lock & state lock
> >                                         Acquires state_lock, sets TCP_C=
LOSE
> >                                         Sets u->oob_skb =3D NULL (lockl=
essly)
> >                                         skb_dequeue() & kfree_skb()
> > frees oob_skb
> >   recv_actor(oob_skb, ...) -> UAF read
> >   UNIXCB(oob_skb).consumed++ -> UAF write
> >
> > Additionally, unix_release_sock() cleared u->oob_skb with a lockless pl=
ain
> > assignment. This creates a KCSAN-visible data race against READ_ONCE(u-=
>oob_skb)
> > in manage_oob() and unix_stream_poll(), both of which rely on all
> > writers updating
> > u->oob_skb with WRITE_ONCE() under sk_receive_queue.lock.
> >
> > Fix the use-after-free by taking an explicit reference via skb_get(oob_=
skb)
> > while holding sk_receive_queue.lock in unix_stream_recv_urg(), and rele=
asing it
> > with consume_skb(oob_skb) after the data copy and consumed counter
> > update complete.
> > This guarantees the sk_buff remains valid even if a concurrent close() =
dequeues
> > and drops the queue's reference.
> >
> > Fix the data race in unix_release_sock() by wrapping the u->oob_skb cle=
ar in
> > sk_receive_queue.lock and using WRITE_ONCE(), matching the locking cont=
ract used
> > by all other oob_skb update paths in af_unix.c.
> >
> > Found by code review of AF_UNIX OOB lifetime management after commit
> > 8594d9b85c07,
> > and verified with a clean build.
> >
> > Fixes: 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB skb.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> > ---
> >  net/unix/af_unix.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index f7a9d55eee8a..011ea88d57c2 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -689,7 +689,9 @@ static void unix_release_sock(struct sock *sk, int =
embrion)
> >         unix_state_unlock(sk);
> >
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > -       u->oob_skb =3D NULL;
> > +       spin_lock(&sk->sk_receive_queue.lock);
> > +       WRITE_ONCE(u->oob_skb, NULL);
> > +       spin_unlock(&sk->sk_receive_queue.lock);
> >  #endif
> >
> >         wake_up_interruptible_all(&u->peer_wait);
> > @@ -2773,6 +2775,7 @@ static int unix_stream_recv_urg(struct
> > unix_stream_read_state *state)
> >         }
> >
> >         oob_skb =3D u->oob_skb;
> > +       skb_get(oob_skb);
> >
> >         if (!(state->flags & MSG_PEEK)) {
> >                 WRITE_ONCE(u->oob_skb, NULL);
> > @@ -2793,6 +2796,8 @@ static int unix_stream_recv_urg(struct
> > unix_stream_read_state *state)
> >         if (!(state->flags & MSG_PEEK))
> >                 UNIXCB(oob_skb).consumed +=3D 1;
> >
> > +       consume_skb(oob_skb);
> > +
> >         mutex_unlock(&u->iolock);
> >
> >         consume_skb(read_skb);
> > --
> > 2.55.0
