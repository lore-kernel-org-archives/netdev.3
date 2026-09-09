Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054C395D8C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977232; cv=pass; b=aekDEDI7blFXkDQUFfjYemCwmdCamdxFMsoGA0jKQWoJbdRsFfoSPLNftHFBgc6/dFFhoXfNWtAXM9KFSpewwT8M3aJWdtK41Vcukeoj/2CpdEGAXCu+gyby5LmCMZ4w34P7E/vocmbIeKgx77NB40W+KJsRASyhKLUddRPjUCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977232; c=relaxed/simple;
	bh=ffpLcmhdNr6NOIw4fF/1zoFPIQiK4mOy2UlkzAuwzw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e62X3t5f8iX/tpfGNUJLRHBQs5ou7xQVo5rBGOrtjbVvXIIN5xFdLrp09htQfumD08csQMMZnxs/JFS10xRJHXmgqVJ9wTipCiUs+0y2EwGhCwvvrBthO0Cu3jz5IJ72W354VUXJmTAZe4b9HaVpawmqggC56VNKwiYhF7nX0bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=u0XRGv88; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="u0XRGv88"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66de7e0bc85so5504095d50.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977230; cv=none;
        d=google.com; s=arc-20260327;
        b=Zg0gE6/Y2QzLIQyiHcF3Hlj9l/fEsp4t/5xBOczFgXomb0G33YL8i+WPWXbn19nvTI
         0uRww01LkxgkOD5wpsNCmIEaAL4D5HLOvHTBlMgz7vefid60N5asOHIf32oKnxB4Oi2p
         o+R3uqcBffzqNM6CVVxF7MPb5bZVopacPnquAq3U5WT3fSnsZ1nDCzbNXpJXmR5KYNKb
         FA7vtlXnehPxt0aeAIqiLf2AuvQ4w3a8hKK8AiopoylNcJ4bpIsSV7oS/ueNX67cz0qd
         UxnrZC3OFJzaKIwMuVhZ95Pe/kgBdYobJOrDs/muD0MCNHzih4flJIx8UzM7sdVm68vH
         2LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pb5/uK6V0VOSoOpi7HbnquG+ZVFHg8kvhGiqpjo0wEE=;
        fh=DT8F4ijd99887DBF4B5PUPnkb7BNDpqOu7+MOaim/uQ=;
        b=PrYqdPArZ4cbJaPpPLx7Q7OAl3rpEH5kwWJcuz5dFY2aPYyUCYL+AChL8BiihaXutL
         fh50IqCdRpv7Sbaj/7etyULD9u6pE+cDtulyqkS/kA5/Zk8GtJTm8MSWAtNW7kRa63R4
         S4+MCfcj++tEn6BEv49y3vVOl02zIUD4dUY9PUO7mIWXgpt4HfkWpOglc4JcPHlJ7CHp
         mBTuxL4CmIpN4mswx0Un3Fs1gcLbxK3G3s6DjBPciuFmGU7ijJbMZHh8eemsOIGk8rev
         jGMtrnfqTpdEVupz6XZbr/31vvSS3U3fLnl5m36OnKvLP5DW/TdJiOVThqKpOyHfGWfa
         icBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788977230; x=1789582030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pb5/uK6V0VOSoOpi7HbnquG+ZVFHg8kvhGiqpjo0wEE=;
        b=u0XRGv88nCQIxehtLTPevTtlB7TUi3IqgpoQOtUO5BVi3QSvwDPVFZQIfiZwfCa3Jj
         S4viXBzwtMEnA6JKFy73M9DCvcbpd7MSh/Uu3LXmOYUeMRJF006TRC+B4Y/XhPHffL9X
         IgFickCE/xsQHHhWihcFWGgHh/hAfTa4cuiU7qac+APhrj81gcm6Bf5JU+XT6Qo9UamS
         yeRSw4M032rdpGBKMvOy9lMuJTfc4LMPAo/GRZU0FK2pb9LTvbYHouaBa8nsIorSTjD7
         kPOpWtA9sazTFT+eD5KqrfCFZr/HhV8fgC5vuqTQifEAuSoSqfvrF2MyjUjSYq5p/Wew
         xHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977230; x=1789582030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pb5/uK6V0VOSoOpi7HbnquG+ZVFHg8kvhGiqpjo0wEE=;
        b=Ks8GkBSP1ge2LXwBl0M4m8mjl+MZNr3PJ2MZib0GWLnxggeMYsBlNL9ZI8k/pPtN79
         zwMICRSQQiyLCjalgUhgAP2/zLeyscb0Xl27J7XDsBiNEdGZDEZRZJlg2ClDcyFC9eHB
         v1KGlRZpjIl8F/RpEQGJ5failJmSBY+IT88kGRW/+VRMGV3FVEiMBQfcFtgr48FHLVDL
         fGXBBlx4aY9YgCDGl08WPghSKIT4GzaI5EocqdBQGXGqGqTHp/GspwuqQFkdUeQ7mV3o
         TNF0VCQcl6wmjKLf4bh3cmE08Ys6SNu5rkMAAZPMt72sfzLGIqoLaLAZUfkSTfnNAotj
         urPQ==
X-Forwarded-Encrypted: i=1; AKwUvByJGLtIy2QD+Iak9LKd/N5ElAtI1CJTaZZl3ml7PZC8YOxORTuAFfVGHsPZlwF60ZsN3iTTuek=@vger.kernel.org
X-Gm-Message-State: AFuF++mhIkjlDUuXTSwQ8D8y5/4VszwfI0KiksrEVApyW3n89uxtQ0tr
	EzlBVT7BWXsEyFBkEDzeXgPHRfjK8Pb7ATweNDGCQJTshpcZ1jDen8zDLVHPDvhW9RFj9QShQZW
	L+WBCRHY/Wc6Kc6eVNSwSLVqDVAgdx/7wKFKX+b+zug==
X-Gm-Gg: AYBFou2zZ19sLSGuq2ayVhVHn3/r1Ua6njXV5nC3UKQ83DfdBEOBHbCDcNH1lbTBCKb
	h87DmuitVLBLQaiE7t6JmbNC8AyJ2lMZqtfV96vYbrRRZj4ZB5qPNh8e08Ijvp+d+TuF+WDQWFp
	qsGoAdrWYKmKKSD2J6K8zPaSwLkjULpkn/4OT+2JEfm92AlniSylF4865bnNWzzBkHn4Y9ZmZjl
	fFTcE9jqAduan3udAxIon/LPRjS9a2Z+PVs0HuuSFIIW5twJu7qOYQMMXIqRFa3doyK3Q6c55zh
	AcAvb2ebcjXdjjfRg7PfRgJ7RBZ/voBngz6bxXycvB3QN3pZwXIDJwI=
X-Received: by 2002:a53:5a0c:0:b0:66f:c1be:317a with SMTP id
 956f58d0204a3-66fc1be35ebmr7665511d50.81.1788977229661; Wed, 09 Sep 2026
 11:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903100921.113374-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260903100921.113374-1-jiayuan.chen@linux.dev>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 14:06:58 -0400
X-Gm-Features: AcwNN1WgDaem2ZiaTSnvUEhjWeQKvrRPTKih7rvRNQjxGVVOPW6EXSNd9iM6xvY
Message-ID: <CABFh=a7as_meC0sM5-KmSsGfvBuHd3XCceBEJ9q29Uf8V5E_gw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix out-of-bounds read of rtt_min in sock_ops
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, VEGA <vega@nebusec.ai>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:10=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> A sockops prog reading skops->rtt_min never checks the sk type: on the
> tcp_conn_request() path sock_ops->sk is a request_sock (non-full), and th=
e
> ctx rewrite casts it to a tcp_sock (full) and reads rtt_min past the end =
of
> the request_sock, returning dirty adjacent memory.
>
>         SEC("sockops")
>         int prog(struct bpf_sock_ops *skops)
>         {
>                 switch (skops->op) {
>                 case BPF_SOCK_OPS_RWND_INIT:
>                         leak =3D skops->rtt_min;   /* reads the request_s=
ock OOB */
>                 ...
>                 }
>         }
>
> For instance one such read returned rtt_min=3D0xffff8881, the high half o=
f a
> leaked kernel pointer.
>
> Guarding that cast is exactly what SOCK_OPS_GET_FIELD() does -- it checks
> is_locked_tcp_sock and returns 0 when sock_ops->sk is not a locked full
> socket. Every other tcp_sock field in sock_ops goes through it; rtt_min i=
s
> the only one open-coded, so it skips the check.
>
> Read rtt_min through SOCK_OPS_GET_FIELD() too. rtt_min is a bit special:
> it is a struct minmax and we only want the current min, so pass
> rtt_min.s[0].v. That is equivalent to the old hand-computed offset
>
>         offsetof(struct tcp_sock, rtt_min) + sizeof_field(struct minmax_s=
ample, t)
>
> (s[0] sits at rtt_min + 0 and .v at + sizeof(.t), i.e. what minmax_get()
> returns), so the loaded field is unchanged and only the full-sock guard i=
s
> added. The two BUILD_BUG_ON()s that protected the hand-computed offset
> are no longer needed.
>
> Before patch:
>
>         0: r1 =3D *(u64 *)(r1 +0)      ; r1 =3D skops->sk
>         1: r1 =3D *(u32 *)(r1 +2324)   ; ((tcp_sock *)sk)->rtt_min.s[0].v
>
> After patch:
>
>         0: *(u64 *)(r1 +56) =3D r9
>         1: r9 =3D *(u8 *)(r1 +50)      ; is_locked_tcp_sock
>         2: if r9 =3D=3D 0 goto pc+4      ; not a locked full sock -> 0
>         3: r9 =3D *(u64 *)(r1 +56)
>         4: r1 =3D *(u64 *)(r1 +0)      ; r1 =3D skops->sk
>         5: r1 =3D *(u32 *)(r1 +2324)   ; rtt_min.s[0].v
>         6: goto pc+2
>         7: r9 =3D *(u64 *)(r1 +56)
>         8: r1 =3D 0
>
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Reported-by: VEGA <vega@nebusec.ai>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  net/core/filter.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..a043d179ff1a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11105,18 +11105,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_=
access_type type,
>                 break;
>
>         case offsetof(struct bpf_sock_ops, rtt_min):
> -               BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D
> -                            sizeof(struct minmax));
> -               BUILD_BUG_ON(sizeof(struct minmax) <
> -                            sizeof(struct minmax_sample));
> -
> -               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> -                                               struct bpf_sock_ops_kern,=
 sk),
> -                                     si->dst_reg, si->src_reg,
> -                                     offsetof(struct bpf_sock_ops_kern, =
sk));
> -               *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -                                     offsetof(struct tcp_sock, rtt_min) =
+
> -                                     sizeof_field(struct minmax_sample, =
t));
> +               SOCK_OPS_GET_FIELD(rtt_min, rtt_min.s[0].v, struct tcp_so=
ck);
>                 break;
>
>         case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):
> --
> 2.43.0
>
