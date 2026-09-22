Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B12368957;
	Tue, 22 Sep 2026 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074036; cv=none; b=vCOpZRfJzGhQV3SpzoDt4D9SYGdzNxbucPBPz4HvcwcQ+B3vTH2Dt2IDQfRyGpe78WQxvzA2zZDt38qrup1pjaDcOJ87cm5Uj4BnQW70wrgjt4+NK6nr+xHzakVAhFCr6jxZByQPrKMJEy/OWaEqtfexQKnZNMSDkpolBw+t8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074036; c=relaxed/simple;
	bh=N6a/rQh49QdPXeYV7dNM1/2pkcYBKmdmRlFzKVH049o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jRmLGapH7kp8QakAE/FY2ilHvNd/pey1+7D4kWqtdMEOOni0J+IjFYBcFT0Pg+F+bXzEAdjCIEeUOjWse3viewFeeac1/C6r3VOu8ETjtL3adeyXlyAP9Ol1vAgOpU7Hb7bY4Jm8ehiWDlptzqeH1orV87ZwJJLSVM/lxBo5Z24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=zdXL1eBK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="zdXL1eBK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46511A3808;
	Tue, 22 Sep 2026 12:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790074030; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cS0IwhYjB6pNlVNQO32h2kqy3Eo5NytkBTi9r+07Xn4=;
	b=zdXL1eBKFqxEnrw7+G8svuA7bJ+pgK8l48KQ7IFDfoWeWWidar2pxBSCj7YrzyAknI96aq
	zlPXIlsXE+dqtz18dSFHqLgvIck242+OQmt7WDEqFS9A4XwC/YnySoCcjjhdEMAzA4S8Sj
	hBdRGtnCd64MWWgYNy7mqn4nnaWqlpUrv8nxiDOUlYgUgoV9FHkhOhkKi46jEZ2SlG2MId
	DH3NBC5YaToQSWhY1Zo8cUQ+n8Bj7aUdQHzfvLsHkVYW0JV2AY78IFshanFY4TxpA5NSas
	tyr5R2N+f1+0mv0AloPX0lBQxgCCsQlnmZkdj0kV9W8ICPPc01WfLVHrEmMDWA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 12:47:03 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: 5mghybrid@khu.ac.kr
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Rafal Ozieblo <rafalo@cadence.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: macb: Preserve timestamp settings on
 rejected requests
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr>
 <20260922-codex-macb-hwtstamp-submit-v1-1-9d1abaa53296@khu.ac.kr>
Message-ID: <700e15209a1266f1ba3ab32f2d6e0e75@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 11:10, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
> 
> gem_set_hwtst() can reject a request after changing the TX one-step
> setting, because it programs the TX mode before checking the RX
> filter. The call returns -ERANGE, but the hardware may no longer match
> the cached configuration.
> 
> Validate both settings first and keep the adjusted RX filter local
> until validation succeeds. Then apply the register settings and update
> the configuration. A rejected request now leaves the hardware, the
> caller's settings and the cached configuration unchanged.
> 
> Protect the NCR read-modify-write with bp->lock, keeping the descriptor
> writes and cache update in the same section. With the register writes
> now in the setter, remove gem_ptp_set_one_step_sync() and
> gem_ptp_set_ts_mode().
> 
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>
> ---
>  drivers/net/ethernet/cadence/macb_ptp.c | 61 
> ++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index 14ae57fa0..4dbb6daa6 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c

> [...]

>  int gem_set_hwtst(struct net_device *netdev,
>  		  struct kernel_hwtstamp_config *tstamp_config,
>  		  struct netlink_ext_ack *extack)
>  {
> +	u32 ncr_mask = 0;
>  	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
>  	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
> +	int rx_filter = tstamp_config->rx_filter;
>  	struct macb *bp = netdev_priv(netdev);
> +	unsigned long flags;
> +	u32 ncr_bits = 0;
>  	u32 regval;

Please re-order to keep RCS [1]

> [...]

[1] 
https://www.kernel.org/doc/html/v6.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

With the above fixed:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
