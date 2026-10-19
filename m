Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426272;
	b=Z7rKbw5cKUENcGdxSJ+7eMkCVIBa1A7SsNCKGGX5BHVkX/yFS4Uw/0euxMhiDbr9888i
	 y8mWCsL31Ib2OJRbVPl8Grvwiz9KAU6+R919epWo3Bn9xsM55rd614fV8iFF+4EF+IiSs
	 ogpDSp37Dd2FnxglIHJYCyzbWP0QIV3s0OrmoHzqO41Ax1BXZbooVglPpTlyF8e7ZLeFU
	 qbXW/k1T+zKiW8KmYZTnfDXZzy/CEQZ+vqo75xs8Og+RQNflR39arUgaTzSOhOEvSSb7D
	 CHnZKI5WwAnLgB35Hh91Ju0Ye/+1u2su8IjQYOqgmELD5vsqWVBmbKyFz+MFzeiaYxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
	b=z8/RpaF7fBSc0TERIwTmtjaMQvg5lKMVX1B3dA7lwi2NVj39swAVSDZmYTRwH6Qdta3V
	 V6YRzZV3yVoB4ql1zGN0p1V5uZakkje9rFTxA8IvOdqqKPQ2ip9Y6rpEja1apwZwOWqpr
	 G8ur/VMkr+ne3uFx0RecK/w4aoFP9zrV8PifdVUQa3HHTbiEoLRy7ZYYEE3Jvy4xd4FgU
	 fnCmcRQ9Bsf7JAF9YRKRJDzsnbeJa5SjOmlggq2Mj0VRih8DH7KvCWMHEB1jJMbc8SJcz
	 IZPoSl14MKlD5aklv1NpyKasKhCDdaQowYRLkhFy6GlXrT3d1Ukh+AwrRQXXXOAtGqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tRx3K5jm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1A606DA78
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F1A606DA78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tRx3K5jm
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso16985a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426270; cv=none;
        d=google.com; s=arc-20260327;
        b=BCZRYfpOQoZ7tegwz458nEB2w1pHGN6nHR/ehBAVWCjvo04xifR7RnJRxOATD+Vk3+
         JBS/iwzKnNJfvB9AV75V1FrYQeDBnilbzkQvqTvNaHfZ7MuJQiWyy4ATPMUdfqklzWHo
         zAcMDXyHafJH9fdZcIJYgU4h0tMWqV3l6pBogp5ls36zyuV1dRLrWnDPpQQRFUbV/VaR
         39ahLUOGQ9WUMTyhZp5kSh8/uqia1VNAvajRg9P/FbNrYWMd7GBIVhuirAt8A41SZea7
         U59W98sFEr0QT6iT+7W08n3Myp4S4i4sIGC6SAhHAaHqm5tX/BRQDkj1a5OWH80/SS9H
         qAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
        fh=YRhe3EoSO8PJ3dTZRAmO/c0dIQH/1mxUBjLt1CP9shE=;
        b=FSQJj4eTWhNoLuyURddaUtiwkCusC5Mik6zs2Ppf8BLgJYF7qLMz9RyH2vudQQxh8l
         YRdpM+HL/OjnV2H+mTFw2ixHwqwEKVd3L4D4BTtWxz+V9ndxSIgZbLY+TAJEks1MJyj7
         Ocy92wDwZiqqRxX2XLiZk90mz73qA+Smi6SpbbgFSPyGiJa09e5frkvG0QFGe+G44ITC
         fo+Lz/bghtTirNyhWAnVmlnRAXrRPEhzBgREhjrBg8jvHHH9Sw+BIuqr+pEzy+8IFWWS
         ETaPVv8O4lv7A1DQpjHbQOiXyD0+ih7kuKzol8B1pGkcV3x39CT9v25RtAPU3OdOm84b
         EC2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792426270; x=1793031070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
        b=tRx3K5jmcY33uFjjLhBl+j7aQChswPzQ8jc6vt21o8gL5HebhBkZhq0m4V5VQXj8Os
         Vxy55uyFlopl85UWtcuhSyXPeS8T5aUmHQFtnKEsZz7CPNXCpLO6jJgwUUnFOIl2yUFB
         91ziLFkt7j059F2wIJiIWCft3lgYJiZpl7D3tjbGSsU8jErVrD+G6+TLwtfY72Fl1BRp
         +udUczkN4A9EVjpSES388lV7wjosc45EmCjnJY0x3QPYLgzoDNHjM4jwwdIDS0kg07RL
         YnqkBmDIKaVV6xViHZm/RbvKeMlM1D1RnEkQXEC8kGdWmFWv98zxVzqcc+Q+Y0hzQQtm
         mbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426270; x=1793031070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pr7BJMuifE78YwYx6pJZlEAPKb8dBOcE7CtzncpVA88=;
        b=Datv2obGd8M+7rtbFej9AnLVAxISaPffzj/Cv98urPr6jojAqQJ7lF/HYbIaLP++nz
         2axwLSc8UZMk55DGGxsoTqVJ4UM9UzIidBGCYIL8eynA92YueK6O9ZgEoVj3LyIZ0Nx9
         Z3EyuUpsc6SXA3KCxvL6OVBzk3tCfgj8RZOhJxGc5NjvUuHQIYDVxpuR8KYixpqbdDrN
         a5aM/Ap3+/Y8PssgysqnjZ5Zd8D5T6lwLigZHusgVkG+lGFf+eQEuJ+QOuk7xUn1GYeZ
         MGV0uw+Mifwix4aOnBXcPdShw0frcm35kPO9DHAZDXVf6HXQmLF3u07WGjd/59z9ONsp
         9lOA==
X-Forwarded-Encrypted: i=1; AKwUvBzDXbK8JwtZAreEogqDBe//QnD899WlKm81Y6RLeQZo8/YZ3OnLbbvz/qDG2ZvTqbwEa65WI2g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLL69ac9OBymK8ko6BpkWOU/3jG/AmHgH4oHc5wN5uZcW0KSOhc
	kQJfPm3WFOVCQxM9EIRuYh7pTYpC4jmgk8AFTEX53Kbr7EzufkSMHllhwALfln6HEIg4kJ5d4p5
	GqhYHGGXMPs8ZDsUhsWfAsveSxqY/IUMKfFWuuAMZ
X-Gm-Gg: AYBFou2CJGFST/0pl38VXohLmlvtl31eVf7JE7RqizPldKWN1qbqzeZoK0VJyJ1Sy6y
	TspmS0Id6mIZqUJa6kJiYk44ZISwECAMqr/rxJR+yjQQVTC5slJaxFNsob1BpKswEtTv7tvTZgl
	w+JpvVjKc3D/qAqcokqNELdrqcbhGZkAv8HNh55ZHzopW32pKiboaKA+2XN9yd9mJC1k5CcBSuu
	sGRPGho6712aFmvvX1sP+6yBLLkJpX2XQgKCq4HoSja4u5lJKkH3wkpDnYoCsTX4jv2x5LRZgo4
	f/iuqgCugFj8JJoTAUED52mGsQvkQLQ9ljFlDb0fklp6D51sGSRS/GyJrNrCzus/IHiN12A3gPH
	SXhIarWHGgw==
X-Received: by 2002:aa7:d3c1:0:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b3ad90b655mr92225a12.9.1792426269498; Mon, 19 Oct 2026
 09:11:09 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015163915.1166043-4-almasrymina@google.com> <179233927086.3135.6123492094489915156@kernel.org>
In-Reply-To: <179233927086.3135.6123492094489915156@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 09:10:57 -0700
X-Gm-Features: AclHuK8eiPagoVp9rRWfufPEyCEaXmjBdb7vS7t1VxUSJn80p85wHIDPJ3eEP2Y
Message-ID: <CAHS8izPobFzob0pF2cLqL+nqtJVL-TC50QuDHOem9_cwJoGSxA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	ap420073@gmail.com, pabeni@redhat.com, kaiyuanz@google.com, 
	bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, shuah@kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dtatulea@nvidia.com, razor@blackwall.org, 
	daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 9:01=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] On builds where PP_DMA_INDEX_BITS is 0, this patch leads to a
>   use-after-free of the netdevsim bus device.
>

Bro this is a pre-existing issue I think. My local sashiko also caught
this but it has to do with us not doing a get_dev or something when
PP_DMA_INDEX_BITS is 0. That's a very rare condition and unrelated to
this patch series I think.

--=20
Thanks,
Mina
