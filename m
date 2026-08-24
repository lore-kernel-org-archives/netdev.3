Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F9363C50
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584485; cv=pass; b=tAcS5+4RSmcZospE1zatxTKaoE2O4D/NK8kCWzNOwC5kUFPorlf/cRKuHuk7N5sZpYRlo/+1iIQduhFio2Z3A+p5H3YlcVZWsZ4VwBlm41xOeuTKhQukehAFZ/XL/VblN2Gx7Nk1FrIHLFwL6Yo7KlSQO+YNcDdPOTl4IgzyOXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584485; c=relaxed/simple;
	bh=VJATUq+652VOGyti/HO0Gm3D5hCpmMFQ9J+4hCktu+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aufZLJgBCDby5kFtHYjW1jjrO16rXrWdEbbTMuxNyfaDtCPF+l2jQauzXF1Da5MxKOG8siFH7UQH1B5LGLrxVC/O3t2Tvg8BMrsMDZQVX1bL2C4ItdFSEs57g4R3EZwB9npT9lcw8V9T9PKQ5RKZDkll8ECaX15k+l1ZXRsfbUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRT1h3Ju; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRT1h3Ju"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so4045021b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584483; cv=none;
        d=google.com; s=arc-20260327;
        b=QC1lLsKZKNhRaZV6q1zcGUCTzAF/zGdjcYMTVLlx9ifQolFBdI5IR7b1B9XVxNCQ3C
         0ebPdGv+4hPRDhlkg0gcQ0kIAXsb97MKYkrYRqhnBzmUjhBzQXPMXGL+K7ElreU5eesi
         A1BndMbMSGl/0OZXyc0FWLj85i08hqY8mkwK2JUb/0C3ots7gCMGM5E4CTt7zk4NZRps
         hbZy4ExOic9g917FbVMrMLAlcovjIZT7H9P3CH/Se9GpuihXwUv1eLlWEFLce5SvgaTe
         Xpc7gF9frzdfafT4QB72X/GglyvKJJXO+rloJNkI8nX6vKOBF1HY+I3epSf95RBvUCl8
         9OFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhOkI8BfwHJxYD+mu7kqK3AB9orV2yeL9tFKuyBojLk=;
        fh=v2dSMgacBgRqHiY3xqwesamGIBNqgB/fiGctN7z1qdk=;
        b=r/bEpaRaoQp9CRAMPrOB0bko5pOLA0mbfVKU118qOVRn6eCF5LJvr6A+4i5DSCDrcd
         tfMQtyHMmt3Jr+D2Riv+cfayN7TQktdtR9B3NkxE1SWFee21AtwUn2SgzYbWOxRHH86k
         EfMhUQmZ2WdEWRZSzf18bbFrDbfmkSvqpRRbhv43yfPUiiC/2hiq21KiP8WLv9WutnAE
         nQjm15nXGygmD2fQ2bF+JyQ1tbOlYHbEcMRucsUNhCHmb4IkJr6Sql5TpsqFTMEjIagZ
         8bcwLB4zTnn0on9zqV31satTr1LcIYKsZKu4qgrdX7RfYiY0IPynNh8ArxoUuvtwfTyy
         9GNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584483; x=1788189283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhOkI8BfwHJxYD+mu7kqK3AB9orV2yeL9tFKuyBojLk=;
        b=JRT1h3JuklS0Q2omBU/uTB/DzkpWaM6Bpsne5e6mjWwmDcdAFFSmSKP5asLWL+Np6P
         P4roxvwl+OJvC1iXNtB2S/xTJYHm4jTutD/US3+FEWxLt/NwswGGKEBnPDyXm+ssdnMO
         CITYQ1p3JzBXf5B2HN27xS3fubY2PEg6ZMb9zXafncEK8wey11w1iCWbqEUwBHuX77FS
         zRD6BmvCOaUddSFNCidsaPImGPLTKh9whXg44XAEbcsSGdkC5SqQ7nn+6Y9rn0PZL+2N
         VeZa4xYCjjrkIZBOlNLjg9OVM+50VgLI0srhb0onOdqNgQQWyxXyV9rolVg9mizICBFe
         YsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584483; x=1788189283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhOkI8BfwHJxYD+mu7kqK3AB9orV2yeL9tFKuyBojLk=;
        b=CP4SRE3baHBqCVrcbpV4AuaQTzQ2JFl7B4tEYdXCLul4baOlRcI0L2xS2d+CWfN1jo
         KzQL7hJ87s0YE7LJmmy1jt7ztAH5tPQfpDcavvVUnro44vwGpV7+Lv103BwdXPBmwEZy
         TRXRjdh9+Q4XtG9itv8hkq9AQV0QJd4fTKFT149apBIpSyIeSx7VpA1A92Z9HQ9voc/x
         YNTQPWR6u3BRhvQrsDiA1RAnaNVEe4m28LjKf3SvYXEIbRhpl4h0d17c5/1NcUZtbdyd
         co4qG26XX7QBngETiIDrxEUJm1KCebfZZk2nyZoyzQsFtrcq9lPL9VraG1pNCKU+rGnL
         MXFA==
X-Gm-Message-State: AFuF++kneTrAyM2zTi+vBgYENGQ87ljkrL+lBemW5/I0LS7floqw002E
	udl8Gm7UxvQeaG48PwpB3LfdvDa+DUTcoSwA463PQMWs7r6HSZQMicLV4T1lSkXp7luyeyMBAuQ
	q5aXaP5Hcbv3cstlCMo3R7s233FfbA3A=
X-Gm-Gg: AR+sD11lZRJAM9r1Q5euJrp/JcX3LQG3FP2ay5EMargMhxIyxH4QxgddBzs3GhaK4Zi
	CpvVUZ13Fa1TSwAPTJ8BiOSvXVsis3D2yPEwfKyjuUNdvNmMUtBjrQdavdNtVz4e95FN/k82u9w
	GvzbOADVqW0XzHVwO5PfqnxSO17KQVlISNgSooaUxYE01sf3PlI0ObLNKOza97Eky7jf73T5Bj+
	VW6mhj5B6CwSgKLldL3lSGP8z7sPfOgHJZuPUXe908mtZtuFAfT7SWwXN+izfUxcFuax+KYFkKO
	bP1PWFUXYU//MaxoBejIUZIUwQPrvUIio8ev9WV6/tNNcm3EjcaauhqgO7l4JVA2mn1xB+qRg6H
	+oAcALAINvZ7lykOP2uwX+bXXelYGAPx072gAoHC/bytg0Q==
X-Received: by 2002:a05:6a00:a585:b0:847:97a4:d6b3 with SMTP id
 d2e1a72fcca58-851fa017b6emr50017161b3a.16.1787584483231; Mon, 24 Aug 2026
 08:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823130510.1341584-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260823130510.1341584-1-bsdhenrymartin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 24 Aug 2026 11:14:31 -0400
X-Gm-Features: AcwNN1Vq5tzN8r2zBbD7fXHd8EuGLLynOeV-kIP_OlLCpzFNsL2qNZD6BOJE3d4
Message-ID: <CADvbK_dr8Oz7DFpA3YJ_YH0HXgWJgkQPRK7QNDCUQrQzQnw-MQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix soft lockup from unpadded ASCONF-ACK
 parameter iteration
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 9:05=E2=80=AFAM Henry Martin <bsdhenrymartin@gmail.=
com> wrote:
>
> sctp_verify_asconf() walks ASCONF-ACK parameters with
> sctp_walk_params(), which advances by SCTP_PAD4(length), and its
> SCTP_PARAM_ERR_CAUSE case performs no length checks, so an odd-length
> parameter passes verification. The consumer sctp_get_asconf_response()
> then iterates the same parameters advancing by the raw length, without
> padding. A single odd-length parameter desynchronises the two walks and
> makes the consumer interpret attacker-controlled bytes at a misaligned
> offset.
>
> When those bytes yield a length of zero, the while loop over
> asconf_ack_len makes no progress, spinning forever in softirq context,
> and the watchdog reports a soft lockup. A remote peer can trigger this
> with a crafted ASCONF-ACK on an ADD-IP enabled association with an
> outstanding ASCONF (RFC 5061 section 4.1.2 requires the chunk to be
> authenticated, but the predefined empty key id 0 allows the peer to
> compute the same association HMAC from publicly exchanged parameters,
> so the gate does not help).
>
> All reads stay within the received skb, so this is a pure remote
> denial of service.
>
> Advance the iterator with the same padding rule as the verifier and
> reject zero or truncated lengths to guarantee forward progress.
>
> The issue was found by ZeroHive, a vulnerability hunting agent at
> Tencent Yunding Lab.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 5a335c980a7a4..0634241fd6649 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -3452,8 +3462,10 @@ static __be16 sctp_get_asconf_response(struct sctp=
_chunk *asconf_ack,
>                 }
>
>                 length =3D ntohs(asconf_ack_param->param_hdr.length);
> -               asconf_ack_param =3D (void *)asconf_ack_param + length;
> -               asconf_ack_len -=3D length;
> +               if (length < sizeof(struct sctp_paramhdr))
> +                       return SCTP_ERROR_INV_PARAM;

This check doesn't seem necessary, as sctp_walk_params() together with the
following check in sctp_verify_asconf():

        if (param.v !=3D chunk->chunk_end)
                return false;

already ensures this. Please confirm.

Please also add the following check for the SCTP_PARAM_ERR_CAUSE case in
sctp_verify_asconf():

      if (length < sizeof(struct sctp_addip_param))
          return false;

This fixes the issue reported by Sashiko:

https://sashiko.dev/#/patchset/20260823130510.1341584-1-bsdhenrymartin%40gm=
ail.com

> +               asconf_ack_param =3D (void *)asconf_ack_param + SCTP_PAD4=
(length);
> +               asconf_ack_len -=3D SCTP_PAD4(length);
>         }
>
>         return err_code;
> --
> 2.43.0

Please share the PoC with maintainers if there's any.

Thanks.
