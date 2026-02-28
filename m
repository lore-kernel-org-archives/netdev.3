Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67112868B5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322938; cv=none; b=E5I1foho/JEMyajEDHAxxCKV9THKevmADkkX39gFRfjaLvg/PGgtfIg+r8panr3BNuTBBA6U+XKMtA1N4U+kHX+uz37wj/doVcFgz8zkCHV0T9tW+Dz/ILvHlw58qscBPHj2EMUsKLddza1DgUwe/N8j3PnhNpZ6lgB9x4QcYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322938; c=relaxed/simple;
	bh=cnr3TRMVoN6T+ejnJO2HTdPPatU5L1Ty+aAScABcwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqcOXkolu01D/9V8xHM6lgS91/HR5RU9MQEA7QAiZtIfvCcpBBTqICXzaui4v+92d/k6LaORwS0IGcTsZK4ncPLEQgd/7PG0sFb//KrWqc9mMR6Zs1gE/AZRF/9wWIW+eyE5UpGVMLcYXrLyP7Hp7yKm/V8Ci20jGhaZANMfYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLOm8NTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLOm8NTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D93AC116D0;
	Sat, 28 Feb 2026 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772322938;
	bh=cnr3TRMVoN6T+ejnJO2HTdPPatU5L1Ty+aAScABcwXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLOm8NTTemgj8EycrJ988OlYGWQmHadpMLNR7RKZLErruV/ypQtFktdg3FRvbUpYM
	 jvGQoTN/OdmmKDyCDlYQKkVj2jXvNm1IPlv82j2zSxzqNxyO2jjw3E7XueZVmPo8dZ
	 QEvUfizyvGQOHIzSfkyEI8476LGHomWinTM1f9lp55b12MjaWjZm1wUupSzEzHhWfh
	 m98sBy0Y/63ZdJ7nN9VJxrlKQmaR6Ou4zl9uw2UUqfrmTPOGYbxLqbTbYoTpuDdA+S
	 NVg0FFatKb/6XZ0Sm/48WgBBK9rPfBi4D3rO1OCTzLomqlmMjg+wQyiVLfXNs/peUn
	 aVk3OuRj1GIqQ==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	guwen@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	lukas.bulwahn@redhat.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	davem@davemloft.net
Subject: Re: [net-next,v27,5/8] eea: implement packet receive logic
Date: Sat, 28 Feb 2026 15:55:37 -0800
Message-ID: <20260228235537.31102-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227015546.47336-6-xuanzhuo@linux.alibaba.com>
References: <20260227015546.47336-6-xuanzhuo@linux.alibaba.com>
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
eea: implement packet receive logic

Implement the core logic for receiving packets in the EEA RX path,
including packet buffering and basic validation.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> index 0398e781dfdb..5a607947a76e 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.h
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> index a8695704d67d..db74580f296c 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c

[ ... ]

> @@ -88,12 +180,391 @@ static int eea_alloc_rx_hdr(struct eea_net_init_ctx *ctx, struct eea_net_rx *rx)
>  	return 0;
>  }
>
> +static void eea_rx_meta_dma_sync_for_cpu(struct eea_net_rx *rx,
> +					 struct eea_rx_meta *meta, u32 len)
> +{
> +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev,
> +				meta->dma + meta->offset + meta->headroom,
> +				len, DMA_FROM_DEVICE);
> +}
> +
> +static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
> +				     struct eea_net *enet)
> +{
> +	u32 max_len;
> +
> +	max_len = ctx->meta->truesize - ctx->meta->headroom -
> +		ctx->meta->tailroom;
> +
> +	if (unlikely(ctx->len > max_len)) {
> +		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> +			 enet->netdev->name, ctx->len, max_len);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
> +{
> +	int err;
> +
> +	err = eea_harden_check_overflow(ctx, enet);
> +	if (err)
> +		return err;
> +
> +	if (ctx->hdr_len) {
> +		if (unlikely(ctx->hdr_len < ETH_HLEN)) {
> +			pr_debug("%s: short packet %u\n", enet->netdev->name,
> +				 ctx->len);
> +			return -EINVAL;
> +		}
> +
> +		if (unlikely(ctx->hdr_len > enet->cfg.split_hdr)) {
> +			pr_debug("%s: rx error: hdr len %u exceeds hdr buffer size %u\n",
> +				 enet->netdev->name, ctx->len,
> +				 enet->cfg.split_hdr);

Should the second pr_debug argument be ctx->hdr_len instead of ctx->len?

The condition checks 'ctx->hdr_len > enet->cfg.split_hdr', and the format
string says 'hdr len %u exceeds hdr buffer size %u', but the argument
passed is ctx->len (the data payload length) rather than ctx->hdr_len (the
header length that actually triggered the error). This would print the
wrong value when debugging split-header overflow issues.

> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (unlikely(ctx->len < ETH_HLEN)) {
> +		pr_debug("%s: short packet %u\n", enet->netdev->name, ctx->len);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[ ... ]
