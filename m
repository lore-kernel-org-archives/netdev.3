Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103295;
	b=FWOfe4HNScrTiWS3MJLbynRsi0dqLRJKKnF/IOm3xXE1887+lZK8ctvemhd/lDAy2vUs
	 yN+nJskRf2el/TFqh3JVfAyTjLpBGbGU51XmA3oHxHRg1tM4Jc5xcYu5fs1qFDshI6Doz
	 mnLYo+b4/ZiAHWU3dfM0QV3MOjgRwAcBfpmNdnA7p1yh3+69/fuOPircPCE8iZH/J+uR2
	 ++L83MpscCHfiSvOL3kTTRabZ1K0K1/BzTO94PVX8grFCPuw0Zo5LN2NlQFCVFDJFkhXR
	 /dzFvzxoteTgG+S0nb500jpBDu2grqHc9RiyLRGNrnXkh8+JuFr4LtAhxEwtGl+MLLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103295;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=W9eRxKylZ2IDdUCQv0zvUbAtiUFib8STcgRGkP/FDkc=;
	b=QkO7g8q5aHcYAkB8CVSmSLCJ4draL3H/tfH0sQHer62Wk61uFw6MXKKplsrVfXAyui0z
	 piWVa+VxRrwvpLPobXozOUu2cOuQSbVT2EVB5snigyeezhQreopJ0DeI2DxfDSKKiUpxh
	 f8tlvt7Yn5iO3ODb3EzTD8usiw8Afhc6nJ13wV70EZm6aacWmlIVBjftApqWWttPTu4Xw
	 tgOo8AU73gX1hDkThgTCCERUiEtG32csrCAuDyFAO3UVVtVy8zO/9ahlxYA4EhxQhEitL
	 TsmoOEX2bCngIpXTwSGfWmqxypA3Axf2FpaJIibfBr3am4KnQWHQcSUV0UoxiaGbt3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=N6cm7en5;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE7606A324;
	Tue, 27 Oct 2026 12:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CE7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=N6cm7en5
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FF1DA160B;
	Tue, 27 Oct 2026 13:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793103285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W9eRxKylZ2IDdUCQv0zvUbAtiUFib8STcgRGkP/FDkc=;
	b=N6cm7en5vAwGPTMoOJJMiJaZktzohdMuhQKcSNF6WD3kWBR4h6+3JD/J/35unxOjjViP9Q
	Uab90tDWUedy/X9JzhUqkeY1tXWG5Ns4bRPCNMmN8zJYQknHkSZ9D4mKooIOeEttmJcbz0
	kon5sDIw+L1jp4lema2EV9oEiDX1HjHZP7twOZh6AeAnVTR2Na5M51KplGZeIMCfXlTelC
	Qa16taAtTRPPCbDnkXMRrRDz3hfjdF441PltqpyiEXN/cryjIREkvMIoNT04mDIdhjL1bU
	Rb+Q8fpOKYALM7ZRZXlic1Noxka0k9Btph+vq9S2mnWjeBhB8WWygyJyqMuxfg==
Date: Tue, 27 Oct 2026 13:14:41 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
CC: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_v2=5D_octeontx2-pf=3A_fix_skb?=
 =?US-ASCII?Q?_use-after-free_with_ipsec_crypto_offload?=
User-Agent: Thunderbird for Android
In-Reply-To: <cf0a87b7-1039-4688-85eb-9efc8a25dfe5@redhat.com>
References: <20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de> <179296218017.3134.5170259489302207876@kernel.org> <cf0a87b7-1039-4688-85eb-9efc8a25dfe5@redhat.com>
Message-ID: <3703F128-A6A9-426D-A177-2E804C67E2F2@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo

On October 27, 2026 12:49:44 PM GMT+01:00, Paolo Abeni <pabeni@redhat=2Eco=
m> wrote:
>On 10/25/26 22:03, netdev-bot+sashiko@kernel=2Eorg wrote:
>> - [High] The fix only partly covers its target=2E
>
>I've mixed feeling WRT the above points; it's (borderline) pre-existing,
>but it's IMHO bad enought that should be addressed in the same fix=2E
>Thoughts?

Let's make it a proper fix, instead of adding another patch soon after=2E =
I will send a v3 within the next days=2E

>
>/P
>

Regards,
Nicolai
