Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BC53ECE4
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573431; cv=pass; b=IVuxGrPYBVkMaD6HZ5fawv71a2dj3ex3rzZDXfgVh2KZv49W3kQsMfSNy1CuWO1G/v7rOcBgfLDT+cwT3b6OYtWwCbXthvyBStTfnTPgUDgsyFzE8eod3cLFOFYl5qDO/RHa0Mm8I43SBgK1zWnaA1RS03/WPOk5FkTrQWKna3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573431; c=relaxed/simple;
	bh=5r9oITh6Ke0h0LdwQAODmCkNekYxLU9BUgIqqL0e/CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwt/msNwiKjxadsVSwZfsXZxG1etpkZyrRPWFgkN9gVUx3xQQ3wqCGvDk2cNu97j9sE2/q94xpbJyRg3sjLmRKJ5W7HuPOTB2/7akNOBKNIyZlw+agBmPzoIXC8ScR+YyJ3cjyZ2GmqSjTPBRWOIRKkWNc8llBFxGfklqYi0H8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAR5is7y; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAR5is7y"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1235610b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573429; cv=none;
        d=google.com; s=arc-20260327;
        b=kcApk8r/ddBUHatI9XYIiGRSSgfvAHm7JhngoZaY86arKvc7hhwvgL7zquL3WLghKr
         lp7193a7mxyEcVqHpqbPe02kvPPgW61tmzt3eOxSP49sCe2px0wx1C6ti7E1SsjFymEU
         3Hv87T3NFb0QCReUIQrZ70UZtSkCKSxvI4CUjy5rmpwvyF8kw/REnrQWeW5U51eU8oVf
         jwciN6WvQysUnt4zv+DWT8PfbtbXTtE8UPXLtzItS7sle4FwZC6mh7WFTNp87Ztj/utf
         FEOgZr/jAE6f5+xvWJqkc/SYL0GODxoualmUrEcsLhjO+AXH6zlwMp9gtC+A1chm7IX/
         hZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODqiZXRBdCHmyesWjPny1yNGa+YI4ZP+iScqkVqOaCM=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=AwQ/jyjOoH5k9f86tCSD+yHUkkD/bt9ouzI9Q7VC12tYMy7hkphnmqZYCw0NXFzNxK
         HGLw/KhfypmtbFDRh/1wczlPqKGNXTT9sBJAhOTKqgYB1VJJryI5/nggaC5eUNpQ56wA
         FGpTwQf1jorVu3Kgtv7AUxIylpONnHjY9H+4Y44Isn5likp4XvnllY784NQqxm7FpL+2
         VXsd4nlp4A+Z4zTXa4NZlCRUe/iyd8rhL7D+3D/6t5gO0ZXTqGnP4d7FNNy+SLc6sPkY
         erAeUoJMhtCzykxUXIUCnifxFy8qodo0tcayWCA93F3wjmRNvnstcU2mJSzd8tGuHzkD
         Qnww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573429; x=1790178229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ODqiZXRBdCHmyesWjPny1yNGa+YI4ZP+iScqkVqOaCM=;
        b=HAR5is7yOUURS5rRWXWE/wvsJcYzvA/PYQefMQRrSg2MYylTiFMSJ7s/dl8rExo6D4
         QCQHOoOQ390nXTZKxaMUSfE8dplM8j9yzuC1lWatomtRZ0OEtMMLgcE2RVX/kOnZg/qc
         jesgvl4eKbjnn8c4UVh9PgrihA81yIdP8XHGRUUJRzH3GPc99l433ByuYNarus15onhQ
         +FIujV28QjrkA86ndnTQUAezvmK4/NSoaW9SHGX6gxOdZ+DZji2iIpmT+Td1dbYakIDZ
         MsS8yW71AplQP+40apNwR23dt8McJfm/v4XaDDhN6LLWnTJ5SYh1OBtu8Zuk/pNbzpEU
         FubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573429; x=1790178229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODqiZXRBdCHmyesWjPny1yNGa+YI4ZP+iScqkVqOaCM=;
        b=1fVKjk6Knn78MyM+jhFtn+Jj06l+WbiUpiTuplfMBWX73hxcdUZDehKWd8LMi5Du1+
         xkWWTn8LDrHQuUfg/cJKs0YIX0rMRg6SCq1SPXGqG54R/Ict2FG89K8a/nUYuDRTYR/S
         tN/mBEgst0/yjAXc5K10T/O5ZR7XupsK14kjSpONoM7qwDbbpx73BN2GLDeJF2dLiuXM
         zTg/I2HIA3nFsvbu/0VebQpynzXXVQTX6x8RdAbQEH/7JD7IawxUSF+WYDVLteCFIytx
         zGN5RwEUMe3YmiT+jvLdbXYh/kNfylsgTlzY5FjP8IzaHudDN2RGh7FN3x3nbrHaKyZD
         Mf9w==
X-Gm-Message-State: AFuF++lQfhHG1vUzdo1P8aSdSEazzB4PNfajB1wbcgtTEOSm3K+KmpnW
	RfnzyqkeVHdEMonSATUL+8NB7pkkBsx+c0z3jYgIVtCPrgeOe0tyJUmnuwr1+kItE0Y1RtHZ3hI
	GcrhP5PTQxdUWgGOhelgb4OzUoXG9BUM=
X-Gm-Gg: AYBFou0/n0xIKSBdlEy+9wtppXaJTVq549/AppVu61cp3Zr0Z121b5GUglzLb+6NBgk
	ii/bwpDz8ZBeW9RvbDDJWI0bkDPYVfvMofcn/Vn7y6irxrDQ7ZNWw4FZLoLJ8Liibm0BsVhwuXB
	FaPNoR4wk4jo543NjCAOGmPrCZf0V41LKvOFOTbzLSAiiof30JjYLoWICUxIXosiNgez6Wh7rAm
	b/pDan74Q2n/jgEsK1bv6z9sPh4LFP4WYR4CFMeffuLztIn0A28jrkAc/E3jn2LSec5q1fjkJpk
	5qXpUqK0lFfmEGSmOwwQtCmm6gZZ73OEpTaOGKToOvNYeBTG41t6eLKVczEKoKzjrcvuUF0U3dL
	VhVWvRsn1apLVzsLs1+bZ7uhBd19XRVeA2T/xXHf9wKY/KnIC9QD30J3W
X-Received: by 2002:a05:6a00:4406:b0:86a:141e:2a8d with SMTP id
 d2e1a72fcca58-872379b1f8cmr7321250b3a.11.1789573429057; Wed, 16 Sep 2026
 08:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <375ee7fe827d9df248a27a8072c84a7c167fc50a.1789393775.git.lucien.xin@gmail.com>
 <178950184430.22033.8793987707688483661@kernel.org>
In-Reply-To: <178950184430.22033.8793987707688483661@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 11:43:37 -0400
X-Gm-Features: AcwNN1XSc3BIya9VHdn-b90bW5THPSIgMzBCtVU9z3ZhvPnGIT-zThpbhq1QirI
Message-ID: <CADvbK_dwf3bMTs_TnOsqJQMAnCCvnr1M8x8DyCtesaL2Wy5ceg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 08/15] quic: add path management
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 5
>
> - [Medium] quic_path_swap() opens a write section on a bare seqcount_t
>   (paths->path_seq) with only local_bh_disable() for context protection.
> - [Medium] In the explicit-port branch of quic_path_bind(), an existing
>   UDP tunnel socket is reused whenever quic_cmp_sk_addr() matches.
> - [Low] Commit message claims PLPMTUD/ICMP feedback is integrated, but at
>   this commit quic_udp_err() is a stub returning 0 and no quic_path_pl_*=
=E2=80=A6
> - [Low] quic_path_pl_send()'s kernel-doc ("Called immediately after
>   sending a probe packet in QUIC Path MTU Discovery") and the matching=E2=
=80=A6
> - [Low] The new file net/quic/path.c carries the header comment
>   "Initialization/cleanup for QUIC protocol support." =E2=80=94 verbatim=
=E2=80=A6
> - [Low] quic_path_pl_recv()'s documented contract ("Return: New PMTU to
>   apply if search completes, or 0 if no change") disagrees with the=E2=80=
=A6
> - [Low] The three PLPMTUD pr_debug() statements in quic_path_pl_send(),
>   quic_path_pl_recv() and quic_path_pl_toobig() print the label "dst:=E2=
=80=A6
>
> --
>
> quic: add path management
>
> This patch adds struct quic_path / struct quic_path_group plus the global
> hash table of UDP tunnel sockets, with helpers to bind, unbind, swap and
> detect alternate paths for connection migration.  It also adds the RFC 88=
99
> PLPMTUD state machine helpers (quic_path_pl_send/recv/toobig/reset/confir=
m)
> and a quic_wq workqueue used to release UDP tunnel sockets.
>
> A few questions below.
>
> > diff --git a/net/quic/path.c b/net/quic/path.c
> > new file mode 100644
> > index 0000000000000..a9e02fc22e609
> > --- /dev/null
> > +++ b/net/quic/path.c
>
> [ ... ]
>
> > +             head =3D quic_udp_sock_head(net, port);
> > +             mutex_lock(&head->lock);
> > +             us =3D quic_udp_sock_lookup(sk, a, port);
> > +             if (us) {
> > +                     if (!uid_eq(sk->sk_uid, us->sk->sk_uid)) {
> > +                             mutex_unlock(&head->lock);
> > +                             return -EADDRINUSE;
> > +                     }
> > +                     /* Allow reuse of an existing UDP tunnel socket.
> > +                      * However, if it is in the middle of asynchronou=
s
> > +                      * teardown (via workqueue), it is temporarily un=
usable.
> > +                      * Return -EAGAIN (not -EADDRINUSE) to signal the=
 caller
> > +                      * to retry soon.
> > +                      */
> > +                     if (!quic_udp_sock_get(us)) {
> > +                             mutex_unlock(&head->lock);
> > +                             return -EAGAIN;
> > +                     }
> > +             } else {
> > +                     us =3D quic_udp_sock_create(sk, a);
> > +                     if (IS_ERR(us)) {
> > +                             mutex_unlock(&head->lock);
> > +                             return PTR_ERR(us);
> > +                     }
> > +             }
> > +             mutex_unlock(&head->lock);
> > +             quic_path_set_udp_sk(&paths->path[path], us);
> > +             return 0;
> > +     }
>
> [Severity: Medium]
> Can this reuse branch bind a path to a source address the host does not o=
wn?
>
> quic_udp_sock_lookup() calls quic_cmp_sk_addr(us->sk, &us->addr, a), so t=
he
> existing tunnel socket address is the first argument, and
> net/quic/family.c:quic_v4_cmp_sk_addr() has:
>
>         /* Match only if socket is also ANY-bound. */
>         if (addr->v4.sin_addr.s_addr =3D=3D htonl(INADDR_ANY))
>                 return a->v4.sin_addr.s_addr =3D=3D htonl(INADDR_ANY);
>         if (a->v4.sin_addr.s_addr =3D=3D htonl(INADDR_ANY))
>                 return true;
>
> That second test means an ANY-bound tunnel socket matches a request for a=
n
> arbitrary specific address (quic_v6_cmp_sk_addr() has the same rule for
> IPv6).
>
> On that branch quic_path_bind() returns 0 without ever going through
> quic_udp_sock_create() -> udp_sock_create() -> kernel_bind(), so
> __inet_bind()'s address ownership check (inet_addr_type() must be
> RTN_LOCAL/MULTICAST/BROADCAST unless IP_FREEBIND, ip_nonlocal_bind or
> CAP_NET_ADMIN) never runs, and paths->path[path].saddr keeps the
> unvalidated address:
>
>   process A: bind 0.0.0.0:P     -> quic_udp_sock_create(), tunnel sk is A=
NY
>   process B (same uid): bind <non-local addr>:P
>                                -> quic_udp_sock_lookup() matches the ANY =
sk
>                                -> quic_udp_sock_get(), return 0
>
> The same request would be rejected if no wildcard tunnel socket existed f=
or
> port P, since then udp_sock_create() would do the bind and validate the
> address.  Should the reuse branch validate the requested source address
> before accepting it?
>
False:

The source address to bind is validated by quic_get_user_addr() when the
quic_bind() socket API is added in the next patchset, including the
FREEBIND and sysctl_ip_nonlocal_bind checks.

> [ ... ]
>
> > +void quic_path_swap(struct quic_path_group *paths)
> > +{
> > +     struct quic_path path =3D paths->path[0];
> > +
> > +     paths->alt_probes =3D 0;
> > +     paths->alt_state =3D QUIC_PATH_ALT_SWAPPED;
> > +
> > +     /* Protect path[0] modifications with seqcount for RCU readers in
> > +      * quic_sock_lookup(). The seqcount allows readers to detect torn=
 reads
> > +      * during the non-atomic structure assignment.
> > +      */
> > +     local_bh_disable();
> > +     write_seqcount_begin(&paths->path_seq);
>
> [Severity: Medium]
> Is local_bh_disable() enough to open a write section on a bare seqcount_t=
?
>
> path_seq is declared as a plain counter in net/quic/path.h:
>
>         seqcount_t path_seq;      /* Protects path[0] during swap */
>
> so there is no associated write serialization lock, and
> write_seqcount_begin() expands to seqprop_assert(s), which for seqcount_t=
 is
> lockdep_assert_preemption_disabled().  On PREEMPT_RT
> __local_bh_disable_ip() only takes softirq_ctrl.lock and does
> migrate_disable(); it does not touch preempt_count():
>
>         kernel/softirq.c (CONFIG_PREEMPT_RT)
>         void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>         {
>                 ...
>                 local_lock(&softirq_ctrl.lock);
>                 ...
>         }
>
> Does that make write_seqcount_begin() warn on every path swap with lockde=
p
> enabled on PREEMPT_RT?
>
> The other half of the same point: the odd-sequence window becomes
> preemptible, and the reader added later in the series busy-waits on it:
>
>         do {
>                 seq =3D read_seqcount_begin(&paths->path_seq);
>                 ...
>         } while (read_seqcount_retry(&paths->path_seq, seq));
>
> Would preempt_disable_nested() around the write section, or declaring the
> counter as a seqcount_LOCKNAME_t associated with the socket lock, be a
> better fit here?
>
True:

I missed that local_bh_disable() does not disable preemption on PREEMPT_RT.
I'll add preempt_disable_nested(), which disables preemption on PREEMPT_RT.

Thanks.
