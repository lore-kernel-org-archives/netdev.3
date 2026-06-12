Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB43D524C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250037; cv=none; b=E8mpKxpK9CHsllsaX7O7MXfBX/gqu8t7RqBKyLFV91ydZKjDUGr16bn/qOQpE50YGT1gXgPQ7LVqwblbIYzgK+FU6lucOoGkuMOWsohdKil8+go84RU73krItD+jZmpjFo7mhZfZjCGjUdh6X4DYLH8BYxqfjCFmCsnnYFnwd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250037; c=relaxed/simple;
	bh=aelshhmUSP5fJlCfVhIpUetRmNDtYzaCxKZxMDQFPX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p48RsNTFgoyP+VDgA7ZJv/nEPSnYBf0d8sdUyxSjSDpubwf1JH8XcBQ+mCi24PyzyPG49dcrT5lvxfe6T5xxbB+g/Q0L1fF2XnMg1Etph14Kz2c5B1mQV3EHsBw73Jvx+oOle7hsibnbMNPv61kk4lydJhBitsuP3Owmqb3dm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=brNAh9+t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="brNAh9+t"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A76944E42E40;
	Fri, 12 Jun 2026 07:40:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78CB960012;
	Fri, 12 Jun 2026 07:40:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07DD4106C8014;
	Fri, 12 Jun 2026 09:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781250031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aelshhmUSP5fJlCfVhIpUetRmNDtYzaCxKZxMDQFPX4=;
	b=brNAh9+tk55k13XzQnSmC5mvHnlM6LSyahm1NK1EkKPvwXe6nT/+xzxSLosPvf8CtplnSY
	+EYXPe77kVTa/aCIfnpBqC89XczsOK4WUce6qHvBzLjcYBzcZQ/DnPVM0VvSHQvzfKRAF0
	CSmbzym46G3X+qtIu9Rite9RHv/qv5SbxFPwMa4cej1qkiMX1n9Qrzx/+hZBR+5vM9W0Fh
	Wbhf4kR1o4619aLastkx7ymuE72ziRSC85yKgTaQGIdvSmKYnY2kOKroP2L7r4rUDVFWZ0
	JPkA1l9JtBhQOROFH4L2dgXSJ34+za6jbtePrRb7/YYXpua9txBdmv2z4IYOaQ==
Date: Fri, 12 Jun 2026 09:40:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 gal@nvidia.com, jacob.e.keller@intel.com, sdf@fomichev.me
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Message-ID: <20260612094025.564cca68@kmaincent-XPS-13-7390>
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
References: <20260611200355.2020663-1-kuba@kernel.org>
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

On Thu, 11 Jun 2026 13:03:55 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
> it tries to update features. mlx5e_hwtstamp_set() calls
> netdev_update_features().
>=20
> I missed this while grepping the drivers because tsconfig goes
> through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
> uAPI is in ethtool Netlink. We could add a dedicated opt out bit
> for mlx5, but NDOs were not supposed to be part of the ethtool locking
> conversion in the first place.
>=20
> The mlx5 features update is related to the "compressed CQE" format
> which lacks timestamp, apparently. See commit c0194e2d0ef0 ("net/mlx5e:
> Disable rxhash when CQE compress is enabled").

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
