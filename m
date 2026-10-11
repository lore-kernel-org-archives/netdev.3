Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15322BD022
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791703234; cv=pass; b=bXrVib9HWkt07a9AlEDZyfdmwByQPGDqA0NQsJjemqA2mVp7b053QhzK706w1lPUoay7O4QoOYm4Mh5FVxIo2PjvSmAinQ3CluTI87nh7FNDSg+qQfHVmvtdC6LEMBHtE3whq/Y8/+w03bI3d/jn53DuW3xzOe2g5b6xpoJrevE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791703234; c=relaxed/simple;
	bh=8KOKIwaDjvb2cYDxEoE6i5g/eeyXWfmuX1STLiv97yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mD9DoRaSMrE7tz7KvEnNPPurpWjTWoVHBYemo68hSXU2bQwC4TFpMQWMbd5Cxjd8EW6P12w1qqNluMVSo/Tc0oymSGdQ5PUIne3wmkxWOCOM1Y8rVs/twU4mYWvFnCLd+7HS9oZmPxv0tMY7PnDUUaheY8DNzwZ2EnY/AQpOLKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=sxXtctnu; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="sxXtctnu"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b63bd2030so15377356d6.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 00:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791703231; cv=none;
        d=google.com; s=arc-20260327;
        b=SmQPcOESUdDeWVWdxonpD44KlgHdZlfH867X9iEd7EcfSoXNP59QFCp1W8j1T0Di4b
         wKpSRHhdLAV5UmQ4S/m7hWid8yAwrfSmbrHZeHejxLagJsq8VM2AuSRlx1csbNJrhI+v
         cpeHOlXknU2/uBgdvRNk/8iE88Dy+Elt28f9Gdkr2gTMSuoxP/l6XKE5FTSm5yy4qsD1
         S9llOu/0EW8Kov8HWpGRZTpi8C4J8QBKHDFF3AtbT6QPVqAqWifYQHOcxt2xOjUuuF2h
         uKOhuoMJwLw5K7uzOMvGPWRP56qGW87+nlqYm/wyilYrD1FCy+QgqI0Q3jXHhGY3/nWN
         Um9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8KOKIwaDjvb2cYDxEoE6i5g/eeyXWfmuX1STLiv97yY=;
        fh=Bp93nmmQUbRa4nlqbs7EyFxet890CZDEWeMUJl95O/U=;
        b=qwilJXa2QtlxiKlEVIodhtQi6uHua9QWm0A/A3esVv4RdY4+dHWxptEyRDYEle69C5
         9/jIeW8UXZ20FAWJZTyiI6oAt+Yx7hNXZ727KXJZbjXT67TPKme/i6imnXvzUJU/zoS/
         lo0HJxtNBd3ixoSgh71eBBssRSe7geZrT6mgG6EZrvOZT3tqlqcMPC6fSSosvzjt8loZ
         mhxyYWs/6NG/9N3tLTcSDfiSdZxVvXYYpzAIrmN/NGWjqUh7V7z2lvU3yo/Os1Mxa8FR
         m4odKK/jHjvQGDiYgqiWFZowi/tYLeY6elMU2CL+KzRp5Hmwz0dYu4qfdWLW+Ss85f5y
         7khA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791703231; x=1792308031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8KOKIwaDjvb2cYDxEoE6i5g/eeyXWfmuX1STLiv97yY=;
        b=sxXtctnuF0KW8c9lkta/dvV10ZVXoLbzP5Y/uMAEDtmPPnRg1iAI8FeSxXxhKVHQRd
         ZJ9eoCL6ExkZ1I5eI8dS/8f0+LtMq/uujSs8zJrifl6bNdFd/HmvLIMKSZr+6YoVPveu
         pTfJSh80QCwM15GtuaxHMB94w9cKJ+f5Ab4HLP1vgLGmsnOJXDnLA9QGt2zGE9eU4IeO
         w9h6jAd14i9v9p14Ii/LMlJFnGbbR2tVArHhHhiE8crLN6aknmFmVlSLdLWVT9b9z6uo
         BI5YzDpHqRwqzg4prsMGgzKmOhmIVNTYbth4whp+EgvFZsryWxkSJFcopn9hWTB7IlrK
         nnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791703231; x=1792308031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KOKIwaDjvb2cYDxEoE6i5g/eeyXWfmuX1STLiv97yY=;
        b=wlFG5A82Ls5Nd8kQ6f555KEE1rdjMyCe8kcf9TPKFZt8vP0Kw+hgPEuH+XdtkZ60vR
         OZA/UKgCKvt0MQr1Q6X9DBYOgmMkkXFt/BYQ0GsugiXSo8RJExstS27G6NqT7iI3X3qL
         pwpgFtLlQryhM1EBkEw3EXw4i/gdhKo8TvA0i8/URN/zBkwXAHHgSYyzO6MXditHoj/b
         gwvmZIdxBwHCkBZ9y8Oa49hFSA6AMaUu4VovNPrnYY6RMtqdLNvYi2EOAe/Zw3Gs43G8
         6tdBCQwE8d8DLWkoD6jFiwZo8BNX/q3X54oviSA9hq3aqgnnYqmP3EZPzo58wURruUVT
         SDTQ==
X-Forwarded-Encrypted: i=1; AKwUvBz63gQLEKFhiiM7I1Lsa+aRa72Eap9IUiuNF43LTCeT0PDcgtaPb0rbLib+y+qJAhHfBxEbH0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/3xUWX8SqjAVvlaQaZdEWw2OTCzBDRl5QtSqlV+PQzFbj4rq/
	kI/L6bwQfuckJMJCc+MFDGCMQ6ySTQKS1EHfoMGs4Mmg1FgZY1My7L99iwywoFujE5UQHqTkEiL
	hhsLb2WFb+XRZT2tSWJC5qLLNPBt/xC3IYSsKFab0
X-Gm-Gg: AYBFou1C+hdJhej5Uqza3nEBxwt+2W5azYels7oHNov9Ab+C5mx/czyXmrl1yvJyf6l
	oLr6jKyhsetcFqDMNuNYVyuARa597tHXy2WBloYJiLWldqsf9OO4Wg1XweDrx4WXbQ/8FWjTN2q
	XaJF5T4hXYmx8Scc3bcmig/BBioBOs9+VZgcWcD5/EKDiameGxqsY47A/iY9xTMZs8TtGRWPZIl
	zcKsra2fWhepH9xFezRZ0HzC39WGvSWAnHplEiiofyjbHJwh3KraG1HkLjDjUs5uv7SwlT5iKC5
	awK1DHIqu7RLe/uRObJhQ6ZhJ6NltLlAecgwpD7bywoscpjB+SG6XpA=
X-Received: by 2002:a05:6214:3209:b0:917:9ec0:f0fb with SMTP id
 6a1803df08f44-91b5e019a01mr109533446d6.24.1791703231532; Sun, 11 Oct 2026
 00:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com> <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
In-Reply-To: <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
From: James Clark <jjc@jclark.com>
Date: Sun, 11 Oct 2026 14:20:20 +0700
X-Gm-Features: AclHuK9Ocwt7HcU-vYQEwbBPDKcgav2cMdh95NRnUvL2pDHuZe7MJXWz9dxj8UI
Message-ID: <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Doug Berger <opendmb@gmail.com>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 10:18=E2=80=AFPM Nicolai Buchwitz <nb@tipi-net.de> =
wrote:
> I dug a bit deeper on a CM4: AFAIU the MDC runs off the GISB clock,
> which the firmware sets to 200 MHz (CPRMAN 0x1d8, PLLD_PER 750 MHz /
> 3.75). Bumping that divider to 4.0 at runtime moves the MDIO busy time
> by exactly the same ratio, so that's the one. The 250 MHz you have in
> mind is genet250 / genet125, the RGMII side, a different generator.
>
> So instead of a fixed clock or a compatible match this could just be
> BCM2711_CLOCK_GISB in clk-bcm2835 (critical, firmware owns it) and
> clocks =3D <&clocks BCM2711_CLOCK_GISB> on the mdio node. I can send that
> if it helps.

Thank you very much for looking into this. I think this would solve
the problem from my end.

Let me just confirm how I would need to adapt my patch with that fix:
in the pdata branch of the probe, I would call devm_clk_get_optional
to find the clock on the mdio node, falling back to pdata->clk. I
would still add the chip-specific compatible string because the number
of MDC periods has only been measured on that specific hardware.

James
