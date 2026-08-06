Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAB2F7F12
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029840; cv=none; b=iuBPk3OYRzcIUkL8RujX2CbGqEziwvPhOvVWnkxVRwqd2YjZ4hYEC3zivEFdNftV/KB9XodYUOjW6l2NfWyeyKlAMD4Yo4Ua26d0ZBn1LxuYNRAabCaJdLWy06dirCgKIC1/2EvdgIMOW752iK5nM3o4zFe0Rovu5HcyCL5+Zgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029840; c=relaxed/simple;
	bh=yir6YVA5i7m1Mlb0OBaQgNufMMEMMv/7xhYdXssCHVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=axodrZ52NoFsl7BLeUQBpslZ2F5h5hJLl3x0K/ZczDuOxjItCZ+3d9mrr+a3ZH6amsq4KLgy50sYyJyyDoGKhaAFvuYKoFFoulzS5aH+zLb9JqYpAMvGsTPdU0vSSqR1xZ/oV/fwu3zUKB/fbz+YycKF0+xMmodabFR+lXpmI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv81s8Cz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv81s8Cz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1013313a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786029839; x=1786634639; darn=vger.kernel.org;
        h=content-transfer-encoding:lines:status:content-disposition
         :content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyD3MC/LYtqqEnSjFEabCt1+8sKgizIUqavkWxkyS9A=;
        b=Sv81s8CzSZIKAfbxpMmuOYtzPB/2U0Qer7RAdTj3qP9tekvmHgibu2SJZBUNgUflsC
         S3OlAzHh7nSwGXrvJdudIBpI3mVjLEpAwruttEFLvZJG4oQpF4zv0utKypHR3OEhPHtS
         Kr94R5hOKoyhV5XiLZTg6Xf+mc22nGz8WM1kEYJxvhqXUO/T/dvayxLY2aWVuyotdYjT
         5O/4zMB3i4iD6f4qORY9Ag/T/SssVoQf5d70VqC/+AQsKkB2xNOOjSnEkn7RFeiDocib
         M/+0QS/AzTLkudib3ISEnceefcVxzFULc99mG4mfhnN0hR34+s7aiAi/I414GBAVTIpp
         WG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029839; x=1786634639;
        h=content-transfer-encoding:lines:status:content-disposition
         :content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JyD3MC/LYtqqEnSjFEabCt1+8sKgizIUqavkWxkyS9A=;
        b=AU4hhI7lWeu67lq35dFkMerbQ37Hj4l9vEVUWkej1a4BTFHQQh0Lr5FV8I1hLhQELP
         M7zyVShdzvU8wX/D1c2QwzflWH9V5ZCNR+UQFpdxHp/SQli0MzEOTf/R145Jg5DohEM/
         9dRAb+quCTN+6O59ybMp0Ix9vMA2rNrRXGxN/+Wn/gjPaOV2aM7h6Db0nkCJ3C8t6irl
         1UKu12OXhiz1uRlVH7vYF2RTDqLtN1AjJp3cAPBQAvHfPTytL9xJ3QLvhYuTZZec78Ft
         Fry9lFsavO3v3L1rS/QhL38scn6gfirMmOYrxJSIZS8otT31k0yG/mPYlnV1/GZaYBJT
         Vg6Q==
X-Forwarded-Encrypted: i=1; AHgh+RooK8uASWNAmeRAjCUFp1AmZznXCOxDG805tSagOsY73WgCgZxQdxg4Zo8zmXG4wHh4Y7puq08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBYYJ2bixHqWKOASh/bG3Rg8FaLhz5I7/sxmLAbICtqDNFT5X
	F4WmjNRG6TC0PB7pEUjZrWL9X28FusLpVwTRuRISvVQv3kKQ/5GPg2iM
X-Gm-Gg: AR+sD1364A/eWveJzTnqRC1AZRBiWNQhs3dm5JSYDE0SX6q4d1rjRnxjPfNYN6kJmA9
	GHoqJD4iDINLp0tdw3IeYlj3b4yiFp1zR2eRs2zdd5YfVfjTSZyjK2QymRABQz8wtOjgtXW7z3l
	SxbL/wpw49oDA1q/cy6aIOo24tpyV/fMrkDyBQptHvKCIW6XgQ+wat3ITwIFH++xs0TWR80SjtJ
	dTrwWkgwhbsgd7DCs+d3Dz95Xowa0UiUVE3J4N6kK9T3RAC5s6FJcogrD9pzCV7/Bknq5ipk+Wf
	mh+/7PBDPf34Wzgk+/mas7iSWnKeceWUQm8E7S8K2LruqVat8RZfdBSwM+TK9mt+6bShHAQUQG9
	a8uf2K4Mozmyxa+ao82lmYCMtf/ZYVegAY+baRaP6jwU7zfeshWR19vVtMyBklz3OaJLFWGrkEs
	5ib37tDImG+OLmyTtt8Q11RTVl+EeuDwjIYIchBTh7iLuWyQjoZnNIkD8UKZPcEW+w5pRLNfU6B
	BhJ/WsOpOV8rNF8JUaGtqYnjvO1PA==
X-Received: by 2002:a17:90b:4ccc:b0:38e:5828:a446 with SMTP id 98e67ed59e1d1-3908982a10emr2522273a91.19.1786029838637;
        Thu, 06 Aug 2026 08:23:58 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5c9a5sm1696416a91.15.2026.08.06.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:23:58 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: hujy652@gmail.com,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sujuan.chen@mediatek.com
Subject: Re: [PATCH net v3 1/2] net: ethernet: mtk_wed: skip ring reset in wdma_tx_ring_setup for WED v3
Date: Thu,  6 Aug 2026 23:23:50 +0800
Message-ID: <20260806152350.555-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724172040.1653-1-hujy652@gmail.com>
References: <20260724172040.1653-1-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-References: <20260724172040.1653-1-hujy652@gmail.com>
X-Mutt-Fcc: ~/sent
Content-Transfer-Encoding: 8bit

On Sat, Jul 25, 2026 at 01:20:39AM +0800, Zhi-Jun You wrote:
> Currently WED v3 tx wdma ring, ring reset happens in a separate code
> block unconditionally.
> 
> Moreover, v3 has double the size of wdma_desc and has different init
> values. mtk_wed_ring_reset doens't deal with that and would corrupt the
> wdma_desc.
> 
> Fix this by skipping mtk_wed_ring_reset in mtk_wdma_tx_ring_setup for
> WED v3.

Commenting on Sashiko's report:
https://sashiko.dev/#/patchset/20260724172040.1653-1-hujy652%40gmail.com

> 
> Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> ---
> Changes in v3:
> - new patch addressing WED v3 ring reset issue raised by Sashiko
> - Link to the review: https://lore.kernel.org/netdev/20260630144831.1109-1-hujy652@gmail.com/
> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 10d9beaae372..7d2775a97fa0 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -1938,7 +1938,7 @@ mtk_wed_wdma_tx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
>  	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_CPU_IDX, 0);
>  	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_DMA_IDX, 0);
>  
> -	if (reset)
> +	if (!mtk_wed_is_v3_or_greater(dev->hw) && reset)
>  		mtk_wed_ring_reset(wdma, MTK_WED_WDMA_RING_SIZE, true);
>  
>  	if (!idx)  {

-This is a pre-existing issue, but while reviewing the WDMA ring reset logic,
 I noticed what looks like reversed logic in mtk_wdma_rx_reset():
 drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wdma_rx_reset() {
 	...
 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++) {
 		if (dev->rx_wdma[i].desc)
 			continue;
 		wdma_w32(dev,
 			 MTK_WDMA_RING_RX(i) + MTK_WED_RING_OFS_CPU_IDX, 0);
 	}
 	...
 }
 Does the if (dev->rx_wdma[i].desc) continue; check skip the CPU_IDX reset for
 active rings?
 When a WDMA RX reset occurs (e.g., during recovery from a hang), the hardware
 index is reset to 0, but the CPU_IDX register won't be reset for active rings
 since they have a non-NULL desc.
 Could this desynchronize the driver and hardware, leading to a permanent stall
 of the WDMA RX rings and network traffic failure?
 - ACK I will add a patch addressing this.

 Best regards,
 Zhi-Jun
> -- 
> 2.47.3
> 

