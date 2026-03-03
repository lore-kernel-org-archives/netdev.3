Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB2492501
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553311; cv=none; b=MflEfKLvMd3tQsGO88mNlO5WGC4ombVIFB5VJWVsP+VFBKLIe4EEdCrP9MdDvCfqe8GCDqTvsVw9K9v1OD3kTzj4htg+cJ63TJkm7B9xd3X5LJl4k5FGHmK6S0HVKBxBV2knKbzhd980LZmjMu3ScIx2wE+QVaPQcwaBW5IoCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553311; c=relaxed/simple;
	bh=7b8F1HaCkpN6fayVr7HNxwpvh017ORH7b3smsXK8+0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkhA9iZo32Qztb+2KRIOFHFTMVa5PMADxdwtBlPEswM3f6s/OV3m4lcYwjLV4OQjaWRdFexvj/opoguxY9aKqNbbwtcWdwOM8huCvHsXbB/e/ah8kOTzS4f5jsBhFE4gawPuoRCXkXT/Tdr7rbzc1Zj4kdKsVgEi5rCG/94LTh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=woXOvWDl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="woXOvWDl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EAF35C40FAF;
	Tue,  3 Mar 2026 15:55:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 374305FF29;
	Tue,  3 Mar 2026 15:55:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 823341036915A;
	Tue,  3 Mar 2026 16:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772553305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SH5CVKmEIbnVEu71258fPU3XMEnF0AcPei/4hXDNKko=;
	b=woXOvWDlKUBjnhuOi/e1OGikcft5vpeuygIsCNkvN1tsXPHf+Lfw/KgOnxveeki9Eoiyb9
	AKMH/InS9g+yX9oOEPzwV+iZWv2+NVAB+FExPvuoeksDdqIEqHIAokikSvLaT2qkqBWI4D
	TvQDeB/UcsKVIUwxnNTS6a9/NznBF30sGWDzhUm3WANLH/3QnC9h884Wg3frFDjVdiG1w6
	98MCuCeIkV8BJGqMcNSU/JfqPdDON0XhQq784puj/8x0f6f0KH3bVBPPrhAu06qMpOVayp
	YohGh713fBhUAj//3xNE4WCBimRQsQOpJUG5kp8gcNl7ZGVOdQsTKXD/35xdTA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: sfp: Describe and handle regulators
Date: Tue, 03 Mar 2026 16:54:56 +0100
Message-ID: <9586950.CDJkKcVGEf@fw-rgant>
In-Reply-To: <aab51KbpIq72wtSU@shell.armlinux.org.uk>
References:
 <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <aab51KbpIq72wtSU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3331196.5fSG56mABF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart3331196.5fSG56mABF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Date: Tue, 03 Mar 2026 16:54:56 +0100
Message-ID: <9586950.CDJkKcVGEf@fw-rgant>
In-Reply-To: <aab51KbpIq72wtSU@shell.armlinux.org.uk>
MIME-Version: 1.0

Hi Russell,

On Tuesday, 3 March 2026 16:10:12 CET Russell King (Oracle) wrote:
> On Tue, Mar 03, 2026 at 02:54:25PM +0100, Romain Gantois wrote:
> > Hi everyone,
> > 
> > This series describes regulators supplying the VccT and VccR pins of an
> > SFP
> > cage or soldered-down transceiver.
> > 
> > These regulators can then be turned on only when the SFP device is probed,
> > thus saving power on systems which only load SFP cage support at certain
> > times, or load SFP device descriptions via device tree overlays.
> > 
> > Please let me know what you think.
> 
> As ever, I don't want to be adding support for stuff into mainline
> which doesn't ever get used - historically, we've had a lot of that.
> So, any patch set which adds some kind of facility like this needs to
> be accompanied by a user of it.
> 

I understand, though I'm dealing with an out-of-tree board but I understand 
that this doesn't really count as a valid first use case.

> This is especially true in this case, because I want to see why you're
> wanting to have two regulators, when INF-8074 suggests that both VccT
> and VccR should be derived from the same supply. The reason the
> modules have separate supplies for the transmitter and receiver is
> because the host side has the supply filtering networks to ensure
> cross-talk between each is kept to a minimum.

Interesting, I wasn't aware of this. I thought it was something like "being 
able to shut down the transmitter side only while waiting for a WoL packet".

It seems like there won't be a v2 anyway but I just wanted to explain why I 
went with two regulators in the first place.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3331196.5fSG56mABF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmmnBFAACgkQKCYAIARz
eA4vBg/9E05YtpfuVD6K6O/qoRgoBV79Ne0/MmCdsIQGo39YkLlJOMkJdP6M3hkD
teYVSQdBdlF3+0gJv0JyzlV5o6yiIzGLVjKZ7GkS1CSXbn2CgUvw4Tuqdy+ExmAb
q8phnrFep3qUlxXbqXb8lVW0++JBx8ci+fyxCUO7SvWkXM7TlgfFNb3DkuHwlpO+
NqzxBDZ5/i+4JjEMhESlGV+YEVKToeUcIrhSBVnskQbBnPNaepJWVaCEf0Y3HBw1
RV3XQf0B6lEdjAlzMJRr3Uoj9RlHsNYw5tuDBjzjhuhLo7Zjk30u0EahSf7bHeOu
9oiTxreZiGfmKoROElaLxJW4hnPBJk49uHuJ9ZEA3piy4vyXNcDkamVX1KNirrx0
DAa0wmOm/c1Shh7YPcM49190QwqMBhq8gzj08zqgFGrGYtgC+zctmrWrdhYCH5et
jrYZzk92SjrzRA1sTSUjb389D1FVZlNMSSw0wVuKplah43Df6Igj2yukQ/kpcOCk
9lB3SL9riKr9T10PJDcrFPoqkEOaMbcdfjRByIlOHLIMvf4k3AM4Od6PSJi/TQ9S
XL5mCULfyxrBAd8sniXcZyhzP531Xv88KqD8tknk5OfSw35xvfWmQzoXEElr34hf
ZAi9MzKythZOiU/0xU2NSTMBY7Y+WD1RaO1LV9XUaEDwU8ih1No=
=u1tT
-----END PGP SIGNATURE-----

--nextPart3331196.5fSG56mABF--



