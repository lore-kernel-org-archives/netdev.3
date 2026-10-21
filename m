Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792615085;
	b=vBoCQJJPwKUxfLgjo8AaXT1C9EBx6nIW05ivJGHUvN6rUA+kWFHAtdYtCSl1q+0Jtd0M
	 MFt6EXeWr+qCW517nCNg4CAPJJ0ijGkUlopOTM2KD1h/kBs8vg1x0ToaVph5uqYiTFPKx
	 xdqG/hqhPKrpCtIXuLYDdP5GTfyZQ6agm99w6ScBvdVqFl6X3Ki+uKiA4oSzEKufKbsvg
	 lgtdh6dTK4Uf1VcQs0/7vZVYlxaaJhBitTN2v9my7phBdFd75zhXe9AiZmfRYLd+cmzmr
	 /8rhRTZ91bbYvFPNJdYEhX1ajCfgaRGxuXIFzDthioToo03X4lVAle5jjXNFsQ5YS1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Sm/ucVIs/IML1ifexi9A6kIUGzt7C9TWX0mG8agamnA=;
	b=Kcgibq2NQV1Z8VzcHLR3pUc35mUQDhmrvhmfJdK8RJj2o8dC5h4+FdNtF2vKhxq9Rj++
	 ndQr/jnQd7RsdXRd0PXqGvNO6+hK4vAdBE5IXxN7wzqG6tvj5u9xFV9qrrjz7WzkfgnhM
	 2RLrRegPsPlbtbKFHYizq6oMm24EVgfu3b3aAFkFNfanuRU64KrDbH401OnvLTOK0efCy
	 DW6lgufALu9HPFMEY65UHQrm3iVfxhWjBob3us0C0xrAqJwNIhoOv/LLvtNw+uuCBlCH2
	 ZbRGIKaZxyco9hlaF6vnLlB0RdDZV3kAZbgOGWg93nW8m0uN8RBQhBaMdHdaJcWyyZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=P9B7WV3t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C0606A325
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 173C0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=P9B7WV3t
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so510251241.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615084; cv=none;
        d=google.com; s=arc-20260327;
        b=WMOxA5CYy5uLx020KLeBIDGoAKN0NVbAMH8GdgMyRpgejnFG1Kk2AcX+rW3Tme/dCF
         usDLFnAoeUS+na7yWlulrigbtsQ/gWcnb8/kFIKe8GVJOofJPLihx/Hf3/TpNe5jaxG/
         3kYZTDp3//cs/qFen/DV4+IwPTH3YPtsPl61RGQahoqO0yIegwy8mb9PwGRu2xvKEm9P
         lt+c3mKtHSwPNP+0tFzklfYFgwM+bnejOo442g770kcEUx7iUr9eMUiDBFQz5ZCGiAvw
         gcomL7hT6tp18bxE3wme3l/ssaHkzYqIDnjrk7xYtcOs4ffcTyho1heJsoXoq+hi5dEo
         hw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sm/ucVIs/IML1ifexi9A6kIUGzt7C9TWX0mG8agamnA=;
        fh=f9JsrBKiTYeDBnGUve0TAmnKI3B+V3mBPzwjxB9qazk=;
        b=GQSqRQzdnllH8vihIR9VxjvvXAXTL7hRRfEsB8whdIyHqY8GGW2nvcMBp2tKSz8K2A
         yxsPeimyoV0vlyB+jSqNor6o39mvhxnUJpWeC+lIEmSKpMu4FJXytKY+4a0Ysw55SNdM
         PG7A76y1rppOFgnw+1nAjVS0eOPqRjIpQSjgezh7JTjYGtYlLcf3KZHWwmjcj/Ncxb0H
         lmqBX1kYywLDGajjyLJxUvhdh5voO7/0qcjwON789GGHNyoA0fXw9dcI3Wa0ckigE1Gy
         P3pwaA/O58LzN+3QhRukBOTBcgrUP+1BsCwGCuhYUFrtTQpcjQq1D1+B+0FdLxqG5rTk
         1CNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792615084; x=1793219884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sm/ucVIs/IML1ifexi9A6kIUGzt7C9TWX0mG8agamnA=;
        b=P9B7WV3tW+qvrq5niXivgO31cu4Owz6HdP3qvP+Iwr/St9Zhpihd1UVKv+q2HbFj1o
         2KWmaSXK0QaAHoNdAwIIRsPz4An2G9/nDSg2IlVf5cQZAmw7TfFudNyeJNrf6CtXqC7B
         Kr0JszlArIOVBLh844PiJshSg6I+azbo6+0CuT9pAbeb6+KWyCsGhbAhGhXRi3AiGtYZ
         bQzc5pHMLExJ6B4wz+rEIoOOdAmR15HAlt+ng57ZsbQPn1iNOX5QlzfOIYJwhR+v0ojU
         7sGH1pIpj1N+7+iJhZOY+cwnIDbFU/ImANQcJyfrv5tfuEQJ6KOHc7LithudHDZayozG
         7AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615084; x=1793219884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sm/ucVIs/IML1ifexi9A6kIUGzt7C9TWX0mG8agamnA=;
        b=j0MlYc3fhYy8wE8qOyi3HUo9Yt/g4fWzrMilsImbW7kP/j6JUoNyoZYV0CVLZvJmWX
         k+O7XtNTfEJH91Meoo37yAlIbMb/t3zApp/whWgog1VjP7kJKBevbPcC+Y7GKZJSl/kU
         K2K23GO+5+/hB7J4OIjqnrQ+rZsh19yI12rI11uMR1bJfdLuds9DkrzPhLsgonLJUu2k
         cJA1a8b9gjNlyk7BtL5sZ/t/7J+7ORFAG3rRw68C7VOPPe5n4BbPrDXi905uI2Dqb7Dd
         B9pv4aJFVnK4IHeQJUltiM74gamjXeWtHyMvziC2JPTB362dyYwsDop6hmDDxU0SCemC
         BgEg==
X-Gm-Message-State: AFq9FYLc0VJX+Piure8bqZBZUa1q6/4amPrxofMuu4hSP/N8OSlBLs07
	i0m5BYNJ8YyDJsmKA4OV08RRiroM5Dc7J7bZxXU6GRavvLQcb76PjIBvCfhV9Lno+eiVLUOGHQO
	SD8c0vJlLawPjEWhhfw59KK9xltsZBJlpU5d8fTtJkw==
X-Gm-Gg: AYBFou2qqjBDK8zeRZXan5MtxwP5DVGpgWNjW4YRAYGzHOj69Jgz++7ytmSzWhQzRlB
	2Xr5G9FuuSKIKCZT7d/SpzrIZZ6Ekycv8u51slicma83cTmEVCLvNZPOib7hX+Bz+UdCPlQx4Av
	0LTWiMx3FpseAcF49UO9kC9D5rsunHIO6nw6EB32VJz5XIqLnJMA8gTDSVDptrurPE52fDZhPOv
	Tfxr7GdDByQOFJK+xWPhPlvWJj5trzvYo/+KpoQQy7vpEp0udZakc/+XHZwPhgYTbnaZa4LQRQn
	G1s8fdlB3jY7wlDOtQbcZ6nAwpXAI0KcPia6amjJ2eYGxecClluJu7WtNjfX2czphxQ/QCwgNwv
	eUJKu6TvPabmB5Il1dLX/Yje5VClDuFSOHMHE0GHqLUNpz4bS6uVjcXrNR69sieWSmTncA/YIn6
	ZnaF5Y0SmHKaaVGIb5du/aqM9LjbX5ZOJltS3jOpm85v+U+zxqaI4WyJ9Gm+qyxvFLIvl2V8u8y
	AbbNMLrsqWyAz/C+6CQd3B4lA==
X-Received: by 2002:a05:6102:850f:20b0:7cc:3eb0:6ea0 with SMTP id
 ada2fe7eead31-7cc93ac38e4mr702006137.22.1792615083930; Wed, 21 Oct 2026
 13:38:03 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020214500.972308-1-rjethwani@purestorage.com> <179253294887.3290.487147499123330924@kernel.org>
In-Reply-To: <179253294887.3290.487147499123330924@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 21 Oct 2026 13:37:52 -0700
X-Gm-Features: AclHuK-ZhRkgIdv5yYGGMnFPJ0d_TUAMLJF9EVSU41qM5LLHoLsovdDN6fqrV4g
Message-ID: <CAKaoeS3iWOm6Oy7V9VZChyQuOBYB33EzbQLgt50E3jj-tMzCbQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tls: keep TX and RX hardware offload on the same device
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Boris Pismenny <borisp@mellanox.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:49=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

This issue was discovered during code review and subsequently
reproduced on hardware using mlx5 and TLS 1.2 AES-GCM-128.

Changing the route between TX and RX setup installed the second
direction on a different device. Driver traces showed successful adds
on both devices, but both deletes at socket close targeted the first
device, leaving an orphaned context on the second. Both setup orders
reproduced the leak, even though all current core TLS context counters
returned to zero. No crash was observed.

With the fix, the same tests correctly fall back to software for the
second direction and leave no orphaned hardware context.
