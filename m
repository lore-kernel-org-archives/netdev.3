Received: from mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC9423768
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972040; cv=none; b=pcaxemXa4RT67ICzsIlga+aX2kE6goGOwi9r8geAtq0GvNzd9nW+qeCEbxES1y0Ol1rCU6u8C0P5NgrHR17q/Tl0JjeC+2hEKpSvZPzFzyNX2F9h+X4w76e4aITTISsGp0jgfbn7WG/V8M6rJQCidH2p2+/VdqHhb4TSp7N+bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972040; c=relaxed/simple;
	bh=JwCIq8Q4Gi25NCdb0A2NOSdCL0T4wHUFF+d4UFdUTAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9K+Gauu7kdWSnmUT9lKmRXPkDmY9+N8Cwd9PdfCWw17w7VtzJ8+gyhNPb4vdQP5vkV4x6BrdrA0jIAKbNiH5TEfRxAiaFg1V1fYUc+WT50kPaFnZDt9YEqmtH0DmhyO5k2ZIXaO0Qv3C9zOXLC87k8VtSNCWlGeUwP8e/Heo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUdka7H8; arc=none smtp.client-ip=91.218.175.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUdka7H8"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JwCIq8Q4Gi25NCdb0A2NOSdCL0T4wHUFF+d4UFdUTAc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786972036; v=1; x=1787576836;
 b=iUdka7H8hvgItfpdf0TIj4r/Qq246UuHAggdKoCbCHPrPgiIYmw2vVBUFCXip03i1Bq4+R/i
 I/o2KpzrVCH8GzX1cnVQD9lYoHVu+1qAiX2ed7dQf5nfziSBrXwApFvFHdi/bW/QqHxykWzTrjM
 HUqoeCgHJ2pYa6yfUw86D6vE=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::6:5429)
	by smtp.migadu.com with ESMTPS id 91c160a6a54b3783;
	Mon, 17 Aug 2026 13:07:16 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <31eca887-50d8-40b2-b206-eff0a50b4a8f@linux.dev>
Date: Mon, 17 Aug 2026 14:07:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: libwx: fix concurrent bitmap overwrite in PTP
 setup
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 03:17, Jiawen Wu wrote:
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
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.c | 22 ++++++++++-----------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 44f3e6505246..7d4bd7b258b7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -555,13 +555,12 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   {
>   	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
>   	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
> -	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
>   	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
> +	bool rx_in_register = false;
> +	bool rx_enabled = false;

why do you need 2 variables if their values are equal in all cases?

>   	bool is_l2 = false;
>   	u32 regval;
>   
> -	memcpy(flags, wx->flags, sizeof(wx->flags));
> -
>   	switch (config->tx_type) {
>   	case HWTSTAMP_TX_OFF:
>   		tsync_tx_ctl = 0;
> @@ -576,20 +575,18 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
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
> +		rx_enabled = true;
> +		rx_in_register = true;
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
>   		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
> -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
> +		rx_enabled = true;
> +		rx_in_register = true;
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>   	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> @@ -602,9 +599,9 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>   		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
>   		is_l2 = true;
> +		rx_enabled = true;
> +		rx_in_register = true;
>   		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> -		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
> -		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>   		break;
>   	default:
>   		/* register PSR_1588_MSG must be set in order to do V1 packets,
> @@ -643,7 +640,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>   	WX_WRITE_FLUSH(wx);
>   
>   	/* configure adapter flags only when HW is actually configured */
> -	memcpy(wx->flags, flags, sizeof(wx->flags));
> +	assign_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags, rx_enabled);
> +	assign_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags, rx_in_register);
>   
>   	/* clear TX/RX timestamp state, just to be sure */
>   	wx_ptp_clear_tx_timestamp(wx);

