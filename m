Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EC42980C
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627314; cv=none; b=BB6w1rGHsnPrFH7V7rtQ26rr9gSf3bA+vZstZkO4hGgROhjArItFtJ0jm10p5QnZIwav80CJ8eMaSr6jWYgBftwc5WkuFW6EYf7/6uEd1YAdJIAjmenEFfLERUkpZfCNHLnvMzRlpcGW/BAHcbqAA40Ary7Og7o9BWZn25pZCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627314; c=relaxed/simple;
	bh=ZR8tGn+UwgUsJBZEd8GIoUSyUM9byLcSp266a5IsPqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbgLNedQ+bJAWEN9DBPT1FDfV/uueWN+V01gav9hiM7PbiqA/Zovo35xRrlfLpEUsbWplnPGpyxGAk4bqhfdF9/xnhX+830X4ZBVns5XrjvTR38Wq6S/GfD3JBfDHTIWi/jVnjWg0YjQonqK30wUfcdMqst36irh4ikJ2sjgzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oP+ewIOa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oP+ewIOa"
Message-ID: <882f9018-30bc-41b9-ad18-1952ecf8c113@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784627300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMNwlLtLuVerZt0Q8EEv1h2+FsKt+8QdW2oDFQgLI40=;
	b=oP+ewIOah5xX6rl1r4NE94+TJ9iKaDklNS5gKOrSCj5Rf4w8E/bk95QWRoej/2ERzdTJbF
	eVpRR9LwBDdRskDjkklhNdY7HlQsXix/0RDgvSFXPfNggcb/PDxk9OzuEamujm4a3HQ8nl
	xDbRxZyb8mm4QuHtR2bLsfmTaSTK3Og=
Date: Tue, 21 Jul 2026 10:47:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] nfc: nci: free destination parameters when closing a
 connection
To: Linmao Li <lilinmao@kylinos.cn>, David Heidelberg <david@ixit.cz>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721023518.1697625-1-lilinmao@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260721023518.1697625-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/07/2026 03:35, Linmao Li wrote:
> When a connection is closed, nci_core_conn_close_rsp_packet() frees
> conn_info but not conn_info->dest_params, which is a separate devm
> allocation. Each connect/close cycle leaks one dest_params until the
> NFC device is removed. Free dest_params along with conn_info.
> 
> Fixes: 9b8d1a4cf2aa ("nfc: nci: Add an additional parameter to identify a connection id")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>   net/nfc/nci/rsp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index 6b2fa6bdbd14..21c2fe64490e 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -360,6 +360,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
>   			list_del(&conn_info->list);
>   			if (conn_info == ndev->rf_conn_info)
>   				ndev->rf_conn_info = NULL;
> +			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
>   			devm_kfree(&ndev->nfc_dev->dev, conn_info);
>   		}
>   	}

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
