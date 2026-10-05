Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F747CA7A
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213022; cv=none; b=AywTQ5CKRmTETwMcjgwXamlZdq8WKbSnYUycwgzpAiAEuGbA1qoNAGs/iNGuiU2YfzGQlH3S0gD116zgGjOGSQgMwDGY4fJIgJAepNBrdNh2cHmZVRd9bYrR8Zf1Sjs0APbx/cwo/9duzGSIrZGoMdiluDrIUuEle3zRe4v1xX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213022; c=relaxed/simple;
	bh=gev7auu+aw/YQA7TNPVeEJbyu+lsrNIp9hNBwxyb5AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okHyKFw6MeIWdcNosP4i85uupNgUBRC6IUsStIvRgcaxW4EtNCLvqTTAzghxhV8JuojZOSl5BedOB6SRxPegP5vCc+0pRUzjTYiPykhYkO1vGT3P74GsKPcFTA5RVH14Xz94BOMYbK6RamMZiXtEcqaBnJozfglFtMEeH7FLZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioX8EJhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioX8EJhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FD31F00899
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213021;
	bh=gev7auu+aw/YQA7TNPVeEJbyu+lsrNIp9hNBwxyb5AU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ioX8EJhfGsYN+iP068pf7EP97cF00LYOixV+m/nYt+4W5foFH314gP6X2rgqBUN7K
	 tzPmSp72NC+MNYcs73Np/hnSKtETrCWmq1ZMwm14FQXF5RS/DVuCe+ANPO9F2N7Q8u
	 Z0+i8k0ukeV/fDuSDoUvZ4YQieAm4tagIaFMkQVaE6hJpfehyXjuZOp/HKYdRhUm+N
	 B2FUtyQcfkKnbadeYAqriqQmfnN8sLwVNnNB+XhPYm/OGP3vAPk11i4q3P+s0RtTgZ
	 5ZlrNXwPzDNnQcNZHW4FPgTnxNqd/hEpSizHCzuQsAYlNrqaTohL5khO+tU+mN2WbT
	 XW4d1uY3V5stw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso397253e87.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:10:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwndOQqrbbTRFz6xYo3RdXA5Y1WLHlGEZsqvXyzVw1In72MzZyU5S2EyzbFYyt04MQuGLwkaKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjOjPIi2gPBRUD2S27E4WOyCpk3LLwlHb3dhixSHIpFiusrCtj
	ANHEvkD1O+iXcvzInHZIU8bINIQQrHfsbaLJZdfcr8trR+fIUabm4dRnMa5kPUAVCzrDmd+ulp9
	pCZD7JPIxxPYIoMSjxOStT87GS5QfAjs=
X-Received: by 2002:ac2:491b:0:b0:5b8:f1d6:554c with SMTP id
 2adb3069b0e04-5ba433daf8fmr3753483e87.12.1791213019980; Mon, 05 Oct 2026
 08:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-6-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-6-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 17:10:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLmPfzi6FqF+xYFJoAjqz+Q9Ax9vhUp-MjUSFNTwOPAn4g@mail.gmail.com>
X-Gm-Features: AclHuK9Pg3c-oYh2HKgVdRpYduwapzKYodOXTDiZwF98bn_mDcLJda40qqY4Inc
Message-ID: <CAD++jLmPfzi6FqF+xYFJoAjqz+Q9Ax9vhUp-MjUSFNTwOPAn4g@mail.gmail.com>
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

On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:

> Store the number of egress queues in the per-chip info structure and
> advertise it through ds->num_tx_queues, following the ksz driver
> (struct ksz_chip_data.num_tx_queues).
>
> The queue count is a per-chip hardware property, and this driver supports
> several chips of the rtl8367c family. All currently-supported chips expos=
e
> eight queues, but keeping the count in chip_info lets the QoS code that
> follows program the priority-to-queue map via the ieee8021q helpers for
> whatever queue count a chip carries, so the 802.1Q collapse is correct
> rather than hard-coded to eight.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

RTL8366RB has 8 queues so it's fine to keep this separate
per-subdriver.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
