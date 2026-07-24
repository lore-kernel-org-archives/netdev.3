Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C33090C5;
	Fri, 24 Jul 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901547; cv=none; b=e8mCecLrevFCZLexVqawK7f2UIyTtY9D/SCbUfBySsuvl8kZXXEmLQPmMugSM96xU/tMUfH7R+exnT6Zt1auQaNTyBK3JXuU7yb8arXgIW1MkZ3Mo1w/1rZ3YY5g9pJUUvDP4LCz0F+mWRhB/j/PFH4G0ch3A1wLMy3HWs+XbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901547; c=relaxed/simple;
	bh=PH7whP+3cDdlFXDhLChtdc5VyOhH8L4lN08XxaE2zTk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=u5yMUS1M1Y2CbGvFe1HtvOyRLe6wKlqT74uTaLdeW045kc8gouKIJFw+HoKtleNrG6yoIH8CFzPHvwYoj16wjtJhC6bXJyIecEY3Lcsm9bJxhTOFvaU5m+KrIEFd8l2iut6yOqbSwN6fh+y4r53khC1VIMzycnVXf0dz7LapXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jX9gTfIm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jX9gTfIm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ED9CC1A11E6;
	Fri, 24 Jul 2026 13:59:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF1A960395;
	Fri, 24 Jul 2026 13:59:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BC1111C100E4;
	Fri, 24 Jul 2026 15:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784901540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nQbNqpY1JX0gW8HgVql2UnXFLi2aXfol29g3GSib/7Y=;
	b=jX9gTfImJjpLbRe4HlnfNyMUUCaaB52iIjcc+wS4F/DSEVbAVNL85RJvzyGeVP4qjSdVWU
	NUvlwMhI4ZHJPnzPDlQYjLaDSGh3nNrVWVvWMMNobydVG1mleQlf7NuU6hsXHeLHwYqEti
	igfrZQJIQgCappMv3zubttpmCR+P5D5zSmXnhgd4K/gZIDcvzBKnNjDDVvIqhpziugJqu0
	PzEDSyvW+l61+B6guzAf2zCqzt3ghdKBYeMTw5IF7xfjwbkZgBHQtgdCx+fXYPvYvevInL
	hIQvgWIZ1n4XE6npuWc9ZNMt2cDNaxV+E0+52PeOmEhL2/GKLHdQGjiYijyqVw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 15:58:55 +0200
Message-Id: <DK6USDMUTRL1.2HQY6Y30YS6BC@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v4 02/15] net: macb: unify device pointer
 naming convention
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-2-0acbe7f10cdb@bootlin.com>
 <be5764f7a984d47c4c4ea49f3e3ce288@tipi-net.de>
In-Reply-To: <be5764f7a984d47c4c4ea49f3e3ce288@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Sun Jul 19, 2026 at 12:32 PM CEST, Nicolai Buchwitz wrote:
> On 17.7.2026 21:48, Th=C3=A9o Lebrun wrote:
>> diff --git a/drivers/net/ethernet/cadence/macb.h=20
>> b/drivers/net/ethernet/cadence/macb.h
>> index 2de56017ee0d..9857df5b57f0 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1326,7 +1326,7 @@ struct macb {
>>  	struct clk		*tx_clk;
>>  	struct clk		*rx_clk;
>>  	struct clk		*tsu_clk;
>> -	struct net_device	*dev;
>> +	struct net_device	*netdev;
>
> Looks like you have missed the one in macb_free(), from commit=20
> 27f575836cfe ("net:
> macb: drop in-flight Tx SKBs on close"):
>
> 	bp->dev->stats.tx_dropped +=3D dropped;
>
> This breaks the build until patch 7 rewrites thatline, which breaks=20
> bisection.

Argh. Next revision fixes it. Checked with

   git rebase --exec "make drivers/net/ethernet/cadence/"

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

