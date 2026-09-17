Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCA3515F7;
	Thu, 17 Sep 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629305; cv=none; b=Z/0WG18G6boU2z93LFUo4Pla9PJ4O5PQCyDVggZH6Ia6Rh2cr4ILhc0t95UzU5azZZxdmZsMvhUFMZljhpiUqWrN/XA5iH+IWt9nJnafOaJS48bpDI7SMey5bbZiccCfwqeSBjpcxX/gJXeDsO5fTFWrEr8APmDe9lnnCWz1GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629305; c=relaxed/simple;
	bh=Auza6V3IkRxhlLfQVhZ2RRQQcb3SjbYSgPj7asL91KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBWfd+rFpTR+yBu/9ybeMz65+iCqkq5l4UBSz0vHL0Vy8QVa5OHZD0T9GCcTf0Nb+nohI5R85LIJXnpXXxnHwacDLtiUH3Jc4ZZff0c1rEOSuhWMjp09viNC3d1OJ5lbBGu0CLSA/j/QvDzzVBUwpuYFUyvnScOun97f1hBPauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b=PgAl7Gw5; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b="PgAl7Gw5"
Received: from [192.168.2.217] (p5dc55dbb.dip0.t-ipconnect.de [93.197.93.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 873484C442F868;
	Thu, 17 Sep 2026 09:13:10 +0200 (CEST)
Message-ID: <636c578a-b88e-4d76-861c-85b37e014f19@molgen.mpg.de>
Date: Thu, 17 Sep 2026 09:13:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
To: Linkui Xiao <xiaolinkui@126.com>, Linkui Xiao <xiaolinkui@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917065436.1181073-1-xiaolinkui@126.com>
 <20260917065436.1181073-2-xiaolinkui@126.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260917065436.1181073-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1789629191; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=dipoDHFX57jnaEmHMtdQX+Ggi0lRYpsDPlvh9ECu+jI=; 
	b=PgAl7Gw54zLQmoV8LNZsKV7nubghYfI17ZjLQCZWK9YHSvOqOo8KjwD0sLzWFAWdT5V4az8917Yf
	RfrF2czesILqWDZ2wdbWEoGV0wabgaIbHa81IKuJC33+MC3mUQaTuaqRRMifQmZH05LR+PwPZCPM56
	4fjB6zW0NTWSA09xr7SK5+BImKfiMl4R0muJ7IDB1demAyL52uz7PzWWZI2oQFFxmBy7CYsPdCWSIz
	NiPIFOSiaHr33HYlVrTzOCTOuhLil4zMjn8YqAZeHUr8p6I4FrIJadUufFLSuv3d5LghF2oRFb3F07
	WKC9MeclXkZLJnHT4bT3JqkgmsqF1YBg==

Dear Linkui,


Thank you for your patch.

Am 17.09.26 um 08:54 schrieb Linkui Xiao:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC is misleading: the value counts 0.5 s
> poll iterations, not seconds, as the comment right above it already
> explains. Rename it to IXGBE_DEVLINK_RELOAD_MAX_ITER, which says what the
> value actually is.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index 781f13240a0d..15b14c5a7c4e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
>   }
>   
>   /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_MAX_ITER	20
>   
>   /**
>    * ixgbe_devlink_reload_empr_finish - finishes EMP reset
> @@ -464,7 +464,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>   
>   		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>   
> -		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >= IXGBE_DEVLINK_RELOAD_MAX_ITER)
>   			return -ETIME;
>   
>   	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
