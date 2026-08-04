Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD04734ED
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871292; cv=pass; b=rSVuIMRNIyY4CS2aLLXU1yZpxD4HzLJtueHhH4LXyb1j2e+nC1spuIh8GF0TzWFBrGn5tZzXVsfqTauP5rE0CKJR8QfMSLEC9wMk4U+Z9jO0TozTqc7gxSWPus0xg2ZllG4MJZHMn5S8zwPPPZEp0HwQeKV7mEUjfRrDyFZ7hFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871292; c=relaxed/simple;
	bh=oCzTqmGLsrIYX3wB3JC2SmDrysquH8+Sn42YPZPJCNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUsA8TRQvLNoYgwIh54IK69GRR+1eaENelnXkEMmVi2Sz4gYquDQ2JSA9ojkHgMW9ZwLZJYV2f2M4tH8OlZGIUTRdeRid6AFtBlUTMno2lIAqCCDxwYRCUHLJViO2pLb114R9PtnuC/lSJc8x953pbhwGm/7exg3pljh+/pP+40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXKYewx1; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXKYewx1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso13255e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 12:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785871289; cv=none;
        d=google.com; s=arc-20260327;
        b=BHsbmBl7rOX7/kJsTsSj4HA3TC++RCp8x8XsHA06um8xN/qpTnfv1dE+mj2PN1PMig
         Y1Wgpqovl8AUd0IQo67t0+dQg7KX7IiQPLXxcPtPx8YXpGuJUyX/LeMP3p25wEWVh3VJ
         SFbe7kHd5X5RRVk0QSYeyrTyd1W1VxGUDvXgKc/xBt3BMt0nppxlwJbhN7QyFiE/89U4
         Xk5uoR+TeHBgCWUuIPBR7JCKb7O1WWM0+gJukr4ZqY32q1DJzvVigwH9kfuuyNOf6d7t
         k8CyR1Cak6xBtPxXu10RKBmZL4Ggu3b/PYbjploD+XA0KwYCANzl6zjK0lPfdwvd+a9M
         TYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eiQ+mFWGiecdRR82uMzLV4tjsPRxwsS531+EQTi21qg=;
        fh=klnnOY0YXYGDmCWYD7jJRtG8y0UZBT2CK/3Q4cBqSM8=;
        b=UI3pHr3sRvUC1skpTCCouavjQ2JXR9xhJs848ZEtqoq4laTpO+W+MvAjOmzH2s5MKZ
         k0linNjvO/5GQdem4Kl1MT8nnZv34JkbCJJL/3ZflsHeoHiJp+qCQuuOWcPLwM3vkELP
         8xuV71XmZSM0Y/FIFBbV43cBtqKuCHIcfKolpmrzZfh6yzElXDwyQhDYSa/T9Kf0PmbC
         UJIYkvkUV1SCH5bG+9CxwYROi5zFra727NdUdx+eDfvFt/pbswSHzenJvlJmQNRjuAWi
         tYBhTerCiqZO7JMlww+2D3EEBJnE1Rf7GeA70K1xb5v2He6LmiEVEM4QIabx17nlJJYd
         4DmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785871289; x=1786476089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eiQ+mFWGiecdRR82uMzLV4tjsPRxwsS531+EQTi21qg=;
        b=GXKYewx1qSqaSum5qkE3BM03PW0agwoC5LOvfJjfkOvVtN36l/hMJhTqQOCZ1rC5tQ
         Q0kBK3BqQ4i+7wpYGhzLTzrebO0U5r7R52fOkkQZQLD/Pawk1f9CdK8Yi8UGjY300MFI
         zNaZc7sx/wBHAHPSlxyOxf0F2A7GpBdVmjkFbvao5ljWuSFfprQ3AWEy9rJ4Pb0J0EWd
         N712VtMoDcQOfHzb+02fx49bWO/m26jrTOWcwmFAAsPD1oG+0vyJPUom46REx7zb5uhr
         D1uAvUYOcQnjwf/wmMNNWRJjP83zKAnN95R00WuRyRbtDmzgJyswswsqXktdVbz/bFni
         nLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871289; x=1786476089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiQ+mFWGiecdRR82uMzLV4tjsPRxwsS531+EQTi21qg=;
        b=rzggc3j1FoV+qaW3YMEhteHct0aq9FPaSx9Oun7fWJ6dLpIFEB2iC2NllDZDgN5ADu
         Txo7/ZHfMSPAUA83jvOGFyjBYjBXd7AWKOoW/BihD+Xd6hI3GVBQGw9NbxVWoFj9jnRF
         xqxd7RjXVTqbnp3srJbj4KMhdo+l9FlkUvM/suPILwNK3OnXnGznYW2sgUfxYdfC51j0
         2QW+hzd7V/vfrc1PappYzAIYKOYYFmnAG2e9ftL7WICYtyCxN67rf6PU2jn6jyMxa0Gn
         8Zva7zCOyuDe4tTpIkV/h4peifRKhn6kMH19FgaGQbwDoImnGAl1bBS83obqfXVn4H8h
         TPtA==
X-Gm-Message-State: AOJu0Yy2U42HA649NTqZVLgvo1i9Cw3rFZySY7/arv5JUOVvUA96Z32X
	mEbPNteH7mAH0gXpdIP9kU01ILcL4p7vldMYWTrKUAQSr2q6FTaEV/zIy2en3k30DHfx4BBKowG
	OQjUrpB0CQzXGJeC4FIbFUUarxkV7bhW/k8wtFZQV
X-Gm-Gg: AR+sD12GPPZzMS52xhUBiKvSx8WC+c5qx38z3jRvqtK0w3UnYwrXSkLjwbuB4eHvN92
	rt4aIZ6Geoe3c6Ki4f0+lJ973pbhLN4+6grdm7JI2whDjb+GZ09zP2zhObk0JISzgJLNsDPyita
	hr1Foj8PHF2NTgfW4PcOc4E0l6Bmx0nEtCoCIOUcPvzakDNcUfiIxicIqHOyVdetW8Xb7RDGlgG
	ufBEDnRKK8uKJW8jmSpafvhpNtdnlQ00PPbI7dHmXTIOcW5OxyHT4ef/+0lY7EpvaM9dtSx3jSP
	FQEDuQiklPTb9H9GvhLYHmgh0quIoxR83R6HAUjHtxrJIwY45fku4XQomT7WSzBNLXVtMwnkJgc
	x42Nc2HPuS629+V+kzL9iqjQnbNkfOGA=
X-Received: by 2002:a05:600c:a218:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-4994e5f4f08mr178735e9.2.1785871288247; Tue, 04 Aug 2026
 12:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801131220.1367229-1-almasrymina@google.com> <20260801131220.1367229-2-almasrymina@google.com>
In-Reply-To: <20260801131220.1367229-2-almasrymina@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 4 Aug 2026 12:21:15 -0700
X-Gm-Features: AUfX_myVmRzjrp685Tu8JJ3h6NSemdTy01R7tU1JzdsGDX3nrETED8K6T0Axa7k
Message-ID: <CABdmKX3Qyeho7Ru8HOzWyCrKXp=kf2H1pOUTXVR3tRWpYhKpTw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: drv-net: ncdevmem: gracefully
 retry bind()
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 6:12=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>
Hi

> In testing environments, binding to the port can transiently fail
> following a driver reset caused by the preceding queue configuration.
> The failing bind() is typically caused by DHCP/IPv6 DAD needing some
> time to resolve and assign the IP address back to the interface after
> the reset.

With EADDRNOTAVAIL? Maybe loop only for that errno?

> Retry bind() multiple times before fully failing the test
> to improve robustness.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/te=
sting/selftests/drivers/net/hw/ncdevmem.c
> index ffe1d5c1fa4e1..6724f81e389fa 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -898,7 +898,12 @@ static int do_server(struct memory_buffer *mem)
>         fprintf(stderr, "binding to address %s:%d\n", server_ip,
>                 ntohs(server_sin.sin6_port));
>
> -       ret =3D bind(socket_fd, &server_sin, sizeof(server_sin));
> +       int retries =3D 10;
> +       while (retries--) {
> +               ret =3D bind(socket_fd, &server_sin, sizeof(server_sin));
> +               if (!ret) break;
> +               sleep(1);
> +       }
>         if (ret) {
>                 pr_err("Failed to bind");
>                 goto err_close_socket;
> --
> 2.55.0.571.g244d577d93-goog
>
