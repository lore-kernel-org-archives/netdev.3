Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860E347C6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380126; cv=pass; b=EiLu+TPd8ZtudNc67Rohyw6pAL4HqyI2ot9W1wxRtFFoW/fLwHfBcjDts7v61UoDGqQ6k8+f3MMJC8mGVKX7CieYxZ+YeAgwKbApemmeqrkAhu17Re4VNfLGEZyRMRSKEoDEI+JL59s/TQsl9Wzus5OoOvEjX3X2V3pCxixRC9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380126; c=relaxed/simple;
	bh=XCCBIJhL1uiHwfrbhW2jplxuax2K8XniIo9zDCZF6dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO4Y32mQvdu/YA6Qixxsh/LAODF2gSFM7RyD2NP++AFe+zoARI4g09VoBQpOcL6i/pw1LJkeQrZYogyGKpuTPtrnME95lHTa2N7aEgNbY4XF+rd4/tpAXAjT/jYI39bPnl5ZdWD05hlyy63zMh4iBkcGCpj+W1nyCiulKnnlPo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFrNLFgH; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFrNLFgH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c34bff61551so220194266b.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792380123; cv=none;
        d=google.com; s=arc-20260327;
        b=g7bqdtTyfZPZ+v3ujlfF7Cp+w/fXE46xJvlQKeEDoTcm/xegYRz+nTOQ9Llf7HoqK0
         PI72RCuljDb4ludjwseZFF/cI9o/MQZtiRkpFPprYyPWNi9P6cRkiBoioa7ZzmWuqsxP
         SYmSFVM259UN9k8IvdtWZ9vpweK+rz4hYtSTLJWmJRRgeAgA0wCW1QxQwBi5hqEOklrr
         X8sHQ8C0h+qiazyBB9kkJOYnIt/ZTx5iHNfDp4uLaDSrHY+0HXsqDwQa032ig1bC5Shf
         2I8WQTazs8MzHMkk6O4bTW30O2cXHNfskIvAWqMbFL2WCJL7L0vkdUngaz8sO6W7mDct
         8zXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XCCBIJhL1uiHwfrbhW2jplxuax2K8XniIo9zDCZF6dI=;
        fh=MIjQ7J0Rr/iX56ttygi2AfcvAdgE/Jpvt+MB86iLBec=;
        b=FPvbMOrMw+cSVMoAml72+qDyhA2qSJmJp6Yv+SuzjSLu3seZckkcSIGW8XAsEV+6Ov
         qnQKWYJSED7CPSHRWolq7kclIU3gNAPDfkbH6A8/xcNPYEXyFck+Bc/eYW3cm10gLoWR
         4IgjW5oNDRVXTKk5jKrt2Mqvnt8lH4BU0gqaDYyoCiH+gWaovjjVEX3mRL28yEPkhEs/
         kPVcokO/IbL/LkuHiQ1Xf/PAzzpiqOzEp6AHDLl3yADi4vceCYIddVEvuCxQqIheu/Sb
         qrYam6XHfFAcBZg9moDk8q3yFGc657gt2mA4kAnGwbtaElXUltLIGhHkI/LydgR+H0Be
         ecDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380123; x=1792984923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XCCBIJhL1uiHwfrbhW2jplxuax2K8XniIo9zDCZF6dI=;
        b=mFrNLFgH7XOF2H70ozU+iHmwLhwox/7BjOzypZK33n1y4pdmh5Zo32FnaAADE9K0RE
         XPblvdqMW5ULR8ufPu1bZvD1orXFNCauzp67pAEaOB0ej0teBiWJfS72oI7cjh9OzwPt
         YE0Pz1/v1MrzN853bRRQlRhRKeTA9h1hcNwg5Qvk2r99ObQcAZies0JEtxXz4uxr+bvq
         gmmLNUz1JLoByvt2ZmvwlAt38812O7VxnZntiOmvubScL32ITr/FTBzgJXANUEhDC6Ez
         5syZbzngfLmZChtnjqLuf5gsxdvTArDNMlRNkKY5XXCvYPPchPWPNSyeJtdEEWbTAyiZ
         KlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380123; x=1792984923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCCBIJhL1uiHwfrbhW2jplxuax2K8XniIo9zDCZF6dI=;
        b=pyV/i2SBKnA3OuYQHe6OzAxc4UtgRbyBC1tOg1o7YVZ7zJ4UE5HFOIp6zSfKWSp4FU
         rnCkB2YZW1SBzRX8MCEqUnVEfOoiECQ/NRwvwQ6ctWETwzD3e7w5cgMZClWcFgXOjX6b
         nm/tJ+sAU8Cwp+1Sz1h4pJRDVRiR4uwoiqP0URu888TZ6xeJFVje7BZrjWk9scUuSjst
         e2M82LEZbidhgxDTb99PA14h/OP+5MPwY5BYYTFLD/xjk+ekDehzN8VQS4QxkaCAoKcn
         +TxqLCG/x8n0Lp9Q0ov6weWa6fsAJV2oHs6qAKZzicIcjuC27UdQurXtEN+sV6yu4YPN
         yUzA==
X-Forwarded-Encrypted: i=1; AKwUvBxY04PAdgp2DvGCSSj02sVJQwvbDyzFiFe1X7EkhEJqgBFOuft9lpfOwjLqiQxM6B7cZHCSlHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRKsNUVwJW4Qgk9owKWxIIVh2NWo6KMZgl7rs5dgE4w04IXtIu
	BypDkfsmZ7HQNWKyIeapwVUIo1gKxyh9cQoJZO8ED9O6B+Ak7nsk9fhTRxvquU5EFFd8VomkOgc
	Vvq7fvgisRAu6AcVGCL3x3lOblG8vQfk=
X-Gm-Gg: AYBFou14awec8PC1d/XssyCj04qwSPQFxhOsKsPBqz+58BO83B3GUeg415eKkkHY9x8
	jsRpNZvG3dRdFtvLjL6aK+m/ssvBZQiloRX8Jx/rIauT2JABPLBgIjlD015uIx/e56LlBp5izlc
	daMmhi9ZBHbVy0fO7+BBbxatDoQNjSnG0Ec/P6D3YVIRSNlD9UrTewUi+OyqUD96RN+bdpbaekf
	r0Y+SD86I5owGIFp8uwjT2tkBZyK038q4Jxl0mraqBiXAziE4W9Z88QKiWqB3YQSJme1a2pmRF4
	9B0hdtntRRBMinbKF6CFHKmAjI1WnABUWe7ZQdd1L6P1znTi4nsGm9/txoU9LrENah7zjk8MGSn
	ewPIAh6DvnqE=
X-Received: by 2002:a17:907:c604:10b0:c42:3a77:80e5 with SMTP id
 a640c23a62f3a-c423a7781d9mr195405966b.29.1792380123432; Sun, 18 Oct 2026
 20:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
 <20261002115850.962676-6-o.rempel@pengutronix.de> <CAD++jLmPfzi6FqF+xYFJoAjqz+Q9Ax9vhUp-MjUSFNTwOPAn4g@mail.gmail.com>
 <CAD++jLnYB2ec6yOF2so7W8kkq3PR-+c2kCscTSxPuGVC-L5G4Q@mail.gmail.com>
In-Reply-To: <CAD++jLnYB2ec6yOF2so7W8kkq3PR-+c2kCscTSxPuGVC-L5G4Q@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 00:21:50 -0300
X-Gm-Features: AclHuK8xO8XmxHG3i4cMn6U2H2agbXczak466E3kXFsr0E8C4_HvzBC2G-OG7dU
Message-ID: <CAJq09z4KZ6kpF+VCTiezEVO5QU0fmYfdLNwn0gR7sjo2mHXh1A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 5/8] net: dsa: realtek: rtl8365mb: store the
 egress queue count per chip
To: Linus Walleij <linusw@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Mon, Oct 5, 2026 at 5:10=E2=80=AFPM Linus Walleij <linusw@kernel.org> =
wrote:
> > On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutr=
onix.de> wrote:
> >
> > > Store the number of egress queues in the per-chip info structure and
> > > advertise it through ds->num_tx_queues, following the ksz driver
> > > (struct ksz_chip_data.num_tx_queues).
> > >
> > > The queue count is a per-chip hardware property, and this driver supp=
orts
> > > several chips of the rtl8367c family. All currently-supported chips e=
xpose
> > > eight queues, but keeping the count in chip_info lets the QoS code th=
at
> > > follows program the priority-to-queue map via the ieee8021q helpers f=
or
> > > whatever queue count a chip carries, so the 802.1Q collapse is correc=
t
> > > rather than hard-coded to eight.
> > >
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >
> > RTL8366RB has 8 queues so it's fine to keep this separate
> > per-subdriver.
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> I meant RTL8366RB has 6 queues. Hm maybe you rather want to
> store this in struct realtek_variant and have the core
> helper instead?

Hi Linus,

Right now, the common realtek core doesn't handle any queue or QoS
logic yet. In rtl8365mb, this property is primarily used internally by
the driver. Moving it to struct realtek_variant felt premature since
rtl8366rb doesn't implement this functionality yet. Unless we want to
refactor both drivers to share QoS helpers right now, keeping it
private to rtl8365mb's chip_info seems cleaner for this series. We can
always promote it to the variant when rtl8366rb gains similar support.

What do you think?

Best regards,

Luiz
