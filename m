Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54511380FDF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844047; cv=pass; b=hnY79e8r1p1XS0eS6XzQed/DCVlOE8LJKE+nBQsYtD0QzQrb5wXHJrP6tkKwFvkoubR+6JObDuSkY1Raav2zqhMjx5u6w2Nj35sS39reXspDalwgxElW+9+9E5BqjSgBQJPSWJr/WzB7ly2/xJLbWxicHC9zryOGAm35MF12Kl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844047; c=relaxed/simple;
	bh=F1aKEf0+UY8QdGbI80WfjYGHcxUeD+r2aROycezgenk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrFn7iZWMp5o9qWsL81BaKQiHmf92UxSNs2TTYwpQ0phercVG5US6ytME+dLKmKZq1/NDfhp0JIn89NTldkv7fOCYpTtSAlqg3Jf0MmaLwyWf8fyoZAShWegfU2GdoHXLig+ivwIGMwzVl+5NIW/BgcUBtnzomIB3tw5HkBOP0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXkQjUHD; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXkQjUHD"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b01cb18515so3966377e87.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 04:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785844043; cv=none;
        d=google.com; s=arc-20260327;
        b=o0T9JugTn3O3iwEly72S9JrRo1Szdis3e/cuxTBt6u7iZM/SBY+3qpqj8gKq9umdpW
         af8peXPDKZ0CWlCwBE/nHGcYXIYvQUt+f3/0rycSe1Yu4leZF2xGIV2XMBbvbOI/onrL
         c1mM87nKZuQeOgYncL5OMJ3PtsYMu2uQYXoPK9gUgaMXDnYi4qAAZkP8kF872F/DUeKN
         /14Tciym6NA6j9tWtabJg8luMzF82nTMkEBiJbinRI5bNkzMNQK9S4XbzaqKaSGw/AQ/
         GKlUKuvBjpS+kdtA9FyAdjXK1TG9jP1pwZXWIDO2wmjlG7GthjxmmmvPD1+lyEKhu6IV
         ISFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wbykn1jlWzXgukkhvoAIgn0Mbp7udhOlX2EPLRb99Bg=;
        fh=mIYIqcA2cIepTZ97LlCyVydu+fvA7aHn9w9ZFvGd/+c=;
        b=pHhbJI7KpkKkLBbceOXeCICP90D4/S5BuZss3VDqhNimIcWvHeWRCuILrKsU/D+fVX
         nve6pvJKlQXM6XXUXY+azGfLwVppnEAKhUEZ92DZd07rTFsKLXezQ+K8DKAmotSEKZ3y
         YzbRktMWbREvXEtUNj1jbjLMAMvy2eITA7s+9UsuVgGfllOC35Nl0ncVvFtGlq/8hFSg
         onuLa1rc8EhJB0qsfRaRBDhH4S+A/eXiHM58fdO4Pwnp+YXGoRSNDu6xKAMRV2BfcwGS
         1Ogxlj41c0ku6LtWz9U0a1ZCsMKcB/XCc58U89sgo9kk2pjzG14WKLNA7jDC+ZgraR9e
         fqag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844043; x=1786448843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wbykn1jlWzXgukkhvoAIgn0Mbp7udhOlX2EPLRb99Bg=;
        b=YXkQjUHDfDlNmGY0EGUehCSpT5/pj41nX9tEWpgDYqw3/ndJujCwH/dNr6E72RNcw2
         8k+ZzOnkoCRSn3p277Yfwz1B1F91te8NpRJLuaYJ5scUJcuHRq2LE1371DuHczOh9Ahb
         lIeVKrAzfpm/Tv5BJQ3X/JH5EptL7VWOYjiQ72onPAlYK8QXuvn3yVdYKMQ2kJqOTT03
         /9TKUk1qKjcpnyiHm95frNlwcCKweNjJ1Ppa6gjdvH69opqUU/gt1oubCtx+vkwa6ErJ
         lvc+qozRdtXgLhkVPLB1iThvVyTeb7qdXjotUoHkTnXGTWp1mzh/hy8vEYb7m+Humoh9
         4kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844043; x=1786448843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wbykn1jlWzXgukkhvoAIgn0Mbp7udhOlX2EPLRb99Bg=;
        b=hfpc594t34ALrxM8lzITBmKSJytlygsL9FW1wP7GnpfyVJday1UssdAMKxRw8wA+Er
         Fy81tpCngmCCr1YcGhDrflxhq5We2Y7/AxQUJiVCDqCrwYo07DWqs1CeS6kbueuWXpzL
         ofqpCJm9fsMTd3xP9TWWvQLj6Kf/HTWOtpaBRJuTgqfBZiZTV8aon6cO9SYSTNP7tuZG
         lmlJs8pn2MDTwpFcbts5t6K/UiZXJ6P3Qany8OZ7GEo+SwDRliUbBaTyZRFt9wXAN21H
         4zpPkSz5cDjEY/9buiVvDfDIqCWLUnyrbKFtgnQIRpipfTo0/Lz/0nbpA1OQ9rSrTK2D
         psfQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9R9pNnXj4RHBemSLhdnEuyPLdajPeaLSCzpFJFVOwbixdhB69o3+u/NMq28+sz0pGoLs9x2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiXt89uzhNxFUrUN/L9YwmhHLS+pHJcGSflsKq8k5MCd0xiDe
	Bu5xgSJfOK8Z+lK0WzDXDG7tyZuTcsVuI9sDqAAOyiWoWLMeZ9T7ZGCpXog3hP9z+xOT+MaEpZF
	S953pAxAKPxleuK+iX6CKOblG6LCCgHE=
X-Gm-Gg: AR+sD11dL3qHV8hk6sePw1Rum47Gry5nApdELFKjQfxjLXcRZDUcYGwTmujF10sOawA
	Q2/kECCmHdNf+MHtigXJ9oFZ560hjA3eYHYdgiZeIauozlkhFws3yceE6dne18pBQUt59l2l7QV
	+djpv/uMPHD5GL6aoFKyRqLJAd1AFTffSAz8mKWsEjof1GikI1Yh/MJUwQAg3GCZXxpnmZRmWpa
	mJ2hyqd6BtzCSSRgZ+8Vg2E/H+1RTW3IXkWLjAzBMmClaKuPQ7vGceAwMNXAV1AlUpgnetsV62e
	2MfXC1rZ3YoM2PeOsbs9/sIN6dI+5BlF6UvXahsu6xSMPgc/gOOVDWzv4bDKrFRwhD9pPzl/r77
	tDaNU75FVraEP02MPyT5tXRpLAfHQjjA6vMRlNKaDZTysDKY4kr2hWMEHiWAlUzld5VVYj7aGoo
	YVbKSiGw==
X-Received: by 2002:ac2:4946:0:b0:5b0:1572:5b0e with SMTP id
 2adb3069b0e04-5b2e4f73457mr1827838e87.39.1785844043067; Tue, 04 Aug 2026
 04:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
In-Reply-To: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Aug 2026 19:46:45 +0800
X-Gm-Features: AUfX_mypfQk8w7EqOyDcZbbrJ_FGx0Fqf5tiqd7XFD1IFRW0P8HWAI7KhRJaBWE
Message-ID: <CAL+tcoC8ORo3PWxm1Eecbxhy0g+RRHLMJX4gaWxCp81U9ouArg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:11=E2=80=AFPM Xiong Weimin <xiongweimin@kylinos.cn=
> wrote:
>
> Validate the AF_XDP queue index before dereferencing the receive or
> send queue arrays in virtnet_xsk_pool_enable().  This keeps an out of
> range queue id from reaching vi->rq[qid] while checking page_pool.
>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

Fixes: 24fbd3967f3f ("virtio_net: add page_pool support for buffer allocati=
on")

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c..6160aa8ba 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5896,15 +5896,15 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
>         if (vi->hdr_len > xsk_pool_get_headroom(pool))
>                 return -EINVAL;
>
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
>         /* In big_packets mode, xdp cannot work, so there is no need to
>          * initialize xsk of rq.
>          */
>         if (!vi->rq[qid].page_pool)
>                 return -ENOENT;
>
> -       if (qid >=3D vi->curr_queue_pairs)
> -               return -EINVAL;
> -
>         sq =3D &vi->sq[qid];
>         rq =3D &vi->rq[qid];
>
> --
> 2.43.0
>
>
