Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989F3845D8
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432998; cv=pass; b=Er4hcLhNhDCUgcFmXblsFF91yCASuYCpQmzy0uE/vqsjCYL8uA+mxWZPxi2TNhirkw1pQfEjQJOdDGe0uy8fN1C3EzVDjzLyv9Jy/uQtNdOxcRtWga2W++EZQmq+ZukgTZy1mEc3LFJtzc7HaKxS9HiS0JqsOxx35jdRNUdqGzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432998; c=relaxed/simple;
	bh=yHbrcN2txt2k4QTXQtVEbYyaJnkVhYsYaFz+JtTpWtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKbz3pXkeYe4y5UEPn2xQZ+KmkVMjeIG6iB8z97k9t6aKs5J7s5a6MTXUXJM9C9HDb+Rckz1uHnbr7lltRLsHAsOaNwYr2RPX56ADmdKQcba9N4TyPvDhWVOKuxlyhO7I3yrMHMrm2OE8h0jreIeV1XoZdFj7MfdmtlGembjPMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3Fn9pi/; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3Fn9pi/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so2738866a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786432995; cv=none;
        d=google.com; s=arc-20260327;
        b=hcMDv0h5gjLIg6q3WncFnPVhw0ZNf6e9Nu1ROWUCdSdQBv4L9Ml6z3Ju+sF1P0hLVh
         8bSKc5hijj1SkW+BDO8/T335XW1MIUClH0tr0XEneCS3hxAkSVF5kgUab+mfGzNCBT+B
         N6prkWBUyvCGgQNEz01S+t2xelXT5Qj9C5Drhok/pUYvz+QjMGGQ6gOxUxboctQZPPBL
         nBlPhfzKa0AfPGrsYdGcbd8CiYIVkvum44OWQfeuDSCtcR+kiqTuz5QbwBhmOj+tVFKl
         f0KK6CQTorPeE8ye9dNH1CCr0f+TyUxLUtwHVi7X8Gr2NA4rLj5fWxnTmHhXDoek1H5D
         OERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHbrcN2txt2k4QTXQtVEbYyaJnkVhYsYaFz+JtTpWtA=;
        fh=9r0GL0tj+kisXxUrOQgicCKyzTpTCo3vSlqa//hMNUE=;
        b=iafxr7aRKHKtfkoaSzwiS48H8jW2rvfpVgAR8hBDeHaURDnOrsev9E7H8dHw/xuEg7
         CwMfvk0NZ06PYNve/HxzW8ywpSr8RCKWpTzNBxETgPKcxxdYCJVL6DyCVEynSLcvJZdz
         tVKThmpsuSAG0oUHmjFg63ZxfXal/mpx3OoDkPLG0EcDAwFzwa/0TMfb2FqL/RsOpgdb
         79lZbTIMAE/TOpuygyrXhvNl5oR1jPu4wOUEFgF2dx6BRGUiZc+6r/CJDsRginP0pvJU
         Ul+YBj+azuoXvU+LTYeN8rZI8635cpEBOret1sYnUxS7HkX/kuFfB1dsCYm2OQFCIYQN
         6YGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786432995; x=1787037795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHbrcN2txt2k4QTXQtVEbYyaJnkVhYsYaFz+JtTpWtA=;
        b=S3Fn9pi/xHxf0BAwMKR3PAwztPIq41cQMCGb/ud1Cef8nlB4caD6k8gd6hpiHAo5Gn
         SSTWcBYBeIMO9wnaRH3um48p0umLgifMfAbxNbxqh9p+zpiRyOaZ4U0Q/EXUKnj7tQiM
         dionJRg+T+pvU+zopIBx0xgPdAM0JtaEufwU2FjHqG0Udsugccmw+CZysun0qTot+LoC
         7khNCm70zLMsED8ya6g07MThrrk1ZtfpuvX4MAQoKYYhIxq8Xk3prgs26V8rOwNmDmj0
         wvmWW/Tro0oGE1WDtMrbDGI9R+MGNFzB0SKGboKxOCS/Bq49dw9rZizn0EebkzKvnDvo
         EVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786432995; x=1787037795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHbrcN2txt2k4QTXQtVEbYyaJnkVhYsYaFz+JtTpWtA=;
        b=DTzfV3lIOKate23pu1rQ+dHLuoUyW2Dz0pbjK/rxtlkwLz1vH8dRZuh8Sh7aklNKvm
         usqQWioswuT76o2ePWPJauavLYWig51bxx5t37XaJPNiwxDn8ovd/1uJCoomIB1Yj0ZK
         77et4O20K3iQDb85xKxhKea3arwWRAsJEyGnIhMJZKIIckP39tSd/LIND5JZ3EXogGTS
         4OpWLz/pGH+fTGtKQo+PeNcyJLXapUlq+65EtFFkZSUeuRRGC46sZxPc1aQxktJ8j4Hi
         W0xZUSh8aMtmMV1Uf/ZLc83s3vuQpZsTmtYOkyWr4eI6YTZhniikvFvNQqdcbA6XYhJB
         c/5g==
X-Forwarded-Encrypted: i=1; AHgh+Rrme+w82lolMKwknPhQXxbn6VNamHkhDFaSSm8UAM70O+z8s7cGs/mFySV8CzdrZtbwJYMO/w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Vf7Lux3dvVvAR9uxh/R82DMUQWtEKOit3U0mNZGJt3rFdUdr
	HE4gwnpHOlwMFmNSuHcmNrpghAam7n4/6rLLklhDQGy1+ntiVUsCksu01dU1WZOJxagfawMG9F7
	vp4C+7qvtdLKU+WcstxfOube6c0KPv0w=
X-Gm-Gg: AR+sD11t7UQrCtnX8RCZZEyD38NBzkGOEFDw0txGxg5pE0QX2UXF6PACnzTIhHXapF3
	njUZYMO+UA9EHoceQ9tuDAKlYWfVGJlMJ10Qr8joVi4IBAVGoxchwWkyg04Bw7YZgKlLzGDShvh
	BseY1yM6S3BTV4aX6ttm8om9Xf7hBwqj1gU76UJ2aVK3glwVpxMzpp17Ax+ID/B/gguxjNvdgFs
	riBoyd+hDn3yZ4VEPBAv0ulen+kbe6qvvLe4sT0anfZvvRqGcR5nqDat7jgsPWlJvCvse7Y9q8k
	h6D+/Et9AD342g/SeCdOJ0iVdxVasSOjAtGsF1yTm2WpmVW9aLLX6RuATqTwC3r35jHyM19tERf
	B8/XHDAwVJG0NPymeQGnBKyBFSqsXIyc85KivBLh1MbYJ6+EvI4fQwFhayehi21HotitKYjLrYT
	dDEeCCQzLj5uwlFTwRb9hoGRr4bRziqkxBudG6eQ==
X-Received: by 2002:a05:6402:912:b0:6a0:9b04:bf76 with SMTP id
 4fb4d7f45d1cf-6a3645207b0mr709391a12.17.1786432994503; Tue, 11 Aug 2026
 00:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
 <20260809-submit-acx00-of-dynamic-v1-v5-1-bfa1f8518b28@gmail.com> <ec826a71-bf33-44cc-80e0-dfc7e92ceb61@kernel.org>
In-Reply-To: <ec826a71-bf33-44cc-80e0-dfc7e92ceb61@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 11 Aug 2026 01:23:01 -0600
X-Gm-Features: AUfX_mwSJJFbFSerCvy_IW10-8LHnrAWQBwEVxYFOtjInvRCI8z97kTvRuJC4Oc
Message-ID: <CADvTj4r==rKP4ThVZog51MQ2AVDLZNFwrPH+uDLFV2wGZueAtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/5] dt-bindings: mfd: x-powers: Add AC200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 1:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 09/08/2026 22:28, James Hilliard wrote:
> > The AC200 is an I2C-controlled mixed-signal companion IC containing
> > audio, video, RTC and Fast Ethernet PHY functions.
> >
> > Describe the parent device and its shared input clock. The Ethernet PHY
> > is represented by a PHY package on its MDIO bus, with a phandle back to
> > this device for access to the package control registers, so it does not
> > require an MFD child node. Function-specific supplies belong to their
> > consumer bindings rather than the shared parent.
> >
> > The input clock must run at 24 or 27 MHz when the Ethernet PHY is used,
> > matching the rates encoded by its documented clock selector.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
>
> I do not understand why MFD and net are combined. And nothing in top
> part of cover letter explains me that (which I asked already - any
> dependency or merging is THE MOST important information. Where do you
> put the most important information which maintainers should see
> immediately?)

The AC200 PHY control registers reside in the I2C-managed
multifunction device. The AC200 PHY backend therefore consumes
the regmap published by the AC200 MFD driver, while the AC300
backend accesses its control registers directly over MDIO.

The managed syscon registration change is used by the AC200 MFD
provider. The net driver itself uses the existing syscon lookup
interface, so there is no compile-time dependency from the net
patches on the new syscon API. There is, however, an unavoidable
runtime dependency for AC200 on its I2C provider. AC300 has no
such dependency.

> Bundling it together suggests this is somehow incomplete and later will
> be finished, which is wrong by itself. How to fix it - decouple
> dependencies.

Could you clarify whether you mean that the MFD and net changes
should be sent as separate submissions, or that the driver
interface should be redesigned so the net side has no dependency
on the AC200 MFD provider?

>
> Best regards,
> Krzysztof
