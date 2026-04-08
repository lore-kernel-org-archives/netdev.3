Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8433B4E9E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649493; cv=none; b=LFK4anMTEaWJAuKtyEvqKScEj+VxA/bnG/jncEHPP1VM1Uo+VKttmb0ranwV9s5YOw2l/OpOlEdxzt9jSLT98oJkjPElsGJBv8RvRch5Tt6jWgmyAfkuaQb3MGbkkwQPbELs5rbf8cdGv5XQk0k7esyZNk2xim6fNlqERKP/49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649493; c=relaxed/simple;
	bh=qOXbjFKSIKMgyWQ+P/2PzjP0uclT1CgXxQ5h7JCed6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRvceIKONwaCZc4OzKNp2w5U8aDO8oF8F7fegS8RWomEPYWkHi1UBKlIN7f7IGCUrlIfzWa64QiM68pWr77/AcFuOIkbYSWb/EXdAs1zQPM1ZYwFvgen6tqAADZbwXKhGk8WZA45pW5GYOB26khhzje114RyHW1JSxAFcfK/dFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D89D24C2C37F04;
	Wed, 08 Apr 2026 13:57:47 +0200 (CEST)
Message-ID: <5496af54-1bfa-4ecd-9565-b87a9df81277@molgen.mpg.de>
Date: Wed, 8 Apr 2026 13:57:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: use ktime_get_real
 helpers in igb_ptp_reset()
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20260408083521.1620447-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260408083521.1620447-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Aleksandr,


Thank you for your patch.

Am 08.04.26 um 10:35 schrieb Aleksandr Loktionov:
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() and ktime_to_timespec64(ktime_get_real()) with
> ktime_get_real_ts64() in igb_ptp_reset().  Using the combined helpers
> avoids the unnecessary intermediate ktime_t variable and makes the
> intent clearer.

No intermediate variable is removed in the diff below. What am I missing?

> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_ptp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index bd85d02..638d824 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -1500,12 +1500,13 @@ void igb_ptp_reset(struct igb_adapter *adapter)
>   
>   	/* Re-initialize the timer. */
>   	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
> -		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
> +		struct timespec64 ts;
>   
> +		ktime_get_real_ts64(&ts);
>   		igb_ptp_write_i210(adapter, &ts);
>   	} else {
>   		timecounter_init(&adapter->tc, &adapter->cc,
> -				 ktime_to_ns(ktime_get_real()));
> +				 ktime_get_real_ns());
>   	}
>   out:
>   	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);

With the commit message clarified, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
