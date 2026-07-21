Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9FE42A17E
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619953; cv=none; b=RmHY6mYzDw30DoMWXowuRltK5E80qqjpAcp3AHV+7leHoYA//xXkGopJSGEWkMVarzu/HW4rC4eUojbRtbZqUjct7fQSOL55hNTIweSIeCS7Hfa4xzlb0Zz2fCa86iR2cHl2RWCrg2dafqp1mUXKTJFs4fRoBz7vOvbL1/Y+BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619953; c=relaxed/simple;
	bh=okTMrHZiP0sVY1prxXrRl26i6JyH7ulay0Mr3CLRG44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxU+gS+3B86EV/qkRN4ryEVDfbqgxWG+vs0gy2kRuAaBiOaDJC5ClqlTrWdkWzCCHl8Z1/B6A9e26mHAjwYt+0EtIrzIUhAeFmFVPmfu5x5A/G8CIHp9fFVGceF7VA5kXr0ztbDSIooesME53IypLXl2T0rM6l2sGTKyzH1dv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojz3AsS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojz3AsS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DFB1F00ACA
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619952;
	bh=okTMrHZiP0sVY1prxXrRl26i6JyH7ulay0Mr3CLRG44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ojz3AsS3yLTPkRMTWCGx3vLCWNJy+520RCn2Hza8D9RWBnYJbEh8KKU7q6b9KxNCG
	 FHzBMRNMV2NDCrmrXTMAIDh9ZXTD4JaCCfqPRiKYxkEDYlZJ79HsJH6w5Bvcqa2j35
	 /omhQr4tItO8u+8wN+5vTIlZd3EYh61tK8e/CZ7sLleetWTivG2suhIYaIlSpCEyp/
	 SsGRsiKsxsfU9dORzY9BMmR9Smd6yYuNmJF6wGZiHD3krGX8TLAD12v9/uNGZZx5WY
	 CmCGVYzGk8bqrjiboPfGsdBPU1t+QrGnJhA7IwQNzCgVmInxUhn16Zd6G1KqYYHiea
	 YWW+3gTKLQsVQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2a44a3b66so785343e87.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:45:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpGnMzup4R3Umz4xyOf5IAATw1lUrhFAsCvMnMUPhCPB7YkjFxeJs8SObPSAPMd2SXdrXbvl/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTdjQGuOVFkV2BdR+bQf2hvNTWugQuB7q/JqzIJHprEtwt3At
	OSoIi+OfgF5s5irnPCwy/U5/yXgvSb7abXn5BSIsxcEibYyIKuNGmZCiNyInHRCG254TIZgiNqK
	exfwN6Wq6EkRaGz7ho99dCJBzZQsuIvc=
X-Received: by 2002:a05:6512:611:10b0:5ae:bbe4:f4b9 with SMTP id
 2adb3069b0e04-5b28f9aead9mr2079075e87.55.1784619950751; Tue, 21 Jul 2026
 00:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721052859.171341-1-manikandan.m@microchip.com> <20260721052859.171341-3-manikandan.m@microchip.com>
In-Reply-To: <20260721052859.171341-3-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 21 Jul 2026 09:45:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLkjY8hwGE9nNnDpuapVyTf-cBJhyZA8B9PE7U-CWmkyjw@mail.gmail.com>
X-Gm-Features: AUfX_mz_2Va_62Eq0-JUpFBlFm9mhUwZ4GUXlXtPLrXevxSFmqeo3xMHXg5EG2Q
Message-ID: <CAD++jLkjY8hwGE9nNnDpuapVyTf-cBJhyZA8B9PE7U-CWmkyjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: nvmem: layouts: add Microchip/SST
 SFDP EUI layout
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, richardcochran@gmail.com, 
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:29=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Add a binding for the NVMEM layout that exposes the factory-programmed
> EUI-48 identifier from the Microchip/SST vendor-specific SFDP parameter
> table (e.g. SST26VF064BEUI) as a "mac-address" NVMEM cell, and reference
> it from nvmem-layout.yaml.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

I like it!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
