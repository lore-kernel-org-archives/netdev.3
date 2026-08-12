Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EC3955C0
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521733; cv=none; b=ayMbLBR031lWurcNXbrsx8kVAKJJut9HSq5m1GpS6bmWvA+9lOb2L4WSIpmeveVhcRfLqVjEyUzrPLr1ysKx7137GEZS0kALDGMglcuV2zjW7044hJ9rnz4BakH6LvM62ne0ZngRzvBWdCdO1M0hrNw4VL2BDQMhIgLJNpObyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521733; c=relaxed/simple;
	bh=psdNGXpTr7IJa0KXLC6CwzS+2MwL+hbrx8E8DTPDm/Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=V7FG8/mRg/tL0/8Xf9f++UgA9a5q7PyEPBpnsUMnMIO/vieXiOFKVzsvfwfmqURbMYutMvdPGr+e1uiFFR54k/F5xGsC4SakO3hVf/Jex3kEbzwk0vxeAXo+zv7pMdq9ozuwPqYFmIAFEJ6IVzZbe+xXl+EUcoSWcY1vBvGi0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rCQ4J/gy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rCQ4J/gy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EACD21A15AF;
	Wed, 12 Aug 2026 08:02:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B09AB6046C;
	Wed, 12 Aug 2026 08:02:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCA5311C4C932;
	Wed, 12 Aug 2026 10:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9JBW2zlHcJHXZzDLRMjW/S/O+kULTTpp3wV8Vcmckcg=;
	b=rCQ4J/gylzZXYAmXGXP2m7H/AWqsdngq2fnYfNQ3srAGmdOPFQpUtPdlh6t8szhBtF0qE2
	ZwLN/GVCOI2fHU1o01XN20VG/G/E9tkF4W/eLlX/EwpXmatFVkrcOsuRc+nwymFxAxkYjF
	eo1d+bYT2lj1cuOQoUwuruFHFgQpqZcUzmAkRi3secdZW14gzBPm6mfpQ5yFuTthwmvsYy
	IWpLtV6uX7JjZ/X9oUBrMOIXiefrATVHd2Zu0ksHqfm1RzoAoITMXqr4DG8C43splIkkBd
	vAc0e2K1m1oPH4RE0fF6poYS4HqGWWAkIBIeLnKBUg85f+iNrbUeSBsTBVp1qQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 10:01:55 +0200
Message-Id: <DKMT3DU36RFK.2DDU6GDWOOX0Q@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v8 14/17] net: macb: move printk() calls out of
 bp->lock critical section
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260805-macb-context-v8-0-bc302ffd1174@bootlin.com>
 <20260805-macb-context-v8-14-bc302ffd1174@bootlin.com>
 <20260810170857.697df2e0@kernel.org>
In-Reply-To: <20260810170857.697df2e0@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Tue Aug 11, 2026 at 2:08 AM CEST, Jakub Kicinski wrote:
> On Wed, 05 Aug 2026 19:42:43 +0200 Th=C3=A9o Lebrun wrote:
>> printk() while bp->lock is acquired is dangerous if netconsole is active
>> on the interface. In that setup, we might land in macb_poll_controller()
>> -> macb_interrupt() -> spin_lock(&bp->lock) but bp->lock is already =20
>> acquired.
>
> Reportedly this patch adds:
>
> drivers/net/ethernet/cadence/macb_main.c: In function =E2=80=98macb_inter=
rupt_misc=E2=80=99:
> drivers/net/ethernet/cadence/macb_main.c:2130:28: warning: variable =E2=
=80=98netdev=E2=80=99 set but not used [-Wunused-but-set-variable=3D]
>  2130 |         struct net_device *netdev;
>       |                            ^~~~~~
>
> which persists after the series.

Indeed. I'm always surprised the -Wunused* flags aren't enabled on some
archs at W=3D0. There is another instance but it's been there since 2017
and I don't touch this code (gem_get_ethtool_strings) so I cannot fix.

New revision for this.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

