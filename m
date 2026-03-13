Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0D397E90
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414874; cv=none; b=U/8vDOv3FQ4eMca3jhd/D5LlSPP5ccbVXW9n7tk6GYdnZWnc9mSOHR83HfnUCQXBlokNw5AyLKqq81BS/2z8/nnKpu2GR6Edd54gKv7dAIl5IYpdJu/yNg+7mq6RjsneznN1i4cDO9vKmrPslRsyG4uaY/jt76lTruutG7BETEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414874; c=relaxed/simple;
	bh=E6AbIC8yXNTcQcd8Qnrpb/M2b9bzq/THFmMMA/P6hRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NLCVAWa1cAZcDg/VuT5awiKmx7rkvNY8mmvGhS7Mir31mlyUeQnUVFW9mrOz5AU+gCO+7EgyLhvAW8Pmqc86yno+76DEArhrsrUPiYyJTk2pWb4ZXqbjCthndTYQ204j3HNJSSdTYzTTF50NpUNZjno3Y6yx8Y3Js106PxY7HSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u3FvzJLv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u3FvzJLv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D7D261A2E17;
	Fri, 13 Mar 2026 15:14:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A0E8E60027;
	Fri, 13 Mar 2026 15:14:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F5E610369F38;
	Fri, 13 Mar 2026 16:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773414868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qr78aoGdCD2E8A40x69tuT9U0YAsw8WtT7vFx2zud0E=;
	b=u3FvzJLvNzRy1egcdwx0axOlzmwzYwlnRiwcvUeZsUipmzg4a3GBr0lUg3QgsZEc8yt2PX
	Kf+2biPB+E5gDWRmy1la3/10BGuctAKBdO0E+XrjFStnQdKRc6gVIwDq8r/EL4lLVRQLEj
	2xfv4t/9CYLd6u7Gdd+CE9brQGb51R6skheFK2pbqQyHF1Dx3YjL1pa8bUVhXsxHg93gHg
	eQB0Q+euk8EvUc6PQm/KT3cEJImqSY7l5dKEjSE74vABdhOKBk5X7B3bcKdUmYkMnjzSTp
	OL55fn+k1+o5+goYkyN+CVNrNppyT5Kx938qr2HjRz8uXmsgwZlv4dFYHvTgcw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 16:14:23 +0100
Message-Id: <DH1R3P9TTPS7.1YE0XC8RTNTIJ@bootlin.com>
Subject: Re: [PATCH net-next v2 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>
To: "Jakub Kicinski" <kuba@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
 <20260311-macb-set-channels-v2-1-982693a1f5fc@bootlin.com>
 <20260312182624.35ab61c8@kernel.org>
In-Reply-To: <20260312182624.35ab61c8@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Fri Mar 13, 2026 at 2:26 AM CET, Jakub Kicinski wrote:
> On Wed, 11 Mar 2026 17:41:53 +0100 Th=C3=A9o Lebrun wrote:
>> +	struct macb *bp =3D netdev_priv(netdev);
>> +	unsigned int old_count =3D bp->num_queues;
>> +	unsigned int count =3D ch->combined_count;
>> +	int ret =3D 0;
>
> unnecessary init

ack

>> +	/*
>> +	 * MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
>> +	 * the per-queue RBQP register disables queue Rx. If we don't have tha=
t
>> +	 * capability we can have multiple queues but we must always run with
>> +	 * all enabled.
>> +	 */
>> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * An ideal .set_channels() implementation uses upfront allocated
>> +	 * resources and swaps them in, bringing reliability under memory
>> +	 * pressure. However, here we implement it for memory savings in
>> +	 * setups with less than max number of queues active.
>> +	 *
>> +	 * Signal it by refusing .set_channels() once interface is opened.
>> +	 */
>> +	if (netif_running(bp->dev))
>> +		return -EBUSY;
>> +
>> +	if (count =3D=3D old_count)
>> +		return 0;
>
> should we reorder this with the running() check?

I don't agree. For example when an operation is not supported, we start
by checking that and returning EOPNOTSUPP. Then we validate the input
data. Then we act.

Here it is the same. When netif_running(), we never reply to any
request even if it happens to be a no-op.

I'll go ahead and send V3. Seeing how this was only a question I'll make
the guess you don't care much about it and are fine either way.
Same for me.

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

