Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707337CD41
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598444; cv=none; b=giO2vfjItIjCn+OiwbnaOa01vI9DfkCWrCNZ7jrkb1UTCIpsiZ5yxlsC2zs5gvzYhFOrtUMNKC/XJXts1Cdor1gRBQdURpZT3BHqNCQJwoy//CRITaR08B1/GHPIrNBhDnJiQWzL7a2l9jiAKajHFPKat7XrzZ8/1EEh6QUT7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598444; c=relaxed/simple;
	bh=4xRrO4B3e496ASKCjYqD1h6zJkGdEI5e3kThLtCQ6YQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EsAsJWdq1/G3p5WalIQLpkIlRb4cFprzKtIidtg2FP0N1xqqLWkpJGWZ+jL+Oixlo8uqXTXtmGZ2ZaR5tXjPZxcyUFlK+dCNDVz68cCU7By/yQsCE9wc3hO8hEbKwezsFFFwCrNepCuWpPFrpKMmdKM5VIG76Ysmo+CWgLiHywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imY7tu4d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPRaeQHE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imY7tu4d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPRaeQHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790598442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8lg97mY9vEh51cxwOINZ9ICG6PIesTeP5CKnCi+ODo=;
	b=imY7tu4ddQrXUIbs5/FCslhbjmVfSREPkM2RHqx56T6/mlt19u3zvJD538OjKBYf8vLNv/
	QWSX7uQeRKGfjA01eDRCtgcHXGHQr5kX/h+n5a8/7XYrkmsqy75AUV9r1hEo/rEU+jpTpB
	2NJEbA//9WWudaOzpwBB+Yy7JcOqEgs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-hVHGlAcjNtmZQivJpTOuzQ-1; Mon, 28 Sep 2026 08:27:20 -0400
X-MC-Unique: hVHGlAcjNtmZQivJpTOuzQ-1
X-Mimecast-MFC-AGG-ID: hVHGlAcjNtmZQivJpTOuzQ_1790598440
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29959eb71fso299718666b.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790598439; x=1791203239; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8lg97mY9vEh51cxwOINZ9ICG6PIesTeP5CKnCi+ODo=;
        b=SPRaeQHEycH7vpY907OglMYmB+iGE01mYSSMu53+WeTLGN4TCZ4Ya6b8yWcS+/pIJ1
         92IKeTZ0lb0VpCl2c9vDbRlMajtm699dFqtA7A/UP4sF3iHK3QxGt+uCG3HY1jEbiKMC
         nwgPExi2b14OVphKN0Qy4GWkn0N9ytBUNKMUBt3UkJEIrqCIFTYlIQlJRaaiWqOzsxU/
         3urUdCfQWVRKybroQSlRPJeEe8SpybXg7cvEvwz55Wp4VmQSWpYJnYLzwaCoP1Ht1oju
         W6Li8DlPjowrijez4CC5Zq9E1mM7Ntr8r54dl20onkpmep4CkVfRDN6Q62QR0LHJqV8l
         Yk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598439; x=1791203239;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8lg97mY9vEh51cxwOINZ9ICG6PIesTeP5CKnCi+ODo=;
        b=qv0tADUc8/9cIXBcVSWB5oadbuGu7u7zDlMdOO0VqOcOCe0/1/a75ZumfESnhsSiEp
         c3DyK3kmUpOpsf0SI0V6CBOahaRE77QtGZfxvmStSb8IRhQrUIZngNVwQWKM/JW0oMef
         2n47pHcTEwIVVTswYTC0v2afLu8MVH8tam+a5KC897yu83kXXDb+xfndbqHaD2O6qQy8
         +NCFT8Xqz9baajhgtooh7k1Y8mMYWxgwBEPmtqwwcaycA/T7Z6heXKVBdZ67Ca4dr7zr
         qjtCQGDpskZNUKYa+ivReE+RAVuwm5U6hfY0/mHJIbgihHeJgpHpbNCFdbbb5zrcyeN6
         AgQg==
X-Gm-Message-State: AFuF++luMRQtKXNnc3cAWZB31h6NfS8wDXz6s3ixoG9bhge7eKojPv5I
	jGFe6pGtLcON6EKVZZ4NFH6iAbRRSZ3rqG7KvL50BzZL7nJiDgMgm3dY3nlpY752mV4XUxnmrim
	v4E5nWFxqNOkWAl1MUXYsoFOh/hf5ZuT+L5H6kk4j436tMtKnrxcNCfLtxA==
X-Gm-Gg: AYBFou2rRwA9Wrj7VEQb7EwL0SptgxiIn7JK8JRtpJhrDpSU2oAD74lYQTQH6UwYqf3
	cDG29OsMVedibEY8ZPbcHgbzjuzWAAm7kWIbTEsfiVzbUcV+xvKSU7PZVKs1silh8ReUhfYSiBE
	pHgun0yP3qEpWM6oDwwKMm+YIMd9u2MX7sFyLHCLCkpm/2SLyzZEpJHtTCjYJ1hoN6pQlU1pfXi
	8DWUtAaWxtFbhbJyRVLQ979bNRoAnosZiXpTuqGVZ79mSWcTE20eGH2Nk8suXQhuXW1HdxnOHPe
	g8akTzyqYA3nkI2EtBF5kNo4SvqGvH+ZUFuVgDTELXbfI0XnURPdPuScy5XV5GJhnKJ+14EKmNf
	FWzgBrCMHrAH8exxJu1Rc
X-Received: by 2002:a17:907:a909:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c2ac53fbdb4mr1041968166b.42.1790598439091;
        Mon, 28 Sep 2026 05:27:19 -0700 (PDT)
X-Received: by 2002:a17:907:a909:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c2ac53fbdb4mr1041965966b.42.1790598438623;
        Mon, 28 Sep 2026 05:27:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd380636sm274820566b.66.2026.09.28.05.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:27:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 504D9A0FCD2; Mon, 28 Sep 2026 14:27:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>
Subject: Re: [PATCH net v3] net: mvneta: clear XDP pfmemalloc flag between
 frames
In-Reply-To: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
References: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 28 Sep 2026 14:27:15 +0200
Message-ID: <87a4p1lfx8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com> writes:

> mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> xdp_buff when a fragment page is a pfmemalloc one (page under memory
> pressure). The xdp_buff is reused for the next frame, but only the
> XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
> propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(),
> so the skb of a subsequent fragmented frame could be wrongly marked as
> pfmemalloc even if none of its pages are under pressure.
>
> Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.
>
> Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
> Changes in v3:
> - Rename xdp_buff_clear_flags() in xdp_reinit_buf().
> - Link to v2: https://lore.kernel.org/r/20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com
>
> Changes in v2:
> - Introduce xdp_buff_clear_flags() utility routine.
> - Link to v1: https://lore.kernel.org/r/20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 2 +-
>  include/net/xdp.h                     | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index c2b1098d8d1d..485af7e395ae 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
>  
>  	/* Prefetch header */
>  	prefetch(data);
> -	xdp_buff_clear_frags_flag(xdp);
> +	xdp_reinit_buf(xdp);

nit: we spell buff with two f's everywhere else, so seems a bit odd to
have only one here...

-Toke

