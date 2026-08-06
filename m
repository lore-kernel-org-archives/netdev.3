Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959303F9A13
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057235; cv=none; b=qyWJbYiCoIDYeUNNBgId+ecRYk8EE1LZBv1ssul0Ga30zumvH6sV7pCw90z6CkXyelBJrTkvFt52y/4sEi5K6IbQHKPU4JJ05Gi0kW+YSbXo6Anqd2Unb6YmnSdK1YZKUeIkHrsH8MsiB/wuzELF7HhkK1LQX3k09ohxuDADhWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057235; c=relaxed/simple;
	bh=ej8Y6axyqvzb7Ub7bz/JJpVG8+y0dcJmH5i84jGd1Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEm2mynYeSNc7373TYF2PJ/jgGdIlsEI+ICGhQbRp4bgprY03j2bWveVrxLSuWFrkAJLRLxPglAcg8C9jTtdkRQM5hfId73bqwD1sbbCV7owzUJ7fzbJVyi2Hd2sRSUYAjuVDPY0YJBUASA8pUtXctpqWni1TAotJxyQK0P/LtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=myA4yZ+a; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="myA4yZ+a"
Message-ID: <513b009f-9327-4524-98b0-82b83121665a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786057220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqewZicBEE/9CSfu3Alzejq9D6xNumNCLUpfdabbtEI=;
	b=myA4yZ+aIn0x1+LrbtSZIWEYXdjCAM4UZIaUFxXatt6wkRLtRAcJPclflxuZ4W8IMm9dfc
	3vhHSr65AGBHiQ8hCWFklgKKnh4BLS/VZnCxMD3JxliBjBir5t3PwCtMkZxuMpBAv8pHdk
	/WQggLOrZ0EtMZ6VzC7lH9X+sfGrAjg=
Date: Fri, 7 Aug 2026 00:00:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] octeontx2-af: return tsc value along with PTP
 clock
To: nshettyj@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Harman Kalra <hkalra@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260806161649.2592484-1-nshettyj@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260806161649.2592484-1-nshettyj@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/08/2026 17:16, nshettyj@marvell.com wrote:
> From: Harman Kalra <hkalra@marvell.com>
> 
> This patch updates the existing PTP_OP_GET_CLOCK mbox message to
> return the timestamp counter value, tsc (cntvct_el0 or pmccntr_el0)
> along with the PTP HI clock value.
> 
> In some debugging scenarios, a user might need to read the PTP HI
> clock value in the fastpath to know how many ticks have been spent
> since the reception of the packet (as the packet reception tick value
> is already appended to the packet by CGX). If the PTP_OP_GET_CLOCK
> mbox message is sent every time the user wants to record the PTP HI
> clock value, it will bring down performance to a great extent as mbox
> communication is a very expensive process.
> 
> To handle this, the PTP HI clock can be derived from the timestamp
> counter (tsc, which could be running at 100MHz or system freq) using
> two parameters: freq multiplier (ratio of frequencies of PTP HI clock
> and tsc) and clock delta (by how much tsc is lagging from PTP HI
> clock).
> 
> By returning both the PTP_HI value and the tsc value simultaneously
> via PTP_OP_GET_CLOCK, the consumer can calculate these parameters
> without being affected by mbox propagation delay:
>       freq_mult = (freq of PTP HI clock) / (freq of tsc counter)
>       clk_delta = (PTP_HI clock value / freq_mult) - (tsc val)
> 
> Now, whenever the user wants to know the PTP HI clock in the fastpath,
> it can be derived from the local tsc counter:
>       PTP_HI val = (tsc value + clk_delta) * freq_mult
> 
> Signed-off-by: Harman Kalra <hkalra@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> ---
>   .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
>   .../net/ethernet/marvell/octeontx2/af/ptp.c   | 26 ++++++++++++++++---
>   2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 73f743e4a83d..21c3d3d5018e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -2010,6 +2010,7 @@ struct ptp_req {
>   	struct mbox_msghdr hdr;
>   	u8 op;
>   	s64 scaled_ppm;
> +	u8 is_pmu;
>   	u64 thresh;
>   	u64 period;
>   	int pps_on;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> index 58e62e955554..0b66a86246b6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> @@ -356,10 +356,27 @@ static int ptp_adjfine(struct ptp *ptp, long scaled_ppm)
>   	return 0;
>   }
>   
> -static int ptp_get_clock(struct ptp *ptp, u64 *clk)
> +static inline u64 get_tsc(bool is_pmu)
>   {
> -	/* Return the current PTP clock */
> -	*clk = ptp->read_ptp_tstmp(ptp);
> +#if defined(CONFIG_ARM64)
> +	return is_pmu ? read_sysreg(pmccntr_el0) : read_sysreg(cntvct_el0);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static int ptp_get_clock(struct ptp *ptp, bool is_pmu, u64 *clk, u64 *tsc)
> +{
> +	u64 end, start;
> +	u8 retries = 0;
> +
> +	do {
> +		start = get_tsc(0);
> +		*tsc = get_tsc(is_pmu);
> +		*clk = ptp->read_ptp_tstmp(ptp);
> +		end = get_tsc(0);
> +		retries++;
> +	} while (((end - start) > 50) && retries < 5);

didn't fully get why do you need this cycle? what are you trying to
avoid?

>   
>   	return 0;
>   }
> @@ -636,7 +653,8 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct ptp_req *req,
>   		err = ptp_adjfine(rvu->ptp, req->scaled_ppm);
>   		break;
>   	case PTP_OP_GET_CLOCK:
> -		err = ptp_get_clock(rvu->ptp, &rsp->clk);
> +		err = ptp_get_clock(rvu->ptp, req->is_pmu, &rsp->clk,
> +				    &rsp->tsc);
>   		break;
>   	case PTP_OP_GET_TSTMP:
>   		err = ptp_get_tstmp(rvu->ptp, &rsp->clk);

