Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A907306764;
	Mon, 10 Aug 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369422; cv=none; b=lqNTNn0W7R9rv0NETmCZwuRZKE2MN8oF8JqY6MYfzNuJAxyjEHur2gYQTK4IhWuNhp/XpkCP3BP79Qjx9ioQZTvANN7tqxwAHcUoLoLGKO5v7+m6l5TXuXemJKZiWsO6W5xNXXCaNzYf+5cM/pho6UCJgtpZikahUCVPEG0RpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369422; c=relaxed/simple;
	bh=UdiPXEaSNaCL1ddXZ2Q9wOc6RknFFv9ThDouOM6fJqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWRFUW9GLGpdi9eojqOBM5hH3O9d7zYYBeTOuZAgXbhnAtU674bpy1HbORkbTEtxkcyVBNB7Nj0SnY849GPkS+I0f6QCWTQIyrpT+aXLCxp+Juy1amPiUnWLPLjk/iHPMcl4z5A5SlD4lVol0isnQ+vZrWRac24sEZxbCk82kr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HkViTTZz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HkViTTZz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B1B251A1538;
	Mon, 10 Aug 2026 13:43:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D8136033B;
	Mon, 10 Aug 2026 13:43:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B15A11C4A749;
	Mon, 10 Aug 2026 15:43:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786369411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UdiPXEaSNaCL1ddXZ2Q9wOc6RknFFv9ThDouOM6fJqQ=;
	b=HkViTTZzQEIlDJAcK79Tf+9pEbZb5Wv4CphZyVRaPuo19w80ZXxG83HPEn3iK98g21dgOJ
	tvpgiYi2mrmgV11Nhg385AtYjloYw4zWRSXsMIsVa66In5j4WzI9fygjppPVA/geHkEuv6
	E/TQuVjKsjt2FolKcxmRg7fsl9tIiuFAvXrqte2kdfXThtFCjt2Nb2Ea5YzpeAAcmNLKpU
	ZyhJMI1+bpfflFTQx5mRoVS3y6UTbQUso5gWoaZ1P3aw7RCjKvgFamOxVBC1Wu5zJEvkp8
	rTJErinJAFRQQ3eIBwcsbnZxNIb2dml0X+3HhQFOkq9hCZ1MfmSMeNNrhf0TTQ==
Date: Mon, 10 Aug 2026 15:43:27 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: github@szelinsky.de, o.rempel@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against
 freed PI data during unregister
Message-ID: <20260810154327.21e71ae9@kmaincent-XPS-13-7390>
In-Reply-To: <20260717111042.446842-2-horms@kernel.org>
References: <20260711121611.1639086-3-github@szelinsky.de>
	<20260717111042.446842-2-horms@kernel.org>
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

On Fri, 17 Jul 2026 12:10:43 +0100
Simon Horman <horms@kernel.org> wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://sashiko.dev/#/patchset/20260711121611.1639086-2-github@szelinsky.=
de?part=3D2
> ---
> --- Patch [2]: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against
> freed PI data during unregister --- commit
> 651be76b54426e6621f4330232053b29d0731f5d Author: Carlo Szelinsky
> <github@szelinsky.de>
>=20
> net: pse-pd: guard regulator ops against freed PI data during unregister
>=20
> The commit tries to fix a use-after-free by clearing pcdev->pi to NULL un=
der
> pcdev->lock during unregister, and adding NULL checks in the regulator
> operations.

All the report from sashiko are either hallucination or possible pre-existi=
ng
lifetime issue, which is what you are trying to solve.

On my side:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

It would be nice to have it accepted to move forward on your PSE notifier
series.

Jakub what do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
