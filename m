Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0ED3B637E
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869459; cv=none; b=VNYTBt6jgqx8ptAJ8yZ3mdacLLS7iOBoEDQdLXDR6WLd/vYe/UfPhbSzEOHlXVTQ/bewmyKEaZTjzV0aZsh0szElk0LnSdPmPYNpChKxQgX/ev7Ll0YNi5X9AzBOAlrOQDAqWPVf9DMwSZR+zZfxYKPIDX7drjWAh7AXTqIbQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869459; c=relaxed/simple;
	bh=zl3OmdW2q++juzlLZtC+OUOcXtOhM1i2v2EzCJ7DmSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXJVJY049ee373MV3yvgb8eE6PcrBSTKCQ54K9P6jtwEulsGXvTWvwrvOTkr56NhGoZBfJFlbKZvscivJwVi1lOSkZmJPTZK3KQpwar/eZp2nWx0vVB60bhmUIpuBEVD4K2BUp81cIa6iiwzmN04fZ093ikwioMrV8SZD9n2lmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=deF5kfhj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="deF5kfhj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4E274C5877D;
	Mon, 30 Mar 2026 11:18:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40AA05FFA8;
	Mon, 30 Mar 2026 11:17:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EA7A10450088;
	Mon, 30 Mar 2026 13:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774869455; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zl3OmdW2q++juzlLZtC+OUOcXtOhM1i2v2EzCJ7DmSg=;
	b=deF5kfhjUMt39TndOSohLEj2N5o0E6qkvuMjl1yWYN2agIQQDjbLbyHRrjC77MKF/sy3kM
	HPWfpU+c3qWVywW5ZGB+MFCfXkwN7p974/c5UC4281yXKoqWiYnDqk+hKAn1ENam4I9BVu
	g1yO/TPUAxxFhKxUeYPPjYNjnLX4E6kC0JCriXU30GETwsKqm8cMz/ECpUT2QTNeSiliMt
	x08nk8cnkUbTSyFwD2xJxKFIPujp8JaIpzaCV5LH+We33pf29+3wWMvAPPrh3Aq5kX2FTr
	pmT3QU2CILDKjS0BJlo4jr2dquQAOq7xSZz9av8WXf5gtUM3oEj5MKapnm4UUw==
Date: Mon, 30 Mar 2026 13:17:33 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: pse-pd: prevent regulator cleanup from
 disabling unclaimed PSE PIs
Message-ID: <20260330131733.7c8e68a0@kmaincent-XPS-13-7390>
In-Reply-To: <20260329161014.2908509-3-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
	<20260329161014.2908509-3-github@szelinsky.de>
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

On Sun, 29 Mar 2026 18:10:13 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> When a PSE controller driver is loaded as a module, its PI regulators
> are registered before any consumer (PHY) acquires the corresponding PSE
> control via of_pse_control_get(). The regulator framework's
> regulator_late_cleanup then calls pse_pi_is_enabled(), which queries
> hardware and sees the PI is enabled. Since no consumer holds it
> (use_count =3D=3D 0), regulator_late_cleanup disables it, killing PoE.
>=20
> Add an admin_state_synced flag to struct pse_pi that is set when a
> consumer first acquires the PSE control and syncs admin_state_enabled
> from hardware. In pse_pi_is_enabled(), report unsynchronized PIs as
> disabled so regulator_late_cleanup skips them.
>=20
> This preserves the existing dual-path behavior: software-tracked state
> for software-controlled power domains, and hardware queries for
> hardware-controlled domains. The admin_state_synced flag is only false
> before the first consumer acquisition, which is the exact window where
> regulator_late_cleanup could incorrectly disable the PI.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
