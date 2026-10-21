Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565976;
	b=kAbJVMs7+1oqAzvjH1rqzHfLrkp3W3QNFUBI6iPw7bCM+/WvGT6W2cGBk/DwR25HdAeq
	 fts5BlCCweDhuRKd4eAHm9kzEJ5v/mhs1xxjp79DImOxIovXl8WTw3wdOMNMTJnBz7t46
	 rMRs6AeNxuqjroO4/xvEERASyyMsO7hF+YOjPxckgax1+dNTDYk1mWZ6+QI5TP15G7sUe
	 NChzY6Zw6EpRxtd1NjrfKwU5gKtErJRWwECBMA/DYRKDXpgPzRBrqDmxrY60wi9X61fWU
	 FmSI1sRMop1Csp/CbhmeDn5fgqXgR2EORrk2svpbwoI/dGtn7p8pQ3o2WNxsq7GRbWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565976;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=4E1IvoD9qhmZ7oCU5Y397uMFMvWE+PlDEwOMXgDmoME=;
	b=sc5ovTgYDrT+nu/hc26SR4zvDFJ/ZmlqzR95eFGzpY1Y7OhSU/ql/MdCVuBrZTEBGTBQ
	 duzvpHQQcxRwgtK3M+0R+hUgnX3fffdFtCCYVCmO64AvmgBiSZjSqUurIJ5YCMl7HOlJ6
	 ofbmvEO7UJ1BiS1Lok6Hwf6O3OWrQ9xzuDrHw1udzwwFcM0ZbGWGbsSTU5hja4X5k0epV
	 huhGsF/pLMnuWT26kPatWfTBc13dyieaiX4M7S4KjkEl2p7gIFdkAKWavEImJim7EdrYF
	 LHwyABt07LhtQBHwXoyTiAw5ifZjxn5+2kMTccqyulLkkbFtz8ktYXL+ndWFfXFttaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="Zn7ku/p2";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7638606A31A;
	Wed, 21 Oct 2026 06:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7638606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Zn7ku/p2
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 504FEA1622;
	Wed, 21 Oct 2026 08:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792565969; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4E1IvoD9qhmZ7oCU5Y397uMFMvWE+PlDEwOMXgDmoME=;
	b=Zn7ku/p2WoykhCQg7+gy4mHa3HKascBIN/yrC99eSPApT1zuMTU9gGtYjhkkCI7TB5NoF3
	1vDsyXUXnchaYX2dVCzStiIyWK0WO08CY5GjHIVbN5T15EGKNlQwQwn4ATDUTdlEDIUz9+
	X3afEZ7UEgNBJMCbFNiyCYuaR6nD5vLSBwvkcfFq4+QiLyFGuJd/cxX/9xDEBuiHcfpXi4
	m3q8+LAhgjHouCOOUV8UWnPuGStD+gmz78HcbhUqrzjGtRA+NpMr+1szj9zUqYW6cPusC1
	7wkQ6ppR8bOfBuEPB71BLbmqCY63LaCtZIKIGvyGD40/eFTF7LiLHyfyt+DxaQ==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 08:59:27 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
In-Reply-To: <atgugPFCpueeAiB8@rkannoth-OptiPlex-7090>
References: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
 <atgugPFCpueeAiB8@rkannoth-OptiPlex-7090>
Message-ID: <a790194252203ea6736acc1554206fd2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ratheesh

On 21.10.2026 05:16, Ratheesh Kannoth wrote:
> On 2026-10-19 at 20:34:33, Nicolai Buchwitz (nb@tipi-net.de) wrote:
>>  	if (!seg) {
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c 
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>> index 8d2d607bc92f9..4a20d73d27c06 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>> @@ -1205,6 +1205,13 @@ bool otx2_sq_append_skb(void *dev, struct 
>> netdev_queue *txq,
>>  	if (free_desc < otx2_get_sqe_count(pfvf, skb))
>>  		return false;
>> 
>> +	/* Crypto hardware need write permission for ipsec crypto offload */
>> +	if (unlikely(xfrm_offload(skb)) && skb_cloned(skb) &&
>> +	    skb_ensure_writable(skb, skb->len)) {
> 
> Thanks for the fix!
> 
> Just wanted to double-check the behavior of `skb_ensure_writable(skb, 
> skb->len)` on a cloned
> SG packet. Does it end up copying the data twice (once via 
> `pskb_may_pull()` to linearize into
> the shared buffer, and again via `pskb_expand_head()` into a new 
> buffer)?
> 
> I'm a bit concerned about potential performance regressions.

No, AFAIU it copies once. On a cloned skb it will be

   __pskb_pull_tail()
     -> pskb_expand_head()
        -> private head, skb->cloned cleared

The frags are copied into that head and skb_ensure_writable() returns.
That matches what the old skb_unshare() did and also only cloned
xfrm skbs take this path.

> [...]

Regards,
Nicolai
