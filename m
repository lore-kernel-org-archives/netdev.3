Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359828;
	b=EXkLuii2VYA7Ds/92cDAFm+/Dhf9nM/+91WmLlxHW6ggvDPMricm/yPXDjdGxK3amT/m
	 ndpYvxCALqyi3ZA3U7wdMMA5rKg+59J+8CBdSNNVnZyfJpXnpL4ysF8HilAuih1g4e3Wh
	 z70mOtFEWAV0vL2wJTcgwhTt6IcjWUNeEP5zk0GF/a9/+3RlAjf7EgEGtTFJp6gNKPh0N
	 l1dqfcGFT+OQToBknxeabwSjBjLAYhhaefkOnF2BUtSqJR37Ail4nikkIhgaXJbV1CBLP
	 KBB8BEeMYjlYsGe8dhiPc66AkYqwqegMEOBiFCYi3o71uFXe5qdxzWXQx9V6tLKP34w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359828;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=Wjn/MlK6pPZ2V47wNsly4oAt9XyqCnE6tIvwNWZKzvI=;
	b=BFRhOORLvm/r3K3LJL/BIwDPIe+FTXQCmmMWYlWgsE3u3xjQxClqmsbPK/aCywPj45zS
	 04wcHkXWr3XtdmBWHInOzumVe+PEExLg1d13KHEHDlLag5voYDcQHg4OUx+cHjVPMTHDM
	 Er9xE4ygrdd6QB7iI58WtbiLp2kofoAqwKgREMApA3Woez96w+VXWRr0445joja/QRR5E
	 KnGVmzihMtppuSgVyApZicVsfqqICfQNlIfiDrfz7K46OU/+w5lwv1rnfn9rPFod37Qck
	 Hs72I4uHySEt9thVfbqNlY3aMykRrr1/OAxqgfcSybf4Bt+6NdTzuR4NnHEqJH3e96A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SH5ktSCn;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768E606A31C;
	Fri, 30 Oct 2026 11:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4768E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SH5ktSCn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6A1824E41396;
	Fri, 30 Oct 2026 11:30:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 27D31603C2;
	Fri, 30 Oct 2026 11:30:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BA2E103290F8;
	Fri, 30 Oct 2026 12:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793359822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Wjn/MlK6pPZ2V47wNsly4oAt9XyqCnE6tIvwNWZKzvI=;
	b=SH5ktSCnbPqCClJmh2OAm8RmALoRruSzhXpWFNl7omx8QCb2DCa4rjCKvyPFcZpNldLcLv
	KklcM8WPVzvRt/CJ+dSflE0+mfplzL3C3sABZXl9Q/SVVRFs3oeA2UZ3z+vZtFZ+6JiPxj
	50k8jJ8WUZX2oCsf4v1rDwKMJiCJ1AFGjuU7TM1JVB/+JuczugimF+6JFFLhLDmIdtRo4z
	qpKoNWuT0m1FL7I/9tSYV9Nh7vkK4mL2XWXlX3oepcnqmJlvJEh4t0y5sQc0ePboJitGfG
	5qNr00iyC122Oq2NBMf8AJMICv7WNMJPnXYhvLnSQnM7XZ2UWydhD3Kj6jICZw==
Message-ID: <3b37693b-bc91-4c76-8df3-7e66743b156b@bootlin.com>
Date: Fri, 30 Oct 2026 12:30:16 +0100
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
Subject: Re: [PATCH net v2 06/14] net: pse-pd: check the PI state under the
 lock when setting a power limit
To: Carlo Szelinsky <github@szelinsky.de>
Cc: netdev-bot+sashiko@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kyle Swenson <kyle.swenson@est.tech>,
 Ross Cawston <ross@r-sc.ca>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <179274321449.3134.2737207729630977183@kernel.org>
 <20261023215441.1087277-1-github@szelinsky.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261023215441.1087277-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/23/26 23:54, Carlo Szelinsky wrote:
> On Fri, 23 Oct 2026 08:13:34 +0000, netdev-bot+sashiko@kernel.org wrote:
>> [Severity: High]
>> Do admin_state_enabled and isr_pd_detected really mean the PI is powered?
> 
> Kory, a question about pending PIs. A PI can be admin enabled with a
> PD detected but without power: when there was not enough budget when
> it was enabled or when the PD was detected, or when a PI with higher
> priority took its budget. Such a PI passes the check in
> pse_pi_update_pw_budget(), so setting a power limit reserves budget
> for it if the limit fits. When the PI is powered later,
> pse_pi_allocate_pw_budget_static_prio() sets pw_allocated_mW again,
> and the budget reserved before is never freed.
> 
> This was the same before my patch. Should set_pw_limit skip a pending
> PI, for example with pse_pi_is_admin_enable_pending()? If yes, I would
> send that as a separate patch.

Sorry for the late reply.
No, I don't think we should skip setting power limit for a pending PI.
Lowering the power limit of a PI could allow this pending PI to be 
powered again with a smaller power budget.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

