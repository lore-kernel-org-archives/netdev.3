Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630CE4B9228;
	Mon, 19 Oct 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405141; cv=none; b=npL5qJME/7E9xUiSg5Gy8buLkjdgoS8NoIbtIqxyFCEa2eVJoKOffikGAYk6u9QPRjg10ebXlJbxN3dI+qf2bP7or3FmQDPkqzu6sJVm/LQPGSSOa7oAEZAX2tM+1pyNblOGpY28Vkchbzx6jwfL4s2p00tqFtGRxngW/dHrr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405141; c=relaxed/simple;
	bh=Kvj7U+htv62wu1W25tLgpZ2lnkSbDbIkj9ib7QhUVmc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TPShNIHJhRR7jn/os9pvlTqud7UMz/l36yxewSJiijrS5laPc9IiDwvS7t6W0o0Cn7TjBnPvObvS0S5GOwwPRkYjMCBfY/k5C+1kRLZVSQgjXQFxK1UHpj2XS5VwyJu8mJiZ6M20XzjYZ26IDKhHEMHSjk2UZqvf4IdDEBWQ2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1tU/bg3U; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1tU/bg3U"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 808B4A1579;
	Mon, 19 Oct 2026 12:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792405137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ka/0d3LLne3RrfKFSIrCbrXaRogskK8tc0o3eKeKKrM=;
	b=1tU/bg3UsRO82BuED9h4OJflhZptef/DttY1VDlE7EO9i8LIILYIARAEZ157p9q/3tw6tV
	SPFlAMfOGgSPuGMnq9PhFVF34Li2xgyskh5m2fD3a2AG1h0PHZQE8VF5HwL+U5TcLjoGvd
	02FtDugg1/hO0YYTCzqlcrCzRFfG8kPKY6nepfS6otDQpd6wgp966pdazeO+x8DpmmRNLY
	91yP1rCmthQTziDcpTpptV+HGuR0rSGhRZFMdo7oBbIbdO+9VeqAea7Q1dTU6TlR/lqMmH
	zNQm6IVK0jEF6bbDIM8eB+yEBCxxbb5+VSrh4YLS9Yp0TP45j0areYL1j4BUcQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 12:18:56 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
In-Reply-To: <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
Message-ID: <3b3ef1c5d926ddeddc3eec1b2388caa8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Chris

On 15.10.2026 17:00, Chris Babroski wrote:
> lan743x_tx_close() and lan743x_rx_close() ask the DMA controller to 
> stop
> the channel and wait for it, but ignore the result. If the channel is
> still stop-pending when the wait gives up, the descriptor ring, the 
> head
> write-back buffer and the packet buffers are unmapped and freed while
> the channel may still be fetching from or writing to them.
> 
> A TX channel has been seen to stop making progress, with its head index
> no longer advancing while DMAC_CMD still reports it as started. A
> channel in that state may not honour the stop request either, and
> closing the interface would then free memory the engine can still
> access.
> 
> If the channel is still stop-pending after the wait, or still reads as
> started, issue a channel soft reset and wait for it before anything is
> freed, and log when that happens.
> 
> Use the same helpers for the channel resets that lan743x_tx_open() and
> lan743x_rx_open() already open-code, and log there too if the reset
> times out.
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x 
> driver")
> Assisted-by: LLM
> Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 64 +++++++++++++++----
>  1 file changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 82d3ec20ba25..9e1276cf313c 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c

> [...]

> @@ -2221,11 +2239,22 @@ static int lan743x_tx_ring_init(struct 
> lan743x_tx *tx)
>  static void lan743x_tx_close(struct lan743x_tx *tx)
>  {
>  	struct lan743x_adapter *adapter = tx->adapter;
> +	int ret;
> 
>  	lan743x_csr_write(adapter,
>  			  DMAC_CMD,
>  			  DMAC_CMD_STOP_T_(tx->channel_number));
> -	lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
> +	ret = lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
> +	if (ret < 0 || ret == DMAC_CHANNEL_STATE_STARTED) {
> +		netdev_warn(adapter->netdev,
> +			    "TX channel %d failed to stop, resetting it\n",
> +			    tx->channel_number);
> +		ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
> +		if (ret)
> +			netdev_err(adapter->netdev,
> +				   "TX channel %d reset timed out\n",
> +				   tx->channel_number);
> +	}
> 
>  	lan743x_csr_write(adapter,
>  			  DMAC_INT_EN_CLR,
> @@ -2271,11 +2300,11 @@ static int lan743x_tx_open(struct lan743x_tx 
> *tx)
>  			  FCT_TX_CTL_EN_(tx->channel_number));
> 
>  	/* reset tx channel */
> -	lan743x_csr_write(adapter, DMAC_CMD,
> -			  DMAC_CMD_TX_SWR_(tx->channel_number));
> -	lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
> -				 DMAC_CMD_TX_SWR_(tx->channel_number),
> -				 0, 1000, 20000, 100);
> +	ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
> +	if (ret)
> +		netdev_err(adapter->netdev,
> +			   "TX channel %d reset timed out\n",
> +			   tx->channel_number);

Not a bug, but what's the benefit of keeping going here?

If the channel never came out of reset, lan743x_tx_open() and
lan743x_rx_open() could return the error instead of starting it anyway.

With the reset work from 4/5 a failed reopen then ends in dev_close(),
which seems like the better place to end up. It would also settle the
open question from the cover letter.

> [...]

Thanks,
Nicolai
