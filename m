Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623E3D9020
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929225; cv=none; b=r9Ju7369VyHrbszZh4PIz8vFEzdJIkiug/Lm+NRQo7SaDnNTyF54S5qcZ0oYCYHQCQ7AoRqU0d5/phsAoGZBog9DDbYJ2zzaKmfGDx19aP2lOtbHv6WjEWfI4mNixrc3Sz8crwSnLprUDRYmWJ6zLJuCPElqzCt943sCDTKtN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929225; c=relaxed/simple;
	bh=gWnu78lsDu7M9l275KxounQcaaczKCQS6knv8WFYAA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8vZw2Tpu35IvbuKr8JnVEA3JSHMfMbzB0TFVtcHpQZp1P6bqhGF+cBO364FE/tvjzfZNaHJNHlPBoBAAp616WlMqMK0+8QTk3dkJ4/0nTpOwKW5lX8CNU2XWO56Cd/v0Or7VeYNc/RmFhZaovFkjhFcPRF6nfSysxsdjRYiv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCk0j/Bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCk0j/Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA60B1F0089A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929223;
	bh=DiolHbL656M0rMTOtyq984nHU4fBgKa0w8p0YS9RAcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YCk0j/BoUGwGZ85uD6036Vl+y9uydYOx1Y2QVDOV01rVxfUI9sDlJc8+9u4Bw37CG
	 CH81HQ+fCEthIu6UvKSY5q52cvrRxYg2OPURZ749HYJopKF6BgQ6x5JmDO0rSOz9n2
	 okB+/hh/2zldjaNm1o6Lgwu0ROH94BVWZoI03WdAqJ1crOx9JUvZYr3mgDn/2s/Qy9
	 KkN44CoGo5HS14wgOLX54L7BOn42sEODD9PWarSsxyUEe9cZsOXAAIaXR00Pg8E+Fv
	 UqGWTHDo2lJZD3EerK2JFMt5uZOqOsr5l48J9kon3yYESSkJUG66cy/uYBKIivyGSK
	 ABWAdP9UeihHg==
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so5060751a34.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 01:20:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwgoAUutAKcsPyBA/srafo80CsDQcVu6CDtkdVVjrpBaFBUHNfPdJMnGltkIg51kldjcBfb0Ko=@vger.kernel.org
X-Gm-Message-State: AFuF++nVeQXlck9h+5l3AlMCXwQAoQ/LBn44bIGJfbffwxqSDe4Sk6i1
	lmjQByo2rl5rN9hcV8Dt3ef4FEma/ibV2/TedL58t/cm+3q4uo1B8tC/uDqJd1er5kNkCoIPdzz
	LMLGVCpwIvIdUptuaZ7dBazgqkBBFVrM=
X-Received: by 2002:a05:6820:55d6:10b0:6d7:5343:b5fd with SMTP id
 006d021491bc7-6df34091446mr1013040eaf.44.1790929223082; Fri, 02 Oct 2026
 01:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790917676.git.zcliangcn@gmail.com> <62774f8c6cbad549d1a95f88df99ab7745d7f6b8.1790917676.git.zcliangcn@gmail.com>
In-Reply-To: <62774f8c6cbad549d1a95f88df99ab7745d7f6b8.1790917676.git.zcliangcn@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 10:20:10 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqWwV+8JaYjsHrWDvoSt8Ng01xs9Orv4xhRpFAvhMnD6w@mail.gmail.com>
X-Gm-Features: AclHuK_GE1sAsvNuKlOLRAERpbySEcCE-snYtHgM_PZqpiuw-6uNdwPQVickwR0
Message-ID: <CAL4WiiqWwV+8JaYjsHrWDvoSt8Ng01xs9Orv4xhRpFAvhMnD6w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: use random salt for netdev name hash to
 prevent text base leak
To: Zhengchuan Liang <zcliangcn@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 8:52=E2=80=AFAM Zhengchuan Liang <zcliangcn@gmail.co=
m> wrote:
>
> dev_name_hash() uses the network namespace pointer as the salt for the
> network device name hash table. Unprivileged users can use SIOCGIFINDEX
> to look up attacker-chosen nonexistent names. Timing these lookups
> reveals which names share a bucket with an existing name, allowing the
> salt to be recovered. For init_net, recovering the salt reveals the
> kernel text base and defeats KASLR.
>
> Use the per-network namespace random value from net_hash_mix() as the
> salt instead. The value remains stable for the lifetime of the namespace.
> Since all name insertions and lookups use dev_name_hash(), this only
> changes bucket placement.
>
> Fixes: 8387ff2577eb ("vfs: make the string hashes salt the hash")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> ---
>  net/core/dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 18dc88990510..f3eca7fa2481 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -98,6 +98,7 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <net/net_namespace.h>
> +#include <net/netns/hash.h>
>  #include <net/sock.h>
>  #include <net/busy_poll.h>
>  #include <linux/rtnetlink.h>
> @@ -193,7 +194,10 @@ static inline void dev_base_seq_inc(struct net *net)
>
>  static inline struct hlist_head *dev_name_hash(struct net *net, const ch=
ar *name)
>  {
> -       unsigned int hash =3D full_name_hash(net, name, strnlen(name, IFN=
AMSIZ));
> +       unsigned long salt =3D net_hash_mix(net);
> +       unsigned int hash;
> +
> +       hash =3D full_name_hash((void *)salt, name, strnlen(name, IFNAMSI=
Z));
>
>         return &net->dev_name_head[hash_32(hash, NETDEV_HASHBITS)];

Thanks for your patch.

CC Linus.

It seems this patch should target net-next, local KASLR attacks are
not a serious concern.

Your patch would allow an attacker to disclose net_hash_mix.
Leaking net->hash_mix compromises other per-netns hash tables.

u32 hash_mix is too weak for full_name_hash()

1) What about passing NULL salt instead?

net->dev_name_head is already a per-netns hash table,
and only CAP_NET_ADMIN inside that netns can add/rename devices in it.

2) I thought about widening net->hash_mix to unsigned long (get_random_long=
())
(but not change net_hash_mix() u32 return type to avoid side effects)

But full_name_hash() skips HASH_MIX for len < 8, any 64-bit salt passed to
full_name_hash() can be recovered quite easily.

pw-bot: cr
