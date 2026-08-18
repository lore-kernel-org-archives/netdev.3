Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195253AAF5E
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066087; cv=pass; b=L34KVRvIbJyinzp5gMkw02VsncrmCxpOIIavguIhhs3NFnPORKTelVDIK3pom/hvmxOHPM6Ajz2NIo1KTw0uiAlwqvJqldRRGSPxMbUV1Chrp+CZq+fIyaQiZk9yoc81gYD/8C3S0T1zy/d7q98t7u81YAwd7okk0x7TeZwySOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066087; c=relaxed/simple;
	bh=fzWmwlWZP2PVM6eD7JNnl5BuebE2tTQXh7/8k3rwCVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIWGvAPopRUKIHg0IOp/1Pys1NVeTV8A6BQVN21grqmlivkL6ysEjslcg+zFhWoxb88GOxLZVabKXMgZGgKetoW/WOqFb3b4ZGh9UfFq/HqzgNFScN1gYangKStmsTfkvVa5yRErotrbSHYhZBwmAJUbLhzxrIvW6Cuvunpu4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUpah2x+; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUpah2x+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso32376b3a.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787066085; cv=none;
        d=google.com; s=arc-20260327;
        b=YYBRtjGoyMXX6pyGJ8scP0epnLnZmfpdJNhOJ3I8czR2HOqUsJgOZQlziXWDFlGaDZ
         DNOv1RLBtXNs3ULdiUTMyJvWE7jHXf1NmaXBPae/Zs7vqPJf9ecpfu1I8YG+qXXWOsoU
         ewY/JtEqyAdOY6aqFdtjw0BCzMb1lfUGSDH+7txAI82pio3BpsT48qoeb0MEupmGBNEU
         48ZusV7KOpFhfjFyp5a0lABvs4++SIj4z0jk4nkQVQgIVwMCJKZEFSIynf/0UYi5ky7K
         tpe+z62HwSiVtZfTWaYl2K6NprcRvheDSRfUYI/gBpEyqlFQPmvxNsDIbyephDbSAPDB
         J/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8CQGd14/uVzcR48IxI6d4ODH2UhxlQ1SK9RbG2HEl4=;
        fh=ejMhCXq6FQN10KMIrrujllPkw6uvJsmjwKix0AVmdxI=;
        b=O+paR/QAVGPZNb9QsP6CVVP/ek6w3dg2xVLmZLfF+5n3erFiF7wyknxJqzaQvVGv9I
         7cF5hR0Pe9TSV+Ks1pGhoXiULdQvtDTNR3hxQWJnpDB7GeHfZz0rBslDOIWUtmleRZai
         nh38NEhNqzkWh4IkIChacKuBU9bC+Kz0C4XvXJjgPagYbb2acPJFftLGopuACSYQXpNw
         VUoKAOaq2qjzAHLV4I1LQJYRQBzz4z1KkLpcUQaxoTIoBf9wDy5iBVBRt2AjWAjeulmn
         k4rvLAo+/oNtP2IA5xKTV9TRWX1H5gkjqpgV6Bx9MI5BKp7Ir1f3pDq41lYrlF0Iz+/8
         YoYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787066085; x=1787670885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8CQGd14/uVzcR48IxI6d4ODH2UhxlQ1SK9RbG2HEl4=;
        b=BUpah2x+E7j2/artNPPXvQomBuLmnPrEfJ5u7wTNDoiuQe0xbPD9Yd9jQngctTUgRD
         7IlNWmPEQxI9KsCJ4LgNhS6TDGoGLFqzjGjsPCdFfBHCNOOni3FgUTkj+NQfVHg0v7wn
         VVGXgEeo5VMHlXof/VC9JPUWhyffjWDj0h0qugj8R4CXtiFzwcAvPRVge9siw70CCT3R
         W912Nrx73CnagR5yq7WI5C1wlTDJC38WDEqvd20UHoTVu2H39Kunj4ujXGFoh0d7L/ho
         l9+vT3kmigVGZr+A/NehjOo5AiXMfBN0Ok8j1tT8TLXsME2H+WLEBE55q0TI0EY2jLHL
         P00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066085; x=1787670885;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8CQGd14/uVzcR48IxI6d4ODH2UhxlQ1SK9RbG2HEl4=;
        b=EblQTtTBJCQopvaL/zJ1UYH4MbwU7V2l1Hj5iH+orXSE+94PfV8cslyxRK93KY2Iz8
         joYXoC/WTMmcl4UNnK7NnK+TM2sn9bP4i/LmxMQl4BuTlxhVoeYhdQkIEi/rzauCF4Gs
         P/G+RP0xwoRJdgpS/kcG26j602CtQiT/mjls/w1Pj/+oV/WlXbBO98ZDiSZo/r4GeuBs
         /uI/7Z4QRNQWz3+zmVwH1AxBSm4++GSYSH6+Umewpd/WtZNfhlTuebzCapuQiX/L4RjE
         i3k9H5235KG2ek8JoOHAq4GHLtx4ksAOXKEpGxSOX6aTxo6k+32VCimffwHjn6XbBERi
         6O9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp+lf5Di1D6MeSNG5MkPNOP577BkE2SaIa7Z/d0FYsnXY5C8ztRkzMiqi38RqJA39zUVEm84co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxCJHV5i3gRHMK22wNNS2Wh71zBdRcT7PUPMoOIB7AzEuqf0j
	y0Hit4QogvlDMGUrmPV6Z3jlIR/0+TVo3CQobneyF3nImiv2SPfi2xDN5DVNlJtE107xEXjnQmG
	rmVyrV9iEL5ZkcpxH17eB0I2bM6ZAlh4=
X-Gm-Gg: AR+sD12V4dARVCvnkLjSHmkwRt45s3mbjomooh9hkEEbW/8Rb1dFnDAAM4Jm3OLIcup
	h2cunZvR6LQTFS6Vf6zD+FiQXYnczgz50NchdjBpBFNTlu1zTs566mUqx2QVdGYi4SBQEnHSK9J
	bXS2WeywsJDuY7vvCF4iuvjkIrZo6VJDoqh6EQKtwkXPwSOwJ2iWM5TnH4QwuKcFe/PhgjraSHq
	I4cEueOOwNuroLcPSiZ8pKrWH8YCWd6cDtv73VTy+bqDmifHnSngLNnrXphGwzJ9qFAXF78SAu8
	I1Ve5h7qF9P15kexP8bL+PImpjTbfqoE9oL/q5Qdu4Av318HLDjmBhPNFm2K4gw46f7D52La0K+
	llmdROT/A692G1/JISjkG+7khv2t3Dz68BcPfKmnxdbgl
X-Received: by 2002:a05:6a00:1256:b0:845:e04b:565f with SMTP id
 d2e1a72fcca58-84fde122876mr33849721b3a.14.1787066085377; Tue, 18 Aug 2026
 08:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818092252.782855-1-l1138897701@163.com>
In-Reply-To: <20260818092252.782855-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 18 Aug 2026 11:14:33 -0400
X-Gm-Features: AcwNN1VwdHJ0DcWiEJyRpRj61huJxMlZDpbYKZHijg-0CDJ-ZtBMTNBx5jsCLjo
Message-ID: <CADvbK_dRmpABM=DA6B1MxZLDf7pcqD0f_mWios+ecJnCBOqqNA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix possible out-of-bounds read in SCTP_PARAM_SUPPORTED_ADDRESS_TYPES
To: luoqing <l1138897701@163.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:23=E2=80=AFAM luoqing <l1138897701@163.com> wrote=
:
>
> From: Qing Luo <luoqing@kylinos.cn>
>
> While processing SCTP_PARAM_SUPPORTED_ADDRESS_TYPES in
> sctp_process_param(), the length field is subtracted from
> sizeof(struct sctp_paramhdr) and stored in a __u16 variable. If the
> length is less than sizeof(struct sctp_paramhdr) (4 bytes), the unsigned
> subtraction underflows, resulting in a value near 0xFFFF. The subsequent
> for() loop then iterates far beyond the parameter boundaries, causing an
> out-of-bounds read.
>
> sctp_verify_param() performs no length validation for this parameter
> type, so a malformed parameter with insufficient length can reach
> sctp_process_param() through the INIT/INIT-ACK/COOKIE-ECHO processing
> path.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  net/sctp/sm_make_chunk.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 236e25abc7a4..ebf791969454 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2169,12 +2169,19 @@ static enum sctp_ierror sctp_verify_param(struct =
net *net,
>         case SCTP_PARAM_IPV4_ADDRESS:
>         case SCTP_PARAM_IPV6_ADDRESS:
>         case SCTP_PARAM_COOKIE_PRESERVATIVE:
> -       case SCTP_PARAM_SUPPORTED_ADDRESS_TYPES:
>         case SCTP_PARAM_STATE_COOKIE:
>         case SCTP_PARAM_HEARTBEAT_INFO:
>         case SCTP_PARAM_UNRECOGNIZED_PARAMETERS:
>         case SCTP_PARAM_ECN_CAPABLE:
>                 break;
> +
> +       case SCTP_PARAM_SUPPORTED_ADDRESS_TYPES:
> +               if (ntohs(param.p->length) < sizeof(struct sctp_paramhdr)=
) {
> +                       sctp_process_inv_paramlength(asoc, param.p,
> +                                                    chunk, err_chunk);
> +                       retval =3D SCTP_IERROR_ABORT;
> +               }
> +               break;
>         case SCTP_PARAM_ADAPTATION_LAYER_IND:
>                 if (ntohs(param.p->length) !=3D sizeof(*param.aind)) {
>                         sctp_process_inv_paramlength(asoc, param.p,
> @@ -2600,6 +2607,9 @@ static int sctp_process_param(struct sctp_associati=
on *asoc,
>                         asoc->peer.ipv4_address =3D 1;
>
>                 /* Cycle through address types; avoid divide by 0. */
> +               if (ntohs(param.p->length) < sizeof(struct sctp_paramhdr)=
)
> +                       break;
> +
>                 sat =3D ntohs(param.p->length) - sizeof(struct sctp_param=
hdr);
>                 if (sat)
>                         sat /=3D sizeof(__u16);
> --
> 2.25.1
>
This is not necessary. Please check sctp_walk_params(),
and I think it's already validated this for all params:

  ntohs(pos.p->length) >=3D sizeof(struct sctp_paramhdr)

Thanks.
