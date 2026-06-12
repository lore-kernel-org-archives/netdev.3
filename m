Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD83074A1;
	Fri, 12 Jun 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268818; cv=none; b=Ixz7V9ciSXnVlNletU3N6/hdEjK/kuhu4yiMNaDrz2loFJIDijoS7CgmLxC9X8bNzhpSfLyBs+qh0X5juYoIB2CrSOADbZaJuy6Gc5gJY9PLrNX88/pj2BBEPq0cPhTuUzEUF6LDiCj/h4jwKL/iC1/956IpUCuG9PhKRolSCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268818; c=relaxed/simple;
	bh=SbBbnkqFuEBxsy92e6y4Uu7nYPMd5yH16bYDCYTkukE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Mdpob50cOTebZUW8oyDKYqkO90Gu1s7a39GAMlvkLzAs6A5Oi6xBANP2GaYXrm7CTJZRoOf6x2UMatZXcAxfd455l/aPtrK2YYTEYpGLiOjlgWMkkYxX3PkIj1ok5lUGHZtzxsDWZcjMV2+6gXYQZOJwRm7RhIwah3XpLm4o1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Hx4Q/M4o; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Hx4Q/M4o"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CAC9A4BFE;
	Fri, 12 Jun 2026 14:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781268813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5TjyvoWU4via/Ypy3GXQXVRXUREfW9VJTOTzTI4VxYM=;
	b=Hx4Q/M4ohqBf2TdOcV9dEEIgp5SyEFEUbkkxOyS4nq9YEvFJOiVOk+e7X6ndp9XAo6gTYQ
	OIO72FLObx3dA4FLgZqggAGNvLGkLRHNOG9phnkr7hpFOHsn8nR0t683eO4Djov0quKp0j
	Hf1zzjllsgwriPX+wKLpBxCkuXwCpLn01wL7UWDZvZYIWNoiic7MBEPsZE29uBotEtbt+/
	g+HPO4aRYCP8Ga4hAOyAlJisX+l05AKDF1g6+Gv8tKn2qzp6jTFG00GgOCZt8ZjaBtUMqq
	g+hroHl+8+vFfC2VLQJw9YHmrZFTeKQSJR+hyNg19zIN9t004irbR9cNnwljxw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 14:53:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: netdev@vger.kernel.org, Theo Lebrun <theo.lebrun@bootlin.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, Lukasz Raczylo <lukasz@raczylo.com>,
 Steffen Jaeckel <sjaeckel@suse.de>
Subject: Re: [PATCH] net: macb: add TX stall timeout callback to recover from
 lost TSTART write
In-Reply-To: <aiwA1dD-qXcT3hds@apocalypse>
References: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
 <dbc25b24865a1ad92555bc826bef4267@tipi-net.de> <aiwA1dD-qXcT3hds@apocalypse>
Message-ID: <85507fd0fb42fca280aca1ee02178ca9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrea

On 12.6.2026 14:51, Andrea della Porta wrote:

> [...]

>> 
>> The commit message describes it as RP1 specific, but it gets applied 
>> to all
>> other variants?
> 
> I've seen this issue happening only on RaspberryPi 5, but AFAIK it
> could affect also other MACB blocks connected through PCIe, so it
> may be widespread (even though it should have probably already been
> noticed in the past). In the orginal driver there's no timeout callback
> defined and this is much like pretgending the issue causing the timeout
> to happen to go away without doing anything (whatever the cause ot the
> specific hw are). So in my opinion we can just extend that to all MACB.
> Or maybe we should execute the restart conditionally on
> .compatible = "raspberrypi,rp1-gem"?

I just observed the issue once, but other people reported it to be 
happen more
frequently. If we can narrow down a reproducer, it would be good to test 
on other
blocks too (like EyeQ at Théo's).|

So maybe you can imagine a good repro for this issue?

Thanks,
Nicolai
