Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61460383328;
	Thu, 16 Jul 2026 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219477; cv=none; b=NObC5cMoXHSD/x5xXa1WIDwBrZKsl0Q4E1sMa9xWv2EfqS4/bvraqvvzWlK7iIOHXjrWgLgy0MCRSAS18LFgd2+lnRCBGGGOSyEJlDHsOCsw/zZLgsWMrhb5S9K9wEkP3qxltmMxtEAutnt5Sal3OgpO4LlyJnrxVoERDI5yEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219477; c=relaxed/simple;
	bh=o/42fB3TPU5yfwZ1YaAF3aMF6rtbmmCm30tk3pRuTr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDU/LAvdJ+mKgIDe8Lx6uX7n7jt0j8TXNpUxtNTKcAPNAEtTdqA3TyGqI+ewUSfvFInkeo9gCE7nFJRXyaTcsTiLvAIE3ep2lz+mGrEIc0zSBrGurGbEN+2axl/+q9/HiBSukQdnjtee4FXaQcViNQAB+e9yoebolsOrsvfwct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OYHPcFkB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OYHPcFkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784219436; x=1784824236; i=markus.elfring@web.de;
	bh=Er8xGM9aClLTdfDDuJ/XAqukZmdzx+1iUqxt+9SWYQM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OYHPcFkBQG3fBNNf5LYIy61ozgDnwCFn6sBcYJijgtdkZDi9vxFFNsdA1jkHeMsP
	 rXxItB44Tpm4mTuIC89SGIPUhKpQDeu+i5ju0aHfcqL/9DqStIcEZtwO4iZJjO+zy
	 8onEFktqCjEHIJahdCkwRR6LSK1no5psI1/pNUjoAUu9mbcbQjts4IiYfmmCjQ1Cv
	 qdcgbk92ZrFza1sQlrDZu/8zG3gYMOF1LzNc0RGgf/YbTgrynGKWkePU2E6iqgmzY
	 HifccbO9l00fRIlLA2It/QJ0U8WXalFdeke1c48RYlY4eao0KBdJBXeA/cMPeNvJb
	 elJW1VD4iz7ScDLTnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVacq-1wcnkG2OCi-00PBwJ; Thu, 16
 Jul 2026 18:30:36 +0200
Message-ID: <ed21aabf-5c97-4e80-9b92-e3fd095b70a6@web.de>
Date: Thu, 16 Jul 2026 18:30:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aliA1EIIrX82jGR-@stanley.mountain>
 <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de> <877bmv9fif.fsf@trenco.lwn.net>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <877bmv9fif.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qkAGlb6LE5ZQfy5wXA29DmYXJQXKuq/VglpSa9fbmhVbVutpEKH
 CuOuOP8Czh/J0qNyAyKKSWnRv8D1RvhHka9+Uhbm5RO0HndCwC88V1aROH2f9cQu0zBleDU
 uZFtTzmcR9Ispy59wNJwlYZh1mYdDspL+UMmcUzefcbv+x4d+eOYLLIUlyVujnv+qKDwEKD
 1jZLNB1JCTLsQrzgUTldA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kAf7Y/yEZSY=;lq2HuVIr4/EW3/LCpjeIrjBJrxo
 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
 tiEh2yDDsKBQhcQwPa4JnzX5BCCgbUsjU4fQC28

>> Does your understanding of programming language details differ from the=
 view
>> by Jonathan Corbet?
>=20
> I'm not sure why you keep dragging me into this

You are one of the contributors who pointed a specific control flow out as=
 a bug.


>                                                 - I have not opined on
> this particular situation,

I got an other impression.


>                            which is definitely *not* a dereference.
Does such a feedback indicate a questionable communication difficulty?

Regards,
Markus
