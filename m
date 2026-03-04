Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C41C84AB
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617754; cv=none; b=uIaUQXN4LIAzogcoftTYZhcGix7rquQYLetwehwdTumiUKfmmGxl0AY8PNVFIDX3UlWH1y0574i45LTNNbmhc4L0HCmOIOx3rvPM8JgnrUCodukMt8L7W9FbkO9Le+f6tGZp84VM0OhnE6XHJ+Sr5twW7tl8E9g/fERnw9hwwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617754; c=relaxed/simple;
	bh=yu3Ohj5106ejuArJ0T+/SYvwZDLiNDKZYAtfRj9AIuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiGl7S74xV5ADcq5Nvv5B0JQp0nzUSn8hyASpM/UvsznWELbPhY91GbGRrSY0GfdIt5SeWrb0fiVzB6M+wKB+d2MHxLuTqoE/gO3aE+7oKNhY3/ovCF32sVTcQon7xjIY61FZ6OxqrOVc5CjbyOqhb9K7sElcK/LkNz1vs9KTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoFzSPLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoFzSPLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE0AC2BCB1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772617754;
	bh=yu3Ohj5106ejuArJ0T+/SYvwZDLiNDKZYAtfRj9AIuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PoFzSPLZDU1yPTkitoUdCLIvZMReO4WU6KkFENlQGQ5KSAkC8BXiSnyss74+eSyYU
	 IAsB7bVSvsS0J71vPSsQpKbfqgzCDtOFTnpiHPVUMhlqWNcfVnnjg0kkniMJ2TtArl
	 GA6gg10RbXvjSa0zSMQ8zBoAZZLo8TAvQwe303poC2ZeYDWMnagBCo+pNDN9atMPuo
	 tJAorZla81hEtbM61a13auTIwNE+sfa1qla0C3fSPz0dm6fWEf9NHoUQS2iKSAPFxy
	 RK4Jgn+Gfij4O6QeipXbRg7O0GanoLNhLHJoskQYgNWLGWICbtRq9I0/c0sb7dzr/O
	 RHWFcAWZRvJJQ==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ae222d87dso6050114d50.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:49:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1qitmuJtv/EsSdRXdoJ0uCG9lFhB1rcwv4Ktm540gaxQOIbLM88j7YZ1UHoyO48EhOYK7BOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XnSWNslGX/4rieHzEa213ckGByuBmz5i/X7rq46LRw5kTyUH
	Ybas6HQsaBdzLzLLlYisAdfXGCol78s2tNpA2iP3l9ec3MapQrSiVeVJ50XObwLsHNWfA1heWHj
	asquHLPpFqDQWj5nHXKk9KvVMWKPk36M=
X-Received: by 2002:a05:690e:e8c:b0:64c:a1b9:ff9d with SMTP id
 956f58d0204a3-64cf9b5f174mr1114523d50.9.1772617753524; Wed, 04 Mar 2026
 01:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304084808.440955-1-xujialu@vimux.org> <4C2D1422EF70337D+20260304084808.440955-3-xujialu@vimux.org>
In-Reply-To: <4C2D1422EF70337D+20260304084808.440955-3-xujialu@vimux.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Mar 2026 10:49:02 +0100
X-Gmail-Original-Message-ID: <CAD++jLmWt0Z=Bb1z0BSwMY-1KDzF=HXR6zudWCzouWDQqdotVw@mail.gmail.com>
X-Gm-Features: AaiRm51UtuYv9UvdVNDDFXnK1E5LWVdQ5W4i_Q3gUoYOTbFETcfV_ORzij7CO8M
Message-ID: <CAD++jLmWt0Z=Bb1z0BSwMY-1KDzF=HXR6zudWCzouWDQqdotVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] nfc: nfcmrvl: convert to gpio descriptors
To: Jialu Xu <xujialu@vimux.org>
Cc: linux-gpio@vger.kernel.org, netdev@vger.kernel.org, brgl@kernel.org, 
	krzk@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jialu,

thanks for your patch!

On Wed, Mar 4, 2026 at 9:48=E2=80=AFAM Jialu Xu <xujialu@vimux.org> wrote:

> +               priv->config.reset_gpio =3D
> +                       devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_L=
OW);
(...)
> -       reset_n_io =3D of_get_named_gpio(node, "reset-n-io", 0);

This isn't gonna work, sadly. The property is named  "reset-n-io"
in the device tree, not "reset-gpios".

To handle this, add code to drivers/gpio/gpiolib-of.c in the
of_find_gpio_rename() function to make it pretend this
custom property is handled as "reset-gpios".

Yours,
Linus Walleij
