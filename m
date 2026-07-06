Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07763FD943;
	Mon,  6 Jul 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347523; cv=none; b=V4G9OiSOdTa/QFDx4s6FTnd1FfdIIc/9jyitbZt3g04D4eq4v1Q6sn6IQilFBhbQsz87SI7KyWaHIDF5oFCH280GkbgYVV6PM0/bTkzBp2Bl23uCznZv7Kv1eEwgUAvpZpphUQ+2D28hyyJMDJp5/inO1+G4qZozjDiKFKuUEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347523; c=relaxed/simple;
	bh=vegbugGfTFiiLREO9lVZJ01BX9BJRAEFOBuuUJEOkuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+pd12wZk9g8xLzOvi2qaWsU2eq4Ycx7FZL4FWn4GJQhcz/KT6SEHvsPWvykfF0L9kWAOLwGqEsgjlHODQ3RbuchABOAJFznQ08wTH7V8L/mr007o27k5LuZk25VbbgGKA2J/0lguUibEHQqmw3FDFyULZ1/IBMHejx12OqCVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (bharat.asicdesigners.com [10.193.191.64])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 666EAJrK022975;
	Mon, 6 Jul 2026 07:10:20 -0700
Date: Mon, 6 Jul 2026 19:40:06 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: chelsio: cxgb4: Use str_plural() in
 mem_intr_handler()
Message-ID: <aku3PjxIvUxAqhed@chelsio.com>
References: <20260704121010.201016-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704121010.201016-3-thorsten.blum@linux.dev>

On Saturday, July 07/04/26, 2026 at 17:40:11 +0530, Thorsten Blum wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Thank you.
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>

>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> index 6871127427fa..29d7b786e51e 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> @@ -33,6 +33,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/string_choices.h>
>  #include "cxgb4.h"
>  #include "t4_regs.h"
>  #include "t4_values.h"
> @@ -4867,7 +4868,7 @@ static void mem_intr_handler(struct adapter *adapter, int idx)
>  		if (printk_ratelimit())
>  			dev_warn(adapter->pdev_dev,
>  				 "%u %s correctable ECC data error%s\n",
> -				 cnt, name[idx], cnt > 1 ? "s" : "");
> +				 cnt, name[idx], str_plural(cnt));
>  	}
>  	if (v & ECC_UE_INT_CAUSE_F)
>  		dev_alert(adapter->pdev_dev,
