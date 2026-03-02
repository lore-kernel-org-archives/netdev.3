Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7E38CFF3;
	Mon,  2 Mar 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442718; cv=none; b=oXGUHiiHlH3Wkgk0vzob8WuX0PiEjYCdppBv8mYNDs/Y/HgJ5Ua4E3TBZ76c6G59shADc1hYYB7tVFGCA1f8Vy4SOz7zl9pIGUZADX/yziAH/cckzWW5s8YzyuFMxvyqvXYVYisbdAG3WBrlPq0Sq/D8nO3aSFT4a0WFzcaQkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442718; c=relaxed/simple;
	bh=gpEwgYAvNErKaj0H5RnVxorvbwrMnR0d5y8BRXb9rXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvpUuMwyJh3QUP/n2mf+sWyLfeGl5jduFtSkJ2oQyNCsCc7wrrt/9x+9YWus7z1/vMQO51k1gCwgdBLhDzTd8COzSaCsRxdSd8SoNypFFfEYS5KRUZA29NVo3+u+bwY1ZxLS24AnG+0UQjEPF0hnrlWTMZ85ZNvoU2ZlRV/JUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.221] (p5b13a7da.dip0.t-ipconnect.de [91.19.167.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 125914C2C37D60;
	Mon, 02 Mar 2026 10:10:54 +0100 (CET)
Message-ID: <a58053f0-9780-4226-87ea-d4cf9bf32383@molgen.mpg.de>
Date: Mon, 2 Mar 2026 10:10:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,


Thank you for the patch. In the summary/title I’d add the header name. 
Should you resend, maybe:

i40e: Include missing wordpart.h header

Am 02.03.26 um 10:03 schrieb Andy Shevchenko:
> When cleaning up another header I have met this build error:
> 
> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit declaration of function 'upper_32_bits' [-Wimplicit-function-declaration]
>    105 |         val1 = (u32)(upper_32_bits(pa));                                \
> 
> This is due to missing header, add it to fix the possible issue.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> index 480e3a883cc7..967711405919 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> @@ -4,6 +4,8 @@
>   #ifndef _I40E_HMC_H_
>   #define _I40E_HMC_H_
>   
> +#include <linux/wordpart.h>
> +
>   #include "i40e_alloc.h"
>   #include "i40e_io.h"
>   #include "i40e_register.h"

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
