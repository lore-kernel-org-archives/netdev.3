Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41E30E82E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489289; cv=none; b=ZIfNWenWsZcpnrmxhITPN/aWvgxP1auK+XhqkozKsgBy868tixt8MPL0/ke6iX7Gk50DYMTbIvcE0Wb/2TB+xHuSUI0GdGZrpY4+EoIq8U5T/NjtkNw5mTjP8vPyTE0/MMsY3/RWpfo5R9/ZmJPralRQz7t9TDhdkBLUIrgZjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489289; c=relaxed/simple;
	bh=LyPU3cVgB8ps1x+jq5pUDWO6wzV0UHL9GSirgsT1Luk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/+lJKBainJPFyxNY/Q6+suqEcn0sGkfDkeLm4JR3ummfuqCBS+LnVQ2urc/JHjseEQbiIEgKVav7mXrTWXZ46AxuYhHZmd5Td155pYHV1e++MJ8EOMYkzU/6Fh+p0bgSahGuRBjT1PYO89fTzP29+8S9Ea7pH7MGt383ns/V+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vsKPut+S; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vsKPut+S"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 63C634E41046;
	Fri, 31 Jul 2026 09:14:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BF7E6039A;
	Fri, 31 Jul 2026 09:14:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D669911C165CA;
	Fri, 31 Jul 2026 11:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785489280; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DGhLkBvrWnVfWTJbUOLebyuvDjP6w/Eu2+LttHJfyN4=;
	b=vsKPut+S9VIXNXhLZeCzKCvmqOir+CcXlsEb0oVTH3HWAwyqSpGlTxLZSwACUi8T7HyPPm
	fFQWan1BZWDJJklSiO+95pVG+4+kJ3cp5XMadXz1keUxIGi1pQx9HC6fqKM2qJCfVbPS1a
	D8Ynpyx6vUHmKloTv/X8Hp+jaAoACCxddSGkCcuKrR31etmd0WkAPwaNeNWJh0Kk4Q8IT8
	gWyh0ZNj/fUthTsXmPC74060fst2gTnbOWrHN47wu5TnFwZrhc0uiWM06nJ/OJY4XKkI1e
	RYufi1yG9NhLkRCeOTXh3yAxfEe3MjCTF7eR99HXK3d2uR23IMOPFwnNlFhD7w==
Message-ID: <7f14eb72-37fb-4bc9-9361-230bc79c6806@bootlin.com>
Date: Fri, 31 Jul 2026 11:14:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: dsa: tag_ksz: share code for
 KSZ8795 and KSZ9893 xmit operations
To: Jakub Kicinski <kuba@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, maxime.chevallier@bootlin.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260727-ksz-new-ptp-v3-7-caba39e680e3@bootlin.com>
 <20260731022343.800348-1-kuba@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260731022343.800348-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 7/31/26 4:23 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [7]: [PATCH net-next v3 07/10] net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations ---
> commit 801d0cdc8ef18f0fbd60b1d666b46b36437fd06e
> Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> 
> net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations
> 
> This factors the duplicated tail-tag encoding of ksz8795_xmit() and
> ksz9893_xmit() into a new ksz_common_xmit() helper parameterized by
> do_tstamp, prio and override_mask.  As a side effect ksz8795_xmit() now
> returns through ksz_defer_xmit() instead of returning the skb directly.
> 
>> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
>> index f58ce0f0e9e42..f8b40437c5fa4 100644
>> --- a/net/dsa/tag_ksz.c
>> +++ b/net/dsa/tag_ksz.c
>> @@ -218,6 +218,37 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
>>   	return NULL;
>>   }
>>   
>> +static struct sk_buff *ksz_common_xmit(struct sk_buff *skb,
>> +				       struct net_device *dev,
>> +				       bool do_tstamp,
>> +				       u8 prio,
>> +				       u8 override_mask)
>> +{
>> +	struct dsa_port *dp = dsa_user_to_port(dev);
>> +	struct ethhdr *hdr;
>> +	u8 *tag;
>> +
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
>> +		kfree_skb(skb);
>> +		return NULL;
>> +	}
>> +
>> +	/* Tag encoding */
>> +	if (do_tstamp)
>> +		ksz_xmit_timestamp(dp, skb);
>> +
>> +	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
>> +	hdr = skb_eth_hdr(skb);
>> +
>> +	*tag = dsa_xmit_port_mask(skb, dev);
>> +	*tag |= prio;
>> +
>> +	if (is_link_local_ether_addr(hdr->h_dest))
>> +		*tag |= override_mask;
>> +
>> +	return ksz_defer_xmit(dp, skb);
>> +}
>> +
> 
> [Severity: Medium]
> Can this dereference NULL for the KSZ8795 tagger?  ksz_defer_xmit() reads
> ds->tagger_data and the tagger private data before using them:
> 
> net/dsa/tag_ksz.c:ksz_defer_xmit() {
> 	struct ksz_tagger_data *tagger_data = ksz_tagger_data(dp->ds);
> 	struct ksz_tagger_private *priv = ksz_tagger_private(dp->ds);
> 	...
> 	if (!clone)
> 		return skb;  /* no deferred xmit for this packet */
> 
> 	xmit_work_fn = tagger_data->xmit_work_fn;
> 	xmit_worker = priv->xmit_worker;
> 	...
> }
> 
> Both pointers are only populated by ksz_connect(), and ksz8795_netdev_ops
> does not install it:
> 
> static const struct dsa_device_ops ksz8795_netdev_ops = {
> 	.name	= KSZ8795_NAME,
> 	.proto	= DSA_TAG_PROTO_KSZ8795,
> 	.xmit	= ksz8795_xmit,
> 	.rcv	= ksz8795_rcv,
> 	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
> };
> 
> compared with ksz9893_netdev_ops which has .connect = ksz_connect and
> .disconnect = ksz_disconnect.  ksz87xx_connect_tag_protocol() and
> ksz88xx_connect_tag_protocol() in drivers/net/dsa/microchip/ksz8.c also
> just return 0 for DSA_TAG_PROTO_KSZ8795, so ds->tagger_data stays NULL for
> these switches.
> 
> So after this change the only thing keeping ksz8795_xmit() from a NULL
> dereference is KSZ_SKB_CB(skb)->clone always being NULL.
> 

I think it's safe to assume that ksz8795 will never use a clone as it 
doesn't support PTP, am I wrong here ?

> Is that invariant actually enforced anywhere?  The ksz87xx/ksz88xx
> dsa_switch_ops export .port_hwtstamp_set = ksz_hwtstamp_set and
> .port_txtstamp = ksz_port_txtstamp unconditionally, dsa_user_hwtstamp_set()
> adds no capability gate, and ksz_set_hwtstamp_config() sets the flag before
> the register write and returns the error without reverting it, with no
> dev->info->ptp_capable check:
> 
> drivers/net/dsa/microchip/ksz_ptp.c:ksz_set_hwtstamp_config() {
> 	...
> 		prt->hwts_tx_en = true;
> 
> 		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, PTP_1STEP);
> 		if (ret)
> 			return ret;
> 	...
> }
> 
> For these chips regs[] is ksz8795_regs, whose last initialized index is
> REG_PORT_PME_CTRL (23) while PTP_MSG_CONF1 is 28, so regs[PTP_MSG_CONF1] is
> an out-of-bounds read and the write can well be rejected, which is exactly
> the path that leaves hwts_tx_en latched.
> 
> Once hwts_tx_en is set on such a port, ksz_port_txtstamp() attaches a clone
> based on that flag alone:
> 
> drivers/net/dsa/microchip/ksz_ptp.c:ksz_port_txtstamp() {
> 	...
> 	KSZ_SKB_CB(skb)->clone = clone;
> 	...
> }
> 
> and then dsa_user_xmit() -> ksz8795_xmit() -> ksz_common_xmit() ->
> ksz_defer_xmit() gets past the "if (!clone)" early exit and loads
> tagger_data->xmit_work_fn from a NULL pointer.  Before this patch
> ksz8795_xmit() returned the skb directly and never touched ds->tagger_data,
> so the same misconfiguration only leaked the clone.
> 
> The commit message states:
> 
>      Clones are only created by the KSZ driver when the PTP feature is
>      enabled. Since KSZ8795 doesn't support PTP, returning the SKB directly
>      or ksz_defer_xmit() is the same.
> 
> Could this assumption be expressed in the code, for instance by keying the
> ksz_defer_xmit() call off do_tstamp, or by adding a DEBUG_NET_WARN_ON()
> for a clone on a tagger without tagger_data?  Note also that
> ksz8795_netdev_ops uses .needed_tailroom = KSZ_INGRESS_TAG_LEN only, so
> there is no room for the 4 byte PTP tag if a future user of this helper
> passes do_tstamp = true with that tailroom.
> 

Best regards,
Bastien
