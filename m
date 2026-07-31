Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF230E0DC
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785463937; cv=none; b=eOFyDrqMRcpYVz8IO8h7K8wiuxGn8tbYCpTvDISbWVeYJxsdvKQoILbft5UypgbJI9+sxtxlA/PkNk3/RvZSoumiICsyzir80kCJ40sOWQyhNJa1cLdLh8V+2+/O0rW4IJUGM/zbGVSd9FNY4bd7JVrSYsg0FJk9mhc0R7j5XL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785463937; c=relaxed/simple;
	bh=Ez+/JFeXCDtwc4NVMrUoqND9RSN2ABIDsDipzLsa4TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViIJ/pH0Cp9yqsP4Oa9nO8sDR6kmPBFe6ReqEHXj117mwtnebPuzaqWKLIvfw1zoouzWNzAjq9m/beLRXFswCsbdTnOOgkq566AGQlZ+zbFad8DjaVAFogj3cfgP+BukZH1nqn4YEgsqIxVS7Q/ItdAaxBX52aGZwI6HnD8eBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=set1ZuMU; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="set1ZuMU"
Message-ID: <507ad6a6-52a2-4c68-9ba2-5cc4f92e192d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785463933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmPGEnHMged4MVtOCZdKBh7EW5THeW2s3SZc/Fx5p8U=;
	b=set1ZuMU2l1LJhdbElnaHncW3htVMpJ+LT8KAyNE87oHGeSl7ekI5XfgExA7/eEmyO/xEK
	cH9suoKK28MhKg/0O3j1IwdJeTw1fAH2LwjDMLqOmWbVqqs2wRfjKhxljNqtMwsg7XPFSu
	S0HbUbvxgby2Ctjh8oGiyIouzCzomMI=
Date: Fri, 31 Jul 2026 10:11:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: stmmac: enable MAC rx/tx after DMA start
To: Abid Ali <dev.taqnialabs@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2026/7/27 14:14, Abid Ali wrote:
> The EMAC should only accept packets after the DMAs are enabled.
This is correct.
> Similarly, the teardown should ensure the MAC rx/tx is stopped before
> DMA engine is stopped.

This is _not_ correct. Instead it's a bit more complicated, according to 
their programming guidelines:

Stopping and Restarting Transmission

- Disable the Transmit DMA (if applicable) by clearing Bit 0 (ST) of the 
`DMA_CH(#i)_Tx_Control` register.
- Wait until the Transmit DMA generates the stopped interrupt (TPS field 
of the `DMA_CH(#i)_Status` register).
- Wait for any previous frame transmissions to complete. You can check 
this by reading the appropriate fields of the `MTL_TxQ0_Debug` register 
(`TRCSTS != 1` and `TXQSTS = 0`).
- Disable the MAC transmitter and MAC receiver by clearing Bit 0 (RE) of 
the `MAC_Rx_Configuration` and Bit 0 (TE) of the `MAC_Tx_Configuration` 
register.
- Disable the Receive DMA (if applicable), after ensuring the data in 
the Rx FIFO is transferred to the system memory (by reading the 
appropriate fields of the `MTL_RxQ0_Debug` register; `PRXQ = 0` and 
`RXQSTS = 0`).
- Wait until the Receive DMA generates the stopped interrupt, which is 
available in the RPS field of the `DMA_CH(#i)_Status` register.
- Restart the DMAs.
- Enable the MAC Transmitter and Receiver.

So the correct order is: stop TX DMA -> stop MAC RX/TX -> stop RX DMA.

Best regards,

Qingfang

