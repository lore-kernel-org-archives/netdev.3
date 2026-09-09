Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4B399350
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977902; cv=pass; b=rujx/lfEp+oaAr8Cs4altW4vslKn8fXjaTRfXPzAZi0c3k7Yzr00/nt+hWA2jF3G0ObeGw9VrBr9d0TXNYLzcPZZhEhKXAaDI0bVC/1aGkqfdVqPtu/MlnUB8Wc3dcosaJ8tDP7ssAtg2QbtT8LbKsp7z54uh5xD5AiLOFnHjIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977902; c=relaxed/simple;
	bh=+CDkEoDX2/LXNI3w0TZ8BPrSDg27dcd2Jkj3AIOFwBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGcrPWNyvHcG/4sRMVYrxkeyodjdTjTkShxMkbc9uXPSLIMB/mB+BJc9tTDvqi2VQydc3I1FhErJRxtBGBnaBFFM5U2Tg3oM17zEiyXUEj+U1BMWejfzSukPE9i2OzetBC3rwT/Tkcn4my8UeVwBQQfG6gU88TkUyTaRRvuKqXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K786/Ugs; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K786/Ugs"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66f883abfdcso6248073d50.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977900; cv=none;
        d=google.com; s=arc-20260327;
        b=qxmTkyWX4KSL/3LFFOURESWYnASlKRoul+Lf7SPCMcxQyYKcresIsotc1Zg7V4rnQv
         hAI+iW4JfeqpYD6GO0SBb1m62s+LarQlZ9AcA86TQmHY+R/K89jK08Z5kDiC/Q54NevY
         98aPJfGXpIwsXxqv2YaYcksXZ6LzSTaSnxgz0vZWCR4jNWCJG8piRSx7mGPInIXUCtNx
         9lj+4uAEoiw9gnDNI+ybYOkxMZ+mbpBk7Ob5d9SsceCrxKYtDahL4qrlFbkgpdMJRTtL
         50H4UnmgSSYhCKitkxU5gN28D8qZu6GoCUHRUt6yEnL9n77P2+a563JVGZO5zfH7Iv7B
         RLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        fh=/JLdD3FhZcs0suMIkb4PJY9LaLEDvrYl8dgSfmunhH4=;
        b=W8D5xF5PsvFmUbuI5mTchxWhxf9QL2EzdC8XaoJMJwCe5uqdPVj5aUXHluQirv2Se6
         b56VVqYpzcMfzJxjTJWo6GdBeQMUWpS/DFOt6P1AXC+XFffqAkpzP8gG/sNqTeWMRLGu
         W+YA4z1eoI6odwc1sjBzXgW69cEXrsjNwlGuoBhSwkVTdrwhPmgFhfCFWQ1uzNooH93B
         qjhNYxMAa/Bwa+ec/Q8coLh+NDm0SeQ6LQNbt4XO5MfQlcvZtXg7GmrIthu5Sn/qmV62
         oITPUNhMVepARze7kDHBaj1ZhqU1JIU7oZ4FBDyc6zqFi0JGfN1ptMuaB2xuTRbC7otF
         xSeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788977900; x=1789582700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        b=K786/UgsWJ13mRcFVosouCsAqsW6E3/kB3B568N2Cf80edSGyVZuDTDeiQwOOzPWUJ
         +ItaDTNfEihzO5M6PHu+v5IxS8xZR3B7+9YhBuQKcn+MdjtQr17l5FYNUgUdLSdZdbnA
         ScmCKjTF9yaAjUsdzD02XeKJenV/vSSQN8H7gRKpCCxyG3C6/Jvy86/EH+SfYAlKJIdI
         9LqxoMOEcMZQKfB+2dvrgoahLX7vtynmozey13NE5eRykP77De179uAmsNlJkUWGMfrO
         dg2benyomZnIWpR0K4fdcCEgkCU40WoG4zIPE9+t9tcqfuyaANvdXCt/JLK5pHjQe9Ra
         tM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977900; x=1789582700;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        b=MNRkUfjS+xYcjpPW+6b3XEKc1SSryj0MNY3l2A7oGaVMAxr4NF7ejtuhrFv5FczS2M
         C7J3sbtolCJLNNlaiL6LRRmX81ej61Z3jf4PswQWZ7PjZhKsfKKi9aBkxLjqVKq8mu1E
         jyP3R1THYwPKPlovlIMKHCUOefo7Yhju9yCSTH255PdmtkD4i0XE9XZAddYEAv0MlvlP
         J3rZ+QH5oE8XBnvcvU+ZQVvA20fn6AUhWpnxJtu9CYwzaYEOVL7eWWxCHmXxEKU737qc
         iAANhw/2T4dEa5EjRbWGibj4ZvkIijyyvQLuoqfX71CIAm+jIlXbKIj3rSWW3qiWlxKA
         gwvA==
X-Forwarded-Encrypted: i=1; AKwUvBx9l+Sx8KKzC+YUdlG24b5IomDtB0aGe/mJhAAjMRAIy1OxRt/yZsciTWqqN8EHQvBGUqKTHhI=@vger.kernel.org
X-Gm-Message-State: AFuF++kNEtkap+8KvmZKm/9u7gJ02g0nM6WYYMxm3J+yeBLgOzmbseek
	0otYuEPZsKL2nALFQY88vp8f1Fx3h0bSDupRCIJ36Zn+aXczp57XqUURlsRNKwHccIedicVBH5I
	fWhezd9cAmLqScfVkQBnN/68u7UL85IQhdCsPn1rRiA==
X-Gm-Gg: AYBFou26T8T3s1jUglcTRrYO9bpkycdk1jYZqq099met4n2pI9QJUC9+Yfsu2R4sdD9
	bpXd+byroG0bARNQ3JZzMnc++yBi02WGpxZO+dCoYv23XRQs0qNqPeM+1i/3+5KS6zvLPWvQWgj
	PeAxEZmKXOLcPWJXOfAE6ztX/TIwc8sgLwzXteEuWQ5sjSekYE06q+urk1wsilqOZVAo4foU4yJ
	K1xzPtwkOTeC9+iLEBV2n+ABNCp6Hf1dNfRMUofgOpZy1LZtjOJtRS0Pq4sgEwXOcHlwPdK9DN7
	Mh4c3wbHtM2jfgfsN/0YgWVFS24MyigsYmDeqzc256ONTznTPoFDzn8=
X-Received: by 2002:a53:dd04:0:b0:66f:c1bc:4033 with SMTP id
 956f58d0204a3-66fc1bc4591mr8088674d50.96.1788977899985; Wed, 09 Sep 2026
 11:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192129.557377-2-bestswngs@gmail.com> <20260909040807.3885815-2-bestswngs@gmail.com>
In-Reply-To: <20260909040807.3885815-2-bestswngs@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 14:18:08 -0400
X-Gm-Features: AcwNN1Vllz-TAro1yIo4gS9pQ0u90xlbBvVitrlvw4Rqq5UUb-P30JRI5SxUS38
Message-ID: <CABFh=a73wXKY--GSfTTp6X0xcKVUNr-iUnqnJO3rZXp7RLvKjQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
To: Weiming Shi <bestswngs@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lebrun <dlebrun@google.com>, 
	Mathieu Xhonneux <m.xhonneux@gmail.com>, co+adfca3e91be95776@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:08=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> An LWT_SEG6LOCAL program can invalidate its cached SRH with
> bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> Post-program SRH validation then writes through that pointer.
>
> Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL programs so the verifier
> rejects this unsafe helper combination. Other LWT program types continue
> to expose the helper through lwt_out_func_proto().
>
> Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
> Reported-by: co+adfca3e91be95776@bugs.sh
> Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@=
bugs.sh/
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Link: https://lore.kernel.org/bpf/DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Changes in v2:
> - Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL instead of adding a
>   wrapper to refresh the cached SRH pointer, as suggested by Alexei.
>
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a8..2a84f9d011314 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9044,6 +9044,8 @@ static const struct bpf_func_proto *
>  lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
>  {
>         switch (func_id) {
> +       case BPF_FUNC_skb_pull_data:
> +               return NULL;
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>         case BPF_FUNC_lwt_seg6_store_bytes:
>                 return &bpf_lwt_seg6_store_bytes_proto;
> --
> 2.55.0
