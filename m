Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8320530E1A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914142; cv=none; b=nkoV0J2sEnW0MB9y/fWwD/APNjnd9sLK7PsntTbppB4QB/T5UjLNah7U5qSpoSLmucgDl4B/idAkxcp9MJc44yXNOuj+WEPzB/33cBl50VqZsGKLiBjmH4qucwv2IndncYjPGSp2WtxE04wIPK8Zonom8oomcBb+IHXlpNuPisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914142; c=relaxed/simple;
	bh=BIXnfYUElBRiWWX6JzmsnWDu8llAt/G0T+rlmAKjccI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=uFvpJozobQrzQ6rWqbqtHg7OUOoXQfHiyiPpw+hQlvI8EyMbthijGZ5p8HT9mN6pD/QJEQh8Egw6rBq76AhZlWLgaJ9h/DSiOLsRjoM+lxgKu6HcDk/T12c2evnycq4vd9YI2DvUrhEcKbvrtPJRGfp1/TIR+oYG3y2YCCA7hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N2REz+Fj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N2REz+Fj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67E481A1217
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:55:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3570760362
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:55:36 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id B58C811D718C4; Tue, 13 Oct 2026 19:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uPwNHlOpz7ymGUpnZRAZ/SDsNHkeFoWOAQvq+Jxnu/4=;
	b=N2REz+FjdOeuF5DM+6fZuk+P/6vgsPADhezidqWSRvgG4feCfgt0qAGfnT9tnLugKTj3vM
	V82qpPKLFLqLCYcSOzgvZU/AXtt7crF0p2bTvZa/GQPSAevzKEIg8F+MJhZn/Yr9wQc/76
	3VH92k+U/xp+2TFxb/w3sgAk/bmt+h8Mpxec2OwjgMSusmwTL46JDLsBFg+YiW/p7G2eiv
	OfZxOcJRFLCYFtNfSpCh+RafEYsEmRBnnhHeXp41ZetWkOXycvnb+GGEh4aY/opoKRrBbf
	xbkcjUVO4zHjyf2r9Xr1Vue95emclEjN3bTo4hM7+p5Z5UM39fWzn3gexY+Guw==
Authentication-Results: mail.galae.net;
	none
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 11:27:41 +0200
Message-Id: <DLYHZKDHMOAJ.THSJPBNACX7Z@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v3 0/1] brief description about the patch and its
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
 "Jeff Garzik" <jeff@garzik.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
To: <taozj888@163.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261004133916.559956-1-taozj888@163.com>
In-Reply-To: <20261004133916.559956-1-taozj888@163.com>
X-TUID: 0fVO84TvPtwU
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: B58C811D718C4
X-Spamd-Result: default: False [1.25 / 30.00];
	BAYES_HAM(-1.65)[86.02%];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[152];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BCC(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	URIBL_BLOCKED(0.00)[atmel.com:email,davemloft.net:email,bootlin.com:email,bootlin.com:mid,bootlin.com:url,localhost:rdns,localhost:helo,garzik.org:email,lunn.ch:email,microchip.com:email];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]

Hello,

On Sun Oct 4, 2026 at 3:39 PM CEST,  wrote:
> v3:=20
> - add this change log since v2 missing it
> - drop the blank line between the assignment sentence and the commit
>   info
>
> v2:
> - update the commit message with the reason why the unlimit prints would
>   bother/delay booting process
> - update the commit message with the Fix commit id provided which is
>   suggested by Th=C3=A9o Lebrun<theo.lebrun@bootlin.com>
> - update the commit message with what packet type would trigger the
>   error printings more easily.
>
> v1:
> - initial commit

No mention that you dropped the diff in start_xmit? It happened in V2.
I'm looking for it because I don't understand why you dropped it.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

text:
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 11:27:41 +0200
Message-Id: <DLYHZKDHMOAJ.THSJPBNACX7Z@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v3 0/1] brief description about the patch and its
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
 "Jeff Garzik" <jeff@garzik.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
To: <taozj888@163.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261004133916.559956-1-taozj888@163.com>
In-Reply-To: <20261004133916.559956-1-taozj888@163.com>
X-TUID: JWRvl5CwSNmk

Hello,

On Sun Oct 4, 2026 at 3:39 PM CEST,  wrote:
> v3:=20
> - add this change log since v2 missing it
> - drop the blank line between the assignment sentence and the commit
>   info
>
> v2:
> - update the commit message with the reason why the unlimit prints would
>   bother/delay booting process
> - update the commit message with the Fix commit id provided which is
>   suggested by Th=C3=A9o Lebrun<theo.lebrun@bootlin.com>
> - update the commit message with what packet type would trigger the
>   error printings more easily.
>
> v1:
> - initial commit

No mention that you dropped the diff in start_xmit? It happened in V2.
I'm looking for it because I don't understand why you dropped it.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

