Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793817029;
	b=oLbG7EYRujHUviW8AibO/DexjQywUY768Sh5fZ+/fZAYLKokrMHH3IKUPTuPXvo3XwQP
	 DsV5N9otUpkp/M0PvALgAm74lPN/AG7V1yiA6PChjSepkH7E85SBwJe9qrNXuYhw1kese
	 L8NkgpQJH1rodzZQ1ONpxRDzLvMspCjomqNSzCw04OjboNwAXy7EaIKWjXv1Zab9nIBaz
	 6dxLEhZrWaPP8VSP5gk6xYmYuiUpvFgUusOK93ZJabU5AngNxLLBQOjj4ycWTOXTiUGRj
	 lTFlWowDiKM/7jtKLw+1tLfuQJCdvD43/OB2994OZdu5I8zBS0M/ldfTmf871hameLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
	b=p/krSoZBhhmthd+mmOI7Ncofvp0aAbHbu4NdpTqQ4kY/FuG1VsItxeXLEM9RI4O8LTgk
	 x2zlFi5WuQ3G2Xz6UavIFTLp3+kQAx24VOjcqtagTbvAkZFwfypb+z++bcadgKkI/1Dkv
	 j0fSyKeZ6cA8gY+A0FLVn0tcGAUYlmBSGiDIA3xhKlVHhPvd2TtC1VWaewPVmjwPbGEB3
	 OmmB/WQhy68r2Tbm61L/7s4TiKhlOWUfIx94EKuYTrs67c6I8aA4FJMmXt4P5mUz+Id7A
	 +TJISMdXpH4bp56WeFrhxRCci2wdIdE6e1uDlrKc3DJ8bIJt/zT3YSLedUSN6vS62rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=D+vzaXEc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE2606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DE2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=D+vzaXEc
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc53938a8fso572078137.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793817023; cv=none;
        d=google.com; s=arc-20260327;
        b=FyXQ8gRKoORRRXC4+9eFxT6t78jukU11hEC138VyhzEh5+xNlikTD50nrzATv33KRl
         QBy8yylbFUinKrxZ3fkhwxpoI3nMWeLmfiBX7zGNcsphN5XTUP5kGQk3r12asrnDbYMo
         UCgLhQfiVilV3gBO3uW9kbB9pPhURqOSC5uK1jAH5jK1DpqUasyA1w6R2Bsb4ECmCrfo
         ElNikAzp7c2N0Geb/pRmOkfLSyz7b9wa+/pcT9bx6TILoYnJm7AXg7KZmM+TduLF5lWE
         disWxrn1lmeieeXGUBvZbgAz0Unp1POjkjgAvhgX/AHNLheJ33cIpQQXON6j7RMHaVk+
         NE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
        fh=GuwKir4kw6mFlkxLdiQUL3ZyKchc8uWqACjmiDK+CrY=;
        b=oPpDAEt8pn52pnoCf8FGVo4mIipQqLCSrMss6ri52z5LnTsukOfKAiOKQd8pnNfcTv
         TDQpJrtBSRqTp9aL2+X2cZksV9lKCTISpqeUJLlz/vsKVBy5cMUhiie+mhjlTvUwDKPt
         o4IbPVvvFvmcBUPuKZp44Fyyv1Q93vqC7q5PaGMYBD9cMNttC5s9DQ+PUKfysPk2wYnz
         VH9B8641OU1qdloiQoRL8KWThVltbPAiUpLo8ZZUYBcZU+B6nZaxtCZy6zW8LenPcRZ4
         68TOL97NCaiAHjRoanH1Yu6vyN+BBRJju8Wm+6tu9qmlPRUYSFIIWi9Hc0xYhxlYsGNp
         Tg7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793817023; x=1794421823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
        b=D+vzaXEcyQsrqSCPGZFnsmiGvYNBSc4foTiivjqiQoqaMvSxloeeFxaM5RXt6S2Kv6
         V9y2OBTNagImvYAvD10a+ZoSyI9FAmiK/KzEsrd/zYfkRAWLXuO+u9GbM4FBFTl9MbPS
         kRyUIbTsbZSmYQQLaciF+SGH0bpTJ1mFPQdzvRxHRBu1u/Miw3SOCmssLYPYx7bNVYPZ
         EBJMPfwBdPViJ2doX3G+mxxchBNoO8kqnaMhAprre7AkIt/4ny0vrfK4SLSP0Nt2bTTw
         uz/yAV3vprRPcCj3PtI0OiyjmsPECr7nrryw5M7Zb4RMktGqwLoCZwH84JtIQ+5N+CoT
         6k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817023; x=1794421823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vlBLO9On7q47NyBJ2Rw1NocpmdzrNn/c5hU8D8zRfc=;
        b=nvKZ5nDbXH1AH4UEgd9SRnhveFuAfTE6C5BtriU3CAnp8/8YgZNktOjosG1Pz7xBjz
         Kd0fPUNkaNb3eOl3v51e2Ts3pAJkYCHJjwCVvx4tndVFQ0qkCQNrzSEYvlrNMSUkZlF5
         6O0V+XpeHMMpXkrTf/7pqbgYx0uocAdazk3E9RpIEae9d6lZzjKL0sPtAHnM/Nstzqxp
         +iSKZCgLjnYq1A61GI7X5yuRG5MeLoT1jvLHrSWr2PBGdwRHvSOR6qhbvwC1Z8Np0s16
         HyCagpedpyR/M36yRgfJc7XqCSDUOyqC9ug9zme6jsNtK4wQ3BMtEWuZqobuTUW03O6+
         Y42w==
X-Gm-Message-State: APuU4Z8c4ILz6Ao3rqklBbK7MmDiNlAKwVuhi7netB77MT9jwLuM5ubk
	KmlX1znwIBy83M6K/v/KD7YvXw5n9NOmakr3iFnpqszDNk02jdkFAXo2YAc7KPdba/EYvF+CNCW
	2HhIlXvrYOZw3zyFlxHBKI9HXAVxBjN2xVcNUBPFHZg==
X-Gm-Gg: AYBFou2BLDOvoetcpr2Olo1nHmUlFFfFyoAyw2/Knn/eSVJf8tEwpJqcj/YAs3E6ov9
	V/JWqRbXpMHU3l4X3fLe1aFvkyE4HNuOjIgRNGRvy+wtHs+r8OzSLCJIURs92kUD3ULhdmzUmwO
	0hIS7eUvxu25UmHUA+JKOv7BSIgT8OYmmwwpL6S/dLdBp3mHnGja46lPf+ZfrxByCiHpEvVgHJR
	0OH4EgbHmN9/HVuvdgtPblJetKm58szdBFg3V4e2fZjF4hHMt8pYW75uKkGYoiH5gE2kwWsn1PZ
	mBljMv5CP0N5SXxv1mEqoc5uLy9mm/6BL5P/o5bptSQNCRQr44+8ft7RzKINM7T99jA9l/KYi39
	LqvpVsJD2t0rjtIph1dblCsacwl+1iZsE2ptgIL5liyFLxAosqSmD6Qog1HJc5sy7+ntbHF/fI1
	XVVmSlu/rLj1/V2QHZoXcfVoyYJhjcw+e86BwzYODUv/gq+F10mJ/knVJUvp8uA1uF91oZ5S/Rv
	XSVNRt+dqIWLfxudtVdzKhP
X-Received: by 2002:a05:6102:3e8e:b0:7cb:bb33:8413 with SMTP id
 ada2fe7eead31-7d072bb37c6mr7312101137.9.1793817022500; Wed, 04 Nov 2026
 10:30:22 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102220310.12649-1-rjethwani@purestorage.com> <179374354756.488856.17787079121679404910@kernel.org>
In-Reply-To: <179374354756.488856.17787079121679404910@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 4 Nov 2026 10:30:11 -0800
X-Gm-Features: AclHuK9IwD1rDZTP-2krUHCIqiisxEe3xHzAbLlTex379jxu1nU7vOHg_omGLSc
Message-ID: <CAKaoeS1koPSPtjzj3sFYnZoO5XkYaDcWnodHR+KsGNfz2CYrgA@mail.gmail.com>
Subject: Re: [PATCH net v5] kcm: reject attaching sockets with a ULP, and TLS
 on KCM sockets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiayuan.chen@linux.dev, 
	syzbot@syzkaller.appspotmail.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hare@suse.de, 
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:05=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message understates one user-visible regression.
> - [Low] The commit message says 'rmmod kcm waits until such sockets are
>   destroyed'.
> - [Low] Documentation/networking/kcm.rst ('Attach transport sockets' /
>   'Unattach transport sockets', lines 144-190) is not updated for the=E2=
=80=A6
>
> --
>
> kcm: reject attaching sockets with a ULP, and TLS on KCM sockets
>
> With this commit, kcm_attach() refuses TCP sockets that already have a
> ULP, and it now refuses raw IPPROTO_TCP sockets too. Attached sockets get
> an unregistered dummy kcm_ulp_ops, so tcp_set_ulp() refuses kTLS on them
> afterwards. The marker stays until the socket is destroyed, and it pins
> the kcm module.
>
> Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55=
@linux.dev/
>
> > Holding a ULP also has visible side effects: getsockopt(TCP_ULP) and
> > inet_diag report "kcm" on a socket that was ever attached,
> > sk_has_decrypt_user() is true so PSP RX association is refused after th=
e
> > attach, and adding an attached socket to a sockmap fails with -EINVAL
> > rather than -EBUSY.
>
> [Severity: Medium]
>
> Is the sockmap effect really limited to attached sockets?
> SIOCKCMUNATTACH does not remove the kcm_ulp_ops marker, because
> kcm_unattach() only clears sk_user_data:
>
> net/kcm/kcmsock.c:kcm_unattach() {
>     ...
>         write_lock_bh(&csk->sk_callback_lock);
>         csk->sk_user_data =3D NULL;
>         WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
>     ...
> }
>
> sk_psock_init() checks for a ULP before it looks at sk_user_data:
>
> net/core/skmsg.c:sk_psock_init() {
>     ...
>         if (sk_is_inet(sk) && inet_csk_has_ulp(sk)) {
>                 psock =3D ERR_PTR(-EINVAL);
>                 goto out;
>         }
>     ...
> }
>
> Before this patch, this sequence succeeded:
>
>   SIOCKCMATTACH -> SIOCKCMUNATTACH -> BPF_MAP_UPDATE_ELEM on a sockmap
>
> With this patch, the map update fails with -EINVAL for the rest of the
> socket's life.
>
> Could the stable-facing paragraph that lists the user-visible changes als=
o
> say that a socket that was ever attached can no longer be added to a
> sockmap or sockhash?

Good catch, I'll list the sockmap case in the stable paragraph,
and I'll fix the earlier paragraph that said the -EINVAL only applied to
attached sockets.

> > listen() after a disconnect fails with -EINVAL, as
> > the dummy has no .clone, and rmmod kcm waits until such sockets are
> > destroyed.
>
> [Severity: Low]
>
> Is "waits" accurate here? Unloading does not block on a non-zero module
> refcount:
>
> kernel/module/main.c:try_stop_module() {
>         /* If it's not unused, quit unless we're forcing. */
>         if (try_release_module_ref(mod) !=3D 0) {
>                 *forced =3D try_force_unload(flags);
>                 if (!(*forced))
>                         return -EWOULDBLOCK;
>         }
>     ...
> }
>
> The reference taken by __module_get() in kcm_attach() is only dropped by
> tcp_cleanup_ulp() when the TCP socket is destroyed. As long as any TCP
> socket that was once attached still exists, rmmod kcm fails at once with
> "Module kcm is in use". This holds even after every KCM socket is closed
> and every socket has been unattached.

Right, rmmod fails immediately rather than waiting. I'll reword it to say
it fails while any once-attached socket exists.

> > diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> > index a7f94d42036fb..1f8bcbb8b9c3b 100644
> > --- a/net/kcm/kcmsock.c
> > +++ b/net/kcm/kcmsock.c
> > @@ -30,11 +30,26 @@
>
> [ ... ]
>
> > +/* Not registered, so TCP_ULP can't select it. It only holds
> > + * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS. Like an=
y
> > + * ULP it stays until the socket is destroyed, pinning this module, an=
d
> > + * tcp_cleanup_ulp() releases it. Clearing it on a live socket would r=
ace
> > + * with lockless readers such as do_tcp_getsockopt() and tcp_diag.
> > + *
> > + * No .clone: children copy icsk_ulp_ops without a module reference, s=
o
> > + * a socket that was once attached must not listen().
> > + */
> > +static const struct tcp_ulp_ops kcm_ulp_ops =3D {
> > +     .name =3D "kcm",
> > +     .owner =3D THIS_MODULE,
> > +};
>
> [Severity: Low]
>
> This isn't a bug, but should Documentation/networking/kcm.rst be updated
> as well? The "Attach transport sockets" section only says:
>
>   - fd: file descriptor for TCP socket being attached
>
> The "Unattach transport sockets" section says unattaching "is
> straightforward".
>
> After this patch, SIOCKCMATTACH refuses raw IPPROTO_TCP sockets and
> sockets that already have a ULP, both with -EOPNOTSUPP.
>
> The kcm marker also stays after SIOCKCMUNATTACH. For the rest of the
> socket's life:
>
>   - setting TCP_ULP fails with -EEXIST
>   - getsockopt(TCP_ULP) and inet_diag report "kcm"
>   - listen() fails with -EINVAL
>   - sockmap insertion fails with -EINVAL
>   - PSP RX association is refused

Yes. The next version updates kcm.rst.

> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261102220310.12649-1-rjethwani%40purestorage.com

pw-bot: cr
