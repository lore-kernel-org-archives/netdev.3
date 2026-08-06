Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E5377AAF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038044; cv=none; b=Z87nbrdXLeK7zeqdcp+TKB6NQVBdkLcNgus00+EM6zJb/eNrPhasOZHFgUGuD4sH9hs185I8DnpsNucCaA6hs+1f7lOHx5+X+b/GPUCOFO5W70QXU5uKkxye8BqivCY5bzaP18wxeF9EJ0y7Q8UhS6vl+W/Ky+OfuPseGY/rwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038044; c=relaxed/simple;
	bh=trGClSl0pr/N9Uc/C8VxoOUzvPklFRvOAPQfs+5QAzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhzZPfmpcYUyP3aX9uys3lKLQ5c2q54HVRboH0+3bldIfaReh3erXLNmZea2lTl4kMoK0fu0I53wPhUbUoj3qDcW1oXRONgxOnLuuOmTg/pzWOj0fL3lOv60U6mQ6XGaeIztKCOf9qHSdgnh9GW6rZtpYse/wxOciMpX95GfMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KigZhT9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KigZhT9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6482D1F01558
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038043;
	bh=YONTwEGWeDAnnFSVnISdkri+5mtbbB3jPOrEWdeT+VI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KigZhT9dsGae/QweZyCm2Dl14EvfD8Pw9BC96xB0Jzk1qFEKmwOtWHI9HkPx6PUKC
	 mjoWnCeEL7EFsAldFJbwzU9vgi/fmwyy0TtSw8rTC5sPn78QGRVqTglCgCGmoLuDWx
	 KZGfAF+wAyYKPK4bRUhOdPRqu/yCuZmysFy5EBIaO53nyAswSBbyiOVhGQIYzCuuF8
	 FvWszXAgkPFCn90VdKtmgAEQmMWESwuoc3cVQcFRJ/90wZOQ/Wdo4C6t1SWRdMTRRj
	 SQMV62T+2ZtutMjkXR8LsINdB+N0+1wK4rrPcaaYpJXgbJgE+njwm2yoNQM3FA52zR
	 ZW1SsvY8gwcnA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so2178734e87.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:40:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrmw7YZHc28c3yitHKhltpOr9eExfOIeC6fNn6r4RwoPYSjB6kvbnP+x3OfOuL5mwz5BWmP9Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLauHIcUcMnDTmG6hW3LUl2enwuxUcK4hNIJKIkc7qyQRf3Mna
	YqCRiZcNB5gh7hIVR0ODgjMmYjQA6U15edqKPF6HXupOugGjDCAl3llY0jCi/fWrVjZEhX9HjS8
	A5exGz9FGmfrmxucAGi3iJqBeeHpyXD4=
X-Received: by 2002:a05:6512:3245:b0:5b0:1516:8799 with SMTP id
 2adb3069b0e04-5b2f4b912b5mr1941029e87.17.1786038041967; Thu, 06 Aug 2026
 10:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de> <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
 <anSj34TOZxYiG_ai@pengutronix.de> <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
 <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
In-Reply-To: <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 6 Aug 2026 19:40:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
X-Gm-Features: AUfX_mw_JClSshRtAVXJ5UI-A-nYn2DgoeLKeAN6F90L8UP_8UoY-cKvuiRzu7c
Message-ID: <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 5:56=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.d=
e> wrote:

[Andrew says]
> > static inline int __must_check clk_bulk_get_optional(struct device *dev=
,
> > static inline int __must_check devm_clk_bulk_get_optional(struct device=
 *dev,
> > static inline int __must_check devm_clk_bulk_get_optional_enable(struct=
 device *dev,
> >
> > If clk has them, maybe regulators should as well?
>
> clk and regulator have different interpretations of _optional
> when encountering a non-existent resource:
>
> clk_get                 return error
> clk_get_optional        return NULL
> regulator_get           return handle dummy regulator
> regulator_get_optional  return error code
>
> So devm_regulator_bulk_get() is already the "optional" variant, but it ca=
uses
> all existing users to get dummy supply warnings.

So is this a big problem? Does it cause any other issues than
dmesg noise?

Yours,
Linus Walleij
