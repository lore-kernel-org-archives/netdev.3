Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD2389473;
	Fri, 12 Jun 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274609; cv=none; b=mS8zXqhCRXX8SIC5f65lK8w99bg1kowoZPQ0C1Cm6Mbt7eAQIeDbLMLgPOmu+eefoCW2P5d8UGBGdoj9nUYtncF4q0t1hhLe1ATe5ljpmd74adCPt8uUNAW+veXK02Utfkf/1Fr/LRbg2NCNLzMXBbtAMj8hlB+lo0jSH7w5+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274609; c=relaxed/simple;
	bh=CV05QbR/NT8UYNRRsSV3xhwreSaY/xzIwlaUPmi6b/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=D3ZakwrpwnGlXEDBxZhf5JBs3a1KpVfJk4qhXhAFXUueWDar46mSgdAWRNXgmjIo8KYesdlPWSZKMdrpiWbWsNgsvDy0PKBghSJHRL0284trGb1rDsMf0HvCuKD8RkmqmotPK/f7QU4FZ21Hz8/0EgwRVuRESXwDSLfxP/YnEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k9eZw9xm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k9eZw9xm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C3DA61A38E6;
	Fri, 12 Jun 2026 14:30:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FE0560012;
	Fri, 12 Jun 2026 14:30:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D4D4106C86A1;
	Fri, 12 Jun 2026 16:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781274604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aFDFYB9La2SnSg556RWfwxCdEciJqAjpEnzTJLjJUqc=;
	b=k9eZw9xmP3UuCmLaPgcuWj/ncboMzMbxIg9q5pyT5HyxUZs/rUf2v2ZjsSYH41uy3LP5cV
	/ke4C0U1ROIkDOu6H9/TrX29Fbseuw3wFAO/CQfUhqMb8W+yQcvNr7bcwpxV/JpvgBC2O6
	mz9lX52MDZuIgqhFMHyvlnDTbbjYIhGQXB9R7cEN6mM0CCOrbjtWJyoPpCNZd2HU3E5xCZ
	umOh8iOqDqr426Lj2+6Z4fpH88nQKKfteS4Oo2lXTK7yC88oDQ1DDP/HMf3pngIPynbAWy
	9sHzNxFEy2TkQbu1zWmdVouLRVH3qRRR85Df2lTtoBsB8vsEgM5xoJ1e3OxbNQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 16:30:00 +0200
Message-Id: <DJ755AOMTC9D.3H0BRD2WBKN8U@bootlin.com>
To: "Andrea della Porta" <andrea.porta@suse.com>, "Nicolai Buchwitz"
 <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>, "Lukasz Raczylo"
 <lukasz@raczylo.com>, "Steffen Jaeckel" <sjaeckel@suse.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com> <dbc25b24865a1ad92555bc826bef4267@tipi-net.de> <aiwA1dD-qXcT3hds@apocalypse> <85507fd0fb42fca280aca1ee02178ca9@tipi-net.de> <aiwDsd-1IzeBzcaD@apocalypse> <DJ753ZA99KY1.1EH3EC5YWVB3@bootlin.com>
In-Reply-To: <DJ753ZA99KY1.1EH3EC5YWVB3@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Jun 12, 2026 at 4:28 PM CEST, Th=C3=A9o Lebrun wrote:
> On Fri Jun 12, 2026 at 3:03 PM CEST, Andrea della Porta wrote:
>> On 14:53 Fri 12 Jun     , Nicolai Buchwitz wrote:
>>> On 12.6.2026 14:51, Andrea della Porta wrote:
>>> > > The commit message describes it as RP1 specific, but it gets applie=
d
>>> > > to all
>>> > > other variants?
>>> >=20
>>> > I've seen this issue happening only on RaspberryPi 5, but AFAIK it
>>> > could affect also other MACB blocks connected through PCIe, so it
>>> > may be widespread (even though it should have probably already been
>>> > noticed in the past). In the orginal driver there's no timeout callba=
ck
>>> > defined and this is much like pretgending the issue causing the timeo=
ut
>>> > to happen to go away without doing anything (whatever the cause ot th=
e
>>> > specific hw are). So in my opinion we can just extend that to all MAC=
B.
>>> > Or maybe we should execute the restart conditionally on
>>> > .compatible =3D "raspberrypi,rp1-gem"?
>>>=20
>>> I just observed the issue once, but other people reported it to be happ=
en
>>> more
>>> frequently. If we can narrow down a reproducer, it would be good to tes=
t on
>>> other
>>> blocks too (like EyeQ at Th=C3=A9o's).|
>>>=20
>>> So maybe you can imagine a good repro for this issue?
>>
>> Sure, it's happening quite often during bulk dataflow, at least
>> on my RPi5.
>> It can be reproduced with the following, issued from the DUT:
>>
>>   iperf -c <SERVER_IP> -P 10 -t 3000 -w 4M -i 1
>>
>> plus, of course, the related command on server side: iperf -s.
>>
>> It usually happens a couple of times withing a few hours.
>
> Thanks for the reproducer command; I'll run it next week.
> I'd be surprised if it reproduced on hardware that isn't the Pi 5.

Sorry for the two-step message. I forgot to mention I'd prefer to have
the timeout callback on all platforms: don't reserve it for Pi 5.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

