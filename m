Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84F31F998;
	Fri, 12 Jun 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274511; cv=none; b=PnMoh42QSMhUKQa2dYcsjebJ7ZvPdli59swgZgbr8ahpOoBrbGGqzO9/0cv4pit5UlFtyxi+LH8IdI3ahWL+v4rF/IY2hYvTm1xnyGX/uYjmwd+vLu3FolIA9Xc2Oo4xH264XAqhrGUdUAPlD46S9WsSgyqq14tUD6mYp3nL2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274511; c=relaxed/simple;
	bh=koZxd/MIb9jWCQbaGZnS16c2J34RzvEjEezffzgN2Aw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=gkFsLwHx8rPvdRfNr8KSxd3DGeVVO/DS8qF5J7oSFPOEgkVfbXMTypbvBBWNODwRw7pproN4SoT7iR6Be19o/rbYt069RHmJBDbrDtQ5Ek487Bnnx8P6QXVVhLOdPficARjhmAYOKCNpYU7S3C+kxw+jaFOzWuCKUl2Saxubbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MJYvamCr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MJYvamCr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 31D8BC2F4C0;
	Fri, 12 Jun 2026 14:28:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 440B560012;
	Fri, 12 Jun 2026 14:28:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84BC8106C8B2C;
	Fri, 12 Jun 2026 16:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781274505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=slSTtMyXDmBj66fKf5VTlY5WOOmySMnBl++KErL1JIE=;
	b=MJYvamCrG4GjPKD7ERZzEZaVWHZ/NaEyB4S6h4rA8JFNecsBODfbD8wrngW6R1jIduGv3/
	ek0JC4UT+3iki/UI7JthyknaB8GPW02tCHxUNzj4w29bPKCKy79uskExuZbXqXijX63B+U
	8G2bYXfvRH/B8Ffqo6dK968uTAfUWHikM6ZMX9iYga1nVKk7d/gPMdCgjBWpM/c/KwKqOS
	+xoWR8UjFBw8h+x0h+IF5RtfPf+aTfNSPiyIzqsOvobgfe3h8KEz5/TKvdTjPYBrvfvGNx
	wok/1OneZMI24FdXBh0VtGI81/eVPURe6hMajNMs1J2Rrww4kQ1v+Cw8S1Y4aw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 16:28:17 +0200
Message-Id: <DJ753ZA99KY1.1EH3EC5YWVB3@bootlin.com>
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>, "Lukasz Raczylo"
 <lukasz@raczylo.com>, "Steffen Jaeckel" <sjaeckel@suse.de>
To: "Andrea della Porta" <andrea.porta@suse.com>, "Nicolai Buchwitz"
 <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover
 from lost TSTART write
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com> <dbc25b24865a1ad92555bc826bef4267@tipi-net.de> <aiwA1dD-qXcT3hds@apocalypse> <85507fd0fb42fca280aca1ee02178ca9@tipi-net.de> <aiwDsd-1IzeBzcaD@apocalypse>
In-Reply-To: <aiwDsd-1IzeBzcaD@apocalypse>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Jun 12, 2026 at 3:03 PM CEST, Andrea della Porta wrote:
> On 14:53 Fri 12 Jun     , Nicolai Buchwitz wrote:
>> On 12.6.2026 14:51, Andrea della Porta wrote:
>> > > The commit message describes it as RP1 specific, but it gets applied
>> > > to all
>> > > other variants?
>> >=20
>> > I've seen this issue happening only on RaspberryPi 5, but AFAIK it
>> > could affect also other MACB blocks connected through PCIe, so it
>> > may be widespread (even though it should have probably already been
>> > noticed in the past). In the orginal driver there's no timeout callbac=
k
>> > defined and this is much like pretgending the issue causing the timeou=
t
>> > to happen to go away without doing anything (whatever the cause ot the
>> > specific hw are). So in my opinion we can just extend that to all MACB=
.
>> > Or maybe we should execute the restart conditionally on
>> > .compatible =3D "raspberrypi,rp1-gem"?
>>=20
>> I just observed the issue once, but other people reported it to be happe=
n
>> more
>> frequently. If we can narrow down a reproducer, it would be good to test=
 on
>> other
>> blocks too (like EyeQ at Th=C3=A9o's).|
>>=20
>> So maybe you can imagine a good repro for this issue?
>
> Sure, it's happening quite often during bulk dataflow, at least
> on my RPi5.
> It can be reproduced with the following, issued from the DUT:
>
>   iperf -c <SERVER_IP> -P 10 -t 3000 -w 4M -i 1
>
> plus, of course, the related command on server side: iperf -s.
>
> It usually happens a couple of times withing a few hours.

Thanks for the reproducer command; I'll run it next week.
I'd be surprised if it reproduced on hardware that isn't the Pi 5.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

