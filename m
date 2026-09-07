Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5C3EC687
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751755; cv=pass; b=Q3kTnaogVPL4oxlKPZMHKAPICwKztrJju/LOkNzrQB/yAaoA/6up+7uCgDOcbOy5iOv/FmgC10K4IaVGdSENd/0AJLIutICO+khHK4/Bs/++4LwSeK5OjUi+MznggM8md3HvF0H9O8/h0Vdz2oB2h0p+CzTuSLsnJmESHvuHMrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751755; c=relaxed/simple;
	bh=GSAAlThqfE8mUuSgAVPRXZIyOsidSPdBFMqj2RYB3UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYAsIqeLAdhCw1CnfBCRtaNOtY6u375IEmk/Rrq5Vc6eNsmlHOi6ewe/Qby9/qVNaTla1ffWOgEAqE5IomfJ2cwZ0jeAhGhYQALtVyh5L4bKpGQ9P9ATGzqSTo2dBylwCaAOeI0IGhuSrWTVyTN/cKX+q0B6+5szo8zU/U3dp2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k1Jq6bFz; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k1Jq6bFz"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b5e1340faeso2609404e87.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 20:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788751750; cv=none;
        d=google.com; s=arc-20260327;
        b=EllxXYiOhadAJEex7fjdk4duRXy/kkIjrLBGLTFc9EAEt/saoQbVYY4XbvrHnN+KAA
         tMmqogCld/xik0v7PnUGDYjw16nZeTHaXmk6eF3d/YQmbrrkzSwdMCxFuxI6QSt8xmb/
         OwoLRGxag63AwKXyezvX/j15iCS3zAyXL7RJ+OevdnMGDdmgMwCTUhe5ph+zjUOqN9zC
         YS6lsLXNlBN6d8y4V8jccz291tAy7ICdUZRqSkW7CHcgsZnxiAxr9OoMl8FOieSuONk+
         uDGD7mlnfvgWn72zCmlUxnFJnlrBAmcjO9nZ6vSF7Fo2x0zijY9nK/thc1qQSGt9m5ZK
         nYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uw7bun+2UCN5MoW38axYgFXx6bpXxJj3jRNtGXiPoTo=;
        fh=lv8kMQz8O+gQ3nqHDoQZliX12miycid/0FLm+oYcUWs=;
        b=ErpaSId39QF6dBVnuTRFXsV++umlgBS4IeNTDl8NQc7xUHEVjATbmdYuCBgNW/gmf3
         I873P61NuG/T6YzJOaLec211gP1NDKpmo7UI1o6T02GGjRjkOlwGZOOqI/RovFqdf2g5
         GyrWxN0oo1i5VPN11jN7usc1mlSDisR3n4I1SNhbB+/xT9HC0guLfeR/fd/qmny/C/ZT
         SBYvzKGUgNwYR3x9nTNpW3QXFpZjwjyBqkafwXR5YLkq9pnNsoLP3uLfQpS8eX/3B5Se
         KdWlfSKS8MTvHvsbfDPRHiGljL5B+YKWOGFSAKCAIH9AdiMezCG4/cjgkGcAvGyGnm6M
         YMyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788751750; x=1789356550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uw7bun+2UCN5MoW38axYgFXx6bpXxJj3jRNtGXiPoTo=;
        b=k1Jq6bFzpt6yZigC9BWXTCg/ragq0H7SEQBUp/NcUNobqw1NFp0af6lWR8ThZ4lM1R
         m5PZZvsnVyps/pOuezHF3EUc0waTGgJs6JNDG1vefH3qP61zQahKXXrnc+fgDVvry4Lm
         hdmxDOKqjxnp91bvz4aR04Kki3VOe3oDo/+CC2FxnGhBquc9pXi2umy8H25jIN+FNcRP
         XuYFX1OKdpmRH8+g0M2BXoTwNGEOB8Fh/D071eemYgclyUOEXsKWSSbG6zgGyAobNkTZ
         AlKom8pbQnwn8sAvv7x2sQFN3bSH+1F1peCfWsL1V3R4C2Fv1mPPEHZMiPOY9gTf+Nxa
         e/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788751750; x=1789356550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uw7bun+2UCN5MoW38axYgFXx6bpXxJj3jRNtGXiPoTo=;
        b=smP4sOyQ5t/SJVlHnLV11cpg3jxjzns0vKZI4fsxnxNVU3jPsSBhXwrn3snDmWAJpA
         xuPRZwulwgCavqa5StEkf9oy5qLSlVaC92CdK5109ZWh2Kxb25fv3A+ChMeY5T8JIY/i
         BCZ0pwa9S3ZsyWdEtG7p+7UdBh0GryIo0ib1dalN6Bk10ayZv0+WdMfbX1drCru6Pwv4
         7ecjOpOLF7wbvdY7Wfkk1bpHqEEDOgo6T/D6tpXO2VijWvr72QNsW0z8QXGFLI52msPS
         y0jrlDlJ2vPN1hAhYudsPFhxS4Vl4SknvNAwwGLdkcf5LJFwajacwMtoAk/ntPZUde0i
         ZtIA==
X-Gm-Message-State: AFuF++lp3v/qhp37Kw1v9uq68o0wFnhMSR6beK7LqChYovxHSMHST9S6
	WpN/EIAn5hFePqFTafMj21Q1BnltSbE5QfKPbe8hU0Z9VlR6OhF03k+9BGN9K5lpBuewBVh36eF
	ZPrc1r2B0b5GJY+GK6xIBA3axREgP16P79+UjxOD4wIs=
X-Gm-Gg: AYBFou2nK101beZsk5KEA4yv4FRLL5hp4oGv3bwTrx3OnsiNuh/jpm3jBdAHa111QrL
	KIeaY/tfaydlX3SCHSBMHJ0nFdLzv4MSVACkxbO6J0kD6cTCuQdy1Sbe0Dg3aIWSUaeUvaIvD9Q
	C4v/UVgYgsQrBWsowBp1NOk85Q8IRzd/CKLIzPX9PjxOkn/a5ZamhqY8Vo9C2zempC0QsIcSIUn
	RXRIDKq6VbO7Z2dh0GaXOj7RIm1MAufYc/3MfM1NCfULwHFzMgwiBeqxyCl4pYQRdf+lbzfUxlb
	SmL9JlmR4/gqVaI9tJMZJZ61HUDSDXa69RLA6tz2Z7nlWsNtNiu6JiDKkpMsZwktVzBd8uUx6d0
	=
X-Received: by 2002:a05:6512:1325:b0:5b1:4caa:4b43 with SMTP id
 2adb3069b0e04-5b616e53bfemr3832223e87.0.1788751750243; Sun, 06 Sep 2026
 20:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788622674.git.zihanx@nebusec.ai> <5fc14a8ba754126b6897939e11154167281d4c5f.1788622674.git.zihanx@nebusec.ai>
 <20260906181910.GA455897@shredder>
In-Reply-To: <20260906181910.GA455897@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 11:28:57 +0800
X-Gm-Features: AcwNN1Vs7jM1fB-2aADxommDInJ89MOY2aFrDlu6fxu3INigQ3uPZpKfJT-CguI
Message-ID: <CAANe3eTObpyHno0X+aAgRBeWVSNgdQm4y4E5GAAUVevDf0sKGw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] ipv6: ip6mr: fix mr_table leak from MRT6_TABLE
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 2:19=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Sat, Sep 05, 2026 at 04:30:07PM +0000, Zihan Xi wrote:
> > MRT6_TABLE is supposed to select a multicast routing table id, but
> > ip6_mroute_setsockopt() currently calls ip6mr_new_table() for every
> > unseen id. The new mr_table is linked into mr6_tables and is only
> > destroyed when the net namespace goes away.
> >
> > A raw ICMPv6 socket with CAP_NET_ADMIN can therefore loop
> > MRT6_TABLE(fresh id) without MRT6_INIT, close the socket, and still
> > leave the tables allocated. Repeating this grows unreclaimable slab
> > until the machine OOMs.
>
> Isn't the established way to deal with this sort of issue to simply
> account for the memory and assume that the admin put some kind of a
> memory limit on the container?

Yes, that is the right approach. v2 tried to reclaim empty tables and
that was the wrong direction.

I will send v3 based on your diff: GFP_KERNEL_ACCOUNT for mr_table and
SLAB_ACCOUNT for the IPv4/IPv6 MFC caches.

Thanks,
Zihan
>
> See for example commit 6126891c6d4f ("memcg: enable accounting for IP
> address and routing-related objects") and commit 5d26cff5bdbe ("net:
> account alternate interface name memory").
>
> This diff [1] accounts for the memory of both the multicast tables
> and the multicast routes.
>
> With your C reproducer and this diff I get:
>
> # echo +memory > /sys/fs/cgroup/cgroup.subtree_control
> # mkdir /sys/fs/cgroup/mrtest
> # echo 64M > /sys/fs/cgroup/mrtest/memory.max
> # echo $$ > /sys/fs/cgroup/mrtest/cgroup.procs
> # unshare -Urn ./mrt_poc
> allocated=3D1 current_table=3D1 maxrss_kb=3D1788
> allocated=3D10001 current_table=3D10001 maxrss_kb=3D1788
> Killed                     bash
> # dmesg | tail -1
> [   63.360047] Memory cgroup out of memory: Killed process 297 (mrt_poc) =
total-vm:2424kB, anon-rss:92kB, file-rss:1448kB, shmem-rss:0kB, UID:0 pgtab=
les:44kB oom_score_adj:0
>
> [1]
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index e5f2b1c6150d..b9c544d48c45 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -3376,7 +3376,8 @@ int __init ip_mr_init(void)
>  {
>         int err;
>
> -       mrt_cachep =3D KMEM_CACHE(mfc_cache, SLAB_HWCACHE_ALIGN | SLAB_PA=
NIC);
> +       mrt_cachep =3D KMEM_CACHE(mfc_cache,
> +                               SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_AC=
COUNT);
>
>         err =3D register_pernet_subsys(&ipmr_net_ops);
>         if (err)
> diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> index 867b24beded1..a0ec6d19a237 100644
> --- a/net/ipv4/ipmr_base.c
> +++ b/net/ipv4/ipmr_base.c
> @@ -52,7 +52,7 @@ mr_table_alloc(struct net *net, u32 id,
>         struct mr_table *mrt;
>         int err;
>
> -       mrt =3D kzalloc_obj(*mrt);
> +       mrt =3D kzalloc_obj(*mrt, GFP_KERNEL_ACCOUNT);
>         if (!mrt)
>                 return ERR_PTR(-ENOMEM);
>         mrt->id =3D id;
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 3f2ed9b77deb..9d8116b5edb1 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1427,7 +1427,7 @@ int __init ip6_mr_init(void)
>  {
>         int err;
>
> -       mrt_cachep =3D KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN);
> +       mrt_cachep =3D KMEM_CACHE(mfc6_cache, SLAB_HWCACHE_ALIGN | SLAB_A=
CCOUNT);
>         if (!mrt_cachep)
>                 return -ENOMEM;
