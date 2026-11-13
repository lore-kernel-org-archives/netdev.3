Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592939;
	b=VAQ6qoQOqfvtls91m1M2oYG7bOeuicURuITXLm/uf30oVgu6DgA3/ATKuBvh3mqjSL7R
	 yNcm+SXNXd461bLK4Y07vrWvJy2Pf+ltHPSTXETwzuncpbPUXTwQDncy4tVtACe8dOxYg
	 SrWdAuey8YBlgQL3GQoDGNgeCQ8sNlTzBk9R8DsyYuEl+TjInA2+pgVljRXNLmrwvX4DF
	 /YFpo7BXp4gPogXWPYuc3oloUW2wfC7XSF0V8k76ugkZ7AGCMrPFpd3MN5HvpfezWVHgv
	 bEdo9OzeCZLsHSkyPmRNw4elS3ulAmA5fXjwSdfK/w2EK2TY4TxV+UwrVS5wAefeoew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592939;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=AZhLC4R/ehnx/+P1FYHV2iFa4HxARqJtp5XQSxT5Tyk=;
	b=iNS5K84sCZs9lCVrwXI3edgiM/OebTCcihgydLoL2dsvg6AR5ORMMUf3IFJkgcOneqDA
	 M0bYxmAKL/9pPAl4kKxQeNZXPiP5DOEUBbw9sHlj6we0rKISOcpygMBl9ycCJkVyW2Fjh
	 nMGHYDUaUF9Jkbupl/4f61axYPAKUXguIlEDnrFSqgpaX923CjW6g8Q1LXA/ld+zNiEb9
	 QR2rUL1B2iwcFkt9xyPV6t/au9hLXMX6A0ZUCEBRIAO31PlyUlk9yCgUiOP+vCXRM7uBo
	 mokgSjAs95dssR/IIqcnYmKeNgLxHIBwAiQPer1AxgAmRu4/t27mEZbzG07nM3t8/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=niOrWThQ;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA47606A338;
	Fri, 13 Nov 2026 18:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA47606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=niOrWThQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6F7D24E415AA;
	Fri, 13 Nov 2026 18:02:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DE5F60015;
	Fri, 13 Nov 2026 18:02:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5818411BC1337;
	Fri, 13 Nov 2026 19:02:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794592936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AZhLC4R/ehnx/+P1FYHV2iFa4HxARqJtp5XQSxT5Tyk=;
	b=niOrWThQHTfkWmMR2Mti4KGPvvkAwT+O7JCFcuEIF80h5+w8X8qn/YXKJkoTfZKJV9Y6hj
	PbfPLu75seJudXvZlKzARYRCxRKAElT53iXYbrq6tVEz/PUNlxk48DzL7c/N6USV+x4A4M
	MwxSDSj9wz7SzfcbjLGSwkCEOj5//Ug4Q1vmDGxaLCSbKk/qaSPNl22YAoVZsNq1YaCoFZ
	budFnNeNAWBvnzTFMo+cubYYYPMlldLsima8b/1/K/Hz0vpR0xeLl8e4ttZsWa0OPhWdf6
	ZjUtKmbB6Vb6NHF/dGuTxcle2y44OtkKz6awXN6gxpyrAdP2nxLFIbgWh68kbg==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 19:02:13 +0100
Message-Id: <DMUA3O40LXJX.IGOAYGNZZ2MO@bootlin.com>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Paolo Valerio" <pvalerio@redhat.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM
 segments
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
 <20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
 <20261020200833.601ddd3e@kernel.org>
In-Reply-To: <20261020200833.601ddd3e@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jakub,

On Wed Oct 21, 2026 at 5:08 AM CEST, Jakub Kicinski wrote:
> On Fri, 16 Oct 2026 18:58:17 +0200 Th=C3=A9o Lebrun wrote:
>> Subject: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM se=
gments
>
> Does this really belong in the tree ? LLM can generate such test=20
> on the fly. Side problem that it doesnt  build cleanly, reportedly

Dropped in V6. LLM can indeed generate kunits or extract the function
into a separate C file and compile it as userspace code. And in any
case, the old kunit tests are available in the mailing lists.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

