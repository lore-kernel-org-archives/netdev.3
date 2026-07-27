Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30D93BED7B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135601; cv=none; b=ayWmyNQpxHihWeElcVupHFn3gz8/YFn1dMHkBG3x4EeJgWNXbrO5D6+/So+EyHUgGVFuBdd0YEby6z8wdYLLbRHFcQ0tKePZih5JLxcfjSFdl22O2LfbP0Lzjcdyw03j+28o6yqs9vbqAlXY2E5Z+G1oLg+btcx8N0XTMCP+uY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135601; c=relaxed/simple;
	bh=g9kgPOl4ZvJAHv0Ex/Oi1E0lrNvhnDLdqQlyf/ZfGq0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZW2imJZhZALTDvV/FW5ZEYi0F+6Tg3XzjxzmclBIdO+RsaNSIp2SIkXsevrspGB53XHp8uvBaO69DvilmgffGW3ERjQcDL25NPJ3t4BVudzogFCY2q9h3zzTFL3GdOKCre6IK4mjij3qFVTK1WA1qRdvhC5n0zvXzxodjh6IQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vyd/IP4z; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vyd/IP4z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E4E094E40F92;
	Mon, 27 Jul 2026 06:59:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8B82601BE;
	Mon, 27 Jul 2026 06:59:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FC2811C1210F;
	Mon, 27 Jul 2026 08:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785135595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XfyAvxSpTRWd615TKg3gtTOpaKIXb4fsRMzklCQ7lnw=;
	b=vyd/IP4zZhwdmGj46qVRVHVwEV+QOLeDfsM/o2ypECbi2OSqJ9yDPttKXmteAfSpAO41PS
	ZSd/LT0Oo+TgWmP8V9WUdXznd+mXTkH82niBNsgQoXf4o6tAWtFEGUuHj4ar+uzpUdtFJ/
	BdwpAoDoa7m/5zEuSdQH5PVon4cS3rDjcYvFrSE9l4H/ZNqhJlrGyKteptpgyhrJ1qnQ5r
	zUwOq1QrpD9sKCb1uegeaUFt6KZeg9KuOLm/+raeWwm3bYcB1FS2sWz4y34LaugZ4EN8LM
	/rAwUqSc3J/do93+0uRLTfPEZTSiD0R5rAzfOO5tqSXKLeuTj00+DnJFgQNG5g==
Message-ID: <31ae45cc-9163-4117-a0ea-f57620f4c88e@bootlin.com>
Date: Mon, 27 Jul 2026 08:59:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/10] net: dsa: microchip: add KSZ8463 tail
 tag handling
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260713-ksz-new-ptp-v2-8-7209c05058ef@bootlin.com>
 <20260720140729.166722-1-horms@kernel.org>
 <a04f0a2f-40b0-4391-a912-1205b83ee1e5@bootlin.com>
Content-Language: en-US
In-Reply-To: <a04f0a2f-40b0-4391-a912-1205b83ee1e5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Simon,

On 7/23/26 12:12 PM, Bastien Curutchet wrote:
> Hi Simon,
> 
> On 7/20/26 4:07 PM, Simon Horman wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> https://sashiko.dev/#/patchset/20260713-ksz-new-ptp- 
>> v2-1-7209c05058ef@bootlin.com?part=8
>> ---
>> --- Patch [8]: [PATCH net-next v2 08/10] net: dsa: microchip: add 
>> KSZ8463 tail tag handling ---
>> commit bc95662a9488a7827d30f83890008a818f0a5228
>> Author: Bastien Curutchet (Schneider Electric) 
>> <bastien.curutchet@bootlin.com>
>>
>> net: dsa: microchip: add KSZ8463 tail tag handling
>>
>> KSZ8463 uses the KSZ9893 DSA TAG driver, but uses reserved fields in 
>> the PTP
>> header for timestamps instead of the tail tag. This commit adds a
>> KSZ8463-specific DSA_TAG driver to handle KSZ8463 timestamps.
>>
>>> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
>>> index f8b40437c5fa4..477f2997c1a34 100644
>>> --- a/net/dsa/tag_ksz.c
>>> +++ b/net/dsa/tag_ksz.c
>>
>> [ ... ]
>>
>>> +static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct 
>>> net_device *dev)
>>> +{
>>> +    unsigned int len = KSZ_EGRESS_TAG_LEN;
>>> +    struct ptp_header *ptp_hdr;
>>> +    unsigned int ptp_class;
>>> +    unsigned int port;
>>> +    ktime_t ts;
>>> +    u8 *tag;
>>> +
>>> +    if (skb_linearize(skb)) {
>>> +        kfree_skb(skb);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    /* Tag decoding */
>>> +    tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
>>> +    port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
>>> +
>>> +    __skb_push(skb, ETH_HLEN);
>>> +    ptp_class = ptp_classify_raw(skb);
>>> +    __skb_pull(skb, ETH_HLEN);
>>> +    if (ptp_class == PTP_CLASS_NONE)
>>> +        goto common_rcv;
>>> +
>>> +    ptp_hdr = ptp_parse_header(skb, ptp_class);
>>> +    if (ptp_hdr) {
>>> +        ts = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr- 
>>> >reserved2));
>>> +        KSZ_SKB_CB(skb)->tstamp = ts;
>>> +        ptp_hdr->reserved2 = 0;
>>> +        skb->ip_summed = CHECKSUM_NONE;
>>
>> [Severity: High]
>> Does this unconditionally modify the payload of all PTP packets?
>>
>> If a PTPv1 packet is received, ptp_classify_raw() identifies it as 
>> PTP, but
>> the PTPv1 header structure is different. Blindly casting and zeroing
>> ptp_hdr->reserved2 aliases bytes 16-19, which corrupts the subdomain 
>> string.
>> Should this check that ptp_class includes PTP_CLASS_V2?
>>
> 
> I don't find in the code a different PTP header for the PTP_CLASS_V1. So 
> my guess is that the reserved2 field is also reserved for V1, so setting 
> it to zero shouldn't matter IMO.
> 
>> Additionally, altering the UDP payload without updating the UDP 
>> checksum and
>> setting skb->ip_summed = CHECKSUM_NONE forces the network stack to 
>> verify the
>> now-invalid checksum, which causes the packet to be dropped.
>>
> 
> I think I misunderstood Sashiko comment on the previous series and 
> shouldn't have added the skb->ip_summed = CHECKSUM_NONE line in this one.
> 
> The switch uses the reserved2 field to convey the frame timestamp. 
> Datasheet doesn't say whether or not it updates the UDP checksum when 
> doing so. What I'm sure of is that packets aren't dropped as the PTP 
> synchronization is successful, so I think the UDP checksum isn't touched 
> by the switch.
> I'm not sure to understand how the skb->ip_summed field is supposed to 
> be used so any guideline here would be welcome.
> 

I took another look at it. skb->ip_summed is only used by the IP layer, 
this series only add support for the L2 layer so I'll simply remove this 
'skb->ip_summed = CHECKSUM_NONE' in the next iteration.


Best regards,
Bastien
