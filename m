Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AE413D87
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572655; cv=pass; b=Ou8FTPC4BjKEqs5na9NM9KzQfaIKcSG/xYuYQaoleDUpVql80n90mj+AGLTFiE6PAm1J6F6kfqF6St3FFJWU6Sd41j0aMx/dwBGRUjx3M2btO8swGvIIKht497mqwP2zTcd8IEtSIF0oJrT+eEEMaRrmtS+VeW5oyjrxUAp/yYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572655; c=relaxed/simple;
	bh=IgaVd4/D/neWcGaYdf4+CIF4yFVYz7Eh1SsiQPIdiNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjsZnnNZCckL6gSnRB4ZlazA86XkvwK7uswprR2UJDTTkeaRxcuCDn3g2/J/GPX4mkqVmvc9tb0GVZlwoZoy23FDwqIITS1oiqhVDRXw2+Fz+QsShivdMDKkCWnizPiRGGRJDc21xdh49/tWK0bg7wKB3jnKBKnyDJRSVsFVDwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezmqC2iN; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezmqC2iN"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59c1bacf871so174547e0c.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 04:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572653; cv=none;
        d=google.com; s=arc-20240605;
        b=TyRVZsHQNqdXxVd9qiINRq1uZ9W0RqnKcRT2s3mOuQCw6hQ4tn9b5ImATdJa6kSIEZ
         3Uo0qtjDEOAOiB7fqucHFgFySDLgsUMDsGDaVC/g/7uhA0SlQGpkFQUrnv/DCugoE86J
         fcyWkIn5+RLMbX1Dq49XDh/qndN7Hwr540mLxRMUo8YN6KjfpbQflbJo6D7gW8n9TQ64
         t8BicM+ptdHrJ8hE63nhodFGMY0MBqw+q6JJl8yt7K2tKaG4cMFs8lzwyZ2lZGguC6Zq
         GQ5I0cJUbmcgQDPnulxJ9uR5RYSjBaIXQy/ucS18WHNxgj3iqEKp2PaW9HHIJnb3PWfC
         3m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        fh=mhyzYzRgTx2JnqG4TJFwTltdE4ePG9W+WNCeDJVrADY=;
        b=iG2KFV1LY8OY4Ilv6YTm6UkTLEbq92LfY+zfULUuOmJcIM7lyEGVirsAQuNV2Er2NX
         3oK36X7CWndFHvFZlqlK0QuGFHJQEVKyA6G9Pp3uRs6xWF29sR2l7gj/ON6XGZjP2rwy
         ynRHFxW56Cg+f0ZWZRKC9BoGJ/sivuBiESpQC9l7K7C4uECbbAcmeku2+p5pb/Zomt79
         hPREtFTDuOKGJiiwODXetx63hMmHBrk4ts7mId+s7WwNDjNkWYsUZl2L6xW1kFmpCQ5P
         qU2ye1qoTYS5l/ciGUo2Cg8XM/ITxJzPBBlmre7pJu9Pj6jD1vsV+J7IlAazUyPqV9vm
         J7ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780572653; x=1781177453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        b=ezmqC2iNUUfJwgeZG5pY77k+XsOPGlvqQzmHybpNLf7TgfVbhGzWR/k7Etygx2EpSE
         Z6JruUu6i+sXQ1MdiNIQhWdtKUBevMu8VDIVGDED/svPKd88sD3WWuf3fk9isG8+grfP
         z7luiITciUECenfvw++v6qu+35n08EKbcfbTDepHUszlgloxnAYu4lxHmiJNISX9VVfi
         ccRz1vwWyVrp1N09BchOhOSHIdePyMAbf61zuPrbhf4qJkOn3BCKIrle7JrKLAL1hMzD
         A6UnlLA3ubDJiXX/X+bf+KGPz0FksE0UYBQZ2TTOcZ8zXrdCZo2ulqws8wYwRrqbdVcv
         evpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572653; x=1781177453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        b=MKa9f1uf1y/+5oyVN1U9gLwwoxB42LUhdY/F6Ovq8GsF2+o6tFFqzXENbZy/PfNCQT
         OlHuGXLVO1g+DFZl1jMUK/WH1UNfuUzdyo7VHgitO1Ml6WjIQVI2IDRyD5GQpiKmUzD/
         pz9NIsyrknZmzmYud31QtlmL2gPp9im8EQD8YZ2+r/67lT/vzPHiMqkmTji9GHbwFJYu
         EYG4K3ja7cuYArJYSk4zb49wDuuBGA4/LE94kz+0bfsRUjqLbEeK+Z6ZZaGeQoX2zfV4
         qIFejBCR/bRQlhfju5+OoGtpS7v0XMqcGzxrdo2ivRG1y6m/ZRa+7onhP6dqZ7v26w60
         zKrg==
X-Forwarded-Encrypted: i=1; AFNElJ+oyu3dMdpmHiT+Lo2842GSXEk3+KJ9RPOD9eloHFIErNSvgDEC0Je3t53yVDImtYWV+q8mQuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlHueVciYZzX67H3/LvICvUB4XTjnz4hBXBX/2jTXOoUfTbZM
	CmGr0XObEezh7Nn2ntAf2/1Mih6YqDR5FLXwlItqp9Pi3x3/KgGIL2qgI5lB+qCmRUPmIUdSlmR
	DNyQK+kUQNN+ZeD+5g6pPyfZCiusueoI=
X-Gm-Gg: Acq92OFU5eSJNN2bMi1KlDnJy4Az2LxOqn0zOF6+sboYcRfXy7i5NIq5VYmAibByXaZ
	eEQgpzOgXYbOzGz6zxmPgUVFs2QVcwGbKzBn/xs4h5SvCLKiZ9sDFtkDPKiVsufHG8jO6i0rkM6
	uWqbNH9RHUFzbNhWdpaO08zVuiOJe9ux97l8FI0AZp1MHIkrIggoD67YQ1sp7sl1iP331lO9Rje
	pwLjG40jtU2SeSeLMtufHW+4oDMaR+NkxcqcniK6CorvaQMZ3vqBpE4/K7/4ErT+tGsIt1EZu/k
	BcrV7xrhO2R+vS0M
X-Received: by 2002:a05:6122:6e0f:b0:5a0:c38e:61a6 with SMTP id
 71dfb90a1353d-5a6e64b8500mr3995715e0c.8.1780572653233; Thu, 04 Jun 2026
 04:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602164635.62517-1-mail@tk154.de> <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
In-Reply-To: <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Thu, 4 Jun 2026 13:30:42 +0200
X-Gm-Features: AVVi8CcDjNH2_4RpELI_VLhIrfYWmPteT4vvqOayjCSlCrLru3IZfh7g7MR56sg
Message-ID: <CAHzn2R2uvJiJM8UNw2+QEU7yqnqdJqcsDo1gBq8FKRBGs9DsDg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] net: mvpp2: fix XDP RX buffer handling
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Til Kaiser <mail@tk154.de>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Matteo Croce <mcroce@redhat.com>, 
	Sven Auhagen <sven.auhagen@voleatech.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,


=C5=9Br., 3 cze 2026 o 15:55 Alexander Lobakin
<aleksander.lobakin@intel.com> napisa=C5=82(a):
>
> From: Til Kaiser <mail@tk154.de>
> Date: Tue,  2 Jun 2026 18:46:31 +0200
>
> > This is v2 of the earlier XDP_PASS fix. The XDP_PASS change is retained=
,
> > and the series now also fixes related RX/XDP buffer handling issues fou=
nd
> > during review.
> >
> > ---
> > v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
> >
> > Changes in v2:
> > - Fixed RX DMA sync range to account for RX headroom.
> > - Limited XDP frame size to the actual RX buffer size.
> > - Fixed refill error paths so retired buffers are not returned to BM.
> >
> > Til Kaiser (4):
> >   net: mvpp2: sync RX data at the hardware packet offset
> >   net: mvpp2: limit XDP frame size to the RX buffer
> >   net: mvpp2: do not return retired RX buffers to BM
> >   net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
> >
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 38 ++++++++++++-------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
>
> Series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>

Tha changes look good, thank you.

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Best regards,
Marcin
