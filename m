Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612122;
	b=p/enPwO88NXzAL9tbwNAiS71t03lOFZb+CF4YlnNfNLq1IDRqmtRkH5bMav7zLIrvOPY
	 sQmwtzirC1AOhd5giuFvPgAZ1giGA2UMCFbnp4NjM4TBgOY2GoniiOn9qpGcUqBTD/L90
	 mTPnHVeK8kU2DPW2WdK/Xof6wKkW0muFazw5Sqd8/zAfVGICI45NKUu2dgkNVPxAYi1uC
	 P0ClSCqCNl+uNUdqbWDxrjwq0oTsaSHbwSY9l4RxPHIqnqrrRKUmee18dFlciJ7/Ct6uI
	 VzDX882Ft/cnMjLydez8BD6H/abi7L/8yARufWaCDRDlGn/oO352GG9Yo/8bTRHstdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612122;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=//z1fRmqXWjQh/7N6utcvjU1J8+lEZQGzJ/Dqs244bI=;
	b=zthPfiYm9prVcn3d6U4GeRqYpi6lDz832W2vicwHDSZtWLmEKtc3jQAY32L/1Vhcjcdf
	 hv3JGnGwhxOnKh0dt7ZLfsTNjIYUp6HjvDhtPAa0+ONBG4KCvYdu8fhfw+xAgUEeNDEFq
	 k4QuxNqVsbSUqXfoYVMIIPEQrFLp5RMYUtqsL+AHO1d3HLZCWfdgIdUnGX5l9egxT/qB7
	 vXF2Rd+bgK0kDAbPEqUGJEL4g75MV76xYqAT/HaOaRy8pILaBsWrQPGqdGynfviq7E+Lk
	 FnAGNBqnLfchQKQ6MvPqM9PERRxO+SWR9la5Yhx2APL9339O3pUT1SVjlNVzmrJ0TbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=GLOI1DHM;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D66606A319;
	Wed, 21 Oct 2026 19:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01D66606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=GLOI1DHM
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64B27A0031;
	Wed, 21 Oct 2026 21:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792612110; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=//z1fRmqXWjQh/7N6utcvjU1J8+lEZQGzJ/Dqs244bI=;
	b=GLOI1DHMZXtsX21nu7Ios4Qs9gubrXOut/Mr2OPLBGWsK15uGZCObmetdILk/TdC1JZ3LB
	/dzblUDLVBE4RCdd2CGTmomJMo9q0srP32B2dhf5L+FmZz8gUZkRRIjQjW2BSbPsBmxuP3
	tO/fiw/iIwQ8gJrKDs7I+aVd1Sqd5R1EaJAYqUIhTeprR5ZuT2VDHqAWIJtRDvMT0fCiNA
	TBjSKAPnLaS7cBnFL2zeJFqDO/RzZhXKD3m3HBTMdFc/srRBZUQuYatxxvf5kkZ/Xh+eC8
	bgoPBxq+Ws10Z+j+g8uBoXM9wN7DgTZEaSSfuLQ+qjkWt0do93gOvTIWj6RVjg==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 21:48:28 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, bryan.whitehead@microchip.com, davem@davemloft.net,
 davthompson@nvidia.com, edumazet@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
In-Reply-To: <20261021192341.361517-1-cbabroski@nvidia.com>
References: <c0117e4e987c3bd349e56a979cbbdbc5@tipi-net.de>
 <20261021192341.361517-1-cbabroski@nvidia.com>
Message-ID: <86df200787e1be614b21a7d009e8f1be@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Chris

On 21.10.2026 21:23, Chris Babroski wrote:
>>> Is there anything special about the 52 byte usage?
>> 
>> Not that I know of. It looks like the head of a scatter-gather frame
>> whose fragments never came in. Does it match the buffer_length of the
>> first active descriptor at tx->last_head?
> 
> Yes, you're right, tx->last_head is pointing to the header of a TSO
> frame and the consistent 52 bytes was just an artifact of the test
> data I was using to reproduce this week which creates a 54-byte
> header. FCT_TX_USED is 52 bytes, but tx->last_head has a buffer_length
> of 54, so not sure where the 2 byte difference comes from. TX_HEAD
> stopped at the frame's payload descriptor, after the TSO extension
> descriptor.

AN2948 5.2.9 says FCT_TX_USED counts the frame length rounded up to a
dword plus the command words, so a 54 byte header should read 56 or
more. 52 does not add up, so I would leave that to Microchip.

The same document lists TX_ERR_STS0 with TX_DATA_READ_ERR and
TX_DESC_READ_ERR, set when a PCIe read failed "and all retries have
been used", and FCT_TXE for a failed FCT sanity check. They land in
DMAC_INT_STS bit 21, which the driver never enables or reads. What do
TX_ERR_STS0, DMAC_INT_STS and FCT_INT_STS show while it hangs?

DMAC_CFG MAX_READ_REQ is not a size either. It is the number of
outstanding TX data reads, 1 to 6, and the driver sets 6. Does the
hang survive MAX_READ_REQ = 1?

> 
>> Which one? Ours sit behind a Pericom PI7C9X2G404.
> 
> Oh, we are also using a Diodes switch, the PI7C9X3G606GP.

Same family then - and I it's known to have it quirks ...
Ours is the Gen2 part at 2.5 GT/s and has not hung so far, but that
port sees little TX load. If you can share the reproducer I can run it 
here.

> [...]

>> My guess: the replay hands the NIC a completion it had already 
>> counted,
>> and the DMA engine then waits for data that never comes, with nothing
>> in the error registers.
>> 
>> Lowering MaxReadReq to 128 bytes with setpci would be a cheap way to
>> test that?
> 
> Unfortunately, we can still reproduce with MaxReadReq set to 128.
> Using the same test as mentioned previously, the FCT_TX_USED now shows
> the header plus ~1 KB of payload data instead of 52 bytes.

So not the request size. What is left in the driver is the descriptor
prefetch. lan743x_tx_open() sets TX_PF_THRES to 0x10 and
TX_PF_PRI_THRES to 4, and the prefetcher works hardest with a full
ring, which is when you see the most hangs. Does TX_PF_THRES 1 change
the rate?

> [...]

Regards,
Nicolai
