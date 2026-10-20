Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792466541;
	b=hGeZv0zOIfeqjlYZkyGqq+C4pEukfPkgE0N/QgsGL00/UKPMcEIdofFdgnDvwkR41IZG
	 kX+Cahs2yhBc3xhVGxNLfkhTdiN/FWiTUtcXbLIEkprzt6OOcGn7JuGngRT0xdNRY+0BX
	 FKpoSdvju2walydsylfHncOK5wQpEmWAeIjy8McUHmzjZsb/oI59WnivINHtgEn+Mu0cG
	 Hpvmd7pVeJuvjMVsNki+W5TWKCQRknJTNyKr7QiSra0V9CyDOl+Ut1Pc3VpUGd/52ZUTW
	 mZGj+PaPponhBL0wPXKbIQHNKtFylkTNtvaISwn5FltQCaa7V33RxZ4TmwRsPH/bUGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cY1kNjH6CTClFeYN/iyrgrNNHN+n4ge9oNe8/oefZ7k=;
	b=NW34FcTqn8dAZ5QWADQylOEQP8Jkdr8Y6fV643flEATeu6a6lanNP3xmOSwlm5EblaKi
	 i1TI47tOWWGsKC2oNfUz5XnrOh/PlHXf4W3bQk9+W5EfCYaIg2F2poOOA0CQC/sZd+5qv
	 z76j45EZm5hqilmxtZA/6BAx/Fj9+N9zs+HyjiwP3nJisXJw5DYNZ7fqIYPMryK8nOkrb
	 giXFkZu7S7bG68pcO0xmbDcpWf/9tUh0CTpQpEu7bRaPlQb487k3QqDU6sqtcIGGmM76p
	 V0yVCCGHx0IA8FQ2HzqT6mESOQqrHd4U6+NggaRAhrLfWit0pwISnV3glZDd+I79HlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yva2Ow7e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4979606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4979606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yva2Ow7e
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3ab490442ceso6036101fa.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792466539; cv=none;
        d=google.com; s=arc-20260327;
        b=HwiGGrnWtwi8lR0oF9+wl6urCA8Uftn9hc/G+vS6JbDcegflnrJ1m+BoFr9Z/JH4me
         WOShBSBRDwWI8PIWpHnz9AY8g1NG96uRb1R0ukvLhsWt97CCd6u292wpDu1WZCRxoavR
         zG9OH5SgxSq34RH4HnlomyPBKTrZgUxII52JvPi/YAqXalP/0CzRByVe/bQRgq2EYPVS
         GMsen4aEM5mEsfpJ5BmW93z6P9jNyt1KzuGVmdZPMlt8jyC2q6PZ6Pxx9BvPnWeKyii2
         T9GKcFKxr3YSkmArHifE+38vVGwNr5ceabV1+BXPFrC4un8pTXuvchL5us2zVixRF7ur
         sS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cY1kNjH6CTClFeYN/iyrgrNNHN+n4ge9oNe8/oefZ7k=;
        fh=UJBTEn0PfhHpbDM+grBb9+m+j1gA6Vse2w6U2Qwl93M=;
        b=cabCfBf3tPYJjRD+iY+5iLpegEyLC7jioFmAtGmDZ2o42XxQ+tf54/XAP3xv46OOEX
         KckTgDjYcMKjZjWL633DUCMmImmhlLoAr9EQVNl7hi9QciyxuJ1Xg84PCs1dh2n+jMAK
         lIBAgRdLhHGTPwfsxR9Nn1OrIswxeyqcr0qIQyJbhHXwXh+kLVv9mAuHRPgZEZtQoyrL
         yEuB6Z3zsPCYFTgkDhpPQm+lKYi+vuoXCI1SzSNNQ6dMjhJJ8gAb2guGwH00vv66+ScB
         fjNq6TxHcyp+cGMrksWdjTXSFyn+bv0xW/anuEkf75Wy06585GQqbyQXfvVglMlAfsbj
         DAyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466539; x=1793071339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cY1kNjH6CTClFeYN/iyrgrNNHN+n4ge9oNe8/oefZ7k=;
        b=Yva2Ow7eFb656UdLLGtRa+Q5PuufY3c2RKDcuH/JRnU4swzd8grEJLpk+D3swhFDWc
         6rszv6Mb5CEeudQY3pUkskXCda0kQZ3IhKNpIzZbQihzE97wCaS4X4zs4uWEhcUmaDwM
         pU8DowKPRrQmKoTifjrS+84ZGjvYS/Gcx6dimh2pG/p0BWbd7V3qdcz5iv5dUuKwqsde
         8+s1/75NYdSwgWS4tARMxzwWItnSkNV/y745wwCrlZgqBRuy6ECGpMupx4vIp9tEVJE/
         oyj3eP6NTUt8z+RuPmz3RF2CC+0xHr7LuJ+o4mBWLO9drmIEC6cSh3V6VWw5TfPkwkbU
         KdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466539; x=1793071339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cY1kNjH6CTClFeYN/iyrgrNNHN+n4ge9oNe8/oefZ7k=;
        b=2r9q/CAhoTAZI3d9oKLLdlWkQEsx6qnnHpg/eDQoyWenCNKgd+BR0VYJ875rvKe53D
         cGlLFlVVZwQrzK0barUFrmXCLgk9GRJ3uVDrOilK1pfby/7VeoVcjWIBXc6W8NI8YYbR
         33go4GjTC3VMJMmcHmWkAzqe2IIj1Tq9u0xlFMhAcJSzU0/tyeFYSyyulJaTPY7etnEs
         dECKZl1aZFeaE/zUwZEBRcwb/iFYQxmjnV1j1VsnGHuQPY7g+EBhzlgFwc8T/UD394Wk
         YADLKseYPKTUPV7OANV1TOwmGetcWr6tjybeqwNnxyAwpJO5lUsRi4Wr75yI6SqQeQUR
         /PDg==
X-Forwarded-Encrypted: i=1; AKwUvBxXLQWhbmfvMfl8jzCoZbLBPgUog7qPqM2L5RtziL3vqpYP2vn6Iyi6ujOyk/33O6cAFGF5pUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhdxeq460prFjK7LVLu4YRgMF6s+GRMPLjgJWW4lOxaOnHXctJ
	2/t08qXL5mjyHvGwjQYiTeVovJ0fDlalQV8zJo0I6ApQ+jky8+CbFEQq7agAqUcJPHWq68L2Yj0
	/xktQlM04GCK3aIHhg7nQImR0QD2R/OM=
X-Gm-Gg: AYBFou2HKYoFd5A3sdFRoBldM1csnNcB67PGLYIyc1tZze8rYro60o9i5jHkX646w7O
	n8G843IMaVF+ugh9klOTgRQdCghgc7be5CVO6ETmP38ZvoTYPeLt+pstP/mGeFCwsn+MbLoxKcr
	XVwl25jOaJ6zdnzAnrWjA8QbhT1sSqCGst/L8r1vhEit68E5YqYlWWr5yjLhpJI9p+2L4FiUbqV
	JbucYav/jOwSct118JR9jEXSHjYQiCU3eb+eX+LVRsAPYqWcv0tjeg/dazjbQdLJtVgZg4CLLMB
	khwirYw36cUOC6l+VsbRnXY9maqVz8I0NhbbalvwaO6tGpTACYy44saqax/SovUmGf0=
X-Received: by 2002:a2e:9a11:0:b0:3a9:9a2e:27fd with SMTP id
 38308e7fff4ca-3ab28e5546amr21208551fa.0.1792466538609; Mon, 19 Oct 2026
 20:22:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013023859.3075601-1-bsdhenrymartin@gmail.com> <179194560847.434549.7995246256511325364@kernel.org>
In-Reply-To: <179194560847.434549.7995246256511325364@kernel.org>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Tue, 20 Oct 2026 11:22:05 +0800
X-Gm-Features: AclHuK-wA6sU_5A6DS2WSUmad9ryl8AYp78MFW2aK-N7YXRESF26bZPc5GEv_lk
Message-ID: <CAEnQdOoE8J9KV7R0Gw-1Gg4-dnFKcUq4woX1nKKK9Nm0Ez1Uiw@mail.gmail.com>
Subject: Re: [PATCH net v2] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, nicolas.dichtel@6wind.com, 
	kees@kernel.org, i.maximets@ovn.org, leitao@debian.org, jlayton@kernel.org, 
	kexinsun@smail.nju.edu.cn, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, the Medium finding is legitimate.

The 64-bit claim in v2 is wrong: group IDs are allocated in
contiguous ranges first-fit (genl_allocate_reserve_groups()) and
genl_unregister_mc_groups() only clears bits without compacting, so
with ~59 free IDs against ~54 in-tree dynamic groups, an
unload/reload sequence can fragment the free space below the size a
multi-group family needs, grow mc_groups_longs past 1, and open the
same stale-bitmap overflow on 64-bit kernels with in-tree modules
only.  Only the privileged module (un)loading requirement is shared
with the 32-bit path.

v3 rewords the reachability paragraph accordingly (guard unchanged);
Cc: stable stays dropped per the earlier "no reproducer" verdict,
maintainers' call.

pw-bot: cr

Regards,
Henry

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=B8=89 10:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The code guard is correct.
>
> --
>
> netlink: fix out-of-bounds bitmap access clearing stale mc groups
>
> This patch adds a bounds check to netlink_update_socket_mc().  With it,
> __netlink_clear_multicast_users() no longer tests or clears bits past a
> socket's nlk->groups bitmap.  Sockets whose bitmap was sized before the
> multicast group table grew are skipped for groups beyond nlk->ngroups.
>
> > With in-tree families the overflow is only reachable on 32-bit
> > kernels: the ~54 dynamically allocated genl groups fit the initial
> > 64-bit bitmap on 64-bit kernels but exceed the 32-bit one, so the
> > table can grow there, and a later module unload then touches bits
> > past the bitmap of stale sockets.
>
> [Severity: Medium]
> The guard looks correct on every architecture.  Is the claim that only
> 32-bit kernels are affected accurate, though?
>
> genl_allocate_reserve_groups() in net/netlink/genetlink.c does a first-fi=
t
> search for a contiguous range.  It grows the table whenever that range en=
ds
> past the current capacity:
>
> net/netlink/genetlink.c:genl_allocate_reserve_groups() {
>     ...
>                 if (id + n_groups > mc_groups_longs * BITS_PER_LONG) {
>                         unsigned long new_longs =3D mc_groups_longs +
>                                                   BITS_TO_LONGS(n_groups)=
;
>     ...
> }
>
> genl_unregister_mc_groups() frees IDs with clear_bit(), and nothing
> compacts the remaining allocations.  So the number of live groups does no=
t
> limit the highest group ID.
>
> The initial bitmap also starts with five bits reserved:
>
> static unsigned long mc_group_start =3D 0x3 | BIT(GENL_ID_CTRL) |
>                                       BIT(GENL_ID_VFS_DQUOT) |
>                                       BIT(GENL_ID_PMCRAID);
>
> That leaves 59 free IDs on a 64-bit kernel, only about 5 more than the ~5=
4
> in-tree groups.
>
> With most in-tree families loaded, can an unload/reload sequence fragment
> the free space enough to force growth on 64-bit?  For example:
>
>   unload nl80211 (7 groups with CONFIG_NL80211_TESTMODE) and psample
>   load psample, which takes part of nl80211's old range
>   load nl80211, which no longer fits in any free 7-bit gap
>
> At that point id + n_groups > 64, mc_groups_longs becomes 2, and
> __netlink_change_ngroups() raises tbl->groups to 128.  Sockets that
> subscribed earlier still have nlk->ngroups =3D=3D 64 and an 8-byte bitmap=
.
>
> A later unload of nl80211 then reaches:
>
> genl_unregister_mc_groups()
>   __netlink_clear_multicast_users()
>     netlink_update_socket_mc()
>       test_bit(group - 1, nlk->groups)        /* bit 64 */
>       __assign_bit(group - 1, nlk->groups, 0)
>
> Without this patch, that would be an out-of-bounds access on a 64-bit
> kernel with only in-tree modules.
>
> The v2 notes say Cc: stable was dropped because of this reachability
> description.  Could this paragraph be reworded so backporters don't
> conclude that 64-bit kernels are unaffected?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261013023859.3075601-1-bsdhenrymartin%40gmail.com
