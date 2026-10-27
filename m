Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085887;
	b=Dbf8uAeGg9TPcGb24U+AojuI5mKqqPU0DYGH/ivVaOqpePmMCsosABizDlFEF0ZCLJkb
	 /EjFOHk8Buip3lqpF4adPFeRNOK8Ozv39luG/DOxGmkWt/DSAppTg4k/rk33eqVYHDvSg
	 vVUXLepB5Usd+53lQXzheuroxgkYywPBm7myB6pY0IYklleywY1v/NvEBXQ9qyq2fXC+w
	 YX/QJFLcJZSmYKQ4hh6lOXDL9zVHlLwZorPBeoR7XB022g2WOB5swlnXktBMMkVDdRsag
	 6kZ9aHCD7I332XWje2UJdiqUPd3v0ikjAZCJ4uAnG2wZGuWgF1dDPt3het3h58aJpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085887;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=CAMDTx+A/6qjs3rCvYy7knsHqtM0dksG0ov+15rFt04=;
	b=Z6z3EMlP3A4pPSjXNDujZrQS6wtVxdPJxWBWsbPuNfJtG7Sd7x+gZMOIxXkwwLrGfQm4
	 V1+mvgrH83/v+j+r97IiP3UZyp/w9dp25M7uh5TDH7wmsoEWcaOGlCeQp1UOwpF8SE6g5
	 0uArW010fcw6KNSXp3XBBkVV8/EA7eTFuVZXVigbYinSMMdeMjpAyHrbZS3j47ObcGYek
	 i5YvnNiOlQgX4WQHNwQZilL3Qz5lFsbdEF9JUvW+gTcjGe88+zXdAv0kfqZPRSL4yUqBK
	 11cki4sXlt+eYoM8nLpVsX798FrsN+s7CNJLM+1sSOpPUAvy9Cd6WI4BRFzIzyL+m2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cf9J2xJY;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0A606A31D;
	Tue, 27 Oct 2026 07:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D0A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cf9J2xJY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=CAMDTx+A/6qjs3rCvYy7knsHqtM0dksG0ov+15rFt04=;
	b=cf9J2xJYyg5p3OGduQLHOgLuPBxLc34VnUmNhEwDBR5YQOQXSnWYqgyHUajErX
	N2ExL3UphtwIfGpKrmKg+TeiQkdlPht6CWCWVJE6hSKZnzrlj3xIA+KX8N4b3/5q
	xdc7MM4r5y7rKrSFEFaLNnZiU0vokgxaXwOwHdMcJeJ9M=
Received: from lx2.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3f0x6UeBqyKY4DQ--.54976S2;
	Tue, 27 Oct 2026 15:23:40 +0800 (CST)
From: Zijin Tao <taozj888@163.com>
To: theo.lebrun@bootlin.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: reply to Theo's questions
Date: Tue, 27 Oct 2026 15:23:37 +0800
Message-Id: <20261027072338.106540-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>
References: <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f0x6UeBqyKY4DQ--.54976S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4fZw1rZr48ZF1rKr13CFg_yoWrArWfpa
	y5Gr1jvr1kJF1fKws7Cay7Z3WrXr95GF43Wr45GryIka45XFnFgrZIg3yYqFy8u34xWa40
	vr4UZasak3yqgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwjjDUUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3h5GDmrgUX5djQAA39

Hi Theo:





Sorry for having missed important things. 

I would like to append some explanations here.



Thanks,

Zijin Tao





At 2026-10-14 01:55:03, "Théo Lebrun" <theo.lebrun@bootlin.com> wrote:

>Hello Zijin,

>

> - I'll stop replying inline because you seem to be having issues with

>   your mailer. Please fix it to ease the discussion.

>

>   See here how your email looks:

>   https://lore.kernel.org/netdev/63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com/

>

> - Your V4 commit message says "Fixes: 89e5785fc8a6" but that is wrong

>   with the current patch, it shold use 4df95131ea80. I don't

>   understand why you are talking about the changelog at the same time,

>   this is unrelated.

>





Yes, I made a mistake in V4 commit message with an oversight, it should use 4df95131ea80, so

I just revised it to 4df95131ea80 in the V5 patch, and I will use it in possible later patches.









> - You skipped over explaining why your dropped the start_xmit diff.

>

>I'll have to stop reviewing if you skip over parts of the messages.

>I gave you a TLDR and you skipped over the first bulletpoint.

>





Sorry, I forgot to make an explanation here, maybe due to an omission.

Now I would like to amend it:

Actually when I started to rate limit the error messages in the data path, I saw 

the netdev_err message print in both the gem_rx_refill and at91ether_start_xmit,

and I knew they are also in the data path.

But for the following reasons I just omitted adding rate limits for them:

1. For the netdev_err in the gem_rx_refill, there is a "unlikely(!skb)" to check if

the skb is NULL which is a rare case,  so I think it's not so needed to add a 

rate limit here;

2. For the netdev_err in the at91ether_start_xmit, I think it belongs to another vendor

which I am not familiar with, and I didn't know how popular it was used, even I was not authorized to 

change it with my will also.





If you think it's better or needed to add a rate limit for them, I would like to do it in later possible

patches. 

Would you please give your opinion here?









>Thanks,

>

>--

>Théo Lebrun, Bootlin

>Embedded Linux and Kernel engineering

>https://bootlin.com

>

>text:

>Mime-Version: 1.0

>Content-Transfer-Encoding: quoted-printable

>Content-Type: text/plain; charset=UTF-8

>Date: Thu, 08 Oct 2026 14:59:55 +0200

>Message-Id: <DLZH4LPJ36YW.1CP7RL0J77DHN@bootlin.com>

>Subject: Re: [PATCH net v4] net: macb: rate limit netdev error info print in

> the data path

>Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,

> "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"

> <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub

> Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jeff

> Garzik" <jeff@garzik.org>, "Haavard Skinnemoen" <hskinnemoen@atmel.com>,

> "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list"

> <linux-kernel@vger.kernel.org>

>To: "taozj888" <taozj888@163.com>

>From: =?utf-8?q?Théo_Lebrun?= <theo.lebrun@bootlin.com>

>X-Mailer: aerc 0.22.0-0-gc2f86b7abde3

>References: <20261007053211.572073-1-taozj888@163.com>

> <DLYI3O7PFN94.V7VH3HSLKEMD@bootlin.com>

> <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>

>In-Reply-To: <63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com>

>X-TUID: tHkCkOndXaQQ

>

>Hello Zijin,

>

> - I'll stop replying inline because you seem to be having issues with

>   your mailer. Please fix it to ease the discussion.

>

>   See here how your email looks:

>   https://lore.kernel.org/netdev/63731290.3f0c.1a1198fe993.Coremail.taozj888@163.com/

>

> - Your V4 commit message says "Fixes: 89e5785fc8a6" but that is wrong

>   with the current patch, it shold use 4df95131ea80. I don't

>   understand why you are talking about the changelog at the same time,

>   this is unrelated.

>

> - You skipped over explaining why your dropped the start_xmit diff.

>

>I'll have to stop reviewing if you skip over parts of the messages.

>I gave you a TLDR and you skipped over the first bulletpoint.

>

>Thanks,

>

>--

>Théo Lebrun, Bootlin

>Embedded Linux and Kernel engineering

>https://bootlin.com


