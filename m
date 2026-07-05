Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E3377553
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253581; cv=pass; b=RyKfZeEfRnuCVgOmLWKH5bnkgqmixc9npojHE3OLaGTBh0nKEqNrSTX9ovMFK07YzHurJF4Mps3xuaEABQ4MUFHqwsmo+DVfYUSCM6ro2+edMIwCz6pGf4Fh8CGeL21pT13Muz+HFzu+n8eRR8wluEP6Koy02IRGGpH7Hr8W1nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253581; c=relaxed/simple;
	bh=5ISwFpI0UbPRq9FTX8wSAZ5/fVWcYX66lDYusFmfZZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pYMPBTFSXqRCbMBEgTt/FbD6Ogb1Oncw26xaZAq/2Y9U5OG0Lebrux8jbAV0FH7ZWV3/fF6GiKgvUz4CfnWStlQEG1gmPVToFrVrehgvvEZ1pSQ3eTLxAJML+frFv603QibhpwhCyTIpwZB0ziqXHQpYo+Y+fi03XA5XHaGxxt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiS8dlOM; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiS8dlOM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c988e16bb3so5122135ad.0
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 05:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783253579; cv=none;
        d=google.com; s=arc-20260327;
        b=di1WmmflmUvM1lXlF/avJOrWk888MLYOrL9eEZm3wf3zqc67SS8HcAu7/MBHZuhDwA
         peNA4efAqZ5SRcNw+k3XseWncK1F3RygSOeFpOZdYuHpGP9qjD0lf7C2Q7ez28Kpb+OX
         eqONSoTjwpSn+SR85asLFNmQAANfQ8LmnOwlDAMGqu84T7aB2o9b1G/jV5u8Ivzw1NQw
         S6R1txobg8Hcw+8sWvWxzhGPsQPdtk0lI7Mor6C5GXZe1t9dyUtesbOs4ltnV4jS4CM+
         malIYUOfDYwmpYn3HOtvVL2JUP7E/HiKmvI3efILTfYyb3xFLFXfv5wlbq/HVRA7fgau
         /3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        fh=tpBRlmJDvgem8Wj/8x+zT1XyQCKc3JOVrrhGJmuJPO8=;
        b=k6gHqCY70EPlyeBpjw3PsiR3roEUO14+RvCKZo/SUGt5Er/f0V+tgP0T1RjhVILXJk
         Edxh00Ou3XjnCpIddXY6WhFgikRnOjdSslpRMW2Od2fCdc1qJ6EG3YQsVDGFbZgC00YJ
         jmPCkU73V/PksaWb/m8S2XDTjDtuw817QRqBSi0GeoYRc5jZdh7DnQvjhq94+H07JOND
         ipx7aYtsO/u53S98HZoZ2ND32JeIirOg6VfAuVeP07YIuYHDAWOKtTC+UMJH0II9p//y
         NdVo1lgGy/0fB1aH3pabqW/aZy1iDUpGCuZkS2dFbQcK+Fy9Al4GlOFZvRG8JYyBG6WC
         tsSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783253579; x=1783858379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=EiS8dlOM4eyK6m1HpW3B/2Lk4Ke8vaKmQ1grSKFAJWT3nDgHQp9PHG6jDFJWFMvvPG
         oCku+2dl+HfLBkdKZgSuHLUA7YZqNbbMrZm2TVKZv4KZ45li1mzTsRsicFKWdCN+v+zi
         IdwL4gSU3xdcrd7mNZoZYzHVr3F5FCVUfsFcww01QxO2XIg11BR+z3vKVvWkHs0gbj5I
         2DZJKv0/WQyEQ8Ha6Xu82TGTSYANNStIKhMU5St9tH4npH0B5hAWmCb/g9/YoriaRJzj
         b431tZuxGVTTDaog+QabLoyvZpxKg8nku7BLjtK1/CPlyoToF4FA0vaITOaO05iHBIt5
         lnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783253579; x=1783858379;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=XER1e6q2WPMJDhURMqn/6cTJa/eOC0bJveL8gZn4HXR/57hh3rIYKz8DNy5Xn+l1vz
         zsu82ELH5G8jBueYDwdmbCEV5P1luFFWw6Ns0qJhXKe6oKUCh3pQO6iOQsZOTyHFBi9t
         xUMm6TAphQdBDw9TCOw+UgbOzhYHWl6ep8kEF6Jv4elkgbUemJ8ExJR4+6RbHCGYahyM
         A3zrPrut2R7axPLBG0ZCkkClwwTrwp04BndsxvCafrqfKJv9OS6jGrReuzysiK5Kn1Wm
         LZ1MnwenFoegeiFo98UdOGZd8p75l6QR8MraAYXcl+SuDctxeMS7hEa06/NRNq2ndSKC
         NYmg==
X-Forwarded-Encrypted: i=1; AHgh+Rrr4aK3hnwKFPBUgwVXNrs8szMETuOd1YpbAZo8aM0EXHoCEklESTCmTUwlHd2JsLaUpXZWjik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvL897EY1c6dMONGC2UOcwwyLLD28EKr/NRHV0XhWFdOw6QqG
	nLdJjxWCj0qAHW/KIA9u2I68hNmCdp4PpCBp4IVM2SZlm6N9ls48XbE6GgUuolRffzIAYEDVCdb
	XE31x7rtR2ndo2zDcQsrymk2mWX3xYgg=
X-Gm-Gg: AfdE7cl+CWuCAeSNfUm+fy7VvozuLKlUclRbOopViV+Px85mR6cyVepHYARmwhi+xK8
	9uQBCcTjgJi4HEGZiPIjyjJ+ttGBTw0S/p641Vb0LtwqNdDJ9eUPizbTX8RWFq1bowm8juQD8+n
	NDa80iN6lEndM0b1pTtSUGbG2H+SMn5Q3iO07hSgFF4dARQPje9kwBUaq3kcqukKTbqWY3PsUER
	msxDcd9UslfvvLeSqaLcU5u2k47h/9EJ8jlY++pW5E2M68rfX0iz6jsZUEf1fS4ElMf9HShpb2o
	F+nv8yRXjY1wZo40MQKvcw8Z0FsCKmclzmjkt7zEDt6WOQOgVjlaY84Ap/44M2caej8b+Y5Xq4l
	rAh84r68CidL8
X-Received: by 2002:a17:90b:268f:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-382802beaa9mr4128789a91.1.1783253579563; Sun, 05 Jul 2026
 05:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com> <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
 <akmtA7EbVBdhRAOq@gurudas.dev>
In-Reply-To: <akmtA7EbVBdhRAOq@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:12:47 +0200
X-Gm-Features: AVVi8Cfl7DMeNQYuJP9tYThrU-TabLAul_khYoWVx5WCyAQG55ujZm7jKpKar4U
Message-ID: <CANiq72nESZyX95XSKC3zaog=XSQF09bYJmre0mUbtQ42-Ly6tA@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 3:02=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> But unfortunately, since `imports_layout` is an unstable option currently=
 [1], it
> cannot be used straightaway.

Yeah, we are trying to get that one stabilized -- upstream `rustfmt`
is aware and working on it. More context at:

  https://github.com/rust-lang/rustfmt/issues/6829
  https://github.com/Rust-for-Linux/linux/issues/398

> However, .rustfmt.toml already has a section of commented-out unstable op=
tions kept
> as a reference for when they stabilize. Would it make sense to add `#impo=
rts_layout =3D
> "Vertical"` there? If so, I can include it in v2.

That may be a bit confusing, because we still need to add the `//`
comments. And if you add them, then `rustfmt` will format properly,
i.e. you don't need the unstable option.

Put another way: the intended workflow is to add the `//` and then to
run `make ... rustfmt`.

I hope that clarifies!

Cheers,
Miguel
