Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40D42668B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196825; cv=none; b=s1zUeKSuTTp6nT9lQoeNSlgrJPH6dC05JSIRGEEmkMKTbYRd4Zt+wxKKPwXp4O1J+Uxa2DLFAXzJ3OoKauviH4sAQGhs7rbUiRChh3vwMyCfEhwiNkYtXaDWGppuD6QsQSfiW3Rl+54+vE2lmC4jp36y660U4pFhMn35RQRqCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196825; c=relaxed/simple;
	bh=Dk1MPEW5mG9bxfvtt3CfMtvzXRHMQBCjfp7cwnyOlRM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=em8OtWQid8UQJymXeTvLicRppZpUQGKbWpqmWbh8p2zMnBRsh5iHtaRxd69Fv69cG4Fyym7AsvJhmHCzXV0xnjh7iDo2xiy2RK/PGYMMLhUDSosTf/8hIpjD182xF6KX3L1M+WHQYY9wCxRqXrg/JieUz7GDFx7kTDPBAbEXjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=el/nEkc8; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="el/nEkc8"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304e83724bfso177823eec.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781196823; x=1781801623; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV1yJVHjmtpmQuw49fMKDZa3YtMwjdJaARv8Q+M7YxE=;
        b=el/nEkc8aGkWc/8OaLMRGsQS5lixUx96qDGRfw69bbo+eYl0kIQovVSw1gGGOYnbbH
         qh8+NaNjatCJA1f8Nf4MOUfMEtlr8i2NVHGl+m6pnGFvdw+lleGbsZNbIEkYaMizsuPJ
         9H7ygippdhHLLPeOJQpyEDvz1RoYhiL7a8ncVe2hv6zA01cO0kEooBNW2WHF2Sg9uiZt
         KbpqL0EkBn8koAuKtwamoPMx/YVYoi8wEXq5+LW9Q5keJBUr5HmFZw9wfb/HOWz1jgrC
         ujCGIFFkdM4N1kgh0C4AYaUw4vnsw5c/DS5lAwjFXbtp4InTf4GAfEVQrCZFDmNKD2fx
         xwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196823; x=1781801623;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yV1yJVHjmtpmQuw49fMKDZa3YtMwjdJaARv8Q+M7YxE=;
        b=Z7EHKjbozooRqOXYkdRn84pgdqLkrGEilGqqBdc3SJG5cC3e2v6HYP41oHoRFU8QYg
         1zV/ZpeYn2LKao4pg4Ed2JJGDeAihZ7E//bw6i1kmH97loRicoz+JSCx4hmftifVDD6A
         BK599Ft1BspK8hAnsfYi4FWSVp1E+ggAUul9Be8GGuXo8muMVG6wLvuQvJpQu9R8uU5r
         deazVCRcDYtE312VQIVlSe6QV9FOCCo5b/UzPlkaZxySW6t6+TIXfcB94O7mOB1xopza
         NicI86jkQXwKGroB76BYBXPf7nzz02Dh4XOUhnMLp/clQ94C39ofeSQEkxKQgLbwt8wZ
         GP+g==
X-Forwarded-Encrypted: i=1; AFNElJ/p6znx/K4KAZnT7WW1qBqDAQlgH7fAbMz6l5USl0cswBPQo1gff84yETs93lpI0nP+s6NgYEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza22THvevh1ENkq1t5lp8/ez7zyE2LrQuniwCgPsZ+MoOfDcbu
	sNiRU3iwEEiDXgr+BxZqcEhu69NNMMQDQJ63z+28lRRkzZrhSTwm9bcZNrjCdH4akfQ=
X-Gm-Gg: Acq92OEd0xCiPHiXyBZhrLBJkr6DjRTHAkd3UEDKQvGZqdwvzfV3crWz/kz/HH/UQVQ
	iXN/uoMKP+cTTweLwUSm66K767gqds6I+HoorH5oKlES68wuEFlAscIjIjsIkMYERv414N9fJUu
	RJtzvRdbr1l9VUlJJPQh8kcZVTzLN/Sy3Mrg4r5241/PN+hREOf7OVbcNXgtYsRYB+M3P4aoSY7
	7CwUAfCUzoq0t0PktzkTRMGgtcuuv5wvmltdjtfZ19VzKwP1HSKDgXtSNCjGulTWy2hp6uTFDeB
	08EStSXQjMHmywYI2+sxewpOPQ0vJ5lPCvL0esWqillf404q74FI1MgH02PB4yajcw6Qnff0Xo0
	YATn24q5bmkFt44cz74N3Be/Jilpx+RpyO4PzW/o3MMb1wrYKB+wu+KvMgjvoZc5b6dqek9BMhM
	7qUgG8h8ciQxR7dz8=
X-Received: by 2002:a05:7300:2382:b0:304:cefc:5fd7 with SMTP id 5a478bee46e88-30804d42f83mr2516335eec.32.1781196823165;
        Thu, 11 Jun 2026 09:53:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806eb7570sm2455352eec.20.2026.06.11.09.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:53:39 -0400
Message-Id: <DJ6DKQNO58PO.WI5J34XRLBWR@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Weiming Shi" <bestswngs@gmail.com>, "Xiang Mei" <xmei5@asu.edu>, "Xinyu
 Ma" <mmmxny@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Sechang Lim" <rhkrqnwk98@gmail.com>, "Cong Wang"
 <cong.wang@bytedance.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 3/7] bpf, sockmap: zero-initialize pages
 allocated in bpf_msg_push_data
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-4-jiayuan.chen@linux.dev>

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Weiming Shi <bestswngs@gmail.com>
>
> bpf_msg_push_data() allocates pages via alloc_pages() without
> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
> heap content is added directly to the sk_msg scatterlist, which is
> then transmitted over TCP to userspace via tcp_bpf_push(). In the
> copy path, a gap of len bytes between the front and back memcpy
> regions is similarly left uninitialized.
>
> This leads to a kernel heap information leak: stale page content
> including kernel pointers from the direct-map and vmemmap regions
> is transmitted to userspace, which can be used to defeat KASLR.
>
> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
> page is always zeroed before it enters the scatterlist.
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.=
org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3e555f276ba80..6e345ca65ca14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2832,7 +2832,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (unlikely(copy + len < copy))
>  		return -EINVAL;
> =20
> -	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZER=
O,
>  			   get_order(copy + len));
>  	if (unlikely(!page))
>  		return -ENOMEM;

