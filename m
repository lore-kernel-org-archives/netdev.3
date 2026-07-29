Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D593B05A8
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337710; cv=pass; b=T7RcBr6VRSzty6FwXh3H2OA4YnbFU8jFl0G0JM17qCFCnlPi1KH0kofWeGouRoVaNuS4uTM3DeUroXxB/qYVa9/zvEvQHFyS5TYsZhJz3/lF+fbfJB7e10IkOiQn1p5ta7oINnKgpNT7VENHp2BPfhUtynRstn1jI1pn5xJ4oRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337710; c=relaxed/simple;
	bh=C1hDEqmnAa3TDi8gjx1zqfyVR/iLfuR2KeKJu77rxU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn0dPDrXxnYt0j9xCd/+CGy+WmtGNWXw46R2XXv6LC6daNPx2ra3KSaW7khVw39GSUQ5eM4fOb1jS7k6PQkw3aNAbwn4D+waYpX/ZtzXXHYjuRmDf2JOYRS0gDXILBr9ZAxQEHmnDOHKB4RDfGYPV4On4X4WCskqSFIF5Ib57W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5rJwYmZ; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5rJwYmZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1038171b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785337708; cv=none;
        d=google.com; s=arc-20260327;
        b=r+PwCfyTXH7+BGxL9nNixJ3Ckl8Fykh9mWvylcKWm30bVBnUiAY8VW56MmNGwT+Mal
         8JLV7TyQMYosgAk7cgk7x3A9GRnA8hZKwBpp1zu8nlV/u52CZE3rttn7oBaf4pi9cbtc
         6T4fJvlGICKl2PvYkBmxT75gzDJpnwJdPL8LUoekNbbLvVnxLqZZVlfoDMOWeS92Robd
         sFaYVvi7opMcwUZU/RIkft2SNGhZ7sKr6WqOB35DFg4/SVXwyth3ElcD8oButEmWsrPm
         k1xfyyysjBTPVwgQb1L6fvL1a/uxKqteThBgzWWLHvfExgqo78H8jLBBFxgslhz52iiN
         K0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DN2pJ0iBJxGrKHnDKUdsB6jvMBxu/va3aV7+6RRh+Zg=;
        fh=NJYiAq9Jvey/qyEhlaPCNvgeuJj7sB9LsZof20nNonE=;
        b=YN1mQoFIRRrq/6B6D6ptDC1EjNMmaYjK3SJ9KfdAlxKj+7avBsGA0ajm2DbdMSbBXE
         wA5ldsif4VzOJggUYtYjQSzVDQNxF7kc4gvhvS6mTfLMETjJtDJnBLKKC0PkS79rQV44
         pNWpxgF+hdcA9vcNceYFwiGmBj2daUAPZ0VymP8WNcttkZtXy6s9m9dXrRDGiJe+2FE6
         ZgjIbRj5PySFWPy7CS3F4PW23WFDEBBUhpzFoABUrqEfe6reNVsFsRs7zcdYj2O2F1H8
         E3schY6wfyieG2WKhMwcEbCGrLgCY6xtbYHTKREXM3LE3w64G1II79/g5+oLh7QyEk+Q
         GZvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785337708; x=1785942508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DN2pJ0iBJxGrKHnDKUdsB6jvMBxu/va3aV7+6RRh+Zg=;
        b=M5rJwYmZIAtlq2ZrXWae5DyVp354Bdhjn+v8XphW1gScMIbXvLwDFkRLCUBBgMqowp
         u25PREYtIQY4zXbqPGZYRcH9UiWZcSW5cG5J8Ih2etgIARHnoRdnv0VBKWmpQZ4fyatz
         v+AhHsriMbdRHCgCuedHZj/GXbRfjMRKZjXG2NzBJPp2tk29qMfvGwss8Fk9pbOvJeLr
         imfUc0eNOr9EEmjc9joTMa+eWQJFoRecb3d2TFqrkn3BtR8k2oARWcg7FhWtV7XZYndt
         h1NMJkkBhXxhs4Nj6gZp4/iqT7FrEEvG18k+0YIYONZoPFmbyWPLsz301B2E1WEXXnvP
         JVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337708; x=1785942508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN2pJ0iBJxGrKHnDKUdsB6jvMBxu/va3aV7+6RRh+Zg=;
        b=fBlz6hx6ZQ3hYmqIzMgZZ0VQWSSGe97hGPmMXXwIFPlc3yFqzrwdblqJTUvk8ecp39
         XzBxoK7Y+2yft4PaQ1Ig/Dz6jYS2PqWAaYzcOithKvH/F+oO/tbzf3+AwAHf4C/QtXPA
         6JdAbGrm0QH+d+8atuaHcJ78tu8O6Qkh6TgSjTxEqJpTMhQlaWUnOa1rTIBxobxwoA5q
         TgGTZeos+uNOi4BVkmIvspztTeQLKOhVkMAdFaBR18iEjE9XjEemb83+/s8UfcbyOwiI
         DuP3FJY6dXT1qcJ4kCpbiVTlHIhAeqQyLBznMJIMmEZv2iAFPn51u5CEDy8Ajaufmuy5
         nEnQ==
X-Forwarded-Encrypted: i=1; AHgh+RrklbcSeDDOTqLEaogbRBsme/oQ2Y7ESjf69RJdv85s0U/Hh3f8Yj/pErdKRGEWa1pmrqd9S6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLyhGA/NNrpkHQE32T6q7fF8tEfH8XlmuFvoj3HKmdw/ILINt
	y9v8fSVnMaqX5Vall1EqTt+4G3aqRslJ9KZCEi9P6uakTfq3P74mC9L/NWrxHpp51h9QnBaiPK5
	vstPHVqiU4jiQDTUoa0TF7ucgLK091KQ=
X-Gm-Gg: AR+sD101H5T0CQl9PLGdNWQrUdD3tP/Hk65YAN4j5OknN+4QLjg5VHWCak+Jj8EYemQ
	RL2p5CxObsesxRy0MR08NLOg2s3hpaCzrqfJpZ14O1i6EVWHR4IYzQccuPKmhxf+ckOakfU5qw2
	033uRpSBhxR0h7rpmOtq8AvxrPZEYhsuq1Nzb5i9qePHrYxyGjfSj8Z1HolRWMID55LmqynmdPR
	I4jWoye2Z6CDZaeSEfvRpOH5F83XTPgQdsmSln2ToOypwWTTLPedAU4v0Vt3lmGh9SAoA06GhpM
	aIfyj1ytL4T0ACu+eMztpKFoTCIBuobzS8kGRQnHCZseSpn4qRaII/YNEy8k4JfUMOUxYLZYxF5
	F49baMpVu6WHZjoJqcBOTw8GE1jeH4UJ6twQ2uM5kZLs=
X-Received: by 2002:a05:6a00:bd86:b0:84a:46ec:3b9c with SMTP id
 d2e1a72fcca58-84ea7aa3469mr2826245b3a.31.1785337708243; Wed, 29 Jul 2026
 08:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-sctp-cookie-preservative-length-v1-1-1ade32e42668@gmail.com>
In-Reply-To: <20260729-sctp-cookie-preservative-length-v1-1-1ade32e42668@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 11:08:16 -0400
X-Gm-Features: AUfX_mypXq3HMlzPwWFUdF9XmRRShPhdnIHIc7-DAFADR9LIdIHSrIzgJYlIUYQ
Message-ID: <CADvbK_ds_4sNnVTxXEooHkkA6JjV35ByCx+BWXiihiAo2cX8gQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate Cookie Preservative parameter length
To: trilobyte777@gmail.com
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:54=E2=80=AFAM Charles Vosburgh via B4 Relay
<devnull+trilobyte777.gmail.com@kernel.org> wrote:
>
> From: Charles Vosburgh <trilobyte777@gmail.com>
>
> The Cookie Preservative parameter contains a fixed 32-bit Suggested
> Cookie Life-span Increment after its parameter header. However,
> sctp_verify_param() accepts a header-only parameter because the generic
> parameter walker only requires the header to be present.
>
> sctp_process_param() then reads lifespan_increment beyond the declared
> parameter and adds the value to asoc->cookie_life. When the malformed
> parameter is last in an INIT, the read starts at the receive skb tail,
> and the resulting value changes the expiration in the State Cookie
> returned in the INIT ACK.
>
> Require the declared parameter length to match the fixed structure size
> and abort the association through the existing invalid parameter length
> path otherwise.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Charles Vosburgh <trilobyte777@gmail.com>
> ---
> This follows Xin Long's review of "[PATCH net] sctp: validate Adaptation
> Indication parameter length", which noted that
> SCTP_PARAM_COOKIE_PRESERVATIVE has the same fixed-format validation issue=
.
>
> Runtime-tested in KVM/QEMU. The unchanged reproducer accepts header-only
> and overlong Cookie Preservative parameters on the unpatched kernel. With
> this patch applied to net.git base 51b093a7ba27, both malformed forms are
> rejected while the baseline and valid eight-byte controls still pass.
>
> The patch passes checkpatch --strict, builds net/sctp/sm_make_chunk.o,
> and completes a full x86-64 bzImage build.
> ---
>  net/sctp/sm_make_chunk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index a1c0334a1038..eb9cff77759b 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2165,7 +2165,14 @@ static enum sctp_ierror sctp_verify_param(struct n=
et *net,
>         switch (param.p->type) {
>         case SCTP_PARAM_IPV4_ADDRESS:
>         case SCTP_PARAM_IPV6_ADDRESS:
> +               break;
>         case SCTP_PARAM_COOKIE_PRESERVATIVE:
> +               if (ntohs(param.p->length) !=3D sizeof(*param.life)) {
> +                       sctp_process_inv_paramlength(asoc, param.p,
> +                                                    chunk, err_chunk);
> +                       retval =3D SCTP_IERROR_ABORT;
> +               }
> +               break;
Why not move 'case SCTP_PARAM_COOKIE_PRESERVATIVE' down
to after 'case SCTP_PARAM_ECN_CAPABLE'? it will save a 'break;'.

Thanks.

>         case SCTP_PARAM_SUPPORTED_ADDRESS_TYPES:
>         case SCTP_PARAM_STATE_COOKIE:
>         case SCTP_PARAM_HEARTBEAT_INFO:
>
> ---
> base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
> change-id: 20260729-sctp-cookie-preservative-length-ffa4472272fb
>
> Best regards,
> --
> Charles Vosburgh <trilobyte777@gmail.com>
>
>
