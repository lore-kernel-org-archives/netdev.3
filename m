Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DC37E5E5;
	Thu, 20 Aug 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246824; cv=none; b=QHeB5ISAuu5K4dCOfh7IBL62rE5v/+efZZa0WE4bGWF7yLin3KdEEL/g01bHA04jbJAj/hksm0PvYlCti+cV+ArpKB3xfkDLCBrFE5bE1SX0Rdq0JrOFsK08eGfUEvsjY16C8wXq85h7dShJE0OajY/fUujO3xy56kd63JBrJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246824; c=relaxed/simple;
	bh=UaL33jsG18Eq1oHTvdTKaW0xWUwrmF30Fr8kSl0f1zg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ktQFWykR2MjIr8UkHkJUlDY4f41/ZXrjkXGLnMTj/t2p2jg30vMQpaAM61RjD0RPn2MOWDl40OEGgRR/3gmwP0CZDDbuki/r+H1WNJJzF7+soU4G8MRfhYQ721rVZ1w/FNKBnt4w7yvQh4OGt5i/yIArqKI/tIggXFT6ZXfu0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Lavws9HA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Lavws9HA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A79BA3A00;
	Thu, 20 Aug 2026 19:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787246809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2bzD2T1rRqWwcCfOgD3KVLK2SEoO/rbc73sc4LvgTXA=;
	b=Lavws9HAwwL7H4OzosGY23pIaezFudsTo7I8waYwEWUtY8eWjEvHIV9JKQVKvNINygFrAf
	dR9eFClnJmkNA+5Tw5KtqHwmai4+aphRJF/5gyQlMar2E6G6i5/cvg5n0GHb2X91zFllw4
	nYUCln4tgWHAn6Pd8I2Hy148bYcqVjinvmve7awiXyShIIB9M5ZGEgPxoil988bjq+ZVk5
	NJX84GxeZil0YvRqRLU11QS8yOri99YkOX0RB0RCCAZ3FGH+QanO2oXs2y8sTy3Rz40wvy
	IiAJV1Ob6Ahq1FG0FSH4BEGFtSxeEaLCTc9Nfx0DY1gXfJmy9OED2GpbOp/TuA==
Date: Thu, 20 Aug 2026 19:26:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?ISO-8859-1?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Valerio <pvalerio@redhat.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net] net: macb: drop CONFIG_OF #if block
User-Agent: Thunderbird for Android
In-Reply-To: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>
References: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>
Message-ID: <5E44F678-A2A8-4868-9069-D1A7E14F3BFC@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Th=C3=A9o

On August 20, 2026 7:08:20 PM GMT+02:00, "Th=C3=A9o Lebrun" <theo=2Elebrun=
@bootlin=2Ecom> wrote:
>Fix -Wimplicit-function-declaration error on CONFIG_OF=3Dn builds:
>
>   drivers/net/ethernet/cadence/macb_main=2Ec: In function =E2=80=98macb_=
probe=E2=80=99:
>   drivers/net/ethernet/cadence/macb_main=2Ec:5951:15: error: implicit
>   declaration of function =E2=80=98macb_alloc_tieoff=E2=80=99 [=2E=2E=2E=
]
>    5951 |         err =3D macb_alloc_tieoff(bp);
>         |               ^~~~~~~~~~~~~~~~~
>   drivers/net/ethernet/cadence/macb_main=2Ec:5973:9: error: implicit
>   declaration of function =E2=80=98macb_free_tieoff=E2=80=99 [=2E=2E=2E]
>    5973 |         macb_free_tieoff(bp);
>         |         ^~~~~~~~~~~~~~~~
>
>Error got introduced because functions are mistakenly declared in a
>`#if defined(CONFIG_OF)` block=2E Instead of moving functions around,
>avoid any future mistake and drop the block entirely=2E
>
>Change the module content slightly on CONFIG_OF=3Dn=2E Previously match
>tables were ignored=2E Now they appear in the resulting build=2E This is
>considered trivial in size by most and is the common case:
>
>   =E2=9F=A9 18 out of 254 OF net drivers reference CONFIG_OF
>   =E2=9F=A9 rg -lF 'MODULE_DEVICE_TABLE(of,' drivers/net/ | tee /tmp/a |=
 wc -l
>   254
>   =E2=9F=A9 xargs -a /tmp/a rg -l CONFIG_OF | wc -l
>   18
>
>Tangent: no, of_match_ptr() does not imply that the compiler can
>optimize out match tables, because MODULE_DEVICE_TABLE(of, =2E=2E=2E)
>unconditionally puts the match tables in the binary=2E It is only meant
>to avoid undefined declaration issues when match tables are hidden
>behind a #ifdef, as was done before=2E We therefore drop the macro call=
=2E
>
>Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across d=
evice lifetime")
>Signed-off-by: Th=C3=A9o Lebrun <theo=2Elebrun@bootlin=2Ecom>
>---
>This is a fix to a build issue present on net/main (91ec20351349) and
>linux-next/master(7079a12d7506)=2E The problematic just landed in
>net/main=2E
>
>Two fixes [0][1] were sent previously (both the same solution):
>[PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of CONFIG_OF b=
lock
>[PATCH net-next] net: macb: fix CONFIG_OF=3Dn build
>
>Instead I'm suggesting [2] we drop the error-prone preprocessor blocks
>and do as everyone else=2E
>
>[0]: https://lore=2Ekernel=2Eorg/netdev/20260818-macb-fix-no-of-build-v1-=
1-f2a009616384@kernel=2Eorg/
>[1]: https://lore=2Ekernel=2Eorg/netdev/20260819040913=2E109367-1-running=
910@gmail=2Ecom/
>[2]: https://lore=2Ekernel=2Eorg/netdev/DKT4CBU8YB5G=2E2W0766H2NU6Y8@boot=
lin=2Ecom/
>---
> drivers/net/ethernet/cadence/macb_main=2Ec | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/cadence/macb_main=2Ec b/drivers/net/eth=
ernet/cadence/macb_main=2Ec
>index 1476bce77f34=2E=2E76ee4f506033 100644
>--- a/drivers/net/ethernet/cadence/macb_main=2Ec
>+++ b/drivers/net/ethernet/cadence/macb_main=2Ec
>@@ -4926,7 +4926,6 @@ static const struct macb_usrio_config at91_default_=
usrio =3D {
> 	=2Eclken =3D MACB_BIT(CLKEN),
> };
>=20
>-#if defined(CONFIG_OF)
> /* 1518 rounded up */
> #define AT91ETHER_MAX_RBUFF_SZ	0x600
> /* max number of receive buffers */
>@@ -5754,7 +5753,6 @@ static const struct of_device_id macb_dt_ids[] =3D =
{
> 	{ /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, macb_dt_ids);
>-#endif /* CONFIG_OF */
>=20
> static const struct macb_config default_gem_config =3D {
> 	=2Ecaps =3D MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>@@ -6267,7 +6265,7 @@ static struct platform_driver macb_driver =3D {
> 	=2Eremove		=3D macb_remove,
> 	=2Edriver		=3D {
> 		=2Ename		=3D "macb",
>-		=2Eof_match_table	=3D of_match_ptr(macb_dt_ids),
>+		=2Eof_match_table	=3D macb_dt_ids,
> 		=2Epm	=3D &macb_pm_ops,
> 	},
> 	=2Eshutdown	=3D macb_shutdown,
>
>---
>base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
>change-id: 20260820-macb-fix-x86-eb78a1fcc63e
>
>Best regards,
>-- =20
>Th=C3=A9o Lebrun <theo=2Elebrun@bootlin=2Ecom>
>

Reviewed-by: Nicolai Buchwitz <nb@tipi-net=2Ede>

Thanks
Nicolai
