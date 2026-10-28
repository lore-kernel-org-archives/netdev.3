Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154106;
	b=PsddnHWs+M5+u27cfSDyO7h58ucAZMvL0BKPj7mpnolmRV6Q9pUtqNNqvCaQm75aE8Xc
	 ZrZzoOme6ruRZ6LYuke5sIc3blUo9fzO8PSseEL/XmBHyOyOQplV8Q6mGH1BcyePtFlif
	 wj2v/zmMhT4MP5WrhheQd2UFkTPTMRgppBgi5Xt/jjQTdZc82ql9OtKgP+NY0imf1y5lz
	 9uy3tJ0xjQhRjsu7PvuRzMlq1KjmN/sFbJ8n47NaKGUPBinqGKH2BXZrQLWLAN11wiRgn
	 dmf2WFEhh2lCHeOxbqpe9h/t59E+kLXJYATnCW9Fw5duDi0LDLu8PvGyb8b8YsUXNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154106;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=yvbnuswRAXkLlEZEOKJhfn9CgxvlmHuarpSPqS5Km4I=;
	b=wAjVGFc1ddkdkqS7FsGPh5IhwxDMIoZRBc0Bxku1TVIW739J3AyKiFu9hOgHTzfrKUGT
	 zfQzjAbN4PUYa+50H0O5Dn/wKehZ8bzC9J/uyKNjBzUJhGE4AtGC2NrXLxI19YAChqOcI
	 PjCgjv4TCBmBii39Ot3EzMU427SuHAOz5Qs6kvBY14Tf77zQC2xRn2EXzGsQNKTGup3co
	 VwUWns3j1+dhL0dXQGoArq9oAZjIxW2tis8IX1RCDgWk3FmbR8zv0wm0W3ek2hxR9mPfw
	 2s2cJo2r68jg6WwnJovnIiQcUlAQLOw472fdJbuLLxprH62g+a9PZTOT9bsB3EhGHCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZjYVER9W;
	arc=none smtp.remote-ip=95.215.58.193
Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A8606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZjYVER9W
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T274q3t0zByFtrwkspOzoZhgms0KPFQlU3UuTQZ4/T0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793154103; v=1; x=1793758903;
 b=ZjYVER9WwVXTxAu/l2BZSI0F8uE2tdUvxUPyrE/DAQNe3gq4dQcf53zxs3JIsSn7eiF3xjam
 w5UHFd0Xg75T/XIaRHiQ8GGbucBXDu9/MLraPB9t+iUq/zDo+ojR4FnnpjD8K4I9+QZG+O3OsdJ
 o/iTtN8RHz0/tPQ0gI5G95Ac=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 935717971550bebf;
	Wed, 28 Oct 2026 02:21:43 +0000
X-Mizu-Trace-ID: 935717971550bebf
X-Migadu-Flow: FLOW_OUT
Date: Wed, 28 Oct 2026 10:22:24 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: bgmac: fix oversized RX frame check
Message-ID: <20261028022128.GA201431@pc>
References: <20261028011035.49201-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028011035.49201-1-rosenp@gmail.com>

On Tue, Oct 27, 2026 at 06:10:35PM -0700, Rosen Penev wrote:
> While reviewing commit 77dac783f11
> ("net: bgmac: rate limit RX error messages") , Florian spotted that the RX
> length sanity check compares the length reported in the RX header against
> BGMAC_RX_ALLOC_SIZE. That is the size of the whole fragment, including the
> space reserved for struct skb_shared_info. The data area handed to the
> hardware is only BGMAC_RX_BUF_SIZE bytes, and the frame starts
> BGMAC_RX_FRAME_OFFSET bytes into it, so a valid frame is at most
> BGMAC_RX_MAX_FRAME_SIZE bytes long.
> 
> A corrupted length between those two limits passes the check, and the
> following skb_put() runs past the skb tailroom and calls
> skb_over_panic() instead of dropping the frame.
> 
> Compare against BGMAC_RX_MAX_FRAME_SIZE instead.
> 
> Only compile tested. Not tested on hardware.
> 
> Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: replace Suggested-by with description.
>  drivers/net/ethernet/broadcom/bgmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index b3a92ae95de3..6873c7bb7a14 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
>  				break;
>  			}
>  
> -			if (len > BGMAC_RX_ALLOC_SIZE) {
> +			if (len > BGMAC_RX_MAX_FRAME_SIZE) {
>  				if (net_ratelimit())
>  					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
>  						   ring->start);
> -- 
> 2.56.0
> 

Hi Rosen

FWIW, it’s helpful for reviewers to have a link to the
prior patch with the new revision for easy reference. :)

Thanks
Chenguang
