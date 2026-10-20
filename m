Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792531994;
	b=fPnYbNozpDK2pc2CNjY/cz+x3vJw7R2iTGnz4nsWHGd5Z/rYyoEsWHJoVNOY6liiN98w
	 DPu8AFa+KkBxIuPLtJ7McGi3zXJ9EE+vp+XWVWAsy5vi9GJcxiaKhfOgRT2aPqaMejxC3
	 sxMFBBgJpHJCazDFeL6YogmtJ4bpzqZ4iIQA6FvmFR9+yVkVqmeQmOy/K7ojZHKammnsI
	 aPFHoqBDPHwCxwCPk7lm7oEm0ZNDD8OINHOPRzzQBPQ122zNnSC6tdLYcXPJwEfGNrY30
	 kXNb5Fknper1WT4TpZtsWjwlNpR/9XNVtDFvGBrr5QtRSpgqjFIa7QKls7SzxyTOOpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2AgfGA8Z+ldUgBgGgA9RrGOTzaa/n9KB7xtFx5qm7gA=;
	b=OC21Sfn5h46SC5hGPU5w0Dgde/U3QwvF0XuFQR6+iPFbi6CQhwFOn07jcucVMchL6ppV
	 P+edP9XjBiQHCa9jYRoFiyV1+SMJs9zfaTQ6EqaZLli9xy3nqeCV00yU+D8BCLOOeuF5V
	 5XVO708sRF0s30JMLJ3i0A/NXfetDTOmgX9SXJQRgiQrYQOj41LkIWhMnIhiTj1zvr2mZ
	 VuYh3vHvaJO/mR169lHV1B9+uizoi8kb4tumT1yE/dhmrZe8NkmTNX7vN7oymM/fpgZBF
	 31HeTi+OrJ7F1zR02ULlv+QbO4jt1CitoaKc3RU/uHZthZ/j4q5NA2L8akC+gSwb+Hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PstJMPG1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBB606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63FBB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PstJMPG1
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a01cac8733so39866b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792531994; cv=none;
        d=google.com; s=arc-20260327;
        b=g3iWf0ny6fUuX3l//brld/nGFZKHS0mJnr8067BN+uyXzWsZynMdiSx6v9HHs/oDQY
         9cAgxop8oUZHOV4TBzK6rVc4e5Udw3qBV2780IRHGURWfzn6caEyjqK1Hd9XmN5LPEvC
         E63I0fXY87PdhtyCLBLl7/E8mhB+7IKi5d2yeBrfdWBNJFXsk0TNUfSFo79tmSUuxahM
         wvW0SPHUK6TJCQRhQ8b3QiEHgP8Um5HRoLbmrwEUedFgzsFOQVoh6uYWh3ACR5FWjDmv
         l7HoEpmQxlFeMk938cBdIVLC8tVkWLuC4jZXLDe8HeRKmlOvXK6Ar00m/PRofgxaTf6z
         pzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2AgfGA8Z+ldUgBgGgA9RrGOTzaa/n9KB7xtFx5qm7gA=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=E3OWUQycvGwKuftY/+AVgKa/1ZKrLS3leEyfK8PH1sVaWJPVQLB2ybTxJit9UazBHI
         hxFkgog9viUqoPvWi6xxrB8oKRvw27RF749b9vH7V1q2kycadrnOZvSV+2XD5ihbbw3h
         OAFVfQsgkTkPVoYoTqXHbaD/eidp1UYh9vKvvejVJmIjYL+Iz6dGgKGjYkatpsSqGBND
         5jGYqRS10s5tbjUE1OdDUHb27mXo/7rQUXko2JpWRNxDjhSYopv9GBZ3cGaSA6aHjpoH
         nxrgzD9Rv9NUufrNn0cDxnTgcMI+eCd5iGAZNZe5mfPVlY6azz/CxSYygNu51EXYk0a/
         PwdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792531994; x=1793136794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2AgfGA8Z+ldUgBgGgA9RrGOTzaa/n9KB7xtFx5qm7gA=;
        b=PstJMPG1RCu9TauBU0uB7KK9t8qQe8psNqbqWWlhVLK54wLJTJnY2a5ocHf2B1+BaY
         j1MoWGReMJHIxTj5NvHLrvWc/33+wXPz0yI3rZZbnOys9hb29EhmglXVTFnWaV7CxVUD
         jAclk5I4DRiymGDTXibLowpbsasxuYt3ijZWKNluS3euv6k3YwbrcBj24NKlKhtd50ft
         jXGFc4/Px99ALtZ3Jsksflt/E1jlhhehC45+VuYSPyVRaynzqYfkk2t3F8HBKrrE6zA6
         UEP61voehlpy2YEWIv4qOpVUkjOlQrM+18YSmELM+ImFQEljc83HQhYJDImCsC5LoHuR
         yxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792531994; x=1793136794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AgfGA8Z+ldUgBgGgA9RrGOTzaa/n9KB7xtFx5qm7gA=;
        b=1n25l+HspDzKFYXkzmd2NMmK2H28jZNJM052jIkijTcGm7HkB5xWczo58BGE2TWhox
         QUwq7ZuEzuWS/RFsXvnL6JnlOPyvnkBW7o2Z3eQMxYtac3BKvh/uZC7NqYVF/kywDaNY
         rwSzP9LVHQ4xdnVjeJLUme17Hs+8t1/Sb72SMTJqcnyYsHNfhML1Obqn115SLohGM72M
         4lruSdnbWDwS9JOk8hww211t6ZXAkfMjd4xL4y8ufrV5ElpbgGzuvsibV4XKORoy81Bv
         dQ824/+/8O9dFblpBZ++GXXB6VoqcrLgSSZvTqH1twinhLB9+cpikVgGjBvZHxjIiygW
         fVxA==
X-Gm-Message-State: AFq9FYLuXEY5y4CNqJRWjjBuN4HAasxXsD1XI/jLMoOLN7rzLf0eckIL
	CJ0xnhhtmFfwu7Pmbp8BnB7BMiF4/EPvEm/cN7XeYFpmmrTf+17cuAzCY13cMSiBA7jGmmHCK5Z
	sHZvDvR6SIuD379Ell1nnhP/AZq7C76k=
X-Gm-Gg: AYBFou3pSxsBFgb2tfV1yhRYGnj0WOJzf8e91nHpCND/0ZJ2X0ob5/MfBHPPbAle6H7
	1ngh51T5Emwqxb7hCXQJzau93oknWfeNDWePUpqAPv4ZVpij7YmkbwkQpOlm9/ibuw6zOkqCO6B
	C471+a1wJGub2Y/+yMZ6ZZSiE4lRwBy8Q7aQxy5ndGe7con4h45lqW700y0GJZr0vx24aJ4KJPi
	dWQ1LfwCa7LslIBSfxu9fAUr+e+dLrDco4M2fVq/cng5eAs+Pw8UD72d5ljKWDjNhiwAmZJkin8
	36mzr4PjHyBXPNw5JY0tzTAb2+stkeGnSkAqFdkQEMqbxO9ek7HPwQm3jCus9I1JFgFcQD6k3Km
	7hxmlpvNlcaZNyFPfveoKqsi1VD5BUR8fv/dNgVH1AUgrWT1+mTY1MbtFZEx38VGMqKNdEec6EK
	0EsGT241+zaO8r
X-Received: by 2002:a05:6a00:a0c:b0:89e:779b:d0f with SMTP id
 d2e1a72fcca58-8a089dfdbb8mr140032b3a.37.1792531993626; Tue, 20 Oct 2026
 14:33:13 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ae36949f7685ef74318d3c742f02e1398db3b454.1792164438.git.lucien.xin@gmail.com>
 <179244539859.3135.15973054396060254186@kernel.org>
In-Reply-To: <179244539859.3135.15973054396060254186@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Oct 2026 17:33:00 -0400
X-Gm-Features: AclHuK-OS8Rlsq-Vf92z9Ck0SMvPAMUJ9Zd-S0XjwZRWioNbmezgdXlvGsvI2pg
Message-ID: <CADvbK_en5dm-psb_eXs26y1bYTNq8_76eHv6ZWX_FbcSPjv8Zg@mail.gmail.com>
Subject: Re: [PATCH net-next v17 08/15] quic: add path management
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
	mef@scarletmail.rutgers.edu, paul@jakma.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 5:30=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] quic_udp_sock_create() in net/quic/path.c zero-initializes
>   udp_conf and fills it with quic_udp_conf_init() ->=E2=80=A6
> - [Medium] IP_FREEBIND (and the IPv6 equivalent) set on a QUIC socket has
>   no effect when a new UDP tunnel socket is created.
>
> --
>
> quic: add path management
>
> This adds struct quic_path_group and struct quic_path to manage the
> active and alternate paths of a QUIC connection. Each path is bound to a
> kernel UDP tunnel socket, which can be shared and is tracked in a
> per-port hash table. The patch also adds bind, unbind and swap helpers,
> alternate path detection for migration, and basic PLPMTUD state handling.
>
> > diff --git a/net/quic/path.c b/net/quic/path.c
> > new file mode 100644
> > index 0000000000000..ba7e2c952a36a
> > --- /dev/null
> > +++ b/net/quic/path.c
> > @@ -0,0 +1,596 @@
>
> [ ... ]
>
> > +static struct quic_udp_sock *quic_udp_sock_create(struct sock *sk,
> > +                                               union quic_addr *a)
> > +{
> > +     struct udp_tunnel_sock_cfg tuncfg =3D {};
> > +     struct udp_port_cfg udp_conf =3D {};
> > +     struct net *net =3D sock_net(sk);
> > +     struct quic_uhash_head *head;
> > +     struct quic_udp_sock *us;
> > +     struct socket *sock;
> > +     int err;
> > +
> > +     us =3D kmalloc_obj(*us);
> > +     if (!us)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     quic_udp_conf_init(sk, &udp_conf, a);
>
> [Severity: Medium]
> Should the tunnel socket take its IPV6_V6ONLY setting from the QUIC
> socket that owns it?
>
> quic_udp_conf_init()->quic_v6_udp_conf_init() fills in the family,
> address, port, checksum flags and bind_ifindex. It never sets
> conf->ipv6_v6only:
>
> net/quic/family.c:quic_v6_udp_conf_init() {
>         conf->family =3D AF_INET6;
>         conf->local_ip6 =3D a->v6.sin6_addr;
>         conf->local_udp_port =3D a->v6.sin6_port;
>         conf->use_udp6_rx_checksums =3D true;
>         conf->use_udp6_tx_checksums =3D true;
>         conf->bind_ifindex =3D quic_get_dev_if(sk, a);
> }
>
> udp_sock_create6() applies v6only only when the config asks for it:
>
> net/ipv6/ip6_udp_tunnel.c:udp_sock_create6() {
>     ...
>         if (cfg->ipv6_v6only) {
>                 err =3D ip6_sock_set_v6only(sock->sk);
>     ...
> }
>
> As a result, the kernel UDP socket always gets the net.ipv6.bindv6only
> default. An IPV6_V6ONLY value set on the QUIC socket through
> quic_setsockopt()->ipv6_setsockopt() is ignored. A zero cfg value also
> can't clear an inherited bindv6only=3D1.
>
> With bindv6only=3D0, could an IPV6_V6ONLY QUIC socket bound to [::]:P get=
 a
> dual-stack tunnel? That tunnel would also hold IPv4 port P and could
> cause unexpected EADDRINUSE for IPv4 binds.
>
> With bindv6only=3D1, a QUIC socket that cleared IPV6_V6ONLY gets a v6-onl=
y
> tunnel, and IPv4 UDP lookup skips ipv6_only sockets. Would IPv4 packets
> for that dual-stack QUIC socket ever be delivered?
>
> quic_udp_sock_lookup() also decides sharing through
> quic_cmp_sk_addr(us->sk, ...), which checks ipv6_only_sock() on the
> tunnel socket. A wrong v6only state would therefore also change which
> QUIC sockets end up sharing a tunnel.
>
> quic_path_bind() has no caller yet in this series, so this would only
> show up once quic_bind() is wired in by the next patchset.
>
False.

This is on purpose, as two quic socket may share the same lower
udp tunnel socket, we try to make the lower :: bind udp socket always
with bindv6only =3D 0 (unless net.ipv6.bindv6only =3D 1), so that two socke=
ts:

- bind(sk1, ::, 1234, ALPN=3D'h3', bindv6only =3D 1)
- bind(sk2, ::, 1234, ALPN=3D'smbd', bindv6only =3D 0)

can co-exist, the bindv6only check will be performed on the quic
socket layer like when looking up the listen socket.

if the tunnel socket takes its IPV6_V6ONLY setting from the QUIC,
the sk2 will never accept IPv4 requests.

> > +     err =3D udp_sock_create(net, &udp_conf, &sock);
>
> [Severity: Medium]
> Is IP_FREEBIND (or its IPv6 equivalent) on the QUIC socket honoured
> when a new tunnel socket is created here?
>
> struct udp_port_cfg has no freebind or transparent field.
> udp_sock_create4() and udp_sock_create6() call kernel_bind() right after
> sock_create_kern(), so FREEBIND can never be set on the new socket
> before it is bound:
>
> net/ipv6/ip6_udp_tunnel.c:udp_sock_create6() {
>         err =3D sock_create_kern(net, AF_INET6, SOCK_DGRAM, 0, &sock);
>     ...
>         err =3D kernel_bind(sock, (struct sockaddr_unsized *)&udp6_addr,
>                           sizeof(udp6_addr));
>     ...
> }
>
> The bind path then calls inet_addr_valid_or_nonlocal() on the new tunnel
> socket. That socket doesn't have FREEBIND set, so a nonlocal source
> address would fail with -EADDRNOTAVAIL.
>
> The QUIC socket accepts IP_FREEBIND through
> quic_common_setsockopt()->ip_setsockopt(). quic_get_user_addr() in the
> next patchset is described as honouring FREEBIND. Could bind validation
> then accept the address, only for
> quic_path_bind()->quic_udp_sock_create() to reject it?
>
> It looks like only the netns-wide ip_nonlocal_bind sysctl would make a
> nonlocal bind work here.
>
False.

quic_get_user_addr() will be called to handle IP_FREEBIND for user
addresses in quic_bind/quic_connect/quic_sock_connection_migrate
in the next patchset.

Thanks.

> > +     if (err) {
> > +             pr_debug("%s: failed to create udp sock\n", __func__);
> > +             kfree(us);
> > +             return ERR_PTR(err);
> > +     }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1792164438.git.lucien.xin%40gmail.com
