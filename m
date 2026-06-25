Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0733A451D;
	Thu, 25 Jun 2026 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385657; cv=none; b=SCvPp8eM4+AMUPdlpcC6x/p/4jIOM+HLD9xNXXN3ECS8AvfCNg/dK5SAbLqbkD+i5dKY4p7zvxjxziTPSJ+SHPbfOZE9WPZihzfc+k7SQlDH+sb3gJ8CpeWHFuUFc/OzcV5Kv+txJLUZHQ0pqCwFOP5oXUVaardjgezV/oT0Sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385657; c=relaxed/simple;
	bh=1DKzcgPw0xfGQ3vVU4fzu+gAjQMxLf9uPhSMmZQA5UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYgL07LEjJvQfHc+YlAbxQkqpZByvB7pWGfKOBrXO4NHqz0JL7cSJpD8nclR91sI9wmwMFZ0PYBCXAyYklErA9foFCPHKpnVv72dzGG7onn5cHJApUg1MsTTYxDFU36xMl25JLiDS1bFNCMBsD7gUXvBqENRNiYpdCnzE5BXFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A54WRRX/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A54WRRX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782385656; x=1813921656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1DKzcgPw0xfGQ3vVU4fzu+gAjQMxLf9uPhSMmZQA5UA=;
  b=A54WRRX/KdxgxJ4/yYTb4WNyIEW0Vl3DXdOZpSisJd3jQ4Rb9iV5PW5b
   /FmXifZFq66nN8WBzKE7WWXV3M1Bx/PJUcicrRt2Le5pHb7c16X9p3Liw
   b85weAXYqpC8zweCZb7dF2qEaABYYtr9ZAL9GZSlPYxdeoshGNg/3UkQ6
   7hdjvbQ85wex3ocFX+rWYc5jb8HaR62LMto8QWM8UqVByZlrpBt9Z6OjK
   D8EbUQML3De04bFBHEatHMUCSLUciRMxtEQ/6tboXDkObzaqEveqymvYc
   R6ruR/zXh98rZQHK1HYwDEkPoxZnzXrxykV/UdHiofdw10tIPVfn6X91E
   w==;
X-CSE-ConnectionGUID: P+cYg6fnT9awpAxSBZz6zg==
X-CSE-MsgGUID: qvEJI4X0RyaIu06ZSulwaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93515283"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93515283"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:07:36 -0700
X-CSE-ConnectionGUID: UBL7DbuESgmqSE+sM3lTCg==
X-CSE-MsgGUID: 9cqH5KWLSAODmTeGA7j2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250755331"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239]) ([10.217.160.239])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:07:32 -0700
Message-ID: <f9a090bd-08ea-47e6-8dee-cf4f828fdced@linux.intel.com>
Date: Thu, 25 Jun 2026 13:07:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting
 when NET_RX_BUSY_POLL is disabled
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
 Ding Meng <meng.ding@siemens.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "wq.wang@siemens.com" <wq.wang@siemens.com>
References: <20260622041718.6106-1-meng.ding@siemens.com>
 <BL1PR11MB59796B99C5A7709B07000D68F3EE2@BL1PR11MB5979.namprd11.prod.outlook.com>
 <d058b0fa9ad923514084a44f51c78ae8355c4ebb.camel@siemens.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <d058b0fa9ad923514084a44f51c78ae8355c4ebb.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/06/2026 11:05, Florian Bezdeka via Intel-wired-lan wrote:
> On Tue, 2026-06-23 at 09:46 +0000, Kwapulinski, Piotr wrote:
>>> -----Original Message-----
>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Ding Meng via Intel-wired-lan
>>> Sent: Monday, June 22, 2026 6:13 AM
>>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Kiszka, Jan <jan.kiszka@siemens.com>; Bezdeka, Florian <florian.bezdeka@siemens.com>
>>> Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; meng.ding@siemens.com; wq.wang@siemens.com
>>> Subject: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled
>>>
>>> When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps from the NIC no longer works as expected.
>>>
>>> This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp() fails to perform its driver lookup, and the igc driver's struct net_device_ops::ndo_get_tstamp is never invoked.
>>>
>>> Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp, a field that the driver has not populated.
>>>
>>> Fix this by populating the hwtstamp field with the correct timestamp in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
>>>
>>> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
>>> Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> Signed-off-by: Ding Meng <meng.ding@siemens.com>
>>> ---
>>> drivers/net/ethernet/intel/igc/igc_main.c | 38 ++++++++++++++++-------
>>> 1 file changed, 26 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>>> index 8ac16808023..1da8d7aa76d 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>>> 	return skb;
>>> }
>>>
>>> -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
>>> +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
>>> +					 struct sk_buff *skb,
>>> +					 struct igc_xdp_buff *ctx)
>>> +{
>>> +	if (!ctx->rx_ts)
>>> +		return;
>>> +#ifdef CONFIG_NET_RX_BUSY_POLL
>>> +	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
>>> +	skb_hwtstamps(skb)->netdev_data = ctx->rx_ts; #else
>>> +	struct igc_inline_rx_tstamps *tstamps;
>> Please move at the top of the function and add:
> 
> That would trigger a "unused variable" warning in the
> CONFIG_NET_RX_BUSY_POLL case.

Put it under #ifndef CONFIG_NET_RX_BUSY_POLL. Variable declarations
need to be on top.

Thanks,
Marcin

> Btw: I was really confused that the #else statement moved to the end of
> the previous line. Might someone be using a wrongly configured mail
> client here?
> 
> Florian
> 
>> Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com
>>
>>> +
>>> +	tstamps = ctx->rx_ts;
>>> +	skb_hwtstamps(skb)->hwtstamp = igc_ptp_rx_pktstamp(adapter,
>>> +							   tstamps->timer0);
>>> +#endif
>>> +}
>>> +
> 
> [snip]

