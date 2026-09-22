Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F632EEE67
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036583; cv=pass; b=NPFSL9fInrk2o0O5PRTen4ySF2wnwREWLEL5tXWNlZy/bdtt7wXm/abLRs5YXnfPGR8kuF1hEQzVwwLVIswYXcirKp+YLEdbQcDGGXPQoXGUx18/BgK8y6n/eATGHJojq3ZGXhuMNQ6oFdAMbyn0wirF2VRZcVQLLAz0ZcOHK4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036583; c=relaxed/simple;
	bh=BShgQSnRDZvpdNI6IHTdW+TRccJX3xOCsX6/sLv8Q2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax5VfkoVZu9VGe4Zf8c5Y+7uFR3k9WQado3Jk9xb/6SglXt+NpS91eK3nUxbLhrvV1IY6ls0P357uouSdq0sLDdy8SURiS59AuRmg1qqxLWZvqvf97/Pz2CM8KeB11Z0TaN54VsoYRWHYdTidfk8z4dvUpFiDKaQwAACmXbxlXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtNcEtqy; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtNcEtqy"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530de452c33so30274111cf.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790036579; cv=none;
        d=google.com; s=arc-20260327;
        b=IdV3HlQHYUzvLpozl4aMGDCRrt1i9EMsVkXchYyxy8W1KFHyN4xREJw2CR97z3AGfV
         IhqJHmjgGbcW/hCD2+lNy4im2Vwzd1g5uF8EYseIRrLSCOtPSwv0ldaNu3F0kYVVDR5X
         nuwkYwmH931l/66DpSDm4iGEvv2FDyNQI00EnNuFbsH2n7rnUQh3iyCi3N0jSFKnyCde
         OwN2pIs7ugOBG4NQRaE8dxTLNMlADKVFKwY5v2vTyrKyocTi3MXOjcDJxxH4+FKMOJtp
         Zr2QQ9/NSr63O0DRnHveUDRlpsFVX31u8hUxLPhdYpgbt1ySu7ss3HXGmD+yCyltZqI7
         Cb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQN61CI3XpI1eI/D+U8aClQsfi0fYX2Xsqv28eim8Zc=;
        fh=6zfc34g9dSC0U+f8Tklj1Fl9FF2409hSLYzYwy9S3Cg=;
        b=p7bfEANPETOtb7oh+ruCVwkSHQGjBvym7HrSYLHjZ3zFLVSz9pcpzKOmC1AVqYfPv9
         u7NbVz2pY4s6eO8RvhDoW+MIm/exZORsTFv8lNKgNqTbzpdxFaludZrhxLHrZtqGYFJ6
         /gA6LcykvUJUWyn5wwvbXj02GTWUgnn2swQHgyDCnXlIOX8mAIqhp46iimgf+QzP32b3
         KmapLiHq8qtx7Be6nIBhtOiNgJAkyphbfff1NP0OXIrBdIvr6As/PSrR3h+z6sOQO7m7
         dYjs5baosOwt2nIWG57tsZ3i1L0N+i1kbtNuoQt26n5dt7rcwtYUI9ez+zVHt8zqFglm
         hmMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790036579; x=1790641379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQN61CI3XpI1eI/D+U8aClQsfi0fYX2Xsqv28eim8Zc=;
        b=KtNcEtqycm0Va/NFZPwU7wbAc/DEpZP8h3h4AeQLWYk4rqVRTsEuk74K3Mb4uiV2AS
         Z5RGUd+98dix+C5Ndc7NhmckQEKF3zW6/tzlRH1mG7X+8i4UGsOdnVKvrghyjx/YV1gz
         vJ+T3056EkdcswEsV43DG8ZiANpTVtjpnhndFXSAVgtyNn/41UN/u5dkJJuxoOT/RgsC
         iFW6oQuJIYTMXvQqlJvZSUr0TCtEr5XdpRR9K41g+SdCJhQ2X5zDKwGRS7wnFaqgiK4O
         wkYH+H4gnsjhhzZFiygxIlhuXJffOLN02hT/UcWhpU4KuhvRLNxGGOf5Fdd6Zh+Z2si0
         C8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790036579; x=1790641379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQN61CI3XpI1eI/D+U8aClQsfi0fYX2Xsqv28eim8Zc=;
        b=kOGNGowxOs+t+35I4oVaLnuK59IHsRFkNwuQHN6jxO25zKBVLqfVpZpSgC19C1/oCH
         YFJwiQdeAGkw9g+2+qxxrHeSHsd6+HrfxGCJ/LHDSaxgOWT42d/v8LgsRWUq7ecZy3ac
         taqBbSUPK1Mf0nZPMg0ERu6kusvWTzUS7z85E4v1lpyHDwlYaTqk8DzOoZF0zCVDrWxH
         wXg8k29TGqxo9sI7hOuD+qCijuEXCzmyqdZjZXFcgfu1dRIgGDrqQHqnQhBkwDhCGs9j
         1xjoYpW3vUTH3rVurFilcLj8bf+jPGM1EgDldJ7M816+7W9gyHBHwnZlAq3GrWdHlUAa
         Fp+A==
X-Gm-Message-State: AFuF++ltSP7gx1rfnoHhlDZmnybPucH9X5UotYsd1G7qrTbCrM0pua51
	NIwK//GpuPSWiqB+JbGSvButBaP7wDrh9J+DCS+Gg/2CHb/K1mN1cseeeEmN+5mYnPAUL9n3k/f
	5JCTxQNbSezvLUB3tZAUSvbY4et1kHgM5yPaTSW9Y
X-Gm-Gg: AYBFou0Vg/rQCd0te+nHwDvJbVfQhxmbQ871jQovwabuTX3USFFHxxTN3tr6PJu3GR3
	4E9yRSBv8zvBb+Qbl2H3/CpdpUjvKjLz+JBpYhAt4PQpXg5H8MDQkr4CBFy79JVDkIqroOHUldB
	/hj6y+vJ2rZuZ+yozeKPrevRfyEVFYLSgNtcVBKL6mWUVzyJo5/3ehjv9rAmp+xdyn/gZUV79se
	gFSRK8SS1S8H78T5qWqHRVyu/QSfdZA6xZgN8s8Kip3G6SM2A3/QGpyyECfPlbUltdo8ZcMA43w
	V/XBeZQzWA8bHmcim2+/efESZjPQt2kP5l5y6T9hZh0+1YQZiEY81G4Ftr18aS+E+/wRv7A5flx
	O9O6DSva8xspaRlQ+A3DOMs0i7Cc1U5iPIK6Hpxf/ua4xilovVJPKeyu4GNynMnIDhsqSDCn3Yj
	GAKlRl
X-Received: by 2002:a05:622a:4d1:b0:52f:b9ad:9dad with SMTP id
 d75a77b69052e-532d8e379c4mr30898621cf.36.1790036578472; Mon, 21 Sep 2026
 17:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921222609.50824-4-jeffjo@openai.com> <20260921222609.50824-5-jeffjo@openai.com>
In-Reply-To: <20260921222609.50824-5-jeffjo@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 02:22:47 +0200
X-Gm-Features: AcwNN1U8yZYsoXQmu5K6WdHeMLLadZtQsvSs1XAbGHZMJT-3PJKd4bwNzD67oNk
Message-ID: <CANn89iL6dWUza+iZeUwtB8b9V0=c6T3jPr9gOrJ37CJppiQB2w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: refresh TS.Recent for accepted old ACKs
To: Jeff Jo <jeffjo@openai.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:26=E2=80=AFAM Jeff Jo <jeffjo@openai.com> wrote:
>
> A TCP packet can carry new data while acknowledging traffic in the
> opposite direction. With overlapping traffic in both directions, a
> delayed packet's acknowledgment can be older than one Linux has already
> accepted, even when that packet fills a gap in the received data.
>
> Linux accepts the data, but tcp_ack() takes the old_ack path and skips
> updating TS.Recent, the timestamp saved for outgoing acknowledgments.
> The reply therefore echoes an older timestamp. If the sender uses this
> echo to measure round-trip time after a long idle period, its estimate
> includes the idle time and can reduce its sending rate.
>
> Update TS.Recent in old_ack using tcp_replace_ts_recent(), before SACK
> processing can trigger a transmission. This reuses the existing timestamp
> and sequence checks, including PAWS protection against old duplicate
> packets. Leave SYN_RECV unchanged because its caller rejects old ACKs;
> established and closing connections accept them.
>
> Echoing the timestamp of the packet that fills the receive gap follows
> RFC 7323 section 4.3. In a socket reproduction with 300 seconds idle,
> controlled reordering and retransmission to exercise timestamp-based RTT
> sampling, the sender's smoothed round-trip time was 37.5 seconds without
> the fix and 15.5 ms with it.
>
> Fixes: 12fb3dd9dc3c ("tcp: call tcp_replace_ts_recent() from tcp_ack()")
> Assisted-by: LLM sparse
> Signed-off-by: Jeff Jo <jeffjo@openai.com>
> ---
>  net/ipv4/tcp_input.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 92bc60716f33..f3f4c905ce00 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4465,6 +4465,13 @@ static int tcp_ack(struct sock *sk, const struct s=
k_buff *skb, int flag)
>         return 1;
>
>  old_ack:
> +       /* Closing connections also accept old ACKs. SYN_RECV rejects the=
m in
> +        * the caller, so leave its timestamp unchanged. Update before SA=
CK
> +        * processing can trigger a retransmission.
> +        */
> +       if (sk->sk_state !=3D TCP_SYN_RECV && (flag & FLAG_UPDATE_TS_RECE=
NT))
> +               flag |=3D tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq)=
;
> +

I think you missed 3d501dd326fb ("tcp: do not accept ACK of bytes we
never sent")

sk->sk_state can not be TCP_SYN_RECV at this point.

Therefore your patch could simply be:

if (flag & FLAG_UPDATE_TS_RECENT)
        tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);

Thanks.

pw-bot: cr
