Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E831B114
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703290; cv=pass; b=t119cqreqWuzQBHzkURcvPb0KRL/1AjfRaou/7Aa0uKu6C1NZsE9hHKmTAJ3Pcj6lYKJ0Q3KeIGQu2lIB5SDx9uNOXGscVFFIJeTQLhq4geW2wTUaPX9aIIbDrweABGraBRtRBGQ88JfISC2dT8N1Y4N//HMLNgYFzgr9A5QEfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703290; c=relaxed/simple;
	bh=A3RhLhmgYPimIVODTTcT+DyLrnNnCzlZBr+56Tcj1Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvYQ8BL/V250vZ03pXsk7rEnwsu66WVHFY9Y9QTUNg9p9RVl5BgcyT8nGCj9Vxppb0vetaegIsrsKPVESH6QGYta7O0QSk6dg3jzI1dLh2JTas8ruA/pcopIWmfubQomYNKDRxK5jlh3JUu0hXZwIwJZNFDNpWyJv7WWfismWd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMWhhQ7n; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMWhhQ7n"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c15bf5000so82902381cf.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784703288; cv=none;
        d=google.com; s=arc-20260327;
        b=DBu7IJZRNl/W6r5vIOFVXpO72Auqg4uN1LBGapr3GHAYvoDDcvStvGQpncielK/cQ+
         qoEQ2t5hp7F7BxV7bVOuOR2Kt29D774d2Nekq407tL88ngBV92EfFgtqhQQl33pRgL/n
         3I6mBRTklRvKHiX5hMhCOh66ZK1diKefnb0KYdSXzZQ0Q6Z1G3mK+hDoF4PcULrILsH6
         UQ7MkRz3dGdJUbMslQx7Cxqr6R5l62Thld/4isVpqRNghIwMU3UqcYrzi81oU0zvOV90
         XP1pnKLqpoyKJ5h9GSKgTg2pf0aSBYN9h8cTrt+VktrdW/gTAmt5+W79WU76Z1hDHER4
         BUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fCi6BD+p9vBOq6sQJ1WD+vUa0a7iJZxIXY5GQshGsd0=;
        fh=urv/pz6bt+BMahSrX1HrZABFfnMLrtiWnWpJVr/WJ7Y=;
        b=fvSLRHk8o5XjJxJWVucnsQ2ZoTW112MD4jAUH1wlGQNR9slHydci0YejPeax1n8UAp
         6XBajOWlynyzgC2ca8APazDJdGL/7LlmiW9Y4K66V3ZK8KhjoYkZm1663FZVLRvFgf8S
         YCsAGD1a0hQgpS+FeSGJ7mSEVaa21ElV/6ZVGg1VzFjh+UDB22sn6A8Tz/AZUFk5+iOt
         /5LUL9UdoH5/1aUGgZ/iyuywVlnedOUexXH4r3L1KHxPXibYOXKuJSqiWLfiYW/kagBj
         y7nB9R6V7UO2lj1ZXhFMFeBc4qwAOOWuTr5EBZd8bwYSG8lqgbBJXAL+IT2O5O2BSDrv
         UdxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784703288; x=1785308088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fCi6BD+p9vBOq6sQJ1WD+vUa0a7iJZxIXY5GQshGsd0=;
        b=lMWhhQ7n9feTbU1CaLZ+Yy3HmiG01K9aTr55LZHufbIgJc9wQSCITLsASzJwtd+O82
         k1LueZcdNGRfti6uf5QPbS2aPYra71OxUtwPJWYcr2fQmV5Wxz6Ozz9mYnzplS1kXR8p
         UUBTiBtdn6zvxi6MJPTBiWAeVbLAV95xInrtHRndYY9W4t2vIZrUEzr01VWoNWv1s9nA
         MJ/4ySPdzTvvVxOCI7Gp7k+eSBHfqyQLUGrkncrNVxh6L4/5KqeSH7JTFALpZB80fcw3
         Nm27bKu1hdVtV9/ui7rVpaGHWtaxsJXeXYiGdgTY8udeP6CwoD4E5hjNFHy1Sr+eiUjb
         bXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703288; x=1785308088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCi6BD+p9vBOq6sQJ1WD+vUa0a7iJZxIXY5GQshGsd0=;
        b=W6G2pJ37/d1Y9XC7SJ7ZMBS7s2q72hpGetLZebVcCKr4s1dy/Q3ZTZCfbQMGHNmqVw
         CtIbQtTaEY3AbCEUJlWFcXgqqWCH6OGfmf6IUaTycf/z5bZdO+XwtDUK/3I6LTIHot/h
         GTO18BLYgIwxBAYahLlin4UxqTGEplwXyXCLLDark9w6fqjk7e4vy02CK94FXmS3Vpy7
         UldcreJmFYDNM7X/SACYj6cVTAMVAOkfh6cFx1AYPdM3nOBZATjzaKucrfjGWDuJwshg
         z1KTj9y0eQeCdpDRFHNh1G9YWF/SbN88Nb5WDb0n2vm8mYqOXJPEUUk5HXREeSIB9Qwd
         VtEw==
X-Gm-Message-State: AOJu0YyNKNvjH1HCre5n1P9JaKNWP4JhAMk6OtsnAnDsB0jDFdlwAfbz
	+zjh7vWrslBv/DIVTJis3IQP+bnV3KW/K7HZg48MkoWKWyiK+bvhLIfRLZvVXNSbpcbsjiGsVQQ
	tnrQTI1qItmyK7zYWYWHdbVbVhGXf6Nrb80Yix/PM
X-Gm-Gg: AR+sD11gosmTSwT9ji9bRHuPk67bG6ZKBNnA2yEuKyrylu4gDUKiY3ycoHFKFSmSSCI
	B/eROcwDfzfp2LpoGOcjAhfX3+BSJyCP1fOzXuDfbgUMLNlFelDEkWbKc1yX2Vhxkp4OwRiDoEz
	vJ5au2lYvxIvsuRQsEtrlGuMxVNWA/mqmINdm4s1lOsjsIYyniMjTuKwxlJC8s0e1cmDY7YMcUR
	t/8n+3wS2c8ZCZzGB5Mm6BxcWWwAz4ON6o829RPkAF6JwYK0xUEnmC/tRMSMzhgq+6qVYFULjeG
	6strKstHXjCunInPIzyc9PZVKGhNf0C5/TrTmy8Pxnrj/DyPvH+f72IyVKSepjgnN3I7wJ9qzJw
	=
X-Received: by 2002:ac8:7d10:0:b0:51a:8c97:938c with SMTP id
 d75a77b69052e-5213e182f07mr211417071cf.67.1784703287179; Tue, 21 Jul 2026
 23:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
 <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
 <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com>
 <CAOAwikBYp7AAxFAZgyLaOZEG6Eoomq3aqU9ViMS8nrO82PD2rw@mail.gmail.com>
 <CANn89iJ+M_r-c3iGK1o7_pLBTVF-s5_R-8MjL3=Q0Aj=1a4deQ@mail.gmail.com>
 <CANn89iLziS_XE8oz03VWU47NRzP-G8OexL=-C0mxcMMnOia=Rw@mail.gmail.com> <CAOAwikCEwv=9gqpfqfSyQW9_1ZqP5cJKq4oKQaGeuYfPZrPJ6w@mail.gmail.com>
In-Reply-To: <CAOAwikCEwv=9gqpfqfSyQW9_1ZqP5cJKq4oKQaGeuYfPZrPJ6w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 08:54:35 +0200
X-Gm-Features: AUfX_myOPLL7_cij9NAro7ZtdrJY0TM3VbQbgZRMSa_YHD68dcXgFeywRRnxRfs
Message-ID: <CANn89i+WKCW=JGu5P1WQy8tSbKaya_Y3C5xYF-X+Wcz2hN3AcA@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Muhammad Ziad <muhzi100@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 12:28=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.com>=
 wrote:
>
> Seems ANYSRC flag is required for ip_route_output_key() to not fail
> with an error:
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 23e921d313b3..c2428fa21b07 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -548,10 +548,15 @@ static struct rtable *icmp_route_lookup(struct
> net *net, struct flowi4 *fl4,
>                 if (IS_ERR(rt2))
>                         err =3D PTR_ERR(rt2);
>         } else {
> -               struct flowi4 fl4_2 =3D {};
> +               struct flowi4 fl4_2 =3D fl4_dec;
>                 unsigned long orefdst;
>
> -               fl4_2.daddr =3D fl4_dec.saddr;
> +               swap(fl4_2.daddr, fl4_2.saddr);
> +               swap(fl4_2.fl4_sport, fl4_2.fl4_dport);
> +
> +               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup_d=
ev);
> +               fl4_2.flowi4_flags |=3D FLOWI_FLAG_ANYSRC;
> +

Thanks for the tip, I am going to test this today.
