Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E546AF1B;
	Tue, 16 Jun 2026 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628153; cv=none; b=d/KE3UIOLtsNzXpKaUj7ApmSUKFM9xztr0Kx+Av1DTERNhSG9LnkBFaSLl8BDvMu8SCWZULOupHcP0bJCEn45VJbKcmvAYpf74/ny2FCrcD2ASiFx491tqCBiLHj/xHugqTvrf9lDaqFVtieJLd0Mvr0XeURfozRLyAZMOZlLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628153; c=relaxed/simple;
	bh=Cozgf+ex87Q5DHGCt4pmEkr1bhDJf05+lcXo9eT2FG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVxIlveW9E4q+QECsFtYJMR/wKYekPUDd3wQwbvxIqLuMjJPqmzD9pJuJ0j3qNue7I0cShrojeZksJx/NgOu1dSSJm1fhkRK9I9086zHypM3FsVzEA5ARC46a+pFNvSctPwOoKGGoWG8VcDtZiIPnBH8T0Cg6bYh/bz2eZYj37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p1XWtPhP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p1XWtPhP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1D2CC4E42F1D;
	Tue, 16 Jun 2026 16:42:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E33D1601A9;
	Tue, 16 Jun 2026 16:42:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85CFA106C9C3D;
	Tue, 16 Jun 2026 18:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781628147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cozgf+ex87Q5DHGCt4pmEkr1bhDJf05+lcXo9eT2FG4=;
	b=p1XWtPhPnGJ6itvOBVOkSswmUzNIKpO0fUiFxtTmNHW+oSpU3OcIL74XfoDT53MiOhptHv
	W95v0AWRnDuWKgwPHrCM2pbbMO3vVIfPd6VuE+SbuJpot/5M45nAAColutpYMdXbyJqa08
	bdqy2prgezcbFrOoNjhfu1Gb1eM2Dk+xolOJbhmoIWh5Shn+wW164t+qQj+FtfK/Q6lVcz
	I9+QCdoMHmKP94O0DhCD3sw6eiuNzN4/D8OX8IbRgKarHo1YsOGJmVEWV3p6JwDM7meF/z
	3m1D3lrwp3grxYBEIk6spVbZiAzjyxOKcBMuOuC35WYMfY8YgjbhDahaIKh5yw==
Date: Tue, 16 Jun 2026 18:42:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Corey Leavitt <corey@leavitt.info>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller
 lookup from MDIO probe
Message-ID: <20260616184220.72d1b814@kmaincent-XPS-13-7390>
In-Reply-To: <20260615180812.829678-1-github@szelinsky.de>
References: <177795581584.12433.14568712745388778289@leavitt.info>
	<20260615180812.829678-1-github@szelinsky.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Carlo,

On Mon, 15 Jun 2026 20:08:12 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> Hi Corey,
>=20
> just checking in on this one. Did you get a chance to continue with the
> series, or is there anything I can help with to move it forward? I'm
> happy to test a v2, and I can still run the SFP path on the
> S600WP-5GT-2SX-SE once it's back on my desk.
>=20
> Kory, Jakub, Russell :-) it would be great to hear your view on the
> approach so Corey can plan the next version. The series fixed the probe
> loop in my testing and I'd really like to see it land.

I haven't heard from Corey since this patch series, but I am in favor of th=
is
notifier design.
Corey, do you have time to continue this work? If not, would it be okay for
Carlo to continue it for you?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
