Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E15390CB8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633667; cv=pass; b=hpeHE+KT6jTxj5lBOoNxbCtx37vigbv1ePKUiB5EjZMfrSGBhh6N1RZUm6eOow/UY9WlbbC0dMYyqymJHPSTAzx0AB7IuWq0HjRAgnzy81RVtJ4SonRMDFbtvnr6VZ3/ec2U6za7ivfTWxs3vVtE7eJkVtejJ4fyg+MRsYtn9Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633667; c=relaxed/simple;
	bh=9422MSPGl/YMq3BPG9hoX8njXhoziJUfqL8beA71Xm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gx1zsUpgH1gMkrWNtAJkBxsxQroRtlTsLCV24brwODqCarzKJXqiXjkT3dG2aEVrtVMXl2JlYPBz2TvxaN40st0tFjT8ZjQKo3a84kBvEAdBPxEM01W+WmJIa+a1c6Oq19vDbIA599mtHrRc6cw/1W9xRCxOGfi2JgztZ8otBrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwSB7Jv8; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwSB7Jv8"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d0ad9b89so4639621fa.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789633654; cv=none;
        d=google.com; s=arc-20260327;
        b=QGLCcvoSjqSmDTJ/YJ/Er2YSjG5bojIu+HK4ULdAVF0a3nm1A9bHGu08N8DSINgT2/
         npHiGCL/7A/kxegGhR+9ZEcxNlXrpBuxx4EbBu8Ny8PD5qM218liI+VAf2BJ+ysws2Qo
         dKDAcNqaNaEsdIc1i/lbmgx9mJbXaUBsamoN6F3byEiqgmkvS5MCBdddu2JB/4BEor0U
         XTTa6kVEqtLmjTuWprRYxz/nY7oLJQ1bJl7CpgBnyhroRSQc7yZZzzKdHId92VIazsXt
         yVJxCtGKynLVcSPhad3gOHORKmZsgr+GKC95Svs4tmOf5X7NQZ9x3MY5AsMFgABGMnDY
         K6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9422MSPGl/YMq3BPG9hoX8njXhoziJUfqL8beA71Xm4=;
        fh=ewvRX+FqjQj/Nq1DB99HgTRxf+zLfGTdEgPvaw4NPA0=;
        b=qzUoXDQj8nySnNh4nyVH3aFIeh4HhvHiI6E8KK2qJaanQI/snd7c/IdpuvrZ4OmWi4
         GhDyD+v2EqDFCCDfxij34QPKFA8OAcjjWcQAbwrAWAr+Ao8eBZhRDbCchgir1oYbZwm/
         8ZXb+5ZzJYfmKliTOceCMAlpZU4p1ELf16/c2RXYfQrciCWE6V4ohWppi0np/hTOovRx
         VprCEcELuk2/V0e344Pgdnhd5sErAr6bcBwYM/+QH8z2y09kZsu75Ah6wYLbgqyrPKuE
         os8gCijspzG8xIR6/laK3EYFvaiJp45OhURHnDBHvnm5K9A3BICBT0ZR8i701p3wKgY1
         GE1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789633654; x=1790238454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9422MSPGl/YMq3BPG9hoX8njXhoziJUfqL8beA71Xm4=;
        b=ZwSB7Jv8IAi2hymmxUgON61rF6UaSVVWvsxIEID7ZC5zwUy0D10/9fqiO9WicY+nh5
         6lUcbwc5ul0SeqSqp/KxrAELLmlJ6UfQn0PqD6WhLLMXW/rJhrzJvHPG9WLZ3mT09Ixw
         iirHFIQ00/ukvRhXGDQdKhd52ctFOD0HiCjTun5O+hefDTE2ijvqCK/dqtgIKpVMNsmh
         kk/303KEgQmWQUGx9VD2uf7ZONdUsSFzRGXII17e+IthKSNDHITiy4Wz/ETTiqxEwSCh
         mqy0hPDEWd4j8OlZFoOc0ubbIAIQydpHq7kRwLWaw/PmAkP7XRgEpoTo4jb+8f3bEEmJ
         x4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633654; x=1790238454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9422MSPGl/YMq3BPG9hoX8njXhoziJUfqL8beA71Xm4=;
        b=Bvzs5TERed9cOVep3nnDeCAw72e+329Nn0t2smIr/oSY3aUaBu5pzburViV3yWVMSK
         GiH8fkJd4c0/iGpf3gd8jy/xhX9P4dmipclp989RnM5mDxnsH4sMgpWIDONmokDZOh59
         anBZ+K4xxU/HwDGajIcJNckhSkig4k4J6GQsbzJJJ+nQSBurl3IghGzg2BgcLfshEh/E
         LGzWflluXWv17wSpSAYbqh/ZXiEa5+6A0IA74gt2YmNSbK88JGHWeHBu0DHvTRuOCV0A
         PR3AtkVzNQjlQB1iPeRoYHULuxHQyVoKWI66Nz6SVX0o3GiEEVLeAqebekbMgvZ6dzIQ
         0DCA==
X-Forwarded-Encrypted: i=1; AKwUvBxEJf74oehse9WW2r+oiw6sSeRiYcs1cFZcaahoo5NtgPmdUZNBnj+atpHfr3WyEU+k9pt5Yo4=@vger.kernel.org
X-Gm-Message-State: AFuF++mqRsjwOmEiQTSGCKanoyd60tItxzFRSG/7SVBvkD4nFxMkue7D
	ZhSgsIihZhz3eWs/JxwI258jwzYXhwon9vlU37O002KiGc9Tof2iWvRFAfbUPUqF8b5hujD2Yp1
	g1Vx6FaQ9XWFVOzZZfEildfCbnMlfk0E=
X-Gm-Gg: AYBFou1xjYlBECm1C91aO4jcTkYnC+MhotiKg+cd0enyzHg8yCjyJdIUJD9dUaQMMiP
	uhmVHRMqkUfMfsaloJC8TQb6iNiSHRIfJHCuZF8K/MkRpSWKx8m0+zh41DOd7hHteU+lv4sXoXN
	y//fFlx32/XQxJZIOqcMXFDu48/s3Nh3wKy2A3o6RL1Z+K22Zjg642duoiEariPLXXh5cuvwAMt
	vqFFsb2k/AVBd8sv+D03M7rHbiuvhBAyvs5bbEWk07SHwjHS5gjAyQBYgiHzhaVC4On5fdo5Eou
	fGabbUGESj6PQh5GMXvIHTDzsETx8vPdGUxg1G4dUkQjn3fWYI+/CMk3I4JZPRVuIkkmEZRb24M
	JSd5ufpQJiuaigruG7WFZcpnzdOSKomz6BCNnUREJJWZ2jVyui4w18yhSBit68lSUtDeXHsRqrd
	s/xvZ+
X-Received: by 2002:a2e:a595:0:b0:3a3:74b9:8a7d with SMTP id
 38308e7fff4ca-3a5dca03df0mr9788741fa.22.1789633653424; Thu, 17 Sep 2026
 01:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915214450.2882680-1-dw@davidwei.uk> <CANn89iLkkiXvjWzH=_iGNV-_n8aAUSiCVuwy1VPYb6BKZO-rew@mail.gmail.com>
 <5eaa3be7-1615-4f8b-81e1-449db0e986ef@davidwei.uk> <CANn89i+f47sHVMtxF5dJwc-RKZbpquJkH=9x09cUCsWMW5XOug@mail.gmail.com>
In-Reply-To: <CANn89i+f47sHVMtxF5dJwc-RKZbpquJkH=9x09cUCsWMW5XOug@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Sep 2026 16:26:55 +0800
X-Gm-Features: AcwNN1XncOMKO3AMmxLawb0xrMVTemdJw60FI52pp4073FkiT9HO5Eg2hODzlzU
Message-ID: <CAL+tcoDMR87sxJftp7T0JX-+NUz8VkXU67M3oNZy8Tk88sDPOA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: initialize skb tx timestamp key before cloning
To: Eric Dumazet <edumazet@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 16, 2026 at 10:23=E2=80=AFAM David Wei <dw@davidwei.uk> wrote=
:
> >
> > On 2026-09-15 15:21, Eric Dumazet wrote:
> > > On Tue, Sep 15, 2026 at 2:44=E2=80=AFPM David Wei <dw@davidwei.uk> wr=
ote:
> > >>
> > >> tcp_tx_timestamp() can select skbs from the rtx queue when all the
> > >> copied data has been sent in tcp_sendmsg_locked(). These skbs may be
> > >> already cloned, sharing the same shinfo, and handed off into the low=
er
> > >> tx layers.
> > >>
> > >> tcp_tx_timestamp() sets tx_flags before setting skb tskey, racing wi=
th
> > >> any reader of both. It is possible to observe a valid tx_flag, but a=
n
> > >> uninitialized tskey, which produces a large underflow after subtract=
ing
> > >> the socket tskey.
> > >>
> > >> Initialize skb tskey just before cloning while its shinfo is still
> > >> private. In tcp_tx_timestamp(), if it selects a cloned skb from the =
rtx
> > >> queue from the current tcp_sendmsg_locked() call (i.e. tx_flags and
> > >> txstamp_ack are 0) and the pre-init skb tskey matches, then tx_flags=
 can
> > >> be set safely.
> > >>
> > >> If the skb is not shared, coming from the write queue, then both tsk=
ey
> > >> and tx_flags are set, as before.
> > >>
> > >> Fixes: 838eb9687691 ("tcp: tcp_tx_timestamp() must look at the rtx q=
ueue")
> > >> Assisted-by: LLM
> > >> Signed-off-by: David Wei <dw@davidwei.uk>

The commit 838eb9687691 is a best-effort attempt because it's likely
to miss reporting qdisc/driver timestamps. Everything is caused by
failing to accurately spot the last portion of each send syscall.
Things like this (when memory is under pressure) happen.

> > >
> > > pw-bot: cr
> > >
> > > Sorry, this patch significantly hurts TCP performance and has many bu=
gs.
> > >
> > > I am sure your LLM can find a cheaper solution if you ask it to try h=
arder.
> >
> > This wasn't a yolo patch straight from an LLM, I tried quite hard to
> > reason with the bug and possible solutions. Maybe that's the problem -
> > the LLM is actually smarter than me :)
> >
> > >
> > > Some hints if needed:
> > >
> > > First idea:
> > >
> > > 1) In tcp_tx_timestamp():
> > >
> > > Keep shinfo / tcb accesses inside if (unlikely(tsflags)) so normal
> > > traffic pays zero cost.
> > > When falling back to skb =3D skb_rb_last(&sk->tcp_rtx_queue):
> > > Verify TCP_SKB_CB(skb)->end_seq =3D=3D tp->write_seq and
> > > !tcp_has_tx_tstamp(skb). If either fails, do not touch skb.
> > > Always write shinfo->tskey before sock_tx_timestamp(sk, sockc,
> > > &shinfo->tx_flags) (and do the same in
> > > bpf_sock_ops_enable_tx_tstamp()).
> > > If pre-initializing shinfo->tskey in __tcp_transmit_skb() before
> > > skb_clone(oskb, gfp_mask) (which already dirties shinfo->dataref in
> > > the same cache line), guard it with !tcp_has_tx_tstamp(oskb) and use
> > > TCP_SKB_CB(oskb)->end_seq - 1 (or seq + len - 1), without the bogus i=
f
> > > (shinfo->tskey !=3D tskey) check in tcp_tx_timestamp().

It minimizes the scope of handling this case without hurting normal
traffic performance. Indeed.

> > >
> > > 2) In tcp_sendmsg_locked() (to preserve TX_SCHED / TX_SOFTWARE /
> > > TX_HARDWARE on non-blocking partial sends):
> > >
> > > Before calling tcp_push_one() / __tcp_push_pending_frames() at the en=
d
> > > of the loop (when skb->len >=3D size_goal), check if
> > > (!sk_stream_memory_free(sk)) goto wait_for_space;.
> > > At wait_for_space:, only call tcp_push() if timeo !=3D 0 (since when
> > > !timeo, sk_stream_wait_memory() immediately returns -EAGAIN and out:
> > > will run tcp_tx_timestamp() before tcp_push()).

The minor flaw of net timestamping is just the case where
wait_for_space and do_error conditions are met. Moving
sk_stream_wait_memory ahead of tcp_push is probably a good idea to
detect if this time the skb happens to be the last one. But it only
covers the non-blocking scenario, right?

> > >
> > > Second idea:
> > >
> > > We can solve this cleanly and minimally by:
> > >
> > > Reordering the writes in tcp_tx_timestamp() (and
> > > bpf_sock_ops_enable_tx_tstamp()) so shinfo->tskey is written first vi=
a
> > > WRITE_ONCE(), followed by publishing shinfo->tx_flags via
> > > smp_store_release() in __sock_tx_timestamp().

It takes care of all the readers and writers tx_flags. I'm not sure if
adding the pairs here is worth it. Admittedly it's cleaner and easy to
understand.

No offense, Eric, I'm wondering if we need to revert the commit
838eb9687691 or just let the bad case happen silently, which both are
actually a best effort. If so, the users indeed lose one timestamp
record for that send syscall, but fortunately, the bad latency will
soon be reflected on the next send syscall. I think this is how we
discussed it at Netconf a few months ago? I'm not so sure if we need
to add too much code just to work around the minor flaw of net
timestamping feature.

Thanks,
Jason

> >
> > I did think about this solution. I still don't fully grasp the memory
> > model and how READ/WRITE_ONCE and acquire-release works, so I wasn't
> > entirely sure if it was sufficient.
> >
> > There could be situations where the skb is pushed early, and the lower
> > layers copy the shinfo e.g. GSO and COW. I don't have experience with
> > this code, so I find it hard to evaluate plausible paths that LLMs
> > suggest.
> >
> > That's why I opted for the pre-set tskey before clone approach in this
> > RFC. I didn't think this would affect perf that badly, but yeah it is a
> > really hot function.
> >
> > I believe I can make the GSO path work with acquire-release. For COW, d=
o
> > you think it is actually relevant?
>
> I am traveling today back to France, I will answer to your email in
> ~24 hours or so.
>
> Thanks.
