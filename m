Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5567379C48
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827509; cv=none; b=kPJgVKYfexvs45p6BcdSp6EFR7xNnmeyXlwgJmpEVet5Yzd/+MEPDRKQXLS/tLDlU7fL5p8yP67zc2SqxeM1SC0Pxoyg1k7GabfdDfGhgfMRN2ZPDUELpSUh6UwQshpER+ny9mqQgx4C97lnwNneCxjKiNU8njWAx3GIqP79EPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827509; c=relaxed/simple;
	bh=xm0bZ7vy4zuVichIPhwukKkHJMnkFOzfPOJgWiejqNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgU661uPb3Rysk2S0C1c8ZrlA2oOF/Rg0Q7gxElm0haVbCt9AqOjARNvaWGFgPDBG5U1P4naaR5C1Vg5jLXkeUSEmo9/ukw2TxrSslu7wQHF3pYXzA2+zext3t2EfLnm1Q6FvkX5w/HJgMbN/eekNZ2t0oaQKUCpCDgysvQdT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGB6oHZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGB6oHZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFF01F000E9;
	Thu, 23 Jul 2026 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784827508;
	bh=fmKeL/JAZvgujPECuklaQbMxQ7dQJHRCbkxbfaWDvdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TGB6oHZDqwytaHvcLF5he7DmU2EaoTtvJcoqI2gnETDJC3aU8u9JhLNVvqcO+/sCS
	 2o3+MqtbKlfNNQFia6Cba86GAhki3rYNLZhLkaI54orhzcvwUqLrL8TS26MWmvFIfO
	 ajO3tMT/LowBgJ9GQ5nm1p9K81+8nj/JrWZqI5WcNElLM46AErXm7QYcEkeHJcfX3D
	 NIQGmEsYEFcY2uW7g7n3RrsRhvNxYSBhLHh1uYXA8Twmz3U94AtQVnuM97oSPzGzoM
	 IVU7mEdRsV4TugulLKPp2KL8atdfWboFTrfZXP1vvS5EO0/jk0Cn93vqrMwcneEdDw
	 wW1ue231exU9w==
Date: Thu, 23 Jul 2026 10:25:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: justinlai0215@realtek.com
Cc: Yun Lu <luyun_611@163.com>, larry.chiu@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] rtase: fix double free of multi-frag skb on DMA map
 failure
Message-ID: <20260723102507.35b4246b@kernel.org>
In-Reply-To: <20260721023836.6691-1-luyun_611@163.com>
References: <20260721023836.6691-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 10:38:36 +0800 Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> In rtase_start_xmit(), when the head buffer DMA mapping fails after
> rtase_xmit_frags() has mapped all fragments, the error path clears
> the fragment descriptors with rtase_tx_clear_range(), which frees
> the skb through the last-frag slot and accounts tx_dropped. Control
> then falls through to the common error label, which frees the same
> skb a second time and counts it again.
> 
> Return right after clearing the fragments when the skb owns frags;
> the no-frag case still drops through and frees the head skb once.
> 
> Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Justin, please review.

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 255667775f0e..67f7fdada119 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1426,6 +1426,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
>  err_dma_1:
>  	ring->skbuff[entry] = NULL;
>  	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> +	if (frags)
> +		/* the frags were cleared above, along with the skb */
> +		return NETDEV_TX_OK;
>  
>  err_dma_0:
>  	tp->stats.tx_dropped++;

