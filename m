Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42E357D17;
	Sat, 10 Oct 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791632760; cv=none; b=NdCObfnoiY+RW6f7fJyb2e3LT1jNI7TrcN+CbrWzAptSnqXH1vA198oYZeXOKKSXxpvsy6HVYLGEMyIX+RvOpDPzMpT+G5OADEzIvDtOmq+M6oqRk4XeGvMd5mhMmOAo+mmL1Za6/L08ywWRa0hzXWi/AislOB9i1Ll1p7q0G1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791632760; c=relaxed/simple;
	bh=aHKZAYKOgUw4s6pMF3TYyfW/QWGTv2rdwctNLujWaf4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PgqovM0YQ/ueqzOnUb+ybqpwcbyiETfwAEFyjFc+EJ8d15dUnFFS2cTmdcJVf1s+tyKcMK1q8IfIBKWbgEfxpNcB4EDJ8ln/TW/cUfmWc3cSekLqz/ZCbn9nrjVexSeEOzuMNpYITUWMFjf2d2NlQdandzqBg/VPl4tj6BFbL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=rRWdK68K; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="rRWdK68K"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58B82A1310;
	Sat, 10 Oct 2026 13:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791632403; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Iom4aTZ1Ng7I9i3S6MX4UJRjRD0DbZbRWHw6zTWilc4=;
	b=rRWdK68KK/2YL4L03HqdStp1iovRmW32vbekDkhqJ4S0xpckOk9o1M/lYFLdlBPdjOSQd5
	nvhFNXvbp1Un04QWSI/ysxq+kDM7Vepux9h66zA7swZbg7QTeRZ117d3IUA10Fge+L9wHh
	ev211l51XT+j1GrcVffSi8GwILB8u8/jyJbTpOeCyKW+9GKVkErKaUdf5PtZnqA9QWyfbs
	jL3Bn0xGoz4R7+RM4TwH+eqrOB1yun/OucN2HGWSehjYE1ETCBv21d+Su4TtDJtaQyMBNc
	VJ8lOdKBoQWJSbfbE+1t3Vsr7P99U3ekNckBXdR7DB4nUq2+PLdA8MiesPt+wA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 Oct 2026 13:40:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
In-Reply-To: <179163062814.434549.7207251041859249341@kernel.org>
References: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
 <179163062814.434549.7207251041859249341@kernel.org>
Message-ID: <6e9e4b9a66d755ee3f7ff3bce5bd27c3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Clashiko

On 10.10.2026 13:10, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] The new skb_share_check() failure branch in bcmgenet_xmit()
>   (drivers/net/ethernet/broadcom/genet/bcmgenet.c:2159-2164) jumps to…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   bcmgenet_timeout()…
> 
> --
> 
> net: bcmgenet: unshare the skb before writing the control block
> 
> bcmgenet_xmit() keeps first_cb, last_cb and bytes_sent in the skb 
> control
> block and reads them back when the transmit completes. A shared skb 
> that
> is resubmitted while it is still in the ring overwrites that state, and
> BQL then stalls the queue. The patch calls skb_share_check() before the
> control block is written, so each transmit works on its own skb.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index e8908916558b1..f4cfbff49a1b8 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -2153,6 +2153,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>  		goto out;
>>  	}
>> 
>> +	/* We store Tx state in the control block, so the skb must not be
>> +	 * shared, but ether_setup() leaves IFF_TX_SKB_SHARING set.
>> +	 */
>> +	skb = skb_share_check(skb, GFP_ATOMIC);
>> +	if (!skb) {
>> +		BCMGENET_STATS64_INC((&ring->stats64), dropped);
>> +		ret = NETDEV_TX_OK;
>> +		goto out;
> 
> [Severity: Medium]
> If the GFP_ATOMIC clone fails on the last skb of an xmit_more batch, do
> the descriptors queued by the earlier calls in that batch get handed to
> the hardware?

No, but that is nothing new. The same goto out is taken by the existing
add_tsb and unmap drops, and the next xmit flushes them anyway. You only
get here on an alloc failure under pktgen, so real traffic probably 
never
hits it. Can be cleaned up separately, maybe even net-next?

> [...]

> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch, but it
> involves the same ring->stats64.syncp that the new dropped increment
> uses.

Agreed, pre-existing. I can fix in another series together with above.

> [...]
