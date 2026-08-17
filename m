Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9852DF126
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960362; cv=none; b=EPMRMre7xIw0rBCHepl2I6tT1yBFnzeUJny0Nh4VAFRpobT/wdRIa5g0Gg1dmR/u+dRE/ab4b7Fa0zN1pDEwJHoTW8bR0Fj9XL2bLWEp6Wjj2wgnqAwqw3nS9xSXtI8cZb1X4sUdSKFkVmA3H+/tVnN6ksZUI/x8dbeNTpbX1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960362; c=relaxed/simple;
	bh=1ja/V7nTbqqmXtS7BPIrWfg4KU9kF4ez22A8VfBaMI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9ymBQkhEAOwNKAKZqgt8HLjCeSoc4IsJswOmqfWo9E9rvr8oQ/C3M1ZigYL8WNVTbO7Y1PTM4ozv4hhnaj9sCo5m8w0jfFqbQaJqfnWimKrwzJoZos7wBHZc2QidpA4u5GDSS2X8e/HxJWPfkwyTCI76WN2HLiujXEl6gf8n+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rNBIXpmL; arc=none smtp.client-ip=91.218.175.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rNBIXpmL"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1ja/V7nTbqqmXtS7BPIrWfg4KU9kF4ez22A8VfBaMI8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786960357; v=1; x=1787565157;
 b=rNBIXpmLrBTjiANagf23NRgfs9kWm35rmmTr4Ow8pICWezRCNVk6uU3+YuBcZuGHVxjZS4uX
 y3cfo2iEVK9dgR4U9AoDc6bRQlqvNnrl6+LRwk4l3oSdnHhAV/nHmcTNLxegh7rzLsxj5v+IRFe
 mbDpEoDaZb892vReEfpyLAHg=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2408:820c:270a:b561:544d:9f6f:ea74:16a5] (2a14:7586:6109:1::198)
	by smtp.migadu.com with ESMTPS id 051eb70d1ed59f2d;
	Mon, 17 Aug 2026 09:52:37 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <29a29de8-ce58-40d5-9161-5ac36b7368c1@linux.dev>
Date: Mon, 17 Aug 2026 17:52:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: Daniel Pawlik <pawlik.dan@gmail.com>, netdev@vger.kernel.org
Cc: lorenzo@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260817090601.1256389-1-pawlik.dan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2026/8/17 17:06, Daniel Pawlik wrote:
> On EN7581 + MT7996 (Gemtek W1700K), mapping small caller buffers with
> DMA_BIDIRECTIONAL regresses NPU version probe: the mailbox completes
> successfully but WLAN_FUNC_GET_WAIT_NPU_VERSION reads as 0.0 instead of
> 0.1111.
>
> Allocate at least SMP_CACHE_BYTES for each mailbox payload and map
> ALIGN(len, SMP_CACHE_BYTES) with DMA_BIDIRECTIONAL while programming
> the original payload length into the mailbox length register.
>
> Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
> 6.18.44, including two cold reboots and sustained WiFi use.
>
> Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260814110017.2795022-1-pawlik.dan@gmail.com/
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260809152813.585797-1-pawlik.dan@gmail.com/
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20260805070851.2885888-1-pawlik.dan@gmail.com/
> Assisted-by: Cursor:composer-2
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> ---
>   drivers/net/ethernet/airoha/airoha_npu.c | 25 +++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
>
> --
> 2.55.0
>
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index b679bed952de..d560b8763753 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -5,6 +5,7 @@
>    */
>
>   #include <linux/devcoredump.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/firmware.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_net.h>
> @@ -160,15 +161,21 @@ struct wlan_mbox_data {
>   	DECLARE_FLEX_ARRAY(u8, d);
>   };
>
> +static size_t airoha_npu_mbox_size(size_t len)
> +{
> +	return ALIGN(max(len, SMP_CACHE_BYTES), SMP_CACHE_BYTES);

SMP_CACHE_BYTES defaults to L1_CACHE_BYTES on Aarch64. On Cortex-A53 
this is fine, but some CPU's L2 cache line size might differ. For 
portability, please use dma_get_cache_alignment() instead.

Also "max" is redundant.

> +}
> +
>   static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
>   			       void *p, int size)
>   {
>   	u16 core = 0; /* FIXME */
>   	u32 val, offset = core << 4;
>   	dma_addr_t dma_addr;
> +	size_t map_len = airoha_npu_mbox_size(size);
>   	int ret;
>
> -	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
> +	dma_addr = dma_map_single(npu->dev, p, map_len, DMA_BIDIRECTIONAL);
You don't have to align the size passed to DMA API. The underlying 
implementation already aligns it.
>   	ret = dma_mapping_error(npu->dev, dma_addr);
>   	if (ret)
>   		return ret;
> @@ -191,7 +198,7 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
>
>   	spin_unlock_bh(&npu->cores[core].lock);
>
> -	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> +	dma_unmap_single(npu->dev, dma_addr, map_len, DMA_BIDIRECTIONAL);
>
>   	return ret;
>   }

Best regards,

Qingfang

