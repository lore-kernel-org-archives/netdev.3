Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793562110;
	b=S07Von64iAHXdgE3lNzWN19fZSjZ/atFaqO/kDdLBT34OUQEJ2Fc0AtJniPr5NHsobdH
	 6ec1u+ULViWnfJW4aaDQDMTNuo234pXie7F+FruFdYMykMvJ6hDTCT0wignPGS5hnpiA0
	 78uP8PiCwIUTh+CqflTazikL+piVAvvjX/WyQAQbM+lYXCErovlJPmk0tBan/hypqS36N
	 /DMQMm+VULGzP7LBpcNE9i8SS7DD95uPMbrFL0pAffsGuDlbPttB7FKku71PA58DDO1Yu
	 i7RI3NoDzZCR1qyQFrApodGlIG2qDgUQTCDwHeQGOU0+WrAi9YWLgKl2TtWQ2wqb4ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
	b=VVijYjhqu9NPJjPSQJe59ytDDU9NBbMGsvK0kyzrE5HZJYTgJeRdcuo7FODjnsPuXHfd
	 tJBh/D3p4OKb0PfXbcKFM4rZUjCOeVJyktdgUSnrMHJX7Z+PyH5E15wSnVwTFMaTwJH6M
	 3EXVME9TJL7xZTkiOEiXX7rAG3DachnwPAUcK7bMwKjK2YYk5l1zWeVZTFUdDxqz5ZXUI
	 ZkRVBQ7rNEweIhMybaBTspYV6cR/QTd1R/cJx4vWLJOJrXdHmdxsgZyBtCQ1HtcPWWMNU
	 ZLr+E6Cy/9X4pu428EBBntxYmXV/LAuVXqW0A4aGL2dXqzL1Vsc3/dxMkQ8h5PG1AeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ot6Gds7T;
	arc=fail smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9B606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B9B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ot6Gds7T
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2eb5251724bso3056075ad.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793562110; cv=none;
        d=google.com; s=arc-20260327;
        b=I875eknVaHy5R+TVTG9J60fjnuztHRoy0lJ90VJ2h/RRQcQ9idTDPPYYqY29YgpdGE
         9NFPhCNdPagKOslp31UnVGOCGCspYeNRt+2optvUhzWz/p7ohARG75pd3H3Iq0Np8jGM
         AYuCBioNUdQb4TL2Gv596dmyyP0KmEdUx8DOKd8IVIoNQkijpg+SQbY4xS6PjqHSNtEi
         Eo+zs5p+qbomwmFQzk4cNPKoKuoy/HqsUHYMnZdulKTnkL7/tmBLCAIClA7f++4Ab28M
         B4ZP+0sMaH2CkU8gDG+HAgPMB4C0M+AqP/9B6pPjqUj1c2JYWGMufbwHCHNc66V1a2/D
         Yzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
        fh=C8Xn/1A/PquGXaZoAK527RxollMD1jpwI92wABqB5F4=;
        b=sPdH+79tU0CwP+WSSgpDbV6SMQA1Qq35HVRUBcyVsL3NwwBzwKahJqJwGfeAISuIx8
         roxDxA0I/ZZCkNq6btrMKeaRHyrKpw/dpYWt2lL5384q0jnNDUXynThkJFltAXjkeJQl
         hw0a6zaQhqpVeSRKlAhqooSqsVUfdYhWrhsAzkl3hnMyAG51SPWSxR/V+H/NkIqrPzhz
         xWBHspO+fnqzwXlMXV1cSwqoaPFXhv/GxU5HxWyf1QgXFeABWdLZF/orprxTlW3zxpfW
         jz3RMHXs8mISHcj9SQWzoGbnppT3g7nC5i9aitKIyB1ou+jAcbN+iN2bM2B2mVNGqIra
         iOkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793562110; x=1794166910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
        b=Ot6Gds7T+5UmsDwVVpntlzClSyWM0aKqpK4RXwbAj+elqcztjTX1ABwoES4t4j6tsF
         PcG1/jCUFX8ULqCgxwPOFB53mEIr4k3pNMBPt8A5jJUhhznD3mrn/7zk+8BgjJncKDuW
         cEXCVwQb4QyqL9MPsd7ovyb+EzQbUePlM1RD/78aWInie7KEY/310H54plu42QP8Jtme
         mNuUAip/djVFfwy0upN5ObbPCJ4pE1E1ksL5cDXnwcIH2JUnVt7o8HeUY2CZyGAywaoM
         yPeCxohuqbzK81O1LcmigXaqDAvbEcSkm8nTiRJ3b9CVQRg2JX/nWHcnfqtydoz/ai6a
         X75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793562110; x=1794166910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JA3jX3tndrIW4yCSFoQPJFyHa7m1TQaR2efx9QzdHgU=;
        b=BClvrCaHsb74BKnRVzUUPOOtcpzC8gpF9tlPFsjZoHcC+xw9UazSZuMiLMURnYLG2g
         iQrIgTkt184p71MOFWo4TF+cTE+LoUqhRSC7X+j5SIjTftBVe/oJCsTWDYyH3avV6bUK
         Wi+Tpr6MJ0IFrcQmVKB3XKJr1BwmzCVD9FI1ccPQDSAPehRvYhipu1pn6xVXfQ8Oh0Wk
         NgEeKpV5u85tNMIWlpGQqcAyMs4dBkzxzj3yCrWy3jXabs3u2/rNT1xCoOzO9YOUCkFo
         NiOkoK8fxL8j7WFt4IR3E21eYfU2MQ0YuJBBRjJqHNwa2yDguJ1TmGIpM1n1JRm2q7Ln
         7vag==
X-Forwarded-Encrypted: i=1; AKwUvBw4j+Kq6Pg+cMSO3ZkGRx1GVpb4qKgCLsLU6x+HE1Us9mUzRV5RJoU5FlWARhFR5fldy605ldM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rVlrCDn30dPukgUld6aXeA0cwH1OUpS2CRZMMz8E4Y5wL+D+W
	n2fkYWpX8KUvKYUCzPAcCJRWNDdr0ysx8jAJ+/aVKrq9Joi17/WMelA/ADq6BbaQZu3N5urt8wv
	x2kfbmv3XBLJlHYEhEyF4BZkJCEcCPYDZ
X-Gm-Gg: AYBFou3qEPgXpJYYOHrEoNIJg4/4syMLXq6TnV8OeblX/rHiinqBEs4aPtYy2qtrNox
	pqb9FbQXkWOY0pP8cLD9l/XaK4uKXjKdR8cUYDCZSpzlX94q0IfH6PxQ603URPDcjESB5yzPahc
	gd7ln1RElDEmwMC47n52nb4+93pQylW2Xa44qi+UILLYEE/505vxf3aj3982Zw4hNCekfofnCg6
	lKG8Ndw1h46rqWwxlFWgkV62fL1uvdy8Q9nPoe6c1MLihAUa5QV63yBD7JEZmiNwmQM/hlHxFoL
	9fgKiPoCKGfzZUIJtd9NJkh7rQob89TqnREyBWcuXCJWRptck37majX04Wd9c1kyoQ8DROg5Z86
	BK1xVHAy1zUe7rMIixKENg6a85zbJGy4CDq1T+7+xeRIXWK6dEib9umJs6/W+YsER4iN27A==
X-Received: by 2002:a17:902:ecc3:b0:2e9:814c:dccb with SMTP id
 d9443c01a7336-2eb36520f1amr79989415ad.69.1793562109749; Sun, 01 Nov 2026
 11:41:49 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com> <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com>
In-Reply-To: <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Sun, 1 Nov 2026 19:41:38 +0000
X-Gm-Features: AclHuK-312lSJcqm_yH_edcVqM-T-ygyAdVyAurMKANlnKwC0cEWpz-W8iElwLU
Message-ID: <CALjTZvbPacWO+NY62fbFdQEAJemD57zmhdYy+v+BXpxFgntcNw@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason,


On Sun, 1 Nov 2026 at 05:48, Jason Xing <kerneljasonxing@gmail.com> wrote:
>
[snipped]
>
> The blamed patch seems correct, so I think you need to root cause it
> instead of adding a global dependency here.

I'm sorry, perhaps I misunderstood, but *I* need to root cause it? I
never claimed to fully understand the implications of the patch I
sent, nor the intricacies of the tg3 driver. What I *do* understand is
that a supposed "fix" from Broadcom has left the Ethernet controller
on my late 2012 Mac Mini inoperable since the 24th November 2024, when
absolutely nothing changed in my kconfig. That is, by definition, a
regression. I'm entirely available for testing any patches people send
my way, if whoever fully understands the driver and the hardware is
unable to reproduce the issue. However, asking the user to fix a
problem created by a patch from the hardware manufacturer is=E2=80=A6 an
interesting approach, at best.


Kind regards,

Rui Salvaterra.
