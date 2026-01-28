Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CF1D5CC9
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617416; cv=none; b=dPqqcj6hEfbHBlHREJKbNP4cKEnEGlHFPF2gODZ2Pj5DUuG4bgtmSrHKxsWfEWLC810RWYhRmXu6yM7ZgP+5vt0IxfQW07Gyn2cI70x6gbACUhoUAjFovfzib8MCSImNpZe1IEdGcVVSGZVr/FWtD9v9zBcNVJi53G10TXGQahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617416; c=relaxed/simple;
	bh=D2EVtZ3Bdu41Pl2Ma9t3PpB00ixzoM6dRSpGiADfFr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gONwtreP3UMJ2h1m0zuHa+BcJXHt4qbZheSep/+ADrTeamxHKQyRxGkDS3jwJE6l6q8dgXvTkLX1Gaa19dGdtgWuscXKK8XDCvNuvsw2a0XPWHjXmDez+M0S/m43NAYQ6ReUubuQGHPpozwdvbvtw5XhI32hLMSO4rSwU8YBBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4YeAKvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4YeAKvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0AAC2BC87
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769617415;
	bh=D2EVtZ3Bdu41Pl2Ma9t3PpB00ixzoM6dRSpGiADfFr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p4YeAKvJ4CZPDV0CsW0tDcLM3yF13+bVmuMOKrOUdHxL/dAc9E1ENqMe/DfaNGZ/a
	 GbrOCgII7DSINitopjirki2BpP4rvUcFtluq+uCWyB2TmvlT2UVhf74mLBOEN6QaL5
	 3RgM1b2CEYOnNgF4Te+C7jNxS931uJ+Oo4/CDSdQdHMf2YJvjFdRFYmw14kwr3KtGB
	 tSyUt7wkBg8WYTY20X+0bRYKs1UXdPexCrG9pWp1NO1hmwoZ/NZO85DUMjY4AB52Gq
	 1HkofEsz5iL58XThDLBHRvejF7V3ika6W7z4WNKFquhecCKCKOOaYL7QPUkqejByhs
	 QDC3X27Y+pbyA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65819e75691so77370a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 08:23:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFqS+K2sPDlgedT+5YAhbNuPJpK25wpbcj0DZwLKGwyVqZUpKHbMuv6m2ZZRGEMURyzmNgANQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpMZcyrAAuv+KcL7oJN9yVYPXOKJPhpb6V559T9VHi1Nd/mJj
	St95c1Z8xDe5sQ6YAC8Q4PUa+WXUWukC5TOXf+8RpBTWq8EBvcDKGQkedjUbdIpdsxaJ+W2kcaT
	crnTQ33DRGLOKUQqS2cnBqGLfu9aQbg==
X-Received: by 2002:a17:907:7f89:b0:b87:65c5:602f with SMTP id
 a640c23a62f3a-b8dab3304eemr370934466b.34.1769617414310; Wed, 28 Jan 2026
 08:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128140222.1627203-1-robh@kernel.org> <1fca424a-6215-4303-a0cd-623063945ce6@kernel.org>
In-Reply-To: <1fca424a-6215-4303-a0cd-623063945ce6@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Jan 2026 10:23:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAREg7ZNK55fsLFcPkj7L4o5nRRvDCHiBu_UfRgEuJvA@mail.gmail.com>
X-Gm-Features: AZwV_Qhwv8z718O3HYAh8VI3E2MSxN46iPZvhgrJUI-6gJD0GIquFnIPc1OVxUU
Message-ID: <CAL_JsqLAREg7ZNK55fsLFcPkj7L4o5nRRvDCHiBu_UfRgEuJvA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: dts: fsl: Drop unused .dtsi files
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:43=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 28/01/2026 =C3=A0 15:02, Rob Herring (Arm) a =C3=A9crit :
> > These files are not included by anything and therefore don't get built =
or
> > tested.
> >
> > There's also no upstream driver for the interlaken-lac stuff.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >   .../boot/dts/fsl/interlaken-lac-portals.dtsi  | 156 -----------------=
-
> >   arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi |  45 -----
>
> Those two files were added by commit 8c43d2b0ca10 ("powerpc: Add T4 LAC
> device tree binding & defs") together with
> Documentation/devicetree/bindings/powerpc/fsl/interlaken-lac.txt
>
> Should the Documentation file be removed as well ?

Yes, once there is no user, I will remove the binding.

>
> Regardless,
>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Thanks!

Rob
