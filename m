Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609073;
	b=XAXwYm5A5ekW08ZLqZdsLWS6T84D5j+YVXjyeZvYOgMg04JV5rsAbwNQfLFJ0odCvXds
	 ACtM7IhGa5PoWhB5KSdSMX+ugkI5B25QEzm6/2gbdfTfKSMoPc0LRvkQvYrCzFdWOG9C/
	 ntGDqbyoPRiLEAF/7VMJJIDZtyoSBUAuXQ8PaRSpa2FrMFSojDHbrDccusNecAsea8adK
	 T8PE3q5di2qtjrpzcZz5D3J/8nrULbw9+9DOnTxz/QiK3TZcqa8RE6FSLCNHS/7mE5G/A
	 HKlvh8QHybIMqCZ7kV3bS3ZMW2bQhXJqggmE399NtpqZreBSi5aFwTdE6FOMeOcRhMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
	b=aIGX/saMNAb+D89QnxCRbFuzAd5FjVq5fpVbQ/GX4mFzNTbqjsW55HMdu+Wm5rPWA9rf
	 zReWyeo5g5CSnQwp/oJN+K2AVXp63pgsW0my+jZ/Ab5BAn4T+oM/0eNuwj3GlUAHh4Ef3
	 3+f1xlZqaq8DGtLmmzGL1jlxudMxEKyNMWkjyKXgaBAceBKb6rE6rjXznBXATpJDjmq5l
	 gvgvPA4PsURuveNOn5mfyHk4CAyhHBm5DbZ4B/y+LrPnBQ5TRpdh7qM/zxCPOK/iiZAdw
	 LRRmuQqx+FYEbRsKYq+Et7mhPK+PoSVH5GSMcP0jkNULFBzLM296h9SSpJWWS8aQqeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GRJOcBba;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102B606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5102B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GRJOcBba
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab98332238so819775a91.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609072; cv=none;
        d=google.com; s=arc-20260327;
        b=VXchpV3FqRLQf2sAAHwgvewgP/fRgw3v6Kyt48KdbI9uSvd+UksA11eQ23wUlII7Nn
         Gnc4g4AIQjQ54QmYzdaq5O6ugE3ozSoIXRhepEr0ZDghutQLbGttX/5R/6hKKSHjARgn
         rZNRNLUpTX9gJ/uiT/ogMOtfJYDZE9UyyxPTJExUo8u6gm/KRMG3ij98f95UO/P7Yz3Z
         tNftqgdZ3UBJRgnAHgoJaZVNkjLWbgwP3H+R1jOJ75ateJtDEYiU8FhLWXtQvF54ZBve
         jaUZ4rhiCRKn05lNhi3jCtatPz0v127n85a6rllS/HdsICe46oTRsQU26pZCr1L5p/GV
         dxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
        fh=mitkmBdjX/EBET7KXmfYcLs4lHhNsA6l31B4VwpfOFQ=;
        b=NjWLF0l3pVIEmDcHx5XiImuSNEW46xZPcPYn2MmMZQE0QdcO/tmnk9PTB2rV5mk2tw
         Ap7BQg6xcPbMYDGhP9h9Lplbr4M8sKRhNU3QOpOL0BTrgKpE+zIYz+q4O0vuetDDrPIi
         8oHxceVZgLop2EyuT1POicwVrdePzJMYwC5KhS2wa3Jk2WKrmXKt9QartODpEIF9Vorx
         VdL+6+0RusgpHmymApjAUMl/bWf/H6IpVOTVbo9wsVzcglLn3dyoVPbBfFrid/shElS6
         8UlZvnjONC+pw9GOeKQj5ouA8n1nStHpbMqQ4MYgJc6Z+MeEPcCW4pob94cOrIrOduCn
         9Lvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609072; x=1793213872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
        b=GRJOcBba8DEJiP4LcvBvI/lWgshwPX1y+sf60QRIqix2s5+eLDRL3csGLAyNFsOvWL
         nB1ccO0SJ+HnQCez2D5o4GpAXs4BOndSs90piRyAha75ce8OZw0PaHnKp4fPErDvBAl4
         NUSDw8och9V4kJEWRTTZreJAcH2/KVrCbRyqle6WFe6oNyGPrf7SevD1WglWcOnHw3la
         tCLnDSfyX+HFzqQMaqZNazHIG0VbLxOaoDNouTxLLZ1dINEeWEvWf0ikAqCD8/Zau7Uf
         r9N8F2GqqpdjB8Y5HVC+LmcXFs3KId5bDmHfVQAmcls7hoZhrF1X8Rv/aewb4JmT7vcY
         HZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609072; x=1793213872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
        b=Tx6kc1c3VR/SrKgMnQepmBRAavrJE2FurNYIl6j7anX1LHXhOFYNdJLREZuR6JIPxp
         c2VZQ1w8kLwIDyF8TKkfRE8OtyyZYUN2rQLhZ/38s50NI1PPO1nNX6/rGL1GpQOpvtzm
         T0WulGLuIp5Aw8UkvETsgw6C9/THnsulpDRrNEoY7RQpeX8eGWKOczJIZcDldd1TSQNA
         hI7UI47PXeavIstwC7hddQ7j94x4E5w7gRO/MFpHZk5b5tZPz9B587/+/7SYa4At3S/q
         OO+BjvdcqAb85NrjPhqwPoV18LxSFOCP5U+mmvAbLyrLvpXZlAByFcP6a0BXXviAj31p
         ekpw==
X-Forwarded-Encrypted: i=1; AKwUvBxn9y0QsJwLxZGaCbtGLHdeecIzeQ5GlsReBGiDAe9zi5Boppwj9WQ+G0v88sUqbOWA2e545go=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVtIWl5YQIdZu2KSy6a1rmhUP7y6OOWKgYz9qxN23QRJRmSG3q
	2vkqPfk3dwnxpqMPlGUfqRTB1PWp/y2/SnmRFN11WtAVY09sucMY6uIpk1qU0FB2fP31FMptYmH
	Mg/dJK5ZMDV7kanV1ZtruZ+YshZHOrNs=
X-Gm-Gg: AYBFou3wVaqkroS3O9Dxpibc+IoqLXDzbZrCAECAFE+jXzkJekMCZpApiCHNg/rnBYw
	KKiROVnQvmRKWGtYrFGJxL7FD/3vMi6e0SITFMvlQVRT9WE1HKBaYKshFf3u/t19lHxCIvAW3Lh
	F7rAOZ/q/fabIqPslNaR5gCu5BqffKQc3Mg86GCnt8F96/QMdBI5dbNShrDIjEIYafEzbIwW4Xz
	sKd8xVuRM+nFfo0cukGpp51TSB3nR73S77sAVa9bzGhHmRa4sTFCbFRoV8HgSBMFiu8luSaJp9b
	hAV6T/iJYDSPxB8fj9sNs/VB4G5MtpTNidy+FT4MB1mBKDOjR2hOafxxqfZcGjvATfcpch2glLZ
	vZgJuDs8jlA4+HKhBE5QEY/voBWxQn54urP2b9/LQv5EgvCx8KuvnECYksjrWd/ajDiwod3TPkc
	MGqFr1I/j/Sp4NwrFPTw==
X-Received: by 2002:a17:90b:3e8a:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3ad86ce70c5mr2459965a91.25.1792609071620; Wed, 21 Oct 2026
 11:57:51 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020155848.75711-1-mahe.tardy@gmail.com> <20261020155848.75711-2-mahe.tardy@gmail.com>
 <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com> <atkG-5eqB8LfVxSa@gmail.com>
In-Reply-To: <atkG-5eqB8LfVxSa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 11:57:39 -0700
X-Gm-Features: AclHuK-I_9WzDyc9HR2tb49toTqh-ceHwcLBr8TwXe2tIajdsNbAf5oioeQVVC8
Message-ID: <CAEf4BzYA79tg5C+uzo3S5=MRgM_O7VMYtOwW59QMieJoFNOpVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, yonghong.song@linux.dev, 
	jolsa@kernel.org, kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com, 
	almagui@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:39=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> =
wrote:
>
> On Wed, Oct 21, 2026 at 10:56:23AM -0700, Andrii Nakryiko wrote:
> > On Tue, Oct 20, 2026 at 8:59=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.co=
m> wrote:
> > >
> > > The motivation is to plumb more of the socket API into ksock, thus
> > > supporting sendto() in addition to send() which makes a lot of sense =
in
> > > the context of UDP sockets which are the only type currently supporte=
d.
> > > This is useful when ksock is used to reply to specific addresses or s=
end
> > > to multiple addresses.
> > >
> > > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > > ---
> > >  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 69 insertions(+), 27 deletions(-)
> > >
>
> [...]
>
> > >
> > > -       return ret;
> > > +/**
> > > + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a r=
emote address.
> > > + * @ks:                The BPF kernel socket context. Must be an acq=
uired reference.
> > > + * @data:      Pointer to the data to send.
> > > + * @data__sz:  Size of the data to send.
> > > + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NU=
LL to use
> > > + *                the connected destination.
> > > + * @addr__sz:  Size of the address union, ignored when the address i=
s NULL.
> > > + *
> > > + * Sends data to the specified address, or to the connected destinat=
ion when
> > > + * the address is NULL, best-effort and nonblocking. This may sleep
> > > + * (kernel_sendmsg), so it can only be called from sleepable BPF pro=
grams.
> > > + *
> > > + * Return: Number of bytes sent on success, negative errno on error.
> > > + */
> > > +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *d=
ata, u32 data__sz,
> >
> > This would limit API to fixed-sized data only. Have you considered
> > passing dynptr as a source of data, so you can send a wider variety of
> > data? I don't have a strong opinion whether we should add a separate
> > API or convert this one into dynptr, but I do think that having
> > ability to work with variable-sized data is super useful and should be
> > added early on.
>
> Oh wow this is really cool that you send this now. I was working this
> afternoon on trying to see if a ksock sendmsg() would make sense, but
> with these static buffer limitations as arguments, it actually didn't.
> I'm not familiar with dynptr so I didn't think about it, but after a
> quick check it looks like it would be a good match with the ksock API!
>
> As I understand, since bpf_ksock_send() is already part of 7.3, it's
> best to not touch it, and having a simple send() available with a
> fixed-size data might make sense.

agreed

>
> But since bpf_ksock_sendto() was just merged, we could make it evolve to
> use dynptr perhaps? How much time do we have for something which was
> merged yesterday to be part of a release? Is it going to be send with
> the 7.4 pull soon?
>

I'd send a follow up in the next few days, it can go in as a fix for
kfunc in rc1 or something, unless others have differing opinions on
this

> >
> > > +                                const union bpf_ksock_addr *addr__nu=
llable,
> > > +                                u32 addr__sz)
> > > +{
> > > +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr_=
_sz);
> > >  }
> > >
> > >  __bpf_kfunc_end_defs();
> > > @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> > >  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> > >  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_N=
ULL)
> > >  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> > > +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
> > >  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> > >
> > >  #ifdef CONFIG_BPF_LSM
> > > --
> > > 2.43.0
> > >
