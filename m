Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5324886E
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774538; cv=none; b=CBfjX6PHG5OwSXthJ2RIpQ8XrKGI60UHDbNVAkm3TQZU3IyCbpN3oBXrLLQs2DL26vb/J019cdFTbrDZDwMTSzclT5nt69D8JqEzFl8JadfBV2se9xgcXIlvj1phCAaMQejPOK8ctV0DQjPyqjfzenliKgKvYDqPRifzJRvA97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774538; c=relaxed/simple;
	bh=9ciIRQPpTn/vkS6FWyouPKRqXMMcfXSzGn/uJJ83siw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPfvgriy16+N4bQMahthjpWZLDJjnTsCW5wMgfWndneANbNWmbIPBOielqAjLSVl3Z8m8sRlAcNLFW7vh7ukcL7/+ejPIAQoPPEl+SAp5kTew/KxxKGsRw8tzlmyBQw0qEOXqnYAyeSJdmJGCrlN7nMdTmkggz8CLNTuOireDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8VEBQa/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8VEBQa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740F3C19425;
	Sun,  3 May 2026 02:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774538;
	bh=9ciIRQPpTn/vkS6FWyouPKRqXMMcfXSzGn/uJJ83siw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8VEBQa/Are04jfzQrjsnw4h37jD4MUoOofdmN6NliynQcUwYeByHUVl262O8+xEW
	 0SnEJUVnYhIWbwL+qPxPunMk5RVRrIfoSq4s2QL87px5XVX2lTB02gL5DJGbI0oFtE
	 DjOnLYrFdgzonofpO2CY5OCuVB2cDICrw7n+TqgAUkGbNdSNfPqzx4IXBceLB+jrw0
	 DkvG1i+nBGxI2e67SXtcoQGoJyqA+O3QLv3Rrs1Fv6c8UzUEOtkHXJ/OLvvQJYlp9X
	 +eBLS5mhirksR/5Zr5Q881n2JAGcEzw2Tlv+wJmkhA/rtkKF6qttucDFJAx3grEiie
	 fxWQTba0JhnXw==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	leitao@debian.org,
	joe@dama.to,
	jacob.e.keller@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v2 5/6] net: wangxun: clear stored DMA addresses after dma_free_coherent()
Date: Sat,  2 May 2026 19:15:36 -0700
Message-ID: <20260503021536.4127361-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430082517.19612-6-jiawenwu@trustnetic.com>
References: <20260430082517.19612-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: clear stored DMA addresses after dma_free_coherent()

This commit clears the ring DMA addresses after freeing their resources via
dma_free_coherent() in the wangxun driver. It aims to prevent use-after-free
of the DMA rings at shutdown when WOL is enabled.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 3216dee778be7..51599f6b878e7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -2462,6 +2462,7 @@ void wx_free_isb_resources(struct wx *wx)
>  	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
>  			  wx->isb_mem, wx->isb_dma);
>  	wx->isb_mem = NULL;
> +	wx->isb_dma = 0;
>  }

This isn't a regression introduced by this patch, but can dma_free_coherent()
be called with a NULL wx->isb_mem virtual address here?

Since wx->isb_mem is only allocated when the interface is brought up, if the
module is removed while the interface is down, wx->isb_mem will be NULL. Does
passing a NULL virtual address to dma_free_coherent() cause a panic here, and
should it be guarded by a NULL check?

[ ... ]

> @@ -2678,6 +2679,7 @@ static void wx_free_rx_resources(struct wx_ring *rx_ring)
>  			  rx_ring->desc, rx_ring->dma);
>  
>  	rx_ring->desc = NULL;
> +	rx_ring->dma = 0;

If rx_ring->dma is set to 0 here, and Wake-on-LAN is enabled, does this result
in the hardware being programmed to DMA directly to physical address 0?

Looking at ngbe_dev_shutdown(), it frees these resources and then calls
wx_configure_rx(). Inside wx_configure_rx_ring(), the driver programs the
base address registers WX_PX_RR_BAL with ring->dma, which is now 0. When a
WOL packet arrives, could this cause silent memory corruption or fatal
IOMMU faults?

Additionally, this wasn't introduced by this patch, but does the shutdown
sequence trigger a NULL pointer dereference when WOL is active?

Earlier in wx_free_rx_resources(), rx_ring->rx_buffer_info is freed and set
to NULL, but ring->count retains its original value. During WOL shutdown,
ngbe_dev_shutdown() frees these resources and then reconfigures the RX rings
via wx_configure_rx_ring(). 

If wx_configure_rx_ring() executes:
memset(ring->rx_buffer_info, 0, sizeof(struct wx_rx_buffer) * ring->count);

with a NULL pointer and a count > 0, won't this cause a kernel panic?

[ ... ]

> @@ -2906,6 +2910,7 @@ static int wx_setup_rx_resources(struct wx_ring *rx_ring)
>  
>  err_desc:
>  	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
> +	rx_ring->dma = 0;
>  err:
>  	kvfree(rx_ring->rx_buffer_info);
>  	rx_ring->rx_buffer_info = NULL;

Should rx_ring->desc also be set to NULL here?

If wx_alloc_page_pool() fails, the driver jumps to err_desc and frees the DMA
memory, but leaves rx_ring->desc pointing to the freed memory. Since wx_ring
structures can be reused across interface up/down cycles, could this dangling
pointer bypass the if (!rx_ring->desc) safety check in wx_free_rx_resources()
and cause a double-free later?
