Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870514;
	b=VRgJXrwktrlBqNmUSNBPYqPxVyTvWKDOwnGnWJap7TqYW/qeM7TcmDbTZfckBaxMwul2
	 QzBAVEUFFQOeXTTxxa+UE3kLJQvW0JzRHghy+CZO1pSgsi2Q5GDGqOrn0SWa0r96aL6Ch
	 u3WmTWE2jruUTsHhtqxtHs48piIhZ2K7+Ef3Jbz1UGEvGuX11swCDu+G5maBOECL3U5hh
	 CP3ZUEY0TUZASYHy6yAx01h7h5o2PX8uFZ8woR/Vz/0NZbNP90xXXI7+I+wlUYuj5I4nW
	 vyTljyMcDZbPsbP4/qIN4Oousp2hO6K/xLlIaRLQeF/t198SXLz1My0javjCmP26RgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870514;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=uPCau9lp+BpbylcdJNudW5r9b3sR9WDS743Y91v+hfg=;
	b=kLLDEndlVStnqwMzjqDgewTM6i3vFrfkGf3cxtmUKwRwXz/LndzqoGg/+VCxv17j/F0Q
	 UlhylodT2+9LAMGieg7UgYVhfdw+EJsbJrbnsesRbeGIk4Ux1xDHT2VNLy2RsTrZAJxEw
	 MQ5kyxtiJo6aIw9S3gvPDUmZSomRS6vC5APLNxVdS/99zlhDS6ErOoHMZTpv5hWkEvB4g
	 HIhhvA3inwYuQCYRt9mP/uwGbUpnBB/xwmMKBNWhavmVIYRc6T7eNb8wegVQcBq5xFzU/
	 Tn09kLIsc+/3r3WCIMDdNcwPaiCcOjxNgQb+zn3NYopUxrNg3NuE7Lw+ggCEGpdsYgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="0/vPB2c/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E72606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E72606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0/vPB2c/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4577D1A07FF;
	Thu,  5 Nov 2026 09:21:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1029E5FF85;
	Thu,  5 Nov 2026 09:21:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01BB110328E77;
	Thu,  5 Nov 2026 10:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793870503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uPCau9lp+BpbylcdJNudW5r9b3sR9WDS743Y91v+hfg=;
	b=0/vPB2c/1f9mEl0RkFlMBsx8PHjAfybM5XFJlrhhhrnGot3pGM1q+VjozisV0cV4kdd3aW
	4dDqCBw8HTqr+m23zLyP4kXnfcyvvuErXq+z0m/8HA3I4s9o56fBTdktLmsSGfOn4seGD4
	7THsZ5WIapjan2XNdhjMJNhLlIc9qF+dX5YkNxqW+irp2k8+4xyoFJCLC8NKe0SJia/Pps
	MIOQLv3Gvwa2BD4lg6aeKXiN5y1x10RqMDbRurEEEky8u9oStlzQ5ZewBHiuFKWcAygiA3
	O2uMiiSrb290vBmWBS681d3uwJMYqafNaN9NeVX4OUcv4UnmDbBeYQArdPCuBw==
Message-ID: <8f310c06-8f02-4870-b7e5-ab58184207bb@bootlin.com>
Date: Thu, 5 Nov 2026 10:21:34 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the page_pool
 RX path
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Song Yoong Siang <yoong.siang.song@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
References: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/2/26 12:46, Lorenzo Bianconi wrote:
> stmmac_rx() initializes the XDP buffer with the metadata area valid, so
> an XDP program can reserve metadata with bpf_xdp_adjust_meta() and write
> it in [xdp->data_meta, xdp->data), for example to export the RX hardware
> timestamp obtained from the metadata kfunc. When such a frame is passed
> to the stack, the skb is built in place around the same page with
> napi_build_skb(), but skb_metadata_set() is never called.
> 
> napi_build_skb() clears skb_shared_info up to dataref, which includes
> meta_len, so skb_metadata_len() stays zero. The stack and TC BPF then see
> an empty metadata range even though the bytes are present in the skb
> headroom. The AF_XDP zero-copy path already records the length in
> stmmac_construct_skb_zc().
> 
> Record the metadata length after reserving the headroom and adding the
> frame data. No copy is needed because the skb is built over the buffer the
> XDP program wrote to. With the length recorded, the software VLAN
> stripping path can move the metadata together with the MAC header, as it
> already does for zero-copy frames.
> 
> Fixes: e3f9c3e34840 ("net: stmmac: add Rx HWTS metadata to XDP receive pkt")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

LGTM, matches the ZC path,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b038472b9817..f97f6dc08789 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6012,7 +6012,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		}
>  
>  		if (!skb) {
> -			unsigned int head_pad_len;
> +			unsigned int metasize;
>  
>  			/* XDP program may expand or reduce tail */
>  			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
> @@ -6029,10 +6029,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			}
>  
>  			/* XDP program may adjust header */
> -			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
> -			skb_reserve(skb, head_pad_len);
> +			skb_reserve(skb,
> +				    ctx.xdp.data - ctx.xdp.data_hard_start);
>  			skb_put(skb, buf1_len);
>  			skb_mark_for_recycle(skb);
> +
> +			metasize = ctx.xdp.data - ctx.xdp.data_meta;
> +			if (metasize)
> +				skb_metadata_set(skb, metasize);
>  			buf->page = NULL;
>  		} else if (buf1_len) {
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
> 
> ---
> base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
> change-id: 20261102-stmmac_meatada_pp_path-0c1b9299e2fb
> 
> Best regards,

