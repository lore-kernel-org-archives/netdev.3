Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671687;
	b=iqnuZsYjTW1waXQVDYJKYr9Y2kj38jah4ED4Nb2cAfzJ6oU5yFiDL7qS8fvWeIH+V8HE
	 35nHCM1y6yhHyoEzW4dgiM4ZjQtDnDrnEOEGX7hpBdeF14pFXURW17/kyvXCTn4CprgZ7
	 t8EvuSAqFxhUld5l0dzN/XBy15C0fA1yZ/dixkSQCYEDGibw2v1Sr0ppmEyVG2Va6EnIo
	 1Km9mJrP+rFhuhevGHRps9cVENDTEYoEp7g+lDsuHjANFy4RZv6OlhEanndKabAa/pfWU
	 3Qp42bNbL/amjdW9Xcmcd9RaxIyxjDyn39U8AWjU54jQ/Ur6i4QS29B041Da9Kns4zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671687;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=1VTsfeIcf9nFY7Rv1wMZ4skGRa0nTl0ky4r8SPGR3hc=;
	b=UjpXRNEDqhYtE4n/VdqhQuwy3t3lAF2d+bUNKnSiT2Bv2mdjA31fizWLIRJK/dujWRBY
	 6im0G6ZBvB6rBjbimKC5cbIN6OFqAlM5Nxd3ihKiJ5JmqQ2y+1BZwRSUUkWIPxADHxopc
	 XrgvZUFJVu4scRbtmvddvYVmWL0sr4D67tkb1wE+K0VEKReoS50UF3j8j1EOdzgyl25gh
	 tfsW6DRto8PwLg7qIOgV1SahZOsgUjlEidJmtqkyY9WfVs650fpwETgKs01xjsUR/aWWj
	 DeO5KqT1TrWAQi/FnsEvjUTqkRQYr941iNGZ8LFX6KvccrrceLfvIgKVjpSZVKyzUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="v/vkvFg4";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE62606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v/vkvFg4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E594EC58476;
	Thu, 22 Oct 2026 12:22:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B7D560360;
	Thu, 22 Oct 2026 12:21:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90EEF10328EFA;
	Thu, 22 Oct 2026 14:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792671677; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1VTsfeIcf9nFY7Rv1wMZ4skGRa0nTl0ky4r8SPGR3hc=;
	b=v/vkvFg4cURUfgmRhuPtPSwfjiFpjkuw/55sY2/cT/mPqpRRDFwnTTcLby7SnO5yw+ndnW
	C/OlluRS+DNtb5VLK5nYMRBZjmDV1551uu8bp9JDEx0BV2fKSdNUJEerDT/o9FcxBJ+vtc
	aJuUeGwbcJF/Z/EVl78l1ibzw7clkB4RrhX2LEvfEzWxhxkLvIvcdDTLoBjINUrVI4yDN2
	brY3FgViNXRNfFhog/jnZNCTMltztu/B9jXqLqS20c8RIjAppp0BJ0HwELi1owiAsLanKV
	EC5cOIIgG9OmNEGko1YB/z1B/yd+gRjhv/Klu//uJ90KUgCcx3U0Yzuz2asVdQ==
Message-ID: <3a9f47f0-884a-49c0-a0a3-d68ea8bdf015@bootlin.com>
Date: Thu, 22 Oct 2026 14:21:12 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net v2] net: pse-pd: don't enable a PI again while
 disabling it
To: netdev-bot+sashiko@kernel.org, ross@r-sc.ca
Cc: netdev@vger.kernel.org, github@szelinsky.de, o.rempel@pengutronix.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20261019220835.613-1-ross@r-sc.ca>
 <179266373570.3135.5306089916848589884@kernel.org>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <179266373570.3135.5306089916848589884@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/22/26 12:08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 (4) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete: the PI being disabled is still enabled
>    again, and the power budget still leaks, on the priority-eviction path.
> 
> Pre-existing issues:
> - [Medium] The priority cut-off in pse_pw_d_retry_power_delivery()
>    (drivers/net/pse-pd/pse_core.c) never takes effect.

Can you take a look at the above issues?
The other ones are currently in discussion with Kyle due to similar 
report he faced on his series.

> - [Medium] pse_set_config_isr() (drivers/net/pse-pd/pse_core.c line 1211)
>    tests `notifs & PSE_BUDGET_EVAL_STRAT_DYNAMIC`.
> - [Medium] pse_pi_disable() (drivers/net/pse-pd/pse_core.c lines 701-719)
>    always returns 0, even when _pse_pi_disable() fails (for example an…
> - [Medium] In the disconnection branch of pse_set_config_isr()
>    (drivers/net/pse-pd/pse_core.c lines 1233-1243), isr_pd_detected is…
> -- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

