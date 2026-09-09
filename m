Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A936B903
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974347; cv=pass; b=tBD+ZhT9aNPoEhtjJF7DAE+5p/yf+xYjMLBKT+GEPTOVG8S2JLJkxroB7mR5OsyAIjd8ayOm4836fUzagGOcS/f9gshj8Yfz7sw0Y4h0qXxAFa4aUp6KFwSgbPT3Nvz9DjCkmuHq+cWMIGAap33/Mfm20ncl6mzHQkyQFuYu1zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974347; c=relaxed/simple;
	bh=BQ+Hst8gOUWR37L4XOKGfAUQBTOzIL1QvKMGUdQMdVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiIf/zprz68zGovuUR76Bmhe1TIr5yU7iGxoWBXWRGEbLewedDwnNfSnWL6GKt8ZpFkez7fZW/+OCEAt96V46eLx0PmT0S53EOWlNMc4/Y/Y8IaK+KvZOA2hisOccSQ2wLCTlo5AU9dNgIAGPZ1Vs9cexnLxYXnkvZlWDygjP1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=z5hGrFdL; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="z5hGrFdL"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ebso628796d50.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788974345; cv=none;
        d=google.com; s=arc-20260327;
        b=i9jv4D5XRqPrg7dfJMnZTWMYTiPGsngZOux2A8XYmN3OV2DL7QAViLvsYhCQMs06NM
         CpPehKRMJfcMrdrTx1i19gTAshuCWzW0ZkWvi294WEXB6eubj4TicdUtOYSDRt/7S0db
         wVRoGd2VeCc7+4TMbokT3cnCsRlUMpccFkZLAlVUcVJ09sfGQQlATfY0IsUkntiz0CxP
         2VzZcd7U23n7GepMpoZUiOKbydbeStAgsXpo3VG4dT9ADAMIOjGobLcfTv71itBvOgsN
         Mmuz9S7rIv1s4wWkn11kCp3eor8t6pJJJAVNRVCSeaeX9kup+zKwUg9aZkwEsORPPA9d
         rpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        fh=2AYlzT6mxEk0vegkYyOM0n2HIynp+WOJj4mGJHorhi8=;
        b=dSWZhnaTzBkFIsOLUGtSnQu7jOZM2PWT6oh0LfpKqxfGZJt9Ma2eBcdCHNQE2Sg2mX
         6wvWVIFp4zUoiAp0aZQBUpXn8zG52AaZl1nMcKOpKHpQQFyNAUrLS2YMylY/ni67QZKs
         /qr8/RrQZ9m/0pPiJPsgqmHeMJL1TM0uSK+4G/4QQ2RrstOv9CtT6ZjcMdYyiwZ13u9+
         KxHqLTv7DJOEB401ceQpv62KuwRvT3OhSvjeBUoQCv03ziFtblry0zcDhRkrr55JI71X
         RKFLfd465P9E4WU3yicfa0qtPdYnhdQxxkGwsPkd4bpeKaHRzkk+Wuc+CTlfBK+h2HRh
         t6rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788974345; x=1789579145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        b=z5hGrFdLgDm+Rboba1delLX9FtBlGxiqFqtudICHSpjiuW5vLNEDkDrgXRLUm1PXXg
         kLmD2HNMODCvIVFA8LA/2qGCV2uYXs85B0YZxMcn6U6pToLCx6fw6XKfnjI1NT62uQ9m
         NQcfRaQvAnUtYKnCqle6DedFs4YvKDjGIKJlYdRZJedWgD/D8g37YzjaVGuuvzohaFXp
         9pMU6JoGGgOux4/Fadq7gM+tY8ttdQWnQGyPgBzhHyccVOkEMqNJkVOsQdUqxszwPgoX
         PRv9sM321iDCHK5aydwxCllwGLdEq57cHpyBW70GVCfH2jzsP1wpZLE0afTHdNvqgtv6
         LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974345; x=1789579145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6E68RRU9n5lqapFJ2+/cJtqMKWFxDFCie3V1FAMd+4g=;
        b=NeTsYHE5v24dvMuxxvjEuiu0/S6+VyvTNosvX4C9XW/x9uRh+T60Mcry1YYuIaT+Gt
         h3k6rGpwz3279b6Yj0Z10gI9XPe4AnKPKNerQ7EWJ6tRbyURbFL2EpjID/ZmosvmMfRp
         nvLjFB1dYL+8XeG7M/NDeygQktyMJ5+20dR8IWgl7np5fnHZtfWsYLsagGDE/KS09aFN
         RyIx+m412NKO6FtJlLcNDdcR6FkLgBVuA2VM1FCt59574JUK+ZEWcMlshQXmIZoZjZX8
         Mp90dmpiUO8U3hTa6Kg0KwfB/gx1BVt3nqtzCj2g84txETBEgDAqJfqNwQGZPtcFglYO
         eRxw==
X-Forwarded-Encrypted: i=1; AKwUvByAyauszl1cyafcR2+alpr9TsCrhy0z17E24S5iK54Ojoy3gYkRB9xbRVqSiUv2CG8Y7Hl4E5o=@vger.kernel.org
X-Gm-Message-State: AFuF++k7xqAYxt1bcRF6jnNYmppITqHmK+0HwIdFNrxrBtZ3s7yJfScL
	WofbK0f/E6MB+VtX5YvnN0KpzPIo39x00RPZufgQWKyjCtQQ1F7PWCj58LKECH4eZCTInOuBJlI
	TafXgJNyr1g6Urkx0A/P8bhlvaOlbOiUwcOdKXUK4vw==
X-Gm-Gg: AYBFou2VjVMpJHbR+nAj7ON/k5E6j9xhUL34xN9+xhaP9PNVwBMmcXt60JntVWDpoNL
	fORyHp3B28h4zSlicJ+9Nqz82d4Yth01oKlGGDnJirVcECD8CoNh+2j5k+O/XdyO3gAiYPEWmvG
	seRh5GA9D35suWFFCcgY4Xwaa9L0r96PyBcs5je9bbAZ1YmE3RsoqDRczA/a9zqZ2vc6zyCtYg9
	sVMKZklXWDhxeIc2bq67BoWyLO8lQsOTPa8E+BxRTu6aOlJOS/RWg1yNPHXuPNpCrPOedWenCly
	se6ZYhI4bS1q4DViu2k27z3ffc+VT5P4l77SaAWEVfmz7H6YzGD20PQ=
X-Received: by 2002:a05:690e:1407:b0:66f:c284:4806 with SMTP id
 956f58d0204a3-67110027d40mr1411230d50.66.1788974344494; Wed, 09 Sep 2026
 10:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
In-Reply-To: <20260909024011.1252694-1-nikhilljatt@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Wed, 9 Sep 2026 13:18:52 -0400
X-Gm-Features: AcwNN1U4pDVgjWmRTrx7PuoPtmF0Fx_Otlis6cGINQ1Y-tUySGzn4ekMF7-3TDY
Message-ID: <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
To: Nikhil <nikhilljatt@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org, 
	razor@blackwall.org, stable@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:40=E2=80=AFPM Nikhil <nikhilljatt@gmail.com> wrot=
e:
>
> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() copy the neighbour's
> link layer address into params->dmac without any synchronisation, but
> neigh_update() writes neigh->ha under write_seqlock(&neigh->ha_lock)
> exactly because there are lockless readers.  A BPF program calling
> bpf_fib_lookup() while the neighbour is being updated can therefore be
> handed a torn address, and XDP/tc then forwards the packet to a bogus
> L2 destination.
>
> neigh_ha_snapshot() cannot be used here because it copies dev->addr_len
> bytes while params->dmac is only ETH_ALEN long (an IPoIB egress device
> has addr_len 20 and would overflow into params->smac), so open-code the
> seqlock loop around the ETH_ALEN copy.
>
> Same problem and same fix as commit 57549ab90791 ("net: bridge: arp/nd
> proxy: fix reading neigh ha") and commit b824059a673b ("vxlan: fix
> reading neigh ha").
>
> Reproduced on x86_64 under qemu: a dummy device holds a permanent
> neighbour whose lladdr is flipped between aa:aa:aa:aa:aa:aa and
> bb:bb:bb:bb:bb:bb with RTM_NEWNEIGH, while an XDP program driven by
> BPF_PROG_TEST_RUN calls bpf_fib_lookup() in a loop and checks that all
> six bytes of the returned dmac are equal.  Before this patch: 211 torn
> addresses out of 16300000 lookups (last one aa:aa:aa:aa:bb:bb).  After
> this patch: 0 out of 38060000 lookups.
>
> Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in ker=
nel FIB table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikhil <nikhilljatt@gmail.com>
> ---

Bot is right wrt possible lockups, please adjust the seqlock
accordingly. Also please
add your full name in the SOB.

pw-bot: cr

>  net/core/filter.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..6fdb85c9af44 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6298,6 +6298,20 @@ static const struct bpf_func_proto bpf_skb_get_xfr=
m_state_proto =3D {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> +/* Take a stable snapshot of the neighbour's link layer address.
> + * neigh_ha_snapshot() can not be used here because it copies dev->addr_=
len
> + * bytes while params->dmac is only ETH_ALEN long.
> + */
> +static void bpf_fib_dmac_snapshot(u8 *dmac, const struct neighbour *neig=
h)
> +{
> +       unsigned int seq;
> +
> +       do {
> +               seq =3D read_seqbegin(&neigh->ha_lock);
> +               memcpy(dmac, neigh->ha, ETH_ALEN);
> +       } while (read_seqretry(&neigh->ha_lock, seq));
> +}
> +
>  static int bpf_fib_set_fwd_params(struct net_device *dev,
>                                   struct bpf_fib_lookup *params,
>                                   u32 flags, u32 mtu, u32 in_ifindex)
> @@ -6491,7 +6505,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>
>         if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>                 return BPF_FIB_LKUP_RET_NO_NEIGH;
> -       memcpy(params->dmac, neigh->ha, ETH_ALEN);
> +       bpf_fib_dmac_snapshot(params->dmac, neigh);
>         memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> @@ -6644,7 +6658,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>         neigh =3D __ipv6_neigh_lookup_noref(dev, dst);
>         if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>                 return BPF_FIB_LKUP_RET_NO_NEIGH;
> -       memcpy(params->dmac, neigh->ha, ETH_ALEN);
> +       bpf_fib_dmac_snapshot(params->dmac, neigh);
>         memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> --
> 2.43.0
>
>
