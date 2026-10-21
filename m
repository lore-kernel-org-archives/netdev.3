Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563469;
	b=O0DIX2x+7D3L9iZ/A5JgU9YRB4JG21vOOsI8whZmLsOD+gDdCLzAEkkeFJlbOhqbONTb
	 n9r46LE3dz2kHP/7g12vvYE9PQvrECiVaFToJFI7VHEwHFTRyXbjtwIflbS0PotZz1CZ/
	 O6EMSC5ToC6VTiz54L1UquNnYLm+5DLo24Y62MIHuvVlOYQkfYhhYZ/yLbkG4z3JeqggO
	 DpEpsPDW5NOGSUpNc7tA0B56vpPTc9fmUjg0KNCvnY41gjyT0kIvY1Xn1KBFbygkplrYk
	 vPDptZ0wy5R9asGYk7aTBB47CTZA8cEjMQFPejEGqhGGKQDo2Unwx2sD+xiM4yLTseA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
	b=fM9x7wyjM4IxEjGCPcP8kIHQtENU0pT3cal+mSuXtwAy2fMFN7ECDX1u92z8udmO7YrA
	 6TAaBaHnUTvGFHuofgxkZZRzIetBvC8kRzGPyo7wfOeb2Ex4dVi0hFc+o/+5yR70ZzmZi
	 zrl7BhQflry7WX6Pmmyj1CJASlHO3qzRvP9LxO0oCNlKAOFAN4XxZvY57BsIXFDrKHd5A
	 DB6FKDk/cM+XZMxN3rGHehtXNHOc/NUuk7eGjbGKXwBFtUC0Yp80KUm1sJRBK68Vft0WK
	 poZsQ7Y3qMB1A3ZQxtiKRXFoGeDz2cixbm2zNWtVSeLUa4OU3x37FaWSNEgF4V/2nPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pQIPJhuw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226F606A338
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F226F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pQIPJhuw
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso5206a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792563467; cv=none;
        d=google.com; s=arc-20260327;
        b=UReRn+TNdlOObDTSnbLioNUt0NgRC3JR8/v4ewU6UdwE0wghCn+HxWWyX7xUBBL3Wf
         vT8uFocSf/EJWHWer21Sr9VzWb7q1TpAfV4ySYmSZ9e/KOFwkU2cnDvCJoBLCcH5PWE9
         iQoJbeuKP07vg3jXAHJ7guL1SNWKu2W/si2gSEMHt1OwnD3YTlHkqOhFyHMDM6zyEliV
         VGomwdQFZNbuWVu8eKMl8rP/iVWgusj2rSPaOFBdBixqYAiwcE/vSuEpFEAHtGx/72uI
         3GxdR9zKBBAVGOT8DFCTiI3EZm2vmPX6v6BcVS3wDUDeMH6Lc8zvsN6bzBMuARBu/1U1
         J65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
        fh=dT/3GQXqOsLE6zZwo9O2v+xHWcY/o7RT40lYyluSib8=;
        b=c9syw/OThgfoZx2C5abE1AfjotK1Rx7kHxGhT0XAU7Yv36P3fprr681qfdpB8MAVcj
         vLUJs2i6RC6Ev0VVbPSjAoQddU79eqrUX78Msxmo/Q0Vn+jOAQpSlSLZMFqMIuUdoM/7
         tGOSbJ6leS180ZFjsN7POX6BKvFv+LvFFSVoCs5iDwPr6Z27vmRH8kjoq47xvwPkqfAL
         Ung+mcR3in8C7TE6GLOnVh0DPj/z/kMNymhL4z9pSa8U0RKigb/IdXOGh8t7AmI259g5
         JUK1/Zl3RPVYWlahNS6nNY8PInHqixY/3FzPRVJ2d9dTS2E2abPjqHciaHQM0zz/iRIl
         ntoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792563467; x=1793168267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
        b=pQIPJhuwRgwitqjGA3ItWVLOGRQSBJ2UxZPYrPAWnSbOgQb7bum+xLkiJsThMZqhOH
         dwhP0Tb7gfDJbRLLmYO0L58nN/lbc0ijCbj7vD9/AsO9AN+96fT1k2yklolZXbSXuPwo
         LvDI+a8olKugTFENbi6HjsCC3zDMl6Iz1h6NBkZRClcTcPd8ggh/X4oK3qTp3lqZ6g+A
         1/vCcb7V+C3SGzXl2pN5Qza6vN7p6/inIC4foXEFviRK7uLerabWIo3jtiqgZBXKVU0E
         35IRXsTcGT6NK/j4Qt7Yug3jaRtwJPct+J6CNc9iCK/DHqCogYkMU/l3zqzSbvR0IHLw
         KzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792563467; x=1793168267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OpMUSfXjYdpw9tHtxpMBZ2ptmbz/1TA55D+obf0dVY0=;
        b=YIB/pMKo3nrWTE2zE2wGoJWuJQW/sVywfJk8xxUtDduxT76PRyxAOF2on9T9oz3CTT
         nZgvK9Iw3Mhv6kIM2u2cSZLtgRrCz3j9RxckEGIYn1b41fAFO5M+/2tArSHa5zWTGcMz
         GR75geob1ItxrIpzScVBWWTYbUhwVSbnlSwj02nFaAZsDj/nvBSLRNYiY0nkUQCeyS85
         GPt0+oJcOBYkn3GSvrjrruXlQlPdBtd8mDVt9J40gfzG683g5uLd1+9Rr4Hj1qNb7/zE
         huba15mJc9aKXd/5hIHEtmXMKtUxEEKRJ51ZVuXHMjHz/+TTeRRExpoDePsyNl09FyDM
         dGJw==
X-Forwarded-Encrypted: i=1; AKwUvByDUvXV63E5x8gwNReQP6qVFNtMe7XAJ8nMvn1JGy1pgaTzqxKraD7S3Q9oNbdZczwh9twKGks=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPQ4Mrkhu4Pyn4CQxzVsPq5Qs37N2ny5ilYQRy3BcD2dXH/0h3
	MbzJhHbV0TQwevS9mZf3tGmIKspW4q4DffYzHyBBPniPd5mos1KVCFQT2e4tk4NEMmnV/gICAhg
	Tkox91ydffI78UK6sIKlQSSzsZXC+l1WSzQYiqqRI
X-Gm-Gg: AYBFou1aqLlxkc0zxqwWb1wKAxZhNSDnfnt8fJ1ADlEivby9yDFwy5m4FGb+57xonMO
	grjxpFZL9r6f9hxGJm2Hlmb200j6FQ1UfYEJF4eZ6EJYBr2UyvIp1/VYGa1k/WTdj5VQ636tdK8
	QNE/QGb1N6IFPFBisKA4QddwkefAMhtJecmc/zbpCMNrdYmPXwseB1e6pOxlnlui4ZpxsadSodP
	bE7bCMYgCD/HDSexfSQuhEK0uoYAI0AtdSRVntZa7Y6vKywATKr8wumsP56PUp2uX3FoMl0+we+
	a7ZEX7EZRy4/VaN69qEmglEgP2ECCCXuCNzc1YgX5x/oDYMVHO5KF5sNsWCvSbaz6G6ruWjsWdb
	R5oylb17sqSSBXZQmixgdr57JHMoZoL488g==
X-Received: by 2002:a05:6402:4050:20b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b3e77153d8mr91222a12.12.1792563466679; Tue, 20 Oct 2026
 23:17:46 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com> <20261020121858.3b9107c5@kernel.org>
In-Reply-To: <20261020121858.3b9107c5@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 23:17:34 -0700
X-Gm-Features: AclHuK9x4qWdNnjJvUjsI2EHUcAIAKj09plc1NcLTKxrSfCtCSi6D5JlUi63xuU
Message-ID: <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 15 Oct 2026 16:39:14 +0000 Mina Almasry wrote:
> > Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
> > netdevsim net_device, and configure page_pool instances with
> > PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus PP_FLAG_DMA_MAP |
> > PP_FLAG_DMA_SYNC_DEV when CONFIG_HAS_DMA is set, so devmem bind-rx and
> > bind-tx netlink operations can be tested against netdevsim in software
> > selftests.
>
> Slightly worried this will bring a bunch of maintenance burden and
> "bugs" in netdevsim. IOW that this will be more pain than gain.

I felt the same way when I noticed many reported bugs against this
series because I didn't add proper support.

But on the other hand the test coverage is nice, and maybe one day if
we add enough devmem support in netdevsim we'll be able to fuzz the
data path or something. Is there a way to get the best of both worlds?
Like put a comment on top of netdevsim that this is test simulator
device and any missing functionality and/or bugs in it should be
medium criticality max or something? Or is it too much trouble and I
should drop the netdevsim support and tests?

--
Thanks,
Mina
