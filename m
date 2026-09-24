Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F04A0922
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262851; cv=none; b=OB3g4FUih0mol6Ts5wjjzwxii10fYEOB/558zIIgzp+g65nL+YTltxekELqDJkMCxdr1Jmxu9YWtpepvD3ngc7Z4piXYBYo/1H5HFEXR/iSDrdLXeOZ1vMpkVqInmqZFrTIYc3BnknOz5EMeJoNupCkivwLqpPNYkS0DjM+pwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262851; c=relaxed/simple;
	bh=+/0bDQSFP6S7bORogvsjMvBLLtcWZkmTIbYT95K5lGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=I/FuMZG/BRR0JR/XOSZ8e7xoSTIyaeW6cwTJqH5heJwX/nIDGQNoe9NDebj7Lj1Q8ibRnfMDOAPjwbzLuMO1GW0j/U41rEu8YwbgWg9oLnmVgYXKruEqgbuWS7D6/BIT+CU/JPgUJS8N5sSPCGRWUn7TjgZ1ZMAZOXM9zJtDaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zautMwzP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zautMwzP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9F2EBC211E7;
	Thu, 24 Sep 2026 15:14:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22A3A60341;
	Thu, 24 Sep 2026 15:14:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7135910329514;
	Thu, 24 Sep 2026 17:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790262842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IbFstMQFyQndZ9dZecL+Nj71fT2xOKf9PZnnDOeNVhs=;
	b=zautMwzPU0mAUhtPbANHdl+XEEl53NBewYcxYgw5XWoJ1q0eTmhYetZwA8For/0gwP6yxE
	0AuRbCpFHq6jqN3CL1aNoO8+CbIeecAuRqXqRcMMEN1nK7zTJraxRMDOhQC89labfLJ0HS
	DMoLcyaL9lB+atJCGXKEW7ybHz6/onuX9CnHMbI0wfqbPhX6vbmSQGyc8hj9MaG1onEMbL
	hv3FCvkVwLdUtBS18WG1gjOLZtXpNycWuCkA3L8gzAhxrdKnRc6uZwlrsQ3xtWMa+7Z5LV
	G+dHdcOZin/p15za27YZOa3mtQOjZamg8ekF7Y9JeHi1CAztDyJFj52oWuO6TQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 17:13:58 +0200
Message-Id: <DLNN7LYYGP7L.3OSN8JZNC37PS@bootlin.com>
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <nicolas.ferre@microchip.com>,
 <sean.anderson@linux.dev>, <atenart@kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <tawfik.bayouk@mobileye.com>, <thomas.petazzoni@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, <netdev-bot+sashiko@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 1/3] net: macb: never give hardware a NULL RX buffer
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
 <179010942002.2160803.8691011751847108495@kernel.org>
 <20260923184756.16ce33a7@kernel.org>
In-Reply-To: <20260923184756.16ce33a7@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Thu Sep 24, 2026 at 3:47 AM CEST, Jakub Kicinski wrote:
> On Tue, 22 Sep 2026 20:37:00 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [High] gem_init_rx_ring()
>>   (drivers/net/ethernet/cadence/macb_main.c:2793) now sets=E2=80=A6
>> - [High] gem_init_rx_ring() now publishes MACB_BIT(RX_USED) on every RX
>>   descriptor of a queue, resets queue->rx_tail/rx_prepared_head and then=
=E2=80=A6
>
> If the AI interprets the rx poll side correctly these seem like a major
> flaw in setting the USED bit :(

Yes the AI is correct (unsurprisingly). But two things:
 - before this patch what happened was that HW read the NULL descriptor,
   so not much better
 - we can detect in gem_rx() using our ring buffer cursors that tell us
   what we've managed to allocate, that we gem_rx() doesn't iterate
   over descriptors that haven't been allocated

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

