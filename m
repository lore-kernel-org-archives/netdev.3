Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793425581;
	b=KnU0tcGEt01oiRMv4OfyeIA+vmI5CRr/3tcYqc7VSWURppEqAxvEjEcNFdpA38iqRy+z
	 cSj1UydopLzpdbWmjn1HRNXNLa1X5zolJGroE4fdIaHr4Q4qhN4IXn++mb613ix8bduXN
	 waO+9Gia9f+YILuQHXmgFg1ImOsuvOGx0lkNYCrjoYaXKF12/ZXCQ/IjX5cFzMmjyO2P4
	 pPfOT4Pk4ptNY+UYCGRDoWpn8Vwp92qGyB2tfTYTg+ms+DZlYqqwqWuf0138ec3s3ucqH
	 /cJDQjs8mNgtKLQEmy4+vn5AajWaABc9pGzsXg+InNCxD6JE5jqjPYJ20bAwi3hVdUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793425581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=j5eFuw5dSBe3p5rkzIGZf40x6p9LO9b0fmbjNxDAM6Q=;
	b=cIOal7IyP7CNOLOP84i5og47pkxHdQ2wsE3BkiUOr7Zw55L8Bms5FzLXTS3Hi1MNcPF+
	 LiEZCSm9ZchHc3hvkLwsrtm0T3S/6bGTgxnVIgNpcZyKqX5e1ba83IymayQ1t/cVYUfDl
	 nmQC597gbYp0pFwkOwqRxNIMll1atC37E6bBPcJaREULr7Ltqf/vBIKtkZ5FmlRI/sCmJ
	 nglnuB+Y5JzyOLTDjp+PyYW3Nn+5i8kXklWwSKprOghZjtf934yX4Rb9OSzD7OKlhUo/0
	 dfBhlk1ms9kazrdvx5PGSqMU93g3MbLX/ZJCQ54gj4Qnaz0gkNT9AtTDA/WzQHTh96A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzjXr6A5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C27606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 05:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C27606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzjXr6A5
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so1860059e87.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793425579; cv=none;
        d=google.com; s=arc-20260327;
        b=cPVydAC1eS6hboouf91Bwe3oNhu5DexEvWDNqBTURHRzfrt90nM+BixXnhdF3OZK04
         pY401KUWWLDz9A5rnGGNWGXqAdtMmzxB0e6OhnrqIEJY1AHEPH6vigLYZFUS3x762bWE
         MHqO1rzkWxbJN9dRFgIKvDih0Z28cj6xvU9CzWzolQH9eB63iorvokkahw395fpev9yp
         K1bZNM7YkgxHUp/f5V/jcAzpWiJj/D6Zzk3JFIDcXxz6xC6sAap1Ue3G4RMJ9X+vfWDS
         mXAIgF33YbQv3modtp4D8Qk5AsnGIGnjT2KeVTtrVvA4rRtBA15gOVU/AHAeWntejAAP
         cufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5eFuw5dSBe3p5rkzIGZf40x6p9LO9b0fmbjNxDAM6Q=;
        fh=r0LXpMu9xfOFipgtCv77cSYONoU+9dxXcl79TWxeDCM=;
        b=VgfSc1Q7rIsNchVpjVR+U5aNAq2+hsnVdltMmbN/pzD+32geA8iuVqeu966BLy2ssn
         R10/472Nci6w6+d8JhsUv0i0ipO9ZPiRuyyCRFL3pNQkIowTPcWTVWf+tuIBU0Yukrlh
         fzjsYB0+4tgiqel/CcCaUvefrGdnwkEUvL1gCel2v3jvJELn476j/TA43bUK4MMRSonU
         LOx8HVPzhE3idyXmUczIT67quVGQ0b0fkhcihfuMF/Qz84Wf1rchAtv3l3AJhyqt7BN3
         sxzBy4HFxftDkcc6CaqEtlm3HgPF5/U8P4uUo0ept/OEcQQMpvrpD5T3GcizNP1D1ujp
         CAUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793425579; x=1794030379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5eFuw5dSBe3p5rkzIGZf40x6p9LO9b0fmbjNxDAM6Q=;
        b=WzjXr6A5EssuO994W0bNfs4J2f2TvDG3e5OPHp4zHJaGHS/dhuhBOQxeP0woukH6w7
         9jydHAQngtjrH+nqq/pvT0KL4krZoi10rO/6BgH84LIjsxid4PUalzAI8UWpDXLyhmNs
         acGySq3LMWkPQHjZEBmfoNpxUvCJHwRXquyxHQqwlNT2m/2PSm3yiYy54RrgGS7umeet
         ZQc+cRT+ucGURADuIULNDnOeP24SoRTNCVEVrUKdoiAu61+3T+WtjIJNEFKv5Dw/3qlY
         QEcsXJArtAs5ojO9NGn+2YJMCbXGsdRrK7XTdq9fYrxGyU38lIhV+tduaXWvcZn9uDpX
         54lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793425579; x=1794030379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5eFuw5dSBe3p5rkzIGZf40x6p9LO9b0fmbjNxDAM6Q=;
        b=vLQvN0JrWvt43OxCsZO+GPYR56ZtEJ4AqeJkLFK27C4kGcDZfltuA0fjzNwIlUAMhF
         vdlciGITIL1wVDBf6ofHSwg9LK2N5lbBnPrNCT7pJC4ZZ57z+ddOc3NXU00xybPj1Ovu
         NFsS3RMranHjQCw4chxHyNPbBAbj4pAR2/EMiBEGB7faSy6RWU2dZhCnZhlBlE7HaA0P
         Zu5a4tAx8GcpnxMisSNFmoDnVH/Ic8FUtY0lM8TlSKrYGXTq+pYPvuQtvFrvkziBTg31
         Mkl9pjUNpHm1GzY+fRitpyiCe1YJjv/x7izPYpVjqXVwSI8vVJPGd61AaZL5MCtsnR37
         33nw==
X-Gm-Message-State: AFq9FYLcglruAwX1Jkcw5kfbQ73NfvbjbJe8hVIlzF6w1bJQFTtLyYUZ
	VqrtA/x4CD8dgWJHL02YOegLucwbJBWxSpfVeUHahk3lEkYEYUZrlztL+J6VF2DPs4qCeZUr/Cn
	mnTJuTpMS/W0eEMn5igYlcDGp0t+KJCg=
X-Gm-Gg: AYBFou3Aa8volWBS1SuFs1k90lUNEO+cXCDHBh/14kZBTx74MidDoJLxTuRfKm+J/Ot
	wDekugEM6nQqp8N3FPBz9WPzachhGIfrflundyLyvdPiNaKhrN3uYjiQB6eIoCra7L62IfjsA+3
	Ua/be9xzCmGMj780VXrxYGxJZIe40i2f1BdLWQGYh8mZB1blbxRFA6DpHJ7TmLU/1bal0AXDVVK
	AGhIxO28Nng8RyU/CU3SqffCeoN2ltn5yl7g9VrJsO2tsSoRo+O+Np9nWZWQo7S0gW1tUqiVmIg
	oun6ziB+5l18rSxKq6dgSe8xVSqzb9kqtG06y1TYl8kN+RZQ8nkXO3eR22B1HJZE88nLJvpoRPp
	vUI+tuQjAjChB/rnALyZAJpi4C8lbm5F4fKpB
X-Received: by 2002:a05:6512:1050:b0:5bf:d189:9e62 with SMTP id
 2adb3069b0e04-5bfd958ddafmr1500570e87.54.1793425578921; Fri, 30 Oct 2026
 22:46:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029062214.3407223-1-anilkaushikwireless@gmail.com> <179340003139.3131.11274717768928642724@kernel.org>
In-Reply-To: <179340003139.3131.11274717768928642724@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Sat, 31 Oct 2026 11:16:07 +0530
X-Gm-Features: AclHuK9xBmY8I8Gu_dRZTmuh3Gi9P3Qwr4-iPGqbwgY4aeTzBzCleg55CSQtfMA
Message-ID: <CAG0Mgm_kyXA43dLYbihf_KGk4Y33u-nog9FE5Cp6DgfApMJ05Q@mail.gmail.com>
Subject: Re: [PATCH net] genetlink: Reject joining multicast groups no family owns
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, 
	nicolas.dichtel@6wind.com, v3rdant.xiang@gmail.com, aliceryhl@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 4:10=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is incomplete because of a check-then-use race.
>
> --
>
Yes I agree. genl_bind() drops cb_lock before the membership bit is set, so=
 an
unregister in that window leaves the socket in a group ID no family owns.
v2 will add a patch that clears the members of the group IDs when a
family is given them, as suggested.
pw-bot: cr

> genetlink: Reject joining multicast groups no family owns
>
> This patch makes genl_bind() return -ENOENT when no registered family
> owns the requested multicast group ID. Before the patch such joins
> succeeded. If a family with GENL_MCAST_CAP_* flags was later given that
> ID, the socket stayed a member.
>
> Link: https://lore.kernel.org/netdev/179324692107.3134.144436898926079213=
37@kernel.org/
>
> > diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> > index 5cc1037d4917e..f038f04ef4ead 100644
> > --- a/net/netlink/genetlink.c
> > +++ b/net/netlink/genetlink.c
> > @@ -1825,7 +1825,7 @@ static int genl_bind(struct net *net, int group)
> >  {
> >       const struct genl_family *family;
> >       unsigned int id;
> > -     int ret =3D 0;
> > +     int ret =3D -ENOENT;
> >
> >       down_read(&cb_lock);
> >
> > @@ -1841,6 +1841,7 @@ static int genl_bind(struct net *net, int group)
> >                       continue;
> >
> >               grp =3D &family->mcgrps[i];
> > +             ret =3D 0;
> >               if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
> >                   !ns_capable(net->user_ns, CAP_NET_ADMIN))
> >                       ret =3D -EPERM;
>
> [Severity: High]
> Does this fully close the case described in the commit message?
>
> genl_bind() checks ownership and the GENL_MCAST_CAP_* flags under
> down_read(&cb_lock). It drops the lock before it returns. The caller
> sets the membership bit only afterwards:
>
> net/netlink/af_netlink.c:netlink_setsockopt() {
>     ...
>                 if (optname =3D=3D NETLINK_ADD_MEMBERSHIP && nlk->netlink=
_bind) {
>                         err =3D nlk->netlink_bind(sock_net(sk), val);
>                         if (err)
>                                 return err;
>                 }
>                 netlink_table_grab();
>                 netlink_update_socket_mc(nlk, val,
>                                          optname =3D=3D NETLINK_ADD_MEMBE=
RSHIP);
>                 netlink_table_ungrab();
>     ...
> }
>
> netlink_bind() follows the same pattern. It updates nlk->groups[0] under
> netlink_table_grab() after genl_bind() has returned.
>
> The owning family can be unregistered inside that window, for example by
> a module unload or by a module init that fails after
> genl_register_family(). Can the following sequence happen?
>
> CPU1 (unprivileged)                  CPU2
> netlink_setsockopt(ADD_MEMBERSHIP, G)
>   genl_bind()
>     down_read(&cb_lock)
>     family F owns G, no caps, ret =3D 0
>     up_read(&cb_lock)
>                                      genl_unregister_family(F)
>                                        down_write(&cb_lock)
>                                        genl_unregister_mc_groups()
>                                          __netlink_clear_multicast_users(=
)
>                                            (CPU1 not a member yet)
>                                          clear_bit(G, mc_groups)
>                                        idr_remove()
>   netlink_table_grab()
>   netlink_update_socket_mc(nlk, G, 1)
>
> After this sequence the socket is a member of a group ID that no family
> owns.
>
> Later, genl_register_family()->genl_validate_assign_mc_groups()->
> genl_allocate_reserve_groups() can give G to a family whose group has
> GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN, such as psample,
> mptcp pm, ioam6 or cifs. Nothing clears the existing members of G at
> that point. do_one_broadcast() delivers based only on the membership
> bit. The CTRL_CMD_GETFAMILY->request_module() autoload path from the
> commit message could still trigger that registration.
>
> That is the end state the commit message says is fixed:
>
>   "A family registered later can get that ID, and the socket stays a
>   member: nothing checks it again."
>
> Would it be more robust to clear existing members of newly assigned
> group IDs in genl_validate_assign_mc_groups()? That could run under
> netlink_table_grab(), the same way genl_unregister_mc_groups() clears
> them on removal. It would cover both the original case and this race,
> instead of relying on the check in genl_bind().
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029062214.3407223-1-anilkaushikwireless%40gmail.com
