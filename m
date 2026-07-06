Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96A41F7CA
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338187; cv=none; b=DyT0z93qFEvcWqKX05Q4uGNzWZ15fXG40KNweEYuBBiaWIlAOcW4+NVE2xXZnMHhoMbZ1kJGdSOJmU+9zP5dN09GN7vcHbFrFSNGpBLhzAqnqaGGGnlGyGfKmOLNb/v+ucHrBNTJ8JiEb0z3rBMMCPi9nGuJMFmAQP0BRPOrvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338187; c=relaxed/simple;
	bh=a06xVfWa6SYvsmjjp2HOBGrgbWN4UUlrbTQI3T0FOv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYSZpwNj5zRydFgqhMz/8SKY4EKtPwDi95vgqBKzVT4tdPeL1+WryjfCNLEkMn0Rjkd2pFXMr+yAI8qAi1mvU424Cg7W6NZpQWpMdVUoqwM7aPOcDz0+JnKAUG0l7mhp7glzNaYInZREHiNT/1mjZ/xOV6oQKl2UbXBQ0lDlN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6iR7Mfr; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q6iR7Mfr"
Message-ID: <65c049ee-4209-4c35-aff4-c4c42f92bb33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783338183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxlHQiawq1DpmHOF5r6CC4nEYAVd/3tojFp0FBDS7Zs=;
	b=Q6iR7Mfr0Ek5CwrYEqLK86PKUnmjE8LIhC/ZZLwNSOs+apqq0smVAN2J0kHEAD0u7ECEzl
	MgOpqzkQC5mrQsj0utdXT9Z+LGnFyOUyXkWkHMmaTy0tOgFbaWuLZQBXKzNzxbYKN/eyoC
	FZxbZoqyibu35AnddpuE0+lzbjF0B+0=
Date: Mon, 6 Jul 2026 12:43:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: netc: explicitly clear TMR_OFF during
 initialization
To: wei.fang@oss.nxp.com, richardcochran@gmail.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com
Cc: netdev@vger.kernel.org, imx@lists.linux.dev, wei.fang@nxp.com
References: <20260706081232.3661826-1-wei.fang@oss.nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260706081232.3661826-1-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/07/2026 09:12, wei.fang@oss.nxp.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The NETC timer does not support function level reset, so TMR_OFF_L/H
> registers are not cleared by pcie_flr(). If TMR_OFF was set to a
> non-zero value in a previous binding, it will persist across driver
> rebind and cause inaccurate PTP time.
> 
> There is also a hardware issue: after a warm reset or soft reset,
> TMR_OFF_L/H registers appear to be cleared to zero, but the timer clock
> domain internally retains the stale value. When the timer is re-enabled,
> TMR_CUR_TIME continues to track the old offset until TMR_OFF is written
> explicitly. This can cause incorrect PTP timestamps and even PTP clock
> synchronization failures.
> 
> Per the recommendation from the IP team, explicitly write 0 to TMR_OFF
> in netc_timer_init() to flush the internally cached value and ensure
> TMR_CUR_TIME follows the freshly initialized counter.
> 
> Fixes: 87a201d59963 ("ptp: netc: add NETC V4 Timer PTP driver support")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/ptp/ptp_netc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 94e952ee6990..5e381c354d74 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -779,6 +779,7 @@ static void netc_timer_init(struct netc_timer *priv)
>   	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>   	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
>   
> +	netc_timer_offset_write(priv, 0);
>   	ktime_get_real_ts64(&now);
>   	ns = timespec64_to_ns(&now);
>   	netc_timer_cnt_write(priv, ns);

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
