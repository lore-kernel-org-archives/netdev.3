Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216753ED5BB
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052330; cv=none; b=Sor7cdRJA6xS0RmjpFE+FqkjXKaxAWZ6DudPL9dLFofQbBYsa0z5elX0qy/1oI8LWdC0dFkiyUcjWdOGEj5CRFeodYCTaRO/jrOZvI0MifcsKdXTD5hbtVCXKDZEP+usfoUlZPfb5LlorIwhmOJehf04xodkdK6ZYzqaW3tetUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052330; c=relaxed/simple;
	bh=jd3GZVcRdXNFUR8mQP8NnyxX80yn0pFH4Jwj8r8Ugpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGg587ZQ3qeM7T0HundKjd0sxleky07OFauiJ9MVuzuaW30dhc0o28DpATyCsB3d7mBR0wNjJOnpu/G0Boa4r8xwi/kbRJcMpT/U6m6fxDsIrZGATwZGEO4+gkvt0N3YKL8ZMIAwgFiNYbYzYEaSv4+W2wwX3TSF3qnPSkXpIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fnrX0keG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fnrX0keG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jd3GZVcRdXNFUR8mQP8NnyxX80yn0pFH4Jwj8r8Ugpw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787052325; v=1; x=1787657125;
 b=fnrX0keGkeTNk/Uk3xejrQ7VLAfCbMEaqICCqmAfzP3fg2XhmUTg5/4KI7H+gcVxs2bOVmUk
 IfiNEJAU81e2++cdjxuQ2Sbfbw0liDQmCWpfn6tbGR7MqSoGx8OIgR2Y5w18YsaZ6HpUUbwo5h4
 Zje/bLbytP6N5UyOUWF/YGRA=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::7:74e0)
	by smtp.migadu.com with ESMTPS id fbb00eda9016d5be;
	Tue, 18 Aug 2026 11:25:25 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <668c3127-1ab3-4dcf-a856-9f396cd57e58@linux.dev>
Date: Tue, 18 Aug 2026 12:25:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: libwx: fix concurrent bitmap overwrite in PTP
 setup
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2026 08:47, Jiawen Wu wrote:
> In wx_ptp_set_timestamp_mode(), the driver copies the global `wx->flags`
> bitmap to a local variable, modifies the PTP-related bits, and then writes
> the entire bitmap back using memcpy().
> 
> This Read-Copy-Update pattern is unsafe and introduces a critical race
> condition. Other asynchronous contexts (such as Tx timeout routines or
> GPIO IRQ handlers) update individual bits in `wx->flags` concurrently
> using atomic bitops like set_bit() or clear_bit(). The memcpy() write-back
> can silently overwrite and drop these concurrent changes, potentially
> causing the driver to miss critical module reset or PCIe recovery requests.
> 
> Fix this by removing the local bitmap copy. Instead, evaluate the intended
> PTP flag states locally and apply them directly to `wx->flags` using
> atomic set_bit() and clear_bit() operations only after the hardware is
> successfully configured.
> 
> Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> Changes in v2:
> - Combine two variables that are always equal into one.
> - Link to v1: https://lore.kernel.org/all/F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com
> ---
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 44f3e6505246..1165518d5522 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -555,13 +555,11 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   {
>   	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
>   	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
> -	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
>   	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
> +	bool rx_tstamp = false;
>   	bool is_l2 = false;
>   	u32 regval;
>   
> -	memcpy(flags, wx->flags, sizeof(wx->flags));
> -
>   	switch (config->tx_type) {
>   	case HWTSTAMP_TX_OFF:
>   		tsync_tx_ctl = 0;
> @@ -576,20 +574,16 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   	case HWTSTAMP_FILTER_NONE:
>   		tsync_rx_ctl = 0;
>   		tsync_rx_mtrl = 0;
> -		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> -		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
>   		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
> -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> +		rx_tstamp = true;
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
>   		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
> -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> +		rx_tstamp = true;
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>   	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> @@ -602,9 +596,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
>   		is_l2 = true;
> +		rx_tstamp = true;
>   		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>   		break;
>   	default:
>   		/* register PSR_1588_MSG must be set in order to do V1 packets,
> @@ -643,7 +636,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   	WX_WRITE_FLUSH(wx);
>   
>   	/* configure adapter flags only when HW is actually configured */
> -	memcpy(wx->flags, flags, sizeof(wx->flags));
> +	assign_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags, rx_tstamp);
> +	assign_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags, rx_tstamp);
>   
>   	/* clear TX/RX timestamp state, just to be sure */
>   	wx_ptp_clear_tx_timestamp(wx);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
