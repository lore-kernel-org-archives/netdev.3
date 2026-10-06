Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855A175A9D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261096; cv=pass; b=HLKAurT/FR1Hy0YH+tLdrXINHM9wR6rLFGqrLHpSFpDnn0EjikZXim+oe/+p+Zxf8Qp8MX5wfCbEoGAPRJlKh5Z3MpD9VGqpfFi6X923E/sD6XNSUxulCI1yjwu0tncGfgcAM73tlbpCBHCRlGXgg99Im1+AVPN7Cd6UE7us19I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261096; c=relaxed/simple;
	bh=wxVRc83oCscpI1WYvPdLrZ7Jll6Ct/5vejKU7uOwMS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeEXDx2zoBdVfYaQ+ez67oRiqOgtezkQEle9musEgWlG/vrcQxtckk3Jb0ky+miUuIxToKJykCRhw/j02EMvfwZ8aO5KwLN/MgOV3MIeJkofEsWvtHv9965CjZG1WbVE9DOTJKGTVJl1sIhhclpFGRbfgERTuO246ucNT44Pnfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7UbHCSR; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7UbHCSR"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7bec5112765so1827023137.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261094; cv=none;
        d=google.com; s=arc-20260327;
        b=lGU8vgXsmmaKYggC2EQbHOOhyQZj+mRUAxpoib2nyBWWX3rW/WPyZWz+82xMEd2eTA
         izdEG6km82UQELfATQEvqPFMqor7sxXna5ubKoUvEzzNRuerrOukI6QI1Qbrcz+IsGFP
         t+r7OnisrhLz2sRWWnTqswcUE8UI/B6ecnaaNlM7gIFxrt5iGnoBXfpABAZiRyYhy3qX
         PAmYcR5HQBKvb1BpntsFxYyzK+T+YOwjNW/FKjG/nQ5H8v++F5BpVGkVyVOT6jE0os+h
         bftqBgdeD/grHYoebf4aCCHF34GRbZvdNAHZIHpoS9xK4SZ9XnxMbpTmrBaD0bBfbHbj
         lWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EG6JiiEhOg99Vjs6HW8VKbpmPJkOtJXYZ/aUNoaDYSo=;
        fh=RvdGrAmN15XPLQf8z3Bdbr+xn5PTTJPJIiJmJ9+2W/Q=;
        b=jYj0tJAgWJTSgTN/mYLM5ZGvRN/rrWc7ASyqTb9DXN/+lhTRG/muY1bwxgq92hga9c
         4D4h9FJRZQy0zj9mHA0GTD005wIE8CRQ7agmuDV2egIAo7Z7btNOUqYDyZOM/7XwtCs8
         s4MQHnk2vDQhGlpuDsZNrqwX1n+LNZ7v63k2pzgn7qDEVopD7bHbpb4EMubEjwR7GiHq
         o7UXEhWdF2b7IfJ0E/3s7A2MclHV5FPMBSBJyxK3SsEdtIjeK3K2PCbUajrLHlS8NpZc
         uzCJX8z7VZBgoy/ssZmEWqUt5Lz6Q4AC+H15nJDAyHZDapSroiV4RorfkH++uZ71A1VB
         scfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261094; x=1791865894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EG6JiiEhOg99Vjs6HW8VKbpmPJkOtJXYZ/aUNoaDYSo=;
        b=G7UbHCSRV61lU4qdxPezgYoy9ybIJUmmYwTrEzCPbQRp7HA+lkTau1i17I5zSEuNhM
         Z68S/SRSxAj7vWINXYK0bj8WPBoVfikwQpFHfPoMSKyRodk2SELR0gUJNwqP0kRnZQYB
         AXGzk3WVlA+8y6QKAbi1HMRcVTqgO8dO7oTQQkCLrQ3VmuCLDRADAKHh43Xnh6zpwU3a
         qIXpRIZMzM/uosNMGdx3NHmA1ePCtR/J3X/VjqTmEFL+RMWV40TaDmH75C5Vd/ch5z3Z
         6wvHx5b9QUWsYNuqsNV95bUwuBeCq5thUvVBWh1csKSTwuR8iiHZSUHM5Zb+ULk1H9kn
         Lofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261094; x=1791865894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EG6JiiEhOg99Vjs6HW8VKbpmPJkOtJXYZ/aUNoaDYSo=;
        b=WsuY85TGirYpxjcL4KcvO/gO3SVQ0yVn3rKDsomhU41PZxFmHOQR1oUNTtMPPIDGSn
         OTjyvQfb9hPGyOLMUcx/QvHQyo53j2T3EFeLYwd1t4cles4LgwJw20kM0IpgwBN9Xa3l
         /wfnf6h8HtNI7Q6Jyd0w8iHpAxdmsL3tCHaJ1vNCl0LFPvXw41hShGzJ+nLArtM5mh8B
         HplGFFAu2JxDYiibWW6Ailz8IJBrFwuRAi59tMk1JRHMn/1GTrBkuRdW63uLjqimthTZ
         N6RhxLKIv1risyb/zGNfBIqXN250u1zidWS3mAA/WpW5kvTqnQoiGafKDRdz5XI3pgEP
         AX7w==
X-Gm-Message-State: AFq9FYLpFPYGX81hu/X0e9gEbPV7/TkTb8LptfxTYDVpSpuWpbnUOBb1
	+y5ffUyMiRq7Zffawv6lvFZsTdByOixRo7sZCHJuF0Q8jV/GpG4/k/CR+OfKq6zeesnB/2YQfZs
	I6WhLwhCtL3eJ7ABkW90pSAASARjwPaA=
X-Gm-Gg: AYBFou2SvRh6YLmzAJ6F/e2pT1S/5HCjUb8pl01PS6R9e+kPdUpB3gcic5qh+kJb/Qu
	TUriRgHCzgIU67rDLHeDQmEBSqnwBrcxh0zzPS1lGskyEfHaXvoWbvh+d+PGNieMOo4nwwV5Rmb
	GTXhGRJTz8O4ucQQkTXAyHfDCHO0o8zUAuBGw5upGuvq6yJaPtW5LpIyQbC8tKc6syWc5VKwpOQ
	l80Ei2ZjDtHvhw3luqNuyRwb7OLUp9AvQO2I5IB5BfPzf+wnR5R8yqhAbtSsB+afygd+P6oRO1l
	3oN/S0c3rMjGhDL+DZ+snPt+br1jcSnVwOhe5dhb89JC8ohsCsCcUUjS5S0NHqbDBYbgVcl9IIZ
	qVY0u2pFKVeXhxAelcTtBcA5Q+AIHq22Z8xFhGtI1V/M25Ze7CxiD/QVDIi9LAZMVQC2ghjTxy6
	jPhgbomKqr2UMH2K1S/b8c8AhtO1L0DUdXUKCuhk+WR8Pt
X-Received: by 2002:a05:6102:5125:b0:7c3:7286:c291 with SMTP id
 ada2fe7eead31-7c87c2d1810mr25241137.19.1791261093704; Mon, 05 Oct 2026
 21:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com> <179082977927.31693.14994198839172125816@kernel.org>
In-Reply-To: <179082977927.31693.14994198839172125816@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:31:22 -0600
X-Gm-Features: AclHuK8pEKgTOuOpuPx6MWvpOl0xgJlv86gE-NJ5IR08oT4zG1HmfFicCuHsjnU
Message-ID: <CADvTj4oPo5oBxB0jx7E_T9mKHCbzx7E1TVQZ62F0HAP59BAvjw@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: leave the datapath running for
 normal-size MTU changes
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:43=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found by source review while working on the larger stmmac MTU/resume
recovery series, then split out as an independently useful fix.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The live AF_XDP pool corruption scenario was identified by inspection,
not reproduced on hardware.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The fast path was tested on Allwinner H616 hardware with sun8i EMAC1
and an AC300 PHY.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
