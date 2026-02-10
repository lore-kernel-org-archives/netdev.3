Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0735898;
	Tue, 10 Feb 2026 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688020; cv=none; b=ScRtgGr3yqH9L1xz+Vrpt4LUKGHEnwwlM+fkYNqImgHEQ0GjdFp61Jr8MOO0gx/nlnz8NcrjUgU8rsy5MB5nrVqO8g7nANjIKUM6GQzVvHqeTMtVBVd9nhwmheXj0jTktzeTZIASQMn+1yYajiqo5ZiFHnqdfL+dm/1xJ0rPNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688020; c=relaxed/simple;
	bh=VTGVcDP0+rEoS/Io0WxqeAyHdjv53E+obMcu2j7Zbko=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQVaOxKHsPtuE9UHdzJIPScwmtffVmSFjCyvvTITu11D/9GnKtO0IXsI/G+HCOy9H7G6knqWijwKtTf2wjVrcZNtKQl8HrkcMnO92LqXO/bZ5iQKkSnacS947mvo/Kv+0N1wFQYd07rVWRcTc3KyQF/nsgZ6Ry5fuz6cgmic6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CxOWHLVr; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CxOWHLVr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WQJ8v01cyUwKck6D/hbkm4oaohtrbNX+EBPP/js0vKw=;
	b=CxOWHLVrrje/DRCFLZ7EajvAAeLcEo1VbWY6GQ+GOA4T0RDIC67A5t/T82AeuvHNRyEHoDkD4
	hLDMjsYBWihCL0kV//6b78P7aQOXGLiygdjkXQHNzwqAyiIuHLCYyiVvJTiTlH1VlD4a7PAzx3u
	M5EMD7YOX0uQIUU66AhEqy4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f947D3w1RzKm4L;
	Tue, 10 Feb 2026 09:42:16 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AF35D40562;
	Tue, 10 Feb 2026 09:46:54 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Feb 2026 09:46:54 +0800
Message-ID: <cfa65635-8a78-4929-8490-f66b7a38d02e@huawei.com>
Date: Tue, 10 Feb 2026 09:46:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <3chas3@gmail.com>,
	<linux-atm-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<stable@kernel.org>
Subject: Re: [PATCH net v3] atm: fore200e: fix use-after-free in tasklets
 during device removal
To: Duoming Zhou <duoming@zju.edu.cn>, <netdev@vger.kernel.org>
References: <20260209094512.33847-1-duoming@zju.edu.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260209094512.33847-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/2/9 17:45, Duoming Zhou wrote:
> When the PCA-200E or SBA-200E adapter is being detached, the fore200e
> is deallocated. However, the tx_tasklet or rx_tasklet may still be running
> or pending, leading to use-after-free bug when the already freed fore200e
> is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().
>
> One of the race conditions can occur as follows:
>
> CPU 0 (cleanup)           | CPU 1 (tasklet)
> fore200e_pca_remove_one() | fore200e_interrupt()
>    fore200e_shutdown()     |   tasklet_schedule()
>      kfree(fore200e)       | fore200e_tx_tasklet()
>                            |   fore200e-> // UAF
>
> Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
> the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
> synchronize with any pending or running tasklets. Moreover, since
> fore200e_reset() could prevent further interrupts or data transfers,
> the tasklet_kill() should be placed after fore200e_reset() to prevent
> the tasklet from being rescheduled in fore200e_interrupt(). Finally,
> it only needs to do tasklet_kill() when the fore200e state is greater
> than or equal to FORE200E_STATE_IRQ, since tasklets are uninitialized
> in earlier states.
>
> This bug was identified through static analysis.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@kernel.org
> Suggested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v3:
>    - Only do tasklet_kill() when state >= FORE200E_STATE_IRQ.
>    - Make the commit messages clearer.
>
>   drivers/atm/fore200e.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
> index f62e3857144..eb386ec6b5e 100644
> --- a/drivers/atm/fore200e.c
> +++ b/drivers/atm/fore200e.c
> @@ -363,7 +363,12 @@ fore200e_shutdown(struct fore200e* fore200e)
>   	/* first, reset the board to prevent further interrupts or data transfers */
>   	fore200e_reset(fore200e, 0);
>       }
> -
> +#ifdef FORE200E_USE_TASKLET
> +	if (fore200e->state >= FORE200E_STATE_IRQ) {
> +		tasklet_kill(&fore200e->tx_tasklet);
> +		tasklet_kill(&fore200e->rx_tasklet);
> +	}
> +#endif

The code appears to be misaligned.
I see that in the original driver code, the first level of indentation uses 4 spaces,
and the second level uses a TAB (8-character width).
In your code, the first level uses a TAB, and the second level uses two TABs.
Of course, your code complies with the current coding standards.

Additionally, I think a better modification would be to do tasklet_kill()
in the "switch(fore200e->state)-case FORE200E_STATE_IRQ" branch,
because "fore200e->tx_tasklet" is initialized together with "fore200e->irq".

Of course, your current change also looks fine, so
Reviewed-by: Jijie Shao <shaojijie@huawei.com>



