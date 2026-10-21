Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576050;
	b=48L/l9XVFHual7yKdP+IRCT033jViF3FhgIdlDGJ/LhcSZxkNn5oq2zixaTNmMI+2XH6
	 0KBOGJLXxZvEeEgs2NmWTMkNLsja9XIymCUvQDQuC5YnAW+1bBf7q/xanGrrKV/Y22COa
	 kj9M9fJctbTjiimYoqSNcIWfXZB9GsUJ+SiJX/ZsLt1umjn4D3yzM3p6k7wWtiyyRal7I
	 yQj1cyJYNPhSybMvnO6X1J5mcn/jOQae7a+TNJMkIZSO0LIXu1cTNSHCDtjNBAPcnbTqg
	 r9pZuHeRuIkMji8lgvs13E+w0Skuk6yFg4FVt+LFVsrbOx/JX2633bBQ5LbWE3jXHkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576050;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=V2A2SjsEBDtbNNGNZqLRA6EbJCTC8KfylpwfOOFsjsE=;
	b=ifMbkcRRBcSE7JsFKH38HLp4Nzy9LMRCy8zI+OX7J9gWZgeeilbIz/7yiJTSRAT9k1IH
	 Gi2lWawyavzbO5wPRslobbIr8gKMkqSrkZ1CtZM9VxatKjjOkiPwKJw3p5/7ohgBPnlcD
	 Ty/xjCD+RFDoASRLM2FaiTPR0FnE/Pz/vVEnoc1uABHIyfAk3GfYo4Tomicif7Ciq4cMh
	 Un4lS2+Au6ifGBUqUdqArQMsw6gkBFNzKc3TZGaYC99FoHKuFEAUNbTDlKSOLt9cb76GS
	 s2+/GciGRlSVSaNImMMP1f6k3ji5t99rvGk/FVlYWywYu5XU+vwnTlzg+ljO7ZP0srg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h0wodTqI;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D03606A31A;
	Wed, 21 Oct 2026 09:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h0wodTqI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C50261A12AD;
	Wed, 21 Oct 2026 09:47:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83748606E3;
	Wed, 21 Oct 2026 09:47:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A8BA10328934;
	Wed, 21 Oct 2026 11:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792576044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=V2A2SjsEBDtbNNGNZqLRA6EbJCTC8KfylpwfOOFsjsE=;
	b=h0wodTqIz2tp/FsrB/CjwzC+YrOz6Q9mYoZWxDpBT30w5ZSLzjrwPHT9n7xKEpzbvEVufr
	ku3pzPKiYlTVunEjYt/vG98kwkcrSvuqGt4nRpEpe7jpaIDHnfpWgn9LfEHAQ+Wtg12gCK
	H9c7qhE9I8zhLPDd9PFCBmdh3CLj9e7T4wc7AEnfOVd3JkPHg4rJyhPjcIZnswGYNcN6sH
	srZlkpH4ni4OQSOnZC4uJP387gDLEE2qvdWlW8Py+RV+/YOkS9R901IX/dxccUDvVv2R56
	FH0P4vMgUPchXILxzDQ2LCs03Cb3UL1TLhEgDadUEufNtqw32vWQkhNuWifYUA==
Message-ID: <65a821ad-e219-4f1e-b76d-6cc8502eb117@bootlin.com>
Date: Wed, 21 Oct 2026 11:47:12 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 06/10] net: phy: phy_port: Store information
 about a port's upstream
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la, chleroy@kernel.org
References: <20261016133107.54054-7-maxime.chevallier@bootlin.com>
 <179241678791.3135.1638003219102257102@kernel.org>
 <130d9b15-238e-48c6-a293-f48e7d1ada06@redhat.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <130d9b15-238e-48c6-a293-f48e7d1ada06@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo,

On 10/21/26 11:24, Paolo Abeni wrote:
> On 10/19/26 15:33, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 0 · Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] net: phy: UAF in upstream_port when connect_phy fails
> 
> I think this concern has not been reported nor answered in previous
> revision?

Well it's been reported as low on v17, but this issue isn't correct from
what I see from the bot's analysis. The bus->phydev pointer is correctly
cleared, and for the upstream_port part, it's also not correct. the case
explained in the report can't happen :(

> Same for the ops-lock related in the next patch.

So for the ops-lock, for now we simply don't use phy_port when using ops-lock,
and there's a separate series that has been sent that addresses the ops-lock
crash when phylink_create is called prior to the netdev ops being set :

https://lore.kernel.org/r/20261008022656.3592191-1-mmyangfl@gmail.com

> 
> I understand that the high prio comment on patch 9 still relates to
> PHY-in-SFP unbinding and should be addressed separately, am I correct?

Yes indeed :)

> 
> The problem is that the net-next PR should be coming very soon and
> the backlog is still very long, we need a fast clear-cut.

Sorry I didn't aswer sashiko's feedback sooner, it's getting a bit
overwhelming sifting through these, and when I tell sashiko that an
issue isn't correct on vXX, it comes back with a similar comment on
vXX+1, with a different severity :(

I understand your point as a maintainer though, I'll make sure I reply
faster :(

I've done my best to test this series in and out on various HW, including
the MAC -> PHY -> PHY setup that sashiko is concerned about, and I did
not reproduce its reports.

Maxime
> 
> /P

