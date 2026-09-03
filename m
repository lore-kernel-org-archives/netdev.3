Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832E41F369
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446225; cv=pass; b=i25WTDH3DzhmvU3hVRzLCDHus3AfEeqnxQoUNG5jl46X53pFvUlC6lUHuTgQTCvW5RnCE+PJa9DYd7vu8aUuhQe6MUVrdzvJHPjfC3D8FzJGEsqXXujXJWFIVHvi+juJz23Z5aoycyOoi0R/d9nAPAV5FlRtQPgUHQVU86A18fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446225; c=relaxed/simple;
	bh=vZbQXvmGyW1/UKrE0sFXKT2KNHALtKdLQAjyI+9b7Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT7ZfYVdYQMU3Kjf97+knDcUB+AUUoWb1rbVkyCDRUEGoI86NiSmBoLTWgciCaD5c6B0TENavM4cLS1+eIPGvEuh6WCdHO5dy7RWWW3jsjHcmqnoyapzGb0U/A0q3w9RFDhTVKhSC2szyRcaUFZij0xk7/QcIDe0cke2hPmv9Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NePxcv/Q; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NePxcv/Q"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52ff7e275e0so22897821cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446221; cv=none;
        d=google.com; s=arc-20260327;
        b=B8QZYtRL+pk10HaJUMd2jfoNq+IHFs36IeAQG+0RjLyMizJ1+A2HQsfyy4yzW+xXLA
         NK9797JkGaormYIHMl+tr3hBAV/Ao+sPo7i6bPs7cJrOSPD1vECqIfu4TobxB1TaDARr
         Lz4oFqLrLtFTAUXS7YpreaSu9r2lwgPf5txg7lW0KhfaPMiWmYygItmATC/0N++i2WE+
         Hp74W6CTrrhqtQiUKeKz5K3sgrAG1tbPNmeL+3Vqanux/Ol0sKrGhfO2Ojlx1ZuLhgGW
         CVvWHR34vTlWvgwpKDo53eZ6Ni0FcUmcgBxPDxcyH4wtE4gu0T/nJyj+pPyC2kufUucs
         E26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=La57paUsnYX53CumeykdWBf/0oLfULFm4zC/h1xvH1E=;
        fh=e5190AbwGS6RZ0qsmVT6yQBy9/N1vyEGLM+YGL4DSPY=;
        b=iazLgYM5F5b7C2L1/UB0c+rSOfgYZ+gYYpBl3X+oTOP/b/nW8fHikj7M0ejkMUfNPM
         Q+WUmd7nZTTlhouQaiZ1PwKaEOoTmizivc+Fr9vXQdr7VjifgXpa4C3DvS8Og3u2YtsG
         M5CBbG2Eya8LDlroliDzpIPRQlFsGFGPeNABqJ6kRREAD1c+7grosNNbS6CA8Cx+P69s
         xLESR6TIBKPxEMrUkwSdia0uW6pO+Js+uZqPns055JsE0th/wFHXQGYNiShXV3SLrRxF
         ZrVOjLm/CkY3pAfNKLZKZBEJ+/XzsLp3jaiZgbbiS+4nAakCOI83xjdHZbzCbEl6dzWC
         6fUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788446221; x=1789051021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=La57paUsnYX53CumeykdWBf/0oLfULFm4zC/h1xvH1E=;
        b=NePxcv/QibOq8ZEBsf9h+aGt1Ge66TAR/1ufEGGI9gslCJ/sNqRpgpDo6l8uMRBhib
         2pEEcQWjDbL1yZsQ1WI3EdlDjXr8Ati1iqBDzmIl3/IsM21pAKx0ka/l4dJg90FJQ9Xy
         nbI0lEvsnJj1MEKmDbigesCATicuRSEvDGXz7tlYTTbjJZoHNYWFIMfQnTNPLviIRtaD
         l51UPnVidYRrc1V/DuITwCOVF/R61Sv9Ii/3/VMoa4svwL/GwuIYQBQIop1AcaoC7t3V
         K9QfwQYC1c1oRQWliPIBCIa8+msBwp8+qIrQDJQP4l8SpLTgSoi0jyPjV824wUM3iY17
         wLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446221; x=1789051021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=La57paUsnYX53CumeykdWBf/0oLfULFm4zC/h1xvH1E=;
        b=ZAc8R7WjDACPOx+CMPrjRXyVJS+6/V+uMZpkX25H4InOrUC+P2gg2z+K+gI7hRF6HI
         jV6pQ+y2R4Fhl006g0gz3JrwMZRX0n/LZMTHpzbhZqMxyH6n4dcKF9ihs8B8s3F5E/zh
         up2IQ1Zwkb9aJmByWZ7WO7/eG4E/iH+lLpWrC7S+F3zd4UbPXld6H/IOtwicctaf7f1I
         bDg1j6999OnYBHFbIDRDp3B13p+IwO8R/PBpd2nTbzGY7mhTsX4Jih09G0IgftRo5F0I
         zS18BPTWaaCgzcwizQDSTMUyP6U8aHzcCWsbfdBgErV7KybhZBb5Ob15Pwy3DrkaCkH8
         aaOg==
X-Forwarded-Encrypted: i=1; AKwUvBxDoOe+Ovm533qNM2vBNojhFBFZMsvBQN/t7SQZQr/9RTnw7hSLvvz+1HcZkgaPBtG4rffW5mM=@vger.kernel.org
X-Gm-Message-State: AFuF++nxTElbIXwopp6cDO09OGCwTlzMGwhHdkEpdDxRBmqKIETAmjKd
	GJXI6bjl+AwX3AWu/lf6vKwt9CP9dNZaEIRY6touWmq34sB/i7tLwaOo/O6y5LNK2/ENzdYFh2H
	qvbZMp2WK7fqPopd2Tdw/WA6ATl1FZuxWnktQeda0qrIAoP3J8yy0U2dU7So=
X-Gm-Gg: AYBFou2tcfcF2m2s659L1lQdm7BUiZYqNU9+FiKSXvm+EL9tGWRt1duOVlJSpb7L940
	uZZAwZR8VcTzOEITJ4IOxtcpCGaxj34cTK6sI08A6/Urm1gIBhNqmw3vWPtghd0ArGtqrMtG3sP
	/ETAoS+3+81t8F9+uT3I+aylgJt6BMz+13I3Itw6dYS0aS6Km9ek02SgYkGD4c20YR8q5gatsZP
	DS3TWBtPXg6rXDZm0Ch5JaToqHDhkqVaeozZUfHCYHsgz1vScETCjlb1ND/rUO97xgA+zvSxy4S
	OeTySGHe32xWA2R54PKE+GOhyiHWfRYCY/E22BmslTqEAGZd7sNx0yb+niBJX0EaFpLlBn1l1yM
	9g5EAfCySDK3LBJcnv9qaEAUlWZaK18j/8Ek/8ZmhQ5a7ZpdaC/J2Zz9ikQ==
X-Received: by 2002:a05:622a:1391:b0:530:42e4:f281 with SMTP id
 d75a77b69052e-53042e4f99amr78832371cf.42.1788446219727; Thu, 03 Sep 2026
 07:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903141204.40934-1-yilinzhang@moonshot.ai>
In-Reply-To: <20260903141204.40934-1-yilinzhang@moonshot.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 16:36:48 +0200
X-Gm-Features: AcwNN1XeB6M7fHc8_CMFwS-rDmM8_s4w0a_8KKsMOJLsJdLcokW0Xwm7DJ_4Mfw
Message-ID: <CANn89i+8uLsaq91utS5d_W9ufUP-DC0-j=PRctwQFMTMZ_0FuQ@mail.gmail.com>
Subject: Re: [PATCH] inet: frags: invalidate queues before flushing them
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kimi Security Team <bug-report@moonshot.ai>, Weiming Shi <shiweiming@moonshot.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:12=E2=80=AFPM Yilin Zhang <yilinzhang@moonshot.ai>=
 wrote:
>
> fqdir_pre_exit() flushes the skbs from incomplete queues without
> changing their completion state. A fragment which found a queue before
> high_thresh was cleared can then acquire the queue lock and reuse stale
> reassembly metadata.
>
> For IPv6, this can make ip6_frag_reasm() use the old nhoffset with a
> new skb and access memory out of bounds. The resulting heap corruption
> can be leveraged for local privilege escalation when unprivileged
> network namespaces are available.
>
> Kill each queue before flushing it in fqdir_pre_exit(). This marks the
> queue complete and releases any timer reference removed by
> inet_frag_kill(), while leaving the hash reference for the asynchronous
> fqdir teardown. In-flight fragments consequently take the existing
> complete-queue drop path without changing the reusable-queue semantics
> of inet_frag_queue_flush().
>

> Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()=
")
> Cc: stable@vger.kernel.org
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Tested-by: Weiming Shi <shiweiming@moonshot.ai>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
>  net/ipv4/inet_fragment.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -235,15 +235,22 @@ void fqdir_pre_exit(struct fqdir *fqdir)
>         rhashtable_walk_start(&hti);
>
>         while ((fq =3D rhashtable_walk_next(&hti))) {
> +               int refs =3D 0;
> +
>                 if (IS_ERR(fq)) {
>                         if (PTR_ERR(fq) !=3D -EAGAIN)
>                                 break;
>                         continue;
>                 }
>                 spin_lock_bh(&fq->lock);
> -               if (!(fq->flags & INET_FRAG_COMPLETE))
> +               if (!(fq->flags & INET_FRAG_COMPLETE)) {
> +                       inet_frag_kill(fq, &refs);
> +               }

OK, but remove the braces as they are not needed per kernel coding style.

if (!(fq->flags & INET_FRAG_COMPLETE))
        inet_frag_kill(fq, &refs);

Reviewed-by: Eric Dumazet <edumazet@google.com>

Please wait ~24 hours before sending a new version, so that other
reviewers can chime in.

Thanks.
