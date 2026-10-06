Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367113B0583
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270906; cv=pass; b=ptEFapXpJbRr5tfxEc9FJkJI43z/r3SQDTQPIF+WrVWPQHEY2N1D+UTedkGssbEy4FYYU3/QaI787qkwkhBrt5ch5rqE2rPm7h3Ifg3Af09tD0YeiDJaupubcnhFXMGWpF2rg4+VbS5CNCvV99SinTp5jWRzB6KHje7njVxVJmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270906; c=relaxed/simple;
	bh=4ATp6PMQr7SBUWePCIQTDnn323iSU6dbR7/g0U4/YnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuhsU+zCTtX5wDUBIJmIlDU3Voqdobyxo6RPucKn5sj421DEgV6+/08qtoGhn98sYW567wdgJ6MBN3Av+ioy2jwr9hGm2LgIrMNa3YDD6yxnUGMpMXRYXFM3q8FLTw0g+myv08d6P9rtHDqbjNC1Gt7b+V4eAzk7m+/ZRnQ++Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9rr3JLQ; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9rr3JLQ"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-988f270d308so1827219241.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 00:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791270904; cv=none;
        d=google.com; s=arc-20260327;
        b=NxlMuOUhiXX3PUX/a6ZVRGOhOAkjQkwhLE2ZxIzP9V3DCkiDadrRDJPaukP1XYGehp
         XZHuMi8l/ie6gslvTi3sLG9q9JTgsLfCHWNKm4tkT/ePsPOs8IVZ72Vo4EridxY4XheG
         ofUjzc2SeURJ6GYpNsWj6/oWJfKd1UpEQN+A9qUJr4Qwi84rW8KPe40prh8JyvOMS6JT
         S9lPdIMu2GBEx3cgL5jWc1cAgJGLJlmg+msd3IsScrYHCbHpQ8p6Locp5LNJWzn9LMHB
         0saQgUNn8DpcSAxannUmMcSAtMP7/im8nZ9cPANEVF1uSJxo85/wFCv9IDEwC/vtmn7c
         AB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uni4/TrlrriaXDkvx89QTAW+nKztkVVHOAjkaVmVW0Q=;
        fh=yclCPUbGF3Z7dQh89LZheI2i/4s8Uc6SCmZOtr7DeOc=;
        b=KKHADCCLoOgvOBdWv5kbAGWWIZrZ2M87jUY7F3V+eZsqVBGDY+V7QxKnAdzSN/h1Dm
         kS6c1v0ruTznTVA1G5Qh1hsSx3jlBQhFcEUyrFA/jFkwyfq4OFqdbyMGi7P8DPyPUCIM
         gk4sNSL3MK1qCI5FTAjfPpeYdS4iwmA7k61NlVp6WYe3gtjoMVOw2HtNdjUkZOSOSTya
         JshOaFn0u+9E4FRsqbvE1tFUi50MV9S1dk6IDQo9CuE3GJrQEWr4pjvRgVQx6nXFYKNC
         Pl6NRW4o2BYQmTvOOeTXuoJtD7o2akqLEnfLrKyAZSZjYL6OXdTtc7hhk3V6D7GkdIf2
         BKHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270904; x=1791875704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uni4/TrlrriaXDkvx89QTAW+nKztkVVHOAjkaVmVW0Q=;
        b=p9rr3JLQaB0LlW22YlT5bqdnG+AuIALV481fmmCazJZJ17j4DMV3sXJC2XTNynF5IM
         Ha+Hu4qJfVOPgkwlEQEB2UMppwDLtCtDPLBz/PqVgIGpQTTftK1g6uWzgtmzrgCkwDqY
         zWSFyJjqbx5PVZBOdGQWV0DU/iJPwz9bNWFpTDeTw549cg674dv7opvzT05wdewh81vg
         pd5Q7059cYTYmPHvwT6OZbxxrEgo0qtVweGg3tPwhtPc+rMLyOM9E0jbBaooc52KiMFA
         lPYKBTrMSXhFQtVd2vilxWMRiyhV53k9/iBrbJASoh9n2Q2VX8G4EfNPqORPwsFoi7YN
         fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270904; x=1791875704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uni4/TrlrriaXDkvx89QTAW+nKztkVVHOAjkaVmVW0Q=;
        b=AUHZM0ZJ9V4G2UyN7OHts3SHN0cyYUxgWgqbQmtmxZMwVYCcfmgLC3E2qe/u0089/w
         8rO/6Km/BxuRsSRzaCvXHZCE6601s68gR7Q/94o4c+aTdOedO3GBgGXD6iiYWYK971kq
         OWeDW7nEXnReXjTIu7lVvNqrSK/a2t6fc4a/nHYkr5z23VMk1MzLSJ70iBb4rURXpjP9
         hEn4hFNlF0l+5vBKZ1bwDAtira3B+0FV8K2Zs4wPi5OHRiBjf7kq5KHfrgYt3YhMFycj
         WNUmNw6Df2/wzgccgaAjeenVlZJ+Fkz6gUSmfjw243PT/4MZjmNooyz0p5BUSiqIJ+7Z
         bwCQ==
X-Gm-Message-State: AFq9FYKvVSBABywqjKFGVC509o5CUWfejLjnTmc5uG4dmGdmSrSv7oPf
	F4gSInnr/3DzXWBxHgNZ/Vz521750Usw/p2Lveai6KB1xTgDkWbAM4sMR89tyn8uS3rd29ApnbH
	O+SHfMNqA+6hkShZhXR19ocIjopZYC+U=
X-Gm-Gg: AYBFou2Q22ilgQ6LLDpy+lxXJCXSKZlDrU50fZCvaPSu25R7K8N6hl+FfZ8FP8gsVoN
	BZi900ZTsDDphLDpkv6vs50smX7iv5Er7WQmyLKkE3meu6soZV3LwvEIlhfY5QzpxKzHKtAYMWa
	KYEZxBnME/5BTmw4MF7I5VjURoKxsLkKSuIYgMKdNaG2hHymqHImmQpt+taWJmKYcCRY5rB8USY
	lyqzaTBeA6W2eBAbr1pEsobw6OetnPGqt5Qygg8pZlVKOqS5SX/Tw0TrTXY5DsVwUHGV+TdLeig
	a2Amw3uopbaV0VNym2xPHJWHZJSS2o8bfh7CGrH9Sai4KjEMtrVfYP/wf34wiJFvlAoK8Zqh9JN
	z/c2/LaJRvi+a8ejy3QGLoeN/Kj1hdD2RnxzM8dDKMAgb4Iqq1qbhYE5cJ6t8Ap9U9b5ycRIeqd
	89oLukXQFLC3AH2PBSg1NV6ioM1tJnHKu59kkBz6Il9sYN
X-Received: by 2002:a05:6102:a53:b0:7a7:198b:674b with SMTP id
 ada2fe7eead31-7c2460fb1demr3329504137.32.1791270903847; Tue, 06 Oct 2026
 00:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com> <179127056620.2231598.8882282421523696709@kernel.org>
In-Reply-To: <179127056620.2231598.8882282421523696709@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 6 Oct 2026 01:14:52 -0600
X-Gm-Features: AclHuK9NHnAoxqio4ND9YA1CPQjIIsifiUFyiINUer63TXcvYLe57-mIcc0zYw8
Message-ID: <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Nicolai Buchwitz <nb@tipi-net.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 1:09=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

This was found while reviewing the error paths for the stmmac
MTU/resume recovery series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

It was reproduced in QEMU by injecting a safety IRQ request failure.
The unwind reported "Trying to free already-free IRQ" and left the
WoL handler registered.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The affected path was tested in QEMU with mocked MAC/DMA hardware,
not on physical hardware with separate WoL and safety IRQs.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
