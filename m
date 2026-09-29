Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356854EECB
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706723; cv=pass; b=P9gfVYhOHGu6BkpCdxeCv+9zzhKxcL4o8C2UU26NIEO1ih01JNluTJRQtXHC7XgIIbFmLHY8LGxs0OJGnDVpPK+ggR3J9yo4tQ9DPmnkyNLjsHjIT6g0rzACL7lYEF41ma8o8GkH0cKzRtO4jJtOEkMeM92V3lgfPkx2XVOnr4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706723; c=relaxed/simple;
	bh=qWjEYaStd/oVywPQuQU4H4r1EBvFvWLTPGQ7OKRH+DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSuKXiMmB0RJ7MvLH2r6QqMfyUZTH8AwRmwa2RT+z5JvZOlwtr4hBz1G89CMs2iuNu11m+jOlW+J3/a9KbIK4H/WoLpmxvT1z85D+NhjHzBWZ/zP+AaiqDOniRVVKvmYZG2t8gBj3L0LulvzGXsxmzBDxgDAxDN/uA9G+k7VEl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQg34cmS; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQg34cmS"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so4026844c88.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790706721; cv=none;
        d=google.com; s=arc-20260327;
        b=dufUFaBmHkkzcxN5miA5I9x5xIE0M7UvcMM6ZVIex4be3ED8bfrU4rdSdLBBGoeax9
         SF5/B71hUl1INe9e4xUOehibshGZswfN/7e3NLa8AVUc7kpQ6gyoZRgIhLexXzue61s8
         LZ5cndV7Ji7yPa72T2tHil3URN61eyjVNX4vqgFj79X1ld7U6XStCv6j6Z3K4AoS/ef7
         mAF37xYWMW5uDHAT58mBUByg91dbdeowiv8Wo/gqGfhB0FRyRDHE35WkHPKWFJnh/kfj
         ah1rMgeRRTwlMK7Nd0r43bNppwvuTcAU17P5y9s/CyxWYdO1lFqfh0VRPMPqyNhTfAmW
         4gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QL+31yB/3pr3YcTjuo55arVZQnRMUw6vTN5sIsky9hs=;
        fh=rD88oy03APe01hGcocPd7J6f60ABrgTDMQkesuIyFMs=;
        b=aHyr3a4QAUlAsqMCGTv9sNjuYOJnPqBmmvCmE3N4bUTp9EHyodbRwtG5MqrcgiGzM7
         1e/9diPvpOH+O4ar1qDRdVQbDqoG3Q7tjntXwhO7k+QKoWOqRd3v6ibpQi+qS7/yc5S5
         aJFL69EJtK9RgdOrsPJbij8Q+dBCxXA8w+IiFuyQgfjfXmf5gijuPwUVCLSw6vT2Gd8w
         0TUEgsrM8C/kSlSAgPgTZwshd/9YiC1ymFMSgroqGx4caKAwFa0DUkpNZJneGfiLay4S
         +8aBG9ZhZoAW+zy9UkGyds2G2ReKJfNiEAwoN4ep+LETLfSkNdA+1fy8fVgpUPDb/RSL
         98Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790706721; x=1791311521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QL+31yB/3pr3YcTjuo55arVZQnRMUw6vTN5sIsky9hs=;
        b=EQg34cmSpqkrp3vUV92uwrc33b3fnuuw1i6krry2C5iq7fN8joisIx8ybSKy65MEbz
         IM5IIU5g92FqcdVdZq/s5D8mPdD43W/LFxkVxmHfTPl1pmF+1rupLFYFmC1xO9w2WpNs
         trRbuFMa6/Wss5W1OoeaMv4d1WAEV78twb69uuhQLbfzIcmyyczYVv4n2oqjTuagIgCs
         Otk5vVIsSJSk1AgJC5umGCkCxpG1EYEKA/490Lhs3bNiw/QpPSdywKwnG4WvbCCbxp6M
         yruymcqsoA5wZWQP3Gg8fa365OfBwtYa9cK6DsGRZg82bL+Jqh8AWtPVRWysfd9qv2/b
         fSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706721; x=1791311521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QL+31yB/3pr3YcTjuo55arVZQnRMUw6vTN5sIsky9hs=;
        b=rSbhMJ5FM6t9QJTScBjj05gXwxj+sikWvO99RLQe1QO/J7tPQJXRUEJf2yLD8sy+bW
         rpblZ2wYgwuja4IdSi/EuRatNe99NhGWQF9FD9JNIK726ZfgKkuyKE2pONr6Wa177MGT
         s5oPv0o+b6nuObTKms8dfKi97WVoR5WTtfqYtZ2B8NjseMEfnqkmfBOdRG4TZU84gYXv
         QkVTcMbwl2/4+j4vO9DFk/xEner5A3yPOwSnYh/ATv5QY2GJPIrhiFv2ulCQNiHxszQO
         h84SNqgx2cuJ56o3AMKC2yAGPn1Hz+3HIyciQx3Kv8ALp9JlNrv0Ediy2waozf6SxHJx
         CC6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxR3LVUTys/bTO/YJZVFjdYuSLPChUNEaHKds7k0ib5f33nPZ+AOP+LqCDH3fn4pFFVQA24I4k=@vger.kernel.org
X-Gm-Message-State: AFuF++no66J1BW5ktVip6XGMF6np+7bFlwqp9g1hxrwsn5Fff2cqkmX/
	y5SPjjTyaC9VQNeha07YMKGfmQfXumEegy8HQrk8Xq2IJf6HFG7FTtHGAt2TkDN2pFVByTlDDub
	lyg0xWaMR01hVhg2+6xyBQItq7hAwfHebRG/OmXuT
X-Gm-Gg: AYBFou2byvMaQ3+jtd+8fqton8WblqzKVegZ9WOYY/o7EfX8CUUg2MwPwAGPKsREyhE
	tDnBkbUP7FS4uFtaH48w8pwblyIhBpDghnEOhOQthGKvzJsb5/Swldw925GxNHaMeLSv0YuCI8H
	uUh0xKYUoDpDEugZNW7z+xQSOLcvaRCsLapcE9WKRZq41IDl+4OI+jcn438KmozKv8VeMZPEqOR
	ydLwP1sS368x2u8fSmCFOqhCrJ5bf9JmpBhftf93eLXGenLvZpjy3mi7N8Q1uhAg32juyGAl14r
	CzCbpe2FEzfXoMNmpA9jHE4N4V9FXVwECR0TiFj0MszxNNotVtXZ9wKUwnLGlYpzHe/yN9T45Yp
	DETFgQPSQ16WmlzLXewUds3g3OYquTqHTX9XfL4eZz3oN3Z8eerNVxIYfQqnuzVCd3nfzgCxZUI
	v7wrsl6RZ9j7RlIr1IKwCqQQ==
X-Received: by 2002:a05:701b:205c:10b0:143:26f5:c617 with SMTP id
 a92af1059eb24-14c9f219e28mr16546c88.32.1790706714675; Tue, 29 Sep 2026
 11:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
 <20260928174546.4022833-1-kuniyu@google.com> <E620A4AC-8FC3-437D-AE14-31D50C7E2007@doyensec.com>
In-Reply-To: <E620A4AC-8FC3-437D-AE14-31D50C7E2007@doyensec.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 29 Sep 2026 11:31:43 -0700
X-Gm-Features: AclHuK__0wlfIuQn5YoIbWiwSnDEbSvDEt-dCblHPCpJMwXVhpCzSggWiEdv3qQ
Message-ID: <CAAVpQUDB8_K0xjGtDzXNd4AjBgD9WOPskJjWMMT4cdYQodEsuA@mail.gmail.com>
Subject: Re: [PATCH net] soreuseport: Fix use-after-free when a socket is
 added to socks[] twice
To: Norbert Szetei <norbert@doyensec.com>
Cc: daniel@iogearbox.net, davem@davemloft.net, edumazet@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:31=E2=80=AFAM Norbert Szetei <norbert@doyensec.co=
m> wrote:
>
> On Sep 28, 2026, at 19:45, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > This has long been a known problem, and I think it's time
> > to fix it instead of working around it:
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 2948dffcc3e1..a33cdf99368d 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1324,6 +1324,8 @@ int sk_setsockopt(struct sock *sk, int level, int=
 optname,
> > case SO_REUSEPORT:
> > if (valbool && !sk_is_inet(sk))
> > ret =3D -EOPNOTSUPP;
> > + else if (!valbool && rcu_access_pointer(sk->sk_reuseport_cb))
> > + ret =3D -EBUSY;
> > else
> > sk->sk_reuseport =3D valbool;
> > break;
>
> Thanks for the suggestion. I tested it with my sock_reuseport.c change dr=
opped
> and I was not able to reproduce the issue, and migration and resurrect st=
ill
> work.
>
> One question before I send it as v2 with Suggested-by: you, unless you
> would rather post it yourself.

I had a few more patches in my local tree regarding this kind of bugs
but I didn't post them as I thought no one would stumble upon them,
but it's no longer the case, so let me post the series.

It will cover SO_BINDTODEVICE as well.


>
> Should the check be restricted to TCP?
>
>         else if (!valbool && sk->sk_protocol =3D=3D IPPROTO_TCP &&
>                  rcu_access_pointer(sk->sk_reuseport_cb))
>                 ret =3D -EBUSY;
>
>
> The closed section only exists for TCP, so TCP is the only protocol where
> clearing the flag leads to the double add. With the check as it is, a bou=
nd
> UDP socket also starts getting EBUSY from setsockopt(SO_REUSEPORT, 0).
>
> N.
>
> >> Clearing it between shutdown() and listen() makes that listen() skip
> >> reuseport_add_sock(), and with it reuseport_resurrect(), so the socket=
 is
> >> hashed as a listener while it is still in the closed section. On the n=
ext
> >> shutdown() __reuseport_detach_sock() does not find it in the listening
> >> section, returns false, and __reuseport_add_closed_sock() adds a secon=
d
> >> copy of it to socks[].
> >>
> >> sk_destruct() calls reuseport_detach_sock(), which removes one of the =
two
> >> entries. reuseport_grow() then dereferences the other one, because its
> >> loop runs over every slot up to reuse->max_socks:
> >>
> >>  BUG: KASAN: slab-use-after-free in reuseport_grow (net/core/sock_reus=
eport.c:291)
> >>  Write of size 8 at addr ffff888132359988 by task poc/621
> >>
> >>   reuseport_grow (net/core/sock_reuseport.c:291)
> >>   reuseport_add_sock (net/core/sock_reuseport.c:350)
> >>   inet_hash (net/ipv4/inet_hashtables.c:810)
> >>   inet_csk_listen_start (net/ipv4/inet_connection_sock.c:1359)
> >>   __inet_listen_sk (net/ipv4/af_inet.c:225)
> >>   inet_listen (net/ipv4/af_inet.c:247)
> >>   __sys_listen (net/socket.c:2014)
> >>
> >>  Allocated by task 621:
> >>   sk_prot_alloc (net/core/sock.c:2246)
> >>   sk_alloc (net/core/sock.c:2308)
> >>   inet_create (net/ipv4/af_inet.c:333)
> >>
> >>  Freed by task 0:
> >>   slab_free_after_rcu_debug (mm/slub.c:6570)
> >>   rcu_core (kernel/rcu/tree.c:2919)
> >>
> >>  The buggy address is located 904 bytes inside of
> >>   freed 2624-byte region [ffff888132359600, ffff88813235a040)
> >>
> >> Only move the socket to the closed section when __reuseport_detach_soc=
k()
> >> reports that it was removed from the listening section.
> >>
> >> Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport gro=
up.")
> >> Assisted-by: LLM
> >> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> >> ---
> >> net/core/sock_reuseport.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> >> index 29948cb44b7d..031b641be317 100644
> >> --- a/net/core/sock_reuseport.c
> >> +++ b/net/core/sock_reuseport.c
> >> @@ -479,8 +479,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
> >> */
> >> bpf_sk_reuseport_detach(sk);
> >>
> >> - __reuseport_detach_sock(sk, reuse);
> >> - __reuseport_add_closed_sock(sk, reuse);
> >> + if (__reuseport_detach_sock(sk, reuse))
> >> + __reuseport_add_closed_sock(sk, reuse);
> >>
> >> spin_unlock_bh(&reuseport_lock);
> >> return;
> >> --
> >> 2.55.0
> >>
>
