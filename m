Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CA84039
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811358; cv=pass; b=rqV7OkMlh+z5HMcpehDl2tlUP62RR9aNoADFKhEkggFPqkSOQJLfKHW5ksWp0Pw+HUSTnYgv5nVPXOdQfcnMgHwz1bokBYMDt8iQMsuOWetIQqxRVLTAMhxml/jzpRs4ASqaNK+uS1vIVp8Jx60xqsCfS3zC2qIeCVPa38fFVxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811358; c=relaxed/simple;
	bh=FPSjKhbj8S0c3uA+0sLGypnVZHw5GjH76vIicGJ5ehg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohpeUNp4x63F6EWjhFLF1yPQHFdTmbhlRhHTtb7SIAuyV1o11bGJ8N0g0MAgcQkgqByAzdaahtQFlBkMWl/uz+26wGR14CLiE2NOl+NPxTKxgCilKaPswQ0TynI/Pmd/7rBXaMSkE+QfMIRLxpKyJLXUj8KHZE9aXvY9MXW7sC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7oOM5fs; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7oOM5fs"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a747448dso15117741cf.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775811355; cv=none;
        d=google.com; s=arc-20240605;
        b=Dsn6e/FR0vsng8z19QWa3o19n2bfhrYTLJoTEuoPXO9ZDFtVmBPLcktMgeO++cF8PR
         RFrAEC6+2wHpbp2TJFVUaPt1c1sY3GFB6mFs3xRKFANrLd9vYOYP3gGEyHlyv6W1BOVT
         nIMu3Lj3pPgAR9T+xfOL/ObMTAzgTlccDCnu+EbjPlqBvqJcarWDKNmf7nCYRuKA7PLb
         zKv4OcS16EJAt5Jr976nAjrszpd3NMt8ksXNTWsl++jpzN1n5ODg+T8wqjd1vXh1pNEM
         ocRYcZKhsQF9y37XUCUKQh0B9rpnWV+ADA3cbsm+9ASZ93xN3u9Mw+5993j6FzJBX0E3
         piZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WPPHnELns2KmwcuHhGMVO2PJ8ZGhtcUFl7s8Vawk+WE=;
        fh=YB6NAuY+I85xS8QC+sbbZivCvS5+dnk37+f4dw23uqk=;
        b=CfiC0JnU2u7RvUxL2x5NY1UlS+KgXatI0DDK6FxJQLR1bLoviAt3IHgj3H2bT715FG
         +bD5venINogqTx69bTUncgxfilG/l5PAEcCRoHqpShso5V1J2JRB6oetUSXVMnuopoNu
         qVw4pwTfo13v7WWTCGut8zpcDhUwblAilFyvipE108oq2wcvXThF+uLbyFkypXD+v5U/
         xhpNEopq2bK85+JyMavcazjXW1XB8AWHztBzNoM7QmpFOtHJfVljqqABJZTAl2gif7cI
         jzj88hmcg9EkgRyxtGUiO5ut9v8nujdWDNEgq3CRVvu3DaIlXBtqh2MIucu939e34DGi
         TnNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775811355; x=1776416155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPPHnELns2KmwcuHhGMVO2PJ8ZGhtcUFl7s8Vawk+WE=;
        b=T7oOM5fsu63cIZIBhVvBuzRBTDs40EU8xeFOd6AyunbCzMzt073bfULZ3n6dtNorqU
         8qPfo1h+lCGowjRMpHHZVVvg3cgfqaE2wVC+LhMM1C7gt9Bmv6I0lr7Rcu2yDQFSZRD0
         srH+FgmZ/NQdIVZvb58KUpVJi18ZocpbZWQfFZbfzmyChE/dvQo4XK8BHdCoEfVLukJP
         4xBbue28EtfJn/fVPIdoLz95X4FtRNOo17S97XPP5a3UCbEw7kui2nSIqjedj/npEpxC
         ApdrKD+weWZuBEoZ2uYvF2968q7AA3CdsyTHD2sdRGrB3JZlXaWAozN7zp1KkJwjt1mq
         sO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775811355; x=1776416155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPPHnELns2KmwcuHhGMVO2PJ8ZGhtcUFl7s8Vawk+WE=;
        b=DRyRZK+8cXVPPBjoD7cl/kzHmEUT3NA/LmhVdAaRt1ew9/nHg13b1yYoUj8V2aMn+Q
         I9d6WOD/PK4Ax8mlSyp+B1wMO1yzMoUGHRtKb7xq9KnJO8uWnMZQVUPrJq6Py8ccRVXp
         +9BrZS/sPXBJilDN+IVVF7+pfDArhbS2Shq0RVkdPARzGksoOjanl9MwkA0mupFzkplb
         PM0eUR4/iNfpSdRuKDAvkn2V6dVbwXF3Urw+/kDPSR/3tv2aQnRN1pK/lD6Yr70nMovW
         cRRP1Pki6IPjmeQjEL3mF0WAVjNFNa9+3+sxrw5dYMU46qimHMwTIJwDSkBR+4JPR9K+
         Vn9Q==
X-Gm-Message-State: AOJu0YyHCCRBM3X3H7cmP/PksXFPsjgdnUt6sKuFUqiFBu2rjapbD6ov
	pLhTBAGDqBdUjBK0YaO0dgMcPBwWZYavaw4kmaGbqAisI8peaFtam+Om53FoL2p8QBHvr0jPcy4
	IwA+gwhZg9TzfunwzsMtnKVxwBo03Yrf4mZ9hqbdj
X-Gm-Gg: AeBDieuaT/94RkVbtbQ6AMDwn/EJc2G32p7ZjC6wp4Yk49oOJ1w78ZKyHqyaJFp6nXE
	7VPSbDzSeeauBFx5tbyj2RTQ2xevENesh9ZBW/8KDwDz7dN0T0BE2hUzBYc1lHH3I+pBhTvLcMI
	rAyrmMAAculXaBe7dS6b54vHUnwCsE5l2BcnfxHFwLhpTP4sOTHUSycO4LsVc2sXYEhKOk1Lekc
	b339kgqg5H0M0Ql9A2n/xYspvuhF+9S2dAeBZtCaNbM9dSVEM8DdDhjXqNZ+hH9+8Cxzf8XOB9b
	SAb6nNuFOiTi6wd005SkHlH7We6KMNg30iNHYXlrwL6vEi9GOH1McY7wEicSQwIv8nWMHzuM+iw
	=
X-Received: by 2002:a05:622a:141:b0:50d:8080:2a7 with SMTP id
 d75a77b69052e-50dd5adb7a6mr35892791cf.21.1775811354973; Fri, 10 Apr 2026
 01:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410020631.191786-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260410020631.191786-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Apr 2026 01:55:43 -0700
X-Gm-Features: AQROBzC1FBtOtPyRk9XwcgTCleU31CdD6vdwYCEN_ZtU04kHxp4iQbsEzpj2qdk
Message-ID: <CANn89iK-F=e266k0CORfbvbwOuUAraQ1eU2qZudzyO+EvSKFyg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 7:06=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> dev_xmit_recursion_{inc,dec}() use __this_cpu_{inc,dec}() which requires
> the caller to be non-preemptible in order to avoid cpu migration. However=
,
> some callers like SCTP's UDP encapsulation path invoke iptunnel_xmit()
> from process context without disabling BH or preemption:
>
>   sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
>   sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
>   udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc
>
> This triggers the following warning on PREEMPT(full) kernels:
>
>

> All other callers of dev_xmit_recursion_{inc,dec}() are fine: those in
> net/core/dev.c and net/core/filter.c run under local_bh_disable(), and
> lwtunnel_input() asserts in_softirq() context. Currently only
> iptunnel_xmit() and ip6tunnel_xmit() can be reached from process
> context via the SCTP UDP encapsulation path.
>
> Fix this by adding guard(migrate)() at the top of iptunnel_xmit() and
> ip6tunnel_xmit() to ensure dev_recursion_level(), dev_xmit_recursion_inc(=
)
> and dev_xmit_recursion_dec() all run on the same CPU.
>
> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functi=
ons")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
