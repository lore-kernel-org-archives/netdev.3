Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB344064F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171113; cv=pass; b=cWZxKffySPMr93dxCJkk7slqritECb5oIOY7s11dtGDuewQqv3eNEZJ7PidhxX8738KemQxP3vcVDrJ8Il58+CgQiAZV3SRI3ZIJdBzgFkMoRoX3TYyqz8pBGghZ7IT+ZYkXabALcu/rE67dDkHNSuPECdgAqXLqVaiObgBMugQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171113; c=relaxed/simple;
	bh=/dX50ORp1sQOGJL2L1CL1azzkJY9rS4GV4ri+igao3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzIMh0A1V53eyLDB/KdZUd3ALnIf/wwJAG247Cbc6XQfN0bfBpmFmPKB44qiUSU91FzT0M1otC/NONUxCzRGzOSkhhLYajH7kEllnEhL0kEnFimQsGOyQFCN1OKshLmtFo5odoDs20Dv2PHfi26Q5GF430QgPu3tvluavUSAVFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=pVYprDmR; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="pVYprDmR"
ARC-Seal: i=1; a=rsa-sha256; t=1787171098; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aGw0b5japTJIN+Gc5KeUX52J9vkfjtOWHxBFxZQ9UO30Oeibm0xsb1TjFC1NHQ8skO+oV2WGxvPOlyaiid9z6C2Mv9NugGEoRqx++tdNGi0UM90nLRdWaOaj8IIGhyM9mwZySfk6cQNGa0nCasrGMjg9ROENG9Ts2YVwmlYN0V4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787171098; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=umUCOZ90Rxt+yZAmOOOGEwbkhkxmRmzzfiL9bhkHvkI=; 
	b=Q0sDCinWfG7/c9G7UHaqJDaGtIIG3Su0d+zBa/Z6e7eyVeI/zsJKoTJGLqZjnu3raZi/yBJeIFc8CBB4RAjHM3pQmM/YGTJ8mod0d/zWqWIQh7bV406KnjObcYVbJWM3Kh44Tn5b+ZSBvrNv9yCb3D54J3tNCoGakJPCEqaoiLA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787171098;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=umUCOZ90Rxt+yZAmOOOGEwbkhkxmRmzzfiL9bhkHvkI=;
	b=pVYprDmRk79nK1MV8rr/4SI01TEtXgAJ+wc4VDkKUdcMZiJsNsHVcMm81eK6KmWL
	eirHAf6gJ0RIHH+PGdI4aXa5lpM3/kvreNTIcgijt13SFs7KtCLgIQvrNW1D1hX/eaR
	ibmvk86DyxP0SRTkYHadNhtpRddo6mtRDdzkY5A1kJ5ZcLod2Nx55TuzFffPrrCQJse
	snW7MprDhcJiUNi0b7VpbKGqX3LaQziIOtKacEofVPZmukTRnDBOGMiv1dbRYCCTYs7
	iYehhZiKs13E/Hb58/PB3XRxLuEI9UQHvbeADSmWHWksmiwMIfOxo+QkNRoQbLNIB+2
	vTbgvZpi1A==
Received: by mx.zohomail.com with SMTPS id 1787171094667424.9142960171981;
	Wed, 19 Aug 2026 13:24:54 -0700 (PDT)
Message-ID: <135788b9-9502-461f-b2df-b4cff5b4842d@machnikowski.net>
Date: Wed, 19 Aug 2026 22:24:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev
References: <20260815063148.2952-3-maciek@machnikowski.net>
 <20260818135800.629288-1-horms@kernel.org>
 <9b17f19d-9d6f-4301-b6a5-871cec042211@machnikowski.net>
 <20260819101706.GP265046@horms.kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260819101706.GP265046@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 19/08/2026 12:17, Simon Horman wrote:
> On Wed, Aug 19, 2026 at 12:03:33AM +0200, Maciek Machnikowski wrote:

>>> [Severity: Low]
>>> [Finding: main-5-12]
>>> [Sources: opus-5]
>>> Does skb_unshare() cover the case this comment describes?
>>>
> d
>>> 	might_sleep_if(gfpflags_allow_blocking(pri));
>>> 	if (skb_cloned(skb)) {
>>> 	...
>>> }
>>>
>>> The copy is made only for clones, so an skb with skb->users > 1 and
>>> cloned == 0 is returned unchanged.  pktgen does
>>> refcount_add(burst, &pkt_dev->skb->users) and resubmits the same skb, so the
>>> skb_hwtstamps(skb) write below touches skb_shared_info that the other
>>> reference holder still owns, and that the peer's NAPI path may read
>>> concurrently after nsim_forward_skb() -> nsim_napi_rx() queues it on
>>> rq->skb_queue.  Should the driver check skb_shared() as well, or stamp a
>>> private copy?
>>>
>> ??
> 
> My understanding here is that it is possible for skbs to be shared without
> being clones. E.g. pktgen.
> 
> And that as a software driver that simulates hardware timestamps
> (unique in the Kernel?) this needs to be taken into account by
> copying skbs that are either shared or cloned.
> 
I believe it should not be an issue - if the SKB gets recycled through
the stack it'll just get a new RX tstamp when it re-enters this part of
the code. If someone disables Rx tstamps - the packet with a tstamp
without a consumer would be recycled.

>>
>>>> +
>>>> +		/* If RX hardware timestamping is enabled report RX timestamp */
>>>> +		if (ptp_info_rx)
>>>> +			skb_hwtstamps(skb)->hwtstamp =
>>>> +				timespec64_to_ktime(rx_ts);
>>>> +	}
>>>> +
>>>
>>> [Severity: Critical]
>>> [Finding: main-6-13]
>>> [Sources: opus-5]
>>> Can this write corrupt kernel memory for AF_XDP TX skbs?
>>>
>>> skb_hwtstamps() returns a pointer into a union in skb_shared_info:
>>>
>>> include/linux/skbuff.h:struct skb_shared_info {
>>> 	union {
>>> 		struct skb_shared_hwtstamps hwtstamps;
>>> 		struct xsk_tx_metadata_compl xsk_meta;
>>> 	};
>>>
>>> struct xsk_tx_metadata_compl has a single member, u64 *tx_timestamp, and the
>>> AF_XDP destructor dereferences it with only a NULL check:
>>>
>>> net/xdp/xsk.c:xsk_destruct_skb() {
>>> 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
>>>
>>> 	if (compl->tx_timestamp) {
>>> 		/* sw completion timestamp, not a real one */
>>> 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
>>> 	}
>>>
>>> Every generic-xmit AF_XDP skb carries that destructor
>>> (xsk_skb_init_misc() sets skb->destructor = xsk_destruct_skb), and it is
>>> freshly allocated and not cloned, so skb_unshare() above returns the same
>>> skb with the destructor and the overwritten shinfo intact.
>>> __dev_forward_skb() -> skb_scrub_packet() does not orphan the skb or reset
>>> skb_shinfo(), so the value survives to the destructor.
>>>
>>> The RX branch is gated only on the peer's setting:
>>>
>>> 	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
>>> 		     HWTSTAMP_FILTER_NONE))
>>> 		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
>>>
>>> so any AF_XDP frame forwarded while the peer has RX timestamping enabled
>>> gets a non-NULL, PHC-derived value in xsk_meta.tx_timestamp, and the
>>> destructor performs an 8-byte write to that address.  The mock PHC value is
>>> settable from userspace through clock_settime() on /dev/ptpN via
>>> mock_phc_settime64().
>>>
>>> Real NICs avoid this because they only stamp skbs they allocated for RX.
>>> Since netdevsim reuses the TX skb as the RX skb, should it orphan the skb
>>> (clearing skb->destructor) or stamp a private copy before touching
>>> skb_shinfo()->hwtstamps?
>>>
>> Sounds like this should be addressed in the generic skb_scrub_packet in
>> the __dev_forward_skb path?
> 
> My understanding is that would be outside the scope of skb_scrub_packet.
> And doing so would would break socket memory accounting and the AF_XDP
> completion signal.
> 
> I think that this problem occurs because netdev sim both uses the same skbs
> for both RX and TX, and now modifies shared metadata. As this is an unusual
> (unique?) scenario, it seems reasonable to me for the driver to address the
> issue.
> 

I do understand your point of view, but I think it's generally something
we should scrub when forwarding the SKB. It doesn't seem right to
deliver a AF_XDP packet to a destination RX queue with some "random"
destructor.
But I'm not AF_XDP expert, so would like to get an opinion from someone
more familiar with it - Kuba - can you help with this one?

