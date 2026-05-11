Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012D3C344D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524029; cv=none; b=QL8pBFkek6RdlUuuefhnvjOOpAVeo1avkw1mvyuxfAtU+f0R7M5R6Qf5GX+q3xFXQ8ASaxuYnTif6/I/xqGzHeldjVMA16FXYJKIUoMK+zdbUKcZ521xo7BvMFAP4dt7uCA+Jr7XopU/A/YzPMLX1nL+BCbIhePBnVwfYS43jwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524029; c=relaxed/simple;
	bh=la5+ROH1L16RHSl9qSVofdv4BLG/MfWkq51XUKzuXGs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YvFqNBsPMg6lWQctsiSovfkm4DzW80qmSZr8fFsp9s54FGVUJ6qOsbkRvaaa/59I2qpjc+H3D2RABMbnCptbtfxtxjZs15/IlpzdD1Zn4q2xgubqP0qGdcG4LKAyHG11kcQJ0va+dvpNNQlZiVLXjrPM9m74Imh9SGju8MVilkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DNzc3FTW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DNzc3FTW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 98DA2C5E154;
	Mon, 11 May 2026 18:27:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D72EF60646;
	Mon, 11 May 2026 18:27:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6BB011AF9FDC;
	Mon, 11 May 2026 20:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778524022; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IUoaZOo0WM1phWbd6ZULg4KFX56eFleG4ODNAvRZuJI=;
	b=DNzc3FTWsu/erUDEMD3zjc6DVqSrkywFMWL9JUCx4soSB/FI19tVVgKFZDZ+sdM4qPInFl
	+j+YkNveDEyLZb3hdarEsvProAaw0pOD/vWeLYd0IZ43vnN6s8pvk+Vi3o2tRkT6eG9Rsu
	9pOYb8Dp/DTvq0aYo8wkTjHlgNpvbwM8sr9YAaMZg5Sx/GzhPtTizqi9a51VrkqlqA/SRo
	3PWvyFNkfr22/3QFoc5xWVzVvXtirElmW63x8Ta16VvPyCbBAZaCQsFWLcnLYuGUncK3Zl
	v8O5jfSi5BYhbJctjk20RXSRPCgoNhTW5u8RQt1LFg9PSJk8RBY5JDV26GneYA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 20:26:56 +0200
Message-Id: <DIG259UJOARG.2WFLZLCSR41AJ@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: change maintainers for macb Ethernet
 driver
Cc: <conor.dooley@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <netdev@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: <patchwork-bot+netdevbpf@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260507120444.9733-1-nicolas.ferre@microchip.com>
 <177828000904.878212.12911947829161473740.git-patchwork-notify@kernel.org>
In-Reply-To: <177828000904.878212.12911947829161473740.git-patchwork-notify@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sat May 9, 2026 at 12:40 AM CEST,  wrote:
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Thu, 7 May 2026 14:04:44 +0200 you wrote:
>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>=20
>> I would like to hand over the macb maintenance to Th=C3=A9o, as I'm unab=
le to
>> keep up with the recent flow of patches for this driver. After speaking
>> with Claudiu, he indicated that he is in the same position as me.
>> To help with this work, Conor has agreed to act as a reviewer.
>>=20
>> [...]
>
> Here is the summary with links:
>   - MAINTAINERS: change maintainers for macb Ethernet driver
>     https://git.kernel.org/netdev/net/c/0a549298f452
>
> You are awesome, thank you!

Acked-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Oh wait, I am too late.

Thanks for you work during all those years to both of you,
and thanks for the kind words Nicolas.

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

