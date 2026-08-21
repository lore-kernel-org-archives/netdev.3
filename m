Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC774BCAA9
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321999; cv=none; b=S/XQsndofjQL6rJZBG8oqGeVixW9cbxa2h5eqYagB2b3A3uvDh5uamjQcOVFZf39PAEeey1h29nnSIn0U/YRYfMa8o40UZoPW0rPk7/dfHAPphgajHLVZaBnN8njSrF6CowgN61NXhRKS2UeeGZCfW7UGt/pew75sQoSCbLZR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321999; c=relaxed/simple;
	bh=30dgUeF8nq3gFuucpnA7d+4X0E+MdvD79jszBHaHOnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBE5tx/rl4iD/Bd8/yN/YKQbX3DlFAiv5wxeLc1wyuvO7pHF1qJFTPcrYZMKp/+L7X/ryjJtYEW+a4f7FEC0wthX/nUKIOFJ4cxTGjHlDS0Xx62QAEtr6UAa/g4h+jNr1osphSWVL7xA/eculQaQku+qxc7SeyGzG794PhM/Vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/GGdQFd; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/GGdQFd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=30dgUeF8nq3gFuucpnA7d+4X0E+MdvD79jszBHaHOnE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787321991; v=1; x=1787926791;
 b=O/GGdQFdlIzectrUe0yq0qIypANbpL90EujkY6fH0wUb3FgnV2evwjMwWog91pA3MFKDEld8
 bSoNvyQT1BmHaVS2sdsPP63RQj59Lrn/GAjpmDII/2SIzWcTtYgvEUQzI4QShH+rCY5Woih4Pda
 +lS/hpwCCKrhX54RCcznKedE=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (64.43.10.89)
	by smtp.migadu.com with ESMTPS id c10daf7e2ae57278;
	Fri, 21 Aug 2026 14:19:40 +0000
X-Mizu-Trace-ID: c10daf7e2ae57278
X-Migadu-Flow: FLOW_OUT
Message-ID: <cce99077-b458-4bf8-9bbe-7ed92d3613cf@linux.dev>
Date: Fri, 21 Aug 2026 15:19:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bnxt_en: Fix call to hardware monitoring event handler
To: Guenter Roeck <linux@roeck-us.net>,
 Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
References: <20260821044512.663941-1-linux@roeck-us.net>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260821044512.663941-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2026 05:45, Guenter Roeck wrote:
> The first parameter of hwmon_notify_event() is supposed to be the hardware
> monitoring device. The bnxt driver calls it with the platform device as
> first parameter instead. This API break results in undefined behavior and
> may result in a crash.
> 
> Pass the hardware monitoring device as parameter instead to fix the
> problem.
> 
> Fixes: a19b4801457b0 ("bnxt_en: Event handler for Thermal event")
> Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> index de3427c6c6aa..faed0cf726e1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -40,7 +40,7 @@ void bnxt_hwmon_notify_event(struct bnxt *bp)
>   		return;
>   	}
>   
> -	hwmon_notify_event(&bp->pdev->dev, hwmon_temp, attr, 0);
> +	hwmon_notify_event(bp->hwmon_dev, hwmon_temp, attr, 0);
>   }
>   
>   static int bnxt_hwrm_temp_query(struct bnxt *bp, u8 *temp)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
