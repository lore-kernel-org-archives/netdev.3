Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A74746A4
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846394; cv=pass; b=L3lUhsfsamSfyPSvMbCREIAIgqPiJ9itzd8JAo6gjpXIrhjNLFV5Ps8pZAUZj0ea5wWZNsNPEdp75PO5Ny+oLdEjEcH/rX/x68Olume3elrp0J0ShTpeiBTQcf27pTpKWMRFMIG2dxCto5yZaLa7r4QzXBP4hXCKOyZ0hClhvaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846394; c=relaxed/simple;
	bh=MapsIztLy09UbhU+7+S9oaDp8H3eC/Z/hVQj74AC93E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s039B3pWjcDYIxR0zYx5zH3WkHkaVAGQ28sG9XjNqIcYQVuPSRKEctSUCokRbyrgAeWiT+L6BL4yjqquKjbXBcxFIgFRMxdOYYXErkUQRZvRycnsOlDF1qbKR8SMzngcdcHZR93Hh09M7CTiYz2tHeA0y+1GMYSEhpm5uuok9gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyQsAXYu; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyQsAXYu"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso52492a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787846392; cv=none;
        d=google.com; s=arc-20260327;
        b=fkPxBSvfkCWSr7Cuum3B+O3yW0yyiBzXgpAA7nRcuB6AzvjUHGdwSh8+oIRqG5XzFF
         7txVywDQEEFq5kccgIQpPZLUdQcQJ4VsTrqeWGN8qL6Ne9/dchqP1HFusbPMWFaoJfkE
         tPOdUrCh2MWh26P9rphXnazljJnsgz1AVRO7o0AZiL/1BSv+9jCrXLevyyvDRZWrbniR
         Dd9lA06Sl8tyIvndMR21W2LZtizRsmG4Ve2JSHRHZAUu0rJ7X/R5LUIeCZRdQm1mwwKW
         ApjHk5XcQT9/AbyDiFyqKE02i8S3etwqbn4yYMffWxYuBfIBqgFM624ZxM8/Tz3Kgvnv
         k4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uf3bB7qcZpR+PPJRdyv+umREJvvSw/JAIAYin8FVQIk=;
        fh=XueEHT5P69N7KyfkPqDkS0TU7wSAVdqiiVuOWjbfvLY=;
        b=i7w/wAHeJG9j5gtXJ5kkynPEID2Q/herIIAKb8xciA6rJoXSNeUPiA/0O4nZRS4pIl
         qVqi2QzWecVGJUFmTsBs5mHQD8c5122iy2Ej3SklWMKju+eqZcfNBbIy17AKPCK3SA6l
         RJqkiKvnEgNIyHhxetqy3XaNZMs31cHglH4ciXZcOetBI9ffQrH5fgTTg+n69RJ3lxgB
         HZh5Gu9JjE5xlCjYrNU2TVt36ezXsqdOaecJz+x89z8LvvN1g2eXEokIHXZ9/IJ9J8/v
         ZCAI4mAe8v9f0FrcOAYUX718U0YotnuugrFAwnAAB2yckhyO0aHy7YbqbK+GnnZnhKnm
         mZVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787846392; x=1788451192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uf3bB7qcZpR+PPJRdyv+umREJvvSw/JAIAYin8FVQIk=;
        b=gyQsAXYui1kjZzJaYcacaul2rNwImI3SwlddyhMwBZqU44Q1InzwFAeElIaPKTkSFx
         /Fqqhn6ZcieZHRdj4EYxHgw6drK1uVMy8CIkzYZNqCpcuGlheZzBUQ2yb/0zwEvQWyPd
         8e4gH7IxDMDL3QVvgIfAvxhEhZ1uyCKG71i5fF48WAQ3nABbLbRYeKS2K94LlMvw8oGL
         atOHMfyOTZFz0KlViALDu3hVo41YjCZJp0lo7sgI0DPbO8xIMy8DVP8zWXeo92sCIa2f
         CRLPYPO6vMzGi/zKn/wslT6zXTPYHApS6xxLN5Sv7jXpZMOa/GYOeLVeiOIHbBKvEnKr
         RVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846392; x=1788451192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uf3bB7qcZpR+PPJRdyv+umREJvvSw/JAIAYin8FVQIk=;
        b=a0JRLak0iREHV7/AkNG/Tw8G1jGY9I6edWBVg8PL2JMezF7MkCaF/lWJzBkLm9QaD7
         HOhMlZgj5NRYfzXSYM7NSmgXTh1tGblu4wVwsqvGOhzm4kLlQJwvIA7lT3rW7SGSK28Q
         3OW1uTUOwHSeydk/35PSSQqab2nM3stewbr+Dt1j/Cks5ai0kCVXHFTc37jPFTEBFmTc
         jBNzh8grY6xtueT2F74WRuN3a9nvLhmwKrk546aj/+G16cnExkNcVFN8650d55TnsaM6
         46WTsoE0bI90U2OytSaChsO2SaC6WH6VVvtX0NXMwX9xtwKuhW2DEJn3lihA0s4i/3s6
         jqZg==
X-Gm-Message-State: AFuF++kPcgdwu4KNQtnkEVb+EJH/isZR6G01WtpcLoy/X9xWbU+YWJuZ
	bo9b2vqFnQJYr9Za/if2pFijeTsg9RptL8xq3g8tl/Y60prSS6uoHbMiEUGhEHUhDL0uRRnLvmz
	sOrgxQRTyVDPrMorS5REVPfi2n969PJ0=
X-Gm-Gg: AR+sD12wix3FFDwoOhIL2x0D9RWl4kWzc/9kEN/ijP4VI5bXRZ35jAEslYalWQAH4iA
	iYSEiCBWiuRk0zvMShnViEkKAovipK5Xu1yK9ogJXIQ3GfGTDSfBrxcsbTR5myly88euHhnA00b
	+MiVIqObNq1TMt9U18ACwCJag3r6hYqFouHkDCTwqJ641TECnchxr9tqqfY+B8/WbKH3NubjHMs
	qEs6BFPcGy4OoUmav70mNeESSc0vV0JTcg/JK+EdBEca9uUAosV8is6CDXTZZPR9R2tKm/Y/+f4
	jh6xBaB1JoLszNYSMSGnOtwrpZc1YFBB8VqoNr2QT78NWtQjK8UI5DhYvHARo30oOf2x06eHtQN
	WVhu7/ppfOOQNMJreNFO28/53VXXmKMj/Rn57XDiz/LQL
X-Received: by 2002:a05:6a00:a118:b0:847:8449:2bb6 with SMTP id
 d2e1a72fcca58-8562953d5e9mr371891b3a.4.1787846391540; Thu, 27 Aug 2026
 08:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dr8Oz7DFpA3YJ_YH0HXgWJgkQPRK7QNDCUQrQzQnw-MQ@mail.gmail.com>
 <20260825082909.2650171-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260825082909.2650171-1-bsdhenrymartin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 27 Aug 2026 11:59:39 -0400
X-Gm-Features: AcwNN1UBd9hEJA40P83_GWTvA_-wfWR0MxVh5pE0XrwDHnI3rwCFvXgtb9RJz7A
Message-ID: <CADvbK_fh1LG1nr5gFgFRZUPWam_A0DRxG+tuHd+bq2hYwsgMZg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix soft lockup from unpadded ASCONF-ACK
 parameter iteration
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 4:29=E2=80=AFAM Henry Martin <bsdhenrymartin@gmail.=
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
> The missing length check in the SCTP_PARAM_ERR_CAUSE case also lets a
> 4-byte parameter reach the consumer, which reads crr_id (offset 4)
> before validating anything, yielding a 4-byte out-of-bounds read past
> the parameter, as reported by Sashiko.
>
> All reads stay within the received skb for the lockup, so it is a
> pure remote denial of service.
>
> Reject undersized SCTP_PARAM_ERR_CAUSE parameters at the verifier,
> and advance the consumer iterator with the same padding rule as the
> verifier to keep the two walks in lockstep. The verifier change alone
> guarantees length >=3D sizeof(struct sctp_paramhdr) for every parameter
> the consumer can see, so no separate minimum-length check is needed in
> the consumer. The consumer padding fix is still required because odd
> lengths >=3D sizeof(struct sctp_addip_param) remain valid for
> SCTP_PARAM_ERR_CAUSE per RFC 5061.
>
> The issue was found by ZeroHive, a vulnerability hunting agent at
> Tencent Yunding Lab.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> v2:
> - Drop the redundant length < sizeof(struct sctp_paramhdr) check in
>   sctp_get_asconf_response(); sctp_walk_params() together with the
>   param.v !=3D chunk->chunk_end check in sctp_verify_asconf() already
>   guarantees it (Xin Long).
> - Add length < sizeof(struct sctp_addip_param) check to the
>   SCTP_PARAM_ERR_CAUSE case in sctp_verify_asconf(), which also fixes
>   the out-of-bounds crr_id read reported by Sashiko.
>
>
>  net/sctp/sm_make_chunk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 236e25abc7a42..1166d1c5ea584 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -3215,6 +3215,8 @@ bool sctp_verify_asconf(const struct sctp_associati=
on *asoc,
>                 *errp =3D param.p;
>                 switch (param.p->type) {
>                 case SCTP_PARAM_ERR_CAUSE:
> +                       if (length < sizeof(struct sctp_addip_param))
> +                               return false;

Sashiko [1] is asking to raise the check against:

sizeof(struct sctp_addip_param) + sizeof(struct sctp_errhdr)

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825082909.2650=
171-1-bsdhenrymartin%40gmail.com

With this change, I think you can remove the asconf_ack_len check from the
SCTP_PARAM_ERR_CAUSE case in sctp_get_asconf_response(), like:

-                               asconf_ack_len -=3D length;
-                               if (asconf_ack_len > 0)
-                                       return err_param->cause;
-                               else
-                                       return SCTP_ERROR_INV_PARAM;
-                               break;
+                               return err_param->cause;

Thanks.

>                         break;
>                 case SCTP_PARAM_IPV4_ADDRESS:
>                         if (length !=3D sizeof(struct sctp_ipv4addr_param=
))
> @@ -3460,8 +3462,8 @@ static __be16 sctp_get_asconf_response(struct sctp_=
chunk *asconf_ack,
>                 }
>
>                 length =3D ntohs(asconf_ack_param->param_hdr.length);
> -               asconf_ack_param =3D (void *)asconf_ack_param + length;
> -               asconf_ack_len -=3D length;
> +               asconf_ack_param =3D (void *)asconf_ack_param + SCTP_PAD4=
(length);
> +               asconf_ack_len -=3D SCTP_PAD4(length);
>         }
>
>         return err_code;
> --
> 2.43.0
