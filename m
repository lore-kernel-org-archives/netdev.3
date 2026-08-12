Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5636196E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565375; cv=none; b=ALg26Y2OPQvvNzSLdvVI9B/fFn05WUe6c/TCgafHn8H/eEBUxYMJqbWTxhSdsCCqerqidvFIr/7boPNMkn0SPcLI36IGXEtMYfWfDkbG4B8GyFsNI1y6cjBMvZXmjswpJFXEcZsA4jMUZxW2z6vshs5DBLdwLR5zXoCHAHL/I7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565375; c=relaxed/simple;
	bh=GJz5pzzAKdVaJHcweh8sKBzQTcyHQlpB+ctFxzyrbGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYrij7FgXRqtmWWc9uKwmszDxdC/LdMb1PmiooilGdz2EOZa8QCrgV+scmv8gw3HtoEQS//CITRStoUbDap5ldJEhBFUJYWZud0z7WOkL+EwNLCyNONZipSZafkWNBpu1p2Y/VRT4d9OebkLuHJWjKKWSKVomOC6R205ex+VN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lw7hmXb2; arc=none smtp.client-ip=95.215.58.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lw7hmXb2"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GJz5pzzAKdVaJHcweh8sKBzQTcyHQlpB+ctFxzyrbGc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786565370; v=1; x=1787170170;
 b=Lw7hmXb2pT24xHg1bbaqiV25dACScJaf1ARKzMYdZ+3807ONrCGgt94kd2g0JVNJyW2EYXnt
 ynJ57eS2EI/sFvewkqYrm7V0rbK7eXz/0C15dmuz9gLnfDMsysXerPQmmdzO0FKLF9VI1JsNqtB
 uzxqIp3e9zbB74pekfl6G2ug=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.45] (109.76.184.122)
	by smtp.migadu.com with ESMTPS id be942cd7d785bcd9;
	Wed, 12 Aug 2026 20:09:30 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <17036d8f-ce1b-49a0-9aae-f28f7d75fdf8@linux.dev>
Date: Wed, 12 Aug 2026 21:09:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: tsconfig: reject zero-valued tx_type
 and rx_filter bitsets
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch
References: <20260812162230.1837788-1-kuba@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260812162230.1837788-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.2026 17:22, Jakub Kicinski wrote:
> The ffs()/fls() guard in ethnl_set_tsconfig() was meant to enforce
> that the user selects exactly one tx_type (and one rx_filter)
> at a time (off / none are explicit types with non-zero values).
> However, both ffs(0) and fls(0) return 0, so the guard passes
> a zero-valued bitset through.
> 
> The subsequent ffs(req_tx_type) - 1 would produce -1, if user selected
> no bit. net_hwtstamp_validate() catches the invalid -1 downstream,
> but returns a generic error (-ERANGE) without telling the user
> what went wrong. Return -EINVAL + extack instead.
> 
> Replace the ffs()/fls() comparison with a hweight32() == 1 check.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: vadim.fedorenko@linux.dev
> ---
>   net/ethtool/tsconfig.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index 24b64862011f..6be3aa5d4bc1 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c
> @@ -359,8 +359,10 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
>   		if (ret < 0)
>   			goto err_free_hwprov;
>   
> -		/* Select only one tx type at a time */
> -		if (ffs(req_tx_type) != fls(req_tx_type)) {
> +		/* Select exactly one tx type at a time */
> +		if (hweight32(req_tx_type) != 1) {
> +			NL_SET_BAD_ATTR(info->extack,
> +					tb[ETHTOOL_A_TSCONFIG_TX_TYPES]);
>   			ret = -EINVAL;
>   			goto err_free_hwprov;
>   		}
> @@ -380,8 +382,10 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
>   		if (ret < 0)
>   			goto err_free_hwprov;
>   
> -		/* Select only one rx filter at a time */
> -		if (ffs(req_rx_filter) != fls(req_rx_filter)) {
> +		/* Select exactly one rx filter at a time */
> +		if (hweight32(req_rx_filter) != 1) {
> +			NL_SET_BAD_ATTR(info->extack,
> +					tb[ETHTOOL_A_TSCONFIG_RX_FILTERS]);
>   			ret = -EINVAL;
>   			goto err_free_hwprov;
>   		}
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
