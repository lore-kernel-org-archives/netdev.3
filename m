Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087480;
	b=FtfFzDw15Tdu+kIDmveWYT/GdmOgPJslhMqTbR+CoaXAIHHxaNdjLMZk14ZHedJPEy+t
	 uzzCxo+n9pjp6BGFhNt9uhuXkdfXiJ2WgzaIIvYa7hrfOHJ+LZRHmQ5+4d3N8Ms5YL3G0
	 BcBAy+vQV8LdHRqFvipNjOkAB7Qh8QjjC1UNUGbHFE2DXeQokITQosrJcT1x0OG3iorBl
	 VQOM/rTN+S6gEgz8SKhwLPPlzgAc5WLOhow/nnyrCTpbiwg8dzZ3DYwKg5MiX+W29bIdO
	 5r1lEQUKyGl4ifIqvIWwQDGBDcN8JgybBz8+anpsriYe795QyjRR2dqjjV3NfSv8IKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087480;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=LUDVMesfYjjT6jM/x7DqLRn6ypp4lsWHpqnJeBC+Agk=;
	b=fs7gupvCyP1+xdPgQma6gejLLafCty+J6xXi2m68YlYRVOds3jywK7ZoMuTVn65PtI55
	 Hz2DY03Zhq0zkAX/+r5MUNlq6XkUMGWqcd1UdukGJI3t/BsgODUAdmt/d3aHmXdBcMazN
	 85CEQ3wjORXOu8+UxB2bZ8ceeoSBAZJDoFubfD0OaqLVXxEopVlUPK6oiJY/iCRYTA0yV
	 HcoXP+2BWRioFj/25QtEoRCMvBWdXcTkJHQ77az7sYGH+BHJhafNqpANyEZaBr5mk00vu
	 tt+AIn6mFGW245avpwNorFR6SUBg8PugrTVaycH9aukvOCx0jYS6ZA9fZ5Va7vx1pIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AMx3g863;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47085606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47085606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AMx3g863
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 66B641A1366;
	Tue, 27 Oct 2026 07:51:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 325C2603BD;
	Tue, 27 Oct 2026 07:51:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96C4310329027;
	Tue, 27 Oct 2026 08:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793087475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LUDVMesfYjjT6jM/x7DqLRn6ypp4lsWHpqnJeBC+Agk=;
	b=AMx3g863HeNKbE7xvsT7Y2rhHJ8FyuBgsyXCw1NvymRLC+wEFflZGelG3ZdLY/E6PhLIBx
	ptV+vwLzduW0qFXEyu16u0urTHM/K0LnTPkAZfn6mEyYiSS+QILspBrB69pahMeFnZ8iEJ
	G7NZlmGxonr1fSwzm9WqaoNM4okLVe8uUn5Uj9sSeXTTDMZLxtPBljzwOEiHKiSZOblbDQ
	8RZaOmWFALzShNuT2s2rwU2ouZag0Gkys+CqSMkSAK6SfaWp+UaHBeSXCFLobGiKrqSGAk
	gwxbI1wKypOeLwf2feiLjCxzY4AcENw09OIhGf/Qdsfffs4nq8ykBAxFwaQgIQ==
Message-ID: <4cadb163-0cae-4a4f-accf-ad0e7eb2c43c@bootlin.com>
Date: Tue, 27 Oct 2026 08:51:10 +0100
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
Subject: Re: [PATCH net v3] net: Use a dedicated flag to track disabled napi
 instances
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022075757.1164283-1-maxime.chevallier@bootlin.com>
 <20261026163357.5d1bdb29@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261026163357.5d1bdb29@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/27/26 00:33, Jakub Kicinski wrote:
> On Thu, 22 Oct 2026 09:57:57 +0200 Maxime Chevallier wrote:
>> Trying to disable the napi threaded state while the napi instance is
>> disabled will hang forever in napi_stop_kthread(), as it waits for
>> NAPIF_STATE_SCHED_THREADED to clear.
> 
> does not apply

Ack, I'll rebase and resend,

Maxime
