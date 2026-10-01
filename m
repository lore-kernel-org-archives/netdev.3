Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8683002C8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858903; cv=none; b=iUIx2Tj01jgkcu8kQwkADMTb2qQvAmoRmboSMOUX+HYI8Kk8US8rjiphk2PhCNuUO0IPDHPoCRmx/eeoaRz56Smsa2BGTg8SqKBxe27PB4LdObGpMaNG7TgwM8R86UxsTWZ/dmLrGiIx4IrhyxtXEPFwVIJ4sKbE1TjUgCU5L9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858903; c=relaxed/simple;
	bh=yzA7rRKhPz/QQiKc5afs4k0NhYhqDDF0wu/OiUk4vYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/Tbi3zPuwUVIC0nG/nAaswIvd/pcL5jKTarX3B8muCfmnIRpS9Ryuu/9RNNXZP7rfar4nQjbfnee+xX0u5Yegw1lRaW7U2fZwYYhQyEd/DbOGWypcE7MOPYBTYaFw0d4jo71gCRy8eua+BFwS4veMlRgwSIKv2g5ol1zOREHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from [10.193.191.42] (Ayushsawal.asicdesigners.com [10.193.191.42])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 691CmB01007196;
	Thu, 1 Oct 2026 05:48:12 -0700
Message-ID: <03db0cd6-6a39-4cb0-a8f5-cb0d1e2b7663@chelsio.com>
Date: Thu, 1 Oct 2026 18:17:52 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] cxgb4/ch_ktls: disable softirqs around tid_list
 erases
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: netdev@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
References: <179070264839.12871.11715792321728503844.idr-bug-51@gmail.com>
Content-Language: en-US
From: Ayush Sawal <ayush.sawal@chelsio.com>
In-Reply-To: <179070264839.12871.11715792321728503844.idr-bug-51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29-09-2026 23:07, Sang-Hoon Choi wrote:
> chcr_ktls_cpl_act_open_rpl() inserts into tid_list from the receive path
> using xa_insert_bh().  The array is shared by the adapter's connections
> and initialized with XA_FLAGS_LOCK_BH.  However, chcr_ktls_dev_del() and
> the chcr_ktls_dev_add() error path use xa_erase(), which takes the XArray
> lock without disabling softirqs.
>
> When cleanup runs with softirqs enabled, a receive softirq for another
> connection on the same CPU can interrupt the erase and spin on the lock
> held by the interrupted task.  Use xa_erase_bh() at both sites to match
> the insertion path.
>
> Fixes: 65e302a9bd57 ("cxgb4/ch_ktls: Clear resources when pf4 device is removed")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Compile-tested with x86_64 allmodconfig and W=1.
> I have not tested this on Chelsio hardware.
>
>   drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> index f5acd4be1e69dcb551758dd27808a1b1eec374bd..dbec95b4977736b9b2fefdf5648a7eaca16429cb 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> @@ -389,7 +389,7 @@ static void chcr_ktls_dev_del(struct net_device *netdev,
>   		cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
>   				 tx_info->tid, tx_info->ip_family);
>   
> -		xa_erase(&u_ctx->tid_list, tx_info->tid);
> +		xa_erase_bh(&u_ctx->tid_list, tx_info->tid);
>   	}
>   
>   	port_stats = &tx_info->adap->ch_ktls_stats.ktls_port[tx_info->port_id];
> @@ -577,7 +577,7 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
>   	cxgb4_remove_tid(&tx_info->adap->tids, tx_info->tx_chan,
>   			 tx_info->tid, tx_info->ip_family);
>   
> -	xa_erase(&u_ctx->tid_list, tx_info->tid);
> +	xa_erase_bh(&u_ctx->tid_list, tx_info->tid);
>   
>   put_module:
>   	/* release module refcount */
Thanks for the patch. Because of the uld_mutex taken in
cxgb4_ktls_dev_add/del, this issue was not coming, but the
change is correct and keeps the locking consistent with
XA_FLAGS_LOCK_BH.

Reviewed-by: Ayush Sawal <ayush.sawal@chelsio.com>
