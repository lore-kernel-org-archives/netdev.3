Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94A4BC00B
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817529; cv=none; b=QNl8bGTkfBTv+wXcN7Sn2Bx3itpGJ1tnw8r8I2E2+9bd4gQHRp7aMBhmvIiK773LvpmFSnBWQyXoHO34PEAM/0wUacrMS97QzDE1WTNhIGv2uSs5dLTsEZeXM0K/20JIbv4Wvmju1C15ZpnZfWP1mtG4RlM3eJWM9fPJhXkaOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817529; c=relaxed/simple;
	bh=Tw6M+WSaMfmJ/G2awrbP09AflUAlLd0gcOGRsqROftg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5U5ymx+6Lpu52EvZW5Yp34X4gnaJv8DxvZs0DYn6La8BjAFvGEG/zR3pHGgjYAw0KCijTKL+JN8qozReNIU0LWPNtXFwh0w1TVqSMsJZXAogrPPn39m0a2JR0VTcq5y/ggrKSyDRaPX/Bm0CWDZqoZrnftyB2BE7lLQhmSs6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LFI1v4GA; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LFI1v4GA"
Message-ID: <6240bb89-1f95-45a9-b7e2-f30593abeeaf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784817514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOB6Msk5u3qQCjvJvZrBvvw5NVn36okl1ebBZiNrd+c=;
	b=LFI1v4GAHQ901gcU5ZmXRxVhrVSewOnwXnPMLA19D2sRl5rtZNb3N158lqAmCC0/UivlQC
	J37izBVge4Hj9PGSunn8TUvZGG5ZNvNrwqMHkvOkRJkRpNuzD3zuLLFDSzw0CSgeDpiNUk
	/EKB8ftnQwpomLfC1uT0WLfM6hcY/B8=
Date: Thu, 23 Jul 2026 07:38:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] forcedeth: fix UAF of txrx_stats in nv_remove
To: Chenguang Zhao <chenguang.zhao@linux.dev>, rain.1986.08.12@gmail.com,
 zyjzyj2000@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/7/23 2:26, Chenguang Zhao 写道:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> nv_remove() frees the per-CPU txrx_stats before unregister_netdev().
> Until unregister completes, ndo_get_stats64, the NAPI/xmit data path,
> and nv_close()/drain may still access txrx_stats, leading to a
> use-after-free.
>
> Free the stats only after unregister_netdev().
>
> Fixes: f4b633b911fd ("forcedeth: use per cpu to collect xmit/recv statistics")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Thanks a lot. I am fine with it.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/net/ethernet/nvidia/forcedeth.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
> index 5b0435d7bc39..106885bd0f6b 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -6187,9 +6187,11 @@ static void nv_remove(struct pci_dev *pci_dev)
>   	struct net_device *dev = pci_get_drvdata(pci_dev);
>   	struct fe_priv *np = netdev_priv(dev);
>   
> -	free_percpu(np->txrx_stats);
> -
> +	/* txrx_stats is used by ndo_get_stats64 and the data path until
> +	 * unregister_netdevice() has completed.
> +	 */
>   	unregister_netdev(dev);
> +	free_percpu(np->txrx_stats);
>   
>   	nv_restore_mac_addr(pci_dev);
>   

-- 
Best Regards,
Yanjun.Zhu

