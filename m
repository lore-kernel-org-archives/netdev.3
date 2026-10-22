Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645273;
	b=p2AyAtwI5YX7F6uUFhWwJIlYnzq/7ferO0CoQjI+l3ZBMDnby3g8ko9eKAfgsTuRdn6Q
	 Pcskx6/11calOgAFypK6fNeNsqGClkyrPo1e+vmYULyvv22eQ6z6ulGvK+BL+a1nIVnYW
	 eMSVY+U+axP8GmsK2ReANbXJyPnN4o+EDxMIhxKOcz5ub9WHt7HD3mSH/CpsG0o/lkA/y
	 VUHT4M/EbActlBGX5woEBI8+yjVpZK/3/TxdVTtW17C3ieVs4eWUlQolUbrX0wT95ir9d
	 eQUg8vLspmENzOY1torFzV/sE4Fyhtztc6DhY7EShXz2LiqOx1wQeBQgAPsVT3z4QeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=JRNz4Z0YTve9TXUlcKdgeKzQtPhMmG2xuxSs8nFX8bo=;
	b=zrYNK2cVaSvTthOCIDT8zSgCyV94boGnoI6TfWBeKmYKumFXoezJpn6wSHSgKcSImEPF
	 ycdo8CCLsDb2qVXWvB4a2j/1plBF8k5NxJKxo5CFnxxB+ZlqCQhIcT20xYAHohMC6GTBV
	 +TR2x85MPo69t123rKJCluFEdCJWSC45gRdSojj2oy9C6q1tD1/zB0QGDN604hV1edlvp
	 QzMVRQPdmazZlvsoabVMWmYSBH5Fy9KGh2qmDqQ+rz+MU0aFVo5fQaxazJmzTSsmMYDkD
	 residtchjpsKm+o4GY3yxr+Fda5UDsBIeMOuUtHUUOItcjRBgrPxBmBqfv50pFsF1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TJL7z1yn;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4F606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F4F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TJL7z1yn
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1283120a91.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 22:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645272; x=1793250072; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JRNz4Z0YTve9TXUlcKdgeKzQtPhMmG2xuxSs8nFX8bo=;
        b=TJL7z1ynPVieI1JZg+gE/wubbyoYb7lZW3teGyPkqOGr7FXuVvgLzY65fxa1TOYamE
         yZQ+fYcXiQ30AnlLM2suSc8gctIuvAfuXiJUenMmYiCzIp+q5zGbNhlFn8qB3lNI6feO
         gbqPkJp5cnsDcF2i63nw1MKLBM2XJpymkL0kHEpSvIZbi/TAYkbaVBY97L2hp1gExV2Z
         VoJb/GzeW4l3EQ/YgWk+CYxsmg1qzYmOpgyfR1dZyMVEVVD7PUAonqKNXuaajo3LN8O1
         3ttnzDNTr+FZBeo7xV2L8aeVlEapkOx25R0fGid5K9NXvX2LIo/yWT7EGDqErVNrK5Wu
         V/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645272; x=1793250072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRNz4Z0YTve9TXUlcKdgeKzQtPhMmG2xuxSs8nFX8bo=;
        b=TmlyWHaIsUShWelfN/buawBTEx2wZTU2WO3GrczKu3W3KSfOTcqbDEl5Jn6AjZ5yOI
         ePbAcheSx4az1MghNe//3FQQXODteVz27o3+XyT3BkmzA++LT7my/JZc3sHExQYCiWoP
         6tDJ36L350HBlC9lXcdmSPBCfQ3EfI13hRlcSobONoSSrobNNxSXlg662jAbe2z94czJ
         0zeLPAuuUPNWFWrxo3pm0/Tlg3BC9/1Mm/R9IGghNQyFc/dRoGB+hph0Zf7RGkxFhv/s
         3XYWpV3EU3sAd1ZU5Z/wJplypRTCUcj16ydtX/T7zxhIDcYaNzOamGi5rmeki8S19b6O
         bw3w==
X-Forwarded-Encrypted: i=1; AKwUvBzHYKqyZzJJsY3UxoeU6BBLZPl8FQRzrtlUv44ugefiJwFp4XjcMoeA5PurWR5yyuHlTz/+Ryk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkigShx57/dNYnz9ambvYF55E+hSJ5fQOomb7QMvifarPqAwIU
	z4RiBB7YW70Fn9DYdJtXvnmgajawsndBiBdaYYrhRtfKbJMHKGOcWQcU
X-Gm-Gg: AYBFou22MCtVYbrLSrmkxwImO7p0hxtTjIRcqpOAxR9m2C0tPrLhUmSy7P/ilCOwi0u
	jX68lW4Nci3t6kYa3rIblC8OxZ8vUBgNVrmfzbpQtkfRC2X6h3iZJNQM1bXgld8LO8XrIKVZ9ip
	GXpdf7e+CYkLX7/iUvQdqUJ3tDRla6/hk3AKr/HLcbftHWxxctsX64GAx5srdFws+A5TlfZxsXv
	B6FMLaHziad+fSg6Gy4iDOQeht1KDeI1UA2hqtiGD1jjGvVkBbnPy1rRGz4p2M75qF/bImMsL46
	67X7sdWMp4Du2M8ZKfJcW/qCzT2aZ/rbuQXRXK6TxG66cSgZovXJn+Q5Wx+U5v9kEEfr7N5v9Ci
	efr4O43Uxh1qYDKUHtOklRWmWLXzh3fqDJcjZcGazSQHTJ5TjoGjhmpjc9tkZ6hMO5P/yckeXxJ
	U8VrWNX4E/43RI+d3L7r5WmIEXQxZIZKdcjVmEOcjbSDnbKGVyfs+eGd1cgHWKnk3V2dysC06zE
	17UC+XEag2qaQ5+xSpvs/J8E7oeSiF+urbB3xj98FS2ESBgZOG1V+Eig5+XFdUs9UeeCDhzA3pX
	9Oic8Vmk6y0yjztFDk8RrR70M017v2SJu9D6ulJwlc8DEd4+KsZoGZECJ2fqLGTvfEZHx8pWBwQ
	ULM/oJo7+FaImtOjM1gTa
X-Received: by 2002:a17:90b:5205:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3ad86cc1b3fmr3516475a91.0.1792645272096;
        Wed, 21 Oct 2026 22:01:12 -0700 (PDT)
Received: from smtpclient.apple (ec2-43-199-181-133.ap-east-1.compute.amazonaws.com. [43.199.181.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm2389165a91.2.2026.10.21.22.01.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 22:01:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH net] net: page_pool: bound queue_idx before indexing
 dev->_rx[]
From: phx <phx0fer@gmail.com>
In-Reply-To: <179259845250.3290.4918122391861397887@kernel.org>
Date: Thu, 22 Oct 2026 13:00:55 +0800
Cc: hawk@kernel.org,
 ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D95B3BD4-75D6-4DAA-974E-1DA5B0A9F665@gmail.com>
References: <20261021155611.68473-1-phx0fer@gmail.com>
 <179259845250.3290.4918122391861397887@kernel.org>
To: netdev-bot+sinfo@kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi, The issue was found by LLM-assisted review of this code path (static =
analysis), not from a production hit or a syzbot report. I then wrote a =
reproducer and ran it on an arm64 QEMU guest under KASAN; it fired at =
the claimed sink (page_pool_create_percpu). The "Assisted-by: LLM" =
trailer reflects that assistance. Thanks.

> 2026=E5=B9=B410=E6=9C=8822=E6=97=A5 =
=E4=B8=8A=E5=8D=8812:00=EF=BC=8Cnetdev-bot+sinfo@kernel.org =E5=86=99=E9=81=
=93=EF=BC=9A
>=20
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

