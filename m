Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C513C141F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808696; cv=pass; b=nKrUtN98ox4NBz7h8dFAgXqBOO1lTKXBrhtyeiKRJH4DKnfnCD9I3LAnGqo20bhF2LghCPColWjqt1YrKjHTd9raXerhR3gEbb/qKeJjlT6K6jHMTXFOxxspI7TRZHPNAntVFO7mBep0+IH6TQn6JE1jwDu4Rhff1TChznQqTn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808696; c=relaxed/simple;
	bh=E33bhb5zDIx5GQabVwi4pFI64V4kElpxF8T3eL+XXdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0YP+dQMmAcjiODA8L4WtPDTqCUGNtIt5bE6LkyWQq7di0SEZs9P42ihForQ8fnBAhFWZqavx3SKcHAO4E2POakcMJzY5J9K2nF2ZYXniFnx7642HwiEJkJxo1nhg5uLy53dpI5LP4Sfpg/S2nUx/473pkBNKDp9SrfMBG1oVrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ks3OyuU5; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ks3OyuU5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so3667235a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785808694; cv=none;
        d=google.com; s=arc-20260327;
        b=XJGqWP1KzQFs3wnW7nyfdiL1pSNB3khwfFM7/j18QzYIjVObFtS3fkFx9U9L5yDQ+0
         iPgbPSjh0N8opaGt3bEo/fQvGXFQ6y0AFBGeaRmoQBRnv8XEEU6YPCTgTvMkbhCZCqUu
         qqFLPyU4Q1DYhipPBRx5wZyLVdxwK5RoicmhtXhGqEGkfcSmFCfDMMh7sQkkmVBSM0Wa
         tkuO4ppgj0KVmxJz2+ALjp7npln5gfvZsCiDNWW+pA2nXITYJLLtY6PWGRelcRSa306w
         nYqfgo/SrLQ7sZ9aZspSKuDyArfNkTq6R6xGh5gCpWbNwA0oM+oSVf16GGpCe+HuVXFC
         Lm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=urICutOteuFwVCvg/Qo1e49u62L0Kec2UTDXdoXgO0c=;
        fh=Hv90l+tg4roJwnjQ8xx1b3VLCJesd1A7CqbZVbntg6g=;
        b=UwO1u/hdvLBPY00rY4/ZVTKoiwAhc7nMK7DZDqn/HEhij+DMtl3RDvRKvfXOID34KP
         sLWsUosgHdFBCTOd10gdfdQ3bGc9yBxCnZrOTjSb5l0rPbyPddPCxCJemUiouYLRs5mq
         Xhx2brL8PzgZ2sqscQFCH20injGnEeHC8hhNNxJ+8uMcCVQcY1xntFBHvzCDAeSyekf3
         ZNI1ZrjGpNzEMuSA/pQikHBnTYNHCh3y8/fo/QJcTA8c3IORkCjBeJ43hLBg4zq+Fa1N
         s3n52pnL7w1mBuBIJXHLJFbe4LKNIUJ/sHlIugqz77f5S/+PHHDY9HxDViT8OoeLWdfF
         eg7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785808694; x=1786413494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=urICutOteuFwVCvg/Qo1e49u62L0Kec2UTDXdoXgO0c=;
        b=ks3OyuU5gcyEWIox0BvNk96drSDP93iBeD19RjSytgcouJkOMV2cMnPsbovoFf66CK
         LdGbkcDgIFaxmi2aMwdVIetFMdeNHf9o7nL25JoLmqIMjTS+gJk92YR9GEGcWaftZ36Z
         I3faTx21TXNY8wSlcXSFnuAgtZmW1baIVN/aIKOX55No69RwPDgTCrcoFU/vcNL1KrPK
         qzUnPAJ0gurMPbMA6Sut3j4GiPOScxZzaBNii56ZeVkIMT4R6wRP4DlLB5vFVlQOz3Zb
         keUkLkIGLB+uVyCrXrCzpy/3p7EAXs1c/z5fz46o4B2uoQW8wISpBRt6qYqZm/imW0gf
         mEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808694; x=1786413494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urICutOteuFwVCvg/Qo1e49u62L0Kec2UTDXdoXgO0c=;
        b=YOQJ7oyX2MShoLQailqqto1YKnfB0tivrOnAs40o2XCfI7AA1RDn7+RfxHnTzd3Ykt
         iU2buViUIYVPxEiLMt7CZLjhzdEtWrBA5vZzjSosBZQceNsVkgy2JdtQzQrP7GoxB4J1
         FetIO75UVaSb9kRm24A6AzsXy37eJp58voCJFzgUZq7BIU+p5g3CvacN70WRhEal7kLd
         2w63cHE4v5WM1jOpCF6gyWmMkOOfWvzqgR+4nUeklPSYuz6cu5nFLO4GSbR5k35TbcYW
         VRdBsIpmzIENXtZlCZzLmMN8IDhCk10z1H498MQCC7abQ+y8XFKT2t3MSKGYbV10e5SV
         DAkg==
X-Forwarded-Encrypted: i=1; AHgh+Rq98BmG2COb0m8Tkbtd8OlKC/si5QPGiKJFmabEkx+T2Khu2RfmvRRiy/jb54JsAtu/KuZ/GNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85fcyAYYxXoPBk8NyYiC/zofQ9vyyUytQGRm9C8JZECHmgzrr
	W08BqpugGOCnbMVlLRm4/d2KQ8cejO1ZJTFWbHjWJWF7RitxF2KB1Bzf9SxCyyNTvYTGG2BGtO7
	NaH10MOFUz+5qNbDBURcyvAjuY72p4XwWxP8grp7a
X-Gm-Gg: AR+sD11S776K8xY+cRjbldr46GdY5t4RrkCCUqw2Nw7RGjxc8A+fFfhgzQL5gToiKWP
	aKpTRwZCrKjXxZFl9T5UKxWwctI4P3mBc7Q8bYABHfC4eOn12RASYwzDZ9hhNR4EQp+liJUiP+C
	oWuWXYWxSPJ7fYV+kfqB6dd0KICxEwR9wX1Y+yDyWqJZI1MUxqd0BiHfDNNbWDLIAJPdGrytgrD
	vjsI+j+Noz0BWpGt4gVdvRJKKDbBIBk/dHnMKx+h/xVMNPqBfAUInWXqbs2ClsCqbHfH1VCkcp4
	JzqNf3fxD4cay0kJNjy0G+9AJazTGloo42fPFXGaKH66cvHMRYfUIASJxJ0qw7reK38vSr3Pw3A
	YFygePInhcoRj5GXwdkJ+Z8v+YYAXySYXHD9a4fSDGo6jvENG3+J2ZSO5s2kESCROHSAxw521KR
	AETr5/zrNmc0pN
X-Received: by 2002:a05:6a21:103:b0:3c0:9c1a:8943 with SMTP id
 adf61e73a8af0-3c92a9a285dmr11490034637.75.1785808693525; Mon, 03 Aug 2026
 18:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co> <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 3 Aug 2026 18:58:01 -0700
X-Gm-Features: AUfX_mwtQ5xxaoHWOSYIH3gyFMv7I_HD9PhPyeRC_7XxBwv9FCWrFdzsr6V7ntk
Message-ID: <CAAVpQUBKBfRm-XqqrMq0hGeOvWzZXLLmsBnDWKHhEEswmJoz+A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 2:01=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Lookup helpers gate whether to acquire a socket reference on
> sk_is_refcounted(), a check re-evaluated at release. An established socke=
t
> refcounted at acquire time can gain SOCK_RCU_FREE via
> connect(AF_UNSPEC)+listen() before release runs; the release-side re-chec=
k
> then reads sk_is_refcounted() =3D=3D false and skips the put. The referen=
ce
> leaks.
>
> Make acquire and release unconditional and symmetric: always take a
> reference, always put it. Adapt sk_select_reuseport().
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCK=
HASH")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kern=
el.org/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
> TC bpf_sk_assign() has the same issue; it takes a reference only when
> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
> destructor it installs) re-checks sk_is_refcounted() independently at
> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
> socket here too. I'd welcome suggestions on the right way to handle this.

The same class of issue was reported by listen() + shutdown() + connect().
https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com/

Can you test the diff in the thread ?


> ---
>  net/core/filter.c   | 27 ++++++++++++++++++---------
>  net/core/sock_map.c |  4 ++--
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index fede810ef37f..d71e069f669a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7032,6 +7032,14 @@ static struct sock *sk_lookup(struct net *net, str=
uct bpf_sock_tuple *tuple,
>                 WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
>                 sk =3D NULL;
>         }
> +
> +       /*
> +        * Always take a reference, even if the lookup skipped one;
> +        * bpf_sk_release() always puts one.
> +        */
> +       if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
> +               sk =3D NULL;
> +
>         return sk;
>  }
>
> @@ -7090,11 +7098,16 @@ bpf_sk_lookup_full_sk(struct sock *sk)
>          */
>         if (sk2 !=3D sk) {
>                 sock_gen_put(sk);
> -               /* Ensure there is no need to bump sk2 refcnt. */
>                 if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
>                         WARN_ONCE(1, "Found non-RCU, unreferenced socket!=
");
>                         return NULL;
>                 }
> +               /*
> +                * sk2 is RCU-free, but take a reference anyway;
> +                * bpf_sk_release() puts.
> +                */
> +               if (sk2 && !refcount_inc_not_zero(&sk2->sk_refcnt))
> +                       sk2 =3D NULL;
>                 sk =3D sk2;
>         }
>
> @@ -7279,7 +7292,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup=
_udp_proto =3D {
>
>  BPF_CALL_1(bpf_sk_release, struct sock *, sk)
>  {
> -       if (sk && sk_is_refcounted(sk))
> +       if (sk)
>                 sock_gen_put(sk);
>         return 0;
>  }
> @@ -11571,11 +11584,13 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuse=
port_kern *, reuse_kern,
>         bool is_sockarray =3D map->map_type =3D=3D BPF_MAP_TYPE_REUSEPORT=
_SOCKARRAY;
>         struct sock_reuseport *reuse;
>         struct sock *selected_sk;
> -       int err;
> +       int err =3D 0;
>
>         selected_sk =3D map->ops->map_lookup_elem(map, key);
>         if (!selected_sk)
>                 return -ENOENT;
> +       if (!is_sockarray)
> +               sock_put(selected_sk);
>
>         reuse =3D rcu_dereference(selected_sk->sk_reuseport_cb);
>         if (!reuse) {
> @@ -11605,13 +11620,7 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reusep=
ort_kern *, reuse_kern,
>         }
>
>         reuse_kern->selected_sk =3D selected_sk;
> -
> -       return 0;
>  error:
> -       /* Lookup in sock_map can return TCP ESTABLISHED sockets. */
> -       if (sk_is_refcounted(selected_sk))
> -               sock_put(selected_sk);
> -
>         return err;
>  }
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 9efbd8ca7db8..92a006fd3368 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -392,7 +392,7 @@ static void *sock_map_lookup(struct bpf_map *map, voi=
d *key)
>         sk =3D __sock_map_lookup_elem(map, *(u32 *)key);
>         if (!sk)
>                 return NULL;
> -       if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt=
))
> +       if (!refcount_inc_not_zero(&sk->sk_refcnt))
>                 return NULL;
>         return sk;
>  }
> @@ -1218,7 +1218,7 @@ static void *sock_hash_lookup(struct bpf_map *map, =
void *key)
>         sk =3D __sock_hash_lookup_elem(map, key);
>         if (!sk)
>                 return NULL;
> -       if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt=
))
> +       if (!refcount_inc_not_zero(&sk->sk_refcnt))
>                 return NULL;
>         return sk;
>  }
>
> --
> 2.55.0
>
