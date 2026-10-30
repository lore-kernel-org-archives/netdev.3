Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793344434;
	b=nay57WDCbddBexPo/mvMTMqtLr1v+rI/HULWgVS+0uhhjRm65s1jCwHMMqy3GxQTS+9E
	 g6Tq6YEEHFeWtV759FzvGX81MwyMiVhyDP1raakc+uRhw7U2E7j4U7pVo8BetLPOmF9LI
	 zEcVmVPbxfWLYBi/pJa/l/+ViEc5QSkr8fB29zkDnwobyyUO2a0KgK4qaaxvaCmC8Wkki
	 EcbCzQbCfSwS6tTHo4aSHzudXnjYf6MJu8v2/+o1t83+oTATluqBv79VwFWXIGQqo789O
	 ua/Y8K8VEwclxrFtKqHlMMLpZxYHEYO73AK9I0PRhLDvE2jF8FvgyFf2vpvy4+9TAOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344434;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rO1DUxgOCL3BnP8dMfQba4psXtFmOQxqwhHA2oiBfww=;
	b=FYUqfhULsQb3kNKoTivDR703Sy0knmqDdBDI0O47OZW6agwh2iOu2fC+6H5EY3ApxEqM
	 7DJlBG5hnF9KEGJ6oTw/RJsx9bnhgjrb8A6Z8CLeFZllXk6eyIbNQxLyitNMuZBWoOcgZ
	 29f24KtDh5FGTBvP6PysWUQtAR8DpBDbCHkH760Z9qsefUvxE8RiZPn+M3BIdxuSZmj2V
	 2CoFZiE2Y87ZlHIBholTx2Guun6BI7D1etYhwbwnNMtzQkMFUBVGNFa+0vKFzprNCodJ+
	 FeuzoSr8H22GgDwLZ6oZfNaBXb+yPEZlGuS3uEKcq1mNDou5cMeUHwsxTQdasBczoVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENYHImrb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C3606A329
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENYHImrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56151F00A16
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793344433;
	bh=rO1DUxgOCL3BnP8dMfQba4psXtFmOQxqwhHA2oiBfww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ENYHImrbGGaDwwaQyrmQOEnSioAcoqrowfam7eDxDSj8+liqu+utROCGApa7MjGK0
	 8RoyD5mCvtPBjnu9sbflL1ilJsztGANx6PiujrHGKcIgg5/PVKYW+saT5kQ7EtlK0l
	 Ub5cUm/gELE2j7mcHGtcgU/vx7UWf0GW20esUk6UESUtp3HVq35pd1DsyM89RTeAgN
	 2Y7yXnLeHDuLRnsxz79rFx/wgGA+hIvlqAdeR5hIlLwIjo3Gkxjc/ZIJfgCuSm2x2r
	 qF4nwhxf5prKoSe3Z9Vnm2+KrKYAAwQIjzprtK+/GZ/ZLRe2Df3cMYlXn8Tf+DG3uG
	 8PeZcyA+rEeAA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4911df1e196so255455fac.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:13:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvHKT0BXt9hnqhuHH0x8gV9iA8W0wKqNP+lN8QRH/wVhkJZZOFoNKE7Bsou3OOnxxH5vOkO9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLACFoPbReXLxCzIXGkUHNXsTBM9HqXB+5BIDzhSRG3fbyDwVhZ
	SngH20cW4Qp38fR0LYXj1RjtzifYbCbiqFl18K5kYq1GaCQYbmK1Am5TIIXNeIspsYQ/CXOH7LS
	yI0UMiWhb8b2ArT5G+E5wtfhXaNwh+kg=
X-Received: by 2002:a05:6871:3a25:b0:494:b8f4:9a3d with SMTP id
 586e51a60fabf-4a90771aa23mr782425fac.40.1793344433131; Fri, 30 Oct 2026
 00:13:53 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028162510.2180528-1-edumazet@kernel.org> <179329410450.3134.7838743761467837570@kernel.org>
In-Reply-To: <179329410450.3134.7838743761467837570@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 08:13:42 +0100
X-Gmail-Original-Message-ID: <CAL4Wiirwx-_LKUT6qSFRbn7Z3psm0n2V8pDWx-SxKhpsVLdX8w@mail.gmail.com>
X-Gm-Features: AclHuK-R0C3aZ682sUxNcPqq3SbnmnobFDRKeeirIO_HVvItYvkX8sDe9-6M6OQ
Message-ID: <CAL4Wiirwx-_LKUT6qSFRbn7Z3psm0n2V8pDWx-SxKhpsVLdX8w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	ncardwell@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	kylebot@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 18:15, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
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
> - [High] tcp: missing synchronize_net() in tcp_sk_exit_batch() for shared
>   ehash
>
> Pre-existing issues:
> - [Medium] tcp_sk_exit_batch() (net/ipv4/tcp_ipv4.c) now calls
>   synchronize_net() only when some netns in the batch has a private=E2=80=
=A6

Ack, I am preparing a V2.

pw-bot: cr
