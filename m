Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662116;
	b=Nif0h2bdiIMvIKqtF1ibBzSjl/9SpEXAymFQ2LbhL22f1tRh4exub5WZmnm1xdjC5X4B
	 2dw4YELuQtJKDZK7f20MqeUmyN9ijiPwDsEbbkG42loidNxgFCGZb1DkCVBSSJfBt5Mln
	 5hDNfr7BoBQ50H5jvgYHNjcsQbyG1/iLmK1fCzCvEV5URitZJ9ofFfDw+gwQDiT8FhCPv
	 E5pW2pdv2/DWM2X4nB80THFGUrQZkeY5fgUX/jtka/33RuJN9X2nTh1W8Gm+8MyAG29s4
	 DhL3Vu61mYHJ0KtS7VVsfRiTALLdZoET8/Hx6cpmbfo9vM58BLMZ9dBcsddRQK4j3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZMaDJSQbb9QLkhHVRE64prZxAiTnxlvuwEcwQapvub8=;
	b=av3DKkeqiqSuNGLSJ+osdCPgcVBly+WIJKvXX31XjQu2ZiNSIFJjOByLMi/WamyOdULn
	 oLzP8NPqDc2jXyaPnZb6afCEPn6mQyw6FpuVXpMfK6U+CkShAuX7nfyEZK8o2LNKghI3z
	 02q1IwmZ9MfIaEieZjH2a71uqEZsyI5wRpI92GHppjzSKtOe94wFbzhXnGti8ztp73dlt
	 gmXQ6h1ib0YkIuTDd6pCVKV35yOtD4myT9MQQRg2ZKTanWGEzDktGJN0FlxjYUoaemlgW
	 ezvNHchXiBOEZNmItGfq9RiAX2BneU4NOOFd2ezofAnlbldimnuec23Hq3covFcjrrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uWLG9vMd;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E6606A336
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493E6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uWLG9vMd
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea94541adbso15560405ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793662114; x=1794266914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMaDJSQbb9QLkhHVRE64prZxAiTnxlvuwEcwQapvub8=;
        b=uWLG9vMdHRfPTQf8yd9B2J4pxCSDMU1Lyv+yKyLSFWcZ/0JjGOWoPfZTjIQeCA7c/F
         OhedkgLoE9Y6v/+A0GiDYtUdlHqMBMafuZG5l8XQG65zIrNDnLZdnfkXc751MGlMdG6e
         T+NnY/jViA3WbFwuN1QmnQRP3W3WcQbXnBXCMjsH5y8BHsPMy0m+YCGoTMQ6Uu9rBS/L
         +gZY/1AewV2MmqrMMKLSMyfjpsZSuav1FcnmSIOHFFw8pNp6K0I4X5UyoBO2upKDE2Xb
         AifxOTWB+utbQVyrtwcteTJXIrjPZIvf8XMjlVZXn0s8GYA8htbKQpMIKDDdw7mk8dfg
         /Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662114; x=1794266914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZMaDJSQbb9QLkhHVRE64prZxAiTnxlvuwEcwQapvub8=;
        b=w4zJpH8Stcmt84UQlNk38rqxNErAVd+Ti4t3ANJXfN9zYBAesXA+0y6ZcXIJu+Dol3
         qs/PrSfYMW+uKx/b25sHz77i3b3CXVTBD3StozRQsGeEWepSq9DIjbKWcIojl/bjNAhT
         lm+MTuPo/Sci3FyllZmYBTD7NFT4/p5go9bDPxNGfPALb3pjpoxff6oVUng1mFnuu+36
         lGYoFKAZYp2eTNOSFUWwmCaoMG/4aLh1keMT3BSY0vhbbIQ1Tb/zgxVPk5ocC1C588aQ
         UGd2lTCAVpXG6ByVFnlFj7hhVsdTmD+Hk0kC4oZ1bNbUiYqo9upVxK4ewxuXhdvUPDVF
         OMCA==
X-Forwarded-Encrypted: i=1; AKwUvBzfmaWP2z+COTwdXwPYtZXx57hAZfi1OE+ClZXjsTv8LSfJ/m6gHO4o//+ruRI/P8aSi/9HZm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K0pwZSXN9eRnn9PYLbff1kd66lW+RIB8gpIBBO14ZIOCYItdT
	CxvRR524fXOpYhcLxRBTmCeSbSnvoPIGzp02cBX1f2GYHPCfH4XsGxAmIv/8gYF1TP8=
X-Gm-Gg: AYBFou2Wm7UpIbRyuzQo9qdNvkNXjYhPdsKEVOq6HMKVxV2qA00WdlJ3TnrfLSbbuJz
	WGbWZKKG1xMST8LyTy+036WiB4rsLXIMsGUMZCxwCclydSXcwBuXIrFLlOy8A4wf9OsNa3NtIRu
	gUPXPYGHRoMzafNu4at7TN8MQ77citDlYN43E53D0v66jGmZBOGcamtyZuBnjNSFPJvRGbz0/TM
	DDzRC6NNqOEX6JljiQifLxqyK0p5Y8KV6ZfVDAoaxlahprZGNu3eEsGm3gw3vRUHfctSXWBuZ3C
	zxXxg2Pj2RV8IwVv5WXIAm1KWeAuUqc+Qc9p9VYAta/54FnS341rUBqNLF5Bu7CT33o+cVvPxPE
	jgJGhfs8VN+MrKGQp138Lgv7JS9ErW+G9Thq900B1wPMjYYdIranmL95racszP1D6jzcDKmboQF
	mKDNiyoaohLdeKNTx2QOiABcPmc2Hgj8PHzTkyGEwmWquphLfk2CbNaCaTDYaaX6KAXgLMeHs3v
	L/e9vtM2Si8UlWfkDPgiMFNrgBF6Ul4w3a7TRr+DhA7ohgqztVGFJUK2p31kJrzPU9iu9XF/rZm
	wOuh9wG5rRAmiYlQAU/zwr57/z/JdpMNOUBy+nI58xCVIYrFJNPMGakVNKsmqxU=
X-Received: by 2002:a17:90b:580d:b0:3ad:25f6:1dd0 with SMTP id 98e67ed59e1d1-3ae8970e5e9mr8946634a91.11.1793662114604;
        Mon, 02 Nov 2026 15:28:34 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6271ccsm1233086a91.7.2026.11.02.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:28:34 -0800 (PST)
Date: Mon, 2 Nov 2026 15:28:33 -0800
From: Joe Damato <joe@dama.to>
To: Frank.Li@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Li <Frank.Li@nxp.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Li Youhong <liyouhong@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Yicong Hui <yiconghui@gmail.com>, Simon Horman <horms@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	imx@lists.linux.dev, vkoul@kernel.org
Subject: Re: [PATCH] net: dma: use dmaengine_desc_set_callback()
Message-ID: <aukcoWLVvSorX5a9@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Frank.Li@oss.nxp.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Li <Frank.Li@nxp.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Li Youhong <liyouhong@kylinos.cn>, Arnd Bergmann <arnd@arndb.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Yicong Hui <yiconghui@gmail.com>, Simon Horman <horms@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	imx@lists.linux.dev, vkoul@kernel.org
References: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>

On Mon, Nov 02, 2026 at 02:19:16PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across net drivers.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c       |  3 +--
>  drivers/net/ethernet/micrel/ks8842.c              |  6 ++----
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  6 ++----
>  drivers/net/wwan/qcom_bam_dmux.c                  | 10 ++++------
>  4 files changed, 9 insertions(+), 16 deletions(-)

[...]

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d64371..1479f8362e04e 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -195,9 +195,8 @@ static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
>  		return false;
>  	}
>  
> -	desc->callback = bam_dmux_tx_callback;
> -	desc->callback_param = skb_dma;
> -	desc->cookie = dmaengine_submit(desc);
> +	dmaengine_desc_set_callback(desc, bam_dmux_tx_callback, NULL, skb_dma);
> +	dmaengine_submit(desc);
>  	return true;
>  }
>  
> @@ -477,9 +476,8 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
>  		return false;
>  	}
>  
> -	desc->callback = bam_dmux_rx_callback;
> -	desc->callback_param = skb_dma;
> -	desc->cookie = dmaengine_submit(desc);
> +	dmaengine_desc_set_callback(desc, bam_dmux_rx_callback, NULL, skb_dma);
> +	dmaengine_submit(desc);

I noticed in the above that the return value of dmaengine_submit is discarded
instead of stored.

Is that intentional? I suppose it might be because AFAICT cookie is never
used and the commit message says "no functional change intended".

Reviewed-by: Joe Damato <joe@dama.to>
