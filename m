Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D003290C7
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749934; cv=none; b=mNzyR6cITwvikZXxc1z7LyoPdomEK54FCg4cZGV0JWw4x/s1Hsoph+J5Z+bHrOX/qmVF+dhXHiwuyBamTDrqvFJQNb892Alo6b+EyoCyhMoehUxb9MJsNszs9cL/o3ZU0r6qjzqdXsjGNk86MRNj3X9VilX44zI/pLJC5H/IvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749934; c=relaxed/simple;
	bh=Gcg44s5pOEsHqe5yAMzNJ5yI/h+EQKqw2L0+QOdZ5j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG/FGQh43b75xIu/xbSzc57wgVba5Ew15ipL4foDWv5PFhYpkVzz9SpaBG54OuK5HmMzGp/g43S8Jos4POR1NeTtyXQzpqvJx2wO8j6sNnXeZnRHQpPTJIc0Z8YclQed5ubKb/1dpAOZcHjThmuzuIa7dVP5dpsfNJKcTgbSzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENy8ZP7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENy8ZP7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574AF1F0089C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 20:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749932;
	bh=Gcg44s5pOEsHqe5yAMzNJ5yI/h+EQKqw2L0+QOdZ5j0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ENy8ZP7jGREjv2K/Qr2t7W6v3kFIJrzQodR5YMlLQLh95STBVDa0eVAnD2dOGzq4Y
	 eVI1WEGOKg9Ukt96aKrSGY5D2Po+li18p2Vqo2JaS7TH3hxXJz/7PZQ2hfhV3IbBqg
	 q+34Xmmi8WwZI54FGEjvHrVZTXO7l6i8nwT5Sva+0dtEO5Prw1xihYUoW/qwNzRgjl
	 QR6L6jd49lWWmbCX7VDlIh6BVaEIXqqfOl3koTLHHrjnxmHt7Aasp/O5u+B/RPvV9u
	 c3jx1914UuBugYQwbfZPRDMjpyqV0L3qco/GPXaMObRVa4tx0Orni3Q7yilPCyvKzt
	 vQ7S+OMVZg+MQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba357a1929so950133e87.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:18:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1knhFrznQCBWB9hOh5MpMNnt51J3fxMtxa3J4LFjWcs8sgp3FTUVbjocPS830DeBcj9NXXz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0S17tRFFTTLD9k5eVHvQW94LpnIuTWGcBfVQd4YQ3ISxaQobK
	K+iyZxW0nKndQWAp+hrf0X0Hu/cxjrpuF3HliyaVDI6GtiKieQFr4safGVW8YSTloeTgNk33vF/
	LtujEiKoXbKNEUfg6U/SaJZH0sLbGs7M=
X-Received: by 2002:a05:6512:1094:b0:5bc:ca67:c329 with SMTP id
 2adb3069b0e04-5bcde3538b2mr2804085e87.4.1791749931095; Sun, 11 Oct 2026
 13:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011131208.272131-3-blum@kernel.org>
In-Reply-To: <20261011131208.272131-3-blum@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 22:18:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLmaCFZ6MOek=n5h7pU=6_ihQJ3EarZSSGi=xhMqcLc3CA@mail.gmail.com>
X-Gm-Features: AclHuK_f9oCezWet9D8wmptpScz-bKTuIXf20YhlSgnbTQakgm03SMJQJWbSXIs
Message-ID: <CAD++jLmaCFZ6MOek=n5h7pU=6_ihQJ3EarZSSGi=xhMqcLc3CA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: Remove unused buffer from
 struct realtek_priv
To: Thorsten Blum <blum@kernel.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 3:12=E2=80=AFPM Thorsten Blum <blum@kernel.org> wro=
te:

> The buffer has never been used. Remove it.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Probably a leftover from initial development, thanks for finding this!

Yours,
Linus Walleij
