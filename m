Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5EE153BE9
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180877; cv=none; b=dUjLPzVOVplKguLZ/iLcZSTWu06NLaTR+mrUFw7smSzmxjxno17SUOrHLXGQPT8e1zs/F1nKQGHIi6nyRl7x2kpy/jcU8JrvlaOOnQwgmcN3tkHN59SlG+0IlUSN/eSf4R7XBMLEd0FvCRdKTs4Fd66vq0e/3akG1X6+vLvWtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180877; c=relaxed/simple;
	bh=YlzjDRUa5zedrADn8TMzv1bPeNHHYcSMsu4/mpoNdQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U42RkHvOELA9Fs3WCKHdiITUQNqxojCDt9unHaUXdqjLv50+8G7UqWSYaw9NOQfqd4d/5E2Idouhj2Z93okCT0V3XxsXbBes+rGG2grF31fCnh/r+JPMmThy0ZUIIX+XW5WgUbJCmseb1DL8MfuRWNS+t4bBAYVOWVbZPlxgeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8n+gomG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8n+gomG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243181F000FF;
	Mon,  5 Oct 2026 06:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791180875;
	bh=plM8wjZGjNhafEdRaKycPgm1I8dsxntCXfjI+a3I+io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d8n+gomGL2lSetvpCpQod5haFq+sGw0xzRDbsVptODwEVgXQBoZ01lrgS6Hdtc2VO
	 BCSl+75/IRPEwSJ0D3X8ZUiHrmeYzxifCB3Vtnt0+81jV5nJ+iH3U2C6caBHvpCMpm
	 Av3aUsFyfAYn6sCVOM5iCJPjwGDiYOxY5fhOpHZ9aQOKnbjD+5R3eG1NkVGL7nWKN5
	 CSGDxr8OWFIaWnl9m8bCkxSfzW2vKq+6fL6hmgIEiojyeFZCuZVriOqNKqc/BgZqH5
	 Iy7Ywa934rFFs2+9Ia/7Cqki2tmCF1ozdVwVTU7yydZ0xyLEjRpeHeO1SYQcD1Kp33
	 MyXw6O8JgNcyg==
Message-ID: <e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org>
Date: Mon, 5 Oct 2026 08:14:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/1] net: loopback: reject skbs with a short linear
 Ethernet header
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, kuba@kernel.org,
 jhs@mojatatu.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 vega@nebusec.ai, bronzed_45_vested@icloud.com, enjou1224z@gmail.com
References: <20261005052249.1914367-1-weir@nebusec.ai>
 <20261005052249.1914367-2-weir@nebusec.ai>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261005052249.1914367-2-weir@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/5/26 07:22, Ren Wei wrote:
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
> 
> loopback_xmit() calls eth_type_trans(), which reads the Ethernet header
> from skb->data and consumes ETH_HLEN bytes. This requires at least
> ETH_HLEN bytes in the skb's linear area.
> 
> An earlier transformation can leave a non-linear skb with fewer than
> ETH_HLEN bytes in the linear area, even when skb->len is at least
> ETH_HLEN. Pulling the header then makes skb->len smaller than
> skb->data_len and triggers the BUG in __skb_pull().
> 
> Check skb_headlen(skb) before calling eth_type_trans(). Reject skbs
> whose linear area is too short, including those whose total length is
> less than ETH_HLEN, without attempting to pull bytes from fragments.
> Free rejected skbs, account them as TX drops and return NETDEV_TX_OK.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/all/2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com/
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---

NACK

If if we do not fix the root cause, we will have hundreds of drivers to fix.

Stop making linux slower and slower just because you can.

