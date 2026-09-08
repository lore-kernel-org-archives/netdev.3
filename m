Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660C39EB5B;
	Tue,  8 Sep 2026 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853772; cv=none; b=SsTi76VZ+d6584GuTtHUCF65YqVT3aw1SxoysReroBmqaRo8MMyblmsNxrv7OVH6jmg2PFzWmHyNvsWh7Ua4hjCK18r+4WJUwgQlUkc+XIOXJ+P+1Oz3DSrIX6tTTh3zDoNyUdhRowFk0GzB9YvN5MX8SipPsMU2HBciX2Ql3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853772; c=relaxed/simple;
	bh=W1yVPeGRaRurs75UMSQJZlfPgff/yDDMbM+M6GFLEb4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9nW4Sl61+pz6seOrtBqUTF2HyoWz+Auyy8GGyN1I66c842vJyXSlcFyjbcvEVCUCVnLq+JHWHjiZsE21TB6b1n9CB9uyZxHTjbAos8eo7n7OxN5deaBN23e8WxuJyFZ10h+Y9iK8uukK30aQGCatw2lvxIhm3Nft7fg/4weoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pFt9Mgw9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pFt9Mgw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788853758; x=1789458558; i=markus.elfring@web.de;
	bh=W1yVPeGRaRurs75UMSQJZlfPgff/yDDMbM+M6GFLEb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pFt9Mgw9P4x+gOqLw00QR/rPRKWE67lzNgJOs1LFxG8nHVn8c5ZonzuzE+CaD4kR
	 mdJQIz/2JYy2/lAv4CtMLRUky9Yb5gicW9ffZ/T3VRQm8rFP8ebr9tZSZVy/HAJGm
	 QD0txZJshaDi4YKHUKDt97drY+ElikAhD/M+muetM8tF+Bn+YYS1oBgh0OuDxvyM4
	 p14/9bQUIuyejAIT5IvqB8BC6rriaap1Ndn/HcIme7KzHHkunrs4s01Uy8lYkcttG
	 rhL/qPCrzSDgnbSAkSBMOhCS9GPdyw3pvreuYBhxtTmSgsfN0t5P5gTPwrOjqMw/q
	 k3bOCHVaOeLzdRFPUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1xICZ73hFM-00WNqz; Tue, 08
 Sep 2026 09:49:17 +0200
Message-ID: <09743e95-cb1b-4750-89bf-6a4a4d96ede0@web.de>
Date: Tue, 8 Sep 2026 09:48:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: ppp_synctty: Use common error handling code
 in ppp_sync_txmunge()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <qingfang.deng@linux.dev>,
 Tom Parkin <tparkin@katalix.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
References: <1d943bf2-d027-41aa-82db-b2f0807a5e7c@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <1d943bf2-d027-41aa-82db-b2f0807a5e7c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sYxrp0aqpuoJqoJewjSNdSwXwnCTR20QQgkLG2CbRB4hiniFJcv
 +U/SAmv6r0UGrXCWEUIu4yuqp8L95G9u/c7rm2GNrv4cscIwc2bYy0rhnVorbKpLOCaxxoJ
 Bif5PaEp/k4F5KIo2vnsXrQ0GCGEtSeKCPoLvb+Ek22IRefmCK61u4VFdvV1u3xnOVUBIpE
 aaPipVUZshsRQxIZ6NFPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VETAhFAu/mM=;yyXGuvV4g6qb1Foy4JBsdYAaB+6
 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
 I=

> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
How do you think about to repeat the proposed source code transformation pattern
after an other contribution would be integrated?
[PATCH net] ppp_synctty: ensure a writeable skb header
https://lore.kernel.org/linux-ppp/20260908072135.877364-1-qingfang.deng@linux.dev/

Regards,
Markus

