Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CB14AD20;
	Mon, 30 Mar 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869825; cv=none; b=GYbRxzvcUzyWU7UziMcldbWvicV3iZ6rSJelBJDFKweXhUIsgLkTH80WmDmPrBRP7f+zP6ijSv2VlRv0b2ZvHXhhtsH86/NSCI/IgL99AXVh0D7BMAMznYkktkC/Nos6V9uNLYvEhqEF54vdfU/9sV7n57NQozHmJ/HpOMtu/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869825; c=relaxed/simple;
	bh=MBS4GoaGmP/WEbQxn9vGEZQuEZgmcTIoI/rZ9ghPZ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn6BidL5aclC7ArQmXbfT2b2shp+KcpYh2p9rr4mHxvQVSwgsm7q2+WZfI4pJEfKdiuBUENxjMXyrZePWDR15Yug8hjyQPb1hnw7sDwYjwPalzEuIH2tkfSqavGEtEZ0toOpb8g7tNKv5o10o3ZYv18b7y1hsIQ3i4HBgw+pSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zxh8qpcp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zxh8qpcp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7DE83C5877D;
	Mon, 30 Mar 2026 11:24:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41F915FFA8;
	Mon, 30 Mar 2026 11:23:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB5E710450088;
	Mon, 30 Mar 2026 13:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774869818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MBS4GoaGmP/WEbQxn9vGEZQuEZgmcTIoI/rZ9ghPZ3E=;
	b=Zxh8qpcpTkbMnsArGVJHEUjQ0iZk78VSO+vGTaJ3vnYNRi4J0r/DDANPMhpUuhkQUzvqPZ
	Y9tjK1qOaMW6twDEdJSDJbJBGxjXk3wdM2MQdBbkGEJks4xtZ5/JZ4JibT3pYRpGwuthLO
	VEDt9SYttpHebIrtQNwNWHuJi75o8O0Wic/sSEW+Kn8uCL+Rg5R5RPkFkTwI6h324XbEWT
	LhZop6Uqs2dFqVMCBGhm6TFv+gflIVHRD/w6JNsp77ObteGspugMaXcd+BrCYtVD/brkRU
	28Ui02+uDm2LLcHjgrPh7xlyADY/W4aIQ8hE8r9PBXaCd/f3mBUuvU6Wrevagw==
Date: Mon, 30 Mar 2026 13:23:34 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: pse-pd: add lazy PSE control resolution for
 modular drivers
Message-ID: <20260330132334.37a994a3@kmaincent-XPS-13-7390>
In-Reply-To: <20260329161014.2908509-4-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
	<20260329161014.2908509-4-github@szelinsky.de>
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

On Sun, 29 Mar 2026 18:10:14 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> When a PSE controller driver is built as a module and was not probed
> during PHY registration, the PHY ends up with psec=3DNULL. Add
> pse_control_try_resolve() to lazily resolve the PSE control on first
> ethtool access.
>=20
> Call pse_control_try_resolve() in both the GET and SET ethtool PSE
> handlers, before checking phydev->psec. The function is serialized by
> RTNL (enforced via ASSERT_RTNL), preventing concurrent callers from
> double-allocating a PSE control.
>=20
> If resolution fails (e.g. the module still has not loaded), a debug
> message is emitted via phydev_dbg() and the handler falls through to
> the existing "No PSE is attached" error path.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
