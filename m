Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7F3D9DC9
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367970; cv=none; b=d9UcfQ5UE/79Jxm21n+4mHlAe4m324Hiq3FALwm7zJkg89TtjvU/cUOfatgjU5LeytuqoYZwJ1h/BOANImd674TfMLKOi+nCbDpVlsTTwAXdXMHC+w2uhikPceOYfqYJ/UQ9h7yh3l0SRPo2/yv75ObIxehBwsakJGMvpWnzzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367970; c=relaxed/simple;
	bh=RCnjMXak1vWRXkY+8P2qCv5I5tPqfGPlUI3npCNQYJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3nYlcVEA7yjf0LG/BEPUDI+PPIg5FIQm1KC3XqTUnJT03l7l/s56KaALP16Lc2Vo2qJ+Q5e+97V6No2jIKHDvjw2eq6ScRmw3Jr7IQeVIfDpfV5nxA46gm9tJQD6PYQngwZbHM8kub07zCNf8nNrbHjpjrRk2G3EWkywoI5eH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a5S556LP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a5S556LP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 648131A1525;
	Mon, 10 Aug 2026 13:19:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F9626033B;
	Mon, 10 Aug 2026 13:19:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69F4311C4A678;
	Mon, 10 Aug 2026 15:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786367958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0Cngfd3pTrBt3w1pSRyXt2FrQZwtm1iuY9S6c178uPg=;
	b=a5S556LPGtJDWULJBOBm1QZCs3uZ35TIQLmIYMDqpoUbPY3C8VrodMGnXG6DmVZnZmRpZm
	CaWQEHqwxrxY20XIzOP/OPctM5YBCPUkro5tirC9SKO7KouAJ8lU4PHFfwDSYoyvU5j6Ky
	Nlpvjkf4AHYlLXRD0kYX89+FGijPy0HHVbYpXGnpX1UFI8jz405m79vw+X3RGWZACOMK01
	p5r43xrNQXoj8w3WCYWLe6YlIi2/9lzdiB86c4TqBq0sDy901zJ/johgfBfk7O6/iXxDze
	uTikUz6K3Vi3PfIGDXWxX9HpX65YUc5+Uz/ibVDIN8l/9+pf+cENXjZZLuE7dA==
Date: Mon, 10 Aug 2026 15:19:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: github@szelinsky.de, o.rempel@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: pse-pd: stop async event sources before
 freeing PI data in unregister
Message-ID: <20260810151914.5d2389a1@kmaincent-XPS-13-7390>
In-Reply-To: <20260717110734.443214-2-horms@kernel.org>
References: <20260711121611.1639086-2-github@szelinsky.de>
	<20260717110734.443214-2-horms@kernel.org>
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

On Fri, 17 Jul 2026 12:07:35 +0100
Simon Horman <horms@kernel.org> wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://sashiko.dev/#/patchset/20260711121611.1639086-2-github@szelinsky.=
de?part=3D1
> ---
> --- Patch [1]: [PATCH net v2 1/2] net: pse-pd: stop async event sources
> before freeing PI data in unregister --- commit
> bc4c653b9b2b42b2c22ca8b6cae3af394c8add0e Author: Carlo Szelinsky
> <github@szelinsky.de>
>=20
> net: pse-pd: stop async event sources before freeing PI data in unregister
>=20
> This commit reorders the teardown process in pse_controller_unregister().
> It disables the IRQ and flushes the notification worker before flushing p=
ower
> domains and releasing the PI array. This is intended to prevent use-after=
-free
> issues caused by asynchronous accessors referencing freed data structures.
>=20
> > diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_cor=
e.c
> > index a5e6d7b26b9fd..6045b6c399c26 100644
> > --- a/drivers/net/pse-pd/pse_core.c
> > +++ b/drivers/net/pse-pd/pse_core.c
> > @@ -1114,11 +1114,15 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
> >   */
> >  void pse_controller_unregister(struct pse_controller_dev *pcdev)
> >  {
> > -	pse_flush_pw_ds(pcdev);
> > -	pse_release_pis(pcdev);
> > +	/* Stop the IRQ and notification worker before freeing what they
> > +	 * reach: both touch pcdev->pi, and the IRQ also uses pw_d->supply
> > +	 * that pse_flush_pw_ds() drops.
> > +	 */
> >  	if (pcdev->irq)
> >  		disable_irq(pcdev->irq); =20
>=20
> [Severity: High]
> Does this code call disable_irq() on an already freed IRQ line?
>=20
> In tps23881.c, devm_pse_controller_register() is called before
> tps23881_setup_irq(). Because devres executes teardown actions in LIFO or=
der,
> the IRQ is freed before pse_controller_unregister() runs.
>=20
> Calling disable_irq() here operates on a freed IRQ descriptor, which can =
cause
> warnings or corrupt state.

This is not relevant because on the sashiko case the pcdev->irq is zero as =
long
as tps23881_setup_irq()->devm_pse_irq_helper() is not call, therefore the I=
RQ
won't be freed two times.

All others are reported as possible pre existed issues and PSE lifetime is
what you are trying to fix so on my side:

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
