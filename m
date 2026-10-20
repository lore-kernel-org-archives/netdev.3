Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792469529;
	b=WX1tDEHNyP9r25jdAHaQwIHHTkY+XiEMn7LaMQk67fzyVp/dNTE2kZHgbsQLLQELteZQ
	 XNCSardrsCNn98wHgLcCLkPaFAp0tOwzBsrji+XYb5KVZcY9xLP6SVqXz5T0/BmF9j0O3
	 Tr10T+dqVZAIx0ZZ7eKNu0Bn32MHNI5RhXLk6mQukaxn58yzkY79vfEGxcEsqeE3khmwo
	 aftRHf7F0c8ds+GWaYR9C0CgthZE3AXmVneJUuw2EFdyOm0ALUpNhxksrpKjwHUm0ufgb
	 lGwzbOeb6wnweXma+NCxd6gh3A+/N8kdyA20tNKi7xEUoJvfnF+SykqBkODDFBJp6jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792469529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=uAQVeBdqF8iBjUZznDFAjUGvJNEGAa606+53oDaEyLw=;
	b=W3XzdfRNiJZDfxE4wgM1uHT7Rh5a9qOln1qeNIUukaHGs1gJ7XMF31aW0KkXVhRiBx0U
	 1tbET9JMMpC8kTaxCuswX1jxOthrZwsh8hBCPiDtIgnnuEubfYV9nfpgPo7VDOar4SJ9y
	 nhipR50xxh5k1iMN5xAIt7pz7nHeVsPRj0ZN+bvAsK20WrYRDVZTDsLbGtZe0UrnkXMqg
	 6L7qC7WHLRl98fJSnvvsJy6keBbWVWOwgG1u8Uc26OFbpMqLfjgtu42k3qzoTpCqkQbAi
	 j/RR6W0ihgM46gTodNiXe/kn1CGPTuo9TMtVj7oPj1laavYc5JzlsotnevKQ+3XFhIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bREnexKh;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CF606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8CF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bREnexKh
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89f2846ab57so2923513b3a.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792469527; x=1793074327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uAQVeBdqF8iBjUZznDFAjUGvJNEGAa606+53oDaEyLw=;
        b=bREnexKhXahp6Bc9honRucDCkEreBwjOPgqmKVZi1KCtuI8Gi6q1oSNXOTDgPw0cp6
         fXmDAVsHL5jwDGgSRHn5ZAEAkzYoPmRFdw/ut6rUhCb9zgKHLTbN4PdY4IBClV/rvIhZ
         5oDaJr055lhCGmZnScl2BHVfWPcY9PtiKAvDA7WiFmAVgGMI/ID+lEUv/hyplMT2jz7Z
         p51zsTmvLAgXQGfVLGtENWquS6NPwrLqY3n5OOb0hWGX5HDnxJEfhpGPy2PZESQu1Q7C
         hd9k0FXu7q3vcN4/DUUXA2/ekGm4LWjYRkXqaHx4zoh4iusbjor2W9B3eBU12mdugD4t
         U0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792469527; x=1793074327;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAQVeBdqF8iBjUZznDFAjUGvJNEGAa606+53oDaEyLw=;
        b=RqLnI4JPb3ayeVix5cppGYR4neTghLEhgED+Csjptf+gMnr75iTVBCPyPhaNLa3egi
         hwDDyg3WCWMzcQReeE5NZ3gtLV3EdA1dC1a10pLricGuTvi2L9tPb7jq1k2s4lQfS+Q8
         ApHMEdGJUFxioMyKBXvSc3Ir6VH2UNcR5p2duesHedvVER2i7s4UKb722WL0Tzl5wqQ+
         cbobvwd2Xky6nGgA1VirY+EUanG4IdJy/bXzW8a6GRquKtckMu6T+JgNePc3XG5ZeBTk
         TsCAC58zL/mMpE9r6RkfwjYTzbC/qhULNYT13B6k/DjhPGyjTe5h3zUiIGFo2qgKtiFr
         Oi2A==
X-Forwarded-Encrypted: i=1; AKwUvBw3MHT0Qbx0XtxS4hMcOtCN1K3tAboPXwlVqzbpWll6LDDiX5rnKvXvgXXOS25Dmf2JzbA+ntU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk+PKeVlXdMwEBCtS+l6h0Wa1DsPIkt34eYfqI81pwoAkHqZj0
	HOt/KFWdHSUSedixnfM2x09j/9M6eDbATOh+kikY+T4eK2nAYIcM7LIJK3TDKQM0LhB7XV61eGL
	sYk75aw==
X-Received: from pfbcj24.prod.google.com ([2002:a05:6a00:2998:b0:889:4fa3:fafc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f12:b0:89f:9da8:1b66
 with SMTP id d2e1a72fcca58-8a04cc2adfbmr7226294b3a.33.1792469527213; Mon, 19
 Oct 2026 21:12:07 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:12:06 +0000
In-Reply-To: <20261019174152.2932829-1-cjubran@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019174152.2932829-1-cjubran@nvidia.com>
Message-ID: <atbp-Zxbm_Os6-mT@google.com>
Subject: Re: [PATCH v3 net] net: skbuff: don't copy alloc_cpu in skb header copies
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>, "=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 20:41:52 +0300, Carolina Jubran wrote:
> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> headers group copied by __copy_skb_header().
>=20
> This is wrong for newly allocated skbs. For example, skb_segment()
> allocates a new skb and records the current CPU in alloc_cpu, but
> __copy_skb_header() overwrites it with the value from the original skb.
>=20
> If the original skb was allocated on another CPU, the segment may later
> be treated as remotely allocated and unnecessarily deferred there when
> it is freed.
>=20
> Move alloc_cpu out of the headers group so it is preserved across
> header copies. Copy it explicitly in skb_clone(), which allocates
> the skb object directly instead of going through __alloc_skb().
>=20
> This was discovered while investigating a throughput regression with
> software IPsec. The load used 512 IPsec tunnels carrying traffic over
> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
>=20
> Before the fix:
>=20
>   16.09%  queued_spin_lock_slowpath
>              |
>              --15.90%--_raw_spin_lock_irqsave
>                        |
>                        --9.37%--__slab_free
>                                  kfree
>                                  skb_release_data
>                                  napi_consume_skb
>                                  mlx5e_poll_tx_cq
>=20
> After the fix:
>=20
>    6.84%  queued_spin_lock_slowpath
>              |
>              --6.57%--_raw_spin_lock_irqsave
>                       |
>                       --5.00%--__slab_free
>                                 kfree
>                                 skb_release_data
>                                 napi_consume_skb
>                                 mlx5e_poll_tx_cq
>=20
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
