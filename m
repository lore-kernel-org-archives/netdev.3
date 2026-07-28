Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572874A32
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197059; cv=none; b=fYOq5gsnh/uthnRpkv48oxp6mycfewAMcaWgH19iGa3+PjcDFAH7WsX/fbOO8WKOCBMCcAHpyURDVYa67JyZ82a5pf7jdInLz0P0JZe2PPJK0p8upibQYeZUUKL+I9vGOjlSPcT15+zFm/Q/89wyXY9PRAJUPReOqLJnPGs5XOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197059; c=relaxed/simple;
	bh=ex7cLfncY79ts9Hz+OBSJ14Qvq48GJjp+PusMQPifCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1kumrqi6lCP5jl3xp8ARvSILXF7aPTxdSHrUmcmXFUvb+Y/xEaA2cqX2R2RyAWK1ApdyDZhyur9NmkowBYkI5RAGG0Y3Qc0pVcaB3rhztfMJ2u72LRtiBdcmA/kPO8Upe0IlQEho67dQruq9/RQbYqcdbS5CnCJCTLyqAZcH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efnYEL0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efnYEL0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A41F000E9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785197058;
	bh=ex7cLfncY79ts9Hz+OBSJ14Qvq48GJjp+PusMQPifCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=efnYEL0nsZw+7uVvNeSez9lMF51iKAr2GXTSXEZhGlYrYrLkIY+DXliWdigk0H3ya
	 bndN1VU7Pb823FMmOU5oTihcz9wn05pseDysKqtMkqnvzhD8MjKcsWDUt0D38jmcUh
	 XGr9QHBwIGUEvUhuAI9CEHE68QImVaGAPhMMkhoFvYrGbYiuz0s/VDzFlcjLkpTiL9
	 V4dr++nRCi9HJ+RK3bgWJ4K0iinFnK3pVZ1Kh7fkQz0Zw9uJ8eCnv+XDNY2JIQEbHH
	 OnwTc7vCUrBvbdOSdrYfWxi7nbUqOtUCxb35hzfeByl5E3C6v9xJfarSNlVOHZ1PFa
	 FJQFLXCc0o0ng==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so2937463e87.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:04:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoByoNTGuriKN1NcfCHgANt54fxOmQ3EYJ/6+n9ERf6mZeTA1sT1Gj2wze6WU0M6Y8dSV9VM2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzeJGKtDBUhn22FYY4nNmjOYdJ+qEHOHJdxRX3TJ0oQ/AYdNN
	FdxAu6+2yfcEUWhyJXILLKmvsOnsrv3MABIhaAfN106pi5x/yUha+iOBQ3hwtfdlTi1PuwZjmzF
	kVI7jTI3g8W2kYG00i7ooIsWny4LsUF0=
X-Received: by 2002:a05:6512:238b:b0:5b2:8de5:ce9d with SMTP id
 2adb3069b0e04-5b2d0257334mr8409e87.50.1785197057050; Mon, 27 Jul 2026
 17:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-realtek-maintainers-v1-1-ab501adc0cdb@analog.com>
In-Reply-To: <20260727-realtek-maintainers-v1-1-ab501adc0cdb@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 28 Jul 2026 02:04:05 +0200
X-Gmail-Original-Message-ID: <CAD++jLk4uEY_7YpZkzt5jESDU+kOrX1z7CfiEE7EYKKQnJKtnw@mail.gmail.com>
X-Gm-Features: AUfX_mxY0xZtzcYwB83Qq_HQkvO7JRbUcKltwI7lauIHYavlYcOCJ_s31hFhIUw
Message-ID: <CAD++jLk4uEY_7YpZkzt5jESDU+kOrX1z7CfiEE7EYKKQnJKtnw@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: make Luiz a maintainer and myself
 reviewer for Realtek DSA
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 10:29=E2=80=AFPM Alvin =C5=A0ipraga <alvin@pqrs.dk>=
 wrote:

> From: Alvin =C5=A0ipraga <alvin.sipraga@analog.com>
>
> I have changed jobs and therefore no longer have access to hardware
> using Realtek Ethernet switches. Luiz has kindly agreed to take up the
> role of maintainer, while I will stick around as a reviewer.
>
> Also update .mailmap so that mails to my old company email stop
> bouncing. Use my new work email for Analog Devices Inc. instead.
>
> Signed-off-by: Alvin =C5=A0ipraga <alvin.sipraga@analog.com>

OK, sweet!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
