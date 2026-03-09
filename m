Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF5125B2
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074091; cv=none; b=ekVwjlXMdJ4c71DllBLO1jTCcmuHPagc3GZZQLFgXEF0YyD8xt25lmGq8KHPoULTlXRajaFnB8qaBbwrVfehim0ScAXaLJNDrH4KQycAN1NY5kjoLwFbYU5sPboLysWdWfkatIV6p9uT8wCv4BUCs+iUE+tLGiWbZSh6rCT0V/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074091; c=relaxed/simple;
	bh=tnI2LHAW214hmRao5KRPErJwDLxYQCUL2oBLFeCtlKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIZdNgSzKut/VPSC5B2mv8CUIdO+ZY322AFG/mk0v7AY6RBZ7Bq3qdH7RVgwGNvoPVCAmW8EhAmLyxbhZq1cCTcwS6zu38xnsl9D/l9o3eD6bC551oQYLI4zXY8094Yov530QXIEhIqDew1Br9oaZnDFn5VpFVfURQ+1IFPj4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A419C4C2C37D47;
	Mon, 09 Mar 2026 17:34:28 +0100 (CET)
Message-ID: <530f6250-549c-46b2-8c53-3e91f843f6c2@molgen.mpg.de>
Date: Mon, 9 Mar 2026 17:34:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported flags
 in ptp_clock_info
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Przemyslaw,


Thank you for your patch.

Am 09.03.26 um 15:11 schrieb Przemyslaw Korba:
> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
> requires that the driver set the .supported_perout_flags and
> .supported_extts_flags fields in PTP clock info. Otherwise, the additional
> flags will be rejected by the kernel automatically.
> 
> i40e does not support perout flags, so reject any request with perout
> flags.

As you reference commits, why not add Fixes: tags?

> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7bcea7d9720f..8d7958692235 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
>   	/* TODO: Implement flags handling for EXTTS and PEROUT */
>   	switch (rq->type) {
>   	case PTP_CLK_REQ_EXTTS:
> +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> +					PTP_RISING_EDGE |
> +					PTP_FALLING_EDGE |
> +					PTP_STRICT_FLAGS))
> +			return -EOPNOTSUPP;
> +
>   		func = PTP_PF_EXTTS;
>   		chan = rq->extts.index;
>   		break;
>   	case PTP_CLK_REQ_PEROUT:
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
>   		func = PTP_PF_PEROUT;
>   		chan = rq->perout.index;
>   		break;
> @@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
>   	pf->ptp_caps.n_ext_ts = 2;
>   	pf->ptp_caps.pps = 1;
>   	pf->ptp_caps.n_per_out = 2;
> -
> +	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
> +					     PTP_FALLING_EDGE |
> +					     PTP_STRICT_FLAGS;
>   	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
>   					       pf->ptp_caps.n_pins);
>   	if (!pf->ptp_caps.pin_config)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
