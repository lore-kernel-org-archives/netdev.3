Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CF3FD120
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373473; cv=none; b=f+5MUyWGoyQT2k9Z+fQ10MCEu3rNEWe+gxZ3COh4s2XElvNy7Dn9RCG95T++df/3amQQyQ7tVDW1lEsZ+7QvZEYEqsFEfnxM/J4o2WqJYZDKxCKwVlXG7ySJJDP0FkGMCt8D7evEwzh7DfvZqSn62/IMa1Tvzz7ibX3m+sZkxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373473; c=relaxed/simple;
	bh=0HutzdFNa0obdPVLGrfLNhx/g4CaTgRC5uNOdkJSmA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2ILcBAnXVjvw0SW3YS8LHFxpgMD4jVn4TnOUmsmotx4lAcAbWc0cFLc37ZEVnLGeCxOFyc0MCwXxxWB/HkPhGbSdLOQYuSWGf4+/CgVsEALVpz7T6hM9ydAUfCl48bpWKboK8AudIbX6QEv7VMjEDL+GuKUA37h/UXoAl7zLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkZpK3Kd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkZpK3Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478E1C2BCC9
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373473;
	bh=0HutzdFNa0obdPVLGrfLNhx/g4CaTgRC5uNOdkJSmA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dkZpK3KdiKZfm1LFxn5n1JF6HjQlDUahfC2FKTP7JpUO6sJSbCjgRxwKtFZlP6eUJ
	 FyM7ZUCSWAFcRK/JblqOih0Sj5T1exzFu4DiREsWuOfeVh6Qj4MxK6wr5C9J5JXIdC
	 ZlB/Q2GRLA3+qKIht+MIisszHOyrgax3YBrPa1lT4HGd54N0PSTEbTt1OPzrg0j/eq
	 D+ZQ4qTlrOZ01PG1MjVcEqIAMnKL1WIa5ghn7Lsee32GfOZ9zohpIelEWjCDyNjf82
	 GlTV2z5LHP19uh8u2G0mDuhEN4p8k0rd1hfIvDg7jiarivOH+sVtKvqK1TlTN1kkcN
	 PHvldzmRhafyw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a01c80c34so110090531fa.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:51:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/CLmnD1ZRTD3sDpXUahqxx+7PW/4wpIm9zpOjqm+eofgok3UiQcTl4KCp2h2UUBljwU1VxRTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybC4Z6X/9xdpQDLAYWN2Ag18SUb2aZ1nKmyYR5V/HN8SfdHAA6
	MpekkNFnyCKOrH58CNI/0uSCNRtSZKlFP4Alnphs2dhURpnv4SYd2zxE3bQhaIetI4Bs2Ee17vQ
	433FfAAq2+HRDOqq21Yz0AE568GBbv9M=
X-Received: by 2002:a05:651c:3252:b0:38e:cab9:365c with SMTP id
 38308e7fff4ca-39240b34918mr8858931fa.0.1777373471941; Tue, 28 Apr 2026
 03:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-nord-tlmm-v2-0-ade8e0f3d803@oss.qualcomm.com> <20260427-nord-tlmm-v2-2-ade8e0f3d803@oss.qualcomm.com>
In-Reply-To: <20260427-nord-tlmm-v2-2-ade8e0f3d803@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 28 Apr 2026 12:50:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLmk2o+i4uqwsv9Pb5ABqnt9584gnmZLosNkLmx1YtsN2A@mail.gmail.com>
X-Gm-Features: AVHnY4IhvQMDEYW8EoPHVxBDI4gshdKsR1xp_fkpIh4_xsz5sgNJU3TihctEl8s
Message-ID: <CAD++jLmk2o+i4uqwsv9Pb5ABqnt9584gnmZLosNkLmx1YtsN2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: add the TLMM driver for the Nord platforms
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Shawn Guo <shengchao.guo@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

thanks for your patch!

On Mon, Apr 27, 2026 at 4:00=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> +config PINCTRL_NORD
> +       tristate "Qualcomm Technologies Inc NORD (SA8797p) pin controller=
 driver"

Krzysztof just tidied up all of these strings, this should now say:

tristate "Qualcomm NORD (SA8797p) pin controller driver"

or something.

Yours,
Linus Walleij
