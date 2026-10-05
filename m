Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554240803B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213182; cv=none; b=CI3t5MnqTl+nnhPkY/FXl1TjjotUS/Aj8sMKoI/UEzUV6L7blPCxNaBdGFkIW+wkRQGGnk9XRVVvdjtTJGsBb9QoKVpE+KOC4hCAvzyp9Fcc47SjcDzYVm2AWHdLB4NVE+RchlABGEkxiJkQrjq6VoKQUkml2YK37k7/RSJflyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213182; c=relaxed/simple;
	bh=bs0Qo5kBM1JXtwtJBPF64JlV5l8X8iTgcgO3zRrUsf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRpZbrwPBViE376BpKhln8UO1YXNmmUhSbS5HGwFhAp0loJFdVQnnjZFjjXJJpYE9h6YPwOxvV/PRuNc6F8nuOw5gEuLWOXhiYDKHIB1HhL1tY71FT8AlM4zZ0Lk1o1Gk3EjsLC1EBn8AbTMEDP7OjdRuYfMqzJKMzYH0OQpS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj+hbZTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj+hbZTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9601F0089E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213180;
	bh=bs0Qo5kBM1JXtwtJBPF64JlV5l8X8iTgcgO3zRrUsf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Uj+hbZTSlESKUfXULAN17eMtlIkaxakIOFAGpv+0ciyC/jG/VFE447MXncT3bvNEV
	 jZgNgqJIiLrr/WMbqhaUVBtlSf5+ZGwfFmm+SMTTgMW6oDOSSM2OtWavk9k5q9ZFx5
	 41Nu6SLHjUNFBLdwWsTwg5eIi4Cwu3mLbyTyBfRYCRL5HgDZb9SGkBKvePeGWp9C+h
	 C15UT57EzeZVfo1lNyQ8JOW89FlH0DFJZu27wW6tcv9MW+w4hoA3He/BKkRF98Lia7
	 k0INPeYU87ka92DAe50ShbckC+N0KBkrR8ahjDMtI9OKo2tsVVn/5X1nFOYnL4qRlG
	 LXH4EImL3maPQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba44044ff8so1388281e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:13:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByxHTZ+qbl174b/+290L9FrfBNcTRMId890lzimD4i7A9fEII4K0m9Z/PzoFVsXbrI5CU1ZoDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIERTUrN9sRIR6CpP3rpFf5ft18QZOjjC7tU9nn92PBH10hTxnB
	ZA2Z3TCZtrmA81zwJUAjZI3NfqBgY07YIlW6sFznvpmbrjG16JSb5ZaMgz+Dgkf6SlTl82eiTsC
	1vMZs5ziQXXszXIc8DyIEfUzwQaFFuOo=
X-Received: by 2002:a05:6512:32c9:b0:5ba:3ce0:b238 with SMTP id
 2adb3069b0e04-5bb93a38f37mr3497099e87.14.1791213179553; Mon, 05 Oct 2026
 08:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
 <20261002115850.962676-6-o.rempel@pengutronix.de> <CAD++jLmPfzi6FqF+xYFJoAjqz+Q9Ax9vhUp-MjUSFNTwOPAn4g@mail.gmail.com>
In-Reply-To: <CAD++jLmPfzi6FqF+xYFJoAjqz+Q9Ax9vhUp-MjUSFNTwOPAn4g@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 17:12:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLnYB2ec6yOF2so7W8kkq3PR-+c2kCscTSxPuGVC-L5G4Q@mail.gmail.com>
X-Gm-Features: AclHuK_lBLUvKCZgIdRftzi0JSbJ2MwHoG_nvSOx3QCjboHQ2WvPYTIxqnjS3mc
Message-ID: <CAD++jLnYB2ec6yOF2so7W8kkq3PR-+c2kCscTSxPuGVC-L5G4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 5/8] net: dsa: realtek: rtl8365mb: store the
 egress queue count per chip
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 5:10=E2=80=AFPM Linus Walleij <linusw@kernel.org> wr=
ote:
> On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutron=
ix.de> wrote:
>
> > Store the number of egress queues in the per-chip info structure and
> > advertise it through ds->num_tx_queues, following the ksz driver
> > (struct ksz_chip_data.num_tx_queues).
> >
> > The queue count is a per-chip hardware property, and this driver suppor=
ts
> > several chips of the rtl8367c family. All currently-supported chips exp=
ose
> > eight queues, but keeping the count in chip_info lets the QoS code that
> > follows program the priority-to-queue map via the ieee8021q helpers for
> > whatever queue count a chip carries, so the 802.1Q collapse is correct
> > rather than hard-coded to eight.
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> RTL8366RB has 8 queues so it's fine to keep this separate
> per-subdriver.
> Reviewed-by: Linus Walleij <linusw@kernel.org>

I meant RTL8366RB has 6 queues. Hm maybe you rather want to
store this in struct realtek_variant and have the core
helper instead?

Yours,
Linus Walleij
