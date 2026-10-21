Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620440;
	b=lZPGG3hq7VR9UWeN/g7vKUCUNzryFpNny9oyrgTRME4E//UwaCrzYfA7YD81Ff6Zpamd
	 HeNOBGtcUph7X+lIFqIGBqrla2jfs/vvA/HGKTV8ps0TR2gUHy38LCkAP/2lVEoY/o2PY
	 IldEBJGKPLaziWvYVYb9BhLmTKCwlAACErtRup+8q1Zk2/tIy4tWFmytE5HRWXMZf+dsZ
	 YYCcGYpg+uVD+jTeS7DkNuNT5s051K7f7TGa/iudAiK94oaHw0QmTIO95ySQjrOckumuS
	 9Q3OHJubZdWzEDl1cuowsr6knH3+q8XZo+smoQJ018MG2kskG6jfwzREHt+Fm/ANwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=C0u0/9pvcVlcUIo5ZldC4VZN02KqtRcVCReP8bcjUq8=;
	b=S5J4O/TszhQwUU2CwxvTzojgrsdDzoZzkrEiC5w/MpfUbWBBKBSHkMUqhUb21SpM9p5/
	 ZfuwRdw1gGT29YpS/iYiCHr3iUBxf1DDkWjrcpMTukKwkC15OghIj/grThIazrBAkbijs
	 kf34NHRGRYuPCKoRiHbhIBpm01JXrmAi7wtSUhsYo+1ZR6BLSu7Ga3jc3BWHWLVnxjvxa
	 CuKsHGelXaBpaB2Rxnas/ppGh0n/clrQbnzIpG5/zaJ5YwtM/DLK6q65D3R5gEiwLd45e
	 8Tzuuh5O0bVoZrsKebqwuVi1Cshk6vf4w23bduMosv6dQNQTHn9PR9plO1oxKR83nxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iRad8MFx;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DC606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iRad8MFx
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93efc0452b5so96209985a.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620439; x=1793225239; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C0u0/9pvcVlcUIo5ZldC4VZN02KqtRcVCReP8bcjUq8=;
        b=iRad8MFxVjg0EAUy3IIiedM4z5AaJ0KF+bdAh23ReapVskGy6lW8MF+8yIfjjSS0aF
         fayr/nVOBitMBPlohzM56OTCfr1jcAlH72nrGtZEOWzPF4S9pTeI9bblaGjDiE6HVvM7
         9KrjlHfA3hIAl0jkKI8I4l9JU18y8pq7Du8iaIACRFZwWfAtpvglpzG7EDMaWkjeFusy
         /jvE0eCF1+6aF02vzsK6q34Q51QnAIw4+PLbW5jnCcAGE02CC8DAdk4qP5vFveQhCi4Z
         mBaRmKM8JAvYRBQ/23tww+CP7wbZgleUhJ1mokp5nS4vE4kYnVPOCn9/UCN1PuZLkOgy
         aczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620439; x=1793225239;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0u0/9pvcVlcUIo5ZldC4VZN02KqtRcVCReP8bcjUq8=;
        b=QOI01+97QkLSoC4RBQilIM5AJs3xlimL5jTUeZP5B2PNBN9/MYdzUly7KxhO4hFeXE
         XLmLidlqoyYQFbqTn5xLUNE5bnDvKluIEiP+9yLEwLxTg48DAIwlbTP79rw3PYnBFvwZ
         pQxEvMvBx4X79z4pB39OS1yF1RcDvE+MqUKGvkb4Ai6vSp8RDCRizhx1i116HLq6ORJe
         4vHPeq4FvQri/ho4nu4NznYxRQ+nFTEARlFDkSlVJPegdKDxdbB4BEu3nTdhWHSKVCt7
         remHwsCTmV45MTsmOYKOuikR/zwXUbl4IHYyoG4YqgZEWeyR3XI9gmjvp24UZjXrI/AP
         HZww==
X-Forwarded-Encrypted: i=1; AKwUvBwT/k/UOsScAdZ1Phv0DQp8YgaHQMB8FDDLgWJh82VSJqNwatV2hLnzheBZcnwoE1aNJOXOhiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqaC1PEVrc4tzh4uEftUNErzhxxdoa16uEzkQ74Q94dvY4j1mO
	vR4PFjHR84v+HlFIE90j8uFUoD4307oziCrnQPIfgzXhD8QIDrKTPghU
X-Gm-Gg: AYBFou0idYzZYDKi2o9Q1wWNWNMvtYtl3ULqC5HBdjSWtVbO3hBNcUIwaeIhni/IS3R
	3GENRL7aU1hWL+mASZvkjnmy6+lt9TB+BqzaUOxxd854ZYQgq5SPOtSGgfOUyuvwfvV/+JY4U7p
	C5Gpe7KT+uMMW+h79AL9sHyW2lSdSr19h4hpva6z8rje/gaDOLBuqUgflHiYhHt1kPILi62sr29
	Ze/782xbTvLubwbFq74RE2GlLzyCteliWip2cyCcyULXQ15V8QsjV9ZgGk+4T8tEXwtjZEmNhgj
	GSaeynCl7fENbSzzFRc2Dse8C7nchHmdpIIPyPXHw7yaCAZBUfGc5xOda+8xkxNCLtxI3q+CeI5
	pC02/I+fnOeNoDRAB4d5YBrdDi66YAoIvj1mv+5iGjaA1UWs/WjPLC1Jr7G5WZq9IAm2sbr7rFT
	SUfyO7Q/hPwKjMyoCrCsO5M4qk2wWvTpKAYSygMdkNLjHjSYvsHvTQg1wehdoznuNQujAwThRWR
	Jzs1G/o0TpJawfV8tQEb3FJJstn1toblSuwNxCItgvNkq9kbM/QOH0IvYIAkA==
X-Received: by 2002:a05:620a:3188:b0:93c:68f0:f09b with SMTP id af79cd13be357-93f57ebdd17mr685263985a.5.1792620439473;
        Wed, 21 Oct 2026 15:07:19 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c6f16dsm365188585a.4.2026.10.21.15.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:07:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 18:07:14 -0400
Message-Id: <DMAUWQVPIVKP.1QAK1YSA76EHJ@gmail.com>
Cc: "Daniel Zahka" <daniel.zahka@gmail.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>, "Rahul Rameshbabu" <rrameshbabu@nvidia.com>, "Raed
 Salem" <raeds@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 0/2] psp: drop packets with extension headers in
 transport mode
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261021210200.788191-1-toddfreed@meta.com>
In-Reply-To: <20261021210200.788191-1-toddfreed@meta.com>

On Wed Oct 21, 2026 at 5:01 PM EDT, Todd Freed wrote:
> While working on adding support for socket-less psp associations, I
> noticed that this case was not being handled correctly. It will be more
> relevant with that series, because it adds udp support, for which the
> psp nexthdr will be taken from the inner packet.
>
> Since the tx association encodes intent to send encrypted packets, but
> because of other configuration (socket options, routes) the packets are
> sent unencrypted, sending this change as a fix.
>
> The first patch drops the packets, the second patch adds selftests for
> that case.
>

Why not just fix psp_dev_encapsulate() to put the psp headers in the
right position? With the self test we are going to make PSP + ipv6 ext
header =3D=3D drop part of the uapi?

> Todd Freed (2):
>   psp: drop transport mode packets with extension headers
>   selftests: drv-net: psp: test ipv6 tcp socket with extension headers
>
>  net/psp/psp_main.c                         |   7 +-
>  tools/testing/selftests/drivers/net/config |   1 +
>  tools/testing/selftests/drivers/net/psp.py | 120 ++++++++++++++++++++-
>  3 files changed, 125 insertions(+), 3 deletions(-)

