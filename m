Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D534CFDD
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745736; cv=none; b=Mau00L3oCX/gUgr2e2f+JFGEPpraGe4zgZ1iFQRmpn1yOCqwvaXnWviGYkMT06XxhcyUNo8Cf6MbPLv30eStLSP6oZgQTvd/0DXo+zlMVBjSRnajVcOT70rgc1a5rNMRvkFTjr/a3TGH5Qml+daLoUFtGG6ips+d+D4XT2jOmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745736; c=relaxed/simple;
	bh=6lUyaIwX+8Yo5zJty438DpfTLRImBDgWNCuNKCBVo4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLTGwhwCE6supeW0QTkllRdOvVtoRCUAseUpzLybwzRF20g82pDxcv0nbG2beqvZXXQecQpGe9fXMS9KOBtNsVa7a16529v0ufETZEWk5n3WD8Bbcm3SyrDVjUFPbiUDuPoMjaQxxXA7E6v74+8JG2gqcLSEAHWedGjBZ0c+sFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Ak6s8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Ak6s8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DFEC4CEF7;
	Fri, 30 Jan 2026 04:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745735;
	bh=6lUyaIwX+8Yo5zJty438DpfTLRImBDgWNCuNKCBVo4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6Ak6s8bSUpC0F567XZjrCBPCbUUuZRDj4UkI7euOcv9+/yeCh4ZTv5OB26AG9MSP
	 C+mQxDvaofUE2hiafkVG3ZC1jVGkC/f4CDf71DUggxO2IcOfiDd8TNPGanwmXVD67M
	 OMD48fa1H3d7DINghh5OOoTMMiKWAv87kqZNAPHNkBvj+AVZGFyoyB5x9x+ufJTdC8
	 tZ/EDaDTn1ureVoxElFUL4ij//OWs01RfY8YvIpzwky/O9jAexAMFAPAXbZHl5ahnO
	 oi8YCY/1s0nnme9pMbIN15lJ9gkWG+dq1DAjyMm2l3g1lmJYr55FdyrvPTJijmz/8x
	 u0M6QcK1/koBg==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	dust.li@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	guwen@linux.alibaba.com,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com,
	davem@davemloft.net,
	dong100@mucse.com,
	vadim.fedorenko@linux.dev,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com
Subject: Re: [net-next,v23,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Thu, 29 Jan 2026 20:02:13 -0800
Message-ID: <20260130040213.708779-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128055232.8021-5-xuanzhuo@linux.alibaba.com>
References: <20260128055232.8021-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
    eea: create/destroy rx,tx queues for netdevice open and stop

This commit adds the netdevice open/stop implementation for the Alibaba
Elastic Ethernet Adapter, including RX/TX queue allocation, IRQ setup,
NAPI handling, and HA reset support.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> new file mode 100644
> index 000000000000..979458cbffa9
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c

[ ... ]

> +int eea_poll(struct napi_struct *napi, int budget)
> +{
> +	struct eea_net_rx *rx = container_of(napi, struct eea_net_rx, napi);
> +	struct eea_net_tx *tx = &rx->enet->tx[rx->index];
> +	struct eea_net *enet = rx->enet;
> +	struct eea_rx_ctx ctx = {};
> +	bool busy = false;
> +	u32 received;
> +
> +	eea_poll_tx(tx, budget);
> +
> +	received = eea_cleanrx(rx, budget, &ctx);
> +
> +	if (rx->ering->num_free > budget)
> +		busy |= eea_rx_post(enet, rx);
> +
> +	busy |= received >= budget;
> +
> +	if (!busy) {
> +		if (napi_complete_done(napi, received))
> +			ering_irq_active(rx->ering, tx->ering);
> +	}
> +
> +	if (busy)
> +		return budget;
> +
> +	return budget - 1;
          ^^^^^^^^^^^^

Should this return "received" instead of "budget - 1"? The NAPI poll
function is expected to return the actual number of packets processed
so that networking statistics are accurate. Returning "budget - 1"
unconditionally when not busy seems inconsistent with other drivers
which return the work done (mlx5e_napi_poll, ixgbe_poll, etc.).

Looking at napi_complete_done() above, the correct "received" value is
already being passed there, suggesting the intent was to track actual
work done.

> +}

[ ... ]
-- 
pw-bot: cr
