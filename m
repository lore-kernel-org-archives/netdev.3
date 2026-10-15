Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA33C769F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074825; cv=none; b=HWpvaqCwd5+Gmn4J8OAp0iJTOLOKLgO1ygo04M81ne2dB8VUfRPG3/GgsowZrywzgFQuKOfd+m8BP++D+HxwnVH/oxUO71WDaIS78jOoha0CzRNIgHrmtA0+tt1r6zXOkb01uUvTICjWxCE4RoZ+dGlxVjCTGiCdKpIsDfCKcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074825; c=relaxed/simple;
	bh=lJ8uafm3LprrM1NvRQ+3WyFF7idbRTUucVIPhG4JwDg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=nPNx2uNijHJiB0IwOa59GSfuhtXTQ2onVN8XLozwke7rwguxgSlKKDGNjzpGHq5TU4AP0ovm0/46OFsys9NDnfai7UUpN+qNiRcMAXpQChRYkJDL46WJPlImcHg49b8JIij3C+tB6knYju9JfRPdsAs6DmsH4f3n/HpmNeSzL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wrwxjhuu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wrwxjhuu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A46BA1A123F;
	Thu, 15 Oct 2026 14:33:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68B056075D;
	Thu, 15 Oct 2026 14:33:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63F7810328C54;
	Thu, 15 Oct 2026 16:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792074814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lJ8uafm3LprrM1NvRQ+3WyFF7idbRTUucVIPhG4JwDg=;
	b=wrwxjhuuEYMvJSUzhQaV+Tjbdes3sWqujxzFkIF6AdwXFgjWlhLtI8OYXQbNbPchc5ON1Y
	0MKFhebuUbfvRtfHqIrT15ZXLvhZ4MFfSzcw89g4nI3sUM4c0a+A62rTPMjQ4knRkWiqei
	FZc3yetRhpamGEuKYTNCTSdGyEyFmZ+TSD1OvEj1YtklZzoWOH3EMTooKEkQjtLiAX2lfr
	dwFIbXmTsRc6rlDqJ2ohEV6wMbFdn0fbrhfd0CnMENN3F6BAGwHaLrCceIYTsj83jgffNr
	nTQlLUFKgGJQdRDKavavdnGwDmAI4RMbOrNnyPsFZUUt+hspU+GGoYhMlPqoLQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 16:33:28 +0200
Message-Id: <DM5HI1QLI75X.2WIXP1OTH6CV6@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v11 0/9] net: macb: implement context swapping
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <stable+noautosel@kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
 <27d764b0c5c72de4aff77160b9efe8ef@tipi-net.de>
In-Reply-To: <27d764b0c5c72de4aff77160b9efe8ef@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Tue Oct 13, 2026 at 9:04 PM CEST, Nicolai Buchwitz wrote:
> On 13.10.2026 15:16, Th=C3=A9o Lebrun wrote:
> Tested on a Raspberry Pi CM5 (RP1 GEM) with lockdep and KASAN enabled:
>
> - ring and MTU changes under bidirectional TCP and a UDP flood
> - ring and MTU changes while the interface is down
> - ring and MTU changes during autoneg
> - injected allocation failures in both paths
> - PTP and EEE after a swap
>
> Everything worked, and changing either no longer takes the link down.
>
> For the series:
>
> Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # RPi CM5 with RP1 GEM

Thanks! I hadn't tested context swapping + PTP or EEE. Did some PTP
tests just now and it is all good here as well.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

