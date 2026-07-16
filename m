Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A3417340
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200374; cv=pass; b=Qmn33kvZc7N2rLrTteuTM11lzzHyhH/AHhsrC7xaMEp8AZKGXrg12yvcRTOzcMQvrx+Q710yGhEbTwE4IkV+5n75PX3O/V1Zbpy8GE4mHf820HatNXKQmOz0oaoIupRY8vKOe1Mkr3wUb+qwuWqTniIY8Sdl4r6mTPJZ/zUJRpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200374; c=relaxed/simple;
	bh=2Mf1yi7rcpKQx+KVf6gqOog7j/QWN72FP0RMqbdb1Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc0q7gwoy7OipHfL+D1dnQN/vt5rAld1fp6ZwNkn7YEUxQcG6DhGOew6yZ/vGup/xjhCKNeN+g/yxt9RLQWFztXEt7/A9zi9Syl0nQ+opEv1MHIKOZobI4ttDfc5K9+zOJm0h+x0y/mp6n2b9zmMUa4hiAK475caO8xQUkQQolk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GksKhXvt; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GksKhXvt"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b021916bd3so5500228e87.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784200369; cv=none;
        d=google.com; s=arc-20260327;
        b=ho868RzckXd1gpIEphiUt9OtXBz8EhIXTEuUo3IaI/PqeFMwr5OgJ9cLah0MguU48I
         BWCk8bq3p7p4hfMPEHa6UL2gb1fJ/2p3OLp2dhFpb7E4/SquDwaLOFDT0B9biBAyZgee
         UR9l9CjOsnKygK25qKceVU//It7s/cuoi7dc4KgA30M06deaZQ3UZAsjWuKSH1Z6xoDx
         a5E5muVGUx80n+eeRt9l2aCkxD84wr2UpU7zLhusSpf+8coZu2ntCF0B0aCxh7Szutq+
         IC1AG1baBd1PsgAZMjaBKV7TGHIWu5yG8ERvBS0coUxcyAuKurHgHJMQHWA8IcR5CJ40
         ssDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t160BcIOQs3DWtYC6cP5bgMx0h1OMSJInLdyfc/dF0g=;
        fh=dg2ymdLbiNbBotc6WzqHvzRlh+YSf/ncbbWgtJsyWH0=;
        b=IgRRDhl5xo86EpfvjGCSpAkexN2pSAQswOgWUAFbolJP54xcqEMbkXk+w/8+LpcMLY
         nHukRg4dlpOaspW/f1459BVJ/GBT6RU/CgmxBVp/mcABGnAlexj+XiyvegkUE1byOe7k
         bBz8ICtv53xQ3VK9wvaWJtuKYAu3M+uYMdxfZjIFNUjqvgX1IFC+MVLcZq9szIQxAFkZ
         7cpQsx8KtZ9L00VRsfHJ1LNBQgFvFbs/pbYqz9w9LQVQYQ7mJ5nAlaJVP2BH1H4ab/hd
         UeLsXDJLFdN4QWuPVvfeGsjbQgHUK/vsShGnL7VU/wskPqD1AMyFc+TajgVEMy7/4I8s
         Qz5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784200369; x=1784805169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t160BcIOQs3DWtYC6cP5bgMx0h1OMSJInLdyfc/dF0g=;
        b=GksKhXvtnwBvUj0gLkAqD11G1Yx5WfhZ+src/qJ3Uv2n44i615qy/aXyNnUaozeBbl
         KuMp5BH99UidbdwkjYxwh3+t3qadzKQVQJKYTbRgZJOcUFcdXcW4+A8xG9RQ1tKw8yd5
         52/KiKkpCnsUh3+Kx4uKQY/ZapBS3qJTSi9WVwBKVodXiEZtJGB/i0uH8tUcVsdibfHe
         eocvyHaOwQKw1obh9+UFHdKOScC7PjpnyOXfIab61Uw5pHHHewGwNMqucA8YS3mBxStH
         GbCD2JZ3TEdhjO9Mdo5A5hT0Q0ztl3y3dopvK3gseZA+o9RHMFNn5jelyywjdv/j9aqf
         greA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784200369; x=1784805169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t160BcIOQs3DWtYC6cP5bgMx0h1OMSJInLdyfc/dF0g=;
        b=bHRFswGDXlbvGo6xf4WILSAN5qWKAkanwloUtmEyFR2tYG6icp9WMq/ZpuR/zs6Zvv
         quQPfj02V7Clp/VvkAGhGAhj1BBhaO/VoJJDaHBn9dmEs/TyZ66GGA76YDlGRLNaGmo1
         1h3ugo1a8FAtHtDfaq/Bn+AIisaY1emefvyO6qOWBq+w4NsMf63J22ZkSjBl9E9zQzqd
         v1jmnu+Sk0vleALi6xh1+ZGjKwdSX3+K+BUcqLj1aNy6lywVB0m6d5rGSO8YJ+qyVQJw
         K/EFjTUr+TB2qjbdxnHzc4B9/W1PhfkgFV8igT0bPF3zOsc46IRWnVuqJeGdx5VqhSFw
         rrmg==
X-Gm-Message-State: AOJu0YwXcdmkACvtWWQqtdIAMetD/kw0S+N+8u9r6fkSV20fmGDoj1zD
	H1b285B4f/yf1+gniogokiFdYsKux+W1HnqPx8bDD9TwJokq+eyMAk9BPnHz9g7/a14ErEdBI+K
	xPjD9IpcIJkOe3+EeLlZ31T/N8xmJEp8=
X-Gm-Gg: AfdE7cmVC0sYulNypBcJed/K6BmeaSZCaM+Gj0kg+1ci9RCohyK/xN/vvhcD5DAz8nW
	+zVtwmerSpS9p65GIgNY3WV8CWifUMzAxQppNMuIy5PCI7/MNbllLQfb32pqVv8tVADO0u5l8Wa
	+QpmQpcb1IWtguOfxJ+8CW1XduEisw2WDWAJTThplvH4C+mIq82rjY11yz9dDsok2FarjQWPPpS
	xsAs1PJGT5ircam4+YGt6Ay+cnORsUR1TkUHbs3I7l7NtxyuV42MpbSlDS/C5mNaFNPVycMvPLp
	sPTWsqEG2wnXimVoJ7Vu2cB+4ChEAxRkeb8a26bm1qvZPsljlgDygP2PZsT18+nCR6C9dMJJynW
	7k/K45A96YWeC
X-Received: by 2002:a05:6512:66da:b0:5b0:1f61:f5e with SMTP id
 2adb3069b0e04-5b15d79d300mr1002660e87.33.1784200368660; Thu, 16 Jul 2026
 04:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80818E6580896D22+20260716091212.43126-1-junvyyang@tencent.com>
In-Reply-To: <80818E6580896D22+20260716091212.43126-1-junvyyang@tencent.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 13:12:10 +0200
X-Gm-Features: AUfX_mwHCtQnLYHwyJACRbZaSuoOmgR_fxhvzgV2tOwIYEgCwlBYYl3bVBeunEU
Message-ID: <CAL+tcoD_BH0xhyAJ1p=TcX8KW8_heVjN8wHeVwWzkMKS4MMgNA@mail.gmail.com>
Subject: Re: [PATCH] sctp: don't free the ASCONF's own transport in DEL-IP processing
To: =?UTF-8?B?5pyx6ZuA6JOd5YabQUlHQm906YKu566x?= <aigbot@tencent.com>
Cc: netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:16=E2=80=AFAM =E6=9C=B1=E9=9B=80=E8=93=9D=E5=86=
=9BAIGBot=E9=82=AE=E7=AE=B1 <aigbot@tencent.com> wrote:
>
> sctp_process_asconf() caches the transport the ASCONF chunk is processed
> against in asconf->transport (=3D=3D chunk->transport, set once in sctp_r=
cv()).
> For an ASCONF located through its Address Parameter by
> __sctp_rcv_asconf_lookup(), that cached transport corresponds to the
> Address Parameter, which need not be the packet's source address.
>
> sctp_process_asconf_param() rejects a DEL-IP for the packet source addres=
s
> (ADDIP D8, SCTP_ERROR_DEL_SRC_IP), but nothing protects asconf->transport=
.
> A single ASCONF can therefore carry, in order:
>
>     [Address Parameter L] [DEL-IP L] [DEL-IP 0.0.0.0]
>
> where L differs from the source. The DEL-IP for L passes the D8 check and
> calls sctp_assoc_rm_peer() on the transport that asconf->transport still
> points at, freeing it (RCU-deferred). The following wildcard DEL-IP then
> reuses the now-dangling asconf->transport in sctp_assoc_set_primary() and
> sctp_assoc_del_nonprimary_peers(): set_primary() dereferences the freed
> transport (->ipaddr, ->state) and plants the dangling pointer into
> asoc->peer.primary_path / active_path, and del_nonprimary_peers(), keepin=
g
> only the pointer that is no longer on the list, removes every real
> transport, leaving the association with a transport_count of 0 and
> primary_path/active_path pointing at freed memory.
>
> Reject a DEL-IP that targets the transport the ASCONF is being processed
> against, mirroring the existing source-address guard, so the wildcard
> branch can never reuse a freed transport.
>
> Fixes: 42e30bf3463c ("[SCTP]: Handle the wildcard ADD-IP Address paramete=
r")
> Cc: stable@kernel.org
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> Acked-by: Xin Long <lucien.xin@gmail.com>

It should explicitly target the net branch?

Thanks,
Jason

> ---
>  net/sctp/sm_make_chunk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 8adac9e0cd66..b14251214896 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -3153,6 +3153,12 @@ static __be16 sctp_process_asconf_param(struct sct=
p_association *asoc,
>                 if (!peer)
>                         return SCTP_ERROR_DNS_FAILED;
>
> +               /* Don't free asconf->transport; a later wildcard DEL-IP
> +                * parameter reuses it.
> +                */
> +               if (peer =3D=3D asconf->transport)
> +                       return SCTP_ERROR_DEL_SRC_IP;
> +
>                 sctp_assoc_rm_peer(asoc, peer);
>                 break;
>         case SCTP_PARAM_SET_PRIMARY:
> --
> 2.55.0
>
>
