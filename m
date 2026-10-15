Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42534AA3ED
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052946; cv=none; b=CLMdFFQFFJz7iMjrS/0ir314m5dh4LxLwaQbtJGGS5DKq1cLrNjdaLCGhzIYOd8WveMfrlIY7gT5WowuO8zoCLSQKg1apqJg2OxnHTp5gt0Jv7Rh/Wrtbq5n6bHVqnPZg2x4TaFnb7Ic4oF4tq9UyDZM0IN+auA70gmGMHhDjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052946; c=relaxed/simple;
	bh=UclMXT5dgaXzi8d+Et2aQmWDjkQGmYQfEWHeAsuzHAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2+tq3j6V6eqJzt8LiK/WNICibKM6bdxKLNG/kU5W+YIwsPJdVAhUezQn5DTwZeE9G5pjdpKMgT43CGHxuyNXGaAuiiWVThg51CVGfbVKYaFOBVZSJo1A57R+1e5gFsjMUzDySzK7g0nk4Ko+xLrtKxJ7UG3aIxNayogekwplWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY/rY+h7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY/rY+h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723D71F000C9
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052945;
	bh=UclMXT5dgaXzi8d+Et2aQmWDjkQGmYQfEWHeAsuzHAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TY/rY+h7wanHSplyQ+Tnf4ZmmiL9+9t1MktcHS2ZZd7G7RWv76+z/hfd0CSY72vwO
	 Au/kiOm73Q08zNZzMK6Lg1fm7pvzSVyi/8r5pVoDrQNYOjjI+jubM7ju0PuCbbiPiW
	 vR++g1RQOAU7m94BIZ0c0xN4ykHod5RYdq1a9/D0OtgP9s5NMEkPI6jLMRI7Rr1gjk
	 JmHdx6tJ5WynTscSrTkZtIeZSwqBvBzyEB4SGd+A6ONpLD93/keqrd7seepJG6/6d7
	 gk8/v0mFNFsyfkPB18h2upZlBC/l2cDOLreae37JwZ2bSEAEj+jBf6YO8+Q2VRol8q
	 hisffRmRt3T0Q==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a7858d3a20so13594621fa.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 01:29:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLj4w7ZqfdV9wHEak4WpWEctnxg5fMe17sovrXyKnzUU/qXNe1CLedzpNer5LeX6uJRIWwz3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsomJ6aKeUvU7YL/lufrWNR0EXBVGKDuxO+4rtqawBM+ikvcp0
	Z6wiKIttsJb+zkErOSjkFJlQDQrj49m4/dGiR2NXbIIdN12qxM3rAC3HIwXlGCo8o7GqUC3HSaV
	P4BPByOuqvq5wN0bhe3YHQyd2SnQdhzk=
X-Received: by 2002:a05:651c:502:b0:3a6:6efb:a0e3 with SMTP id
 38308e7fff4ca-3a9c52544femr47372571fa.5.1792052943186; Thu, 15 Oct 2026
 01:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-3-1522662b6c53@oss.qualcomm.com>
 <CAD++jLnqCipTxkOhiwQhKFymOxu1HOTbHzLbNrGTOkCO33y8Vg@mail.gmail.com> <0cb8005e-964c-43e2-8e9d-4e955cf2ff90@oss.qualcomm.com>
In-Reply-To: <0cb8005e-964c-43e2-8e9d-4e955cf2ff90@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 10:28:50 +0200
X-Gmail-Original-Message-ID: <CAD++jLmA65GL4xxFNSHr-j=Xo2o3dNmEcKjpNEkECXb5bOX8TA@mail.gmail.com>
X-Gm-Features: AclHuK8sF_Rp3sPUvkXokg3OYjbIVxL6iVSLlt_kf3aFbP7rWfJnEWwj0w4dISM
Message-ID: <CAD++jLmA65GL4xxFNSHr-j=Xo2o3dNmEcKjpNEkECXb5bOX8TA@mail.gmail.com>
Subject: Re: [PATCH 3/5] pinctrl: qcom: Add gp_mn mux function for QCS8300,
 SA8775P and SC7280
To: Taniya Das <taniya.das@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:14=E2=80=AFAM Taniya Das <taniya.das@oss.qualcomm=
.com> wrote:

> > This looks all right and no-one is saying anything about it, should
> > I just apply this one patch to the pin control tree? It doesn't seem
> > to have any dependencies.
> >
> Linus Walleij, sorry for the late response. I will split the patches as
> per comments from Konrad.

In the meantime Bartosz has taken responsibility of
Qualcomm pin control patch collection and integration, so
check with him how he want to merge this, I think just some
separate patches for pin control would work fine.

Yours,
Linus Walleij
