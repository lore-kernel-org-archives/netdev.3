Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605397;
	b=D5VaAMnOjKO/ZpoCS/MEPokwgb6KLPr9n9Use2CUtBjzYr3XVeiAz5QW7FiNV3PtJ9M9
	 cfEVw/m8tqeyYrARf341/D1Q21DoggVTne8fWwU7xDz14/HPLpqXZ/PGb5RnxEzz7kuSQ
	 s+iL+him4jPHJeoNXP9wE0gMmkUoTYdYH5dAt6c4uZR8+xZHjodrbG8milE0sdztFopjM
	 adx68maxnuKwMMK9I/qoUV4AEojkI14dpQAX7pMQa/MVrRto0oiM/hQHpsJjbg8wi1PSf
	 Wc1NTJFW0bqFEMaFba2uOXZLtTVG7D7W4x5tnDcjNcOJUxor75yLzEpgMeH+jcTkZ6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
	b=5Ap+b9FDXuHs/1GLXbCVKJ+6t8z0rdibS38D2ZGBmPxTWjlz2GLhsBYoWHqP4W8KVWc4
	 0BoRDw+7JY6kHwph4O7seFvDiTgDhd+ks8OE0+0IHdFNYleC9AdDnNuQ8obGsWr2FHY/5
	 YrlfTghRPS3lygmWapM23EybqQMVekKo1JSh2pbACRA+ef5KiNYyUI7FluLC0DqaJ91I1
	 QNdVqp2KxSJvdBCS6/zCKXYARmxOd/QBi4O5IQ/i+05D8qu2A63KiAUFt9zGYr0OjFPWU
	 4op47QWsACXxuoy9NSHAnCCql46p76zL+V9+S0rHdkoy0bXjiiHuZnYbVixDHDGiAWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="XjnGAW/l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA0606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAEA0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XjnGAW/l
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so905736a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605396; cv=none;
        d=google.com; s=arc-20260327;
        b=S3RVSAeOazQ63llLsnMfjQ3vYBDyOpy7uOsqxEKo9GEyAifoseifq5HWoaB5dDWAiG
         cf7g+zFvyrTrhS7eNs7+Yvt+GVKOk8xuhsOAVJXiBd2rKkt/aANnpJEQZ0JL3XETYlv5
         +0qL8KImg3r3F6VyvRckRDahOKPC0MindcxVoJQrgLsf0XJ6WHWBLrNehTYcnT37Uu+t
         FOeAvySXbk99jf72Gg8oQBjFyOAISso/Lf5wJ+3Jriq0GP0W0HKchWlgb2E2RwsbWcGL
         z688u1coAeO8v+Zq/mJz/2Jx7dJX6a+f9SILtwvN3chhhOZPD9SzT6ynxKsXHvhUAGXS
         vTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
        fh=yJQ89xxk265yyqFXXu03G5MauZwTPPDmHL+NaqRKNl8=;
        b=YGX4/S0rfsCrWnz5IhcQzwa7O0646bSzv+MLKaSiLiXkqD4YkySxyEx7UANWlydtAb
         Pu5ZRVK91MLRQoh4mtgLk174rtkkH3937fS8NjhzU3erxMvuJqhdsTtEiKLcqEn3q9Wc
         t6C89yHlD7kvEA/Drn3Na7YltSZ1eP6olPFiGmvKkr7BWGrthZ1Ol2CnHbirXcAtg2Db
         Eoy3biqltEmcjAYZ+OkKFVYDvfPkP4/ZWGItp+QfCyO0VGA6PoPmz9XZDQAJEOIuozvl
         b/WPGXda7WMmgHE3N0UyzcDSvje4QHxoprzjgQK633jh4uYI5SI75yCt7OXAtNdWbYIx
         7yQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605396; x=1793210196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
        b=XjnGAW/lkqm11P0pMYijUpYq1oonr3mzQR4L5QXOUAKweJaJXolhjXgl0KiSNwUi3u
         RigAv+W5Q8JG8RSqBUZlwXm4QcaPSV25TJ0AY6NLXHBARGVhtc8DXc37Ve1Smjo+7BM/
         01pl/MPiu96OcvAljgHXE118771IPEAInsahOEQsONtETRODdd6gWJ5te20jZIGCnXd+
         1Fx4HrqZ8EWJEFjeW5Vk6vd/JvnLa8QmzUjHxXgNVaSIz1j1RlLQYsoIRAzzdUb2mBnS
         k0CkLW/aKowrDvCZpFU7mOYD5SRfQDVvohVauRNK7tN8aPLO7l+y2gBAS2NapsnO2Uz+
         3PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605396; x=1793210196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbBlG9dBV9dQwd61zkZiG/rhXlHvnLvyJTnTn4Xv1Ho=;
        b=rzOMs83gKDLOY5sVEJ90aKtgEFOUeDy1s8EslrVR4+tSeQ54PU6VfkvAULfJjANyXp
         kUV7BlKsreDjs4+z7WaALNSjqv+hcbSKoezZk+UIqlquzOySsnRMUidP++KstJaisuG1
         /qHoUQb4t4dZJFLpwDhtd4H+FWpBeCQBc7pVIlEQfUBJJuV+4fLR0N+qtObKXeBUtH/Y
         1UuQBb/h57bVrjoISQWxc2BXd1pMAz27OV1c53LLknFzghuOjqV7S3flWCQSlldzZfgw
         kX0DkbEKTUqd/7Zh01Xmb2sgDwQOIdlvRLH4w/WF8eeq6FxOA1Qiyhq+YCPLGAiLkcmU
         l+GA==
X-Forwarded-Encrypted: i=1; AKwUvBwiTI4MAV9uvkpU1fQuDxUnn4HDhOjrmn+eCCsKb8rHwPEfoylvWpXjOdLMXHckmf90ZbrIMww=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTXrc1LUnuoDrZBJFsa12CuQVExEIEPF1qLLKkWujpaGiIaGlb
	osGxcuEY4zEhyv6P0LLv8jc30KebDBOc08xwJc4bLZ50eQMJkAffRoXxMNOYZLwU4J/2Yc/n3ns
	TYim3BT8yzzD0bVg2E1MI3keNB6+g68E=
X-Gm-Gg: AYBFou05MPb/ajk707jMzZc+X6AQNZ0JIAq4ZVoWkhnicTpggufWevl8fcS3c6aXLKN
	EQCgKp/ek6qd6KIpc7WfISj0QCnBUlI+rFNHZ/HfWLLdZrg+SzwSqxYCf1DKh2Lv7enzfK072rA
	+17Hw50t0aL0Avj54azT629QYG2vV/fAVyKruwuQbY3Rl2J43k4ADDEYsKDOXPzPJllJGFv6C9j
	9rUPdV2aq3tRI8KTHVgS8kvxP21pDo4FcGk1PDQN1P5weDQ1ad2QYrBNkvctiHovAmSNO/d7F4J
	glxE/W2s1bxvJtCz/acvM0fN1CaClrn3erliVFCdXPzzHi5aQJDyJclPmvnTiKrIvfrhw2yAuyG
	a9ziMy3jBVmdFm7jzSNfJqd368SjXlnzB3ReS1lM93zBMkisUyODgll/4Nhl7DxWmdkv1/oCWka
	sjNl/KyOPcM4atblTEssuXd3cCAw48DLldZie5cPo=
X-Received: by 2002:a17:90b:4a48:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3ad870a090emr2485173a91.57.1792605396207; Wed, 21 Oct 2026
 10:56:36 -0700 (PDT)
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
In-Reply-To: <20261020155848.75711-2-mahe.tardy@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 10:56:23 -0700
X-Gm-Features: AclHuK_Gjd_0JETWrWSuRV1IbMqYcY07rIIqTjIYhd9Ry3rga3lnZ6YW-KgPkzM
Message-ID: <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 8:59=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> The motivation is to plumb more of the socket API into ksock, thus
> supporting sendto() in addition to send() which makes a lot of sense in
> the context of UDP sockets which are the only type currently supported.
> This is useful when ksock is used to reply to specific addresses or send
> to multiple addresses.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 27 deletions(-)
>
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> index 48a2e2327ace..37168f43c16c 100644
> --- a/net/core/bpf_ksock.c
> +++ b/net/core/bpf_ksock.c
> @@ -37,6 +37,49 @@ static void ksock_release_work_fn(struct work_struct *=
work)
>         kfree(ks);
>  }
>
> +static int bpf_ksock_addr_to_sockaddr(const union bpf_ksock_addr *addr,
> +                                     u32 addr_sz, struct sockaddr_storag=
e *sa)
> +{
> +       if (!addr || addr_sz !=3D sizeof(*addr))
> +               return -EINVAL;
> +
> +       /* Kfunc memory arguments may be unaligned. */
> +       memcpy(sa, addr, sizeof(*addr));
> +
> +       switch (sa->ss_family) {
> +       case AF_INET:
> +               return sizeof(struct sockaddr_in);
> +       case AF_INET6:
> +               return sizeof(struct sockaddr_in6);
> +       default:
> +               return -EAFNOSUPPORT;
> +       }
> +}
> +
> +static int ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data=
_sz,
> +                       const union bpf_ksock_addr *addr, u32 addr_sz)
> +{
> +       struct sockaddr_storage sa;
> +       struct msghdr msg =3D {
> +               .msg_flags =3D MSG_DONTWAIT,
> +       };
> +       struct kvec iov =3D {
> +               .iov_base =3D (void *)data,
> +               .iov_len =3D data_sz,
> +       };
> +       int addrlen;
> +
> +       if (addr) {
> +               addrlen =3D bpf_ksock_addr_to_sockaddr(addr, addr_sz, &sa=
);
> +               if (addrlen < 0)
> +                       return addrlen;
> +               msg.msg_name =3D &sa;
> +               msg.msg_namelen =3D addrlen;
> +       }
> +
> +       return kernel_sendmsg(ks->sock, &msg, &iov, 1, data_sz);
> +}
> +
>  __bpf_kfunc_start_defs();
>
>  /**
> @@ -155,22 +198,9 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *=
ks,
>         struct sockaddr_storage sa;
>         int addrlen;
>
> -       if (!addr || addr__sz !=3D sizeof(*addr))
> -               return -EINVAL;
> -
> -       /* Kfunc memory arguments may be unaligned. */
> -       memcpy(&sa, addr, sizeof(*addr));
> -
> -       switch (sa.ss_family) {
> -       case AF_INET:
> -               addrlen =3D sizeof(struct sockaddr_in);
> -               break;
> -       case AF_INET6:
> -               addrlen =3D sizeof(struct sockaddr_in6);
> -               break;
> -       default:
> -               return -EAFNOSUPPORT;
> -       }
> +       addrlen =3D bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
> +       if (addrlen < 0)
> +               return addrlen;
>
>         return connect_socket(ks->sock, &sa, addrlen, 0);
>  }
> @@ -225,18 +255,29 @@ CFI_NOSEAL(bpf_ksock_release_dtor);
>  __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
>                                u32 data__sz)
>  {
> -       struct msghdr msg =3D {
> -               .msg_flags =3D MSG_DONTWAIT,
> -       };
> -       struct kvec iov =3D {
> -               .iov_base =3D (void *)data,
> -               .iov_len =3D data__sz,
> -       };
> -       int ret;
> -
> -       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> +       return ksock_sendto(ks, data, data__sz, NULL, 0);
> +}
>
> -       return ret;
> +/**
> + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remot=
e address.
> + * @ks:                The BPF kernel socket context. Must be an acquire=
d reference.
> + * @data:      Pointer to the data to send.
> + * @data__sz:  Size of the data to send.
> + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL t=
o use
> + *                the connected destination.
> + * @addr__sz:  Size of the address union, ignored when the address is NU=
LL.
> + *
> + * Sends data to the specified address, or to the connected destination =
when
> + * the address is NULL, best-effort and nonblocking. This may sleep
> + * (kernel_sendmsg), so it can only be called from sleepable BPF program=
s.
> + *
> + * Return: Number of bytes sent on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data,=
 u32 data__sz,

This would limit API to fixed-sized data only. Have you considered
passing dynptr as a source of data, so you can send a wider variety of
data? I don't have a strong opinion whether we should add a separate
API or convert this one into dynptr, but I do think that having
ability to work with variable-sized data is super useful and should be
added early on.

> +                                const union bpf_ksock_addr *addr__nullab=
le,
> +                                u32 addr__sz)
> +{
> +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr__sz)=
;
>  }
>
>  __bpf_kfunc_end_defs();
> @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
>  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
>  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
>
>  #ifdef CONFIG_BPF_LSM
> --
> 2.43.0
>
