Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95239CCE3
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566928; cv=none; b=Lzeo5BqIa++ynfPKxF2lOf+xzPyyxm8EEaXByiP/5p4wG4GTrZyi5/JHtnBhI1oCGzpJUpQIekpyr94np0rQfeFkNww5rPyXywsophhSLsVkwBrz2MoqMgw/XC9Ke4w8fnpl5kbwd72QEI5g6c3iGpUauNE1hAvhdfU8/nf9qEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566928; c=relaxed/simple;
	bh=e3PZH1uvAAVu8H64QxKZjgyyr7i7ztebISgz0WXHlwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIN6vUBSOhrdccOzKnqagl4VVhadZVyuwUczAlc0TPlvE3yxG65XTURAqxWdp1i8RmFrUHKQ0cp3XTluITwWBjWf8hXauXwW/ee4BFsJDMyfjH0UXzrK0uJkdoxEJqDtcDQ5jqO6BHfi6BAmFE9/vXYgMdrLaoVvGFbC7GkkC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lukCbvMp; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lukCbvMp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e3PZH1uvAAVu8H64QxKZjgyyr7i7ztebISgz0WXHlwE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786566923; v=1; x=1787171723;
 b=lukCbvMp+tv9wX9kKR0m9+fYkR7WeK0LkYzzbw7iQA0dk8gC8Atobf1gnDycaAR88QsBm7Xn
 HBOeO8L2p1/ozcdx6/Han4TbYYNq9chIFIvlK/c4DWR57pfQMkJ6v8Lhnk2RTvWZixO/MCr/M9W
 +sR38roUUr1DHSyacyGMrdy8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.45] (109.76.184.122)
	by smtp.migadu.com with ESMTPS id 5d086fa5087b19c5;
	Wed, 12 Aug 2026 20:35:13 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <0b4ca607-9e50-48e7-a016-c1b829a37250@linux.dev>
Date: Wed, 12 Aug 2026 21:35:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 2/3] netdevsim: Implement basic ptp support
To: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, horms@kernel.org
References: <20260812183708.312412-1-maciek@machnikowski.net>
 <20260812183708.312412-3-maciek@machnikowski.net>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260812183708.312412-3-maciek@machnikowski.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.2026 19:37, Maciek Machnikowski wrote:
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the timestamps
> of the ones attached either to the netdevsim or its peer and returns
> timestamps using standard timestamps APIs.
> 
> This implementation enables running ptp4l on netdevsim adapters and
> introduces a new ptp selftest.
> 
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

[...]

>   
> +static int nsim_set_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +	int rx_filter;
> +
> +	if (!ns->phc)
> +		return -EOPNOTSUPP;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		WRITE_ONCE(ns->tstamp_config.tx_type, HWTSTAMP_TX_OFF);
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		WRITE_ONCE(ns->tstamp_config.tx_type, HWTSTAMP_TX_ON);
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		rx_filter = HWTSTAMP_FILTER_NONE;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +	case HWTSTAMP_FILTER_ALL:
> +		rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}

nit: technically, you can make sashiko silent in this case by simply swapping
switch statments order :)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

