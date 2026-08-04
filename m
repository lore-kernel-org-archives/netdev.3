Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129619C54E
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844452; cv=pass; b=C5POtrFox5pN6cBHlS8GB95y9t6H+usjNqAV2/rf6nJAbKFaRPEPXKewvYk5Thr+R8MWE/ovDQ7+DrPZ8fbVvAnmr1y67HJCxO5o7yHWo/K1qoKBNeeluyPxXVPbU4/OvyxcG96lvdDm0hWCa2rwk6xVgAodyTMkiF24K06N2Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844452; c=relaxed/simple;
	bh=NiHYBO6mM54WqCxaJ6DJN8tIYDx1o+0wAXpicen5XgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqvaHeIkf6zcqNU+UbZBd9utQ1jkfQuPd75lEcY8BDWQg1fJh4KEq88TbILvlsSg/dSoavvXm2mh85pwpRVrNYQwKutaFt6inqI2rhSRsysCEUeuiG16WDArDw9ZMpptNWGFA1ov9IcRv6EGG/2ySsKWgmd0ej0I1Z/KqgjlBQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5UgiR3V; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5UgiR3V"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39f75e0a2f1so34458231fa.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 04:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785844449; cv=none;
        d=google.com; s=arc-20260327;
        b=F2GwjxCIKFoxSNRoQB0/wDGgDX8RfjlMibLaELCEIlL4DVICFieT/ue0Nh+lRg0uC2
         VsAugmFNRHaERic0parX31I6Q4L1Nu8a1UYbZFEe4snEKEj1fQDe9LgT1Ec/tb509BHC
         7XZ4YuokiEpv2ICz3VC7Y2VdPbesOsdcXwZo4YL8lmFWNii5FMfoZYTjPjjbbk3CKMMb
         mJK7O+03yYfagqXt1ia4jpGmlhrLc56NXIKCG3WML4mPkt+Wqm7GKWmsfxo6mDNEwJSb
         Ucx3Gp/ycl83LOgKd/1Ysj8ZB8vxssWKWHON97i4vFFWQyCCBDjkEiUljXIJDwmjKB/9
         AoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzEDkw2lgyz4LJOfYQbkuDjFz07+NbqDM9wJpqc6Ag0=;
        fh=fWYPagJQEqPIzxAp+TDLzE1W8m/tHXwSZ4sR+d9gjcA=;
        b=Yk6OTwUpINQLwUqBCVixQZyZ5e5GAGTnCK3prv5X/UB0ws0ettN7bdiLnj4T4ynL9N
         tMjN480XPdVpAIDPbapOyvUE4mEmo5h8WKIUjt3BhCq9U52rVVyHUW1Fn4nkYZlzY65p
         2Y3q9NlVEvq2/0Q/3bULPegOptpowGiKccMA0m8p9KQTgjRypn7xZPX/oUZghPcysxdO
         CnAbkWtN12xszLFHlCKHdaCK4uZWsecxY9ouMEeGtKp6a1Sx44r3IqtCeyYznBPaUsfh
         YUMMB07pbTV29FYiLNsBMVNLSDE3L9ZglDCkZpq9GvtdaSt8BTGjyAHo7ZOUVBy3KdUz
         hN9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844449; x=1786449249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzEDkw2lgyz4LJOfYQbkuDjFz07+NbqDM9wJpqc6Ag0=;
        b=n5UgiR3VZFbiFQWBBW536WQoEMoOQoxR7wJoVHEjjZcqhuRt4/lcTpvbOi+NOTa1SY
         8oQfXLFfnysMFD9MT/3hKft87HshcIYCOf6XozOOuLTM70QiWt8NhxoAmZvZyNbcjkhh
         Db0Q1gof/TD/j3Fod0eLYml1X9xGoV2qp6xbo9llR2hiAo7L4O3G8NToKeVvXxYby6vh
         AyRx7QXLDt7GaQqqim6VnzKhGt2SZTO08lY6pV04zc5frE/s3JjOkA8Ec6eQ/t58ZHo3
         gMpMw0huMqVwaNmHaZlvVpNmkJvUkghFRqF5KBfg4n9qBLyBZ1jdMDWTQRrWf4XTS7mC
         Fq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844449; x=1786449249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzEDkw2lgyz4LJOfYQbkuDjFz07+NbqDM9wJpqc6Ag0=;
        b=j3N7Ii9nOdhyalBOYWWF9RLAPmVHyL7DO7pn/BhoydHVmlPZgYr0JK5PZLKnkHl4Xn
         V008ZXLe/HzI9oW8qw+x666Rj7sHXqLLzOOa1QTnzCAP7rOXClNAEYb/6skZGWKyYi4j
         K1qQQKdMi+DLYl9ZhrqF3Czijxu0lQjnP5snjwWLN2hsUMXz8ymxHxctX4WtmEOBGx66
         rYMiitGwtsmap18aRiGbfkcF7OFHXKxRGoSV8fjaVBerRTdL513r3wp7SpkO/c6bYdX+
         26ggF1Lvcp3dMLFyix8Ps/RsyG3Bb4v3s7z1xVoo796q6qYK9VI0ymGnvOkee9tlMOCp
         lVsw==
X-Forwarded-Encrypted: i=1; AHgh+RqijsEWdpd10N/jLdc7xP1iPzr9xSfenxeNaK6t7SropROnA6dYPZKUdbILcBGU/7M8lvOGWi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJZDGtkfaaU9Bo7rcQFF9EjeA+fOJ6CQDNCt2uY/4EEieAFb+
	ktDkh+kjuGhV8S0/+afP7Rfo6MTc6Fp61qXwR4yac6ivMMCSFlKkS3nLfGNOw2cff8IwkWo6O2O
	c0YgLFIETxXJNoEQxePr55Bk0aJ09YI4=
X-Gm-Gg: AR+sD11I57ctJH6sf9PJzGJdvoyd8RJLePCOkKQHS3PAH7F5r31EQy3rQ1LjQ/yYWmA
	xuX0vPCfnvgSi5NMnvyRZ3KBaeSKHL+bi/twdU6hfoV1LhTcHfhi/nUssQhwO7emkCBe0vMOEf9
	PYGf0X4LFYSw876uJdTIuk5J5Y2Hh8Ej8XlS+gDvzCfUiYLCRNKeN1OX2KrkFdUyKw0XQfiaTCW
	O7Pzr3gbjJkbVkgADzD2Edg3cY8wuJKCv9hSwItoi2elvNa75TYDRs4UDUzA3gDklcZUlcdrPfM
	0Me4cY6TAjmp7bbzZ6j7Z8S7XDm7nJUZ8NQfJnxXH7OTL8UHwMevr91Ytn2f3NhsyW9kRuSyFqZ
	SEycNCJMunGppw7d9//AKx3G6Bx9Jn1AxaAXxswMAA/9vqQOn4mSemn32jc8=
X-Received: by 2002:a2e:a99f:0:b0:39d:b60e:d70e with SMTP id
 38308e7fff4ca-39f8613f0ecmr28953541fa.3.1785844448678; Tue, 04 Aug 2026
 04:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn> <20260804085330.1333242-2-xiongweimin@kylinos.cn>
In-Reply-To: <20260804085330.1333242-2-xiongweimin@kylinos.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Aug 2026 19:53:30 +0800
X-Gm-Features: AUfX_myJfe6cC_LDyaq8piVi7GizRNnxneLKwPSD6Rv2uLsowGjk9JnmZPaYfjY
Message-ID: <CAL+tcoCVPfyK3o2Ps1eJgifAntffMSB8OoZc4eRqw+NHpz4mig@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio_net: unmap AF_XDP header with tx virtqueue
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 5:22=E2=80=AFPM Xiong Weimin <xiongweimin@kylinos.cn=
> wrote:
>
> virtnet_xsk_pool_enable() maps the shared AF_XDP transmit header with
> the send virtqueue, and the disable path unmaps it with the same queue.
> Use sq->vq on the setup error path as well so the DMA unmap matches the
> mapping side.
>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Nice catch! Thanks for your work!

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6160aa8ba..a6f90f579 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5959,7 +5959,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>  err_rq:
>         xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> -       virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> +       virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
>                                      DMA_TO_DEVICE, 0);
>  err_free_buffs:
>         kvfree(rq->xsk_buffs);
> --
> 2.43.0
>
>
