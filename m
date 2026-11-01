Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793512133;
	b=ha45tf+Cj8Ho6eo0qZvemSyS1jkra7QUMUqUA4c9Q+qmykbr1dnHXLrQDeGxbVKd+XpU
	 sZkGnncrdb08ZYr4bka744B+zA3w15T7vJr/bY4Ee6yIfKD4akrMD4z6w8YJHNnj82uRP
	 O+0rLfvJB962TfCI+SfkhSKO1hcVryjtuw/8W1uBzY5ceYM3s8lRqL+LUFmAEP+Y3ONob
	 NEy3aMDC7jAkIbLwHBtjY1MkURQ8jYuFHW4Xy7zt4WtVmFoqq9S8piQSV/aHRSgdzDAdP
	 OH2qTLGfbFonYvshQTqJvEzrztaGicWqEXbwx/wCyfWsub7KaQAAq4nhedN5FQTRXQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
	b=j9td9qoEenKj4DQrOMkn790Mq/dm72mnTyEQ06YAGu9A3sLOIRA1hEqItMgXjawPwLAW
	 nwgfHviZTB0XP8d5zSj4FpSVNQFjxzNKZwoaF7tCG8xFkrCO8sQJhU3QnvPBIynaF/Ieg
	 ONrimvelkNpB9gs2QdSebJFR20zKgJFXeALx1NsjThLhhIofLT0Wl0W+21fsgCnPViKgj
	 Jvljf47xBD9B0eg3KIKaiTFjwRL0MOt1DGIdOJ2soyN11XCd7jY2v/ZApsuzJJ8FxUsAJ
	 fu3UvuDM3bAmJYAQ1qet0YmHRC6WdJ5ppMlQDm4SW5K/tiCDPgVNc8arYBRGlBETgeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weyO2K2Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C4606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 05:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weyO2K2Z
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so17380821fa.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 22:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793512131; cv=none;
        d=google.com; s=arc-20260327;
        b=n2GBKy7lo5qG21Z4gF4MgDYdLfMRNsqW5qoPZaH5U0mgOV/uP+S82qagVN+sCh2u6n
         XISPQZI0zcvEJ6Pf/af+QI/+bWWwMkLFv+rVpESHQzBUR5qlH7dsHQF4X8YQF691ReSE
         It5XVP+8n/Aht1hIKNVQ6m7EiF+Rq1hPFE1Iz/mjAQ+XvuQnz7E4P7Rycf2OZ9xXLPj+
         aLSKqMkG/jHjMTJwjY3lk2tGnLLKjQZki9omLk7s/N6SPXIlUm7CU0JdFDEaso9OdUT3
         hfx0tffv0PSeblqcZGEhHfUp8+Qldqczb/8JljxElt6SlGNJa2AQhE12zz455NFujc9X
         Vprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
        fh=a49iLzkEryX2XQEFLUQgXI1XGY+sBnY0dKX5WDBXgfI=;
        b=UgRNd8dxkT3/ksiqYlptxsJx9WqeW4pzclXadxAuYh9d6G91uzPwCe1fRaSBGzQnvh
         ozjhGbzwk+2UUqHybc9AdA0IBHlAfWcGcY0VduZJi4OcyKshCfWfMOSn2s9JP38AiVuA
         gta8QGijB+j9jY/hs09mR4M6uRk2BByj7mKT4IJJpyZ9lmJk18aKocRcVbP+F2PZNhlT
         H62myLp2/18Opqfwx4/MvaUilOULxRz3Hi8EdA21vWNgTtrR6438acz3mZxCDmeT02Ge
         R7jrwFsA9Aw/q70/YpNy7G/HSwAlADBktRCQ5q5CRvmGOLzdWB+Xe07rHaoV96cy8lcO
         2R4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512131; x=1794116931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
        b=weyO2K2Z3b0LzD/hEyODcUaTMjso5EY+pHzgpgsO36+Go7wri9KGFzwbOpt11QlPm2
         hM6VRrvJCFcWqLlRbdvtdLrcIYxwb1is/W2btLLeBpycRVMvHNZbAnya2ep3XFu7aQHp
         tr2F1uocntttl9YlKlF6ntEWPU/tKGg+OIUkiDbF+AutxMPipzwlq+Ki0KkZRJU0bWo5
         yal59Z9UAq/4hrOU00lGv0fUtxZ3/op2fEx+6Vk9zJlgyxOAYmvwVQGH+7vACMaGArG7
         4TVwXsSvd9lVy+56qYxm0lfSpTgf9Qllc7GxU4poZR+lZM95d7xWc4aNnJqwwVpoJqMk
         QpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512131; x=1794116931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
        b=yLUGe/W3EICGTxdPv5HqlB2YZ0sttQpgAEgb/ElydNEveLbhxilfjZgWpj3ipCgM6A
         XOZMlW2Dp4NuxKp3o3GSVxVIF7U46N9W7JYFTnhvmEbyuA+oVfGHQV7g+c6UaZ6aRzS8
         cN/X0AJ24akTlEl/fozBFW1TrD7bkMkMdtd8YpGG9dGwaM6jJWIBZ+TDj/Mo0AgOcx7A
         qQXJRKx5O0M3a810RpQNVrpYwkcw62es87GUMUxuolZFYO+Xb5CdiE40gHnWZXvOOy/W
         /6RxvDQq/cFe6kZpNJuTlEieA7Ky5+T7ObD5iK6terHZ+ezDD/D2yEm+tI6P9tHx1U4I
         E2vg==
X-Forwarded-Encrypted: i=1; AKwUvBw3eS/+0fe27FX2DUsN1q1Af+O186mAhcYRTphwgyACbTfa4u0EMfVTwPxVznMoqS0SdsZeZE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPfSGagJ3eMDfowfR6pg3IzY6UHnu0W8G7r7Lc/QrDchJFe5Z3
	wbVfPQQFEAwmdXbK3VycN5yTLEPmV5j11t5EaRrEmF4A/3C71tdYpOO/ikH6NzhC43AWlZxihnX
	K+pxHau3I0zXgZrqYhmLL675PBWPSq8GKJA==
X-Gm-Gg: AYBFou2MyrFoPyeERxFUumKrarhhqRScmdCgLUGnUMuvhOdOjorT5zFF0X18RIwUxWX
	O2RA8CDdpPOUxmRaw/WNR+DytLM6YpRbz4WRXuO430nqtTJoqmVz6zSHlX/dRZAauScIX1kwFQX
	mXqPOr4o/7CUJsObbRQo1vEGC61WlDXHWV0La9qGHp8GWESgVGMtpZLq/cZJtK9Ud5FinRuQBbW
	hZae5/p9pt9lF6fazziltZYkdvoGEBZRxAoZkfMx0J/tOUF5MC43HwQfj40wBClyzguoALpEOcb
	M/uTHYZu8hclqLzmN7lyK1mwhLBKwlf9GBreywxremx6t0zuQBWd34a/Mj7+TMAf8WbeeDC/2L2
	1qMNMrVfkj/zWZtRrSeZYzU5BP49vUm2Ob9kFkfWZ9TXJH4g57plDy4hM9m4HcAxufYYKogQ2LW
	55go508MT4aMPQA7kw9oeaA/oN4EQJOw+xlK0Z+bixW5Fla0tyLM8=
X-Received: by 2002:a05:6512:1252:b0:5bf:d938:b808 with SMTP id
 2adb3069b0e04-5bfd954bb21mr2075584e87.1.1793512130701; Sat, 31 Oct 2026
 22:48:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com>
In-Reply-To: <20261031133455.3070233-2-rsalvaterra@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Nov 2026 13:48:13 +0800
X-Gm-Features: AclHuK9Oijgn2EhPzsnGywVMmHQSWFg3blfXJ7nFJaMnQXGzRvyU2SOiQm3Go7g
Message-ID: <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 9:36=E2=80=AFPM Rui Salvaterra <rsalvaterra@gmail.c=
om> wrote:
>
> Since 614f4d166eee, on systems with ZONE_DMA unavailable, the Tigon3 driv=
er
> fails to initialize, at least on systems with BCM57766 controllers. On a =
late
> 2012 Mac Mini:
>
> [    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for consiste=
nt allocations
> [    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error =
-5
>
> Fixes: 614f4d166eee "tg3: Set coherent DMA mask bits to 31 for BCM57766 c=
hipsets"

The format is not right. And please target net branch if it's a fix by
changing your title to ']PATCH net]'.

>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet=
/broadcom/Kconfig
> index f0bac0dd1439..c9875daa043b 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig
> @@ -124,6 +124,7 @@ config TIGON3
>         tristate "Broadcom Tigon3 support"
>         depends on PCI
>         depends on PTP_1588_CLOCK_OPTIONAL
> +       depends on ZONE_DMA

Did you verify it possibly affects those kernels without DMA config?

The blamed patch seems correct, so I think you need to root cause it
instead of adding a global dependency here.

Thanks,
Jason

>         select CRC32
>         select PHYLIB
>         help
> --
> 2.55.0
>
>
