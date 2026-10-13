Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECD472F7D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887550; cv=none; b=HhQJirhf1vpY3emv/QfjnMHK3T5pk22rLAL2kY2QotOUD1QW36sVnuYPbILFt69VPLzpKiOLAbiELCvb0qHLbybyGBgExMwF5xCO3UHUa4P97cCEY2+orysMgz2Psukg0jMAKGMUCaB6m1ihi/9F4R2fLQtPSIDzbt/EQaIFAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887550; c=relaxed/simple;
	bh=VtktllvjbtSgq5BOhRgJ022ymOm4v3tR5dDr0y7Fl0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBYKXTnTFeEYW36KhL8sMqDvRzSKzJVbXRdsoSNdFwPN+SUhKVLBzIHz8UJpYDBaxgwczlAoZK+BCllvp47UMyKEBTyM1xlOw9zE2g0bxypr+2Gf8aMm4Y2K7iWi7cCTDGaSpME4TVus+BLwTNYVzkZ0FNjjG5La9qIGFjXMTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPOfgVo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPOfgVo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8198E1F000FF
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791887548;
	bh=VtktllvjbtSgq5BOhRgJ022ymOm4v3tR5dDr0y7Fl0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QPOfgVo1jLHKciL3TpUGgwTNjE3fE5wahnQ4v4vlFmfSTLFyis2uNbtImvWhwjNzW
	 DXPdNDYCZZCmOYnmEgrtC40EmvU6ALLTCH+Paj2mmKBg93E7JSRoYsbjFSTnyTjWNb
	 QNSSBFr1VDOCfFRgykVhibuxH+B+dnpV5D3ywluwhQYaKTB4BeRe0aawnt0xBl3sN6
	 PVdIX/HtPiri6KOOYykTVYQXZnsptsspH3P8ZLJkJ/weglJNEJjPVPpqzJcUCGeEi3
	 bFYeB0frRp14vMGJWjV5yB3bok9bRBBOnJmMD26wyTFWCwNzZWam1/NpB0iWc47VFA
	 ugFx1cEZs0tOA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6c1983dfaffso2082660eaf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:32:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx5Gi6xvrQ8qRVkjhJNMMzEuEb5azxfHVQcaK8Az7zpCMkKlSlNBTTfu4n/OXmp4guIGyk7ly4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjyJwijFStYHEzGoV9apuD+yvMZGADLJ+dBpmAXWcqhnSLoIFg
	i/1C0mNp0N14HutkicuIYv3me0Tp3cvEbPr4CQItW1WZxej40Q6Hz0zhqQdR/mypUsJtwgoDg/J
	L4L5pFusfAst+la9LYLIB0bw/mKHxaKE=
X-Received: by 2002:a05:6820:4b91:b0:6d9:f92f:5589 with SMTP id
 006d021491bc7-6ef0e5e6aeemr9767637eaf.47.1791887547790; Tue, 13 Oct 2026
 03:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010145106.773639-1-edumazet@kernel.org> <CAPa5EdAioOoMNj+kH8+Ko822tSyLJL-CxpXr3Q=ZWx0jwFNdOA@mail.gmail.com>
In-Reply-To: <CAPa5EdAioOoMNj+kH8+Ko822tSyLJL-CxpXr3Q=ZWx0jwFNdOA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 13 Oct 2026 12:32:16 +0200
X-Gmail-Original-Message-ID: <CAL4WiiotF1AC0biFb11Oe60eyab68jr06AZCPoW+d=4_eaLAKQ@mail.gmail.com>
X-Gm-Features: AclHuK8Mi_eEZre3qSg4v_oC-OSHho0rLrn9zCCHj8QarA9uUK5Z0-R3-dXUHXM
Message-ID: <CAL4WiiotF1AC0biFb11Oe60eyab68jr06AZCPoW+d=4_eaLAKQ@mail.gmail.com>
Subject: Re: [PATCH net v3] vlan: restore HW VLAN tag insertion with
 reorder_hdr off
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Stefan Agner <stefan@agner.ch>, hitchin999 <hitchin999@users.noreply.github.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 12 oct. 2026 =C3=A0 14:11, Jan =C4=8Cerm=C3=A1k <sairon@sairon.cz> =
a =C3=A9crit :
>
> Hi Eric,
>
> as I wrote in [1], the bug also affected cards using the r8152 driver,
> so I used that in my setup for testing.
>
> I applied this patch to v6.18.54, which was previously used as base
> for testing, and I confirm the issue is gone, and the VLAN interface
> can be normally used. On vanilla v6.18.54 toggling reorder_hdr to off
> triggered the issue (even when the VLAN was created with it enabled),
> so this step was enough to verify the regression is mitigated
> kernel-side, so:
>
> Tested-by: Jan =C4=8Cerm=C3=A1k <sairon@sairon.cz>
>
> Previous v2 of the patch was confirmed to fix the issue with r8169 as
> well by hitchin999 in [2].
>
> Thanks for looking into that!
>
> Cheers,
> Jan
>
> [1] https://lore.kernel.org/netdev/CAPa5EdD7tFRyDztEanTwQXTzVEE8T0FLkbXAt=
WxUcGGaLYt_bA@mail.gmail.com/
> [2] https://github.com/home-assistant/operating-system/issues/5019#issuec=
omment-6065756866

Unfortunately netpoll was in the way, a v4 is needed.

https://sashiko.dev/#/patchset/20261010145106.773639-1-edumazet%40kernel.or=
g

pw-bot: cr

Thanks.
