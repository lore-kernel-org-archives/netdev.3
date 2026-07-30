Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB842D759
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416557; cv=none; b=EZnR9239LK4f7vgvui+jRE/qzYrWBTp1JnAN6sKqlppCrNiANzWLGlUTfz16CW51F0V4PhRWhZD+Oq9CxkVrc8RHP3CS42IioyuKD+m35GpZPr7qJVEoJ3gNmr1PNTqGepVtg8LeX32UeMhYmRcwwhjni0YjZHMgMBDlqfdviiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416557; c=relaxed/simple;
	bh=OGfI7CQWmeTig9mlK9YWXS4MNmzUFY2veniVIJNAzm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9CmApk/T5oQVQ3GLHH+98HYzsgBqDftHIlm453/RncvwXV8kox0jCWZflaIWJP5nYc6ixQPwmVOwj5qqTF4uJgmTa3AvYUpksh4JI36wWM/PU9kijYRw0mmsKVhgSvWFiq3MQMywp2TowJJCFtG+fi65bog/k2sZhkiCmlLpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wBl8/CeK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wBl8/CeK"
Message-ID: <48631703-cbd9-45ba-b079-c4d94f4cf405@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785416543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLMzAM2jhcBcjvUbjDVz8nPB2UWdb+PQz/+bnXZY5Sk=;
	b=wBl8/CeKE7+AeEZjGa6VWejw62/EHMA7eEQYOJ3nVvQ7kjaSGESyyQG4pdczMaWLVPNOEK
	9xfo2BxYDy2gNs0som1K/KVC7F/IghOggkT8Ca0xYfBzDMDke2F+sXTlfEgHe7FUlq8DS1
	RqCo+bpdLqximLeWFkxfXBw9iZoZVPI=
Date: Thu, 30 Jul 2026 14:02:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 6/7] net: dsa: netc: add PTP two-step
 timestamping support
To: Wei Fang <wei.fang@nxp.com>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "olteanv@gmail.com" <olteanv@gmail.com>
Cc: "chleroy@kernel.org" <chleroy@kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
 <20260728104548.3301214-7-wei.fang@oss.nxp.com>
 <59ecaa4e-f111-4dd4-914a-7704990ac58e@linux.dev>
 <GV2PR04MB11739A4EDB782AB83B60968D988C92@GV2PR04MB11739.eurprd04.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <GV2PR04MB11739A4EDB782AB83B60968D988C92@GV2PR04MB11739.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2026 02:31, Wei Fang wrote:
>>> +int netc_get_ts_info(struct dsa_switch *ds, int port,
>>> +		     struct kernel_ethtool_ts_info *info)
>>> +{
>>> +	struct netc_switch *priv = ds->priv;
>>> +
>>> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
>>> +				SOF_TIMESTAMPING_RX_SOFTWARE |
>>> +				SOF_TIMESTAMPING_SOFTWARE;
>>
>> SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE
>> are available
>> by default, no need to add them.
> 
> Yes, you are right, I will remove them.
> 
>>
>> the code doesn't have skb_tx_timestamp() calls, I wonder how is
>> SOF_TIMESTAMPING_TX_SOFTWARE implemented?
> 
> The switch and the conduit port (ENETC) are integrated into the NETC IP,
> so the switch can only connect to the ENETC MAC. And the ENETC driver
> calls skb_tx_timestamp() unconditionally, so I thought
> SOF_TIMESTAMPING_TX_SOFTWARE can be added. I checked the existing
> DSA drivers and found no drivers set this flag, maybe I should remove this
> flag as well. Thanks.

well, you have the hardware, you can actually check if enetc driver 
provides it for you

> 
>>
>>> +
>>> +	info->phc_index = netc_get_phc_index(priv);
>>> +	if (info->phc_index < 0)
>>> +		return 0;
>>> +
>>> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
>>> +				 SOF_TIMESTAMPING_RX_HARDWARE |
>>> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
>>> +
>>> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
>>> +
>>> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
>>> +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
>>> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>>> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
>>> +
>>> +	return 0;
>>> +}
>>
> 

