Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1B4772AD
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149438; cv=none; b=qsdsHlbQI1rjD+CZ9kvWn70VsZn0OLT2O3DJ8DKkwSBIs38gHh8qjE4ZgZU0vVgPVjHuNl+FuQum+jSdSjQaXHr/icjkR9qd5z5bIKGMOFo6OJNcu3UdJpu02nNfYMTHj2v3mObLErcN2Pm7fZInsuQz2tCE1jeC7uqu7cx0Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149438; c=relaxed/simple;
	bh=hTgQEMfpwyZOQZzZcZQI8UvRBKCiyj+u2NSj5kyeUfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZGroMAXSNHLq0idAN6zPGzfRORRg0nI/o3NyepQsg52X5+QMaZC2jZiratJpx4qSFsgaRvrI1qRJDNaQw4Z8+ulvpQPm9DbJW6pAQDW1LcQBo4SEiHlFM6lgeukiSEnC5x7Um82RM5SyvkLve5lJAo4X/ESnf8EtjtY0uTtBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qno71NrC; arc=none smtp.client-ip=91.218.175.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qno71NrC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hTgQEMfpwyZOQZzZcZQI8UvRBKCiyj+u2NSj5kyeUfs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792149431; v=1; x=1792754231;
 b=qno71NrCkWn5SwjEBMDQ590u5v6WQw/N+XTc9A3buGj7lkzzRySZ5LvOnq/p91bLBQ8K4bvg
 2mv5Ri32qNILAcibEVwGYF/uHf/FBTFPj76yh6CeY8FtX2du5zw44cIQbr85xpdCTuyhYBW45gh
 GM1kv6h/wId4twFatrQY5+6E=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d37c0f3850b60ceb;
	Fri, 16 Oct 2026 11:17:11 +0000
X-Mizu-Trace-ID: d37c0f3850b60ceb
X-Migadu-Flow: FLOW_OUT
Message-ID: <6383302a-4605-460a-b57b-e90a8bd85235@linux.dev>
Date: Fri, 16 Oct 2026 12:17:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] ionic: fix port_info use-after-free on
 firmware recovery
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
 Eric Dumazet <edumazet@kernel.org>
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
 <20261015-ionic-port-info-lifetime-v2-1-57232013fd79@amd.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-1-57232013fd79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 00:03, Eric Joyner wrote:
> From: "Nikhil P. Rao" <nikhil.rao@amd.com>
> 
> ionic_port_init() allocates port_info when the pointer is NULL, but its
> error path frees it without checking whether this call allocated it.
> Before commit ddc5911b9bd2 ("ionic: call ionic_port_init after
> fw-upgrade") the function returned early when the buffer already
> existed, so the two were symmetric.
> 
> Since then a failed PORT_INIT on either recovery path - fw_up or
> reset_done - frees a buffer an earlier init owns, while the netdev is
> registered and the ethtool ops are reading it.
> 
> Free only what this call allocated.
> 
> Fixes: ddc5911b9bd2 ("ionic: call ionic_port_init after fw-upgrade")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_main.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> index 10501be9ef95..38b47b959a11 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -722,6 +722,7 @@ int ionic_port_init(struct ionic *ionic)
>   {
>   	struct ionic_identity *ident = &ionic->ident;
>   	struct ionic_dev *idev = &ionic->idev;
> +	bool allocated = false;
>   	size_t sz;
>   	int err;
>   
> @@ -733,6 +734,8 @@ int ionic_port_init(struct ionic *ionic)
>   						     GFP_KERNEL);
>   		if (!idev->port_info)
>   			return -ENOMEM;
> +
> +		allocated = true;
>   	}
>   
>   	/* If the driver knows about more "extra stats" than the firmware,
> @@ -757,10 +760,12 @@ int ionic_port_init(struct ionic *ionic)
>   	mutex_unlock(&ionic->dev_cmd_lock);
>   	if (err) {
>   		dev_err(ionic->dev, "Failed to init port\n");
> -		dma_free_coherent(ionic->dev, idev->port_info_sz,
> -				  idev->port_info, idev->port_info_pa);
> -		idev->port_info = NULL;
> -		idev->port_info_pa = 0;
> +		if (allocated) {
> +			dma_free_coherent(ionic->dev, idev->port_info_sz,
> +					  idev->port_info, idev->port_info_pa);
> +			idev->port_info = NULL;
> +			idev->port_info_pa = 0;
> +		}
>   	}
>   
>   	return err;
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
